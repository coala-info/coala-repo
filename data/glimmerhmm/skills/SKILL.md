---
name: glimmerhmm
description: GlimmerHMM is a gene-finding system that predicts protein-coding genes and exon-intron boundaries in eukaryotic genomic sequences using a Generalized Hidden Markov Model. Use when user asks to predict genes in eukaryotic genomes, annotate genomic FASTA sequences, or identify splice sites and start/stop codons.
homepage: https://github.com/kblin/glimmerhmm
metadata:
  docker_image: "quay.io/biocontainers/glimmerhmm:3.0.4--pl5321h503566f_10"
---

# glimmerhmm

## Overview
GlimmerHMM is a gene-finding system based on a Generalized Hidden Markov Model (GHMM) designed for eukaryotic genomes. It identifies protein-coding genes by predicting splice sites, start/stop codons, and exon-intron boundaries. Use this skill when you need to annotate genomic FASTA sequences with predicted gene coordinates, particularly for organisms where pre-trained models exist or when you have generated a custom training directory.

## Command Line Usage

The basic syntax for running GlimmerHMM is:
```bash
glimmerhmm <fasta_file> -d <training_directory> [options]
```

### Common Execution Patterns

1.  **Predicting genes in Arabidopsis:**
    ```bash
    glimmerhmm sequence.fasta -d /path/to/GlimmerHMM/trained_dir/arabidopsis/
    ```

2.  **Predicting genes in Human (General):**
    If the GC content of the sequence is unknown, use the general human training directory:
    ```bash
    glimmerhmm sequence.fasta -d /path/to/GlimmerHMM/trained_dir/human
    ```

3.  **Predicting genes in Human (Isochore-specific):**
    For better accuracy in human sequences, select a training directory based on the local GC content (isochore):
    *   **0-43% GC:** `-d /path/to/trained_dir/human/Train0-43`
    *   **43-51% GC:** `-d /path/to/trained_dir/human/Train43-51`
    *   **51-57% GC:** `-d /path/to/trained_dir/human/Train51-57`
    *   **57-100% GC:** `-d /path/to/trained_dir/human/Train57-100`

    *Example for a 39% GC sequence:*
    ```bash
    glimmerhmm sequence.fasta -d /path/to/GlimmerHMM/trained_dir/human/Train0-43
    ```

## Best Practices and Tips

*   **Training Directory:** The `-d` flag is mandatory. It must point to a directory containing the species-specific parameter files (e.g., `topol`, `transition`, `weight`).
*   **GC Content Analysis:** Before running human gene prediction, calculate the GC content of your input FASTA to select the most appropriate isochore model for significantly improved prediction accuracy.
*   **Custom Training:** To use GlimmerHMM on a species other than Arabidopsis, rice, or human, you must first generate a training directory. This involves running `make` in the `train` directory of the source and following the `readme.train` instructions.
*   **Platform Compatibility:** While pre-compiled binaries for Linux (32-bit) are often provided in the `bin` directory, it is recommended to compile from source using `make` in the `sources` directory for modern 64-bit Unix/Linux environments.

## Reference documentation
- [GlimmerHMM GitHub Repository](./references/github_com_kblin_glimmerhmm.md)