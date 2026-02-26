---
name: bttoxin_digger
description: bttoxin_digger is a specialized pipeline for the automated discovery and annotation of toxin genes in *Bacillus thuringiensis* genomes. Use when user asks to identify toxin profiles, mine virulence factors from raw reads or protein sequences, or generate a distribution matrix of toxins across multiple bacterial strains.
homepage: https://github.com/liaochenlanruo/BtToxin_Digger/blob/master/README.md
---


# bttoxin_digger

## Overview
bttoxin_digger is a specialized pipeline designed for the automated discovery of toxin genes in *Bacillus thuringiensis*. It streamlines the workflow from raw sequencing data to annotated toxin profiles by integrating genome assembly, ORF prediction, and homology-based searching against an updated database of virulence factors. It is particularly useful for large-scale comparative genomics where users need to generate a matrix of toxin distributions across multiple bacterial strains.

## Core CLI Usage
The tool is typically invoked via the `BtToxin_Digger` command. It requires a path to input sequences and a definition of the sequence type.

### Basic Command Structure
```bash
BtToxin_Digger --SeqPath <path_to_dir> --SequenceType <type> [options]
```

### Common Parameters
- `--SeqPath`: Directory containing your input files.
- `--SequenceType`: Type of input data. Options: `nucl` (nucleotides/genomes), `prot` (protein sequences), `reads` (raw sequencing data).
- `--Scaf_suffix`: The file extension for your genome files (e.g., `.fna`, `.fasta`, `.scaffolds.fa`).
- `--CPU`: Number of threads to use for multi-threaded steps (HMMER, BLAST).

## Workflow Patterns

### 1. Mining from Assembled Genomes
When you have a collection of `.fna` files in a directory:
```bash
BtToxin_Digger --SeqPath ./my_genomes/ --SequenceType nucl --Scaf_suffix .fna
```

### 2. Mining from Raw Reads
If starting from raw sequencing data, the tool utilizes its internal PGCGAP integration to perform assembly before mining:
```bash
BtToxin_Digger --SeqPath ./raw_data/ --SequenceType reads
```

### 3. Mining from Protein Sequences
For pre-predicted proteomes:
```bash
BtToxin_Digger --SeqPath ./proteomes/ --SequenceType prot --Scaf_suffix .faa
```

## Expert Tips and Best Practices
- **Batch Processing**: The tool is designed for high-throughput. Ensure all files in the `--SeqPath` share the same extension defined in `--Scaf_suffix` to avoid skipping samples.
- **Database Scope**: Beyond standard Cry/Cyt/Vip toxins, the tool searches for a wide array of factors including Sip, Chitinase, InhA, Bmp1, and newer classifications like App, Gpp, and Tpp.
- **Output Analysis**:
    - Check the generated **matrix file** for a summary of virulence factors across all processed strains.
    - The pipeline produces a centralized file containing both the metadata and the sequences of all identified toxins, which is ideal for downstream phylogenetic analysis.
- **Environment Setup**: If running via source, ensure `libsvm` and `NCBI-blast+` are in your system PATH, as the tool calls these binaries directly.

## Reference documentation
- [BtToxin_Digger README](./references/github_com_liaochenlanruo_BtToxin_Digger_blob_master_README.md)
- [bttoxin_digger Overview](./references/anaconda_org_channels_bioconda_packages_bttoxin_digger_overview.md)