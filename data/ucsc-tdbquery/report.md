# ucsc-tdbquery CWL Generation Report

## ucsc-tdbquery_tdbQuery

### Tool Description
Query the trackDb system using SQL syntax.

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-tdbquery:482--h0b57e2e_0
- **Homepage**: https://hgdownload.cse.ucsc.edu/admin/exe
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-tdbquery/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-tdbquery/overview
- **Total Downloads**: 34.8K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
tdbQuery - Query the trackDb system using SQL syntax.
Usage:
    tdbQuery sqlStatement
Where the SQL statement is enclosed in quotations to avoid the shell interpreting it.
Only a very restricted subset of a single SQL statement (select) is supported.   Examples:
    tdbQuery "select count(*) from hg18"
counts all of the tracks in hg18 and prints the results to stdout
   tdbQuery "select count(*) from *"
counts all tracks in all databases.
   tdbQuery "select  track,shortLabel from hg18 where type like 'bigWig%'"
prints to stdout a a two field .ra file containing just the track and shortLabels of bigWig 
type tracks in the hg18 version of trackDb.
   tdbQuery "select * from hg18 where track='knownGene' or track='ensGene'"
prints the hg18 knownGene and ensGene track's information to stdout.
   tdbQuery "select *Label from mm9"
prints all fields that end in 'Label' from the mm9 trackDb.
OPTIONS:
   -root=/path/to/trackDb/root/dir
Sets the root directory of the trackDb.ra directory hierarchy to be given path. By default
this is ~/kent/src/hg/makeDb/trackDb.
   -check
Check that trackDb is internally consistent.  Prints diagnostic output to stderr and aborts if 
there's problems.
   -strict
Mimic -strict option on hgTrackDb. Suppresses tracks where corresponding table does not exist.
   -release=alpha|beta|public
Include trackDb entries with this release tag only. Default is alpha.
   -noBlank
Don't print out blank lines separating records
   -oneLine
Print single ('|') pipe-separated line per record
   -noCompSub
Subtracks don't inherit fields from parents
   -shortLabelLength=N
Complain if shortLabels are over N characters
   -longLabelLength=N
Complain if longLabels are over N characters
```

