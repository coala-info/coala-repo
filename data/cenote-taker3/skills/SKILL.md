---
name: cenote-taker3
description: Cenote-Taker 3 is a virus bioinformatics pipeline that identifies and annotates viral sequences in metagenomic assemblies or individual genomes using hallmark gene detection. Use when user asks to identify viral sequences in DNA contigs, discover prophages in microbial genomes, or provide functional and taxonomic annotations for confirmed viruses.
homepage: https://github.com/mtisza1/Cenote-Taker3
metadata:
  docker_image: "quay.io/biocontainers/cenote-taker3:3.4.4--pyhdfd78af_0"
---

# cenote-taker3

## Overview

Cenote-Taker 3 is a high-performance virus bioinformatics pipeline designed to scale from individual genomes to massive metagenomic assemblies. It specializes in identifying "hallmark genes" to detect viral sequences and provides comprehensive functional and taxonomic annotations. This skill should be used when you need to analyze DNA contigs to distinguish viral content from host sequences, particularly in complex environmental samples or when looking for integrated proviruses in bacterial genomes.

## Installation and Database Setup

Before running the main pipeline, the environment must be configured and databases must be downloaded.

1.  **Environment**: Ensure the `ct3_env` is activated.
2.  **Database Download**: Use `get_ct3_dbs` to fetch required HMMs and taxonomy data.
    ```bash
    # Basic database setup (~3.0 GB)
    get_ct3_dbs -o ct3_DBs --hmm T --hallmark_tax T --refseq_tax T --mmseqs_cdd T --domain_list T
    ```
3.  **Environment Variable**: The tool looks for the `CENOTE_DBS` variable.
    ```bash
    conda env config vars set CENOTE_DBS=/path/to/ct3_DBs
    ```

## Common CLI Patterns

### 1. Discovery and Annotation (Default)
Use this for metagenomic contigs where you want to find and annotate all potential viral sequences.
```bash
cenotetaker3 -c contigs.fna -r my_run_title -p T
```
*   `-c`: Input contigs (FASTA).
*   `-r`: Run title (used for output directory and file naming).
*   `-p T`: Enable "Pruning" (discovery mode) to find viral regions.

### 2. Prophage Discovery in Microbial Genomes
When searching for prophages within bacterial or archaeal genomes, increase the hallmark gene threshold to reduce false positives.
```bash
cenotetaker3 -c genome.fna -r prophage_search -p T --lin_minimum_hallmark_genes 2
```

### 3. Annotation Only
Use this when you already have a set of confirmed virus sequences and only need functional/taxonomic annotation.
```bash
cenotetaker3 -c virus_seqs.fna -r annotation_run -p F -am T
```
*   `-p F`: Disable pruning/discovery.
*   `-am T`: Enable annotation mode.

### 4. Advanced Functional Search
To include high-sensitivity protein structure-based searches (requires HH-suite databases):
```bash
# Requires downloading hhCDD, hhPFAM, or hhPDB during get_ct3_dbs
cenotetaker3 -c contigs.fna -r deep_annotation -p T --hhsuite T
```

## Expert Tips and Best Practices

*   **Speed**: Cenote-Taker 3 is significantly faster than version 2. For massive datasets, ensure you are using the default `prodigal-gv` caller unless you have a specific reason to force standard `prodigal` using `--caller prodigal`.
*   **Hallmark Selection**: You can limit the hallmark gene categories used for discovery with the `-db` flag (e.g., `-db virion rdrp` to focus on structural proteins and RNA-dependent RNA polymerases).
*   **Coverage Analysis**: If you have raw sequencing reads, provide them to calculate coverage levels for the identified viruses:
    ```bash
    cenotetaker3 -c contigs.fna -r coverage_run -p T --reads sample_R*.fastq
    ```
*   **Output Review**: Always check `{run_title}_virus_summary.tsv` first for a high-level overview of identified viruses. For visualization, the `.gbf` files in the `sequin_and_genome_maps/` folder can be opened in standard genome browsers.



## Subcommands

| Command | Description |
|---------|-------------|
| cenotetaker3 | Cenote-Taker 3 is a pipeline for virus discovery and thorough annotation of viral contigs and genomes. |
| get_ct3_dbs | Update and/or download databases associated with Cenote-Taker 3. HMM (hmmer) databases: updated January 10th, 2024. RefSeq Virus taxonomy DB compiled July 31, 2023. hallmark taxonomy database added March 19th, 2024 |

## Reference documentation
- [Cenote-Taker3 README](./references/github_com_mtisza1_Cenote-Taker3_blob_main_README.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_cenote-taker3_overview.md)