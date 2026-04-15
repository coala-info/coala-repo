---
name: qiime
description: QIIME 2 is a microbiome bioinformatics platform used to analyze high-throughput community sequencing data through a plugin-based command line interface. Use when user asks to import sequencing data, denoise reads into feature tables, perform taxonomic classification, or calculate diversity metrics.
homepage: https://github.com/YongxinLiu/QIIME2ChineseManual
metadata:
  docker_image: "quay.io/biocontainers/qiime:1.9.1--py27_0"
---

# qiime

## Overview
QIIME 2 (Quantitative Insights Into Microbial Ecology) is a decentralized microbiome bioinformatics platform. This skill enables the execution of complex multi-step procedures for analyzing high-throughput community sequencing data (such as 16S, 18S, and ITS rRNA genes). It focuses on the native Command Line Interface (CLI), helping users navigate the plugin-based architecture to transform raw sequencing reads into interpretable visualizations and statistical results while maintaining data provenance.

## Core CLI Concepts
QIIME 2 operates on two main file types:
- **.qza (Artifacts)**: Compressed data files containing data and provenance metadata.
- **.qzv (Visualizations)**: Files intended for human viewing (can be viewed at [view.qiime2.org](https://view.qiime2.org)).

### Command Structure
Every command follows a consistent pattern:
`qiime <plugin> <method> --i-<input-name> <input.qza> --p-<parameter-name> <value> --o-<output-name> <output.qza>`

## Common Workflow Patterns

### 1. Data Import and Visualization
Before processing, data must be converted into a QIIME 2 Artifact.
- **Importing Fastq (Manifest format):**
  ```bash
  qiime tools import \
    --type 'SampleData[PairedEndSequencesWithQuality]' \
    --input-path manifest.csv \
    --output-path paired-end-demux.qza \
    --input-format PairedEndFastqManifestPhred33V2
  ```
- **Summarizing Data:**
  ```bash
  qiime demux summarize \
    --i-data paired-end-demux.qza \
    --o-visualization demux.qzv
  ```

### 2. Denoising and Feature Table Generation
Using DADA2 to filter noise and generate Amplicon Sequence Variants (ASVs).
```bash
qiime dada2 denoise-paired \
  --i-demultiplexed-seqs paired-end-demux.qza \
  --p-trim-left-f 0 \
  --p-trim-left-r 0 \
  --p-trunc-len-f 240 \
  --p-trunc-len-r 200 \
  --o-table table.qza \
  --o-representative-sequences rep-seqs.qza \
  --o-denoising-stats stats.qza
```

### 3. Taxonomic Classification
Assigning identities to sequences using a pre-trained Naive Bayes classifier.
```bash
qiime feature-classifier classify-sklearn \
  --i-classifier silva-138-99-nb-classifier.qza \
  --i-reads rep-seqs.qza \
  --o-classification taxonomy.qza
```

### 4. Diversity Analysis
Calculating alpha and beta diversity metrics.
```bash
qiime diversity core-metrics-phylogenetic \
  --i-phylogeny rooted-tree.qza \
  --i-table table.qza \
  --p-sampling-depth 10000 \
  --m-metadata-file sample-metadata.tsv \
  --output-dir core-metrics-results
```

## Expert Tips
- **Metadata Validation**: Always run `qiime metadata tabulate --m-metadata-file your-metadata.tsv --o-visualization metadata-check.qzv` to ensure your metadata is formatted correctly before running diversity analyses.
- **Parallelization**: Many plugins (like DADA2 and Feature Classifier) support the `--p-n-threads` parameter. Set this to `0` to use all available cores.
- **Filtering**: Use `qiime feature-table filter-samples` or `filter-features` to remove low-frequency data or specific taxa (e.g., Mitochondria/Chloroplast) before downstream analysis.
- **Provenance**: If you receive a `.qza` file and don't know how it was made, use `qiime tools inspect-metadata <file.qza>` or view it in the online viewer to see the entire command history.

## Reference documentation
- [QIIME 2中文文档 (Main README)](./references/github_com_YongxinLiu_QIIME2ChineseManual.md)