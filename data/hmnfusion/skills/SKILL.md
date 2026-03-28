---
name: hmnfusion
description: HmnFusion is a bioinformatics tool that aggregates structural variant calls to quantify fusion allelic frequencies and analyze MMEJ signatures. Use when user asks to extract fusions from discovery tools, calculate fusion allelic frequency, or identify microhomology signatures in deletions and fusions.
homepage: https://github.com/guillaume-gricourt/HmnFusion
---

# hmnfusion

## Overview

HmnFusion is a specialized bioinformatics tool designed to bridge the gap between fusion detection and clinical quantification. It acts as an aggregator and refiner, primarily taking structural variant calls from discovery tools like GeneFuse and Lumpy to produce standardized JSON outputs. Beyond simple detection, it provides critical functionality for calculating the allelic frequency of fusions (quantification) and identifying MMEJ signatures, which are essential for understanding the molecular mechanisms behind double-strand break repairs in cancer.

## Core Workflows

### 1. Fusion Extraction
Combine results from discovery tools into a single HmnFusion-compatible JSON file.

```bash
hmnfusion extractfusion \
    --input-genefuse-json genefuse.json \
    --input-lumpy-vcf lumpy.vcf \
    --output-hmnfusion-json fusions.json
```
*Note: You can also use `--input-genefuse-html` if the JSON output is unavailable.*

### 2. Fusion Quantification
Calculate the allelic frequency for detected fusions. This requires a BAM file and a BED file defining the regions of interest.

```bash
hmnfusion quantification \
    --input-hmnfusion-json fusions.json \
    --input-sample-bam sample.bam \
    --input-hmnfusion-bed regions.bed \
    --name sample_id \
    --output-hmnfusion-vcf quantified.vcf
```
*Tip: To quantify a specific coordinate without a JSON file, use `--region chromosome:position`.*

### 3. MMEJ Analysis
Extract microhomology information from either standard deletions or fusion breakpoints.

**From VCF (Deletions):**
```bash
hmnfusion mmej-deletion \
    --input-sample-vcf variants.vcf \
    --input-reference-fasta reference.fasta \
    --output-hmnfusion-xlsx mmej_deletions.xlsx
```

**From Fusions:**
```bash
hmnfusion mmej-fusion \
    --input-hmnfusion-json fusions.json \
    --input-sample-bam sample.bam \
    --input-reference-fasta reference.fasta \
    --name sample_id \
    --output-hmnfusion-xlsx mmej_fusions.xlsx
```

## Expert Tips and Best Practices

- **Workflow Integration**: For a streamlined experience, use the `workflow-hmnfusion` command (available in the Docker image) to run `extractfusion` and `quantification` in a single step.
- **Breakpoint Logic**: In quantification, a fusion is defined by two breakpoints. HmnFusion requires at least one breakpoint to fall within the provided BED intervals; allelic depth is computed specifically for that side.
- **Alignment Requirements**: If you need to generate the BAM files first, use the `hmnfusion-align` Docker image, which contains the necessary `workflow-align` command and dependencies like BWA and Samtools.
- **Reference Data**: Ensure your reference FASTA matches the genome build used for alignment (e.g., hg19). You can use `hmnfusion download-zenodo` to fetch standard reference sets.



## Subcommands

| Command | Description |
|---------|-------------|
| hmnfusion download-zenodo | Download files from a Zenodo repository |
| hmnfusion extractfusion | Extract fusion information from Genefuse and Lumpy results |
| hmnfusion mmej-deletion | Analyze MMEJ-mediated deletions using VCF files and a reference genome |
| hmnfusion mmej-fusion | Analyze MMEJ (Microhomology-Mediated End Joining) fusions from HmnFusion results |
| hmnfusion quantification | Quantification of fusions using hmnfusion |
| hmnfusion workflow-align | Hmnfusion workflow for alignment of fastq files |
| hmnfusion workflow-fusion | HmnFusion workflow for fusion detection |
| hmnfusion workflow-hmnfusion | HmnFusion workflow for processing Lumpy and Genefuse results |

## Reference documentation
- [HmnFusion GitHub Repository](./references/github_com_guillaume-gricourt_HmnFusion.md)
- [HmnFusion README](./references/github_com_guillaume-gricourt_HmnFusion_blob_main_README.md)