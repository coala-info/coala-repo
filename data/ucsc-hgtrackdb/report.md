# ucsc-hgtrackdb CWL Generation Report

## ucsc-hgtrackdb_hgTrackDb

### Tool Description
Create trackDb table from text files.

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-hgtrackdb:482--h0b57e2e_0
- **Homepage**: http://hgdownload.cse.ucsc.edu/admin/exe/
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-hgtrackdb/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-hgtrackdb/overview
- **Total Downloads**: 16.8K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
hgTrackDb - Create trackDb table from text files.

Note that the browser supports multiple trackDb tables, usually
in the form: trackDb_YourUserName. Which particular trackDb
table the browser uses is specified in the hg.conf file found
either in your home directory file '.hg.conf' or in the web server's
cgi-bin/hg.conf configuration file with the setting: db.trackDb=trackDb
see also: src/product/ex.hg.conf discussion of this setting.
usage:
   hgTrackDb [options] org database trackDb trackDb.sql hgRoot

Options:
  org - a directory name with a hierarchy of trackDb.ra files to examine
      - in the case of a single directory with a single trackDb.ra file use .
  database - name of database to create the trackDb table in
  trackDb  - name of table to create, usually trackDb, or trackDb_${USER}
  trackDb.sql  - SQL definition of the table to create, typically from
               - the source tree file: src/hg/lib/trackDb.sql
               - the table name in the CREATE statement is replaced by the
               - table name specified on this command line.
  hgRoot - a directory name to prepend to org to locate the hierarchy:
           hgRoot/trackDb.ra - top level trackDb.ra file processed first
           hgRoot/org/trackDb.ra - second level file processed second
           hgRoot/org/database/trackDb.ra - third level file processed last
         - for no directory hierarchy use .
  -strict - only include tables that exist (and complain about missing html files).
  -raName=trackDb.ra - Specify a file name to use other than trackDb.ra
   for the ra files.
  -release=alpha|beta|public - Include trackDb entries with this release tag only.
  -settings - for trackDb scanning, output table name, type line,
            -  and settings hash to stderr while loading everything.
  -gbdbList=list - list of files to confirm existance of bigDataUrl files
  -addVersion - add cartVersion pseudo-table
  -noHtmlCheck - don't check for HTML even if strict is set
```

