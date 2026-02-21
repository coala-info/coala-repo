---
name: bigwig-nim
description: The `bigwig-nim` tool is a specialized utility designed for efficient manipulation of bigWig and bigBed files.
homepage: https://github.com/brentp/bigwig-nim
---

# bigwig-nim

## Overview

The `bigwig-nim` tool is a specialized utility designed for efficient manipulation of bigWig and bigBed files. It provides a fast, command-line interface for converting genomic signal data and calculating summary statistics over specific regions. It is particularly valuable in bioinformatics workflows where performance is critical and when input BED files are compressed, as it natively supports (b)gzipped formats.

## Common CLI Patterns

### Converting BED to bigWig
To convert a BED file (where the signal value is in a specific column) into a bigWig file, use the `view` command. You must provide a chromosome sizes file (usually a `.fai` index).

```bash
bigwig view input.bed --value-column 4 --chrom-sizes genome.fai -O bigwig -o output.bw
```

### Extracting Regional Statistics
The `stats` command calculates summary metrics for genomic intervals. Supported statistics include `mean`, `min`, `max`, `coverage`, and `sum`.

**For a single region:**
```bash
bigwig stats --stat mean data.bw chr22:145000-155000
```

**For multiple regions defined in a BED file:**
```bash
bigwig stats --stat mean data.bw regions.bed
```
The output is tab-delimited: `chrom`, `start`, `stop`, `stat`.

### Inspecting File Metadata
To view chromosome names, lengths, and mean coverages stored in the bigWig header:
```bash
bigwig stats --stat header data.bw
```

## Expert Tips and Best Practices

- **Gzipped Input:** Unlike many older tools (e.g., Kent tools), `bigwig-nim` can process `.bed.gz` files directly without prior decompression.
- **Automatic Optimization:** When using `view`, the tool automatically determines the most efficient data format for each block (fixed span/step vs. per-base) to minimize file size.
- **Performance Bottlenecks:** Most CPU time during conversion is spent parsing the input BED file. Ensure your input is well-formatted to maximize throughput.
- **BigBed Support:** The tool also supports bigBed files. Use the `entries` logic (via the Nim wrapper) or standard CLI queries to interact with bigBed data.
- **Value Column Selection:** Always verify which column in your BED file contains the signal value. The `--value-column` flag is 1-based.

## Reference documentation
- [bigwig-nim GitHub Repository](./references/github_com_brentp_bigwig-nim.md)
- [bigwig-nim Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_bigwig-nim_overview.md)