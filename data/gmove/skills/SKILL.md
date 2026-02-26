---
name: gmove
description: gmove integrates genomic sequences with transcriptomic and proteomic evidence to predict and synthesize gene structures. Use when user asks to predict gene models, integrate RNA-seq or protein evidence into annotations, or filter gene structures based on specific biological constraints.
homepage: https://github.com/institut-de-genomique/Gmove
---


# gmove

## Overview

gmove is a gene modeling tool designed to integrate diverse biological evidence to predict gene structures. It processes genomic sequences alongside transcriptomic (RNA) and proteomic data to generate filtered gene models. It is ideal for researchers who have existing alignments or ab initio predictions and need a tool to synthesize these into a coherent annotation.

## Usage Instructions

### Basic Command Structure
The tool requires a reference genome in FASTA format and at least one source of evidence (typically RNA-seq data in GFF format).

```bash
gmove -f <genome.fasta> --rna <rna_evidence.gff> [options]
```

### Input Requirements
*   **Reference Sequence (-f):** A FASTA file containing the genome sequence.
*   **Evidence Files:** gmove accepts GFF2 or GFF3 files. It looks for specific tags in the 3rd column:
    *   `--rna` and `--prot`: Expects `exon` or `HSP`.
    *   `--annot` and `--abinitio`: Expects `CDS` or `UTR`.
*   **Data Integrity:** 
    *   Transcript/Protein IDs in the last column must be unique.
    *   Files must be sorted by genomic position (smallest position first).
    *   For negative strand features, ensure the "first" line in the file corresponds to the exon with the smallest genomic coordinate.

### Common CLI Options
*   **Output Format:** Use `-t` to output in GTF format (default is GFF3).
*   **Output Directory:** Use `-o <folder>` to specify the destination (default is `./out`).
*   **Filtering Models:**
    *   `-S`: Do not output single-exon models.
    *   `--cds <int>`: Set minimum CDS size (default is 100).
    *   `--ratio`: Require a minimum of 80% CDS/UTR ratio.
*   **Structural Constraints:**
    *   `-e <int>`: Minimum exon size (default: 9nt).
    *   `-i <int>`: Minimum intron size (default: 9nt).
    *   `-m <int>`: Maximum intron size (default: 50,000nt).
    *   `-b <int>`: Search window for start/stop codons around exon boundaries (default: 30nt).

### Expert Tips
*   **Raw Data Inspection:** Use the `--raw` flag to output all generated models into a `raw/` subfolder before filtering. This is useful for troubleshooting why certain expected models were excluded from the final `filter/` output.
*   **Splice Site Refinement:** If your evidence boundaries are slightly imprecise, use `-x <int>` to define a search region around "covtigs" boundaries to find better splice sites.
*   **Complexity Management:** For highly fragmented assemblies or dense evidence, adjust `-p <int>` (default 10,000) to limit the maximum number of paths calculated inside a connected component to prevent memory exhaustion.

## Reference documentation
- [gmove - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_gmove_overview.md)
- [GitHub - institut-de-genomique/Gmove: Gmove is a gene prediction tool](./references/github_com_institut-de-genomique_Gmove.md)