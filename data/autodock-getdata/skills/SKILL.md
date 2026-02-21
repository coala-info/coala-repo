---
name: autodock-getdata
description: This skill facilitates the acquisition and installation of the AutoDock suite using the Bioconda distribution channel.
homepage: http://autodock.scripps.edu/
---

# autodock-getdata

## Overview
This skill facilitates the acquisition and installation of the AutoDock suite using the Bioconda distribution channel. AutoDock is a specialized toolset designed to predict how small molecules, such as substrates or drug candidates, bind to a receptor of a known 3D structure. Use this skill when you need to establish the computational environment required for molecular docking simulations on Linux or macOS platforms.

## Installation and Setup
To prepare the environment for AutoDock, use the following Conda command:

```bash
conda install -c bioconda autodock
```

### Supported Platforms
- **Linux**: 64-bit (linux-64)
- **macOS**: 64-bit (osx-64)

## Usage Best Practices
- **Environment Isolation**: Always install AutoDock within a dedicated Conda environment to avoid dependency conflicts with other bioinformatics tools.
- **Version Consistency**: The current stable version available via Bioconda is 4.2.6. Ensure your input files (PDBQT) are compatible with this version's force field requirements.
- **Suite Components**: Note that the `autodock` package typically includes both `autodock` (the docking engine) and `autogrid` (for pre-calculating grid maps).

## Reference documentation
- [AutoDock Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_autodock_overview.md)