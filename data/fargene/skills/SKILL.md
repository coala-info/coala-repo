---
name: fargene
description: fARGene identifies and reconstructs full-length antibiotic resistance genes from fragmented metagenomic reads, contigs, or protein sequences. Use when user asks to detect antibiotic resistance genes, perform targeted assembly of resistance fragments, or analyze metagenomic data for specific resistance categories like beta-lactamases.
homepage: https://github.com/fannyhb/fargene
metadata:
  docker_image: "quay.io/biocontainers/fargene:0.1--py27h5ca1d4c_2"
---

# fargene

## Overview

fARGene (Fragmented Antibiotic Resistance Gene iENntifiEr) is a bioinformatics tool used to detect and reconstruct complete antibiotic resistance genes from various types of sequencing data. While many tools only identify fragments, fARGene is optimized to deliver full-length gene sequences as output. It is particularly effective for analyzing fragmented metagenomic data (short reads) by performing targeted assembly, but it also supports longer contigs and protein sequences.

## Core Workflows

### 1. Fragmented Metagenomic Data (Short Reads)
When working with raw paired-end FASTQ files, you must use the `--meta` flag. This triggers the assembly process (typically using SPAdes) to reconstruct the genes.

```bash
fargene -i /path/to/reads/*.fastq --meta --hmm-model class_a -o output_dir -p 8
```

### 2. Genomic Sequences or Long Contigs
For pre-assembled contigs or complete genomes in FASTA format, omit the `--meta` flag.

```bash
fargene -i /path/to/contigs.fasta --hmm-model class_a -o output_dir
```

### 3. Protein Sequences
If the input consists of amino acid sequences, use the `--protein` flag.

```bash
fargene -i /path/to/proteins.fasta --protein --hmm-model class_a -o output_dir
```

## Pre-defined HMM Models

fARGene includes several optimized models. Use the string identifier with the `--hmm-model` flag:

| Resistance Category | Model Identifiers |
| :--- | :--- |
| **Beta-lactamases** | `class_a`, `class_b_1_2`, `class_b_3`, `class_c`, `class_d_1`, `class_d_2` |
| **Quinolones** | `qnr` |
| **Tetracycline** | `tet_efflux`, `tet_rpg`, `tet_enzyme` |
| **Macrolides** | `erm_type_a`, `erm_type_f`, `mph` |
| **Aminoglycosides** | `aminoglycoside_model_a` through `aminoglycoside_model_i` |

## Expert Tips and Best Practices

- **Parallelization**: Always use the `-p` flag when processing metagenomic data to utilize multiple CPU cores, as the assembly step is computationally intensive.
- **Custom Models**: You can provide your own HMM file. When doing so, you must manually specify the bit-score thresholds:
  - Use `--score` for long sequences.
  - Use `--meta-score` for fragmented data (expressed as score per amino acid).
- **Handling Dependencies**: fARGene relies on external tools like HMMER, SPAdes, and seqtk. If these are not in your PATH, the tool will fail. If you lack specific optional dependencies like Trim Galore! or ORFfinder, use the `--no-quality-filtering` or `--no-orf-prediction` flags respectively.
- **Output Inspection**: The tool generates a `results_summary.txt` in the output directory, which is the best place to start reviewing identified genes before diving into the FASTA files.

## Reference documentation
- [fARGene GitHub Repository](./references/github_com_fannyhb_fargene.md)
- [fARGene Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_fargene_overview.md)