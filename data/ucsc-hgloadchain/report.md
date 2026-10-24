# ucsc-hgloadchain CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ucsc-hgloadchain_hgLoadChain | PASS | Tested with -test (no database needed) on a real hg19 chrM to susScr3 chain: chain.tab and link.tab match an independent parse (97 link blocks, score, bin, qPrefix, normScore); database loading not tested (CWL fixed: sqlTable is a File, hg.conf added) |

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

