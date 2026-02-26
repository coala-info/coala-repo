# ucsc-dbtrash CWL Generation Report

## ucsc-dbtrash_dbTrash

### Tool Description
drop tables from a database older than specified N hours

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-dbtrash:482--h0b57e2e_0
- **Homepage**: https://hgdownload.cse.ucsc.edu/admin/exe
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-dbtrash/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-dbtrash/overview
- **Total Downloads**: 24.5K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
dbTrash - drop tables from a database older than specified N hours
usage:
   dbTrash -age=N [-drop] [-historyToo] [-db=<DB>] [-verbose=N]
options:
   -age=N - number of hours old to qualify for drop.  N can be a float.
   -drop - actually drop the tables, default is merely to display tables.
   -dropLimit=N - ERROR out if number of tables to drop is greater than limit,
                - default is to drop all expired tables
   -db=<DB> - Specify a database to work with, default is customTrash.
   -historyToo - also consider the table called 'history' for deletion.
               - default is to leave 'history' alone no matter how old.
               - this applies to the table 'metaInfo' also.
   -extFile    - check extFile for lines that reference files
               - no longer in trash
   -extDel     - delete lines in extFile that fail file check
               - otherwise just verbose(2) lines that would be deleted
   -topDir     - directory name to prepend to file names in extFile
               - default is /usr/local/apache/trash
               - file names in extFile are typically: "../trash/ct/..."
   -tableStatus  - use 'show table status' to get size data, very inefficient
   -delLostTable - delete tables that exist but are missing from metaInfo
                 - this operation can be even slower than -tableStatus
                 - if there are many tables to check.
   -verbose=N - 2 == show arguments, dates, and dropped tables,
              - 3 == show date information for all tables.
```

