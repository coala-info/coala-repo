---
name: dna-nn
description: "dna-nn uses deep learning to identify and annotate simple DNA sequence patterns such as centromeric satellites and repeats. Use when user asks to predict sequence features, evaluate model accuracy, or train new models for satellite DNA recognition."
homepage: https://github.com/lh3/dna-nn
---


# dna-nn

## Overview
The `dna-nn` package (primarily utilizing the `dna-brnn` executable) implements a deep-learning approach to recognize simple DNA sequence patterns. It is specifically optimized for identifying centromeric satellites and repeats that constitute a significant portion of the human genome. While it is exceptionally fast—capable of processing a human assembly in under two hours—it is a specialized tool best suited for satellites and Alu repeats rather than complex transposable elements like L1 repeats.

## Installation and Setup
The tool is available via Bioconda for easy environment integration:
```bash
conda install bioconda::dna-nn
```
If building from source, ensure `zlib` is installed and run `make` within the repository.

## Common CLI Patterns

### Predicting Sequence Features
To annotate a FASTA file using a pre-trained model (e.g., `attcc-alpha.knm`), use the following pattern. The output is a BED file where the 4th column indicates the feature type.

```bash
dna-brnn -Ai models/attcc-alpha.knm -t16 input.fa > output.bed
```
*   **-A**: Apply the model for prediction.
*   **-i**: Path to the trained `.knm` model file.
*   **-t**: Number of threads (scales well for large assemblies).

**Label Reference:**
*   **Label 1**: (ATTCC)n repeats.
*   **Label 2**: Alpha satellite repeats.

### Evaluating Model Accuracy
If you have a sequence with known ground truth (formatted as a FASTQ where base qualities represent labels), you can calculate the model's accuracy:

```bash
dna-brnn -Ei models/attcc-alpha.knm -t16 test_data.fa > /dev/null
```
*   **-E**: Evaluation mode. Accuracy metrics for each label will be printed to `stderr`.

### Training New Models
Training requires training data in a specific FASTQ format where the "quality string" actually contains the integer labels for each base.

```bash
dna-brnn -t8 -n32 -b5m -m50 -s14 -o new_model.knm training_data.fq
```
*   **-n**: Number of hidden neurons (default is often 32).
*   **-b**: Minibatch size (e.g., `5m` for 5 million).
*   **-m**: Maximum number of epochs.
*   **-s**: Random seed for reproducibility.
*   **-o**: Output path for the trained model.

## Expert Tips and Best Practices
*   **Input Preparation**: For training, use the provided `gen-fq` utility to convert BED annotations and FASTA sequences into the labeled FASTQ format required by `dna-brnn`.
*   **Performance**: `dna-brnn` is significantly faster than RepeatMasker. Use it as a first-pass filter for satellite DNA in large-scale pangenome projects to save days of compute time.
*   **Sensitivity Limits**: Be aware that while the tool is highly accurate for (ATTCC)n and alpha satellites, it has lower sensitivity for Beta satellites and generally fails to learn complex features like L1 repeats.
*   **Memory Management**: When training on very large datasets, adjust the minibatch size (`-b`) to fit your available RAM.

## Reference documentation
- [dna-nn GitHub Repository](./references/github_com_lh3_dna-nn.md)
- [dna-nn Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_dna-nn_overview.md)