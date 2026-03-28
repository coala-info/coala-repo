---
name: dna-nn
description: dna-nn is a deep-learning toolkit that uses neural networks to learn, predict, and annotate sequence-level features in DNA. Use when user asks to predict genomic features with pre-trained models, train new models on custom sequence labels, or evaluate model accuracy.
homepage: https://github.com/lh3/dna-nn
---


# dna-nn

## Overview
dna-nn is a deep-learning toolkit designed to learn and predict sequence-level features in DNA. It primarily utilizes Bidirectional Recurrent Neural Networks (BRNN) and Convolutional Neural Networks (CNN) to classify genomic regions. The tool is highly optimized for speed, capable of annotating a human genome for specific satellites in under 1.5 hours on a standard multi-core CPU. While it comes with pre-trained models for human (ATTCC)n and alpha satellites, it can be trained on any sequence feature where ground-truth labels can be provided at the base level.

## Command Line Usage

### Predicting Features with Pre-trained Models
To find repeats in a FASTA file using the provided BRNN model:
```bash
./dna-brnn -Ai models/attcc-alpha.knm -t16 input_sequences.fa > output_annotations.bed
```
*   **-A**: Apply the model (prediction mode).
*   **-i**: Path to the trained `.knm` model file.
*   **-t**: Number of CPU threads to use.

**Output Interpretation (BED 4th Column):**
*   `1`: Indicates an (ATTCC)n repeat region.
*   `2`: Indicates an alpha satellite region.

### Training a New Model
Training requires a FASTQ file where the "base quality" characters represent the integer labels for each base.

1.  **Prepare Training Data**: Convert a reference FASTA and a truth BED file into the required FASTQ format:
    ```bash
    ./gen-fq -m2 reference.fa truth_annotations.bed > training_data.fq
    ```

2.  **Execute Training**:
    ```bash
    ./dna-brnn -t8 -n32 -b5m -m50 -o new_model.knm training_data.fq
    ```
    *   **-n**: Number of hidden neurons (e.g., 32 or 64).
    *   **-b**: Process a specific number of nucleotides per epoch (e.g., 5m for 5 million).
    *   **-m**: Maximum number of training epochs.
    *   **-o**: Output filename for the trained model.

### Evaluating Model Accuracy
To check the performance of a model against a known truth set (in FASTQ format):
```bash
./dna-brnn -Ei models/attcc-alpha.knm -t16 evaluation_data.fq > /dev/null
```
*   **-E**: Evaluation mode. Accuracy per label will be reported to `stderr`.

## Expert Tips and Best Practices
*   **Architecture Selection**: Use `dna-brnn` for most classification tasks as the bidirectional context generally provides higher sensitivity for biological motifs compared to the CNN implementation.
*   **Memory Management**: For very large assemblies, ensure you have sufficient RAM, though `dna-nn` is designed to be more memory-efficient than traditional alignment-based repeat maskers.
*   **Labeling Strategy**: When training, ensure your labels are mutually exclusive. If a base could belong to multiple categories, prioritize the most specific feature or create a combined label.
*   **RepeatMasker Integration**: A common workflow is to use RepeatMasker on a small subset of data to generate "truth" labels, then train `dna-nn` to annotate the rest of the massive dataset at a fraction of the computational cost.



## Subcommands

| Command | Description |
|---------|-------------|
| dna-brnn | Reads a sequence file and performs training or prediction using a recurrent neural network. |
| gen-fq | Generate FASTQ from FASTA and BED files. |

## Reference documentation
- [dna-nn README](./references/github_com_lh3_dna-nn_blob_master_README.md)
- [dna-brnn Source and Options](./references/github_com_lh3_dna-nn_blob_master_dna-brnn.c.md)
- [dna-cnn Source and Options](./references/github_com_lh3_dna-nn_blob_master_dna-cnn.c.md)