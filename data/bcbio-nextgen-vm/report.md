# bcbio-nextgen-vm CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| bcbio-nextgen-vm_cwl | Not completed | needs an installed bcbio genome data bundle (GRCh37 indexes and tool-data loc files, many GB); with sarscov2 reads it stops at the genome lookup. |
| bcbio-nextgen-vm_cwlrun | Not completed | runs a bcbio-generated CWL workflow through a runner with Docker containers and bcbio genome data, which bcbio_vm.py cwl could not produce here. |
| bcbio-nextgen-vm_run | Not completed | starts the bcbio Docker container (Docker inside Docker) and needs the multi-GB bcbio genome data bundle. |
| bcbio-nextgen-vm_template | PASS |  |

## bcbio-nextgen-vm_template

### Tool Description
Create a bcbio sample.yaml file from a standard template and inputs

### Metadata
- **Docker Image**: quay.io/biocontainers/bcbio-nextgen-vm:0.1.6--py37_0
- **Homepage**: https://github.com/bcbio/bcbio-nextgen-vm
- **Package**: https://anaconda.org/channels/bioconda/packages/bcbio-nextgen-vm/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bcbio-nextgen-vm/overview
- **Total Downloads**: 100.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/chapmanb/bcbio-nextgen-vm
- **Stars**: N/A

### Original Help Text
```text
usage: bcbio_vm.py template [-h] [--only-metadata] [--force-single]
                            [--separators SEPARATORS]
                            [--systemconfig SYSTEMCONFIG] [-n NUMCORES]
                            [--relpaths]
                            template metadata [input_files [input_files ...]]

positional arguments:
  template              Template name or path to template YAML file. Built in
                        choices: freebayes-variant, gatk-variant, tumor-
                        paired, noalign-variant, illumina-rnaseq, illumina-
                        chipseq
  metadata              CSV file with project metadata. Name of file used as
                        project name.
  input_files           Input read files, in BAM or fastq format

optional arguments:
  -h, --help            show this help message and exit
  --only-metadata       Ignore samples not present in metadata CSV file
  --force-single        Treat all files as single reads
  --separators SEPARATORS
                        semicolon separated list of separators that indicates
                        paired files.
  --systemconfig SYSTEMCONFIG
                        Global YAML configuration file specifying system
                        details. Defaults to installed bcbio_system.yaml.
  -n NUMCORES, --numcores NUMCORES
                        Total cores to use for processing
  --relpaths            Convert inputs into relative paths to the work
                        directory
```

## bcbio-nextgen-vm_cwl

### Tool Description
Generate Common Workflow Language (CWL) from configuration inputs

### Metadata
- **Docker Image**: quay.io/biocontainers/bcbio-nextgen-vm:0.1.6--py37_0
- **Homepage**: https://github.com/bcbio/bcbio-nextgen-vm
- **Package**: https://anaconda.org/channels/bioconda/packages/bcbio-nextgen-vm/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bcbio-nextgen-vm/overview
- **Total Downloads**: 100.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/chapmanb/bcbio-nextgen-vm
- **Stars**: N/A

### Original Help Text
```text
usage: bcbio_vm.py cwl [-h] [--systemconfig SYSTEMCONFIG]
                       [--add-container-tag ADD_CONTAINER_TAG]
                       sample_config

positional arguments:
  sample_config         YAML file with details about samples to process.

optional arguments:
  -h, --help            show this help message and exit
  --systemconfig SYSTEMCONFIG
                        Global YAML configuration file specifying system
                        details. Defaults to installed bcbio_system.yaml.
  --add-container-tag ADD_CONTAINER_TAG
                        Add a container revision tag to CWL ('quay_lookup`
                        retrieves lates from quay.io)
```

## bcbio-nextgen-vm_cwlrun

### Tool Description
Run Common Workflow Language (CWL) inputs with a specified tool

### Metadata
- **Docker Image**: quay.io/biocontainers/bcbio-nextgen-vm:0.1.6--py37_0
- **Homepage**: https://github.com/bcbio/bcbio-nextgen-vm
- **Package**: https://anaconda.org/channels/bioconda/packages/bcbio-nextgen-vm/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bcbio-nextgen-vm/overview
- **Total Downloads**: 100.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/chapmanb/bcbio-nextgen-vm
- **Stars**: N/A

### Original Help Text
```text
usage: bcbio_vm.py cwlrun [-h] [--no-container]
                          [-s {lsf,sge,torque,slurm,pbspro,htcondor}]
                          [-q QUEUE] [-r RESOURCES] [-j JOBLIMIT]
                          [--runconfig RUNCONFIG]
                          [--cloud-project CLOUD_PROJECT]
                          [--cloud-root CLOUD_ROOT] [--host HOST]
                          [--auth AUTH]
                          {cwltool,arvados,toil,bunny,funnel,cromwell,sbg,wes}
                          directory [toolargs [toolargs ...]]

positional arguments:
  {cwltool,arvados,toil,bunny,funnel,cromwell,sbg,wes}
                        CWL tool to run
  directory             Directory with bcbio generated CWL
  toolargs              Arguments to pass to CWL tool

optional arguments:
  -h, --help            show this help message and exit
  --no-container        Use local installation of bcbio instead of Docker
                        container
  -s {lsf,sge,torque,slurm,pbspro,htcondor}, --scheduler {lsf,sge,torque,slurm,pbspro,htcondor}
                        Scheduler to use, for an HPC system
  -q QUEUE, --queue QUEUE
                        Scheduler queue to run jobs on, for an HPC system
  -r RESOURCES, --resources RESOURCES
                        Cluster specific resources specifications. Can be
                        specified multiple times. Supports SGE, Torque, LSF
                        and SLURM parameters.
  -j JOBLIMIT, --joblimit JOBLIMIT
                        Maximum number of simultaneous jobs (not cores)
                        submitted. Only supported for Cromwell runner.
                        Defaults to 1 for local runner, unlimited otherwise.
  --runconfig RUNCONFIG
                        Custom configuration HOCON file for Cromwell.
  --cloud-project CLOUD_PROJECT
                        Remote cloud project for running jobs. Cromwell
                        AWS/GCP support.
  --cloud-root CLOUD_ROOT
                        Remote bucket location for run files. Cromwell AWS/GCP
                        support.
  --host HOST           WES: host for submitting jobs
  --auth AUTH           WES: authentication token
```

## bcbio-nextgen-vm_run

### Tool Description
Run an automated analysis on the local machine

### Metadata
- **Docker Image**: quay.io/biocontainers/bcbio-nextgen-vm:0.1.6--py37_0
- **Homepage**: https://github.com/bcbio/bcbio-nextgen-vm
- **Package**: https://anaconda.org/channels/bioconda/packages/bcbio-nextgen-vm/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bcbio-nextgen-vm/overview
- **Total Downloads**: 100.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/chapmanb/bcbio-nextgen-vm
- **Stars**: N/A

### Original Help Text
```text
usage: bcbio_vm.py run [-h] [--fcdir FCDIR] [--image IMAGE]
                       [--systemconfig SYSTEMCONFIG] [-n NUMCORES]
                       sample_config

positional arguments:
  sample_config         YAML file with details about samples to process.

optional arguments:
  -h, --help            show this help message and exit
  --fcdir FCDIR         A directory of Illumina output or fastq files to
                        process
  --image IMAGE         Docker image name to use, could point to compatible
                        pre-installed image.
  --systemconfig SYSTEMCONFIG
                        Global YAML configuration file specifying system
                        details. Defaults to installed bcbio_system.yaml.
  -n NUMCORES, --numcores NUMCORES
                        Total cores to use for processing
```

