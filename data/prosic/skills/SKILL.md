---
name: prosic
description: Prosic infers protein-level significance from peptide-spectrum matches using a Bayesian framework to address the protein inference problem. Use when user asks to calculate protein-level scores, manage decoy databases for FDR estimation, or generate statistically sound protein rankings from proteomics datasets.
homepage: https://prosic.github.io
metadata:
  docker_image: "quay.io/biocontainers/prosic:2.1.2--hc7800f0_1"
---

# prosic

## Overview
Prosic is a specialized bioinformatics tool used to infer protein-level significance from peptide-spectrum matches. It addresses the "protein inference problem" by using a Bayesian framework to aggregate peptide-level evidence into robust protein-level scores. This skill provides the necessary command-line patterns to process proteomics datasets, manage decoy databases for FDR estimation, and generate statistically sound protein rankings.

## Command Line Usage
The core functionality of prosic is accessed via its CLI. Ensure your input files (typically in TSV or specialized proteomics formats) are prepared with peptide-to-protein mappings.

### Basic Analysis
To run a standard protein inference analysis:
```bash
prosic -i input_peptides.tsv -o protein_results.tsv
```

### Key Parameters
- `--decoy-prefix`: Specify the string used to identify decoy proteins (e.g., `REV_` or `DECOY_`). This is essential for accurate FDR calculation.
- `--threshold`: Set the posterior error probability (PEP) or FDR threshold for reporting significant proteins.
- `--min-peptides`: Filter results to include only proteins identified by a minimum number of unique peptides (commonly set to 2 for high-confidence sets).

## Best Practices
- **Input Quality**: Ensure that peptide-level PEPs are pre-calculated. Prosic performs best when input scores are well-calibrated probabilities.
- **Decoy Strategy**: Always use a concatenated target-decoy database search result. Prosic relies on the distribution of decoy hits to model the null hypothesis.
- **Grouping**: Be aware of protein groups. If a peptide maps to multiple proteins, prosic will handle the ambiguity, but you should review the "group" column in the output to understand shared evidence.



## Subcommands

| Command | Description |
|---------|-------------|
| prosic | prosic |
| prosic | ProSIc: a tool for predicting the impact of variants on protein stability |
| prosic call-tumor-normal | Call somatic and germline variants from a tumor-normal sample pair and a VCF/BCF with candidate variants. |
| prosic control-fdr | Filter calls for controlling the false discovery rate (FDR) at given level. |
| prosic estimate-mutation-rate | Estimate the effective mutation rate of a tumor sample from a VCF/BCF with candidate variants from STDIN. |

## Reference documentation
- [Anaconda Bioconda Prosic Overview](./references/anaconda_org_channels_bioconda_packages_prosic_overview.md)