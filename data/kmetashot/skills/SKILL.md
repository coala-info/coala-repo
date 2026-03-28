---
name: kmetashot
description: kMetaShot is a high-performance taxonomic classifier that uses k-mer and minimizer counting to profile Metagenome-Assembled Genomes. Use when user asks to classify MAGs, perform taxonomic profiling of microbial communities, or assign taxonomy to genomic bins from superkingdom to strain level.
homepage: https://github.com/gdefazio/kMetaShot
---

# kmetashot

## Overview

kMetaShot is a high-performance taxonomic classifier designed specifically for Metagenome-Assembled Genomes (MAGs). It bypasses traditional sequence alignment in favor of a k-mer and minimizer counting strategy, comparing query sequences against a comprehensive HDF5-formatted reference database derived from RefSeq prokaryotic genomes. This approach allows for rapid and reliable profiling of microbial communities, providing assignments from superkingdom down to the strain level.

## Installation and Setup

kMetaShot is primarily distributed via Bioconda.

```bash
# Create environment and install
conda create --name kmetashot kmetashot -c bioconda
conda activate kmetashot
```

### Reference Database
The tool requires a specific HDF5 reference file (approx. 22GB). You must download the latest release from Zenodo or HuggingFace before running classifications.
- **2025 Release**: `kMetaShot_bacteria_archaea_2025-05-22.h5`
- **2022 Release**: `kMetaShot_reference.h5`

## Command Line Usage

The primary classification script is `kMetaShot_classifier_NV.py`.

### Basic Classification
To classify a directory of bins:
```bash
kMetaShot_classifier_NV.py -b ./my_bins/ -r ./path/to/reference.h5 -p 8 -o ./results
```

### Key Arguments
- `-b, --bins_dir`: Path to a directory containing `.fa`, `.fasta`, or `.fna` files (supports `.gz`). Alternatively, a single multi-fasta file where each header represents a bin.
- `-r, --reference`: Path to the downloaded HDF5 reference file.
- `-p, --processes`: Number of parallel processes. **Warning**: Increasing parallelism significantly increases RAM usage as the reference is loaded into shared memory.
- `-a, --ass2ref`: A float between 0 and 1 (default 0). This filters assignments based on the ratio of MAG minimizers to the reference strain's minimizers. Higher values increase precision but may reduce sensitivity.
- `-o, --out_dir`: Directory where results and intermediate CSV files will be stored.

## Expert Tips and Best Practices

### Memory Management
kMetaShot utilizes shared memory to handle the large reference database. 
- **Docker Users**: You must run the container with `--shm-size=22g` (or higher) to prevent crashes during reference loading.
- **Resource Planning**: Ensure the host system has at least 32GB of RAM available to accommodate the reference and the overhead of multiple processes.

### Validation
Always verify your installation and reference path using the provided test script before starting large-scale production runs:
```bash
kMetaShot_test.py -r /path/to/kMetaShot_reference.h5
```

### Interpreting Results
The tool generates several files in the output directory:
- `kMetaShot_classification_resume.csv`: The primary summary of taxonomic assignments.
- `all_ass2ref.csv`: Detailed statistics for all potential matches.
- `ass2ref.csv`: Specific ratios used for the final strain-level assignment.

### Input Flexibility
If you have a single large file containing multiple MAGs, kMetaShot treats each entry (header) as an individual bin. This is useful for processing output from binning refinement tools that concatenate results.



## Subcommands

| Command | Description |
|---------|-------------|
| kMetaShot_classifier_NV.py | kMetaShot is able to taxonomically classiy bins/MAGs and long reads by using an alignment free and k-mer/minimizer based approach. |
| kmetashot_kMetaShot_test.py | kMetaShot installation test |

## Reference documentation
- [kMetaShot README](./references/github_com_gdefazio_kMetaShot_blob_master_README.md)
- [Classifier Script Documentation](./references/github_com_gdefazio_kMetaShot_blob_master_kMetaShot_classifier_NV.py.md)