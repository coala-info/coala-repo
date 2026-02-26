---
name: pyclone
description: PyClone is a statistical framework used to identify and cluster subclonal populations in cancer samples by estimating the cellular prevalence of mutations. Use when user asks to cluster subclonal populations, estimate cellular prevalence, or run a Bayesian clonal inference pipeline on mutation read counts and copy number data.
homepage: https://github.com/Roth-Lab/pyclone/
---


# pyclone

## Overview

PyClone is a statistical framework designed to identify and cluster subclonal populations within cancer samples. It uses a Bayesian model to process mutation read counts and copy number data, providing an estimate of the cellular prevalence of each mutation. This skill enables the execution of the PyClone pipeline, from initial setup and MCMC (Markov Chain Monte Carlo) analysis to post-processing and result generation. It is most effective when used with multi-sample datasets from the same patient, as shared mutations across samples significantly improve the accuracy of clonal inference.

## Installation and Environment

The most reliable way to use PyClone is via a dedicated Conda environment to avoid library conflicts.

```bash
# Create and activate the environment
conda create -n pyclone -c bioconda -c conda-forge pyclone
conda activate pyclone

# Verify installation
PyClone --help
```

## Input Data Requirements

PyClone requires one tab-delimited (TSV) file per sample. Each file must contain the following mandatory columns:

- `mutation_id`: A unique identifier (must be identical across all sample files for the same mutation).
- `ref_counts`: Number of reads matching the reference allele.
- `var_counts`: Number of reads matching the variant allele.
- `normal_cn`: Copy number in non-malignant cells (usually 2, except for sex chromosomes).
- `minor_cn`: Minor allele copy number in malignant cells.
- `major_cn`: Major allele copy number in malignant cells (must be > 0).

## Common CLI Patterns

### Standard Analysis Pipeline
The `run_analysis_pipeline` command is the primary entry point for most users, handling preprocessing, MCMC, and plotting in one step.

```bash
PyClone run_analysis_pipeline \
    --in_files sample_A.tsv sample_B.tsv \
    --working_dir ./pyclone_analysis \
    --tumour_contents 0.9 0.7 \
    --samples SampleA SampleB
```

### Handling Large Datasets
For datasets with more than a few hundred mutations, the default settings may be slow or less accurate. Use the following adjustments:

- **Speed up initialization**: Use `--init_method connected`.
- **Improve convergence**: Increase the number of iterations with `--num_iters 20000`.

### Manual Step-by-Step Execution
If the automated pipeline fails (common with very large datasets during the plotting phase), run the steps manually:

1. **Setup**: `PyClone setup_analysis --in_files <files> --working_dir <dir>`
2. **Run MCMC**: `PyClone run_analysis --config_file <dir>/config.yaml`
3. **Build Results Table**: `PyClone build_table --config_file <dir>/config.yaml --out_file results.tsv`

## Expert Tips and Best Practices

- **Mutation ID Consistency**: Do not append sample names to mutation IDs (e.g., use `chr1_12345` instead of `chr1_12345_SampleA`). PyClone uses the ID to link mutations across samples; if they don't match, the analysis will fail to find overlapping loci.
- **Missing Data**: If a variant caller fails to identify a mutation in one sample of a multi-sample set, manually retrieve the allele counts for that position in the "missing" sample and include it in the TSV. PyClone performs best when the mutation matrix is complete.
- **Tumor Content**: Always provide `--tumour_contents`. If omitted, PyClone assumes 100% purity, which often leads to incorrect prevalence estimates in real-world samples.
- **Plotting Limitations**: The built-in `plot_clusters` and `plot_loci` commands are not optimized for thousands of mutations. If they crash, use the `build_table` output to create custom visualizations in R (e.g., using `ggplot2`) or Python (e.g., `seaborn`).
- **Phylogeny**: PyClone identifies clusters but does not infer the evolutionary tree (phylogeny). Use the output TSV with downstream tools like `citup` or `PhyloWGS` for tree reconstruction.

## Reference documentation
- [GitHub - Roth-Lab/pyclone](./references/github_com_Roth-Lab_pyclone.md)
- [PyClone Overview - Bioconda](./references/anaconda_org_channels_bioconda_packages_pyclone_overview.md)