---
name: phyclone
description: PhyClone models tumor evolution by transforming bulk sequencing data into phylogenetic trees using a forest-structured Chinese restaurant process. Use when user asks to infer tumor phylogenies, model clonal evolution from multi-sample sequencing data, or reconstruct cancer cell population relationships.
homepage: https://github.com/Roth-Lab/PhyClone
---


# phyclone

## Overview
PhyClone is a specialized tool for cancer genomics that implements a forest-structured Chinese restaurant process to model tumor evolution. It transforms bulk sequencing data into phylogenetic trees, allowing researchers to understand how different cell populations within a tumor are related. The tool is designed to handle multi-sample data and accounts for varying copy number states and tumor purity. It is most effective when used in conjunction with pre-clustering tools like PyClone-VI to manage computational complexity in whole-genome sequencing (WGS) datasets.

## Installation
The recommended installation method is via Conda:
```bash
conda install -c bioconda -c conda-forge phyclone
```

## Input Data Requirements
PhyClone requires data in a tab-delimited (TSV) tidy format.

### Main Input File
The following columns are mandatory:
- `mutation_id`: Unique identifier for the mutation.
- `sample_id`: Unique identifier for the sample.
- `ref_counts`: Number of reads matching the reference allele.
- `alt_counts`: Number of reads matching the alternate allele.
- `major_cn`: Major copy number of the segment (must be > 0).
- `minor_cn`: Minor copy number of the segment.
- `normal_cn`: Total copy number in healthy tissue (typically 2 for autosomes).

Optional columns: `tumour_content` (default 1.0), `error_rate` (default 0.001), and `chrom`.

### Cluster File (Recommended)
While optional, pre-clustering mutations significantly reduces runtime.
- `mutation_id`: Must match the main input file.
- `cluster_id`: The assigned cluster for the mutation.

## Common CLI Patterns

### Standard Sampling Run
To generate a posterior trace file:
```bash
phyclone run -i input.tsv -c clusters.tsv -o trace.h5 --num-chains 4
```

### High-Precision Configuration
For complex datasets, increase the number of particles and chains to improve results:
```bash
phyclone run -i input.tsv -c clusters.tsv -o trace.h5 --num-chains 8 --num-particles 200 --seed 42
```

### Handling Overdispersed Data
If the sequencing data shows higher variance than expected under a binomial model, use the beta-binomial emission density:
```bash
phyclone run -i input.tsv -o trace.h5 -d beta-binomial
```

### Outlier Modeling
To account for mutational outliers or potential data artifacts, enable the global outlier probability:
```bash
phyclone run -i input.tsv -o trace.h5 --outlier-prob 0.001
```

## Expert Tips and Best Practices
- **Pre-clustering**: For Whole Genome Sequencing (WGS), always pre-cluster mutations using PyClone-VI. PhyClone can ingest PyClone-VI output directly.
- **Chain Convergence**: Always run at least 4 independent chains (`--num-chains 4`). If the resulting phylogenies differ significantly between chains, increase the number of iterations (`-n`) or particles (`--num-particles`).
- **Missing Data**: PhyClone removes mutations that do not have entries for all samples. If a mutation is missing in one sample, you should manually extract the reference and alternate counts from the BAM file for that sample rather than leaving it blank.
- **Copy Number**: Ensure `major_cn` is never 0 for any mutation you wish to keep, as PhyClone automatically filters these out.
- **Burn-in**: PhyClone uses a heuristic SMC strategy for burn-in. These samples are automatically discarded and do not target the posterior.

## Reference documentation
- [PhyClone GitHub Repository](./references/github_com_Roth-Lab_PhyClone.md)
- [PhyClone Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_phyclone_overview.md)