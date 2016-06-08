#!/usr/bin/python
import jenkins,os

jenkins_url='http://localhost:8080'

def create_job(jenkins_url,job_name,job_config):
  server = jenkins.Jenkins(jenkins_url)
  server.create_job(job_name, job_config)

def create_view(jenkins_url,view_name,view_config):
  server = jenkins.Jenkins(jenkins_url)
  server.create_view(view_name,view_config)

def check_job(job_name):
  server = jenkins.Jenkins(jenkins_url)
  jobs = server.get_jobs()
  for job in jobs:
    if job['fullname'] == job_name:
      return 1
  return 0

def check_view(view_name):
  server = jenkins.Jenkins(jenkins_url)
  views = server.get_views()
  for view in views:
    if view['name'] == view_name:
       return 1
  return 0

for job in os.listdir("./jobs"):
  if check_job(job) != 0:
    print "Job {} already exists.".format(job)
    continue
  with open("./jobs/{}/config.xml".format(job)) as job_config:
    create_job(jenkins_url,job,job_config.read())


for view in os.listdir("./views"):
  if check_view(view) != 0:
    print "View {} already exists.".format(job)
    continue
  with open("./views/{}/config.xml".format(view)) as view_config:
    create_view(jenkins_url,view,view_config.read())
