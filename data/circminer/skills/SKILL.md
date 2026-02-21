---
name: circminer
description: CircMiner is a high-performance computational tool designed for the rapid and accurate identification of circular RNAs.
homepage: https://github.com/vpc-ccg/circminer
---

# circminer

## Overview
CircMiner is a high-performance computational tool designed for the rapid and accurate identification of circular RNAs. It utilizes a specialized pseudo-alignment scheme that is aware of splice sites, allowing it to distinguish circular back-splice junctions from linear splicing events. This skill guides the two-stage workflow: building a reference index and executing the circRNA detection pipeline.

## Installation
The most reliable way to install circminer is via Bioconda:
```bash
conda install -c bioconda circminer
```

## Core Workflow

### 1. Indexing the Reference
Before processing reads, you must generate an index from your reference FASTA file.
```bash
circminer --index -r reference.fa -k 20 --thread 8
```
*   **-k, --kmer**: Kmer size (range 14-22, default 20).
*   **-m, --compact-index**: Use this during indexing to reduce the memory footprint of the resulting index.

### 2. Detecting circRNAs
Run the detection pipeline using the indexed reference, a gene model (GTF), and your sequencing reads.
```bash
circminer -r reference.fa -g annotations.gtf -1 reads_R1.fq -2 reads_R2.fq -o project_prefix --thread 8
```
*   **-g, --gtf**: Required for gene model awareness.
*   **-a, --scan-lev**: Scan level (0-2). Use `2` to report the best mapping (highest accuracy but slower), or `0` for the first valid mapping (fastest).
*   **-o, --output**: Prefix for output files (e.g., `project_prefix.circ_report`).

## Post-Processing and Utilities

### Transcript Annotation
To add gene, transcript, and exon information to the raw report:
```bash
python scripts/annotate_transcript.py project_prefix.circ_report annotations.gtf project_prefix.annotated.report
```

### GTF Format Conversion
CircMiner prefers Ensembl-style GTF files. If using UCSC GTF files, convert them first:
```bash
python scripts/convertGTF.py ucsc_input.gtf ensembl_style_output.gtf
```

## Expert Tips and Best Practices
*   **Memory Management**: If working with large genomes (e.g., Human) on memory-constrained systems, always use the `-m` (compact index) flag during the indexing stage.
*   **Read Length**: The default max read length is 300bp (`-l 300`). If using long-read data or chemistry exceeding this, adjust `-l` accordingly to avoid truncated alignments.
*   **Sensitivity Tuning**: For higher sensitivity in complex samples, increase the scan level (`-a 2`) and allow a higher edit distance (`-e`) if the data quality is lower.
*   **Output Formats**: By default, mapping results are not saved to save space. Use `--sam` or `--pam` if you need to inspect the pseudo-alignments for downstream visualization or validation.

## Reference documentation
- [CircMiner GitHub Repository](./references/github_com_vpc-ccg_circminer.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_circminer_overview.md)