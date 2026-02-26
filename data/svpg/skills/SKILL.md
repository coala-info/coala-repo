---
name: svpg
description: SVPG identifies structural variations in long-read sequencing data by leveraging pangenome graph alignments to improve precision and resolve complex variants. Use when user asks to call structural variants from BAM or GAF files, detect somatic variants, or augment a pangenome graph with newly discovered variants.
homepage: https://github.com/coopsor/SVPG
---


# svpg

## Overview

SVPG (Structural Variant detection based on Pangenome Graph) is a computational tool designed to identify structural variations by leveraging pangenome references. Unlike traditional callers that rely solely on linear reference genomes, SVPG uses graph alignments to improve precision and resolve complex variants. It is particularly optimized for long-read sequencing data (Oxford Nanopore and PacBio HiFi) and provides a streamlined path for integrating newly discovered variants back into a pangenome graph.

## Core Workflows

### 1. Pangenome-Guided SV Detection (BAM-based)
Use this mode when you have reads already mapped to a linear reference genome. SVPG will extract SV-supporting reads and realign them to the pangenome graph to refine calls.

```bash
svpg call \
    --working_dir svpg_out/ \
    --bam sample.bam \
    --ref hg38.fa \
    --gfa pangenome.gfa \
    --read [ont|hifi] \
    --threads 16
```

### 2. Graph-Based SV Detection (GAF-based)
Use this mode for reference-bias-free discovery or somatic variant detection. This requires reads to be aligned directly to the pangenome graph (typically using `minigraph`).

**Step A: Align reads to graph**
```bash
minigraph -cx lr --vc -t 64 pangenome.gfa sample.fasta > sample.gaf
```
*Note: The `--vc` flag is mandatory for SVPG compatibility.*

**Step B: Call variants**
```bash
svpg graph-call \
    --working_dir svpg_out/ \
    --ref hg38.fa \
    --gfa pangenome.gfa \
    --gaf sample.gaf \
    --read [ont|hifi] \
    -s 3
```

### 3. Pangenome Graph Augmentation
Use this mode to automatically detect de novo SVs and embed them back into the GFA file to update your pangenome.

```bash
svpg augment \
    --working_dir svpg_out/ \
    --ref hg38.fa \
    --gfa pangenome.gfa \
    --read hifi
```

## Expert Tips and Best Practices

### Minimum Support Thresholds
Adjust the `-s` or `--min_support` parameter based on your sequencing depth to balance sensitivity and precision.

| Depth | ONT Support | HiFi Support |
| :--- | :--- | :--- |
| < 10x | 2 | 1 |
| 10x - 20x | 3 | 2 |
| 20x - 50x | 4 | 3 |
| > 50x | 10 | 4 |

### Tumor/Normal Paired Analysis
For somatic SV discovery, run `graph-call` on both samples independently with different support thresholds, then use the provided utility script to isolate tumor-specific variants:

1. Run Tumor sample with `-s 3`.
2. Run Normal sample with `-s 1` (to ensure even low-evidence germline variants are captured for filtering).
3. Filter:
```bash
python scripts/vcf_specific.py tumor_out/variants.vcf normal_out/variants.vcf tumor_specific.vcf
```

### Filtering for High Confidence
In `call` mode, SVPG assigns genotypes. Filter the output VCF for `FILTER=PASS` to obtain the most reliable germline SV set.

### Input Preparation for Augmentation
When running `svpg augment`, you can provide a directory structure or a `.tsv` file. If using a TSV, ensure it follows the format:
```text
/path/to/sample_1.fasta
/path/to/sample_2.fasta
```

## Reference documentation
- [SVPG GitHub Repository](./references/github_com_coopsor_SVPG.md)
- [SVPG Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_svpg_overview.md)