---
name: muat
description: MuAt is a deep learning framework that classifies tumor types and subtypes by analyzing somatic mutation patterns like SNVs and MNVs. Use when user asks to download genomic datasets, preprocess mutation files, train new models, or run high-accuracy ensemble predictions on tumor samples.
homepage: https://github.com/primasanjaya/muat
---


# muat

## Overview
MuAt (Mutation Attention) is a deep learning framework specialized in classifying tumor types and subtypes by analyzing somatic mutation patterns, specifically Single Nucleotide Variants (SNVs) and Multi-Nucleotide Variants (MNVs). It utilizes an attention-based architecture to extract features from genomic data. This skill guides the execution of the MuAt pipeline, including data downloading, preprocessing, and running high-accuracy ensemble predictions.

## Command Line Interface
The `muat` tool uses a sub-command structure. Access help for any command using `muat <command> -h`.

### Core Commands
- `download`: Retrieve necessary datasets (e.g., PCAWG).
- `preprocess`: Convert raw genomic files into the tokenized format required by the model.
- `predict`: Run classification on individual samples.
- `predict-ensemble`: Execute predictions using the optimized MuAt ensemble models for higher reliability.
- `train`: Train a new MuAt model on custom or public datasets.

### Common Prediction Patterns
For Whole Genome Sequencing (WGS) data in VCF format, use the following patterns:

**Using hg19 Reference:**
```bash
muat predict wgs --hg19 /absolute/path/to/hg19.fa --mutation-type 'snv+mnv' --input-filepath /absolute/path/to/sample.vcf.gz --result-dir /absolute/path/to/results
```

**Using hg38 Reference:**
```bash
muat predict wgs --hg38 /absolute/path/to/hg38.fa --mutation-type 'snv+mnv' --input-filepath /absolute/path/to/sample.vcf.gz --result-dir /absolute/path/to/results
```

**Ensemble Prediction (Recommended for Accuracy):**
```bash
muat predict-ensemble muat-wgs --hg19 /absolute/path/to/hg19.fa --mutation-type 'snv+mnv' --input-filepath /absolute/path/to/sample.vcf.gz --result-dir /absolute/path/to/results
```

### Working with Preprocessed Data
If you have already run the preprocessing step, you can skip it during prediction to save time:
```bash
muat predict wgs --no-preprocessing --mutation-type 'snv+mnv' --input-filepath /absolute/path/to/sample.token.gc.genic.exonic.cs.tsv.gz --result-dir /absolute/path/to/results
```

## Expert Tips and Best Practices
- **Absolute Paths**: Always use absolute paths for `--hg19`, `--hg38`, `--input-filepath`, and `--result-dir`. Relative paths often cause execution failures in the underlying processing scripts.
- **Mutation Types**: Ensure the `--mutation-type` argument is quoted (e.g., `'snv+mnv'`) to prevent shell expansion issues.
- **Environment Activation**: Always ensure the conda environment is active (`conda activate muat-env`) before execution to ensure all deep learning dependencies (PyTorch/TensorFlow) are available.
- **VCF Compatibility**: MuAt is optimized for consensus somatic mutation calls. Ensure your VCFs are properly filtered for somatic variants before running prediction.

## Reference documentation
- [Mutation Attention Tool Overview](./references/anaconda_org_channels_bioconda_packages_muat_overview.md)
- [MuAt GitHub Repository and Quick Start](./references/github_com_primasanjaya_muat.md)