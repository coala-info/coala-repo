---
name: scg
description: The Single Cell Genotyper (SCG) is a statistical framework used to infer the clonal evolution and population structure of tumors from single-cell sequencing.
homepage: https://bitbucket.org/aroth85/scg/wiki/Home
---

# scg

## Overview
The Single Cell Genotyper (SCG) is a statistical framework used to infer the clonal evolution and population structure of tumors from single-cell sequencing. It accounts for the high error rates and missing data typical of single-cell experiments (such as allelic dropout) to provide a more accurate representation of the underlying genetic architecture. Use this skill to guide the execution of SCG for genotype calling and subclonal clustering.

## Installation and Setup
The tool is primarily distributed via Bioconda. Ensure the environment is configured to handle the dependencies required for the `linux-64` or `macOS-64` platforms.

```bash
conda install -c bioconda scg
```

## Core Workflow and Best Practices
When using SCG, follow these procedural guidelines to ensure high-quality inference:

### 1. Data Preparation
SCG requires input data representing the counts of reference and variant alleles at specific genomic loci across multiple single cells.
- Ensure input matrices are formatted correctly (typically sparse or dense representations of A/B allele counts).
- Filter out low-quality cells or loci with excessive missing data before running the inference to improve convergence speed.

### 2. Model Selection
SCG utilizes different probabilistic models depending on the nature of the data (e.g., doublet detection, varying error rates).
- Select the model that best matches your sequencing technology's error profile.
- Account for allelic dropout (ADO) rates, as this is a critical parameter for single-cell genotype accuracy.

### 3. Running Inference
The tool typically operates via a command-line interface. Common patterns involve specifying the input data, the number of expected clones (or a range for discovery), and the maximum number of iterations for the EM algorithm or MCMC sampling.

### 4. Interpreting Results
- **Clonal Prevalences**: Review the inferred proportions of each subclone within the sample.
- **Genotype Matrix**: Examine the most likely genotype assigned to each clone at each locus.
- **Cell Assignments**: Identify which individual cells belong to which inferred subclone.

## Expert Tips
- **Initialization**: Since the underlying models may be sensitive to initial conditions, run the tool with multiple random restarts to ensure the global optimum is reached.
- **Convergence**: Monitor the log-likelihood of the model to ensure the inference has converged before interpreting the clonal structure.
- **Complexity**: If the number of clones is unknown, run SCG across a range of values and use model selection criteria (like BIC or AIC) to determine the most parsimonious fit.

## Reference documentation
- [SCG Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_scg_overview.md)