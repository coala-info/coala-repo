---
name: bamrescue
description: "bamrescue identifies and repairs data loss in corrupted BAM files by skipping damaged BGZF blocks and concatenating the valid ones. Use when user asks to check BAM file integrity, identify corruption in genomic data, or rescue readable data from corrupted BAM files."
homepage: https://github.com/Arkanosis/bamrescue
---

# bamrescue

## Overview

`bamrescue` is a high-performance command-line utility designed to identify and mitigate data loss in corrupted BAM files. Because BAM files are composed of concatenated BGZF (Blocked GNU Zip Format) blocks, a single corrupted byte often causes standard bioinformatics tools to abort processing, potentially losing 100% of the remaining data. `bamrescue` scans these blocks, verifies their CRC32 checksums, and can "rescue" the file by skipping only the specific corrupted blocks (typically ≤ 64 KiB) and concatenating the remaining valid data into a new, readable BAM file.

## Usage Instructions

### Checking for Corruption

To perform a non-destructive integrity check on a BAM file:

```bash
bamrescue check path/to/file.bam
```

**Best Practices for Checking:**
*   **Multi-threading**: By default, the tool uses all available threads (`--threads=0`). For specific resource allocation, define the count: `bamrescue check --threads=4 file.bam`.
*   **Automation**: Use the `--quiet` (or `-q`) flag in automated pipelines. This causes the tool to stop at the first error encountered and suppresses statistical output, making it faster for simple "pass/fail" logic.

### Rescuing Data

If corruption is found, use the `rescue` command to generate a repaired version of the file:

```bash
bamrescue rescue corrupted.bam rescued_output.bam
```

**Expert Tips for Rescue:**
*   **Disk Space**: Ensure you have enough disk space for the output file, as it will be approximately the same size as the original.
*   **Validation**: The rescued file is composed of validated, non-corrupted blocks. While some reads (those in the corrupted blocks) are lost, the resulting file is a valid BAM file that can be indexed and queried by standard tools like `samtools`.

## Technical Considerations

*   **Block-Level Integrity**: `bamrescue` validates the integrity of the BGZF/gzip containers. It does **not** validate whether the uncompressed BAM payload follows the SAM specification. If the file was created by a non-compliant tool, `bamrescue` will not fix logical formatting errors.
*   **Performance**: The tool is optimized for speed and is generally faster than `gzip -t`. It is highly recommended for large-scale genomic data audits.
*   **Data Loss**: A typical hard drive bad sector (512 bytes) usually results in the loss of only one or two BGZF blocks (approx. 46-128 KiB of payload), meaning >99.9% of data is usually recoverable.



## Subcommands

| Command | Description |
|---------|-------------|
| bamrescue check | Check a BAM file for corruption or rescue data from a corrupted BAM file. |
| bamrescue check | Check a BAM file for corruption |
| bamrescue rescue | Rescue data from a corrupted BAM file |
| bamrescue rescue | Rescue data from a corrupted BAM file |

## Reference documentation

- [bamrescue README](./references/github_com_Arkanosis_bamrescue_blob_master_README.md)
- [bamrescue Homepage](./references/bamrescue_arkanosis_net_index.md)