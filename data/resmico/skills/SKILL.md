---
name: resmico
description: ResMiCo (Residual Misassembly Corrector) is a deep learning framework designed to detect errors in metagenomic assemblies.
homepage: https://github.com/leylabmpi/ResMiCo
---

# resmico

## Overview

ResMiCo (Residual Misassembly Corrector) is a deep learning framework designed to detect errors in metagenomic assemblies. By analyzing features derived from re-aligning sequencing reads back to contigs, it provides a probability score (0 to 1) indicating the likelihood of a misassembly. This skill enables the systematic processing of metagenomic data from raw alignments to filtered, high-quality genomic sets.

## Core Workflow

### 1. Preparing the Input Map
Before running the CLI, create a tab-delimited `map.tsv` file to link your assemblies with their corresponding alignments.

**Required Columns:**
- `Taxon`: Unique name for the contig FASTA.
- `Fasta`: Path to the FASTA file.
- `Sample`: Unique name for the BAM file.
- `BAM`: Path to the sorted BAM file (reads mapped to the FASTA).

### 2. Feature Extraction
Convert BAM files into the feature tables required by the deep learning model.

```bash
resmico bam2feat --outdir features_output map.tsv
```
*   **Tip**: Ensure BAM files are indexed and sorted. The parameters used here should match those used during model training (the default settings align with the pre-trained "default" model).

### 3. Evaluating Assemblies
Run the prediction model on the generated features.

```bash
resmico evaluate \
  --feature-files-path features_output \
  --save-path results \
  --save-name my_predictions \
  --min-avg-coverage 1.0
```
*   **Critical Parameter**: `--min-avg-coverage`. For real-world data, a value of `1.0` is standard. Only lower this for testing or extremely low-depth samples.
*   **Performance**: Use a GPU whenever possible; CPU evaluation is significantly slower.
*   **Optimization**: Use `--dont-verify-insert-size` to skip redundant checks if you have already validated your library's insert size distribution.

### 4. Filtering Contigs
Generate a cleaned FASTA set by removing contigs that exceed a specific misassembly score.

```bash
resmico filter \
  --score-cutoff 0.5 \
  --outdir filtered_contigs \
  results/my_predictions.csv \
  path/to/original_contigs/*.fasta
```
*   **Score Interpretation**: A higher `--score-cutoff` is more permissive (fewer contigs removed), while a lower cutoff increases stringency.

## Expert Tips and Best Practices

- **Alignment Tooling**: The default ResMiCo model is optimized for data produced by **Bowtie2**. Using other aligners may impact prediction accuracy.
- **Environment Requirements**: ResMiCo requires Python 3.8+ and is sensitive to TensorFlow versions. It is recommended to run within a dedicated Conda environment.
- **Hardware**: While `resmico` can run on macOS (x86) and Linux, it does not currently support Apple Silicon (M1/M2/M3) due to TensorFlow dependencies.
- **Training**: If your data deviates significantly from standard metagenomic distributions (e.g., extreme GC content or non-Illumina reads), consider using `resmico train` to develop a niche-specific model.

## Reference documentation
- [ResMiCo GitHub Repository](./references/github_com_leylabmpi_ResMiCo.md)
- [ResMiCo Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_resmico_overview.md)