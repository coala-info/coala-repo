# ucsc-hgloadoutjoined CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ucsc-hgloadoutjoined_hgLoadOutJoined | PASS | Tested with -tabFile (no database needed) on the kent test RepeatMasker .out.gz (an older-style file; 198 rows, score, coordinates and divergence match an independent parse); database loading not tested (CWL fixed: tabFile is an output name, hg.conf added) |

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

