---
name: truvari
description: Truvari is a suite for comparing, manipulating, and benchmarking structural variants (SVs). Use when user asks to benchmark structural variants, compare SV callsets, collapse redundant variants, refine SV benchmarking results, convert VCFs to analysis-ready data, or annotate structural variants.
homepage: https://github.com/spiralgenetics/truvari
---


# truvari

## Overview
Truvari is a specialized suite designed to address the challenges of structural variant (SV) comparison and manipulation. Unlike small variants, SVs are often represented inconsistently across different callers; Truvari solves this by using distance-based matching and local re-alignment. It is the standard tool for calculating precision and recall metrics against truth sets (like GIAB) and provides essential utilities for callset consolidation and functional annotation.

## Core Workflows

### SV Benchmarking
The most common use case is comparing a "comparison" VCF (your results) against a "base" VCF (the truth set).

```bash
truvari bench -b base.vcf.gz -c comp.vcf.gz -f reference.fa -o output_dir/
```
**Key Parameters:**
- `-b / --base`: The gold standard/truth VCF.
- `-c / --comp`: The VCF to be evaluated.
- `-f / --ref`: Reference genome FASTA (required for many matching logic steps).
- `-o / --output`: Directory for results (summary.json, tp-base.vcf, fp.vcf, etc.).

### Collapsing Redundant Variants
Use this to merge multi-sample VCFs or remove duplicate calls from the same sample that represent the same event.

```bash
# First merge with bcftools
bcftools merge -m none sampleA.vcf.gz sampleB.vcf.gz | bgzip > merged.vcf.gz
tabix merged.vcf.gz

# Collapse with truvari
truvari collapse -i merged.vcf.gz -o collapsed_output.vcf -c collapsed_removed.vcf
```

### Benchmarking Refinement
After running `bench`, use `refine` to resolve complex regions where standard matching might fail due to different variant representations. This uses multiple sequence alignment (MSA) via the `phab` engine.

```bash
truvari refine output_dir/
```

### VCF to Analysis-Ready Data
To perform custom statistics or plotting, convert VCF entries into a pandas DataFrame (stored as a Parquet or CSV file).

```bash
truvari vcf2df input.vcf.gz output.parquet
```

## Expert Tips and Best Practices

1. **Input Preparation**: All input VCFs must be blocked-compressed with `bgzip` and indexed with `tabix`.
2. **Matching Thresholds**: By default, Truvari uses specific thresholds for size similarity (`-s 0.7`) and sequence similarity (`-S 0.7`). Adjust these if working with particularly noisy data or very large SVs.
3. **Pass Only**: If you only want to benchmark high-quality calls, use the `--passonly` flag to ignore variants filtered in the VCF.
4. **Reference Consistency**: Ensure the reference FASTA used in `-f` exactly matches the one used for variant calling (identical chromosome names and sequences).
5. **Annotation**: Use `truvari anno` to add genomic context (like repeat regions or gene overlaps) directly to the VCF INFO fields, which is more efficient than manual bedtools intersections for SV-specific logic.

## Reference documentation
- [Truvari GitHub Repository](./references/github_com_ACEnglish_truvari.md)
- [Truvari Wiki Documentation](./references/github_com_ACEnglish_truvari_wiki.md)
- [Bioconda Truvari Overview](./references/anaconda_org_channels_bioconda_packages_truvari_overview.md)