---
name: fastqpuri
description: FastqPuri is a high-performance suite for the quality assessment, trimming, and contamination filtering of Next-Generation Sequencing data. Use when user asks to generate quality reports, create Bloom filters for contaminants, or perform single-end and paired-end read trimming and filtering.
homepage: https://github.com/jengelmann/FastqPuri
---


# fastqpuri

## Overview
FastqPuri is a high-performance suite designed for the pre-processing of Next-Generation Sequencing (NGS) data. It provides a complete workflow from initial quality assessment to the generation of "clean" FASTQ files. Its primary strengths lie in its ability to handle contamination filtering through efficient data structures like Bloom filters and its integrated R-based reporting system that visualizes quality metrics before and after trimming.

## Core Executables and CLI Patterns

### 1. Quality Assessment (Qreport & Sreport)
Generate detailed quality metrics. These tools require `Rscript`, `pandoc`, and specific R packages (`pheatmap`, `knitr`, `rmarkdown`) to produce HTML outputs.

*   **Generate a single report:**
    ```bash
    Qreport -f input.fastq -o output_prefix
    ```
*   **Generate a summary report for multiple samples:**
    Use `Sreport` to aggregate results from multiple `Qreport` runs to compare sample quality across a project.

### 2. Contamination Preparation (makeBloom & makeTree)
Before filtering for contamination (e.g., removing unwanted rRNA), you must represent the contaminant reference sequences in a searchable format.

*   **Create a Bloom filter:**
    ```bash
    makeBloom -f contaminants.fasta -o contaminants.bloom -k 25 -s 100M
    ```
    *Note: `-k` sets the k-mer size; `-s` sets the filter size.*

*   **Create a Tree filter:**
    ```bash
    makeTree -f contaminants.fasta -o contaminants.tree -d 10
    ```

### 3. Trimming and Filtering (trimFilter & trimFilterPE)
This is the primary processing step. It handles adapter trimming, quality filtering, and contamination removal simultaneously.

*   **Single-End Filtering:**
    ```bash
    trimFilter -f input.fastq -o filtered_output -q 20 -c contaminants.bloom
    ```

*   **Paired-End Filtering:**
    ```bash
    trimFilterPE -f1 forward.fastq -f2 reverse.fastq -o1 filtered_1.fastq -o2 filtered_2.fastq -q 25 --trim-adapters
    ```

## Expert Tips and Best Practices

*   **Workflow Sequence:** Always follow the "Report -> Filter -> Report" sandwich. Run `Qreport` on raw data, perform `trimFilter`, then run `Qreport` on the output to verify the effectiveness of the parameters.
*   **Memory Management:** When using `makeBloom`, ensure the size (`-s`) is large enough to minimize false positives but fits within your system's RAM.
*   **Contamination Strategy:** Bloom filters are generally faster and more memory-efficient for large contaminant databases (like a whole genome), while Trees can be effective for smaller, specific sequences.
*   **Dependency Check:** If HTML reports are not generating, verify that `Rscript` and `pandoc` are in your PATH. FastqPuri will still perform filtering without them but will skip the visual report generation.
*   **Maximum Read Length:** By default, the tool is often compiled for a maximum Illumina read length of 400bp. If working with longer reads, ensure the tool was compiled with the appropriate `READ_MAXLEN` flag.



## Subcommands

| Command | Description |
|---------|-------------|
| ./Qreport | Reads in a fq file (gz, bz2, z formats also accepted) and creates a quality report (html file) along with the necessary data to create it stored in binary format. |
| ./Sreport | Uses all *bin files found in a folder (output of Qreport\|trimFilter\|trimFilterPE) and generates a summary report in html format (of Qreport\|trimFilter\|trimFilterPE). |
| makeBloom | makeBloom from FastqPuri |
| makeTree | Reads a *fa file, constructs a tree of depth DEPTH and saves it compressed in OUTPUT_FILE. |
| trimFilter | Reads in a fq file (gz, bz2, z formats also accepted) and removes: low quality reads, reads containing N base callings, reads representing contaminations, belonging to sequences in INPUT.fa |
| trimFilterPE | Reads in paired end fq files (gz, bz2, z formats also accepted) and removes: low quality reads, reads containing N base callings, reads representing contaminations, belonging to sequences in INPUT.fa. Outputs 8 [O_PREFIX][1\|2]_fq.gz files containing: "good" reads, discarded low Q reads, discarded reads containing N's, discarded contaminations. |

## Reference documentation
- [FastqPuri GitHub Repository](./references/github_com_jengelmann_FastqPuri.md)
- [FastqPuri README](./references/github_com_jengelmann_FastqPuri_blob_master_README.md)