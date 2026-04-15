---
name: noresm
description: The Norwegian Earth System Model (NorESM) simulates past, present, and future global climate states using a fully-coupled framework. Use when user asks to create a new climate simulation case, manage model externals, or build and submit NorESM runs on specific machine targets.
homepage: https://github.com/NorESMhub/NorESM
metadata:
  docker_image: "quay.io/biocontainers/noresm:2.0.2--py37pl5321h736fc29_1"
---

# noresm

## Overview
The Norwegian Earth System Model (NorESM) is a global, fully-coupled climate model used for simulating past, present, and future climate states. It is built upon the Community Earth System Model (CESM) and utilizes the CIME (Common Infrastructure for Modeling the Earth) framework for case management. This skill provides the specific environment variables, machine targets, and workflow patterns required to initialize and execute NorESM simulations.

## Environment Configuration
Before creating a NorESM case, you must define the following environment variables to ensure the model can locate NetCDF libraries and manage data paths correctly:

```bash
# Set NetCDF directory using nc-config
export NETCDF_DIR=$(nc-config --prefix)

# Define CIME model type
export CIME_MODEL=cesm

# Set data and work roots (typically $HOME or a high-capacity scratch disk)
export CESM_DATA_ROOT=$HOME
export CESM_WORK_ROOT=$HOME

# Ensure the input data directory exists
mkdir -p $CESM_DATA_ROOT/inputdata
```

## Case Management Workflow
NorESM follows the standard CIME workflow. When creating a new simulation case, use the following patterns:

### 1. Creating a New Case
When running on supported infrastructure, specify `espresso` as the target machine.
```bash
./create_newcase --case ~/cases/my_noresm_run --compset <COMPSET_NAME> --res <RESOLUTION> --mach espresso
```

### 2. Managing Externals
NorESM relies on several external components (BLOM, CAM, CICE, etc.). Use `git-fleximod` (in newer versions) or `checkout_externals` to fetch these:
- **Modern approach**: Use `git-fleximod` to manage branch development and component checkouts.
- **Legacy approach**: Run `./manage_externals/checkout_externals` from the root directory.

### 3. Setup, Build, and Submit
Navigate to your case directory to finalize the model:
```bash
cd ~/cases/my_noresm_run
./case.setup
./case.build
./case.submit
```

## Component-Specific Tips
- **BLOM (Bergen Layered Ocean Model)**: NorESM's native ocean component. Ensure you check the specific BLOM tags (e.g., v1.12.x) in the `Externals.cfg` for version compatibility.
- **CAM (Community Atmosphere Model)**: Pay attention to atmospheric nudging settings if performing historical reconstructions.
- **FATES (Functionally Assembled Terrestrial Ecosystem Simulator)**: Often used with CTSM in NorESM. Check parameter files if you encounter water balance "endrun" errors during historical simulations.
- **Output Compression**: For NorESM3, it is recommended to compress output files to `cdf5` rather than standard NetCDF-4 to optimize storage.

## Troubleshooting
- **Input Data**: If the model fails at initialization, verify that `$CESM_DATA_ROOT/inputdata` contains the required forcing files.
- **Machine Files**: If not using `espresso`, you may need to modify `ccs_config` to define your local cluster's compiler paths and MPI settings.

## Reference documentation
- [NorESM Overview and Installation](./references/anaconda_org_channels_bioconda_packages_noresm_overview.md)
- [NorESM GitHub Repository and Branches](./references/github_com_NorESMhub_NorESM.md)
- [NorESM3 Release Tags and Component Updates](./references/github_com_NorESMhub_NorESM_tags.md)