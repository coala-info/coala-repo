---
name: dms
description: Dynamic Meta-Storms is a bioinformatics suite that calculates phylogenetically-aware dissimilarity between metagenomic samples at the species level. Use when user asks to merge MetaPhlAn profiles into abundance tables, compute pairwise distance matrices, or create customized phylogenetic reference files.
homepage: https://github.com/qibebt-bioinfo/dynamic-meta-storms
---

# dms

## Overview

Dynamic Meta-Storms (DMS) is a specialized bioinformatics suite for comparing metagenomic samples at the species level. Unlike simple abundance-based comparisons, DMS incorporates phylogenetic relationships to provide a more comprehensive measure of dissimilarity. It is particularly effective at handling unclassified organisms by dynamically placing them at virtual internal nodes within a taxonomic hierarchy. Use this skill to process species-level abundance tables and generate pairwise distance matrices for downstream ecological or comparative analysis.

## Core Workflow and CLI Patterns

### 1. Preparing the Input Table
If you have individual MetaPhlAn profiling files, you must first merge them into a single abundance table.

**Create a list file (`samples.list.txt`):**
The file must be tab-delimited with the sample ID in the first column and the file path in the second.
```text
Sample_A    /path/to/sample_A.txt
Sample_B    /path/to/sample_B.txt
```

**Merge profiles:**
```bash
MS-single-to-table -l samples.list.txt -o samples.sp.table
```

### 2. Computing the Distance Matrix
The primary tool for distance calculation is `MS-comp-taxa-dynamic`.

**Standard calculation (MetaPhlAn2 default):**
```bash
MS-comp-taxa-dynamic -T samples.sp.table -o samples.sp.dist
```

**Using MetaPhlAn3 references:**
If your data was profiled using MetaPhlAn3, specify the database version using the `-D` flag.
```bash
MS-comp-taxa-dynamic -D M -T samples.sp.table -o samples.sp.dist
```

### 3. Creating Customized References
If you have a specific phylogenetic tree and taxonomy, you can build a custom `.dms` reference file.

**Build the reference:**
```bash
MS-make-ref -i tree.newick -r tree.taxonomy -o custom_tree.dms
```
*   **Tree:** Must be in Newick format with species names as tip nodes.
*   **Taxonomy:** A tabular file containing the full hierarchy (Kingdom to Species).

**Compute distance with custom reference:**
```bash
MS-comp-taxa-dynamic -D custom_tree.dms -T samples.sp.table -o samples.sp.dist
```

## Expert Tips and Best Practices

*   **Input Profiling:** Ensure MetaPhlAn is run with the `-tax_lev s` flag to generate species-level profiles, as DMS is optimized for this resolution.
*   **Parallelization:** The tools utilize OpenMP for parallel computing. Ensure your environment has the necessary libraries (e.g., `libgomp`) to take advantage of multi-core performance.
*   **Memory Management:** For typical datasets, 2GB of RAM is sufficient, but for very large abundance tables (hundreds of samples), 8GB+ is recommended for optimal performance.
*   **Taxonomy Formatting:** When creating custom references, the taxonomy file must follow the specific prefix convention (e.g., `k__`, `p__`, `c__`, `o__`, `f__`, `g__`, `s__`) to be parsed correctly by `MS-make-ref`.



## Subcommands

| Command | Description |
|---------|-------------|
| MS-make-ref | Make customized reference for dynamic-meta-storms |
| dms_MS-single-to-table | Converts MS-single output to a table format. |

## Reference documentation

- [Dynamic Meta-Storms GitHub README](./references/github_com_qibebt-bioinfo_dynamic-meta-storms_blob_master_README.md)
- [DMS Installation and Environment Guide](./references/github_com_qibebt-bioinfo_dynamic-meta-storms_blob_master_install.sh.md)
- [DMS Makefile and Binary Definitions](./references/github_com_qibebt-bioinfo_dynamic-meta-storms_blob_master_Makefile.md)