#!/bin/bash -x

## Sourcing 'backupadmin' credentials

export OS_USERNAME=backupadmin
export OS_PROJECT_NAME=trilio
export OS_PASSWORD=password

curl -O http://download.cirros-cloud.net/0.4.0/cirros-0.4.0-x86_64-disk.img

openstack --insecure network create trilio-internal-net

openstack --insecure subnet create --subnet-range 10.0.0.0/24 --network trilio-internal-net \
    --gateway 10.0.0.1 --dns-nameserver 8.8.8.8 trilio-internal-subnet

openstack --insecure image create --id b2e4996c-3300-419f-a1f0-a4a3ad7ef858 --disk-format qcow2 --container-format bare --public \
    --property os_type=linux --file cirros-0.4.0-x86_64-disk.img trilio.cirros

## TODO: create vm. Network id is hardcoded. All other options are correct.
#openstack --insecure server create --image b2e4996c-3300-419f-a1f0-a4a3ad7ef858 --flavor 100 --nic net-id=87bdb053-2eb1-4026-bb2c-f6ec8653f5ef test-cirros
