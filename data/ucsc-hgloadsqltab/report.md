# ucsc-hgloadsqltab CWL Generation Report

## ucsc-hgloadsqltab_hgLoadSqlTab

### Tool Description
Load table into database from SQL and text files.

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-hgloadsqltab:482--h0b57e2e_0
- **Homepage**: http://hgdownload.cse.ucsc.edu/admin/exe/
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-hgloadsqltab/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-hgloadsqltab/overview
- **Total Downloads**: 11.9K
- **Last updated**: 2025-06-28
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
hgLoadSqlTab - Load table into database from SQL and text files.
usage:
   hgLoadSqlTab database table file.sql file(s).tab
file.sql contains a SQL create statement for table
file.tab contains tab-separated text (rows of table)
The actual table name will come from the command line, not the sql file.
options:
  -warn - warn instead of abort on mysql errors or warnings
  -notOnServer - file is *not* in a directory that the mysql server can see
  -oldTable|-append - add to existing table

To load bed 3+ sorted tab files as hgLoadBed would do automatically
sort the input file:
  sort -k1,1 -k2,2n file(s).tab | hgLoadSqlTab database table file.sql stdin
```

