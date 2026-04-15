---
name: octopusv
description: OctopuSV harmonizes and standardizes structural variant caller outputs into a unified format for downstream analysis and merging. Use when user asks to standardize VCF files, resolve breakend notations into standard SV types, merge variant calls from multiple tools, perform somatic variant calling, or benchmark structural variants against a truth set.
homepage: https://github.com/ylab-hi/octopusV
metadata:
  docker_image: "quay.io/biocontainers/octopusv:0.3.0--pyhdfd78af_0"
---

# octopusv

## Overview

OctopuSV is a specialized toolkit designed to harmonize the inconsistent outputs of various structural variant callers. It addresses the challenge of varying VCF implementations by using a unified intermediate format called SVCF. This allows for seamless integration of short-read and long-read callers, resolution of complex breakend (BND) notations into standard SV types (DEL, DUP, INV, INS, TRA), and robust somatic filtering. Use this skill to standardize workflows from raw variant calls to publication-ready cohort or somatic analysis.

## Core Workflow

The standard OctopuSV pipeline follows a three-step process:
1.  **Standardize**: Convert raw caller output to SVCF using `octopusv correct`.
2.  **Analyze**: Perform merging, somatic calling, or benchmarking on the SVCF files.
3.  **Export**: Convert the final results back to standard VCF using `octopusv svcf2vcf`.

## Command Reference and Best Practices

### 1. Standardization and BND Resolution
Use `correct` to resolve paired BND records into concrete SV types. This is essential for BND-heavy callers like GRIDSS or SvABA.

```bash
# Basic standardization
octopusv correct -i input.vcf -o output.svcf

# Apply quality and length filters during correction
octopusv correct -i input.vcf -o output.svcf --min-svlen 50 --max-svlen 100000 --filter-pass

# Adjust position tolerance for BND pairing (default is often sufficient)
octopusv correct -i input.vcf -o output.svcf --pos-tolerance 5
```

### 2. Merging and Integration
OctopuSV supports merging across different callers (multi-caller) or different individuals (multi-sample).

*   **Intersection (High Confidence)**: `octopusv merge -i a.svcf b.svcf c.svcf -o intersection.svcf --intersect`
*   **Union (Maximum Sensitivity)**: `octopusv merge -i a.svcf b.svcf -o union.svcf --union`
*   **Minimum Support**: Keep variants found by at least N callers:
    `octopusv merge -i a.svcf b.svcf c.svcf -o supported.svcf --min-support 2`
*   **Complex Logic**: Use the `--expression` flag for specific filtering:
    `octopusv merge -i A.svcf B.svcf C.svcf --expression "(A AND B) AND NOT C" -o filtered.svcf`

### 3. Somatic Variant Calling
Extract tumor-specific variants by comparing tumor and normal SVCFs. This works even for callers not natively designed for somatic analysis.

```bash
# Basic somatic extraction
octopusv somatic -t tumor.svcf -n normal.svcf -o somatic.svcf

# Fine-tune matching parameters
octopusv somatic -t tumor.svcf -n normal.svcf -o somatic.svcf --max-distance 100 --min-jaccard 0.8
```

### 4. Benchmarking and Statistics
Evaluate call sets against truth sets or generate visual reports.

```bash
# Benchmark against a truth set
octopusv benchmark truth.vcf calls.svcf -o results --reference-distance 500 --size-similarity 0.7

# Generate an interactive HTML report
octopusv stat -i input.svcf -o stats.txt --report

# Plot figures from statistics
octopusv plot stats.txt -o figures_prefix
```

## Expert Tips

*   **GRIDSS Support**: OctopuSV (v0.3.1+) natively resolves GRIDSS BND pairs to standard types and detects insertions from BND pairs with inserted sequences. No external R scripts are required.
*   **SVCF vs VCF**: Always perform analysis (merge/somatic) on `.svcf` files. Only use `svcf2vcf` at the very end of the pipeline for downstream tools that require standard VCF.
*   **Sample Names**: When merging in `--mode sample`, use `--sample-names` to ensure the output header correctly reflects the cohort.
*   **Visualization**: The `--upsetr` flag in the `merge` command generates UpSet plots to visualize the overlap between different callers or samples.



## Subcommands

| Command | Description |
|---------|-------------|
| octopusv benchmark | Benchmark structural variation calls against a truth set using GIAB standards. |
| octopusv correct | Correct SV events with optional quality filtering. |
| octopusv plot | Generate plots from the statistics file. |
| octopusv somatic | Extract somatic SVs by finding tumor-specific variants (tumor - normal intersection). |
| octopusv svcf2bed | Convert SVCF file to BED format. |
| octopusv svcf2bedpe | Convert SVCF file to BEDPE format. |
| octopusv svcf2vcf | Convert SVCF file to VCF format. |
| octopusv_merge | Merge multiple SVCF files based on specified strategy with consistent SOURCES and SAMPLE ordering. |
| octopusv_stat | Analyze a single SVCF file and generate comprehensive statistics. |

## Reference documentation
- [OctopuSV README](./references/github_com_ylab-hi_OctopuSV_blob_main_README.md)
- [SVCF Specifications](./references/github_com_ylab-hi_OctopuSV_blob_main_docs_SVCF_specifications.md)