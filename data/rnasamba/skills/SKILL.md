---
name: rnasamba
description: RNAsamba is a deep-learning-based tool designed to classify RNA transcripts as either protein-coding or non-coding.
homepage: https://github.com/apcamargo/RNAsamba
---

# rnasamba

## Overview

RNAsamba is a deep-learning-based tool designed to classify RNA transcripts as either protein-coding or non-coding. Unlike traditional tools that rely on hand-crafted features, RNAsamba utilizes a neural network to calculate a coding score based on the sequence itself. It is particularly effective for analyzing de novo assembled transcriptomes where transcripts may be incomplete. Use this skill when you need to annotate a transcriptome, filter non-coding RNAs, or extract translated protein sequences from genomic or transcriptomic data.

## Installation

RNAsamba can be installed via bioconda or pip:

```bash
# Using Conda
conda install -c conda-forge -c bioconda rnasamba

# Using Pip
pip install rnasamba
```

## Classification Workflow

The `classify` command is the primary entry point for most users. It requires a FASTA file of transcripts and one or more pre-trained weight files (HDF5 format).

### Basic Classification
To classify sequences and save the results to a TSV file:

```bash
rnasamba classify results.tsv input_transcripts.fa weights.hdf5
```

### Extracting Protein Sequences
To automatically extract and translate the predicted coding ORFs into a FASTA file, use the `-p` or `--protein_fasta` flag:

```bash
rnasamba classify -p predicted_proteins.fa results.tsv input_transcripts.fa weights.hdf5
```

### Model Selection
RNAsamba provides two standard pre-trained models based on human data that generalize well across species:
- **full_length_weights.hdf5**: Best for high-quality, complete transcript sequences (e.g., RefSeq/Ensembl annotations).
- **partial_length_weights.hdf5**: Best for fragmented data, such as *de novo* transcriptomes or ESTs.

### Ensembling Models
You can improve classification robustness by providing multiple weight files. RNAsamba will ensemble the predictions:

```bash
rnasamba classify results.tsv input.fa model1.hdf5 model2.hdf5
```

## Training a Custom Model

If the pre-trained models are insufficient for your specific organism or data type, you can train a new model using known coding and non-coding sequences.

```bash
rnasamba train -v 2 custom_model.hdf5 coding_sequences.fa noncoding_sequences.fa
```

### Training Best Practices
- **Early Stopping**: Use `-s` or `--early_stopping` to prevent overfitting. This stops training after a specified number of epochs without improvement in validation loss.
- **Batch Size**: The default is 128. Adjust with `-b` if you encounter memory constraints.
- **Verbosity**: Use `-v 2` to see a progress bar during the training process.

## Output Format

The output TSV file contains three columns:
1. **sequence_name**: The header from the input FASTA.
2. **coding_score**: A value between 0 and 1 (higher means more likely to be coding).
3. **classification**: A binary label ("coding" or "noncoding") based on a 0.5 threshold.

## Reference documentation
- [RNAsamba GitHub Repository](./references/github_com_apcamargo_RNAsamba.md)
- [RNAsamba Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_rnasamba_overview.md)