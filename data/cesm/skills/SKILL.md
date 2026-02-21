---
name: cesm
description: The Community Earth System Model (CESM) is a sophisticated, coupled climate model used to simulate Earth's climate system.
homepage: https://github.com/ESCOMP/cesm
---

# cesm

## Overview
The Community Earth System Model (CESM) is a sophisticated, coupled climate model used to simulate Earth's climate system. This skill provides the procedural knowledge required to set up a CESM sandbox, manage its modular component architecture, and ensure the underlying infrastructure (CIME) is correctly initialized. It is essential for researchers and developers who need to port the model to new high-performance computing (HPC) environments or customize specific model components like CAM, POP, or CLM.

## Installation and Environment Setup
CESM requires a specific software stack. Ensure your environment meets these requirements before proceeding:
- **Compilers**: Fortran 2003 compliant (Intel, GNU, or PGI) and C compiler.
- **Libraries**: NetCDF 4.3+, LAPACK, BLAS, and MPI.
- **Tools**: Python 3.8+, Perl 5, CMake, and Gmake.

To install via Conda (Bioconda channel):
```bash
conda install bioconda::cesm
```

## Sandbox Management
CESM uses a "meta-repository" approach. The main repository contains tools to fetch external components.

### 1. Initializing the Sandbox
```bash
# Clone the main repository
git clone https://github.com/escomp/cesm.git my_cesm_sandbox
cd my_cesm_sandbox

# List available versions
git tag

# Checkout a specific release or beta tag
git checkout cesm3_0_beta02
```

### 2. Populating Components (git-fleximod)
After checking out the main repository, you must download the actual model components (atmosphere, ocean, land, etc.).
```bash
# Download all required components and CIME infrastructure
./bin/git-fleximod update

# Check status of components
./bin/git-fleximod status
```

## Customizing Components
If you need to point to a specific version of a component (e.g., a specific version of the CAM atmosphere model):
1. Open `.gitmodules` in the root directory.
2. Locate the component entry.
3. Modify the `fxtag` or `fxhash` value.
4. Update the sandbox:
   ```bash
   ./bin/git-fleximod update <component_name>
   ```

## Common CLI Patterns
- **Switching Tags**: If you haven't made local changes, you can switch the entire sandbox version:
  ```bash
  git checkout <new_tag>
  ./bin/git-fleximod update
  ```
- **Forcing Updates**: If a component directory is corrupted or manually modified and you want to revert to the version defined in `.gitmodules`:
  ```bash
  ./bin/git-fleximod update --force
  ```
- **Help**: Access detailed fleximod options:
  ```bash
  ./bin/git-fleximod --help
  ```

## Expert Tips
- **Detached HEAD**: It is normal to be in a "detached HEAD" state after checking out a tag. If you plan to develop or commit changes, create a local branch immediately: `git checkout -b my_feature_branch`.
- **Porting**: If running on a new machine, the primary work occurs within the `cime` directory (Common Infrastructure for Modeling the Earth). Refer to CIME-specific documentation for `config_machines.xml` and `config_compilers.xml` setups.
- **Case Creation**: Once the sandbox is populated, use the `create_newcase` tool located in `cime/scripts/` to begin a simulation.

## Reference documentation
- [CESM GitHub Repository](./references/github_com_ESCOMP_cesm.md)
- [Bioconda CESM Overview](./references/anaconda_org_channels_bioconda_packages_cesm_overview.md)