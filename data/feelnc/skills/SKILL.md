---
name: feelnc
description: FEELnc is a bioinformatics pipeline for the automated annotation and classification of long non-coding RNAs from reconstructed transcripts. Use when user asks to filter transcripts against protein-coding exons, calculate coding potential using k-mer models, or classify lncRNAs based on their genomic localization.
homepage: https://github.com/tderrien/FEELnc
metadata:
  docker_image: "quay.io/biocontainers/feelnc:0.2--pl526_0"
---

# feelnc

## Overview

FEELnc (FlExible Extraction of LncRNA) is a specialized bioinformatics pipeline for the automated annotation of lncRNAs from reconstructed transcripts (e.g., from StringTie or Cufflinks). It operates through three primary stages: filtering out transcripts that overlap with known protein-coding exons, calculating the coding potential of candidates using a k-mer based model, and classifying the resulting lncRNAs based on their genomic relationship to neighboring genes (such as intergenic, antisense, or intronic).

## Core Modules and CLI Usage

The pipeline can be run as individual modules for fine-grained control or via a wrapper script for standard workflows.

### 1. Filtering (FEELnc_filter.pl)
Extracts candidate transcripts by removing those that overlap with reference protein-coding exons.

*   **Basic Pattern:**
    ```bash
    FEELnc_filter.pl -i transcripts.gtf -a reference_annotation.gtf > candidates.gtf
    ```
*   **Best Practice:** Always use the `--biotype` option to ensure you are only filtering against protein-coding mRNAs, preventing the accidental removal of known lncRNAs present in your reference.
    ```bash
    FEELnc_filter.pl -i transcripts.gtf -a reference.gtf -b transcript_biotype=protein_coding > candidates.gtf
    ```
*   **Stranded Data:** If using a stranded protocol, include antisense monoexonic transcripts which are often filtered by default.
    ```bash
    FEELnc_filter.pl -i transcripts.gtf -a reference.gtf --monoex=-1 > candidates.gtf
    ```

### 2. Coding Potential (FEELnc_codpot.pl)
Computes the probability of a transcript being non-coding.

*   **Standard Mode (with Genome):**
    ```bash
    FEELnc_codpot.pl -i candidates.gtf -a reference.gtf -g genome.fa --mode=shuffle
    ```
*   **De Novo/Reference-free:** If a reference genome is unavailable, this module can run directly on FASTA files.
*   **Performance:** Use the `-proc` argument (if available in your version) to specify the number of threads for k-mer counting.

### 3. Classification (FEELnc_classifier.pl)
Categorizes lncRNAs based on their genomic localization relative to other transcripts.

*   **Usage:**
    ```bash
    FEELnc_classifier.pl -i lncRNA.gtf -a reference.gtf > classification_results.txt
    ```
*   **Output:** This generates a detailed table describing the type of lncRNA (e.g., lincRNA, antisense, intronic) and the distance to the nearest partner gene.

### 4. Integrated Pipeline (FEELnc_pipeline.sh)
A wrapper script to execute all three steps in a single command.

```bash
FEELnc_pipeline.sh --candidate=transcripts.gtf \
                   --reference=reference.gtf \
                   --genome=genome.fa \
                   --outname=project_name \
                   --outdir=output_directory
```

## Expert Tips and Best Practices

*   **Reference Preparation:** When providing a reference GTF, it is highly recommended to subselect only `protein_coding` biotypes to serve as the "gold standard" for what is NOT a lncRNA.
*   **K-mer Shuffling:** The `--mode=shuffle` in `FEELnc_codpot.pl` is effective for generating a null model of coding potential by shuffling the input sequences while preserving k-mer frequencies.
*   **Environment Setup:** Ensure `PERL5LIB` is correctly exported to include the FEELnc `lib` directory, and that `KmerInShort` and `fasta_ushuffle` binaries are in your `PATH`.
*   **Input Formats:** Ensure your input GTF files follow standard formatting (9 columns). FEELnc is sensitive to the attribute column for biotype filtering.



## Subcommands

| Command | Description |
|---------|-------------|
| FEELnc_classifier.pl | Classifies lncRNAs based on their genomic context and overlap with protein-coding genes. |
| FEELnc_codpot.pl | FEELnc_codpot.pl is a tool for predicting lncRNA transcripts. |
| FEELnc_filter.pl | Filter candidate lncRNA transcripts based on a GTF annotation file. |
| FEELnc_pipeline.sh | FEELnc pipeline for transcript model annotation. |

## Reference documentation
- [FEELnc GitHub Repository](./references/github_com_tderrien_FEELnc.md)