---
name: phyloflash
description: phyloFlash is a bioinformatics pipeline that performs taxonomic profiling and targeted assembly of SSU rRNA sequences from metagenomic data. Use when user asks to profile microbial community composition, assemble ribosomal RNA genes from raw reads, or compare taxonomic diversity across multiple metagenomic samples.
homepage: https://github.com/HRGV/phyloFlash
---

# phyloflash

## Overview
phyloFlash is a specialized bioinformatics pipeline designed to bypass the heavy computational requirements of full metagenomic assembly when the primary goal is taxonomic profiling. It works by specifically targeting Small Subunit (SSU) rRNA reads, mapping them against the SILVA database, and performing targeted assembly. This allows for high-resolution phylogenetic analysis even from low-abundance organisms that might fail to assemble in a standard global assembly.

## Core Workflow and CLI Patterns

### 1. Environment and Database Setup
Before running analysis, ensure the environment is functional and the SILVA database is correctly indexed.

*   **Check Environment**: `phyloFlash.pl -check_env`
*   **Database Path**: Always specify the location of the formatted SILVA database using `-dbhome`.
*   **Custom Database**: If using a non-preformatted SILVA release, use `phyloFlash_makedb.pl`.

### 2. Standard Analysis Runs
The main driver is `phyloFlash.pl`. Use the following patterns based on your data type:

*   **Recommended Default (SPAdes assembly)**:
    `phyloFlash.pl -lib <NAME> -dbhome <DB_PATH> -read1 R1.fq.gz -read2 R2.fq.gz -almosteverything -CPUs <INT>`
    *Note: `-almosteverything` is the standard "best practice" flag for most users.*

*   **Interleaved Reads**:
    `phyloFlash.pl -lib <NAME> -read1 interleaved.fq.gz -interleaved -almosteverything`

*   **Single-Cell (MDA) or Low Diversity**:
    Add the `-sc` flag to optimize assembly parameters for non-uniform coverage.

*   **Maximum Sensitivity**:
    Use `-everything` to run both SPAdes and EMIRGE for rRNA reconstruction, though this significantly increases runtime.

### 3. Advanced Processing Options
*   **Alternative Mapping**: Use `-sortmerna` instead of the default BBmap if higher sensitivity for divergent SSU sequences is required.
*   **Trusted Contigs**: If you have an existing assembly, use `-trusted contigs.fasta` to screen those contigs for SSU sequences alongside the raw reads.
*   **Output Management**: Use `-zip` to automatically package results into a tarball and `-log` to ensure a record of the run parameters is preserved.

### 4. Multi-Sample Comparison
After running individual samples, use `phyloFlash_compare.pl` to generate comparative visualizations.

*   **Generate Heatmaps/Barplots**:
    `phyloFlash_compare.pl -task all -out <PREFIX> <SAMPLE1_FOLDER> <SAMPLE2_FOLDER> ...`
*   **Distance Matrices**: Use `-task distance` to calculate beta-diversity metrics between samples based on SSU abundances.

## Expert Tips
*   **Resource Allocation**: By default, phyloFlash attempts to use all available CPUs. Always specify `-CPUs` in shared HPC environments to avoid job termination.
*   **Read Accessions**: Use `ENA_phyloFlash.pl` to automate the download and processing of public datasets directly from the European Nucleotide Archive.
*   **Assembly Graphs**: If you have a `.fastg` file from a metagenome assembly, use `phyloFlash_fastgFishing.pl` to "fish out" contigs connected to identified SSU sequences, helping to link phylogeny to genomic context.



## Subcommands

| Command | Description |
|---------|-------------|
| phyloFlash.pl | Runs the phyloFlash pipeline to assemble and annotate eukaryotic viral genomes from sequencing data. |
| phyloFlash_compare.pl | Compare phyloFlash runs. |

## Reference documentation
- [phyloFlash GitHub Repository](./references/github_com_HRGV_phyloFlash.md)
- [phyloFlash Documentation/Wiki](./references/github_com_HRGV_phyloFlash_wiki.md)