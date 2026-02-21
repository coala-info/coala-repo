---
name: svhip
description: svhip is a machine learning pipeline designed to detect conserved RNA secondary structures across genomes.
homepage: https://github.com/chrisBioInf/Svhip
---

# svhip

## Overview
svhip is a machine learning pipeline designed to detect conserved RNA secondary structures across genomes. It is particularly useful for researchers looking to distinguish between functional non-coding RNAs and protein-coding regions within genomic alignments. The tool operates through a modular workflow: preparing training features from known sequences, training a classifier, preprocessing target alignments into overlapping windows, and finally performing classification.

## Core Workflows

### 1. Generating Training Data (`data`)
Use this task to create a feature set (TSV) from known coding and non-coding sequences.
- **Requirement**: Requires Clustal Omega (`clustalo`) for alignment.
- **Negative Sets**: By default, it uses SISSIz. If SISSIz is not installed, use `--shuffle-control` to fall back to column-based shuffling.
- **Key Pattern**:
  ```bash
  python svhip.py data --coding ./coding_seqs/ --noncoding ./nc_seqs/ -o features.tsv -n 100 -l 120 -w 40
  ```
- **Tip**: Use `--max-id 0.95` to remove highly redundant sequences that might bias the model.

### 2. Training the Model (`train`)
Train a Random Forest (RF), Support Vector Machine (SVM), or Logistic Regression (LR) classifier.
- **Optimization**: Always enable `--optimize-hyperparameters` for better performance, especially with SVMs.
- **Strategy**: Use `--optimizer randomwalk` for a faster search than `gridsearch`.
- **Key Pattern**:
  ```bash
  python svhip.py train -i features.tsv -o my_model -M RF --optimize-hyperparameters
  ```

### 3. Preparing Alignments (`windows`)
Before prediction, slice long alignments into manageable, overlapping windows.
- **Identity Filtering**: Use `--min-id` and `--max-id` to ensure the windows contain enough sequence variation for structural signal detection without being too divergent to align reliably.
- **Key Pattern**:
  ```bash
  python svhip.py windows -i input.aln -o windows.aln -l 120 -s 80 --opt-id 0.8 -n 6
  ```

### 4. Running Predictions (`predict`)
Classify windows as coding, non-coding, or other.
- **MAF Support**: If using `.maf` files, svhip preserves genomic coordinates.
- **Strand Sensitivity**: The tool can scan both strands of the alignment.
- **Key Pattern**:
  ```bash
  python svhip.py predict -i windows.aln -m my_model.pkl -H hexamer_models/Human_hexamer.tsv -o results.tsv
  ```

## Expert Tips
- **Thread Management**: svhip defaults to `CPU_COUNT - 1`. For high-throughput genomic scans, ensure your environment has sufficient memory as structural feature calculation is memory-intensive.
- **Hexamer Models**: Use the `hexcalibrate` task to create species-specific hexamer frequency models if the provided human/model organism defaults are not taxonomically appropriate for your data.
- **Structural Filtering**: If you are getting too many "other" (intergenic/random) hits, ensure `--no-structural-filter` is NOT set to True, as the statistical significance of the structure is a primary filter for functional RNA.

## Reference documentation
- [svhip GitHub Repository](./references/github_com_chrisBioInf_svhip.md)
- [Bioconda svhip Overview](./references/anaconda_org_channels_bioconda_packages_svhip_overview.md)