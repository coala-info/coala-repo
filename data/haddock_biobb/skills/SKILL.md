---
name: haddock_biobb
description: HADDOCK3 is a modular platform for the integrative modeling and docking of biomolecular complexes using custom workflows. Use when user asks to perform protein-protein docking, run biomolecular simulations, or manage HADDOCK3 workflows using TOML configuration files.
homepage: https://github.com/haddocking/haddock3
---


# haddock_biobb

## Overview
HADDOCK3 (High Ambiguity Driven protein-protein DOCKing) is a modular platform designed for the integrative modeling of biomolecular complexes. It distinguishes itself from previous versions by implementing a "recipe" based system where users define custom workflows using discrete modules (such as rigid-body docking, flexible refinement, and water refinement). This skill facilitates the execution and management of these workflows through the native HADDOCK3 command-line interface, focusing on the transition from input data to structural models.

## Core CLI Usage
The primary entry point for the software is the `haddock3` command, which requires a configuration file in TOML format.

### Basic Execution
To start a new docking simulation:
```bash
haddock3 <configuration-file.toml>
```

### Workflow Management
*   **Dry Run / Setup**: To validate the configuration and prepare the directory structure without starting the actual heavy computations:
    ```bash
    haddock3 recipe.toml --setup
    ```
*   **Restarting a Run**: If a simulation fails or needs to be re-run from a specific point, use the `--restart` flag. Note that this will delete all subsequent step folders from the specified step onwards:
    ```bash
    haddock3 recipe.toml --restart <step_number>
    ```
*   **Extending a Run**: To continue a simulation from a directory previously prepared with the `haddock3-copy` utility:
    ```bash
    haddock3 --extend-run <run_directory>
    ```

### Debugging and Logging
Control the verbosity of the output to troubleshoot issues with specific modules or data parsing:
```bash
haddock3 recipe.toml --log-level DEBUG
```
Available levels: `DEBUG`, `INFO`, `WARNING`, `ERROR`, `CRITICAL`.

## Expert Tips and Best Practices
*   **Module Sequence**: A standard HADDOCK3 workflow typically begins with the `topoaa` module to generate topologies. Common subsequent modules include `rigidbody` (sampling), `flexref` (flexible refinement), `emref` (energy minimization), and `caprieval` (analysis).
*   **Configuration Format**: Ensure all configuration files use the `.toml` extension. HADDOCK3 relies on this format to parse the modular "recipe" steps.
*   **Restraint Generation**: For complex docking scenarios involving specific experimental data, use the auxiliary `haddock-restraints` tool to format data correctly before referencing it in your TOML recipe.
*   **Large Scale Runs**: For screening multiple molecules or running large batches, utilize `haddock-runner` to automate the generation and execution of multiple HADDOCK3 scenarios.

## Reference documentation
- [HADDOCK3 Overview](./references/anaconda_org_channels_bioconda_packages_haddock_biobb_overview.md)
- [HADDOCK3 GitHub Repository](./references/github_com_haddocking_haddock3.md)