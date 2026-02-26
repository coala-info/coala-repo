---
name: chromsize
description: The chromsize tool calculates chromosome lengths from FASTA or 2bit genomic data files. Use when user asks to calculate chromosome sizes, generate a chrom.sizes file, or determine sequence lengths from genomic data.
homepage: https://github.com/alejandrogzi/chromsize
---


# chromsize

## Overview
The `chromsize` skill provides a high-performance method for calculating chromosome lengths from genomic data. It is significantly faster than traditional methods (like `samtools faidx` followed by `cut`) because it is optimized specifically for length calculation and supports multi-threading. It automatically detects input formats (FASTA or 2bit) and compression (gzip), making it a versatile tool for genomic preprocessing and index generation.

## Command Line Usage

### Basic Syntax
```bash
chromsize --sequence <INPUT> --output <OUTPUT> [OPTIONS]
```

### Common Patterns
*   **Standard File Input**: Process a local FASTA or 2bit file.
    ```bash
    chromsize -s genome.fa -o genome.chrom.sizes
    ```
*   **Streaming via Stdin**: Pipe sequence data directly into the tool.
    ```bash
    cat genome.fa | chromsize -o genome.chrom.sizes
    ```
*   **Compressed Inputs**: Handle gzipped files through explicit stdin or direct file path (auto-detected).
    ```bash
    zcat genome.fa.gz | chromsize -s - -o genome.chrom.sizes
    ```
*   **Accession IDs Only**: Use the `-a` flag to truncate headers at the first whitespace, keeping only the accession ID.
    ```bash
    chromsize -s genome.fa -o genome.chrom.sizes -a
    ```

## Expert Tips and Best Practices
*   **Thread Optimization**: By default, the tool uses all available CPUs. In shared HPC environments, explicitly set threads using `-t` to match your resource allocation.
*   **Format Versatility**: The tool accepts `.fa`, `.fasta`, `.fa.gz`, and `.2bit` files. You do not need to specify the format; the tool detects it via magic bytes.
*   **Performance Advantage**: For large genomes (e.g., Axolotl or Lungfish), `chromsize` can be 10-40x faster than `awk` or `bioawk` scripts. Use it as a drop-in replacement for `samtools faidx` when only lengths are required to save significant compute time.
*   **Stdin Default**: If you omit the `--sequence` or `-s` argument, the tool defaults to reading from stdin.

## Python Integration
If working within a Python environment, use the `chromsize` package for direct list generation without CLI overhead:

```python
import chromsize as cs

# Get sizes as a list of tuples: [('chr1', 123), ('chr2', 456)]
sizes = cs.get_chromsizes("path/to/genome.fa")

# Or write directly to a file
cs.write_chromsizes("path/to/genome.fa", "path/to/output.sizes")
```

## Reference documentation
- [chromsize GitHub Repository](./references/github_com_alejandrogzi_chromsize.md)
- [chromsize Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_chromsize_overview.md)