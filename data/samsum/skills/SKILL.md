---
name: samsum
description: samsum is a high-performance, lightweight bioinformatics tool that bridges Python and C++ to provide rapid summarization of sequence alignment data.
homepage: https://github.com/hallamlab/samsum
---

# samsum

## Overview

samsum is a high-performance, lightweight bioinformatics tool that bridges Python and C++ to provide rapid summarization of sequence alignment data. It processes SAM or BAM files to quantify how reads are distributed across a reference genome or assembly. By integrating reference FASTA information, it automatically calculates normalized abundance values (FPKM/TPM), which are essential for comparative genomics and transcriptomics. This skill should be applied when you need to transform raw alignment files into structured coverage tables with specific filtering criteria for mapping quality and breadth of coverage.

## Installation

samsum can be installed via pip or conda:

```bash
pip install samsum
# OR
conda install -c bioconda samsum
```

## Command Line Interface (CLI)

The primary command is `samsum stats`. It requires a reference FASTA file and an alignment file.

### Basic Usage
```bash
samsum stats -f reference.fasta -a alignments.bam -o results.csv
```

### Common Options and Patterns
- **Filter by Coverage Breadth**: Use the `-p` flag to ignore reference sequences that do not meet a minimum coverage proportion.
  ```bash
  # Only report stats for sequences covered across at least 50% of their length
  samsum stats -f ref.fasta -a aln.sam -p 0.5 -o filtered_results.csv
  ```
- **Include Multi-mapped Reads**: By default, reads with a mapping quality of 0 are excluded. Use `--multireads` or `-m` to include them.
  ```bash
  samsum stats -f ref.fasta -a aln.sam --multireads -o all_reads.csv
  ```
- **Output Format**: To generate a Tab-Separated Values (TSV) file instead of the default CSV, specify the separator.
  ```bash
  samsum stats -f ref.fasta -a aln.sam -o results.tsv
  ```

## Python API Usage

For integration into custom Python scripts, use the `commands` module.

```python
from samsum import commands

# Calculate abundances
ref_seq_abunds = commands.ref_sequence_abundances(
    aln_file="alignments.sam",
    seq_file="reference.fasta",
    min_aln=10,    # Minimum alignments
    p_cov=0.5,     # Minimum proportion covered (0.0 to 1.0)
    map_qual=0     # Minimum mapping quality
)

# Accessing results (returns a dictionary of RefSequence objects)
for name, data in ref_seq_abunds.items():
    print(f"Sequence: {name}")
    print(f"TPM: {data.tpm}")
    print(f"FPKM: {data.fpkm}")
    print(f"Reads Mapped: {data.reads_mapped}")
```

## Expert Tips

- **Memory Efficiency**: Version 0.1.3+ includes optimizations to reduce RAM consumption during processing.
- **BAM Support**: While the tool was originally built for SAM, it supports BAM files via the C++ extension for faster processing.
- **Log Files**: Every execution generates a `samsum_log.txt` in the working directory. Check this file if results appear empty or if the process terminates unexpectedly.
- **Data Fields**: The output table includes: `QueryName`, `RefSequence`, `ProportionCovered`, `Coverage`, `Fragments`, `FPKM`, and `TPM`.

## Reference documentation
- [samsum GitHub Repository](./references/github_com_hallamlab_samsum.md)
- [samsum Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_samsum_overview.md)