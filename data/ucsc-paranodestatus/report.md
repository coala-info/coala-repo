# ucsc-paranodestatus CWL Generation Report

## ucsc-paranodestatus_paraNodeStatus

### Tool Description
Check status of paraNode on a list of machines.

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-paranodestatus:482--h0b57e2e_0
- **Homepage**: http://hgdownload.cse.ucsc.edu/admin/exe/
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-paranodestatus/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-paranodestatus/overview
- **Total Downloads**: 12.0K
- **Last updated**: 2025-07-14
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
paraNodeStatus - version 12.19
Check status of paraNode on a list of machines.
usage:
    paraNodeStatus machineList
options:
    -retries=N  Number of retries to get in touch with machine.
        The first retry is after 1/100th of a second. 
        Each retry after that takes twice as long up to a maximum
        of 1 second per retry.  Default is 7 retries and takes
        about a second.
    -long  List details of current and recent jobs.
```

