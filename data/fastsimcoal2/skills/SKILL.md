---
name: fastsimcoal2
description: fastsimcoal2 simulates genetic data under complex demographic histories using a continuous-time sequential Markovian coalescent approximation. Use when user asks to simulate genomic regions, model population migrations and fissions, or perform composite likelihood-based demographic inference using the site frequency spectrum.
homepage: http://cmpg.unibe.ch/software/fastsimcoal27/
---


# fastsimcoal2

## Overview
fastsimcoal2 is a powerful tool for simulating genetic data under complex demographic histories. It uses a continuous-time sequential Markovian coalescent approximation, making it significantly faster than traditional coalescent simulators for large genomic regions (>100 Mb). It is particularly useful for researchers needing to model population fissions, fusions, and migrations, or for those performing composite likelihood-based demographic inference using the Joint Site Frequency Spectrum (JSFS).

## Core CLI Usage Patterns

### Basic Simulation
To run a simulation based on a parameter file (.par):
`fsc27093 -i scenario.par -n 1000`
- `-i`: Input parameter file.
- `-n`: Number of simulations to perform.

### Generating SNPs
To generate a specific number of SNPs from short DNA segments:
`fsc27093 -i scenario.par -n 100 -s 10`
- `-s [X]`: Output exactly X SNPs.

### Demographic Parameter Estimation
To estimate parameters from an observed SFS:
`fsc27093 -t scenario.tpl -e scenario.est -m -n 100000 -L 40`
- `-t`: Template file (.tpl) defining the model.
- `-e`: Estimation file (.est) defining parameter ranges.
- `-m`: Perform parameter estimation via the SFS.
- `-L`: Number of Brent cycles for likelihood maximization.

### Output Options
- `-G`: Generate a genotype table (.gen file).
- `-g`: Generate diploid genotypes (0, 1, 2) instead of haploid (0, 1).

## Expert Tips and Best Practices

### Handling Population Growth and Migration
- **Bug Alert**: Ensure you are using version 2.7.0.5 or later (e.g., fsc27093) if your model includes both exponential growth and migration, as earlier 2.7 versions had critical bugs in this combination.
- **Deme Killing**: To make a population inaccessible to migration (e.g., population extinction backward in time), set the sink deme size to zero using an `absoluteResize` event. This allows you to maintain the same migration matrix without manual adjustments.

### Parameter File Syntax
- **absoluteResize**: Use this keyword in `.par` or `.tpl` files to set a sink population to a specific absolute size, avoiding complex relative growth calculations in the `.est` file.
- **paramInRange**: In `.est` files, use this keyword at the end of a line to use a previously defined simple parameter as a range delimiter for a new parameter.

### Performance Optimization
- **Large Recombining Segments**: Use the `-k` option to specify the number of recombination breakpoints to keep in memory, which optimizes simulations of large chromosomes.
- **Subdivided Populations**: The latest version is optimized for large, sparsely occupied structured populations; however, the performance gain is minimal for models with only a few migration-connected demes.

### MacOS Compatibility
- If running on macOS, ensure a recent version of `gcc` (e.g., version 10+) is installed via Homebrew or manual download, as the multithreaded features require OpenMP libraries not included in default Apple Clang.

## Reference documentation
- [fastsimcoal27 Homepage](./references/cmpg_unibe_ch_software_fastsimcoal27.md)
- [Bioconda fastsimcoal2 Overview](./references/anaconda_org_channels_bioconda_packages_fastsimcoal2_overview.md)