---
name: mtsv-tools
description: MTSv Tools is a high-performance computational engine designed for the rapid assignment of sequencing reads to taxonomic IDs using a custom FM-index. Use when user asks to prepare reference databases, build genomic indices, bin sequencing reads to taxa, aggregate results into summary reports, or partition reads into matched and unmatched sets.
homepage: https://github.com/FofanovLab/mtsv_tools
---

# mtsv-tools

## Overview

MTSv (Metagenomic Taxon Selection and Verification) Tools is a high-performance computational engine designed for the rapid assignment of sequencing reads to taxonomic IDs. It utilizes a custom FM-index (MG-index) to enable memory-efficient and highly parallelizable workflows. The toolset is modular, allowing users to scale from small datasets to massive reference databases by chunking the reference and processing reads in parallel across multiple indices.

## Core Workflow

### 1. Reference Preparation (`mtsv-chunk`)
To maintain performance and manage memory, split large FASTA reference databases into smaller chunks (typically 1-2 GB).

```bash
mtsv-chunk --input ref_db.fasta --output ./chunks/ --gb 1.0
```

### 2. Index Construction (`mtsv-build`)
Build an MG-index for each FASTA chunk. This step requires a mapping between sequence headers and NCBI TaxIDs.

**Default Header Format:** `>InternalID-TaxID` (e.g., `>12345-987`)

**Using External Mapping:**
If headers are not in the default format, provide a TSV/CSV mapping file with columns: `header`, `taxid`, and `seqid`.

```bash
mtsv-build --fasta ./chunks/ref_0.fasta --index ./indices/ref_0.index --mapping map.tsv
```

*   **Performance Tip:** Adjust `--sample-interval` (default 64) and `--sa-sample` (default 32). Lower values increase index size but speed up queries.

### 3. Read Binning (`mtsv-binner`)
Assign sequencing reads to the generated indices. MTSv supports gzipped FASTQ/FASTA inputs and features automatic resume capabilities.

```bash
mtsv-binner --input reads.fastq.gz --index ./indices/ --output results.bin
```

*   **Long-form Output:** Use this mode to record Genome ID and alignment offsets for downstream functional annotation.
*   **Checkpointing:** If a run is interrupted, `mtsv-binner` will detect partially completed output and resume from the last processed read.

### 4. Result Aggregation (`mtsv-collapse`)
Consolidate binning results into human-readable taxon-level summary reports.

```bash
mtsv-collapse --input results.bin --output summary.tsv --report
```

*   **Precision:** The `--report` flag provides detailed percentage columns with 6 decimal places for high-resolution analysis.

## Utility Operations

### Read Partitioning (`mtsv-partition`)
Separate reads into "matched" and "unmatched" sets based on binning results. This is essential for iterative filtering (e.g., removing host contamination).

```bash
mtsv-partition --input reads.fastq.gz --results results.bin --matched matched.fastq.gz --unmatched unmatched.fastq.gz
```

### Reference Management (`mtsv-reference`)
Use this utility for general reference database maintenance and metadata tasks.

## Expert Tips

*   **Memory Management:** Total RAM usage during binning is approximately 3.5x the size of the reference FASTA chunk. Ensure your `--gb` setting in `mtsv-chunk` aligns with your available hardware.
*   **Parallelization:** Since indices are independent, you can run multiple `mtsv-binner` instances across different nodes or CPU cores for different index chunks, then combine results.
*   **Gzip Handling:** MTSv tools (v2.1.1+) correctly handle multi-member gzip files. You can safely use concatenated `.gz` files as input.



## Subcommands

| Command | Description |
|---------|-------------|
| mtsv-binner | Metagenomic and metatranscriptomic assignment tool. |
| mtsv-build | Index construction for mtsv metagenomic and metatranscriptomic assignment tool. |
| mtsv-chunk | Split a FASTA reference database into chunks for index generation. |
| mtsv-collapse | Tool for combining the output of multiple separate mtsv runs. |

## Reference documentation

- [MTSv Tools README](./references/github_com_FofanovLab_mtsv_tools_blob_master_README.md)
- [MTSv Tools Changelog](./references/github_com_FofanovLab_mtsv_tools_blob_master_CHANGELOG.md)