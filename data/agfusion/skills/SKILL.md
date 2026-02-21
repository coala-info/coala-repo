---
name: agfusion
description: "AGFusion is a tool for visualizing and annotating gene fusions. (Note: The provided text appears to be a system error log regarding a container build failure and does not contain help text or argument definitions.)"
homepage: https://github.com/murphycj/AGFusion
---

# agfusion

## Overview

AGFusion (Annotate Gene Fusion) is a bioinformatics tool designed to provide functional context to gene fusion events. While many tools detect fusions, AGFusion specializes in the downstream analysis: determining if a fusion is in-frame or out-of-frame, predicting the resulting protein sequence, and visualizing how protein domains are preserved or lost. It supports Ensembl-based annotation for human (GRCh37/38) and mouse (GRCm38) genomes.

## Installation and Database Setup

Before running annotations, you must install the package and download the necessary genomic and AGFusion-specific databases.

1. **Install AGFusion**: `pip install agfusion`
2. **Install PyEnsembl dependency**: `pyensembl install --species homo_sapiens --release 95`
3. **Download AGFusion Database**: `agfusion download -g hg38`
   * Use `agfusion download -a` to see all available species and releases.

## Common CLI Patterns

### Annotating a Single Fusion
The `annotate` command is the primary interface for individual fusion events. You must provide the 5' and 3' gene partners and their respective genomic junction coordinates.

```bash
agfusion annotate \
  --gene5prime DLG1 \
  --gene3prime BRAF \
  --junction5prime 31684294 \
  --junction3prime 39648486 \
  -db agfusion.mus_musculus.87.db \
  -o DLG1-BRAF_output
```

### Batch Processing from Fusion Finders
AGFusion can directly parse output files from common fusion-calling algorithms using the `batch` command.

```bash
agfusion batch \
  -f final-list_candidate-fusion-genes.txt \
  -a fusioncatcher \
  -db agfusion.homo_sapiens.95.db \
  -o batch_output
```
*Supported algorithms include: Arriba, STAR-Fusion, FusionCatcher, EricScript, JAFFA, deFuse, and others.*

## Expert Tips and Customization

### Visualization Enhancements
* **Wild-Type Comparison**: Use the `--WT` flag to generate plots of the normal (wild-type) protein and exon structures alongside the fusion for comparison.
* **Non-canonical Isoforms**: By default, AGFusion only processes canonical isoforms. Use `--noncanonical` to include all isoform combinations.
* **Publication Quality**:
  * **Recolor Domains**: `--recolor "Domain_Name;red"`
  * **Rename Domains**: `--rename "Long_Domain_Name;ShortName"`
  * **Consistent Scaling**: Use `--scale [integer]` (e.g., 2000) across multiple runs to ensure that different fusion proteins are drawn with appropriate relative lengths.

### Troubleshooting
* **Missing cDNA Warnings**: If you see warnings about missing sequences, ensure your `pyensembl` version is up to date and the database is correctly installed.
* **SSL Errors on macOS**: If `agfusion download` fails with a certificate error, run the "Install Certificates.command" found in your Python application folder.

## Reference documentation
- [AGFusion GitHub Repository](./references/github_com_murphycj_AGFusion.md)
- [Bioconda AGFusion Overview](./references/anaconda_org_channels_bioconda_packages_agfusion_overview.md)