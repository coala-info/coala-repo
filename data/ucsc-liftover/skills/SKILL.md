---
name: ucsc-liftover
description: ucsc-liftover translates genomic features between different assembly coordinates. Use when user asks to lift genomic features between assemblies, update genomic coordinates from an older reference genome, or map coordinates between different species.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-liftover:482--h0b57e2e_0"
---

# ucsc-liftover

## Overview
The `ucsc-liftover` suite, primarily centered around the `liftOver` binary, is the standard utility for "lifting" genomic features between different assembly coordinates. It works by analyzing a "chain" file—a mathematical mapping of alignments between two assemblies—to translate start and end positions. This skill should be used whenever you encounter data tied to an older reference genome that must be analyzed alongside modern data, or when performing cross-species coordinate mapping.

## Installation and Setup
The most reliable way to access the tool is via Bioconda.
```bash
conda install -c bioconda ucsc-liftover
```
Note: The binaries are platform-specific (linux.x86_64, macOSX.arm64, etc.). If downloading directly from the UCSC server, ensure you use `chmod +x` to make the binary executable.

## Core CLI Usage
The primary command follows a strict positional argument structure:
```bash
liftOver input.bed mapping.chain output.bed unmapped.bed
```
- **input.bed**: The source file (coordinates must match the "from" assembly in the chain file).
- **mapping.chain**: The specific conversion file (e.g., `hg19ToHg38.over.chain`).
- **output.bed**: The resulting file with updated coordinates.
- **unmapped.bed**: A required file that stores records that failed to map (e.g., due to deletions or rearrangements in the new assembly).

## Expert Tips and Best Practices

### 1. Adjusting Mapping Stringency
By default, `liftOver` requires 95% of bases to map successfully. For cross-species lifts or highly divergent regions, you may need to lower this threshold:
- Use `-minMatch=0.1` for very loose mapping (useful for cross-species).
- Use `-minMatch=0.95` (default) for same-species assembly updates.

### 2. Handling Different File Formats
While optimized for BED format, `liftOver` can handle other types with specific flags:
- **GFF/GTF**: Use the `-gff` flag. Note that `liftOver` treats GFF as a simple coordinate file; it does not perform sophisticated transcript-aware remapping.
- **Sample/Position files**: For simple 1-based coordinate lists, convert them to 0-based BED format first.

### 3. Common Errors and Troubleshooting
- **"Chain file does not match input"**: Ensure your input BED file uses the exact same chromosome naming convention as the chain file (e.g., "chr1" vs "1").
- **Empty Output**: Check if your input coordinates are 0-based (BED standard). If you provide 1-based coordinates to a tool expecting 0-based, mapping may fail or shift.
- **Large Deletions**: If a feature spans a gap in the new assembly, it will be sent to the `unmapped` file. Always inspect the `unmapped` file to understand the "loss" in your dataset.

### 4. Chain File Acquisition
Chain files are not bundled with the tool. You must download them from the UCSC GoldenPath server:
`http://hgdownload.soe.ucsc.edu/goldenPath/<source_db>/liftOver/`

## Reference documentation
- [Bioconda ucsc-liftover Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-liftover_overview.md)
- [UCSC Binary Server Index](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Platform Specific Binary Information](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)