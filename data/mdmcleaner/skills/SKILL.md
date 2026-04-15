---
name: mdmcleaner
description: mdmcleaner is a bioinformatics pipeline designed to identify and remove contamination from microbial genomes using a reference-aware least common ancestor approach. Use when user asks to clean genomes, build or download reference databases, assess bin completeness, or extract marker genes.
homepage: https://github.com/KIT-IBG-5/mdmcleaner
metadata:
  docker_image: "quay.io/biocontainers/mdmcleaner:0.8.7--pyh7cba7a3_0"
---

# mdmcleaner

## Overview

mdmcleaner is a specialized bioinformatics pipeline designed to handle the fragmented nature of "microbial dark matter" genomes. Unlike standard tools, it is reference-DB contamination aware, meaning it can recognize potential contaminants within the reference datasets themselves using a "least common ancestor" (LCA) approach. It integrates GTDB, SILVA, and RefSeq data to provide high-resolution classification without overclassifying sequences that lack strong reference support.

## Core Workflows

### 1. Database Initialization
Before cleaning genomes, a reference database must be built or downloaded. This is a resource-intensive process.

*   **Build most recent DB**: Downloads latest GTDB, RefSeq, and Silva data.
    ```bash
    mdmcleaner makedb -o /path/to/database_dir
    ```
*   **Download publication data**: For reproducibility (note: this data is older).
    ```bash
    mdmcleaner makedb --get_pub_data -o /path/to/database_dir
    ```
*   **Best Practice**: Use `nohup` or `screen` for `makedb` as it can take 13-18+ hours.

### 2. Genome Cleaning and Assessment
The `clean` command is the primary entry point for assessing and filtering contamination.

*   **Basic Cleaning**:
    ```bash
    mdmcleaner clean -i input_folder -o output_folder --db_basedir /path/to/database
    ```

### 3. Configuration Management
mdmcleaner uses a hierarchy where CLI arguments override local configs, and local configs override global configs.

*   **Create local config**: Generates `mdmcleaner.config` in the current directory.
    ```bash
    mdmcleaner set_configs -s local --db_basedir /path/to/database --threads 16
    ```
*   **View active settings**:
    ```bash
    mdmcleaner show_configs
    ```

### 4. Accessory Commands
*   **Extract Markers**: Get marker gene sequences from input genomes.
    ```bash
    mdmcleaner get_markers -i input_genome.fasta -o markers_out
    ```
*   **Quick Completeness**: Assess bin completeness based on tRNA types.
    ```bash
    mdmcleaner completeness -i input_folder
    ```
*   **Taxonomy Lookup**: Get the full taxonomic path for a GTDB accession.
    ```bash
    mdmcleaner acc2taxpath --acc <ACCESSION_ID>
    ```

## Expert Tips

*   **Dependency Check**: Always run `mdmcleaner check_dependencies` after installation to ensure `blastn`, `blastp`, `diamond`, `hmmer`, `barrnap`, `aragorn`, and `prodigal` are correctly mapped in your PATH or config.
*   **Contamination Thresholds**: If a bin is flagged as highly contaminated, exercise caution when using the "cleaned" output; the tool provides a warning if the remaining data might be insufficient for reliable downstream analysis.
*   **Resuming Downloads**: The `makedb` command is checkpoint-aware. If a download or processing step is interrupted, simply run the same command again to resume.



## Subcommands

| Command | Description |
|---------|-------------|
| mdmcleaner acc2taxpath | Convert accessions to taxonomic paths. |
| mdmcleaner check_dependencies | Checks if all required dependencies for MDMcleaner are met. |
| mdmcleaner completeness | Completeness analysis for mdmcleaner |
| mdmcleaner get_markers | Extracts marker genes from input FASTA files. |
| mdmcleaner makedb | Builds the reference database for MDMcleaner. |
| mdmcleaner refdb_contams | Analyze the ambiguity report file to identify and manage contaminants in a reference database. |
| mdmcleaner set_configs | Set mdmcleaner configuration options. |
| mdmcleaner show_configs | Show MDMcleaner configurations |
| mdmcleaner_clean | Clean input fastas of genomes and/or bins. |

## Reference documentation
- [MDMcleaner GitHub Overview](./references/github_com_KIT-IBG-5_mdmcleaner.md)
- [Getting the reference database](./references/github_com_KIT-IBG-5_mdmcleaner_wiki_Getting-the-reference-database.md)
- [MDMcleaner Wiki Home](./references/github_com_KIT-IBG-5_mdmcleaner_wiki.md)