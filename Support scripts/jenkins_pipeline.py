#!/usr/bin/env python

import sys
import requests
from time import sleep


auth=("admin","<password>")
error_message = "calm script failed"

old_status = "PENDING"

status_msg_map = {
    "PENDING": "Preparing flow {}.",
    "RUNNING": "Running flow {}.",
    "APPROVAL": "Flow {} is waiting for human approval.",
    "SUCCESS": "Flow {} finished successfully.",
    "FAILURE": "Flow {} failed.",
}

#HACK
app_url_map = {
    "staging-demoapp":  "http://<url>/api/1/default/applications/<deploymentid>/runlogs?flow_id=<flowid>",
    "prod-demoapp": "http://<url>/api/1/default/applications/<deploymentid>/runlogs?flow_id=<flowid>",
}


def check_flow_status(app_name, flow_name, flow_run_id):
    global old_status

    url = app_url_map[app_name]
    r = requests.get(url, auth=auth)

    if not r.ok:
        print >> sys.stderr, error_message
        sys.exit(-1)

    runs = r.json()['data']['rows']
    flow_run = None
    for run in runs:
        if run['uid'] == flow_run_id:
            flow_run = run
            #print >> sys.stdout, flow_run

    status = flow_run['status']
    if status != old_status:
        print >> sys.stdout, status_msg_map[status].format(flow_name)
        old_status = status

    return status


def start_flow_run(app_name, flow_name):

    url = "http://<url>/public/api/1/default/applications/flows/run"

    json = {
        "application_name": app_name,
        "flow_name": flow_name,
    }

    r = requests.post(url, auth=auth, json=json)

    flow_run_id = r.json()['data']['row']['flow_run_uid']

    if not r.ok:
        print >> sys.stderr, error_message
        sys.exit(-1)

    return flow_run_id


def main():
    global old_status

    app_name = sys.argv[2]
    flow_name = sys.argv[4]

    flow_run_id = start_flow_run(app_name, flow_name)

    while True:

        current_status = check_flow_status(app_name, flow_name, flow_run_id)
        if current_status == "SUCCESS":
            sys.exit(0)
        elif current_status == "FAILURE":
            sys.exit(-1)

        sleep(3)

if __name__ == "__main__":
    main()

