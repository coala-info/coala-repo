---
name: bayesase
description: BayesASE is a modular bioinformatics pipeline that implements a Bayesian approach to estimate allelic imbalance and formally compare it between experimental conditions.
homepage: https://github.com/McIntyre-Lab/BayesASE
---

# bayesase

## Overview
BayesASE is a modular bioinformatics pipeline that implements a Bayesian approach to estimate allelic imbalance and formally compare it between experimental conditions. It addresses common issues in ASE analysis by incorporating error reduction techniques, explicitly accounting for read coverage (which affects power), and allowing for varying bias across conditions. The core statistical model is implemented using RStan for robust MCMC-based inference.

## Installation
Install the package via Bioconda:
```bash
conda install bioconda::bayesase
```

## Core Workflow
The BayesASE pipeline is modular. When running the full analysis, follow this sequence of operations:

1.  **Reference Preparation**: Generate genotype-specific references to reduce mapping bias.
2.  **Alignment and Counting**: Align RNA-seq reads to the references and generate allele-specific counts.
3.  **Summarization**: Aggregate counts across features (e.g., genes or SNPs).
4.  **Design File Creation**: Prepare a design file that specifies replicates, conditions, and paths for prior calculation.
5.  **Prior Calculation**: Estimate parameters for the Bayesian model based on the experimental data.
6.  **Prior Merging**: Combine calculated priors for cross-condition comparisons.
7.  **Bayesian Analysis**: Run the RStan-based model to estimate AI and calculate Bayesian evidence for differences between conditions.

## CLI Usage and Patterns
While BayesASE is available as a Python package, it is frequently deployed via a collection of specialized scripts found in the project repository.

### Common Script Patterns
If using the repository's HPC/SLURM templates, the following script sequence is standard:

*   **Reference Generation**: `run_ase_genotype_specific_references.sbatch`
*   **Mapping**: `run_ase_align_and_count.sbatch`
*   **Aggregation**: `run_ase_summarize_counts.sbatch`
*   **Model Setup**: `run_ase_create_design_file_4_prior_calc.sbatch`
*   **Inference**: `run_ase_bayesian.sbatch`

### Key Statistical Considerations
*   **Replication**: For single-condition AI testing, at least three replicates are required for the model to function correctly.
*   **Coverage Sensitivity**: The model is robust to large differences in coverage between conditions, but ensure input counts are accurately summarized before the Bayesian step.
*   **Bias Modeling**: Unlike simpler models, BayesASE allows bias to vary between conditions, which is critical for GxE or reciprocal cross comparisons.

## Expert Tips
*   **Modular Input**: You can use the Bayesian model independently of the mapping pipeline. If you have allele-specific counts from other tools (e.g., GATK ASEReadCounter), you can format them for the `run_ase_bayesian` step.
*   **MCMC Diagnostics**: Since the tool uses RStan, ensure that the MCMC chains have converged. If the model reports low evidence or errors, check the coverage levels in the design file.
*   **Genotype-Specific Mapping**: Always prefer the genotype-specific reference workflow over standard reference mapping to minimize the "reference bias" that often plagues ASE studies.

## Reference documentation
- [BayesASE GitHub Repository](./references/github_com_McIntyre-Lab_BayesASE.md)
- [Bioconda BayesASE Overview](./references/anaconda_org_channels_bioconda_packages_bayesase_overview.md)