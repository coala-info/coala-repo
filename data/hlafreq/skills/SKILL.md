---
name: hlafreq
description: hlafreq is a Python-based tool designed to automate the collection and meta-analysis of Human Leukocyte Antigen (HLA) allele frequencies.
homepage: https://github.com/Vaccitech/HLAfreq
---

# hlafreq

## Overview
hlafreq is a Python-based tool designed to automate the collection and meta-analysis of Human Leukocyte Antigen (HLA) allele frequencies. It solves the problem of disparate data reporting by providing a standardized workflow to scrape data from the Allele Frequency Net Database (AFND), filter for quality, and merge results using a Dirichlet distribution model. This approach ensures that combined frequency estimates are statistically robust and weighted appropriately by sample size.

## Core Workflow Patterns

### 1. Data Acquisition
To fetch data, you must first generate a search URL based on AFND parameters and then download the resulting table.

```python
import HLAfreq

# Generate URL for a specific country and locus
# Parameters match allelefrequencies.net form fields
base_url = HLAfreq.makeURL("Uganda", locus="A")

# Download data into a pandas DataFrame
aftab = HLAfreq.getAFdata(base_url)
```

### 2. Data Pre-processing and Standardization
Raw data from multiple studies often varies in quality and resolution. You must clean the data before aggregation.

*   **Filter Incomplete Studies**: Use `only_complete()` to keep only those studies where the sum of allele frequencies is approximately 1.0.
*   **Standardize Resolution**: Use `decrease_resolution()` to ensure all alleles are compared at the same level (e.g., 2-digit or 4-digit/2-field resolution).

```python
# Keep only high-quality, complete datasets
aftab = HLAfreq.only_complete(aftab)

# Reduce resolution to 2nd field (e.g., A*01:01:01 -> A*01:01)
aftab = HLAfreq.decrease_resolution(aftab, 2)
```

### 3. Combining Frequencies
The `combineAF()` function merges the data. By default, it weights studies by $2 \times \text{sample size}$ (accounting for two alleles per person).

```python
# Generate combined allele frequency estimates
caf = HLAfreq.combineAF(aftab)
```

## Expert Tips and Best Practices

*   **Weighting Logic**: While the default weighting is sample size, you can provide custom weights (e.g., total population size) when averaging across different countries or regions.
*   **Credible Intervals**: For publication-quality statistics, use the `HLAfreq_pymc` submodule. This uses Bayesian estimation to provide credible intervals for the frequencies, though it requires a functional C++ compiler (g++) for optimal performance.
*   **Windows Compatibility**: If running full scripts on Windows, always wrap your execution code in a `if __name__ == "__main__":` block to prevent multiprocessing errors during the estimation phase.
*   **Resolution Consistency**: Never combine data without first running `decrease_resolution`. Comparing a 2-field allele to a 3-field allele directly will result in fragmented and inaccurate frequency counts.

## Reference documentation
- [HLAfreq GitHub Repository](./references/github_com_BarinthusBio_HLAfreq.md)
- [hlafreq Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_hlafreq_overview.md)