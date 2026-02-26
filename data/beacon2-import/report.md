# beacon2-import CWL Generation Report

## beacon2-import

### Tool Description
Input arguments

### Metadata
- **Docker Image**: quay.io/biocontainers/beacon2-import:2.2.4--pyhdfd78af_0
- **Homepage**: https://pypi.org/project/beacon2-import/
- **Package**: https://anaconda.org/channels/bioconda/packages/beacon2-import/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/beacon2-import/overview
- **Total Downloads**: 7.4K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Missing value -> database. Use -h or --help for usage details.
usage: beacon2-import [-h] [-H DATABASE_HOST] [-P DATABASE_PORT] [-a]
                      [-A DATABASE_AUTH_CONFIG] [-g] [-u GALAXY_URL]
                      [-k GALAXY_KEY] [-d DATABASE] [-c COLLECTION]
                      [-i INPUT_JSON_FILE] [-s] [-o] [-D] [-V] [-ca] [-cc]
                      [-r REMOVED_COLL_NAME]

Input arguments

options:
  -h, --help            show this help message and exit

Connection to MongoDB:
  -H DATABASE_HOST, --db-host DATABASE_HOST
                        Hostname/IP of the beacon database
  -P DATABASE_PORT, --db-port DATABASE_PORT
                        Port of the beacon database

Addvanced Connection to MongoDB:
  -a, --advance-connection
                        Connect to beacon database with authentication
  -A DATABASE_AUTH_CONFIG, --db-auth-config DATABASE_AUTH_CONFIG
                        JSON file containing credentials/config e.g.{'db_auth_
                        source':'admin','db_user':'root','db_password':'exampl
                        e'}

Connection to Galaxy:
  -g, --galaxy          Import data from Galaxy
  -u GALAXY_URL, --galaxy-url GALAXY_URL
                        Galaxy hostname or IP
  -k GALAXY_KEY, --galaxy-key GALAXY_KEY
                        API key of a galaxy user WITH ADMIN PRIVILEGES

Database Configuration:
  -d DATABASE, --database  DATABASE
                        The targeted beacon database
  -c COLLECTION, --collection COLLECTION
                        The targeted beacon collection from the desired
                        database

Import Json Arguments:
  -i INPUT_JSON_FILE, --input_json_file INPUT_JSON_FILE
                        Input the local path to the JSON file or it's name on
                        your Galaxy Hitory to import to beacon

store origin:
  -s, --store-origins   Make a local file containing variantIDs with the
                        dataset they stem from
  -o , --origins-file   Full file path of where variant origins should be
                        stored (if enabled)

control output:
  -D, --debug
  -V, --verbose         Be verbose

Clear beacon database:
  -ca, --clearAll       Delete all data before the new import
  -cc, --clearColl      Delete specific collection before the new import
  -r REMOVED_COLL_NAME, --removeCollection REMOVED_COLL_NAME
                        Define the collection name for deletion
```

