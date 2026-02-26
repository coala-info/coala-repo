---
name: prefersim
description: PReFerSim performs fast forward-time simulations of genetic data under the Poisson Random Field model to study natural selection and complex demographic histories. Use when user asks to simulate genetic variation patterns, model population bottlenecks, or analyze the distribution of fitness effects.
homepage: https://github.com/LohmuellerLab/PReFerSim
---


# prefersim

## Overview
PReFerSim is an ANSI C program designed for fast forward-time simulations of genetic data. It is specifically optimized for the Poisson Random Field model, allowing researchers to simulate how mutations arise and change in frequency under the influence of natural selection and complex demographic histories. It is a powerful tool for generating expected patterns of genetic variation under specific evolutionary hypotheses, including bottlenecks, inbreeding, and varying dominance coefficients.

## Installation and Dependencies
The easiest way to install PReFerSim is via Bioconda:
```bash
conda install bioconda::prefersim
```
**Note**: The tool requires the GNU Scientific Library (GSL). If compiling from source, ensure GSL is installed and linked correctly.

## Command Line Usage
PReFerSim relies on environment variables for its random number generator and takes a parameter file as its primary input.

### Basic Execution Pattern
```bash
GSL_RNG_SEED=1 GSL_RNG_TYPE=mrg ./PReFerSim [ParameterFile] [PrintOption]
```
- **GSL_RNG_SEED**: An integer value used to seed the simulation for reproducibility.
- **GSL_RNG_TYPE**: Usually set to `mrg` for the multiple recursive generator.
- **ParameterFile**: Path to the text file containing simulation parameters.
- **PrintOption**: 
    - `1`: Prints summary statistics of genetic variation.
    - `0`: Suppresses summary statistics.

## Input File Components
To run a simulation, you must define several configuration files referenced within your main Parameter File:

### 1. Demographic History File
Defines population size changes over time.
- Format typically includes the number of generations and the population size (N) for each epoch.
- Example files: `Bottleneck.txt`, `DemographicHistoryTwoConstantSizes.txt`.

### 2. Selection/Fitness Effect Files
Defines the Distribution of Fitness Effects (DFE).
- **Discrete Distribution**: Use a file like `SelPointTest.txt` to specify fixed selection coefficients and their probabilities.
- **Uniform Distribution**: Use a file like `SelUnifBounds.txt` to specify intervals for selection coefficients.

### 3. Inbreeding Coefficient File
If inbreeding is not constant, provide a file (e.g., `FChangedExample.txt`) specifying the inbreeding coefficient ($F$) for different epochs.

## Expert Tips and Best Practices
- **Trajectory Tracking**: To follow specific allele frequency trajectories, provide a list of allele IDs in a file (e.g., `Alleles11.txt`).
- **Post-Processing**: Use the included Perl script `GetListOfRunsWhereFrequencyMatches.pl` to extract specific alleles from the output based on their final frequencies.
- **Reproducibility**: Always record the `GSL_RNG_SEED` used for a specific run to ensure results can be replicated.
- **Validation**: Run the provided `Examples.sh` script to verify the installation and familiarize yourself with the output formats.

## Reference documentation
- [prefersim - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_prefersim_overview.md)
- [GitHub - LohmuellerLab/PReFerSim](./references/github_com_LohmuellerLab_PReFerSim.md)