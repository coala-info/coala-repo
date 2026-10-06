# askocli CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| askocli_integrate | Not completed | needs a running AskOmics server and API key; on a real GFF3 the command line parsed and the tool stopped at login with connection refused. |

## askocli_integrate

### Tool Description
Integrate data to a distant AskOmics

### Metadata
- **Docker Image**: quay.io/biocontainers/askocli:0.5--py_0
- **Homepage**: https://github.com/askomics/askocli
- **Package**: https://anaconda.org/channels/bioconda/packages/askocli/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/askocli/overview
- **Total Downloads**: 42.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/askomics/askocli
- **Stars**: 0
### Original Help Text
```text
usage: askocli integrate [-h] -k APIKEY -a ASKOMICS [--file-type FILE_TYPE]
                         [--public] [--uri URI]
                         [--headers [HEADERS [HEADERS ...]]]
                         [--key-columns [KEY_COLUMNS [KEY_COLUMNS ...]]]
                         [--disabled-columns [DISABLED_COLUMNS [DISABLED_COLUMNS ...]]]
                         [-c [COLUMNS [COLUMNS ...]]]
                         [-e [ENTITIES [ENTITIES ...]]] [-t TAXON]
                         [-n ENTITY_NAME]
                         [file]

Integrate data to a distant AskOmics

positional arguments:
  file                  file to integrate

optional arguments:
  -h, --help            show this help message and exit
  -k APIKEY, --apikey APIKEY
                        An API key associate with your account
  -a ASKOMICS, --askomics ASKOMICS
                        AskOmics URL
  --file-type FILE_TYPE
                        The file type
  --public
  --uri URI             Custom URI
  --headers [HEADERS [HEADERS ...]]
                        List of custom headers (csv)
  --key-columns [KEY_COLUMNS [KEY_COLUMNS ...]]
                        List of the key columns index (csv)
  --disabled-columns [DISABLED_COLUMNS [DISABLED_COLUMNS ...]]
                        List of columns index to disable (csv)
  -c [COLUMNS [COLUMNS ...]], --columns [COLUMNS [COLUMNS ...]]
                        List of forced columns types (csv)
  -e [ENTITIES [ENTITIES ...]], --entities [ENTITIES [ENTITIES ...]]
                        List of entities to integrate (gff)
  -t TAXON, --taxon TAXON
                        Taxon (gff and bed)
  -n ENTITY_NAME, --entity-name ENTITY_NAME
                        Entity name (bed)
```

## Metadata
- **Skill**: generated
