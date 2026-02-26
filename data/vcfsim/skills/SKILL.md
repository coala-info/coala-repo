---
name: vcfsim
description: vcfsim simulates genetic data and outputs it into VCF files. Use when user asks to simulate genetic data, generate ground-truth genomic data, validate variant callers, test population genetic software, perform power analyses, create null datasets, benchmark selection detection tools, or benchmark demographic inference algorithms.
homepage: https://github.com/Pie115/VCFSimulator-SamukLab
---


# vcfsim

## Overview

vcfsim bridges the gap between complex coalescent simulations and standard bioinformatics file formats. It leverages the `msprime` engine to simulate ancestral histories and mutations, then outputs the resulting genetic data directly into VCF files. This tool is particularly useful for researchers who need to generate ground-truth genomic data to validate variant callers, test population genetic software, or perform power analyses without writing custom Python scripts.

## Usage Patterns

### Basic Simulation
The primary function of vcfsim is to generate a VCF from a set of population parameters.
```bash
vcfsim -n [sample_size] -l [sequence_length] -mu [mutation_rate] -r [recombination_rate] -o [output_prefix]
```

### Common Parameters
- `-n`, `--samples`: Number of haploid samples to simulate.
- `-l`, `--length`: Length of the genomic region in base pairs.
- `-mu`, `--mutation`: Mutation rate per base per generation.
- `-r`, `--recombination`: Recombination rate per base per generation.
- `-Ne`, `--effective_size`: Effective population size (defaults to 10,000 in many coalescent models).

### Expert Tips
- **Scaling**: When simulating large regions, ensure the recombination and mutation rates are adjusted to reflect realistic biological values (e.g., ~1e-8 for humans).
- **Downstream Compatibility**: The output is a standard VCF. It is recommended to pipe the output to `bgzip` and index with `tabix` if the simulated files are large, as many bioinformatics tools require indexed VCFs.
- **Integration**: Use vcfsim to create "null" datasets where the demographic history is known, allowing for the benchmarking of selection detection tools or demographic inference algorithms.

## Reference documentation

- [vcfsim Overview](./references/anaconda_org_channels_bioconda_packages_vcfsim_overview.md)