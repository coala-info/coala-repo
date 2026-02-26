---
name: pb-falconc
description: This tool provides C-optimized utilities for Pacific Biosciences genome assembly pipelines like FALCON and FALCON-Unzip. Use when user asks to install, update, or execute the underlying C binaries for PacBio secondary analysis and genome assembly.
homepage: https://github.com/PacificBiosciences/pbbioconda
---


# pb-falconc

## Overview
The `pb-falconc` skill provides procedural knowledge for working with the C-optimized utilities used in Pacific Biosciences (PacBio) genome assembly. These tools are essential components of the FALCON and FALCON-Unzip assembly pipelines, specifically handling the computationally intensive tasks of the assembly process. Use this skill when you need to install, update, or execute the underlying C binaries that power PacBio secondary analysis.

## Installation and Environment
The tools are distributed via Bioconda. It is recommended to use a dedicated environment to avoid dependency conflicts, particularly with Python versions.

```bash
# Create a dedicated environment and install pb-falconc
conda create -n pacbio_assembly
conda activate pacbio_assembly
conda install -c bioconda pb-falconc
```

To ensure all dependencies for a full assembly workflow are present, you may also need the meta-package:
```bash
conda install -c bioconda pb-assembly
```

## Core Utilities
`pb-falconc` is a "combo-package" that includes:
- **pbipa**: C-based utilities for PacBio assembly.
- **FALCON/FALCON-Unzip components**: Optimized C implementations of the pypeflow and FALCON logic.

### Best Practices
- **Platform Support**: These utilities are primarily supported on **linux-64**. While some PacBio tools support macOS, `pb-falconc` is optimized for Linux HPC environments.
- **Channel Priority**: Ensure your conda channels are configured correctly to avoid library mismatches:
  1. conda-forge
  2. bioconda
- **Updates**: Because conda performs minimal updates to satisfy dependency graphs, always update the entire environment to prevent stale dependencies:
  ```bash
  conda update --all
  ```

## Troubleshooting
- **Python Compatibility**: Note that many legacy PacBio assembly components require Python 2.7. If you encounter "ImportError" or syntax errors, verify that you are not attempting to run these utilities in a Python 3-only environment.
- **Official Support**: Tools distributed via Bioconda are intended for Research Use Only (RUO). For ISO-compliant or production-grade needs, refer to the official SMRT Link stable releases.

## Reference documentation
- [pb-falconc - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_pb-falconc_overview.md)
- [PacificBiosciences/pbbioconda: PacBio Secondary Analysis Tools on Bioconda](./references/github_com_PacificBiosciences_pbbioconda.md)