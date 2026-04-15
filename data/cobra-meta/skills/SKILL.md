---
name: cobra-meta
description: COBRA is a post-assembly tool that joins fragmented viral contigs into more complete scaffolds using k-mer overlap and paired-end read linkage. Use when user asks to rescue fragmented viral genomes, extend contigs after assembly, or join viral scaffolds using coverage and mapping data.
homepage: https://github.com/linxingchen/cobra
metadata:
  docker_image: "quay.io/biocontainers/cobra-meta:1.2.3--pyhdfd78af_0"
---

# cobra-meta

## Overview

COBRA (Contig Overlap Based Re-Assembly) is a post-assembly tool designed to rescue fragmented viral genomes. It operates on the principle that assemblers using de Bruijn graphs often break at specific points (repeats or population variations) despite having a deterministic "expected overlap length" based on the k-mer size used. COBRA identifies these overlaps and uses paired-end read linkage and coverage consistency to safely join contigs, transforming fragmented pieces into higher-quality, more complete viral scaffolds.

## Core CLI Usage

The primary command for the tool is `cobra-meta`. It requires four specific input files and three assembly parameters to function correctly.

### Required Arguments

| Flag | Description | Format/Notes |
| :--- | :--- | :--- |
| `-f`, `--fasta` | The full assembly file | Fasta format containing all contigs. |
| `-q`, `--query` | The contigs you want to extend | Fasta file or a one-column text list of names. |
| `-c`, `--coverage` | Contig sequencing coverage | Two-column tab-separated file (Name [tab] Coverage). |
| `-m`, `--mapping` | Paired-end read mapping | SAM or BAM format. |
| `-a`, `--assembler` | The assembler used | Must be `idba`, `megahit`, or `metaspades`. |
| `-mink` | Minimum k-mer size | Used during the initial de novo assembly. |
| `-maxk` | Maximum k-mer size | Used during the initial de novo assembly. |

### Basic Command Pattern

```bash
cobra-meta -q queries.fasta -f total_assembly.fasta -a metaspades -mink 21 -maxk 127 -m mapping.bam -c coverage.txt -o output_folder
```

## Expert Tips and Best Practices

### Assembler-Specific Logic
*   **IDBA_UD:** COBRA calculates the expected overlap as `maxK - 1`. For IDBA_UD, it is strongly recommended to use **contigs** rather than scaffolds to avoid propagation of scaffolding errors.
*   **metaSPAdes/MEGAHIT:** The expected overlap is exactly `maxK`. Scaffolds from metaSPAdes are generally safe to use as input.

### Input Preparation
*   **Query Names:** Ensure the names in your query file (`-q`) exactly match the headers in your fasta file (`-f`). Mismatches will prevent the extension process.
*   **Mapping Files:** Use tools like Bowtie2 or BBMap to generate the mapping file. The file must contain paired-end information, as COBRA relies on read pairs spanning contig boundaries to validate joins.
*   **Coverage File:** This is a simple tab-delimited text file. Ensure it includes all contigs present in the fasta file.

### Parameter Tuning
*   **Linkage Mismatch (`-lm`):** If you have high-diversity populations, you may need to adjust the number of allowed mismatches in read mapping (default is usually sufficient for most viral populations).
*   **Threads (`-t`):** COBRA uses BLASTn for overlap verification. Increase threads to significantly speed up the processing of large query sets.

### Troubleshooting
*   **No Extensions:** If COBRA exits without extending any queries, check the log file in the output directory. Common causes include k-mer sizes not matching the assembly parameters or insufficient read mapping coverage across contig ends.
*   **Biopython Issues:** Ensure you are using a version compatible with your COBRA installation (v1.2.3+ addresses specific Biopython GC function issues).

## Reference documentation
- [COBRA GitHub Repository](./references/github_com_linxingchen_cobra.md)
- [Bioconda cobra-meta Package](./references/anaconda_org_channels_bioconda_packages_cobra-meta_overview.md)