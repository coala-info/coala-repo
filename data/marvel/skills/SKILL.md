---
name: marvel
description: MARVEL identifies bacteriophage sequences within metagenomic bins using functional annotation and protein domain searching. Use when user asks to predict phage genomes from metagenomic bins, adjust classification confidence thresholds, or filter bins by size.
homepage: http://github.com/quadram-institute-bioscience/marvel/
metadata:
  docker_image: "quay.io/biocontainers/marvel:0.2--py39hdfd78af_4"
---

# marvel

## Overview
MARVEL (Metagenomic Analysis and Retrieval of Viral Elements) is a specialized tool for the identification of bacteriophage sequences within metagenomic datasets. Unlike general viral discovery tools, MARVEL is optimized to work with "bins"—groups of contigs likely belonging to the same organism—to predict which bins represent draft phage genomes. It leverages Prokka for functional annotation and HMMER for protein domain searching to inform its classification model.

## Usage Patterns

### Basic Phage Prediction
To run the standard prediction pipeline on a set of genomic bins:
```bash
marvel -i /path/to/bins_folder -o /path/to/output_directory -t 8
```
*   **Input**: A directory containing bins in `.fa` or `.fasta` format.
*   **Threads**: Use `-t` to specify CPU threads for Prokka and hmmscan.

### Adjusting Sensitivity and Specificity
*   **Confidence Threshold**: Use `-c` (default 0.7) to adjust the random forest probability threshold. Higher values increase precision; lower values increase recall.
    ```bash
    marvel -i ./bins -o ./results -c 0.9
    ```
*   **Minimum Bin Size**: Use `-m` (default 2000) to filter out small bins that may not contain enough information for accurate classification.
    ```bash
    marvel -i ./bins -o ./results -m 5000
    ```

### Setup and Maintenance
Before the first run, or if models are missing, ensure the database is initialized:
```bash
python3 download_and_set_models.py
```

### Expert Tips
*   **Intermediate Files**: Use the `--keep` flag if you need to inspect the Prokka annotations or HMMER outputs for specific bins.
*   **Force Overwrite**: If re-running an analysis on the same output directory, use `-f` to overwrite existing results.
*   **Binning Requirement**: MARVEL expects data that has already been processed by a binning tool (like MetaBAT2 or MaxBin2). Do not provide raw assembly contigs directly unless they are organized into single-fasta files per "bin".

## Reference documentation
- [MARVEL GitHub Repository](./references/github_com_quadram-institute-bioscience_MARVEL.md)
- [Bioconda Marvel Overview](./references/anaconda_org_channels_bioconda_packages_marvel_overview.md)