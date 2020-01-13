#!/bin/bash -x

echo "Logfile in current directory: create_users_projects.log"

#exec &> create_users_projects.log

openstack project create trilio
openstack project create trilioadmin

openstack project list

openstack user create backupuser --password password

openstack user create backupadmin --password password

openstack user list

openstack role add --user backupuser --project trilio _member_
openstack role add --user backupadmin --project trilioadmin admin
openstack role add --user backupadmin --project trilioadmin _member_
openstack role add --user backupadmin --project trilio _member_

openstack --insecure quota set --instances 1000 --ram 100000 --volumes 1000 --snapshots 1000 --ports 1000 --gigabytes 1000 --cores 1000 trilio

openstack --insecure flavor create --id 100 --ram 512 --disk 1 --vcpus 1 trilio.tiny
openstack --insecure flavor create --id 200 --ram 2048 --disk 20 --vcpus 1 trilio.small
openstack --insecure flavor create --id 300 --ram 4096 --disk 40 --vcpus 2 trilio.medium
openstack --insecure flavor create --id 400 --ram 2048 --disk 50 --vcpus 1 trilio.fm
