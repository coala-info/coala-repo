---
name: bamrescue
description: `bamrescue` is a specialized utility designed to recover data from damaged BAM files.
homepage: https://github.com/Arkanosis/bamrescue
---

# bamrescue

## Overview

`bamrescue` is a specialized utility designed to recover data from damaged BAM files. While standard bioinformatics tools often abort entirely when encountering a corrupted byte, `bamrescue` leverages the BGZF (Blocked GNU Zip Format) structure to identify and skip only the specific corrupted blocks. By validating each block using CRC32 checksums, it can salvage nearly all non-corrupted reads from a file, making it an essential tool for data recovery after hardware failures, bad sectors, or interrupted file transfers.

## Usage Instructions

### Checking for Corruption
To perform a health check on a BAM file and see statistics regarding potential data loss:

```bash
bamrescue check <bamfile>
```

**Key Options:**
- `-q, --quiet`: Stops at the first error found and suppresses statistics. Useful for quick integrity scripts.
- `--threads=<n>`: Sets the number of threads. Use `0` (default) for auto-detection based on available CPU cores.

### Rescuing Data
To create a new, valid BAM file by excluding corrupted blocks:

```bash
bamrescue rescue <input.bam> <output.bam>
```

**Note:** The rescue process requires additional disk space equivalent to the size of the original file. The resulting output file is a standard BAM file that can be indexed and used by `samtools`, `picard`, or other downstream tools.

## Expert Tips and Best Practices

- **Performance Tuning**: `bamrescue` is highly parallelizable. On multi-core systems, ensure `--threads` is set to `0` or a high number to significantly decrease processing time compared to standard `gzip -t`.
- **Validation vs. Compliance**: `bamrescue` checks the integrity of the BGZF containers (the "wrappers"), not the internal compliance of the BAM payload with the SAM specification. If the file was created by a non-compliant tool, `bamrescue` will not fix those logical errors.
- **Data Loss Expectations**: Because BGZF blocks are at most 64 KiB, a single-byte corruption or a typical 512-byte bad sector usually results in the loss of only one block. This means you can often rescue >99.9% of your data even if the file is "unreadable" by other software.
- **Post-Rescue Steps**: Always re-index the rescued BAM file using `samtools index <output.bam>` before proceeding with analysis, as the original index will no longer match the rescued file's block offsets.

## Reference documentation
- [bamrescue - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_bamrescue_overview.md)
- [Arkanosis/bamrescue: Utility to check Binary Sequence Alignment / Map (BAM) files for corruption and repair them](./references/github_com_Arkanosis_bamrescue.md)