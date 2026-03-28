---
name: savvy
description: Savvy is a high-performance toolset for converting, querying, and manipulating genomic variant data in VCF, BCF, and SAV formats. Use when user asks to convert genomic files to SAV format, query variants by region or record slice, concatenate files, sort variants, or extract file statistics and headers.
homepage: https://github.com/statgen/savvy
---

# savvy

## Overview

Savvy is a high-performance toolset and C++ library designed for the SAV genomic variant format. It provides a seamless interface for handling VCF, BCF, and SAV files, with a focus on efficient storage and rapid random access. The `sav` command-line interface (CLI) allows for fast conversion between formats and advanced querying capabilities using S1R indices, which support both traditional genomic region lookups and record-offset (slice) queries.

## CLI Usage and Patterns

### File Conversion and Import
The `import` command is the primary way to create SAV files. It automatically generates and appends an S1R index.
- **Convert BCF/VCF to SAV**: `sav import input.bcf output.sav`

### Data Export and Querying
The `export` command converts SAV back to VCF/BCF or filters the data.
- **Basic Export**: `sav export file.sav > output.vcf`
- **Genomic Region Query**: `sav export --regions chr1,chr2:10000-20000 file.sav`
- **Sample Subsetting**: `sav export --sample-ids ID1,ID2,ID3 file.sav`
- **Slice Query (Record Offsets)**: Use this for fast access to specific record ranges regardless of coordinates.
  - First 1,000 records: `sav export --slice 0:1000 file.sav`
  - Records 1,000 to 1,999: `sav export --slice 1000:2000 file.sav`

### File Manipulation
- **Fast Concatenation**: Performs a byte-for-byte copy of compressed blocks (similar to `bcftools concat --naive`).
  - `sav concat file1.sav file2.sav > combined.sav`
- **Sorting**: Sort variants by chromosome and position.
  - Ascending: `sav sort unsorted.sav > sorted.sav`
  - Descending: `sav sort --direction desc unsorted.sav > reversed.sav`

### Header Management
- **View Header**: `sav head file.sav`
- **Extract Sample IDs**: `sav head --sample-ids file.sav`
- **Replace Header Samples**: `sav rehead --sample-ids new_ids.txt old.sav new.sav`

### Analysis and Statistics
- **Full File Stats**: Parses the entire file for detailed metrics.
  - `sav stat file.sav`
- **Fast Index Stats**: Parses only the S1R index (useful for record counts and chromosome lists).
  - `sav stat-index file.sav`

## Expert Tips and Best Practices

- **Performance Trade-offs**: 
  - Increasing **block size** reduces file size (especially with PBWT) but makes random access less precise.
  - Increasing **compression level** yields smaller files but slows down the initial import; decompression speed remains largely unaffected.
- **PBWT Encoding**: Enable PBWT for significantly smaller file sizes on datasets with many samples, though it increases CPU usage during read/write.
- **Index Efficiency**: Always prefer `sav stat-index` over `sav stat` when you only need high-level metadata like record counts, as it avoids decompressing the variant data.
- **Version Compatibility**: Savvy 2.0+ supports reading SAV 1.x files but only writes SAV 2.0+ formats.



## Subcommands

| Command | Description |
|---------|-------------|
| sav | Missing sub-command |
| sav concat | Concatenates SAV files. |
| sav head | Print headers or sample IDs from a Savvy file |
| sav import | Import data into SAV format |
| sav rehead | Replace headers in a SAV file. |
| sav stat | Too few arguments |
| savvy export | Export SAV data to VCF, VCF.GZ, or SAV format. |
| savvy sav sort | Sorts a SAV file. |
| savvy sav stat-index | Index a SAV file for fast random access. |

## Reference documentation
- [Savvy Library Overview](./references/github_com_statgen_savvy_blob_master_README.md)
- [SAV v2 Specification](./references/github_com_statgen_savvy_blob_master_sav_spec_v2.md)
- [S1R Index Specification](./references/github_com_statgen_savvy_blob_master_s1r_spec.md)