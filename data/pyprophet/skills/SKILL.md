---
name: pyprophet
description: PyProphet processes SWATH-MS proteomics data by training semi-supervised classifiers to distinguish target peak groups from decoys and estimate false discovery rates. Use when user asks to score OpenSWATH results, merge multiple mass spectrometry runs, estimate peptide or protein-level FDR, and export proteomics data to TSV or Parquet formats.
homepage: https://github.com/PyProphet/pyprophet
metadata:
  docker_image: "quay.io/biocontainers/pyprophet:3.0.5--py311haab0aaa_0"
---

# pyprophet

## Overview

PyProphet is a high-performance Python re-implementation of the mProphet algorithm, specifically optimized for SWATH-MS data. It functions by training a semi-supervised classifier (typically Linear Discriminant Analysis or XGBoost) to distinguish between target peak groups and decoys. By calculating q-values and posterior error probabilities, it provides the statistical confidence necessary for large-scale proteomics studies. It is the standard post-processing tool for OpenSWATH outputs, enabling error rate control at the precursor, peptide, and protein levels.

## Installation

Install the stable version via pip or conda:

```bash
pip install pyprophet
# or
conda install -c bioconda pyprophet
```

## Common CLI Patterns

PyProphet operates through a series of subcommands. The typical workflow involves scoring, followed by FDR estimation at different levels.

### Scoring Results
The `score` command is the core of the tool. It trains the classifier on the input data.

```bash
# Basic scoring of an OpenSWATH file
pyprophet score --in=input.osw --out=scored.osw

# Scoring with a specific main score (e.g., for SRM data)
pyprophet score --in=input.osw --ss_main_score=hyperscore
```

### Merging Multiple Runs
For large cohorts, individual runs are often merged before global FDR estimation.

```bash
pyprophet merge --in=run1.osw run2.osw run3.osw --out=merged.osw
```

### FDR Estimation (Peptide and Protein Levels)
After scoring, calculate FDR at various biological levels to control for error rates across the entire dataset.

```bash
# Peptide-level FDR estimation
pyprophet peptide --in=scored.osw --context=global

# Protein-level FDR estimation
pyprophet protein --in=scored.osw --context=global
```

### Exporting Data
Convert the internal `.osw` (SQLite) format to human-readable TSV or high-performance Parquet files.

```bash
# Export to TSV for downstream analysis
pyprophet export --in=scored.osw --out=results.tsv

# Export to Parquet for large-scale data handling
pyprophet export --in=scored.osw --out=results.parquet
```

## Expert Tips and Best Practices

- **Context Selection**: Use `--context=run-specific` for individual run validation and `--context=global` when analyzing large cohorts to ensure consistency across samples.
- **Ion Mobility**: If working with ion mobility data (e.g., diaPASEF), ensure you are using PyProphet v3.0+ which includes centralized checks for `EXP_IM` and IM boundary columns in the feature table.
- **Classifier Weights**: You can apply pre-trained weights using the `--apply_weights` flag. Note that this often requires specifying the same `--ss_main_score` used during the original training.
- **Memory Management**: For very large datasets, consider using the `split_parquet` functionality or the `.oswpq` format to reduce the memory footprint during scoring and export.
- **XGBoost Integration**: PyProphet supports XGBoost as a classifier for non-linear scoring. This can be toggled via the `--classifier` flag in the `score` command.

## Reference documentation

- [PyProphet GitHub Repository](./references/github_com_PyProphet_pyprophet.md)
- [Bioconda PyProphet Overview](./references/anaconda_org_channels_bioconda_packages_pyprophet_overview.md)