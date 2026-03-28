---
name: homopolish
description: Homopolish is a genome polisher that uses Support Vector Machines and homologous sequences to correct systematic errors and improve assembly quality. Use when user asks to polish genome assemblies, correct homopolymer errors, or improve assembly accuracy using homologous sequence retrieval.
homepage: https://github.com/ythuang0522/homopolish
---

# homopolish

## Overview

Homopolish is a specialized genome polisher that utilizes Support Vector Machines (SVM) and homologous sequence retrieval to push assembly quality toward Q50-Q90 (>99.999% accuracy). It is designed to be the final stage in a polishing pipeline—typically following Racon and Medaka for Nanopore data, or directly after Flye assembly for PacBio CLR data. It works by scanning Mash sketches of known genomes to find closely related sequences, which then guide the correction of systematic sequencing errors.

## Installation and Setup

Install via Conda or Mamba for the most stable environment:

```bash
mamba create -n homopolish -c conda-forge -c bioconda -c defaults python=3.8 homopolish=0.4.1
```

### Required Resources
Before polishing, download the appropriate Mash sketches for your organism type:
- **Bacteria**: `http://bioinfo.cs.ccu.edu.tw/bioinfo/downloads/Homopolish_Sketch/bacteria.msh.gz`
- **Virus**: `http://bioinfo.cs.ccu.edu.tw/bioinfo/downloads/Homopolish_Sketch/virus.msh.gz`
- **Fungi**: `http://bioinfo.cs.ccu.edu.tw/bioinfo/downloads/Homopolish_Sketch/fungi.msh.gz`

Always unzip the sketch (`gunzip <file>.msh.gz`) before use.

## Core Polishing Workflows

### Standard Homopolymer Polishing
Use the `polish` command to correct indel errors. You must provide an assembly, a Mash sketch, and the pre-trained model corresponding to your sequencing chemistry.

**Nanopore R9.4 Example:**
```bash
homopolish polish -a assembly.fasta -s bacteria.msh -m R9.4.pkl -o output_dir
```

**PacBio CLR Example:**
```bash
homopolish polish -a assembly.fasta -s bacteria.msh -m pb.pkl -o output_dir
```

### Polishing with Local Genomes
If you have specific, closely-related private genomes, use the `-l` flag instead of a Mash sketch to improve accuracy.
```bash
homopolish polish -a assembly.fasta -l local_references.fasta -m R9.4.pkl -o output_dir
```

### Correcting Modification-Mediated Errors
Use the `modpolish` submodule for ONT data to correct errors caused by base modifications. This requires the original sequencing reads (FASTQ) or a BAM file.

```bash
homopolish modpolish -a assembly.fasta -q reads.fastq -m R9.4.pkl -s bacteria.msh -o output_dir
```

## Expert Tips and Best Practices

- **Model Selection**: Ensure the `.pkl` model matches your flowcell. Use `R9.4.pkl` for R9.4 chemistry, `R10.3.pkl` for R10.3, and `pb.pkl` for PacBio CLR.
- **Pipeline Order**: For Nanopore, always run `Racon` (multiple rounds) and `Medaka` before `Homopolish`. Homopolish is a "finisher" and performs best on already-refined drafts.
- **Autosearch vs. Manual Genus**: Avoid using the `-g` (genus) flag unless autosearch fails. The default autosearch algorithm is generally more effective at finding the most relevant strains for polishing.
- **Performance**: Use the `-t` flag to specify threads (e.g., `-t 8`) to speed up the homologous sequence retrieval and SVM processing.
- **Memory Management**: The bacteria Mash sketch is large (~3.3GB). Ensure the system has sufficient RAM to load the sketch into memory during the search phase.



## Subcommands

| Command | Description |
|---------|-------------|
| homopolish make_train_data | Make training data for homopolish by aligning reference genomes to assembly genomes and downloading homologous sequences. |
| homopolish modpolish | A tool for polishing genome assemblies using mash sketches and local databases. |
| homopolish polish | Homopolish is a tool for polishing genome assemblies using homologous sequences. |
| homopolish train | Train a model for homopolish using alignment dataframes. |

## Reference documentation
- [Homopolish Main Documentation](./references/github_com_ythuang0522_homopolish_blob_master_README.md)
- [Environment and Dependencies](./references/github_com_ythuang0522_homopolish_blob_master_environment.yml.md)