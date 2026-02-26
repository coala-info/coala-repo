---
name: repaq
description: "repaq is a lossless compressor for FASTQ files that offers high-speed or high-ratio compression modes for genomic data. Use when user asks to compress FASTQ files, decompress RFQ files, or verify the integrity of compressed genomic data."
homepage: https://github.com/OpenGene/repaq
---


# repaq

## Overview

repaq is a specialized, lossless compressor designed for FASTQ files. It outperforms standard tools like gzip by utilizing domain-specific knowledge of genomic data structures. It offers two primary output formats: `.rfq`, which prioritizes extreme speed (often 5x faster than gzip), and `.rfq.xz`, which prioritizes ultra-high compression ratios (potentially reducing files to 3-5% of their original size).

## Installation

The recommended way to install repaq is via Bioconda:

```bash
conda install -c bioconda repaq
```

## Core CLI Patterns

### Compression

For the best compression ratio on paired-end data, always process both reads together in a single command.

**Paired-End (Recommended):**
```bash
repaq -c -i input_R1.fq.gz -I input_R2.fq.gz -o output.rfq.xz
```

**Single-End:**
```bash
repaq -c -i input.fq -o output.rfq.xz
```

*Note: Use the `.rfq` extension instead of `.rfq.xz` if you require maximum speed over maximum compression.*

### Decompression

**Paired-End:**
```bash
repaq -d -i input.rfq.xz -o out_R1.fq -O out_R2.fq
```

**Single-End:**
```bash
repaq -d -i input.rfq.xz -o out.fq
```

### Integrity Verification

To ensure a compressed file is identical to the original source, use the `--compare` mode. This returns a JSON object indicating if the check passed.

```bash
repaq --compare -i original_R1.fq.gz -I original_R2.fq.gz -r compressed.rfq.xz
```

## Advanced Workflows and Tips

### Streaming with Pipes
repaq can integrate into bioinformatics pipelines using STDIN and STDOUT. This is useful for compressing output directly from pre-processing tools like `fastp`.

```bash
fastp -i R1.fq -I R2.fq --stdout | repaq -c --interleaved_in --stdin -o out.rfq.xz
```

### Performance Tuning
- **Memory:** Ensure the system has at least 16GB RAM for optimal performance.
- **Chunk Size:** You can adjust the encoding chunk size (default 1000kb) using the `-k` flag to balance memory usage and compression efficiency.
- **Format Compatibility:** repaq requires standard 4-line FASTQ records. It supports bases A, T, C, G, and N. If your data contains other IUPAC ambiguity codes, it may not be compatible.

### Best Practices
1. **Always use PE mode for PE data:** Compressing R1 and R2 into a single `.rfq` file yields a significantly better compression ratio than compressing them separately.
2. **Input Formats:** repaq natively handles gzipped FASTQ files as input if the filename ends in `.gz`.
3. **NovaSeq Optimization:** This tool is specifically optimized for the discrete quality scores found in Illumina NovaSeq data.

## Reference documentation
- [repaq GitHub Repository](./references/github_com_OpenGene_repaq.md)
- [repaq Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_repaq_overview.md)