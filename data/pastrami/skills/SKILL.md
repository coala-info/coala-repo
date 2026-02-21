---
name: pastrami
description: Pastrami is a scalable computational algorithm designed for rapid human ancestry estimation.
homepage: https://github.com/healthdisparities/pastrami
---

# pastrami

## Overview

Pastrami is a scalable computational algorithm designed for rapid human ancestry estimation. It utilizes exact haplotype matching and non-negative least square (NNLS) optimization to provide ancestry insights across various granularities. The tool is optimized for speed and can handle large-scale genomic datasets that might be computationally prohibitive for traditional methods. It is primarily used in bioinformatics workflows to analyze query genotypes against established reference populations.

## Installation and Environment

The most reliable way to install pastrami is via Bioconda:

```bash
conda install bioconda::pastrami
```

**Key Dependencies:**
- **Plink2**: Must be accessible in your `$PATH`. If only `plink2` is available, create a symbolic link named `plink` as the script may look for that specific name.
- **Python 3.8+**: Requires `pathos`, `numpy`, `scipy`, and `pandas`.
- **R**: Required for the `outsourcedOptimizer.R` component used during the aggregation stage.

## Data Preparation

Pastrami requires input in **TPED/TFAM** format. If your data is in VCF format, convert it using Plink:

```bash
plink --vcf input.vcf.gz --recode transpose --out output_prefix
```

## Core Workflows

### The Consolidated Workflow
For most use cases, the `all` subcommand handles the entire pipeline from haplotype creation to ancestry estimation.

```bash
./pastrami.py all \
  --reference-prefix [REF_FILES] \
  --query-prefix [QUERY_FILES] \
  --pop-group pop2group.txt \
  --haplotypes chrom.hap \
  --out-prefix results_run \
  --threads 20 \
  -v
```

### Modular Subcommands
If you need to run specific stages or resume a failed run, use the individual subcommands:

1.  **hapmake**: Generates the haplotype map file.
2.  **build**: Creates a database from the reference genotype files.
3.  **query**: Compares the query genotype against the reference database.
4.  **coanc**: Generates the pairwise individual copying fraction matrix.
5.  **aggregate**: Performs the final ancestry fraction estimation and grouping.

## Required Input Files

- **--reference-prefix**: The prefix for your reference `.tped` and `.tfam` files.
- **--query-prefix**: The prefix for your query `.tped` and `.tfam` files.
- **--haplotypes**: A TSV file defining haplotype positions.
- **--pop-group**: A mapping file (e.g., `pop2group.txt`) that assigns specific populations or tribes to broader regional groups.

## Expert Tips and Best Practices

- **Thread Management**: Always specify `--threads` for the `all` or `coanc` commands. Ancestry estimation is computationally intensive, and the tool is designed to scale across multiple cores.
- **Memory Considerations**: When working with very large reference sets, ensure your environment has sufficient RAM for the NNLS optimization phase, which occurs during the `aggregate` step.
- **Haplotype Tuning**: Use the `--min-snps` (default: 7) and `--max-snps` flags to fine-tune the granularity of the haplotype blocks if the default settings do not yield sufficient resolution for your specific population.
- **Output Interpretation**: The tool produces several `.Q` files. The `_fine_grain_estimates.Q` file provides the most detailed ancestry breakdown, while `_estimates.Q` typically provides the broader continental/sub-continental view.

## Reference documentation

- [Pastrami GitHub README](./references/github_com_healthdisparities_pastrami.md)
- [Bioconda Pastrami Overview](./references/anaconda_org_channels_bioconda_packages_pastrami_overview.md)