# OpenLDAP Lab
A container for expirimenting with OpenLDAP based on the *meschbach/openldap-dynconfig* container.  This provides 5 mount points at */storage/db{1..5}* which allows for the creation of databases.

## Examples
There are several examples of using the online configuration (OLC) backend under the *examples* directory of this repository.

### Multimaster
Run the script *examples/002.sh* to execute the multimaster example.  This will spawn up two containers and bind them to the docker default bridge's default address.  TODO: Update script to inspect docker for bridge address.
