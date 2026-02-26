# garli-mpi CWL Generation Report

## garli-mpi

### Tool Description
This MPI version is for doing a large number of search replicates or bootstrap replicates, each using the SAME config file. The results will be exactly identical to those obtained by executing the config file a comparable number of times with the serial version of the program.

### Metadata
- **Docker Image**: biocontainers/garli-mpi:v2.1-3-deb_cv1
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/garli-mpi/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
MPI Garli started with command line: garli-mpi 

***ERROR***:Garli is expecting the number of jobs to be run to follow
	the executable name on the command line

GARLI Version 2.1. (32-bit)
This MPI version is for doing a large number of search replicates or bootstrap
replicates, each using the SAME config file.  The results will be exactly
identical to those obtained by executing the config file a comparable number
of times with the serial version of the program.

Usage: The syntax for launching MPI jobs varies between systems
Most likely it will look something like the following:
  mpirun [MPI OPTIONS] garli-mpi -[# of times to execute config file]
Specifying the number of times to execute the config file is mandatory.
This version will expect a config file named "garli.conf".
Consult your cluster documentation for details on running MPI jobs
```


## Metadata
- **Skill**: generated
