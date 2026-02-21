---
name: bio-unicorn
description: bio-unicorn is a specialized tool for metagenomic profiling that extracts high-resolution statistics from short-read alignments.
homepage: https://github.com/GeoGenetics/unicorn
---

# bio-unicorn

## Overview
bio-unicorn is a specialized tool for metagenomic profiling that extracts high-resolution statistics from short-read alignments. Unlike standard tools that only provide read counts, bio-unicorn calculates 28 distinct metrics per reference sequence, including Average Nucleotide Identity (ANI), breadth of coverage, and evenness (Gini coefficient and Entropy). It is designed to help researchers validate the presence of specific organisms in complex samples and filter out noise from multi-mapped reads or low-quality alignments.

## Core Commands and Usage

### 1. Per-Reference Statistics (`refstats`)
Use this to get a granular view of how reads align to every individual reference in your database.

*   **Basic Command:**
    ```bash
    unicorn refstats -b input.bam > statistics.txt
    ```
*   **Filtering on the fly:**
    To reduce noise and output size, apply filters directly during the run.
    ```bash
    unicorn refstats -b input.bam --minreads 10 --minrefl 1000 --outstat filtered_stats.txt
    ```
*   **Key Metrics Produced:**
    *   `m_alnani`: Mean alignment ANI (useful for species-level validation).
    *   `breath_cov`: Breadth of coverage (percentage of reference covered).
    *   `evenness_cov` / `entropy`: Measures of how uniformly reads are spread across the reference.

### 2. Taxonomic Summarization (`tidstats`)
Use this when you have a taxonomy-aware database and want to group statistics by TaxID (e.g., species or genus level).

*   **Required Files:** You must provide NCBI-style taxonomy files (`names.dmp`, `nodes.dmp`) and an accession-to-taxid mapping.
*   **Example:**
    ```bash
    unicorn tidstats -b input.bam -a acc2tax.txt -n names.dmp -d nodes.dmp --rank species > species_stats.txt
    ```
*   **Optimization Tip:** Providing a `.khash` file for the `--acc2tax` option is significantly faster than a raw text mapping.

### 3. Multi-Mapping Resolution (`reassign`)
Use this to filter alignments using an Expectation-Maximization (EM) algorithm. This is critical for metagenomics where a single read might map to multiple closely related species.

*   **Requirement:** The input BAM must be **query-grouped** (collated or sorted by read name).
*   **Example:**
    ```bash
    unicorn reassign -b input.bam -o reassigned_output.bam --alpha 0.80 --niter 5
    ```
*   **Scaling:** Use `--scale-type LENGTH` (default) to account for reference length during reassignment, which prevents longer references from artificially "stealing" reads.

### 4. Global BAM Summary (`bamstats`)
Use this for a quick high-level overview of the entire sequencing run.

*   **Example:**
    ```bash
    unicorn bamstats -b input.bam --printdists
    ```
*   **Note:** The `--printdists` flag generates an auxiliary file (`<input>.dists.txt`) containing distributions for read lengths and alignment lengths.

## Expert Tips and Best Practices

*   **Thread Management:** Most commands support `-t` or `--threads`. For `refstats` and `reassign`, increasing threads significantly reduces wall-clock time on large metagenomes.
*   **Filtering Filtered Alignments:** You can use `refstats` to generate a new, cleaner BAM file while simultaneously calculating stats by using the `--outbam` flag.
*   **Metagenomic Validation:** When confirming a low-abundance hit, look for a combination of high `m_alnani` (>95-97%) and high `evenness_cov`. A high read count with very low evenness often indicates a collapsed repeat or a conserved region rather than a true positive hit.
*   **Memory Efficiency:** If processing hundreds of BAM files, use the `--filelist` option in `bamstats` or `tidstats` to process them in a single command execution.

## Reference documentation
- [bio-unicorn GitHub README](./references/github_com_GeoGenetics_unicorn.md)
- [Bioconda bio-unicorn Overview](./references/anaconda_org_channels_bioconda_packages_bio-unicorn_overview.md)