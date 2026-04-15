---
name: biopet-seattleseqkit
description: Biopet-seattleseqkit processes and manipulates SeattleSeq output files to filter variants and aggregate data into gene-level matrices. Use when user asks to filter SeattleSeq files by genomic regions or field criteria, or merge variant annotations into a combined gene matrix.
homepage: https://github.com/biopet/seattleseqkit
metadata:
  docker_image: "quay.io/biocontainers/biopet-seattleseqkit:0.2--0"
---

# biopet-seattleseqkit

## Overview
The biopet-seattleseqkit is a specialized toolset designed to process and manipulate SeattleSeq output files. It streamlines the workflow of handling large annotation datasets by providing mechanisms to extract variants within specific genomic coordinates (via BED files) and filter records based on custom field criteria. Additionally, it includes functionality to transform variant-level annotations into gene-level matrices, which is essential for comparative genomic studies and population-scale analysis.

## Tool Components and Usage

The kit consists of three primary sub-commands. Access them using the following pattern:
`biopet-seattleseqkit <ToolName> [options]`

### 1. Filter
Use this tool to subset a SeattleSeq file.
- **Regional Filtering**: Provide a BED file to retain only the variants located within specified genomic regions.
- **Field Filtering**: Apply filters to specific annotation fields to remove low-quality or irrelevant variants.
- **Best Practice**: Always use regional filtering first to significantly reduce file size before performing complex field-based logic.

### 2. MultiFilter
Use this tool for more complex filtering scenarios. While similar to the standard Filter tool, it is designed to handle multiple filtering criteria or potentially multiple input streams to produce a refined subset of the SeattleSeq data.

### 3. MergeGenes
Use this tool to aggregate data after the filtering steps.
- **Matrix Creation**: It combines gene counts from multiple filtered outputs into a single combined matrix.
- **Data Integrity**: The tool automatically fills missing gene entries with a value of `0`, ensuring the resulting matrix is complete and ready for statistical software.
- **Workflow Tip**: This is the final step in the SeattleSeqKit pipeline, transforming variant annotations into a format suitable for gene-based association studies.

## Common CLI Patterns
While specific flags may vary by version, the standard Biopet tool structure applies:

```bash
# General syntax
biopet-seattleseqkit <Tool> -i <input_file> -o <output_file> [additional_args]

# Example: Filtering by region
biopet-seattleseqkit Filter --input sample.seattleseq.txt --bedFile regions.bed --output filtered.txt

# Example: Merging gene counts
biopet-seattleseqkit MergeGenes --input filtered_sample1.txt --input filtered_sample2.txt --output combined_matrix.tsv
```

## Expert Tips
- **Memory Management**: Since these tools are written in Scala, ensure the JVM has sufficient heap space for large SeattleSeq files by using environment variables like `JAVA_OPTS="-Xmx4G"`.
- **Zero-Filling**: When using `MergeGenes`, remember that the output matrix is designed for compatibility; the automatic zero-filling is crucial for R or Python-based downstream analysis where "NA" values might cause errors.
- **Field Names**: Ensure that field-based filtering uses the exact column headers found in the SeattleSeq output, as these are case-sensitive.

## Reference documentation
- [biopet-seattleseqkit - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_biopet-seattleseqkit_overview.md)
- [GitHub - biopet/seattleseqkit](./references/github_com_biopet_seattleseqkit.md)