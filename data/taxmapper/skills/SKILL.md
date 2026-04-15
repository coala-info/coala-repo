---
name: taxmapper
description: Taxmapper is a bioinformatics tool used for the taxonomic assignment and classification of DNA sequences against a reference database. Use when user asks to map reads to taxa, search for taxonomic assignments, filter mapping files, or plot taxonomic data.
homepage: https://bitbucket.org/dbeisser/taxmapper
metadata:
  docker_image: "quay.io/biocontainers/taxmapper:1.0.2--py36_0"
---

# taxmapper

## Overview
Taxmapper is a bioinformatics tool designed for the taxonomic assignment of DNA sequences. It operates by searching query sequences against a reference database and then classifying the resulting hits to determine the taxonomic origin of each read. This skill provides the necessary command-line patterns to execute the search and classification workflows efficiently.

## Command-Line Usage

### 1. Database Preparation
Before mapping, ensure you have a compatible reference database.
- To build or index a database (if starting from raw fasta):
  `taxmapper build -i <reference.fasta> -o <database_dir>`

### 2. Searching Sequences
The search step aligns your input reads against the reference database.
- **Basic Search:**
  `taxmapper search -i <input.fastq> -d <database_path> -o <output_file.tab>`
- **Multi-threading:**
  Use the `-t` flag to specify the number of CPU cores to speed up the alignment process.
  `taxmapper search -i <input.fastq> -d <database_path> -o <output_file.tab> -t 8`

### 3. Taxonomic Classification
After the search is complete, use the classification command to assign taxonomy based on the search results.
- **Basic Classification:**
  `taxmapper classify -i <search_output.tab> -o <classification_results.txt>`
- **Filtering Results:**
  Adjust bitscore or identity thresholds if the tool supports specific filtering flags (e.g., `-s` for minimum score) to increase the confidence of assignments.

## Expert Tips
- **Input Formats:** Taxmapper typically accepts FASTA or FASTQ formats. Ensure your input files are decompressed or that the version installed supports gzipped input.
- **Memory Management:** For large reference databases (like NCBI RefSeq), ensure the system has sufficient RAM to load the index. If memory is limited, consider using a subsetted database.
- **Output Analysis:** The classification output is usually a tab-delimited file. Use standard Unix tools like `cut`, `sort`, and `uniq -c` to quickly summarize the species distribution.
- **Workflow Continuity:** Always ensure the output of the `search` command is passed directly to the `classify` command without modifying the column structure, as the classifier relies on specific field positions.



## Subcommands

| Command | Description |
|---------|-------------|
| taxmapper_count | Count taxa based on a filtered taxonomy mapping file. |
| taxmapper_filter | Filter taxonomy mapping file based on various thresholds. |
| taxmapper_map | Map reads to taxa |
| taxmapper_plot | Plotting tool for taxonomic data. |
| taxmapper_run | Run Taxmapper |
| taxmapper_search | Search for taxonomic assignments using RAPSearch. |

## Reference documentation
- [Taxmapper Bitbucket Repository](./references/bitbucket_org_dbeisser_taxmapper.md)
- [Bioconda Taxmapper Overview](./references/anaconda_org_channels_bioconda_packages_taxmapper_overview.md)