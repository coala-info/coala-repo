---
name: squire
description: SQuIRE is a pipeline for the locus-specific quantification and differential expression analysis of transposable elements from RNA-seq data. Use when user asks to fetch genomic resources, clean repeat annotations, map reads to a reference, quantify locus-specific repeat expression, or call differential expression of transposable elements.
homepage: https://github.com/wyang17/SQuIRE
metadata:
  docker_image: "quay.io/biocontainers/squire:0.9.9.92--pyhdfd78af_1"
---

# squire

## Overview
SQuIRE (Software for Quantifying Interspersed Repeat Expression) is a comprehensive pipeline designed to provide locus-specific quantification of transposable elements. Unlike tools that only provide subfamily-level summaries, SQuIRE uses an expectation-maximization algorithm to disambiguate multi-mapping reads, allowing researchers to identify exactly which genomic instances of a repeat are transcriptionally active. It is particularly useful for studying the regulatory roles of specific TEs in development, disease, or stress responses.

## Core Workflow and CLI Patterns

The SQuIRE pipeline is divided into four main stages: Preparation, Quantification, Analysis, and Follow-up.

### 1. Preparation Stage
Before processing RNA-seq data, you must fetch genomic resources and clean the repeat annotations.

*   **Fetch Resources**: Downloads chromosome fastas, RefGene annotations, and RepeatMasker files.
    ```bash
    squire Fetch -b hg38 -f -c -r -g -x -p 8
    ```
    *   `-b`: UCSC genome build (e.g., hg38, mm10).
    *   `-x`: Generates the STAR index (resource intensive).
*   **Clean Annotations**: Filters and formats the RepeatMasker file into a BED file.
    ```bash
    squire Clean -b hg38 -c DNA,LTR -o squire_clean_folder
    ```
    *   `-c`: Specify repeat classes (e.g., LTR, DNA, SINE, LINE). Wildcards are supported.

### 2. Quantification Stage
This stage aligns your reads and assigns them to specific TE loci.

*   **Map Reads**: Uses STAR to align RNA-seq data.
    ```bash
    squire Map -1 sample_R1.fastq.gz -2 sample_R2.fastq.gz -o map_out -p 8 -r 100 -b hg38
    ```
    *   `-r`: Read length is required for proper alignment parameters.
*   **Count Loci**: Quantifies reads using an EM algorithm to handle multi-mappers.
    ```bash
    squire Count -m map_out -c squire_clean_folder -o count_out -p 8 -b hg38
    ```

### 3. Analysis Stage
*   **Call Differential Expression**: Compiles counts and runs DESeq2.
    ```bash
    squire Call -n control,control,treat,treat -o call_out -p 8
    ```
    *   `-n`: Comma-separated labels for your samples.

### 4. Follow-up Stage
*   **Draw**: Generates BigWig/BedGraph files for visualization in genome browsers.
*   **Seek**: Extracts the actual sequences of the quantified TEs.

## Expert Tips and Best Practices

*   **Software Compatibility**: SQuIRE is highly sensitive to dependency versions (e.g., STAR 2.5.3a, Python 2.7). It is strongly recommended to use the provided Conda/Mamba environment or run `squire Build -s all` if manual installation fails.
*   **Memory Management**: The `Fetch -x` (indexing) and `Map` steps are memory-intensive. Ensure your environment has at least 32GB of RAM for human or mouse genomes.
*   **Read Length**: Always provide the correct read length (`-r`) in the `Map` step, as SQuIRE uses this to calculate the appropriate `sjdbOverhang` for STAR.
*   **Multi-mapping**: SQuIRE's strength is its EM algorithm. If you have very short reads (e.g., <50bp), the ability to uniquely assign TE expression decreases significantly due to the repetitive nature of the sequences.
*   **Custom Repeats**: You can incorporate non-reference TE sequences by providing them in the appropriate format during the `Clean` stage.



## Subcommands

| Command | Description |
|---------|-------------|
| squire | squire: error: invalid choice: 'build' (choose from 'Build', 'Fetch', 'Clean', 'Map', 'Count', 'Call', 'Draw', 'Seek') |
| squire | squire: error: invalid choice: 'clean' (choose from 'Build', 'Fetch', 'Clean', 'Map', 'Count', 'Call', 'Draw', 'Seek') |
| squire | A command-line tool for genomic analysis. |
| squire | squire: error: invalid choice: 'fetch' (choose from 'Build', 'Fetch', 'Clean', 'Map', 'Count', 'Call', 'Draw', 'Seek') |
| squire | A command-line tool for genomic analysis. |
| squire | A command-line tool for genomic analysis. |

## Reference documentation
- [SQuIRE README and Pipeline Overview](./references/github_com_wyang17_SQuIRE_blob_master_README.md)
- [SQuIRE Repository Structure](./references/github_com_wyang17_SQuIRE.md)