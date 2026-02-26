# bcbio-nextgen-vm CWL Generation Report

## bcbio-nextgen-vm_bcbio_vm.py

### Tool Description
Automatic installation for bcbio-nextgen pipelines, with docker.

### Metadata
- **Docker Image**: quay.io/biocontainers/bcbio-nextgen-vm:0.1.6--py37_0
- **Homepage**: https://github.com/chapmanb/bcbio-nextgen-vm
- **Package**: https://anaconda.org/channels/bioconda/packages/bcbio-nextgen-vm/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bcbio-nextgen-vm/overview
- **Total Downloads**: 100.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/chapmanb/bcbio-nextgen-vm
- **Stars**: N/A
### Original Help Text
```text
usage: bcbio_vm.py [-h] [--datadir DATADIR]
                   {template,cwl,cwlrun,install,upgrade,run,ipython,ipythonprep,runfn,devel,aws,elasticluster,saveconfig}
                   ...

Automatic installation for bcbio-nextgen pipelines, with docker.

optional arguments:
  -h, --help            show this help message and exit
  --datadir DATADIR     Directory with genome data and associated files.

[sub-commands]:
  {template,cwl,cwlrun,install,upgrade,run,ipython,ipythonprep,runfn,devel,aws,elasticluster,saveconfig}
    template            Create a bcbio sample.yaml file from a standard
                        template and inputs
    cwl                 Generate Common Workflow Language (CWL) from
                        configuration inputs
    cwlrun              Run Common Workflow Language (CWL) inputs with a
                        specified tool
    install             Install or upgrade bcbio-nextgen docker container and
                        data.
    upgrade             Install or upgrade bcbio-nextgen docker container and
                        data.
    run                 Run an automated analysis on the local machine.
    ipython             Run on a cluster using IPython parallel.
    ipythonprep         Prepare a batch script to run bcbio on a scheduler.
    runfn               Run a specific bcbio-nextgen function with provided
                        arguments
    devel               Utilities to help with developing using bcbio inside
                        of containers
    aws                 Automate resources for running bcbio on AWS
    elasticluster       Interface to standard elasticluster commands
    saveconfig          Save standard configuration variables for current
                        user. Avoids need to specify on the command line in
                        future runs.
```

