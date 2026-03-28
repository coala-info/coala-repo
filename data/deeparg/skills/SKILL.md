---
name: deeparg
description: DeepARG uses deep learning to identify and quantify antibiotic resistance genes in metagenomic and genomic sequences. Use when user asks to predict antimicrobial resistance genes from protein or nucleotide sequences, download the required reference database, or process short reads through a specialized pipeline.
homepage: https://bitbucket.org/gusphdproj/deeparg-ss/
---

# deeparg

## Overview
DeepARG is a computational framework that utilizes deep learning to characterize and quantify antibiotic resistance genes (ARGs) in environmental and clinical samples. It overcomes the limitations of traditional alignment-based methods by using a neural network to identify ARGs even with low sequence identity to known functional variants. This skill provides the necessary command-line patterns to execute predictions on raw sequences (reads) or assembled contigs/proteins.

## Core Workflows

### Data Preparation
DeepARG requires a local database to be initialized before the first run.
```bash
deeparg download_data -o /path/to/database/
```

### Predicting ARGs
The `predict` command is the primary entry point for annotation. It supports both nucleotide (DNA) and protein (AA) sequences.

**From Protein Sequences (High Confidence):**
Use this when you have predicted ORFs or protein FASTA files.
```bash
deeparg predict \
    --input /path/to/input.fasta \
    --output /path/to/output_prefix \
    --model-dir /path/to/database/ \
    --type protein \
    --data-path /path/to/database/
```

**From Nucleotide Sequences (Reads/Contigs):**
DeepARG will internally use Diamond to align sequences against the database before classification.
```bash
deeparg predict \
    --input /path/to/input.fasta \
    --output /path/to/output_prefix \
    --model-dir /path/to/database/ \
    --type genes \
    --data-path /path/to/database/
```

### Key Parameters and Optimization
- `--prob`: Probability threshold (default 0.8). Increase to 0.9 or higher for high-confidence annotations in clinical settings.
- `--identity`: Identity threshold (default 50%). Lowering this allows the deep learning model to capture more divergent ARGs that traditional BLAST might miss.
- `--min-length`: Minimum length of the sequence (default 40). Useful for filtering out short, noisy reads in metagenomic datasets.

## Best Practices
- **Database Sync**: Ensure the version of the `deeparg-ss` (the software) matches the version of the downloaded database to avoid compatibility errors in the neural network layers.
- **Input Types**: Always specify `--type genes` for DNA sequences and `--type protein` for amino acid sequences. Using the wrong type will result in zero hits or execution errors.
- **Output Interpretation**: Focus on the `.mapping.ARG` output file, which provides the best-hit classification along with the deep learning probability score.



## Subcommands

| Command | Description |
|---------|-------------|
| deeparg download_data | Download data for deeparg |
| deeparg predict | Predicts antimicrobial resistance genes from sequence data. |
| deeparg short_reads_pipeline | Pipeline for short reads to predict ARGs and 16S rRNA genes. |

## Reference documentation
- [DeepARG Bitbucket Repository](./references/bitbucket_org_gusphdproj_deeparg-ss.md)
- [Bioconda DeepARG Package](./references/anaconda_org_channels_bioconda_packages_deeparg_overview.md)