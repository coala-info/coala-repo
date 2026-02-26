---
name: hmnfusion
description: HmnFusion aggregates and quantifies gene fusions detected in DNA genomics data while analyzing MMEJ signatures at breakpoints. Use when user asks to extract and merge fusion calls, calculate fusion allelic frequency, or analyze microhomology-mediated end joining signatures.
homepage: https://github.com/guillaume-gricourt/HmnFusion
---


# hmnfusion

## Overview

HmnFusion is a specialized bioinformatics utility designed to streamline the downstream analysis of gene fusions detected in DNA genomics. It acts as an aggregator and quantifier, taking structural variation calls from Genefuse and Lumpy to produce a unified JSON representation. Beyond simple aggregation, it calculates the allelic frequency of fusions by inspecting BAM files and provides dedicated modules for detecting MMEJ (Microhomology-Mediated End Joining) signatures at both deletion and fusion breakpoints.

## Command Line Usage

### 1. Fusion Extraction and Aggregation
Use `extractfusion` to merge results from different callers into a single HmnFusion JSON file.

```bash
hmnfusion extractfusion \
    --input-genefuse-json genefuse_results.json \
    --input-lumpy-vcf lumpy_calls.vcf \
    --output-hmnfusion-json aggregated_fusions.json
```

### 2. Allelic Frequency Quantification
Calculate the variant allele frequency (VAF) for fusions. This requires the aggregated JSON and the original alignment file.

```bash
hmnfusion quantification \
    --input-hmnfusion-json aggregated_fusions.json \
    --input-sample-bam sample_aligned.bam \
    --input-hmnfusion-bed target_regions.bed \
    --name sample_id \
    --output-hmnfusion-vcf quantified_fusions.vcf
```

### 3. MMEJ Analysis
Analyze microhomology at fusion or deletion sites to understand the repair mechanism.

**For Fusions:**
```bash
hmnfusion mmej-fusion \
    --input-hmnfusion-json aggregated_fusions.json \
    --input-sample-bam sample_aligned.bam \
    --input-reference-fasta reference.fasta \
    --name sample_id \
    --output-hmnfusion-xlsx mmej_analysis.xlsx
```

**For Deletions (from standard VCFs):**
```bash
hmnfusion mmej-deletion \
    --input-sample-vcf variants.vcf \
    --input-reference-fasta reference.fasta \
    --output-hmnfusion-xlsx deletion_mmej.xlsx
```

## Expert Tips and Best Practices

- **Unified Workflow**: For standard pipelines, use `workflow-hmnfusion` to run extraction and quantification in a single command.
- **Region Specificity**: In `quantification`, a fusion is defined by two breakpoints. HmnFusion requires at least one breakpoint to fall within the provided BED intervals to compute allelic depth for that side.
- **Input Flexibility**: The `extractfusion` command accepts Genefuse results in either JSON or HTML format.
- **Docker Integration**: When using Docker, use the `hmnfusion` image for analysis and the `hmnfusion-align` image (which includes heavy reference dependencies) specifically for the `workflow-align` command.
- **Sample Naming**: Always provide a consistent `--name` argument; this string is used as the sample identifier in the resulting VCF and Excel outputs.

## Reference documentation
- [HmnFusion GitHub Repository](./references/github_com_guillaume-gricourt_HmnFusion.md)
- [HmnFusion Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_hmnfusion_overview.md)