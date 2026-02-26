# ucsc-maketablelist CWL Generation Report

## ucsc-maketablelist_makeTableList

### Tool Description
create/recreate tableList tables (cache of SHOW TABLES and DESCRIBE)

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-maketablelist:482--h0b57e2e_0
- **Homepage**: http://hgdownload.cse.ucsc.edu/admin/exe/
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-maketablelist/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-maketablelist/overview
- **Total Downloads**: 18.0K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
makeTableList - create/recreate tableList tables (cache of SHOW TABLES and DESCRIBE)
usage:
   makeTableList [assemblies]
options:
   -host               show tables: mysql host
   -user               show tables: mysql user
   -password           show tables: mysql password
   -toProf             optional: mysql profile to write table list to (target server)
   -toHost             alternative to toProf: mysql target host
   -toUser             alternative to toProf: mysql target user
   -toPassword         alternative to toProf: mysql target pwd
   -hgcentral          specify an alternative hgcentral db name when using -all
   -all                recreate tableList for all active assemblies in hg.conf's hgcentral
   -bigFiles           create table with tuples (track, name of bigfile)
```

