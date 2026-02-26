---
name: svtyper-python3
description: SVTyper assigns genotypes to structural variant calls by analyzing paired-end and split-read alignment patterns. Use when user asks to genotype structural variants, refine SV calls from discovery tools, or extract library metrics for genomic alignments.
homepage: https://github.com/hall-lab/svtyper
---


# svtyper-python3

## Overview

SVTyper is a specialized tool for assigning genotypes to structural variant (SV) calls. It works by analyzing the alignment patterns of paired-end and split reads at specific breakpoints. It is particularly useful for refining SV calls made by discovery tools like LUMPY, providing a probabilistic framework to distinguish between homozygous reference, heterozygous, and homozygous alternative genotypes. This skill covers both the standard multi-sample implementation and the parallelized single-sample optimized (`svtyper-sso`) version.

## Core Workflows

### Standard Genotyping
Use the base `svtyper` command for multi-sample VCFs or standard processing.

```bash
svtyper \
    -i input_svs.vcf \
    -B alignments.bam \
    -l library_metrics.json \
    > genotyped_svs.vcf
```

### Single-Sample Optimization (svtyper-sso)
Use `svtyper-sso` for faster processing of a single sample by utilizing multiple CPU cores.

```bash
svtyper-sso \
    --core 4 \
    --batch_size 1000 \
    -i input_svs.vcf \
    -B alignments.bam \
    -l library_metrics.json \
    > genotyped_svs.vcf
```

### Library Metadata Extraction
Before genotyping, extract library metrics to a JSON file. This step is highly recommended for large datasets to avoid redundant calculations.

```bash
svtyper -B alignments.bam -l library_metrics.json
```

## Expert Tips and Best Practices

- **Pre-calculate Library Stats**: Always generate the `.json` library file separately if you plan to run multiple genotyping iterations or troubleshoot specific variants. It saves significant compute time.
- **Monitor Insert Sizes**: Many genotyping errors stem from abnormal insert size distributions. Use the `scripts/lib_stats.R` script provided in the repository to visualize the JSON output:
  `Rscript scripts/lib_stats.R library_metrics.json output_histogram.pdf`
- **CRAM Support**: While SVTyper supports CRAM, be aware that `svtyper-sso` may occasionally encounter stability issues with CRAM files. If errors occur, fallback to the standard `svtyper` command or convert to BAM.
- **Adjusting Max Reads**: If a specific SV region has extremely high coverage (e.g., repetitive regions), use `--max_reads` (default 1000) to skip genotyping for that site to prevent bottlenecks.
- **Python Integration**: For pipeline developers, SVTyper can be imported directly. Use `svtyper.classic` for standard genotyping and `svtyper.singlesample` for the SSO implementation.

## Reference documentation
- [SVTyper GitHub Repository](./references/github_com_hall-lab_svtyper.md)
- [Bioconda svtyper-python3 Overview](./references/anaconda_org_channels_bioconda_packages_svtyper-python3_overview.md)