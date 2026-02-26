---
name: umi-transfer
description: umi-transfer merges UMI sequences from a separate FastQ file into the read headers or sequences of paired-end R1 and R2 files. Use when user asks to merge UMI sequences into paired-end reads, place UMIs in read headers or inline, standardize read numbering, or control output file naming and compression.
homepage: https://github.com/SciLifeLab/umi-transfer
---


# umi-transfer

## Overview
`umi-transfer` is a high-performance Rust-based tool designed to solve the "separate UMI file" problem in genomics. In many sequencing workflows, UMIs are sequenced as a separate index read and output as a third FastQ file. This tool merges that UMI information back into the paired-end R1 and R2 files, typically by appending the UMI sequence to the read ID header. This step is essential before using deduplication tools like UMI-tools or Picard, which expect UMIs to be part of the read metadata.

## Usage Patterns

### Basic UMI Transfer
The most common use case involves taking three files (R1, R2, and the UMI file) and generating two new paired-end files with UMIs in the headers.

```bash
umi-transfer external \
  --in read1.fq.gz \
  --in2 read2.fq.gz \
  --umi umi.fq.gz \
  --z
```
*Note: By default, this appends `_with_UMI` to the input filenames for the output.*

### Customizing UMI Placement
Depending on your downstream pipeline, you may need the UMI in the header (default) or inserted "inline" at the start of the read sequence.

- **Header (Default):** `... --position header`
- **Inline:** `... --position inline` (Moves the UMI sequence and its quality scores to the beginning of the actual read data).

### Standardizing Read Numbers
If your input files have inconsistent or non-standard read numbering in the headers, use the `-c` flag to force canonical `/1` and `/2` suffixes in the output.

```bash
umi-transfer external --in R1.fq --in2 R2.fq --umi U.fq -c
```

### Performance and Compression
- **Threads:** Use `-t` to specify thread count. For optimal performance, odd numbers like 9 or 11 are recommended.
- **Compression:** Use `-z` to enable Gzip compression for outputs. You can control the level (1-9) with `-l`.
- **Direct Naming:** Use `--out` and `--out2` to explicitly name your output files instead of using the default suffix.

## Expert Tips
- **File Extensions:** If you specify an output filename ending in `.gz`, the tool automatically enables compression even if the `-z` flag is omitted.
- **Overwriting:** Use `-f` or `--force` to overwrite existing output files without a confirmation prompt, which is useful for automated shell scripts.
- **Memory Efficiency:** Because it is written in Rust, `umi-transfer` is highly memory-efficient and suitable for processing very large FastQ datasets on standard workstations.

## Reference documentation
- [github_com_SciLifeLab_umi-transfer.md](./references/github_com_SciLifeLab_umi-transfer.md)
- [anaconda_org_channels_bioconda_packages_umi-transfer_overview.md](./references/anaconda_org_channels_bioconda_packages_umi-transfer_overview.md)