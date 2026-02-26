# ucsc-hgloadout CWL Generation Report

## ucsc-hgloadout_hgLoadOut

### Tool Description
load RepeatMasker .out files into database

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-hgloadout:482--h0b57e2e_0
- **Homepage**: http://hgdownload.cse.ucsc.edu/admin/exe/
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-hgloadout/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-hgloadout/overview
- **Total Downloads**: 18.3K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
hgLoadOut - load RepeatMasker .out files into database
usage:
   hgLoadOut database file(s).out
For multiple files chrN.out this will create the single table 'rmsk'
in the database, use the -split argument to obtain separate chrN_rmsk tables.
options:
   -tabFile=text.tab - don't actually load database, just create tab file
   -split - load chrN_rmsk separate tables even if a single file is given
   -table=name - use a different suffix other than the default (rmsk)
note: the input file.out can also be a compressed file.out.gz file,
      or a URL to a file.out or file.out.gz
```

