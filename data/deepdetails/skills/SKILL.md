---
name: deepdetails
description: DeepDETAILS (Deep-learning-based DEconvolution of Tissue profiles with Accurate Interpretation of Locus-specific Signals) is a computational framework that extracts cell-type-specific regulatory maps from bulk sequencing libraries.
homepage: https://details.yulab.org
---

# deepdetails

## Overview

DeepDETAILS (Deep-learning-based DEconvolution of Tissue profiles with Accurate Interpretation of Locus-specific Signals) is a computational framework that extracts cell-type-specific regulatory maps from bulk sequencing libraries. It uses deep learning to bridge the gap between bulk tissue signals and single-cell resolution, allowing researchers to visualize and analyze how regulatory elements like histone modifications or transcription initiation sites behave in specific cell populations within a complex tissue.

## Installation

Install the tool via Bioconda:
```bash
conda install bioconda::deepdetails
```

## Core Workflow

### 1. Data Preparation
Before deconvolution, you must compile your bulk and reference data into a unified HDF5 dataset.

**Required Inputs:**
- **Bulk:** Forward and reverse strand bigWig files (`.bw`) and peak regions (`.bed`).
- **Reference:** scATAC-seq fragments (tabular) and cell type annotations (barcode/cellType mapping).
- **Genome:** Reference FASTA and chromosome sizes file.

**Command Pattern:**
```bash
deepdetails prep-data \
  --bulk-pl bulk_forward.bw \
  --bulk-mn bulk_reverse.bw \
  --regions bulk_peaks.bed \
  --fragments ref_fragments.tsv.gz \
  --barcodes cell_annotations.tsv \
  --accessible-regions atac_peaks.bed \
  --save-to ./dataset_folder \
  --genome-fa genome.fasta \
  --chrom-size hg38.chrom.sizes
```

### 2. Deconvolution
Run the deconvolution process. **Note:** This step requires a GPU.

```bash
deepdetails deconv \
  --dataset ./dataset_folder \
  --save-to ./results \
  --study-name my_sample \
  --save-preds
```

### 3. Generating Visualization Tracks
To view the deconvolved signals in a genome browser (like IGV or UCSC), convert the predictions back to bigWig format.

```bash
deepdetails build-bw \
  -p ./results/my_sample.predictions.h5 \
  --save-to ./tracks \
  --chrom-size hg38.chrom.sizes
```

## Expert Tips and Troubleshooting

### Handling GPU Out-of-Memory (OOM) Errors
If you encounter `torch.cuda.OutOfMemoryError`, apply these optimizations:
- **Reduce Batch Size:** The default is 32. Try `--batch-size 16` or `--batch-size 8`.
- **Model Selection:** Use the fused version instead of the sequence-only model (ensure you do **not** add the `--seq` flag).
- **Simplify Reference:** Aggregate highly similar cell types to reduce the total number of deconvolution targets.

### Input Formatting
- **Strand Specificity:** Ensure your bulk bigWig files are truly strand-specific. If you only have BAM files, use `bamCoverage` with `--filterRNAstrand` to generate the required `pl.bw` and `mn.bw` files.
- **Barcode Matching:** Ensure the cell barcodes in your fragments file exactly match those in your annotation file. If using ArchR, you may need to strip sample prefixes (e.g., `Sample#Barcode` to `Barcode`).

## Reference documentation
- [Deconvolve your samples](./references/details_yulab_org_howto.md)
- [Frequently asked questions](./references/details_yulab_org_faq.md)
- [deepdetails - bioconda](./references/anaconda_org_channels_bioconda_packages_deepdetails_overview.md)