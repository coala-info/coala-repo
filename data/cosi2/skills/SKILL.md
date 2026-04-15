---
name: cosi2
description: cosi2 is a high-performance coalescent simulator that models the ancestral history of genetic samples under complex evolutionary scenarios. Use when user asks to simulate genetic data, model natural selection, incorporate recombination maps, or define demographic events like population splits and migration.
homepage: https://www.broadinstitute.org/mpg/cosi2/
metadata:
  docker_image: "quay.io/biocontainers/cosi2:2.3.0rc3--py35_0"
---

# cosi2

## Overview
The `cosi2` tool is a high-performance coalescent simulator developed by the Broad Institute. It allows researchers to model the ancestral history of genetic samples under various evolutionary scenarios. Unlike simpler simulators, `cosi2` excels at incorporating natural selection and fine-scale recombination maps, offering both exact and approximate simulation modes to balance accuracy and computational speed.

## Command Line Usage
The primary interface for `cosi2` involves passing a parameter file that defines the demographic model and simulation constraints.

### Basic Execution
To run a simulation, use the following pattern:
```bash
cosi2 -p <parameter_file> [options]
```

### Key Parameters and Flags
- `-p <file>`: Path to the parameter file (required). This file defines population sizes, migration rates, and recombination events.
- `-n <int>`: Specify the number of iterations (replicates) to perform.
- `-r <seed>`: Set a specific random seed for reproducibility.
- `--approx`: Enable approximate simulation mode for faster execution on large datasets or complex models.

## Best Practices
- **Parameter File Structure**: Ensure your parameter file correctly defines the "events" (e.g., population splits, bottlenecks, or migration changes) in reverse chronological order, as the coalescent process works backward in time.
- **Recombination Maps**: When simulating specific genomic regions, provide a recombination map file to capture realistic crossover hotspots rather than assuming a uniform rate.
- **Selection Modeling**: If modeling a selective sweep, define the selection coefficient and the timing of the mutation clearly. `cosi2` is particularly robust for simulating "hard" sweeps.
- **Memory Management**: For large-scale simulations involving many populations or high recombination rates, monitor memory usage; the approximate mode (`--approx`) is recommended if the exact coalescent becomes computationally prohibitive.

## Reference documentation
- [cosi2 Overview](./references/anaconda_org_channels_bioconda_packages_cosi2_overview.md)