# ncbitax2lin CWL Generation Report

## ncbitax2lin

### Tool Description
Converts NCBI taxomony dump into lineages.

### Metadata
- **Docker Image**: quay.io/biocontainers/ncbitax2lin:3.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/zyxue/ncbitax2lin
- **Package**: https://anaconda.org/channels/bioconda/packages/ncbitax2lin/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ncbitax2lin/overview
- **Total Downloads**: 2.0K
- **Last updated**: 2025-09-23
- **GitHub**: https://github.com/zyxue/ncbitax2lin
- **Stars**: N/A
### Original Help Text
```text
INFO: Showing help with the command 'ncbitax2lin -- --help'.

NAME
    ncbitax2lin - Converts NCBI taxomony dump into lineages.

SYNOPSIS
    ncbitax2lin NODES_FILE NAMES_FILE <flags>

DESCRIPTION
    NCBI taxonomy dump can be downloaded from
    ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/taxdump.tar.gz

POSITIONAL ARGUMENTS
    NODES_FILE
        Type: str
        path/to/taxdump/nodes.dmp from NCBI taxonomy
    NAMES_FILE
        Type: str
        path/to/taxdump/names.dmp from NCBI taxonomy

FLAGS
    -o, --output=OUTPUT
        Type: Optional[Optional]
        Default: None

NOTES
    You can also use flags syntax for POSITIONAL ARGUMENTS
```

