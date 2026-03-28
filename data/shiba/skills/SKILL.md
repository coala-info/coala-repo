---
name: shiba
description: Shiba identifies alternative mRNA splicing patterns from bulk and single-cell RNA-seq alignments. Use when user asks to identify alternative splicing events, perform differential splicing analysis, or process bulk and single-cell RNA-seq data.
homepage: https://github.com/Sika-Zheng-Lab/Shiba
---


# shiba

## Overview

Shiba is a versatile computational framework designed for the systematic identification of alternative mRNA splicing. It streamlines the transition from raw alignments (BAM files) to biological insights by performing transcript assembly, splicing event identification, read counting, and statistical differential analysis. The tool is split into two primary interfaces: `shiba.py` for bulk RNA-seq and `scshiba.py` for single-cell RNA-seq. It is particularly effective for detecting complex splicing patterns, including alternative first/last exons (AFE/ALE), skipped exons (SE), and mutually exclusive exons (MXE).

## Core Workflows

### Bulk RNA-seq Analysis (Shiba)
The standard bulk workflow requires an experiment table (TSV) defining samples and groups, a reference genome annotation (GTF/GFF3), and aligned BAM files.

```bash
# Standard execution
shiba.py --experiment experiment.tsv --genefile annotation.gtf --outdir results/

# Lightweight analysis (MameShiba)
# Use this to run only splicing analysis without the full assembly pipeline
shiba.py --mame --experiment experiment.tsv --genefile annotation.gtf --outdir results/
```

### Single-Cell RNA-seq Analysis (scShiba)
For single-cell data, Shiba requires a barcode-to-group mapping file to aggregate reads and identify cluster-specific splicing.

```bash
scshiba.py --experiment experiment.tsv --barcode barcode_groups.tsv --genefile annotation.gtf --outdir sc_results/
```

## Expert Tips and Best Practices

- **Long-Read Support**: Shiba natively supports long-read data (PacBio/ONT). To enable this, ensure the `datatype` column in your experiment TSV is set to `long-read`.
- **Transcript Assembly**: Shiba uses StringTie for assembly. If you have a high-quality custom transcriptome, you can provide it via the `--genefile` argument to bypass the assembly step and focus on quantification.
- **Handling Low Variance**: In version 0.8.2+, Shiba handles NaN values in PCA analysis more robustly. If you encounter issues with PSI (Percent Spliced In) matrices, ensure you are using the latest version to benefit from improved KNN imputation.
- **Visualization**: 
    - Check `plots/pdf/barplot_splicing_summary.pdf` for a high-level count of DSEs.
    - Use the `summary.html` report for an interactive overview of all detected events.
    - For sashimi plots, use the companion tool `shiba2sashimi`.
- **Resource Management**: For large-scale single-cell datasets, ensure your environment has sufficient memory for the read-counting step, as scShiba aggregates junctions across barcodes.



## Subcommands

| Command | Description |
|---------|-------------|
| scshiba.py | scShiba v0.8.1 - Pipeline for identification of differential RNA splicing in single-cell RNA-seq data |
| shiba.py | Shiba v0.8.1 - Pipeline for identification of differential RNA splicing |

## Reference documentation
- [Shiba README](./references/github_com_Sika-Zheng-Lab_Shiba_blob_main_README.md)
- [Shiba Changelog](./references/github_com_Sika-Zheng-Lab_Shiba_blob_main_CHANGELOG.md)
- [Bulk RNA-seq Usage](./references/sika-zheng-lab_github_io_Shiba_usage_shiba.md)
- [Single-cell RNA-seq Usage](./references/sika-zheng-lab_github_io_Shiba_usage_scshiba.md)