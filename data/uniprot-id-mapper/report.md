# uniprot-id-mapper CWL Generation Report

## uniprot-id-mapper_protmap

### Tool Description
Retrieve data from UniProt using UniProt's RESTful API. For a list of all
available fields, see: https://www.uniprot.org/help/return_fields.
Alternatively, use the --print-fields argument to print the available fields
and exit the program.

### Metadata
- **Docker Image**: quay.io/biocontainers/uniprot-id-mapper:1.1.4--pyh7e72e81_0
- **Homepage**: https://github.com/David-Araripe/UniProtMapper
- **Package**: https://anaconda.org/channels/bioconda/packages/uniprot-id-mapper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/uniprot-id-mapper/overview
- **Total Downloads**: 292
- **Last updated**: 2025-06-02
- **GitHub**: https://github.com/David-Araripe/UniProtMapper
- **Stars**: N/A
### Original Help Text
```text
usage: UniProtMapper [-h] -i [IDS ...] [-r [RETURN_FIELDS ...]]
                     [--default-fields] [-o OUTPUT] [-from FROM_DB]
                     [-to TO_DB] [-over] [-pf]

Retrieve data from UniProt using UniProt's RESTful API. For a list of all
available fields, see: https://www.uniprot.org/help/return_fields.
Alternatively, use the --print-fields argument to print the available fields
and exit the program.

options:
  -h, --help            show this help message and exit
  -i, --ids [IDS ...]   List of UniProt IDs to retrieve information from.
                        Values must be separated by spaces.
  -r, --return-fields [RETURN_FIELDS ...]
                        If not defined, will pass `None`, returning all
                        available fields. Else, values should be fields to be
                        returned separated by spaces. See --print-fields for
                        available options.
  --default-fields, -def
                        This option will override the --return-fields option.
                        Returns only the default fields stored in:
                        /usr/local/lib/python3.13/site-
                        packages/UniProtMapper/resources/cli_return_fields.txt
  -o, --output OUTPUT   Path to the output file to write the returned fields.
                        If not provided, will write to stdout.
  -from, --from-db FROM_DB
                        The database from which the IDs are. For the available
                        cross references, see: /usr/local/lib/python3.13/site-
                        packages/UniProtMapper/resources/uniprot_mapping_dbs.j
                        son
  -to, --to-db TO_DB    The database to which the IDs will be mapped. For the
                        available cross references, see:
                        /usr/local/lib/python3.13/site-packages/UniProtMapper/
                        resources/uniprot_mapping_dbs.json
  -over, --overwrite    If desired to overwrite an existing file when using
                        -o/--output
  -pf, --print-fields   Prints the available return fields and exits the
                        program.
```

