# bcbio-nextgen CWL Generation Report

## bcbio-nextgen_bcbio_nextgen.py

### Tool Description
Community developed high throughput sequencing analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/bcbio-nextgen:1.2.9--pyh5e36f6f_3
- **Homepage**: https://github.com/bcbio/bcbio-nextgen
- **Package**: https://anaconda.org/channels/bioconda/packages/bcbio-nextgen/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bcbio-nextgen/overview
- **Total Downloads**: 409.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bcbio/bcbio-nextgen
- **Stars**: N/A
### Original Help Text
```text
Incorrect input arguments []
usage: bcbio_nextgen.py [-h] [-n NUMCORES] [-t {local,ipython}]
                        [-s {lsf,sge,torque,slurm,pbspro}]
                        [--local_controller] [-q QUEUE] [-r RESOURCES]
                        [--timeout TIMEOUT] [--retries RETRIES] [-p TAG]
                        [-w WORKFLOW] [--workdir WORKDIR] [-v]
                        [--force-single] [--separators SEPARATORS]
                        [global_config] [fc_dir] [run_config ...]

Community developed high throughput sequencing analysis.

positional arguments:
  global_config         Global YAML configuration file specifying details
                        about the system (optional, defaults to installed
                        bcbio_system.yaml)
  fc_dir                A directory of Illumina output or fastq files to
                        process (optional)
  run_config            YAML file with details about samples to process
                        (required, unless using Galaxy LIMS as input)

optional arguments:
  -h, --help            show this help message and exit
  -n NUMCORES, --numcores NUMCORES
                        Total cores to use for processing
  -t {local,ipython}, --paralleltype {local,ipython}
                        Approach to parallelization
  -s {lsf,sge,torque,slurm,pbspro}, --scheduler {lsf,sge,torque,slurm,pbspro}
                        Scheduler to use for ipython parallel
  --local_controller    run controller locally
  -q QUEUE, --queue QUEUE
                        Scheduler queue to run jobs on, for ipython parallel
  -r RESOURCES, --resources RESOURCES
                        Cluster specific resources specifications. Can be
                        specified multiple times. Supports SGE, Torque, LSF
                        and SLURM parameters.
  --timeout TIMEOUT     Number of minutes before cluster startup times out.
                        Defaults to 15
  --retries RETRIES     Number of retries of failed tasks during distributed
                        processing. Default 0 (no retries)
  -p TAG, --tag TAG     Tag name to label jobs on the cluster
  -w WORKFLOW, --workflow WORKFLOW
                        Run a workflow with the given commandline arguments
  --workdir WORKDIR     Directory to process in. Defaults to current working
                        directory
  -v, --version         Print current version
  --force-single        Treat all files as single reads
  --separators SEPARATORS
                        comma separated list of separators that indicates
                        paired files.
```

