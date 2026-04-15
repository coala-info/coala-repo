---
name: tb_variant_filter
description: This tool filters and refines variant calls for *M. tuberculosis* by masking problematic genomic regions and applying quality thresholds. Use when user asks to filter VCF files for TB-specific regions like PE/PPE genes, apply depth or allele frequency thresholds, or remove SNVs near indels.
homepage: http://github.com/pvanheus/tb_variant_filter
metadata:
  docker_image: "quay.io/biocontainers/tb_variant_filter:0.4.0--pyhdfd78af_0"
---

# tb_variant_filter

## Overview
The `tb_variant_filter` tool is a specialized utility designed to refine variant calls for *M. tuberculosis* H37Rv. Unlike general-purpose VCF filters, it includes built-in genomic coordinates for known problematic regions in the TB genome, such as PE/PPE genes and repetitive loci. Use this skill to ensure high-quality SNV calling by applying standardized filters for depth, allelic percentage, and genomic context.

## Core Filtering Modes
The tool operates on a "opt-in" basis; no filters are applied unless explicitly flagged.

### 1. Region-Based Masking
Mask variants falling within specific TB-specific genomic regions.
*   **PE/PPE Genes**: `--region_filter pe_ppe` (Fishbein et al. 2015)
*   **Low Confidence/Mappability**: `--region_filter farhat_rlc` or `farhat_rlc_lowmap`
*   **Antibiotic Resistance Genes**: `--region_filter tbprofiler` or `mtbseq`
*   **Repetitive Loci**: `--region_filter uvp`

### 2. Quality and Context Filters
*   **Indel Proximity**: Use `-I` to mask SNVs near indels. Adjust the window with `--indel_window_size` (default is 5bp).
*   **Allele Frequency**: Use `-P` and `--min_percentage_alt` (default 90%) to remove heterogeneous or low-frequency calls.
*   **Read Depth**: Use `-D` and `--min_depth` (default 30) to ensure calls are supported by sufficient coverage.
*   **SNV Only**: Use `--snv_only_filter` to strip out all indels and complex variants, leaving only single nucleotide substitutions.

## Common CLI Patterns

### Standard High-Stringency Filter
For a standard "clean" SNV set, combine region masking with depth and frequency thresholds:
```bash
tb_variant_filter \
  --region_filter farhat_rlc_lowmap \
  --region_filter pe_ppe \
  --snv_only_filter \
  --min_depth_filter --min_depth 30 \
  --min_percentage_alt_filter --min_percentage_alt 90 \
  input.vcf output_filtered.vcf
```

### Extracting Masked Regions to BED
To visualize exactly what regions are being excluded in a genome browser (like IGV), use the helper command:
```bash
tb_region_list_to_bed pe_ppe pe_ppe_regions.bed
```

## Expert Tips
*   **Cumulative Filtering**: Filters are additive. A variant is excluded if it fails *any* of the active criteria.
*   **H37Rv Coordinates**: Ensure your input VCF is mapped to the H37Rv reference (NC_000962.3). Using other strains or reference versions will result in incorrect masking.
*   **Mapping Quality**: This tool does *not* filter by mapping quality (MQ). Perform MQ filtering using `bcftools` or `gatk` prior to running this tool if your upstream pipeline hasn't already addressed it.

## Reference documentation
- [GitHub Repository Documentation](./references/github_com_COMBAT-TB_tb_variant_filter.md)