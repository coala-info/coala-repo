# dx-cwl CWL Generation Report

## dx-cwl_compile-tool

### Tool Description
Compile a CWL tool definition file into a DNAnexus applet.

### Metadata
- **Docker Image**: quay.io/biocontainers/dx-cwl:0.1.0a20180820--py27_0
- **Homepage**: https://github.com/dnanexus/dx-cwl
- **Package**: https://anaconda.org/channels/bioconda/packages/dx-cwl/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dx-cwl/overview
- **Total Downloads**: 66.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/dnanexus/dx-cwl
- **Stars**: N/A
### Original Help Text
```text
usage: dx-cwl compile-tool [-h] --token TOKEN --project PROJECT
                           [--rootdir ROOTDIR] [--assets ASSETS [ASSETS ...]]
                           [--bundled BUNDLED [BUNDLED ...]]
                           [--extradisk EXTRADISK]
                           [--instance-provider {aws,azure}]
                           tool

positional arguments:
  tool                  CWL tool definition file

optional arguments:
  -h, --help            show this help message and exit
  --token TOKEN         DNAnexus authentication token
  --project PROJECT     DNAnexus project ID
  --rootdir ROOTDIR     Root directory to place CWL workflow, tools, and
                        resources
  --assets ASSETS [ASSETS ...]
                        One or more DNAnexus asset IDs to include in tool.
  --bundled BUNDLED [BUNDLED ...]
                        One or more DNAnexus bundledDepends file IDs to
                        include in tool.
  --extradisk EXTRADISK
                        Additional disk space required for instance in
                        mebibytes (2**20)
  --instance-provider {aws,azure}
                        VM instance provider (default: aws)
```


## dx-cwl_compile-workflow

### Tool Description
Compile a CWL workflow to a DNAnexus workflow.

### Metadata
- **Docker Image**: quay.io/biocontainers/dx-cwl:0.1.0a20180820--py27_0
- **Homepage**: https://github.com/dnanexus/dx-cwl
- **Package**: https://anaconda.org/channels/bioconda/packages/dx-cwl/overview
- **Validation**: PASS

### Original Help Text
```text
usage: dx-cwl compile-workflow [-h] --token TOKEN --project PROJECT
                               [--rootdir ROOTDIR]
                               [--assets ASSETS [ASSETS ...]]
                               [--bundled BUNDLED [BUNDLED ...]]
                               [--instance-provider {aws,azure}]
                               workflow

positional arguments:
  workflow              CWL workflow definition file

optional arguments:
  -h, --help            show this help message and exit
  --token TOKEN         DNAnexus authentication token
  --project PROJECT     DNAnexus project ID
  --rootdir ROOTDIR     Root directory to place CWL workflow, tools, and
                        resources
  --assets ASSETS [ASSETS ...]
                        One or more DNAnexus asset IDs to include in tools.
  --bundled BUNDLED [BUNDLED ...]
                        One or more DNAnexus bundledDepends file IDs to
                        include in tool.
  --instance-provider {aws,azure}
                        VM instance provider (default: aws)
```


## dx-cwl_run-workflow

### Tool Description
Runs a CWL workflow on the DNAnexus platform.

### Metadata
- **Docker Image**: quay.io/biocontainers/dx-cwl:0.1.0a20180820--py27_0
- **Homepage**: https://github.com/dnanexus/dx-cwl
- **Package**: https://anaconda.org/channels/bioconda/packages/dx-cwl/overview
- **Validation**: PASS

### Original Help Text
```text
usage: dx-cwl run-workflow [-h] --token TOKEN --project PROJECT
                           [--rootdir ROOTDIR] [--wait]
                           workflow inputs

positional arguments:
  workflow           Pointer to workflow/applet file or ID on the platform
  inputs             Pointer to CWL input file on (JSON or YAML) the platform.
                     All files referenced within this file should exist within
                     the project on the platform. Relative paths are
                     supported.

optional arguments:
  -h, --help         show this help message and exit
  --token TOKEN      DNAnexus authentication token
  --project PROJECT  DNAnexus project ID
  --rootdir ROOTDIR  Root directory to place CWL workflow, tools, and
                     resources
  --wait             Pointer to CWL input file on (JSON or YAML) the platform.
                     All files referenced within this file should exist within
                     the project on the platform. Relative paths are
                     supported.
```


## Metadata
- **Skill**: generated
