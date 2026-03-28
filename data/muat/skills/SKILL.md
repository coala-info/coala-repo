---
name: muat
description: The Mutation Attention tool identifies tumor origins and subtypes by analyzing somatic mutation patterns from whole genome sequencing data. Use when user asks to predict tumor types from VCF files, perform ensemble predictions for higher accuracy, or preprocess genomic data for deep learning analysis.
homepage: https://github.com/primasanjaya/muat
---

# muat

## Overview
The Mutation Attention (muat) tool is a specialized deep learning framework designed to identify tumor origins and subtypes based on somatic mutation patterns. It processes Whole Genome Sequencing (WGS) data to provide high-accuracy predictions. This skill provides the necessary CLI patterns for prediction, ensemble analysis, and data preparation, ensuring consistent execution across different genomic reference versions.

## Core CLI Patterns

### Tumor Type Prediction
The most common use case is predicting the tumor type from a somatic VCF file.

**For hg19 Reference:**
```bash
muat predict wgs \
  --hg19 /path/to/hg19.fa \
  --mutation-type 'snv+mnv' \
  --input-filepath '/path/to/sample.vcf.gz' \
  --result-dir ./results
```

**For hg38 Reference:**
```bash
muat predict wgs \
  --hg38 /path/to/hg38.fa \
  --mutation-type 'snv+mnv' \
  --input-filepath '/path/to/sample.vcf.gz' \
  --result-dir ./results
```

### High-Accuracy Ensemble Prediction
To achieve better performance using the best-performing MuAt ensemble models:
```bash
muat predict-ensemble muat-wgs \
  --hg19 /path/to/hg19.fa \
  --mutation-type 'snv+mnv' \
  --input-filepath '/path/to/sample.vcf.gz' \
  --result-dir ./results
```

### Processing Preprocessed Data
If the data has already been converted to the internal tokenized format (`.tsv.gz`), skip the heavy preprocessing step:
```bash
muat predict wgs \
  --no-preprocessing \
  --mutation-type 'snv+mnv' \
  --input-filepath '/path/to/sample.token.gc.genic.exonic.cs.tsv.gz' \
  --result-dir ./results
```

## Expert Tips & Best Practices
- **Path Management**: Always use **absolute paths** for reference genomes (`.fa`) and input files. Relative paths often cause execution failures in the underlying deep learning environment.
- **Mutation Types**: Ensure the `--mutation-type` matches your VCF content. The standard for most tumor classification tasks is `'snv+mnv'`.
- **Reference Matching**: The tool is sensitive to the reference genome version. Ensure the VCF was called against the same version (hg19 vs hg38) provided in the command line arguments.
- **Environment**: Always ensure the `muat-env` conda environment is active before execution to provide access to the necessary deep learning libraries.



## Subcommands

| Command | Description |
|---------|-------------|
| muat download | Download datasets. |
| muat predict | Predicts variants from sequencing data. |
| muat train | Train a model |
| muat_predict-ensemble | Predicts variants using an ensemble of models. |
| muat_preprocess | Preprocess VCF, SomAgg VCF, or TSV files with specified genome build and optional dictionaries. |

## Reference documentation
- [Mutation Attention README](./references/github_com_primasanjaya_muat_blob_main_README.md)
- [Preprocessing Guide](./references/github_com_primasanjaya_muat_blob_main_documentation_README_preprocessing.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_muat_overview.md)