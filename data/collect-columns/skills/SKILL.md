---
name: collect-columns
description: This tool consolidates data from multiple tables into a single output by aligning value columns based on a shared feature identifier. Use when user asks to merge count files, aggregate expression data across samples, or append genomic attributes from a GTF file to a combined table.
homepage: https://github.com/biowdl/collect-columns
metadata:
  docker_image: "quay.io/biocontainers/collect-columns:1.0.0--py_0"
---

# collect-columns

## Overview
`collect-columns` is a specialized utility for consolidating data across multiple tables. It extracts a specific value column from each input file and aligns them into a single output table based on a shared feature ID column. Beyond simple merging, the tool can handle duplicate feature identifiers by summing their values and can perform lookups against genomic annotation files (GTF/GFF) to append descriptive attributes like gene names or biotypes to the final output.

## Command Line Usage

### Basic Syntax
The standard usage requires an output path followed by one or more input files:
```bash
collect-columns output.tsv sample1.tsv sample2.tsv sample3.tsv
```

### Common CLI Patterns

**1. Merging HTSeq-count Output (Default)**
By default, the tool assumes tab-separated, headerless files where column 1 is the ID and column 2 is the value.
```bash
collect-columns all_counts.tsv s1.counts s2.counts
```

**2. Merging StringTie Abundance Files**
StringTie files typically have headers and require specific column indices (e.g., column 7 for FPKM).
```bash
collect-columns merged_fpkm.tsv s1.tab s2.tab -c 7 -H
```

**3. Adding Genomic Attributes**
To include extra information (like gene names) from a GTF file:
```bash
collect-columns counts_with_names.tsv s1.tsv s2.tsv \
  -g genes.gtf \
  -a gene_name gene_biotype
```

**4. Handling Duplicate Feature IDs**
If an input table contains multiple rows for the same ID (e.g., multiple transcripts for one gene), use `-S` to sum them instead of overwriting.
```bash
collect-columns summed_counts.tsv s1.tsv s2.tsv -S
```

## Tool Options and Best Practices

### Input Formatting
- **Column Indexing**: Use `-f` for the feature ID column and `-c` for the value column. Note that indices are **1-based**.
- **Headers**: If your input files have a header row, you must include the `-H` flag to prevent the header from being treated as data.
- **Separators**: The tool defaults to tabs. Use `-s` to specify a different character (e.g., `-s ','` for CSV).

### Output Customization
- **Sample Naming**: By default, the output headers use the input filenames. Use the `-n` flag followed by a list of names to provide clean sample identifiers:
  ```bash
  collect-columns out.tsv s1.tsv s2.tsv -n Control Treatment
  ```
- **GTF Mapping**: The tool uses `gene_id` as the default attribute to map input rows to GTF records. If your tables use a different identifier (like transcript IDs), change the mapping attribute with `-F`.

### Expert Tips
- **Float Conversion**: Enabling the `-S` (sum) flag automatically converts values to floats.
- **Warning Awareness**: Without the `-S` flag, if the tool encounters a duplicate feature ID, it will only keep the last value found and issue a warning. Always check your logs if you suspect duplicate IDs in your source data.
- **Consistency**: The tool assumes all input files share the same format (same separator and column indices). Do not mix different tool outputs in a single command.

## Reference documentation
- [collect-columns GitHub Repository](./references/github_com_biowdl_collect-columns.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_collect-columns_overview.md)