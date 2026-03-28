---
name: iucn_sim
description: iucn_sim models the future of biodiversity by simulating species transitions between IUCN Red List threat categories to project extinction risks. Use when user asks to download IUCN threat data, estimate transition rates from reference groups, or simulate future extinction times for specific species.
homepage: https://github.com/tobiashofmann88/iucn_extinction_simulator
---

# iucn_sim

## Overview

`iucn_sim` is a command-line utility designed to model the future of biodiversity by leveraging historical and current IUCN Red List data. It employs a stochastic approach to simulate how species transition between threat categories (e.g., from Vulnerable to Endangered) and eventually reach extinction. By using a "reference group" to estimate transition rates, the tool can project extinction risks for specific "target species," providing probabilistic estimates of extinction times and overall extinction rates for a given clade or region.

## Installation and Environment

The tool has complex dependencies involving both Python and R. Using Conda is the recommended approach to ensure all R packages (like `rredlist`) and Python libraries are correctly linked.

```bash
# Create and activate a dedicated environment
conda create -n iucn_sim_env iucn_sim -c conda-forge -c bioconda
conda activate iucn_sim_env
```

## Command Line Usage

### Basic Commands
- `iucn_sim -h`: Display the main help page and list of available functions.
- `iucn_sim --version`: Verify the installation (ensure version >= 2.1).
- `iucn_sim <function> -h`: Access detailed help for a specific subcommand.

### Data Acquisition
The first step in any simulation is gathering the necessary threat assessment data.
```bash
iucn_sim get_iucn_data --species_list species.txt --out_dir ./iucn_data
```
*Note: This typically requires an IUCN Red List API key.*

### Simulation Workflow
The simulation process generally follows these steps:
1.  **Define Target Species**: A list of species for which you want to predict extinctions.
2.  **Select Reference Group**: A larger, well-documented group (e.g., the entire class Mammalia) used to estimate the rates at which species move between IUCN categories.
3.  **Estimate Transition Rates**: The tool calculates the probability of status changes based on the reference group's history.
4.  **Run Simulation**: Execute the stochastic model to project future extinctions over a specified timeframe.

## Expert Tips and Best Practices

- **Reference Group Selection**: Choose a reference group that is taxonomically or ecologically similar to your target group. The accuracy of the simulation depends heavily on the transition rates derived from the reference group.
- **R Dependencies**: Since `iucn_sim` calls R internally, ensure your R environment is accessible. If you encounter errors related to `rredlist`, verify that R is correctly configured in your path or within your Conda environment.
- **Data Pre-compilation**: For large-scale analyses (like all Mammals), check the `data/precompiled/` directory in the source repository for existing transition rate data to save computation time.
- **Windows Usage**: Always use the **Anaconda Powershell Prompt** rather than the standard Command Prompt to avoid path issues with the Python/R integration.



## Subcommands

| Command | Description |
|---------|-------------|
| iucn_sim get_iucn_data | Download IUCN data for future simulations |
| iucn_sim run_sim | Run future simulations based on IUCN data and status transition rates |
| iucn_sim transition_rates | MCMC-estimation of status transition rates from IUCN record |

## Reference documentation
- [IUCN Extinction Simulator README](./references/github_com_tandermann_iucn_extinction_simulator_blob_master_README.md)
- [Tool Overview and Installation](./references/anaconda_org_channels_bioconda_packages_iucn_sim_overview.md)