#This script will add cpu and memory to the vm of a esxi host

$vmip="IP of the target vm"
$vshpereip="Esxi host IP Address"
$user="user name vsphere client"
$password="password of vsphere user account"
$memory="4096"
$cpu=""

## Adding snapin
Add-PSSnapin VMware.VimAutomation.Core

## Connection to Vshpere Server
Connect-VIServer -Server $vshpereip -User $user -Password $password

## Getting the hostname for the given ip address
$vmname=Get-VM | Select Name, @{N="IP_Address";E={@($_.guest.IPAddress[0])}} | Where-Object {$_.IP_Address -eq $vmip} | Select-Object -ExpandProperty Name

if ($memory -and $cpu)
  {
  GET-VM $vmname | SET-VM -MemoryMB $memory -confirm:$false
  GET-VM $vmname | SET-VM -NumCPU $cpu -confirm:$false
  write-host "Changed memory of $vmname to $memory,cpu cores to $cpu"
  }
elseif ($memory)
  {
  GET-VM $vmname | SET-VM -MemoryMB $memory -confirm:$false
  Write-host "Changed memory of $vmname to $memory"
  }
elseif ($cpu)
  {
  GET-VM $vmname | SET-VM -NumCPU $cpu -confirm:$false
  Write-host "Changed cpu cores of $vmname to $cpu"
  }
else
 {
 write-host "Give the input"
 }
