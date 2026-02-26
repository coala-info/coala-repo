# ucsc-paratestjob CWL Generation Report

## ucsc-paratestjob_paraTestJob

### Tool Description
A good test job to run on Parasol. Can be configured to take a long time or crash.

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-paratestjob:482--h0b57e2e_2
- **Homepage**: http://hgdownload.cse.ucsc.edu/admin/exe/
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-paratestjob/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-paratestjob/overview
- **Total Downloads**: 11.2K
- **Last updated**: 2025-08-10
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
paraTestJob - version 12.19
A good test job to run on Parasol.  Can be configured to take a long time or crash.
usage:
   paraTestJob count
Run a relatively time consuming algorithm count times.
This algorithm takes about 1/10 per second each time.
options:
   -crash  Try to write to NULL when done.
   -err  Return -1 error code when done.
   -output=file  Make some output in file as well.
   -heavy=n  Make output heavy: n extra lumberjack lines.
   -input=file  Make it read in a file too.
   -sleep=n  Sleep for N seconds.
```

