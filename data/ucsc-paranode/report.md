# ucsc-paranode CWL Generation Report

## ucsc-paranode_paraNode

### Tool Description
Parasol node server.

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-paranode:482--h0b57e2e_0
- **Homepage**: http://hgdownload.cse.ucsc.edu/admin/exe/
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-paranode/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-paranode/overview
- **Total Downloads**: 12.3K
- **Last updated**: 2025-07-14
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
paraNode - version 12.19
Parasol node server.
usage:
    paraNode start
options:
    -logFacility=facility  Log to the specified syslog facility - default local0.
    -logMinPriority=pri minimum syslog priority to log, also filters file logging.
     defaults to "warn"
    -log=file  Log to file instead of syslog.
    -debug  Don't daemonize
    -hub=host  Restrict access to connections from hub.
    -umask=000  Set umask to run under - default 002.
    -userPath=bin:bin/i386  User dirs to add to path.
    -sysPath=/sbin:/local/bin  System dirs to add to path.
    -env=name=value - add environment variable to jobs.  Maybe repeated.
    -randomDelay=N  Up to this many milliseconds of random delay before
        starting a job.  This is mostly to avoid swamping NFS with
        file opens when loading up an idle cluster.  Also it limits
        the impact on the hub of very short jobs. Default 5000.
    -cpu=N  Number of CPUs to use - default 1.
```

