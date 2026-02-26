---
name: dehomopolymerate
description: This tool collapses homopolymer runs in biological sequences into single representative nucleotides. Use when user asks to collapse homopolymer runs, perform homopolymer-blind analysis, convert FASTQ to FASTA, or filter sequences by length after collapsing.
homepage: https://github.com/tseemann/dehomopolymerate
---


# dehomopolymerate

## Overview
`dehomopolymerate` is a high-performance C utility designed to transform biological sequences by collapsing homopolymer runs (e.g., `AAAAA`) into a single representative nucleotide (`A`). This process is particularly useful for "homopolymer-blind" analysis where the exact count of identical adjacent bases is less reliable than the sequence of base changes themselves. It supports both compressed and uncompressed FASTQ/FASTA inputs and provides options for filtering and format conversion.

## Installation and Setup
The tool is most easily installed via Bioconda:
```bash
conda install -c bioconda dehomopolymerate
```

## Common CLI Patterns

### Basic Homopolymer Collapsing
To process a standard FASTQ file and output the collapsed sequences in FASTQ format:
```bash
dehomopolymerate reads.fastq > collapsed_reads.fq
```

### Handling Compressed Data
The tool natively supports gzipped input files:
```bash
dehomopolymerate reads.fastq.gz > collapsed_reads.fq
```

### Format Conversion
To collapse sequences and simultaneously convert the output to FASTA format:
```bash
dehomopolymerate -f reads.fastq > collapsed_reads.fasta
```

### Length Filtering
Collapsing homopolymers significantly reduces the total length of a read. Use the `-l` flag to discard reads that fall below a specific length threshold after the collapsing process:
```bash
# Discard any reads shorter than 50bp after collapsing
dehomopolymerate -l 50 reads.fastq > filtered_collapsed.fq
```

### Raw Sequence Extraction
For tasks requiring only the sequence string (one per line) without headers or quality scores:
```bash
dehomopolymerate -w reads.fastq > sequences_only.txt
```

## Expert Tips and Best Practices
- **Quality Score Handling**: When collapsing a run, the tool typically retains the quality score of the first base in the run. Be aware that this may not represent the aggregate quality of the collapsed run.
- **Quiet Mode**: Use the `-q` flag in automated pipelines or scripts to suppress the summary statistics (sequences processed, base pairs, average length) normally sent to stderr.
- **Pipeline Integration**: Since the tool outputs to stdout, it is ideal for piping into other utilities like `minimap2` or `grep`.
- **Memory Efficiency**: The tool uses `kseq.h` for fast parsing, making it suitable for very large datasets with minimal memory overhead.

## Reference documentation
- [Main Repository and Usage](./references/github_com_tseemann_dehomopolymerate.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_dehomopolymerate_overview.md)