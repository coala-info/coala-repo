---
name: ucsc-pslpartition
description: This tool partitions PSL alignment records into discrete groups based on target sequence overlaps or batch size requirements. Use when user asks to partition PSL files, group overlapping alignments on a target sequence, or split large datasets for parallel processing.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-pslpartition

## Overview
The `pslPartition` utility is a specialized tool from the UCSC Genome Browser "Kent" suite designed to organize PSL alignment records into discrete groups. Its primary function is to identify alignments that overlap on the target sequence and ensure they are kept together in the same partition, or to simply break large files into smaller batches for parallel processing. This is a critical preprocessing step for pipelines involving large-scale genomic comparisons where memory or time constraints require distributed computing.

## Usage Instructions

### Basic Partitioning
The tool typically requires an input PSL file and a target directory for the output partitions.
```bash
pslPartition input.psl outDir
```

### Common CLI Patterns
*   **Partition by Overlap**: By default, the tool groups alignments that overlap on the target sequence. This ensures that all evidence for a specific genomic locus remains in a single file.
*   **Batching for Parallelism**: Use the tool to create a specific number of partitions or to limit the number of records per partition to optimize for cluster job arrays (e.g., using `para` or `parasol`).
*   **Handling Large Datasets**: When working with whole-genome alignments, partitioning allows you to run tools like `pslCDnaFilter` or `pslCheck` on smaller subsets of data simultaneously.

### Expert Tips
*   **Output Structure**: The tool creates a directory structure (often using a 3-level deep hierarchy like `000/001/part001.psl`) to prevent directories from containing too many files, which can degrade filesystem performance.
*   **Target vs. Query**: Remember that partitioning is usually calculated based on the **target** (genomic) coordinates. If you need to partition by query (e.g., transcript ID), ensure the input is sorted or use query-based flags if available in your specific version.
*   **Permissions**: Since this tool is often downloaded as a standalone binary, ensure it has execution permissions: `chmod +x pslPartition`.

## Reference documentation
- [ucsc-pslpartition - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_ucsc-pslpartition_overview.md)
- [Index of /admin/exe/linux.x86_64](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)
- [UCSC Genome Browser source (kent)](./references/github_com_ucscGenomeBrowser_kent.md)