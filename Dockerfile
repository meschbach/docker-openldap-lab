#
# OpenLDAP Container for expirimenting 
# Please see http://openldap.org/ for copyright information
#
# MetaData 
#
FROM meschbach/openldap-dynconfig
MAINTAINER Mark Eschbach <meschbach@gmail.com>

#
#
#
USER ldap
RUN mkdir -p /storage/db1 /storage/db2 /storage/db3 /storage/db4 /storage/db5
