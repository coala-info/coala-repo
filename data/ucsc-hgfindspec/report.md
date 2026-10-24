# ucsc-hgfindspec CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ucsc-hgfindspec_hgFindSpec | Not completed | Needs a writable UCSC MySQL database; the command line is accepted, the kent trackDb.ra is read and the program reaches the database connection (CWL fixed: organism is a string and hgRoot is a directory; hg.conf and network access added) |

## ucsc-hgfindspec_hgFindSpec

### Tool Description
Create hgFindSpec table from trackDb.ra files.

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-hgfindspec:482--h0b57e2e_0
- **Homepage**: http://hgdownload.cse.ucsc.edu/admin/exe/
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-hgfindspec/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-hgfindspec/overview
- **Total Downloads**: 17.9K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
hgFindSpec - Create hgFindSpec table from trackDb.ra files.

usage:
   hgFindSpec [options] orgDir database hgFindSpec hgFindSpec.sql hgRoot

Options:
  -strict		Add spec to hgFindSpec only if its table(s) exist.
  -raName=trackDb.ra - Specify a file name to use other than trackDb.ra
   for the ra files.
  -release=alpha|beta|public - Include trackDb entries with this release tag only.
```

