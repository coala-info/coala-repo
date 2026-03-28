---
name: deepbgc
description: DeepBGC uses deep learning to identify and classify biosynthetic gene clusters in genomic sequences. Use when user asks to detect novel secondary metabolite clusters, train custom BGC models, or prepare Pfam domain annotations from genomic data.
homepage: https://github.com/Merck/DeepBGC
---


# deepbgc

## Overview
DeepBGC is a specialized bioinformatics tool that leverages Bidirectional Long Short-Term Memory (Bi-LSTM) networks and Pfam protein domain embeddings to mine genomes for secondary metabolite clusters. Unlike traditional rule-based tools, it can identify novel BGCs that do not strictly follow known biosynthetic patterns. It provides a complete pipeline from raw sequence to annotated BGCs, including integration with antiSMASH for visualization.

## Installation and Setup
Before running the pipeline, ensure the environment is prepared and models are downloaded.

```bash
# Install via Conda (Python 3.7 is required)
conda create -n deepbgc python=3.7 hmmer prodigal
conda activate deepbgc
pip install deepbgc

# Download required trained models and Pfam database
deepbgc download
```

## Core Workflows

### Standard Detection Pipeline
The `pipeline` command is the primary entry point. It automatically handles protein prediction (Prodigal) and Pfam domain identification (HMMER) if the input is a raw FASTA.

```bash
# Run detection on a FASTA sequence
deepbgc pipeline my_sequence.fa --output_dir ./results

# Run on a pre-annotated GenBank file (faster as it skips Prodigal/HMMER)
deepbgc pipeline my_annotated_genome.gbk --output_dir ./results
```

### Custom Model Usage
If you have trained a specific detector or classifier on niche data, provide the path to the `.pkl` model file.

```bash
deepbgc pipeline --detector path/to/my_detector.pkl input.fa
```

### Training and Data Preparation
To train custom models, sequences must be converted to Pfam TSV format.

```bash
# Prepare Pfam TSV from genomic sequence
deepbgc prepare my_sequence.fa --output pfam_table.tsv

# Prepare Pfam TSV from protein FASTA
deepbgc prepare --protein my_proteins.faa --output pfam_table.tsv
```

## Expert Tips and Best Practices
- **antiSMASH Integration**: DeepBGC 0.1.23+ generates an `antismash.json` file in the output folder. Upload this to the antiSMASH web server using "Upload extra annotations" to visualize DeepBGC scores alongside standard antiSMASH predictions.
- **Input Formats**: While FASTA is supported, providing a GenBank file with existing `CDS` and `db_xref="Pfam:..."` annotations significantly reduces runtime by bypassing the HMMER search.
- **Hardware**: Deep learning inference is performed via TensorFlow. Ensure your environment has sufficient memory for the LSTM layers, especially when processing large multi-contig assemblies.
- **Version Constraint**: DeepBGC requires Python 3.6 or 3.7. It is incompatible with Python 3.8+ due to its dependency on TensorFlow < 2.0.



## Subcommands

| Command | Description |
|---------|-------------|
| deepbgc prepare | Prepare genomic sequence by annotating proteins and Pfam domains. |
| deepbgc train | Train a BGC detector/classifier on a set of BGC samples. |
| deepbgc_download | Download trained models and other file dependencies to the DeepBGC downloads directory. |
| pipeline | Run DeepBGC pipeline: Preparation, BGC detection, BGC classification and generate the report directory. |

## Reference documentation
- [DeepBGC GitHub Repository](./references/github_com_Merck_deepbgc.md)
- [DeepBGC README and Usage](./references/github_com_Merck_deepbgc_blob_master_README.md)