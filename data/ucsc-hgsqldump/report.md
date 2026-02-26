# ucsc-hgsqldump CWL Generation Report

## ucsc-hgsqldump_hgsqldump

### Tool Description
Execute mysqldump using passwords from .hg.conf

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-hgsqldump:482--h0b57e2e_0
- **Homepage**: http://hgdownload.cse.ucsc.edu/admin/exe/
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-hgsqldump/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-hgsqldump/overview
- **Total Downloads**: 18.5K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
hgsqldump - Execute mysqldump using passwords from .hg.conf
usage:
   hgsqldump [OPTIONS] database [tables]
or:
   hgsqldump [OPTIONS] --databases [OPTIONS] DB1 [DB2 DB3 ...]
or:
   hgsqldump [OPTIONS] --all-databases [OPTIONS]
Generally anything in command line is passed to mysqldump
	after an implicit '-u user -ppassword
See also: mysqldump
Note: directory for results must be writable by mysql.  i.e. 'chmod 777 .'
Which is a security risk, so remember to change permissions back after use.
e.g.: hgsqldump --all -c --tab=. cb1
```

