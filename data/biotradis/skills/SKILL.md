---
name: biotradis
description: Bio-Tradis is a toolkit for processing and interpreting transposon mutagenesis libraries to identify essential genes and quantify insertion sites. Use when user asks to process TraDIS sequencing data, map reads to a reference genome, identify essential genes, or perform comparative fitness analysis between growth conditions.
homepage: https://github.com/sanger-pathogens/Bio-Tradis
---

# biotradis

## Overview
Bio-Tradis is a specialized toolkit designed for the processing and interpretation of transposon mutagenesis libraries. It manages the transition from raw sequencing data to biological insights by identifying transposon tags, mapping reads to a reference genome, and quantifying insertion sites. It is particularly effective for identifying essential genes in bacteria and comparing library fitness across different growth conditions.

## Core Workflow and CLI Patterns

### 1. Complete Pipeline Execution
The `bacteria_tradis` script is the primary entry point for a full analysis. It handles mapping and plot generation.

*   **Basic Usage**:
    ```bash
    bacteria_tradis -f fastq_list.txt -r reference.fa -t TAG
    ```
*   **Input Format**: The `-f` flag expects a plain text file containing the paths to your FastQ files, one per line.
*   **Tagging**: If your reads already have TraDIS tags handled, you can run it without the `-t` parameter.

### 2. Pre-processing and Tag Management
If you need to manually handle tags before mapping:
*   **Check for tags**: `check_tradis_tags -b file.bam` (Returns 1 if present, 0 if not).
*   **Filter reads by tag**: `filter_tradis_tags -f reads.fastq -t TAG -m 0` (Use `-m` to allow mismatches).
*   **Remove tags for mapping**: `remove_tradis_tags -f reads.fastq -t TAG` (Prepares reads for standard aligners).

### 3. Quantifying Insertions
After mapping, use `tradis_gene_insert_sites` to map insertion plots to genomic features. This requires a genome annotation in **EMBL** format.

```bash
tradis_gene_insert_sites -g annotation.embl -p sample1.plot.gz sample2.plot.gz
```
This produces tab-delimited files containing gene-wise insertion counts and read counts.

### 4. Downstream Statistical Analysis
Bio-Tradis includes R scripts for high-level analysis:
*   **Gene Essentiality**:
    ```bash
    Rscript tradis_essentiality.R <gene_insert_sites.tab>
    ```
*   **Comparative Analysis (Condition A vs B)**:
    Requires replicates and uses edgeR.
    ```bash
    Rscript tradis_comparison.R <tab_file_1> <tab_file_2> ...
    ```

## Expert Tips and Best Practices

*   **Parameter Tuning**: Default parameters in `bacteria_tradis` are optimized for **comparative experiments**. If performing a **gene essentiality study**, you must manually adjust parameters (such as mapping sensitivity) to ensure high-confidence insertion site detection.
*   **Aligner Selection**: The pipeline uses `bwa` or `smalt`. When using `smalt`, the tool automatically calculates indexing parameters (`-sk` and `-ss`) based on read length:
    *   Reads < 70bp: `-sk 13 -ss 4`
    *   Reads 70-100bp: `-sk 13 -ss 6`
    *   Reads > 100bp: `-sk 20 -ss 13`
*   **Memory Management**: For large datasets, ensure `samtools` and `tabix` are in your PATH, as the pipeline relies on them for indexing and sorting intermediate BAM files.
*   **Docker Usage**: If local dependencies (Perl/R) conflict, use the official container:
    ```bash
    docker run --rm -it -v $(pwd):/data sangerpathogens/bio-tradis bacteria_tradis -h
    ```



## Subcommands

| Command | Description |
|---------|-------------|
| bacteria_tradis | Run a TraDIS analysis. This involves filtering data with tags, removing tags, mapping, creating an insertion site plot, and creating a stats summary. |
| check_tags | Check for the existence of tradis tags in a bam |
| filter_tags | Filters a BAM file and outputs reads with tag matching -t option |
| remove_tags | Removes transposon sequence and quality tags from the read strings |
| tradis_plot | Create insertion site plot for Artemis |

## Reference documentation
- [Bio-Tradis Main Documentation](./references/github_com_sanger-pathogens_Bio-Tradis.md)
- [Bio-Tradis Executables List](./references/github_com_sanger-pathogens_Bio-Tradis_tree_master_bin.md)