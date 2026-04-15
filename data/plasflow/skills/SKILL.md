---
name: plasflow
description: PlasFlow identifies plasmid sequences within metagenomic contigs using deep learning models trained on k-mer frequencies. Use when user asks to identify plasmids in metagenomic data, classify contigs as plasmid or chromosome, or recover mobile genetic elements from assemblies.
homepage: https://github.com/smaegol/PlasFlow
metadata:
  docker_image: "quay.io/biocontainers/plasflow:1.1.0--py35_0"
---

# plasflow

## Overview

PlasFlow is a specialized tool for identifying plasmid sequences within metagenomic contigs. It utilizes deep learning models trained on k-mer frequencies to distinguish between plasmids and chromosomes with high accuracy. This skill should be applied during the post-assembly phase of a metagenomics pipeline to recover mobile genetic elements that are often difficult to identify using traditional homology-based methods.

## Installation and Environment

The recommended way to use PlasFlow is via Conda to manage its specific dependency requirements (Python 3.5 and TensorFlow 0.10).

```bash
# Create and activate environment
conda create --name plasflow python=3.5
source activate plasflow

# Install PlasFlow
conda install plasflow -c smaegol
```

## Core Workflow

### 1. Pre-filtering Sequences
PlasFlow's k-mer based approach is unreliable for short sequences. You must filter your assembly to include only contigs longer than 1000 bp to ensure prediction quality and reduce memory consumption.

```bash
filter_sequences_by_length.pl -input assembly.fasta -output filtered_assembly.fasta -thresh 1000
```

### 2. Running Prediction
Execute the main classification script on the filtered fasta file.

```bash
PlasFlow.py --input filtered_assembly.fasta --output predictions.tsv --threshold 0.7
```

### Key Arguments:
- `--input`: Path to the input FASTA file.
- `--output`: Path for the resulting TSV file containing classifications.
- `--threshold`: The probability threshold for filtering predictions (default is 0.7). Higher values increase precision but may reduce recall.
- `--batch_size`: Adjust this if you encounter memory issues on large datasets.

## Interpreting Results

The primary output is a tabular (.tsv) file. Key columns include:
- **contig_id**: The header from the input FASTA.
- **contig_length**: Length of the sequence.
- **label**: The classification (e.g., plasmid, chromosome, or unclassified).
- **probability**: The confidence score of the neural network prediction.

## Expert Tips

- **Memory Management**: If the process crashes on large datasets, decrease the `--batch_size` or ensure you have strictly filtered out short contigs (under 1000bp), as short contigs significantly increase the computational overhead without providing reliable data.
- **Taxonomic Context**: PlasFlow provides classifications into several taxonomic groups. Use these labels to cross-reference with other binning tools (like MetaBAT2 or MaxBin2) to validate plasmid-host associations.
- **Unclassified Sequences**: Sequences with probabilities below the `--threshold` are marked as "unclassified." If you have a high number of these, consider if your assembly has low-quality contigs or if the organisms in your sample are highly divergent from the training set.

## Reference documentation
- [PlasFlow GitHub Repository](./references/github_com_smaegol_PlasFlow.md)
- [Bioconda PlasFlow Overview](./references/anaconda_org_channels_bioconda_packages_plasflow_overview.md)