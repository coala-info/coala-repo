# ucsc-hgloadchain CWL Generation Report

## ucsc-hgloadchain_hgLoadChain

### Tool Description
Load a generic Chain file into database

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-hgloadchain:482--h0b57e2e_0
- **Homepage**: https://hgdownload.cse.ucsc.edu/admin/exe
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-hgloadchain/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-hgloadchain/overview
- **Total Downloads**: 22.3K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
hgLoadChain - Load a generic Chain file into database
usage:
   hgLoadChain database chrN_track chrN.chain
options:
   -tIndex  Include tName in indexes (for non-split chain tables)
   -noBin   suppress bin field, default: bin field is added
   -noSort  Don't sort by target (memory-intensive) -- input *must* be
            sorted by target already if this option is used.
   -oldTable add to existing table, default: create new table
   -sqlTable=table.sql Create table from .sql file
   -normScore add normalized score column to table, default: not added
   -qPrefix=xxx   prepend "xxx" to query name
   -test    suppress loading to database
```

