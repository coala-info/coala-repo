# ucsc-genepredcheck CWL Generation Report

## ucsc-genepredcheck_genePredCheck

### Tool Description
validate genePred files or tables

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-genepredcheck:482--h0b57e2e_0
- **Homepage**: https://hgdownload.cse.ucsc.edu/admin/exe
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-genepredcheck/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-genepredcheck/overview
- **Total Downloads**: 58.0K
- **Last updated**: 2025-06-26
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
genePredCheck - validate genePred files or tables
usage:
   genePredCheck [options] fileTbl ..

If fileTbl is an existing file, then it is checked.  Otherwise, if -db
is provided, then a table by this name in db is checked.

options:
   -db=db - If specified, then this database is used to
          get chromosome sizes, and perhaps the table to check.
   -chromSizes=file.chrom.sizes - use chrom sizes from tab separated
          file (name,size) instead of from chromInfo table in specified db.
```

