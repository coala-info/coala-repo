---
name: bgt
description: "This tool provides flexible genotype querying across large whole-genome datasets. Use when user asks to query genotypes, filter genetic variations, or search genomic data."
homepage: https://github.com/Dysman/bgTools-playerPrefsEditor
---

# bgt

Provides flexible genotype querying across large whole-genome datasets.
  Use when needing to efficiently search and filter genetic variations among thousands of samples.
  This skill is specifically for the 'bgt' tool, a command-line utility for genotype analysis.
body: |
  ## Overview
  The 'bgt' tool is designed for high-throughput genotype querying across extensive genomic datasets. It allows users to efficiently search and filter genetic variations across tens of thousands of samples, making it invaluable for population genetics, variant analysis, and large-scale genomic studies. This skill focuses on leveraging the command-line interface of 'bgt' for optimal performance and flexibility.

  ## Usage Instructions

  The `bgt` tool is primarily used via its command-line interface. The core functionality revolves around querying genotype data.

  ### Basic Querying

  To perform a basic genotype query, you typically specify the input genotype file and the query criteria.

  **Example:**
  ```bash
  bgt query --genotype-file input.vcf --region chr1:10000-20000 --samples sample_list.txt --output query_results.tsv
  ```

  *   `--genotype-file`: Path to the input genotype file (e.g., VCF format).
  *   `--region`: Specifies the genomic region to query (e.g., `chr1:10000-20000`).
  *   `--samples`: A file containing a list of sample IDs to include in the query.
  *   `--output`: The file where the query results will be saved.

  ### Filtering Options

  `bgt` offers various filtering options to refine your queries.

  *   **Allele Frequency Filtering:**
      ```bash
      bgt query --genotype-file input.vcf --min-allele-freq 0.05 --output freq_filtered.tsv
      ```
      This filters for variants with a minimum allele frequency of 5%.

  *   **Variant Quality Filtering:**
      ```bash
      bgt query --genotype-file input.vcf --min-qual 30 --output qual_filtered.tsv
      ```
      This filters for variants with a minimum quality score of 30.

  ### Advanced Usage and Tips

  *   **Parallel Processing:** For large datasets, leverage multi-threading if supported by your `bgt` installation to speed up queries. Consult the `bgt` documentation for specific parallelization flags.
  *   **Output Formats:** Explore different output formats (e.g., TSV, VCF) to best suit your downstream analysis needs.
  *   **Sample Management:** For very large numbers of samples, ensure your sample list file is correctly formatted and that `bgt` can efficiently process it.
  *   **Region Specification:** Use precise region specifications for targeted queries to reduce processing time and memory usage. Consider using BED files for complex region definitions if supported.

  Always refer to the official `bgt` documentation for the most up-to-date command-line options and advanced features.



## Subcommands

| Command | Description |
|---------|-------------|
| bgt atomize | Atomize a VCF/BCF file |
| bgt bcfidx | Index a BCF file. |
| bgt import | Import VCF/BCF files into BGT format |
| bgt view | View and convert VCF/BCF files |
| fmf | Process FMF files |

## Reference documentation
- [bgt - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_bgt_overview.md)