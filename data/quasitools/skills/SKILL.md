---
name: quasitools
description: Quasitools is a bioinformatics suite designed to analyze genetic diversity and evolutionary metrics within viral quasispecies populations using NGS data. Use when user asks to call nucleotide or amino acid variants, measure quasispecies complexity, calculate dN/dS ratios, or identify HIV drug resistance mutations.
homepage: https://github.com/phac-nml/quasitools/
metadata:
  docker_image: "quay.io/biocontainers/quasitools:0.7.0--py_0"
---

# quasitools

## Overview

Quasitools is a specialized bioinformatics suite designed for the study of viral populations, known as quasispecies. Unlike standard genomic tools that focus on a single consensus, quasitools characterizes the genetic diversity within a sample. It processes Next-Generation Sequencing (NGS) data to measure evolutionary metrics, calculate dN/dS ratios, and detect clinically relevant mutations. It is an essential tool for researchers working with highly variable viruses where low-frequency variants are biologically or medically significant.

## Common CLI Patterns

### Variant Calling
Identify variations between an NGS dataset (BAM) and a reference sequence (FASTA).

*   **Nucleotide Variants:**
    `quasitools call ntvar <sample.bam> <reference.fasta>`
*   **Amino Acid Variants:**
    `quasitools call aavar <sample.bam> <reference.fasta>`
*   **Codon Variants:**
    `quasitools call codonvar <sample.bam> <reference.fasta>`

### Quasispecies Complexity
Measure the diversity of the viral population.

*   **From Aligned Reads:**
    `quasitools complexity bam <sample.bam> <reference.fasta>`
*   **From Haplotypes:**
    `quasitools complexity fasta <haplotypes.fasta>`
*   **Filtering:** Use the frequency filter option in `complexity` to ignore low-frequency haplotypes that may be sequencing artifacts.

### Evolutionary Analysis
*   **Distance:** Calculate the angular cosine distance between multiple quasispecies to generate a distance matrix.
    `quasitools distance <sample1.bam> <sample2.bam> [sampleN.bam ...]`
*   **dN/dS:** Calculate the ratio of non-synonymous to synonymous substitutions per coding region.
    `quasitools dnds <codonvar_output> <regions.bed>`

### Specialized HIV Analysis (Hydra)
The `hydra` command is a high-level workflow specifically for identifying HIV drug resistance mutations. It performs quality control, mapping, and mutation calling in a single pipeline.
`quasitools hydra <reads.fastq> <reference.fasta>`

### Consensus and Coverage
*   **Generate Consensus:** Create a consensus sequence from a BAM file.
    `quasitools consensus <sample.bam> <reference.fasta>`
*   **Amino Acid Coverage:** Build an amino acid consensus and report coverage.
    `quasitools aacoverage <sample.bam> <reference.fasta>`

## Expert Tips and Best Practices

*   **Quality Control First:** Always run `quasitools quality <reads.fastq>` before analysis to perform quality control on raw FASTQ reads, especially if not using the integrated `hydra` pipeline.
*   **Reference Alignment:** Ensure your BAM files are sorted and indexed. Quasitools relies on accurate alignments to the provided reference FASTA.
*   **Output Formats:** Note that `call aavar` and `hydra` produce Amino Acid Variation Format (AAVF) files. These are standard for representing viral mutations and are preferred over the deprecated HMCF format.
*   **Handling Indels:** When using `complexity`, be aware that version 0.7.0+ includes specific fixes for parsing haplotypes with insertions and deletions (indels).
*   **Memory Management:** For large BAM files or many samples in `distance` calculations, ensure sufficient system memory as pileup generation can be resource-intensive.



## Subcommands

| Command | Description |
|---------|-------------|
| quasitools | A command-line tool for manipulating and analyzing quasigenomes. |
| quasitools aacoverage | This script builds an amino acid census and returns its coverage. The BAM alignment file corresponds to a pileup of sequences aligned to the REFERENCE. A BAM index file (.bai) must also be present and, except for the extension, have the same name as the BAM file. The REFERENCE must be in FASTA format. The BED4_FILE must be a BED file with at least 4 columns and specify the gene locations within the REFERENCE. The output is in CSV format. |
| quasitools call | Call nucleotide variants from a BAM file. |
| quasitools complexity | Reports the per-amplicon (fasta) or k-mer complexity of the pileup, for each k-mer position in the reference complexity (bam and reference) of a quasispecies using several measures outlined in the following work: |
| quasitools consensus | Generate consensus sequences from BAM files. |
| quasitools distance | Quasitools distance produces a measure of evolutionary distance [0 - 1] between quasispecies, computed using the angular cosine distance function defined below. |
| quasitools dnds | Calculate dN/dS ratios for coding sequences. |
| quasitools drmutations | Detects drug-resistant mutations from BAM files. |
| quasitools hydra | Generate a mixed base consensus sequence. |
| quasitools quality | Quasitools quality performs quality control on FASTQ reads and outputs the   filtered FASTQ reads in the specified directory. |

## Reference documentation
- [Quasitools README](./references/github_com_phac-nml_quasitools_blob_master_README.md)
- [Quasitools Changelog](./references/github_com_phac-nml_quasitools_blob_master_CHANGELOG.md)