# taxadb CWL Generation Report

## taxadb_download

### Tool Description
download the files required to create the database

### Metadata
- **Docker Image**: quay.io/biocontainers/taxadb:0.12.1--pyh5e36f6f_0
- **Homepage**: https://github.com/HadrienG/taxadb
- **Package**: https://anaconda.org/channels/bioconda/packages/taxadb/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/taxadb/overview
- **Total Downloads**: 9.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/HadrienG/taxadb
- **Stars**: N/A
### Original Help Text
```text
usage: taxadb download [-h] [--quiet | --verbose] --type [<str> ...] [--force]
                       --outdir <dir>

download the files required to create the database

options:
  -h, --help            show this help message and exit
  --quiet               Disable info logging. (default: False).
  --verbose             Enable debug logging. (default: False).
  --type [<str> ...], -t [<str> ...]
                        divisions to download. Can be one or more of "taxa",
                        "full", "nucl", "prot", "gb", or "wgs". Space-
                        separated.
  --force, -f           Force download if the output directory exists
  --outdir <dir>, -o <dir>
                        Output Directory
```


## taxadb_create

### Tool Description
build the database

### Metadata
- **Docker Image**: quay.io/biocontainers/taxadb:0.12.1--pyh5e36f6f_0
- **Homepage**: https://github.com/HadrienG/taxadb
- **Package**: https://anaconda.org/channels/bioconda/packages/taxadb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: taxadb create [-h] [--quiet | --verbose] [--fast] [--chunk <#chunk>]
                     --input <dir> [--dbname taxadb]
                     [--dbtype [sqlite|mysql|postgres]]
                     [--division [taxa|full|nucl|prot|gb|wgs]]
                     [--hostname HOSTNAME] [--password PASSWORD] [--port PORT]
                     [--username USERNAME]

build the database

options:
  -h, --help            show this help message and exit
  --quiet               Disable info logging. (default: False).
  --verbose             Enable debug logging. (default: False).
  --fast                Disables checks for faster db creation. Use with
                        caution!
  --chunk <#chunk>, -c <#chunk>
                        Number of sequences to insert in bulk (default: 500)
  --input <dir>, -i <dir>
                        Input directory (where you first downloaded the files)
  --dbname taxadb, -n taxadb
                        name of the database (default: taxadb))
  --dbtype [sqlite|mysql|postgres], -t [sqlite|mysql|postgres]
                        type of the database (default: sqlite))
  --division [taxa|full|nucl|prot|gb|wgs], -d [taxa|full|nucl|prot|gb|wgs]
                        division to build (default: full))
  --hostname HOSTNAME, -H HOSTNAME
                        Database connection host (Optional, for MySQLdatabase
                        and PostgreSQLdatabase) (default: localhost)
  --password PASSWORD, -p PASSWORD
                        Password to use (required for MySQLdatabase and
                        PostgreSQLdatabase)
  --port PORT, -P PORT  Database connection port (default: 5432 (postgres),
                        3306 (MySQL))
  --username USERNAME, -u USERNAME
                        Username to login as (required for MySQLdatabase and
                        PostgreSQLdatabase)
```


## taxadb_query

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/taxadb:0.12.1--pyh5e36f6f_0
- **Homepage**: https://github.com/HadrienG/taxadb
- **Package**: https://anaconda.org/channels/bioconda/packages/taxadb/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: taxadb <command> [options]

download and create the database used by the taxadb library

options:
  -h, --help     show this help message and exit
  -v, --version  print software version and exit

available commands:
  
    download     download the files required to create the database
    create       build the database
    query        query the database
```


## Metadata
- **Skill**: generated
