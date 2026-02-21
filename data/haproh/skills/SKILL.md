---
name: haproh
description: The `haproh` skill enables the identification of long autozygous segments and the estimation of contamination rates in ancient genomic data.
homepage: https://github.com/hringbauer/hapROH
---

# haproh

## Overview
The `haproh` skill enables the identification of long autozygous segments and the estimation of contamination rates in ancient genomic data. Unlike standard ROH callers, this tool is optimized for the high error rates and low coverage typical of ancient DNA by leveraging modern haplotype reference panels. It is primarily used for detecting parental relatedness (inbreeding) and assessing the authenticity of male ancient samples through the `hapCon` module.

## Installation and Setup
Install the package via Bioconda or PyPI to access the command-line utilities and Python API.

```bash
# Using Conda (recommended for bioinformatics environments)
conda install bioconda::haproh

# Using pip
pip install hapROH
```

## Core Workflows

### 1. Calling Runs of Homozygosity (ROH)
Use `hapROH` to identify genomic regions where an individual has inherited identical haplotypes from both parents.
- **Target Data**: Ancient or modern human DNA.
- **Requirement**: Input data should be restricted to the 1240K SNP set for optimal performance with standard reference panels.
- **Reference Panels**: Requires a modern haplotype reference panel (e.g., 1000 Genomes Project) to model the background linkage disequilibrium.

### 2. Estimating Contamination (hapCon)
Use the `hapCon` extension to estimate the proportion of non-endogenous DNA in male ancient samples.
- **Mechanism**: It analyzes the X chromosome in males; since males should only have one X, any "heterozygosity" detected against a reference panel suggests contamination.
- **Constraint**: This module is specifically validated for male individuals.
- **Input**: Requires a specific HDF5 reference file (e.g., `maf5_filter_chrX.hdf5`) for the X chromosome.

### 3. Joint Estimation
For complex samples, `haproh` can perform joint estimation of ROH blocks and contamination rates simultaneously to prevent contamination from masking or creating false ROH signals.

## Expert Tips and Best Practices
- **SNP Selection**: Always ensure your input genotypes are filtered to the 1240K SNP array positions. Using significantly different SNP sets may lead to inaccurate HMM (Hidden Markov Model) transitions.
- **Coverage Handling**: The tool is robust down to very low coverage (e.g., <0.5x), but ensure that the genotyping error parameters are adjusted if the coverage is extremely sparse.
- **Reference Panel Matching**: Ensure the reference panel used matches the broad ancestry of the ancient sample to avoid false-positive ROH calls due to population-specific bottlenecks.
- **Memory Management**: For large-scale processing, utilize the HDF5 intermediary file format to optimize memory usage during the E-step of the HMM.

## Reference documentation
- [anaconda_org_channels_bioconda_packages_haproh_overview.md](./references/anaconda_org_channels_bioconda_packages_haproh_overview.md)
- [github_com_hringbauer_hapROH.md](./references/github_com_hringbauer_hapROH.md)
- [github_com_hringbauer_hapROH_tree_master_Notebooks.md](./references/github_com_hringbauer_hapROH_tree_master_Notebooks.md)