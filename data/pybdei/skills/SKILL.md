---
name: pybdei
description: PyBDEI performs maximum likelihood estimation of Birth-Death Exposed-Infectious model parameters from rooted phylogenetic trees. Use when user asks to infer transition rates between exposed and infectious states, estimate transmission and removal rates, or calculate epidemiological parameters like R0 and incubation periods from Newick trees.
homepage: https://github.com/evolbioinfo/bdei
---


# pybdei

## Overview

PyBDEI is a specialized tool for fast and accurate maximum likelihood estimation of Birth-Death Exposed-Infectious (BDEI) model parameters. It is designed to overcome the computational bottlenecks and numerical instabilities found in older phylodynamic implementations. By analyzing a rooted Newick phylogenetic tree, PyBDEI infers transition rates between "Exposed" (infected but not yet infectious) and "Infectious" states, as well as transmission and removal rates.

## Command Line Interface (CLI)

The primary command for parameter inference is `bdei_infer`.

### Basic Usage
To run an inference, you must provide a rooted tree and fix at least one model parameter to ensure the model is identifiable.

```bash
bdei_infer --nwk <path/to/tree.nwk> --p 0.3 --CI_repetitions 100 --log <output_file.tab>
```

### Key Arguments
- `--nwk`: Path to the rooted phylogenetic tree in Newick format.
- `--CI_repetitions`: Number of bootstrap repetitions for calculating Confidence Intervals (e.g., 100).
- `--log`: Path to the tab-separated output file where estimated parameters and CIs will be stored.

### Parameter Fixing (Identifiability)
For the model to converge correctly, you must fix one of the following parameters based on prior knowledge:
- `--mu`: Rate of becoming infectious (transition from state E to I).
- `--la`: Transmission rate (from I to a new E).
- `--psi`: Removal rate (individuals exiting the study due to death, healing, or treatment).
- `--p`: Sampling probability (probability of an individual being sampled upon removal).

## Python API Usage

PyBDEI can be integrated directly into Python workflows for programmatic analysis.

```python
from pybdei import infer

# Perform inference
# nwk: path to tree, p: fixed sampling probability
result, time = infer(nwk="tree.nwk", p=0.3, CI_repetitions=100)

# Accessing results
print(f"R0: {result.R_naught}")
print(f"Incubation Period: {result.incubation_period}")
print(f"Infectious Time: {result.infectious_time}")
print(f"Transition Rate (mu): {result.mu} (CI: {result.mu_CI})")
```

## Expert Tips and Best Practices

1. **Identifiability**: Always ensure you have a reliable estimate for at least one parameter (usually sampling probability `p` or the incubation rate `mu`) before running the inference. Fixing no parameters or incorrect parameters will lead to unreliable results.
2. **Large Datasets**: PyBDEI is optimized for up to 10,000 samples. If working with extremely large trees, ensure your environment has sufficient memory for the C++ backend to process the differential equations.
3. **Rooting**: The input Newick tree must be rooted. Using an unrooted tree will result in errors or incorrect likelihood calculations.
4. **Confidence Intervals**: While `CI_repetitions` increases runtime, it is critical for publishing results. A value of 100 is typically a good balance between speed and statistical rigor.
5. **Output Interpretation**: The `.tab` output file is compatible with spreadsheet software (Excel, LibreOffice) and standard data science tools (Pandas, R).

## Reference documentation
- [PyBDEI GitHub Repository](./references/github_com_evolbioinfo_bdei.md)
- [Bioconda PyBDEI Overview](./references/anaconda_org_channels_bioconda_packages_pybdei_overview.md)