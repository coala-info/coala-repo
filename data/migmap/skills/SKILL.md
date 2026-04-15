---
name: migmap
description: MiGMAP processes immune repertoire sequencing data by mapping reads to germline segments and extracting CDR3 regions. Use when user asks to assemble clonotype abundance tables, perform per-read mapping, or filter sequencing data based on quality and coding properties.
homepage: https://github.com/mikessh/migmap
metadata:
  docker_image: "quay.io/biocontainers/migmap:1.0.3--0"
---

# migmap

## Overview
MiGMAP is a specialized tool for processing immune repertoire sequencing data. It addresses common limitations of raw IgBlast by providing direct CDR3 region extraction, quality-aware filtering, and automated clonotype abundance table generation. Use this skill to map FASTQ/FASTA reads to germline segments, identify mutations, and prepare data for downstream post-analysis tools like VDJtools.

## Core Execution Patterns

### Basic Clonotype Assembly
To process raw sequencing reads into a clonotype abundance table, use the following syntax. This is the most common entry point for repertoire analysis.
```bash
# Standard execution for human IGH
java -jar migmap.jar -R IGH -S human input.fastq.gz output.txt

# Execution if installed via Homebrew/Linuxbrew
migmap -R IGH -S human input.fastq.gz output.txt
```

### Per-Read Mapping
For workflows requiring individual read assignments rather than assembled clonotypes, use the `--by-read` flag. This is useful for piping to other utilities.
```bash
java -jar migmap.jar --by-read -R TRB -S mouse input.fastq.gz - | grep "TRBV" > filtered_reads.txt
```

### Multi-Chain Analysis
It is recommended to map against the complete set of receptor genes to identify and filter contaminations later.
```bash
migmap -R IGH,IGK,IGL -S human input.fastq.gz output.txt
```

## Configuration and Optimization

### Resource Management
*   **Memory**: For large datasets, increase the heap size using `-Xmx` (e.g., `-Xmx8G`).
*   **Parallelization**: Use `-p` to specify threads. MiGMAP optimizes speed by parsing IgBlast output in parallel.

### Path Requirements
*   **IgBlast Binaries**: Ensure `igblastn` and `makeblastdb` are in your `$PATH`. If not, use `--blast-dir /path/to/bin/`.
*   **Data Bundle**: MiGMAP requires a `data/` folder containing binary databases. If moved, specify its location with `--data-dir`.

## Advanced Filtering Options
Control the stringency of your repertoire analysis with these flags:

| Option | Effect |
| :--- | :--- |
| `-q <int>` | Quality threshold (default 25). Filters reads with low-quality CDR3 N-regions. |
| `--allow-incomplete` | Includes clonotypes lacking J germline parts. |
| `--allow-noncoding` | Includes sequences with stop codons or frameshifts. |
| `--allow-noncanonical` | Includes CDR3s not starting with C or ending with F/W. |
| `--all-alleles` | Uses all alleles in the database instead of just the major (*01) allele. |

## Expert Tips
*   **Nomenclature**: By default, MiGMAP uses IMGT nomenclature for FR/CDR markup. Use `--use-kabat` if your downstream analysis requires Kabat numbering.
*   **Reporting**: Always use the `--report` flag to generate a summary of extraction and filtering efficiency, which is critical for QC.
*   **Custom References**: You can point to a custom segment database using `--custom-database`, provided it follows the `segments.txt` format found in the MiGMAP data bundle.

## Reference documentation
- [MiGMAP GitHub Repository](./references/github_com_mikessh_migmap.md)
- [Bioconda MiGMAP Overview](./references/anaconda_org_channels_bioconda_packages_migmap_overview.md)