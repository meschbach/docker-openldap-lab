#!/bin/sh +xe

#
# Configuration knobs
#
image=meschbach/openldap-lab
iface="172.17.42.1"

#
# Spawn containers
#
container1=`docker run -d -p 1025:1025 -h ldap1.test $image`
container2=`docker run -d -p 1026:1025 -h ldap2.test $image`
sleep 1		# Give OpenLDAP/DOcker time to bring the containers on-line

#
# Setup configuration
#
ldapadd -H ldap://$iface:1025 -D cn=root,cn=config -w secret -f 002_multimaster_ldap1.ldif
ldapadd -H ldap://$iface:1026 -D cn=root,cn=config -w secret -f 002_multimaster_ldap2.ldif

#
# Install the root DN
#
ldapadd -H ldap://$iface:1025 -D cn=root,dc=example,dc=test -w example -f 002_multimaster_rootdn.ldif

#
# Install a subentry in the other producer (rootdn should be replicated from the first master) 
#
sleep 5		# TODO determine if there is a way to reduce replication delay between containers.
ldapadd -H ldap://$iface:1026 -D cn=root,dc=example,dc=test -w example -f 002_multimaster_subentry.ldif

#
# The expected result here is to see two entries, the root of the database and the subentry ou=test.
#
sleep 5		# TODO determine if there is a way to reduce replication delay between containers.
ldapsearch -H ldap://$iface:1025 -D cn=root,dc=example,dc=test -w example  -b dc=example,dc=test "(objectClass=*)"

#
# Clean up containers
#
docker stop $container1 $container2
docker rm $container1 $container2
