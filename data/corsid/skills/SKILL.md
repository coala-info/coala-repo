---
name: corsid
description: CORSID identifies transcription regulatory sequences and gene boundaries in coronavirus genomes. Use when user asks to identify TRS sites, predict viral gene architecture, or validate existing annotations in unannotated or annotated coronavirus FASTA sequences.
homepage: http://github.com/elkebir-group/CORSID
metadata:
  docker_image: "quay.io/biocontainers/corsid:0.1.3--pyh5e36f6f_0"
---

# corsid

## Overview

CORSID (Core Sequence Identifier) is a specialized bioinformatics tool designed for the coronavirus research domain. It automates the discovery of TRS sites and gene boundaries, which are critical for understanding viral transcription. Use this skill when you need to process FASTA sequences to predict viral architecture or validate existing annotations against predicted TRS alignments. The tool provides two primary workflows: one for de novo identification in unannotated genomes and another for targeted TRS identification in genomes with known gene locations.

## CLI Usage and Patterns

### Core Commands

*   **corsid**: Use for unannotated genomes to identify TRS-L, TRS-Bs, and genes simultaneously.
*   **corsid_a**: Use when gene locations are already known to identify the most likely TRS-L and TRS-B sites.

### Common Command Patterns

**1. De Novo Identification (Unannotated Genome)**
Identify genes and TRS sites from a raw FASTA file:
```bash
corsid -f genome.fasta -o results.json > report.txt
```

**2. Identification with Validation**
Use an existing GFF3 file to validate the genes identified by the tool:
```bash
corsid -f genome.fasta -g annotation.gff3 -o results.json > report.txt
```

**3. Targeted TRS Identification (Annotated Genome)**
Find TRS sites for specific known genes:
```bash
corsid_a -f genome.fasta -g annotation.gff3 -o results.json > report.txt
```

## Input and Output Specifications

### Required Inputs
*   **FASTA (-f)**: The complete coronavirus genome sequence.
*   **GFF3 (-g)**: Required for `corsid_a`; optional for `corsid` (used for validation).

### Primary Outputs
*   **JSON (-o)**: Contains sorted solutions and auxiliary information. This file is the standard input for the CORSID-viz web application.
*   **GFF3**: Generated automatically using the same basename as the JSON output. It contains the annotated genes of the optimal solution.
*   **Standard Output (stdout)**: Contains human-readable tables of solutions and visualizations of TRS alignments. Always redirect this to a text file for reference.

## Expert Tips and Best Practices

*   **Solution Ranking**: CORSID sorts solutions lexicographically based on (1) genome coverage, (2) total matching score, and (3) minimum score. The first solution in the JSON/GFF3 output is the mathematically optimal one.
*   **Capturing Visualizations**: The tool outputs alignment visualizations directly to stdout. To preserve these for analysis, ensure you use shell redirection (`> output.txt`).
*   **Handling Incomplete Genomes**: For genomes missing the TRS-L (5' leader TRS), ensure you are using version 0.1.3 or later, which utilizes an XGBoost model to classify and handle incomplete sequences.
*   **GFF3 Formatting**: When providing an input GFF3 for validation or `corsid_a`, ensure the coordinates are 1-based and the file follows standard GFF3 specifications. The tool is sensitive to attribute casing but generally supports standard VADR or RefSeq GFF formats.

## Reference documentation
- [CORSID GitHub Repository](./references/github_com_elkebir-group_CORSID.md)
- [CORSID Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_corsid_overview.md)