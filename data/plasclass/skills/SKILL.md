---
name: plasclass
description: PlasClass classifies DNA sequences as either plasmid or chromosomal based on k-mer frequencies across multiple length scales. Use when user asks to distinguish between plasmid and chromosomal sequences, classify metagenomic fragments, or calculate plasmid probability scores for FASTA files.
homepage: https://github.com/Shamir-Lab/PlasClass
---


# plasclass

## Overview

PlasClass is a classification tool that distinguishes between plasmid and chromosomal sequences. It utilizes a set of logistic regression classifiers trained on k-mer frequencies at multiple sequence length scales. This multi-scale approach allows it to effectively classify sequences of varying lengths, which is common in fragmented metagenomic assemblies. The tool provides a plasmid probability score for each input sequence, where scores closer to 1.0 indicate a high likelihood of plasmid origin.

## Installation

The most efficient way to install PlasClass is via Bioconda:

```bash
conda install bioconda::plasclass
```

Alternatively, it can be installed from source using the `setup.py` script provided in the repository.

## Command Line Usage

The primary interface for classification is the `classify_fasta.py` script.

### Basic Classification
To classify sequences in a FASTA file and save the results:
```bash
python classify_fasta.py -f input.fasta -o output_scores.tsv
```

### Performance Optimization
For large datasets, use the `-p` flag to specify the number of parallel processes (default is 8):
```bash
python classify_fasta.py -f input.fasta -p 16
```

### Output Format
The output is a tab-separated file containing:
1. The sequence header from the FASTA file.
2. The plasmid probability score (0.0 to 1.0).

## Python API Integration

PlasClass can be integrated directly into Python workflows for programmatic classification.

```python
from plasclass import plasclass

# Initialize the classifier
# n_procs: number of processes (default 1)
my_classifier = plasclass.plasclass(n_procs=4)

# Classify a list of sequences (must be uppercase strings)
sequences = ["ATGC...", "GCTA..."]
scores = my_classifier.classify(sequences)

for seq, score in zip(sequences, scores):
    print(f"Sequence Score: {score}")
```

## Training Custom Models

If the default models are not suitable for your specific biological context, use `train.py` to build new ones.

```bash
python train.py -p plasmid_refs.fasta -c chromosome_refs.fasta -o ./my_models_dir/ -n 16
```

**Parameters for Training:**
- `-k`: Comma-separated k-mer sizes (default: 3,4,5,6,7).
- `-l`: Comma-separated sequence length scales (default: 1000, 10000, 100000, 500000).

*Note: If you use custom k-mer or length parameters during training, you must pass these same arrays to the `plasclass()` constructor in Python when using the model.*

## Expert Tips and Best Practices

- **Sequence Pre-processing**: Ensure sequences are in uppercase. While some versions may handle case conversion, providing uppercase strings prevents potential runtime errors or warnings.
- **Length Considerations**: PlasClass is designed to handle sequences across a wide range of lengths. If your assembly contains very short fragments (under 1kb), the classification may be less reliable as it falls below the smallest default training scale.
- **Score Interpretation**: A common threshold for plasmid identification is 0.5, but for high-confidence sets, users often use a threshold of 0.7 or 0.8.
- **Memory Management**: When using high values for `-p` (processes), ensure the system has sufficient RAM to handle multiple instances of the k-mer frequency matrices, especially for higher k-mer values (k=7).

## Reference documentation
- [PlasClass GitHub Repository](./references/github_com_Shamir-Lab_PlasClass.md)
- [Bioconda PlasClass Overview](./references/anaconda_org_channels_bioconda_packages_plasclass_overview.md)