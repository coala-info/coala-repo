---
name: splitp
description: splitp is a high-speed tool for pre-processing SPLiT-seq reads by extracting and mapping barcodes from FASTQ files. Use when user asks to pre-process SPLiT-seq data, extract barcodes from R2 files, or map oligo-dT sequences to random hexamers.
homepage: https://github.com/COMBINE-lab/splitp
---


# splitp

## Overview

splitp is a high-speed Rust implementation of SPLiT-seq read pre-processing logic. It is designed to replace slower legacy Perl scripts while maintaining functional equivalence. The tool processes R2 files by extracting barcodes from specific positions and mapping them against a provided oligo-dT to random-mer translation table. Because it writes directly to stdout, it is optimized for streaming workflows that avoid unnecessary disk I/O.

## Command Line Usage

The basic syntax for splitp requires an input FASTQ, a barcode map, and the coordinate range for the barcode within the read.

```bash
splitp -r <READ_FILE> -b <BC_MAP> -s <START> -e <END> [OPTIONS]
```

### Core Arguments
- `-r, --read-file`: The input R2 FASTQ file.
- `-b, --bc-map`: A two-column, tab-separated file mapping oligo-dT to random hexamers.
- `-s, --start`: The 0-indexed start position of the random barcode in the read.
- `-e, --end`: The 0-indexed end position of the random barcode.

### Options
- `-o, --one-hamming`: Enables 1-Hamming distance lookups for the random hexamers, allowing for single-base sequencing errors in the barcode.
- `-h, --help`: Prints detailed help information.

## Best Practices and Expert Tips

### Input Mapping File Requirements
The barcode mapping file (`--bc-map`) must follow a strict format:
1. It must be a tab-separated values (TSV) file.
2. The first row **must** be a comment line starting with the `#` character.
3. It should contain two columns: the oligo-dT sequence and its corresponding random-mer.

### Streaming and Pipelining
Since splitp writes processed reads to `stdout`, you should always pipe the output to avoid flooding the terminal:

**To compress output on the fly:**
```bash
splitp -r reads.fq -b map.txt -s 87 -e 94 -o | gzip > processed_reads.fq.gz
```

**To pipe directly into downstream tools (e.g., alevin-fry):**
Use process substitution or standard Unix pipes to feed the output directly into the next stage of the single-cell analysis pipeline.

### Handling Ambiguous Bases (N)
If the barcode sequence contains `N` characters, splitp replaces them with `A` before performing the table lookup. If your data contains multiple `N`s in the barcode region, be aware that this behavior may lead to different results compared to tools that handle ambiguity differently.

### Performance Optimization
splitp is significantly faster than the original Perl implementation (often processing 10 million reads in seconds rather than minutes). To maximize throughput:
- Use it in a pipe-heavy workflow to minimize disk writes.
- Ensure the input FASTQ is accessible via fast local storage or a high-bandwidth network mount.

## Reference documentation
- [splitp GitHub Repository](./references/github_com_COMBINE-lab_splitp.md)
- [splitp Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_splitp_overview.md)