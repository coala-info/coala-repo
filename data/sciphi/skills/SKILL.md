---
name: sciphi
description: SCIPhI (Single-cell mutation identification via phylogenetic inference) is a specialized tool for somatic mutation calling in single-cell sequencing (SCS) data.
homepage: https://github.com/cbg-ethz/SCIPhI
---

# sciphi

## Overview

SCIPhI (Single-cell mutation identification via phylogenetic inference) is a specialized tool for somatic mutation calling in single-cell sequencing (SCS) data. Unlike standard variant callers that treat cells independently, SCIPhI uses a Markov Chain Monte Carlo (MCMC) scheme to jointly call mutations and estimate the tumor phylogeny. This approach allows the tool to share information across the evolutionary tree, significantly improving accuracy in the presence of technical artifacts like Allelic Dropout (ADO) and sequencing errors.

Use this skill to:
1. Prepare the required input files (mpileup and cell metadata).
2. Configure cell type identifiers for tumor and control samples.
3. Execute the inference engine to generate mutation calls and phylogenetic trees.

## Input Preparation

### 1. Sequencing Data (mpileup)
SCIPhI expects sequencing information in the standard `mpileup` format.
- **Generation**: Align FASTQ files to a reference genome and use `samtools mpileup` to generate the input.
- **Note**: SCIPhI assumes a pileup against a reference and will ignore any positions where the reference base is 'N'.

### 2. Cell Names and Types
You must provide a tab-delimited text file (e.g., `cellNames.txt`) that maps the samples in the mpileup to their respective types. The order of cells in this file must match the order of samples in the mpileup file.

**Format**:
```text
Cell_ID_1    CT
Cell_ID_2    CT
Cell_ID_3    CN
Cell_ID_4    BN
```

**Cell Type Identifiers**:
- `CT`: Tumor Cell (Single-cell)
- `CN`: Control Normal Cell (Single-cell)
- `BN`: Control Bulk Normal

## Common CLI Patterns

### Basic Execution
To run the inference with a specific seed for reproducibility:
```bash
sciphi -o output_prefix --in cellNames.txt --seed 42 input.mpileup
```

### Key Arguments
- `-o, --out`: Prefix for output files.
- `--in`: Path to the tab-delimited cell names/types file.
- `--seed`: Integer seed for the MCMC random number generator.
- `-h, --help`: Display all available options, including MCMC parameters and model constraints.

## Best Practices and Expert Tips

- **Control Samples**: Always include normal control samples (`CN` or `BN`) when available. This allows SCIPhI to more effectively filter out germline variants and focus on somatic mutations.
- **Preprocessing**: Follow GATK Best Practices for data pre-processing (marking duplicates, base recalibration) before generating the mpileup to ensure the highest quality input.
- **MCMC Convergence**: For complex datasets, you may need to adjust MCMC parameters (found in `sciphi -h`) to ensure the chain reaches a stable posterior distribution.
- **Streaming**: Recent versions of SCIPhI support streaming of mpileup files to reduce disk I/O overhead.

## Reference documentation
- [SCIPhI GitHub Repository](./references/github_com_cbg-ethz_SCIPhI.md)
- [SCIPhI Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_sciphi_overview.md)