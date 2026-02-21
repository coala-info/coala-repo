---
name: kinship-read
description: The `kinship-read` skill provides a specialized workflow for analyzing genetic distance between ancient individuals.
homepage: https://bitbucket.org/tguenther/read/src/master/
---

# kinship-read

## Overview
The `kinship-read` skill provides a specialized workflow for analyzing genetic distance between ancient individuals. Unlike modern DNA kinship tools, READv2 is optimized for the unique challenges of ancient DNA, such as post-mortem damage and extremely low sequencing depth. It works by calculating the proportion of non-matching alleles (P0) between pairs of individuals, normalized by a non-related baseline to account for population-specific diversity.

## Installation
The tool is available via Bioconda:
```bash
conda install -c bioconda kinship-read
```

## Common CLI Patterns

### Basic Kinship Estimation
To run the standard analysis on a set of individuals in TPED format:
```bash
readv2 -i input_folder/ -o output_results/
```

### Key Arguments
- `-i, --input`: Path to the directory containing input files (typically .tped and .tfam).
- `-o, --output`: Path to the directory where results and plots will be saved.
- `-p, --plot`: Generates PDF plots showing the P0 values and classification thresholds.
- `-t, --threshold`: Manually set the threshold for kinship classification if the default heuristic is insufficient.

### Input Requirements
- **Format**: READv2 primarily uses the TPED/TFAM format (PLINK).
- **Filtering**: Ensure data is filtered for biallelic SNPs. While READv2 handles low coverage, extremely low SNP counts (e.g., <2500 overlapping SNPs) may lead to unreliable classifications.

## Expert Tips
- **Baseline Selection**: The accuracy of READv2 depends on the normalization baseline. If the automated baseline selection fails due to small sample sizes, consider merging your data with a reference panel of unrelated individuals from a similar geographic or temporal context.
- **Low Coverage Handling**: For samples with very low coverage, use the `--low-coverage` flag (if available in the specific version) or manually inspect the P0 distribution plots to ensure the "unrelated" peak is clearly defined.
- **Interpreting Results**: Pay close attention to the standard error (SE) reported in the output. If the SE bars for a pair cross multiple kinship category thresholds, the classification should be treated as tentative.

## Reference documentation
- [READv2 Overview](./references/anaconda_org_channels_bioconda_packages_kinship-read_overview.md)
- [READv2 Source and Documentation](./references/bitbucket_org_tguenther_read_src_master.md)