---
name: humann2
description: HUMAnN2 profiles the functional and metabolic potential of microbial communities by transforming raw sequencing reads into gene family and pathway abundances. Use when user asks to characterize microbial metabolic pathways, quantify gene family abundances from metagenomes or metatranscriptomes, or normalize and regroup functional profiles.
homepage: http://huttenhower.sph.harvard.edu/humann2
---


# humann2

## Overview
HUMAnN 2.0 (HMP Unified Metabolic Analysis Network) is a bioinformatic pipeline designed to answer "what are the microbes doing?" within a community. It transforms raw DNA or RNA sequencing reads into stratified functional profiles. This skill provides the necessary command-line patterns to execute the core pipeline, manage its extensive databases (ChocoPhlAn and UniRef), and process the resulting gene family and pathway tables.

## Core Workflow and CLI Patterns

### 1. Database Initialization
Before running samples, the required nucleotide and protein databases must be downloaded.

*   **Nucleotide (ChocoPhlAn):**
    `humann2_databases --download chocophlan full /path/to/db`
*   **Protein (UniRef):**
    `humann2_databases --download uniref uniref90_ec_filtered_diamond /path/to/db`
    *Tip: Use the `uniref90_ec_filtered_diamond` version for a balance of speed and sensitivity.*

### 2. Basic Execution
The primary command accepts FASTQ (metagenome/metatranscriptome), SAM/BAM (alignments), or TSV (gene tables).

`humann2 --input sample.fastq --output output_dir`

**Key Arguments:**
*   `--nucleotide-database`: Path to ChocoPhlAn if not in default config.
*   `--protein-database`: Path to UniRef if not in default config.
*   `--metaphlan`: Path to the MetaPhlAn2 directory if not in system PATH.
*   `--threads`: Number of CPUs to use (highly recommended for Diamond/Bowtie2 steps).

### 3. Output Interpretation
HUMAnN2 generates three primary files in the output directory:
1.  `[sample]_genefamilies.tsv`: Abundance of gene families (usually in RPKs).
2.  `[sample]_pathabundance.tsv`: Abundance of metabolic pathways.
3.  `[sample]_pathcoverage.tsv`: Presence/absence (0 to 1) of pathways.

### 4. Post-Processing Utilities
After running individual samples, use these utility scripts to prepare data for statistical analysis:

*   **Merge Tables:** Combine multiple sample outputs into a single matrix.
    `humann2_join_tables --input output_dir --output joined_table.tsv`
*   **Normalization:** Convert RPKs to relative abundance or copies per million (CPM).
    `humann2_renorm_table --input joined_table.tsv --output joined_table_cpm.tsv --units cpm`
*   **Regrouping:** Map gene families to other functional categories (e.g., GO terms, KO, EC).
    `humann2_regroup_table --input genefamilies.tsv --groups uniref90_ko --output ko_abundance.tsv`

## Expert Tips and Best Practices
*   **Memory Management:** Ensure at least 16GB of RAM is available. For large datasets using the full UniRef90 database, 32GB+ is safer.
*   **Input Quality:** Always perform adapter trimming and host-read removal (e.g., removing human DNA) before running HUMAnN2 to improve speed and accuracy.
*   **Bypassing Steps:** If you already have MetaPhlAn2 results, you can provide the taxonomic profile using `--taxonomic-profile [file].tsv` to skip the initial taxonomic profiling step.
*   **Temporary Files:** HUMAnN2 creates a `_humann2_temp` folder. If a run crashes, you can often resume or troubleshoot by inspecting the `.log` file inside this directory.



## Subcommands

| Command | Description |
|---------|-------------|
| humann2_regroup_table | Regroup HUMAnN2 table features (e.g. convert UniRef50 gene families to GO terms or KO groups). |
| humann2_renorm_table | Renormalize a HUMAnN2 table to relative abundance or other units. |

## Reference documentation
- [HUMAnN 2.0 Overview and Installation](./references/huttenhower_sph_harvard_edu_humann2.md)
- [HUMAnN 2.0 Database and Run Configuration](./references/huttenhower_sph_harvard_edu_humann2_1.md)