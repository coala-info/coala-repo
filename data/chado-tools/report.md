# chado-tools CWL Generation Report

## chado-tools_chado

### Tool Description
Tools to access CHADO databases

### Metadata
- **Docker Image**: quay.io/biocontainers/chado-tools:0.2.15--py_0
- **Homepage**: https://github.com/sanger-pathogens/chado-tools/
- **Package**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Total Downloads**: 26.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sanger-pathogens/chado-tools
- **Stars**: N/A
### Original Help Text
```text
usage: chado [-h] [-v]
             {connect,query,extract,insert,delete,import,export,execute,admin}
             ...

Tools to access CHADO databases

positional arguments:
  {connect,query,extract,insert,delete,import,export,execute,admin}
    connect             connect to a CHADO database for an interactive session
    query               query a CHADO database and export the result to a text
                        file
    extract             run a pre-compiled query against the CHADO database
    insert              insert a new entity of a specified type into the CHADO
                        database
    delete              delete an entity of a specified type from the CHADO
                        database
    import              import data from file into the CHADO database
    export              export data from the CHADO database to file
    execute             execute a function defined in a CHADO database
    admin               perform administrative tasks, such as creating or
                        dumping a CHADO database

optional arguments:
  -h, --help            show this help message and exit
  -v, --version         show the version of the software and exit

For detailed usage information type 'chado <command> -h'
```

