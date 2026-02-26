# ucsc-hgloadoutjoined CWL Generation Report

## ucsc-hgloadoutjoined_hgLoadOutJoined

### Tool Description
load new style (2014) RepeatMasker .out files into database

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-hgloadoutjoined:482--h0b57e2e_0
- **Homepage**: http://hgdownload.cse.ucsc.edu/admin/exe/
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-hgloadoutjoined/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-hgloadoutjoined/overview
- **Total Downloads**: 18.1K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
hgLoadOutJoined - load new style (2014) RepeatMasker .out files into database
usage:
   hgLoadOutJoined database file(s).out
For multiple files chrN.out this will create the single table 'rmskOutBaseline'
in the database.
options:
   -tabFile=text.tab - don't actually load database, just create tab file
   -table=name - use a different suffix other than the default (rmskOutBaseline)
```

