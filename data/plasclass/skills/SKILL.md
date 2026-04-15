---
name: plasclass
description: PlasClass is a machine learning tool that classifies DNA sequences as either plasmid or chromosomal in origin. Use when user asks to distinguish between plasmid and chromosomal DNA, classify metagenomic contigs, or assign plasmid probability scores to FASTA sequences.
homepage: https://github.com/Shamir-Lab/PlasClass
metadata:
  docker_image: "quay.io/biocontainers/plasclass:0.1.1--pyhdfd78af_0"
---

# plasclass

## Overview
PlasClass is a machine learning-based tool designed to distinguish between plasmid and chromosomal DNA sequences. It is particularly effective for classifying contigs in metagenomic assemblies where the origin of a sequence is unknown. The tool utilizes multiple logistic regression classifiers trained on different sequence length scales and k-mer frequencies (typically k=3 to 7) to assign a plasmid probability score to each input sequence.

## Command Line Usage

The primary interface for classification is the `classify_fasta.py` script.

### Basic Classification
To classify sequences in a FASTA file using default settings:
```bash
python classify_fasta.py -f input.fasta -o output_scores.tsv
```

### Performance Optimization
By default, the tool uses 8 processes. Adjust this based on your available CPU cores to speed up the k-mer counting and classification steps:
```bash
python classify_fasta.py -f input.fasta -p 16
```

### Output Format
The output is a tab-separated values (TSV) file where:
- Column 1: Sequence header from the FASTA file.
- Column 2: Plasmid score (0.0 to 1.0).
- **Interpretation**: Scores closer to 1.0 indicate a high probability of plasmid origin, while scores closer to 0.0 indicate chromosomal origin.

## Python API Integration

For integration into custom bioinformatics pipelines, use the `plasclass` module directly.

```python
from plasclass import plasclass

# Initialize the classifier (n_procs sets parallelization)
c = plasclass.plasclass(n_procs=4)

# Classify a list of uppercase DNA strings
sequences = ["ATGC...", "GCTA..."]
probabilities = c.classify(sequences)

for seq, prob in zip(sequences, probabilities):
    print(f"Sequence probability: {prob}")
```

## Training Custom Models
If the default models are not suitable for your specific taxonomic niche, use `train.py` to build a new model:
```bash
python train.py -p plasmids.fasta -c chromosomes.fasta -o ./my_model_dir -n 16
```
*Note: If you use custom k-mer lengths (-k) or sequence scales (-l) during training, you must pass these same arrays to the `plasclass()` constructor when loading the model.*

## Expert Tips
- **Sequence Case**: The underlying classification engine requires uppercase sequences. While the CLI script automatically converts sequences and issues a warning, ensure your input strings are uppercase when using the Python API to avoid errors.
- **Length Sensitivity**: PlasClass uses different models for different sequence lengths (1kb, 10kb, 100kb, 500kb). It is most accurate when sequences fall within or near these trained scales.
- **Metagenomic Assemblies**: When processing large metagenomic assemblies, it is often more efficient to filter out very short contigs (e.g., <1000bp) before classification, as k-mer signatures in very short fragments can be noisy.



## Subcommands

| Command | Description |
|---------|-------------|
| classify_fasta.py | Classify fasta sequences as plasmid or chromosomal. |
| plasclass_train.py | Train the PlasClass classifier using plasmid and chromosome sequences. |

## Reference documentation
- [PlasClass README](./references/github_com_Shamir-Lab_PlasClass_blob_master_README.md)
- [Classification Script Details](./references/github_com_Shamir-Lab_PlasClass_blob_master_classify_fasta.py.md)