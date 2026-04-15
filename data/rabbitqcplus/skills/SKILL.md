---
name: rabbitqcplus
description: RabbitQCPlus is a high-performance quality control and error correction tool for processing Next-Generation and Third-Generation sequencing data. Use when user asks to perform quality control, filter reads, correct sequencing errors, or generate QC reports for FASTQ files.
homepage: https://github.com/RabbitBio/RabbitQCPlus
metadata:
  docker_image: "quay.io/biocontainers/rabbitqcplus:2.3.0--h5ca1c30_1"
---

# rabbitqcplus

## Overview

RabbitQCPlus is a high-performance quality control tool designed to replace or augment traditional tools like fastp, FASTQC, and SOAPnuke. It is specifically optimized for speed, offering significant performance gains when processing gzip-compressed files and performing over-representation analysis. Beyond standard filtering and QC reporting, it integrates the CARE error correction engine, making it a versatile choice for both Next-Generation Sequencing (NGS) and Third-Generation Sequencing (TGS) data.

## Core CLI Usage

### Basic Quality Control
Process single-end (SE) or paired-end (PE) data with multi-threading.

*   **Single-End (Plain or Gzip):**
    ```bash
    RabbitQCPlus -w 8 -i input.fastq.gz -o output.fastq.gz
    ```
*   **Paired-End (Plain or Gzip):**
    ```bash
    RabbitQCPlus -w 16 -i read1.fq.gz -I read2.fq.gz -o out1.fq.gz -O out2.fq.gz
    ```

### Third-Generation Sequencing (TGS)
Use the `--TGS` flag for long-read data (e.g., PacBio or Oxford Nanopore).
```bash
RabbitQCPlus -w 8 -i long_reads.fastq.gz --TGS
```

### Integrated Error Correction (CARE Engine)
RabbitQCPlus can correct sequencing errors during the QC process. This requires specifying the coverage and the pairing mode.
```bash
# Paired-end error correction
RabbitQCPlus -w 32 -i r1.fq -I r2.fq -o p1.fq -O p2.fq --correctWithCare --coverage 30 --pairmode PE
```

## Expert Tips and Best Practices

*   **Thread Optimization:** Use the `-w` parameter to specify the number of threads. For gzip-compressed data, RabbitQCPlus is highly efficient; allocating 16-32 threads is often the "sweet spot" for modern server CPUs to maximize throughput without hitting I/O bottlenecks.
*   **Instruction Set Performance:** If installing via Bioconda, the tool uses SSE4.2 for compatibility. For maximum performance on specific hardware (e.g., utilizing AVX2 or AVX512), it is recommended to compile from source on the target machine.
*   **Gzip Efficiency:** RabbitQCPlus solves common performance bottlenecks associated with processing `.gz` files. You do not need to decompress files beforehand; the tool handles them natively with better speed than most competitors.
*   **Memory Usage:** While efficient, the error correction module (`--correctWithCare`) and over-representation analysis are more resource-intensive. Ensure the system has sufficient RAM when these features are enabled on large datasets.
*   **Help Command:** For a full list of filtering parameters (quality scores, length filters, adapter trimming), use:
    ```bash
    RabbitQCPlus -h
    ```

## Reference documentation
- [RabbitQCPlus Overview](./references/anaconda_org_channels_bioconda_packages_rabbitqcplus_overview.md)
- [RabbitQCPlus GitHub Repository](./references/github_com_RabbitBio_RabbitQCPlus.md)