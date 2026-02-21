---
name: savvy
description: The `savvy` toolset provides a high-performance C++ library and command-line interface (CLI) for interacting with genomic variant data.
homepage: https://github.com/statgen/savvy
---

# savvy

## Overview
The `savvy` toolset provides a high-performance C++ library and command-line interface (CLI) for interacting with genomic variant data. While it supports standard VCF and BCF formats, its primary strength lies in the SAV format. SAV files utilize S1R indices to enable not only genomic region queries but also "slice" queries (accessing records by their numerical offset). This skill focuses on the `sav` CLI for efficient file conversion, subsetting, and metadata management in bioinformatics workflows.

## Installation
The most reliable way to install the `savvy` CLI is via bioconda:
```bash
conda install -c bioconda savvy
```

## Common CLI Patterns

### File Conversion and Import
To convert standard formats into the optimized SAV format (which automatically generates an S1R index):
```bash
sav import input.bcf output.sav
```

### Exporting and Subsetting
The `export` command is the primary way to filter data or convert SAV back to VCF/BCF.

**Filter by Genomic Region:**
```bash
sav export --regions chr1,chr2:10000-20000 input.sav > output.vcf
```

**Filter by Sample IDs:**
```bash
sav export --sample-ids ID1,ID2,ID3 input.sav > subset.vcf
```

**Slice Queries (Record Offsets):**
Unique to SAV/S1R, this allows extracting specific ranges of records regardless of genomic position.
```bash
# Export the first 1,000 records
sav export --slice 0:1000 input.sav > first_1k.vcf
```

### High-Speed Concatenation
For SAV files, `concat` performs a "naive" byte-for-byte copy of compressed blocks, making it significantly faster than re-processing records.
```bash
sav concat file1.sav file2.sav > combined.sav
```

### Metadata and Headers
**View Header or Samples:**
```bash
# View full header
sav head input.sav

# List only sample IDs
sav head --sample-ids input.sav
```

**Modify Headers:**
Use `rehead` to replace sample IDs or other header metadata without recompressing the entire variant data block.
```bash
sav rehead --sample-ids new_ids.txt old.sav new.sav
```

### Statistics and Analysis
*   **`sav stat`**: Parses the entire file to provide detailed statistics.
*   **`sav stat-index`**: Only parses the S1R index. Use this for near-instant counts of variant records and chromosome distributions.

## Expert Tips
*   **Sorting**: If your SAV file is unsorted, use `sav sort unsorted.sav > sorted.sav`. You can also sort in descending order (`--direction desc`), which is natively supported by the S1R index.
*   **Compression Trade-offs**: When creating SAV files, you can enable PBWT (Positional Burrows-Wheeler Transform) for significantly smaller file sizes, though this may slightly increase decompression time during reading.
*   **Index Efficiency**: Always prefer `sav stat-index` over `sav stat` if you only need high-level metadata (like record counts), as it avoids the CPU overhead of decompressing variant blocks.

## Reference documentation
- [Savvy GitHub Repository](./references/github_com_statgen_savvy.md)
- [Savvy Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_savvy_overview.md)