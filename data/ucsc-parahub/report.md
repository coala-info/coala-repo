# ucsc-parahub CWL Generation Report

## ucsc-parahub_paraHub

### Tool Description
parasol hub server

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-parahub:469--h664eb37_1
- **Homepage**: http://hgdownload.cse.ucsc.edu/admin/exe/
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-parahub/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-parahub/overview
- **Total Downloads**: 11.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
paraHub - parasol hub server version 12.19
usage:
    paraHub machineList
Where machine list is a file with the following columns:
    name - Network name
    cpus - Number of CPUs we can use
    ramSize - Megabytes of memory
    tempDir - Location of (local) temp dir
    localDir - Location of local data dir
    localSize - Megabytes of local disk
    switchName - Name of switch this is on

options:
   -spokes=N  Number of processes that feed jobs to nodes - default 30.
   -jobCheckPeriod=N  Minutes between checking on job - default 10.
   -machineCheckPeriod=N  Minutes between checking on machine - default 20.
   -subnet=XXX.YYY.ZZZ Only accept connections from subnet (example 192.168).
     Or CIDR notation (example 192.168.1.2/24).
     Supports comma-separated list of IPv4 or IPv6 subnets in CIDR notation.
   -nextJobId=N  Starting job ID number.
   -logFacility=facility  Log to the specified syslog facility - default local0.
   -logMinPriority=pri minimum syslog priority to log, also filters file logging.
    defaults to "warn"
   -log=file  Log to file instead of syslog.
   -debug  Don't daemonize
   -noResume  Don't try to reconnect with jobs running on nodes.
   -ramUnit=N  Number of bytes of RAM in the base unit used by the jobs.
      Default is RAM on node divided by number of cpus on node.
      Shorthand expressions allow t,g,m,k for tera, giga, mega, kilo.
      e.g. 4g = 4 Gigabytes.
   -defaultJobRam=N Number of ram units in a job has no specified ram usage.
      Defaults to 1.
```

