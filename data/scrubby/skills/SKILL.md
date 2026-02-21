---
name: scrubby
description: Scrubby is a specialized tool designed for the depletion of background DNA (such as host contamination) from metagenomic sequencing datasets.
homepage: https://github.com/esteinig/scrubby
---

# scrubby

## Overview

Scrubby is a specialized tool designed for the depletion of background DNA (such as host contamination) from metagenomic sequencing datasets. It supports both short-read (Illumina) and long-read (Oxford Nanopore) data. You should use this skill to generate command-line workflows for filtering raw FASTQ files, extracting specific taxa of interest, or post-processing classification and alignment results to refine read sets. It integrates with common bioinformatic tools like Bowtie2, Minimap2, and Kraken2 to provide a unified interface for read cleaning.

## Core Workflows

### 1. Read Depletion and Extraction
The `reads` command is the primary entry point for filtering FASTQ files.

*   **Paired-end Depletion (Bowtie2 default):**
    `scrubby reads -i r1.fq r2.fq -o clean1.fq clean2.fq -I chm13v2`
*   **Long-read Depletion (Minimap2):**
    `scrubby reads -i reads.fq -o clean.fq -I reference.fa.gz --preset lr-hq`
*   **Read Extraction:** Add the `-e` or `--extract` flag to keep only the reads that match the reference/taxa instead of removing them.
    `scrubby reads -e -i r1.fq r2.fq -o target1.fq target2.fq -I reference_index`

### 2. Post-Classification Cleaning
Use the `classifier` command to filter reads based on existing Kraken2 or Metabuli outputs.

*   **Filter by Taxon Name or ID:**
    `scrubby classifier --input r1.fq r2.fq --output clean1.fq clean2.fq --report kraken2.report --reads kraken2.reads --taxa Chordata --taxa-direct 9606`

### 3. Alignment-based Filtering
The `alignment` command allows for fine-grained filtering of reads using mapping statistics from SAM, BAM, CRAM, or PAF files.

*   **Filter by Quality and Coverage:**
    `scrubby alignment --input r1.fq --output clean.fq --alignment map.paf --min-len 50 --min-cov 0.5 --min-mapq 50`
*   **Piping from Minimap2:**
    `minimap2 -x map-ont ref.fa r.fq | scrubby alignment -a - -f paf -i r.fq -o c.fq`

### 4. Reference Management
Before running depletion, you must have an index. Scrubby can download pre-built indices (e.g., the CHM13 human reference).

*   **List and Download:**
    `scrubby download --list`
    `scrubby download --name chm13v2 --aligner bowtie2 minimap2`

## Best Practices and Tips

*   **Pre-processing:** Always perform quality and adapter trimming (e.g., using fastp or Porechop) before running Scrubby.
*   **Paired-end Consistency:** Scrubby maintains pair integrity; if one read in a pair is flagged for depletion, the entire pair is removed to prevent "orphaned" reads.
*   **Resource Management:** Use the `-t` flag to specify threads and `-w` to set a specific working directory for temporary files, which is critical when processing large metagenomic datasets.
*   **Verification:** Use the `diff` command to compare input and output files to verify the number of reads removed and obtain a list of depleted read IDs.
    `scrubby diff -i in.fq -o out.fq -j stats.json -r removed_ids.tsv`
*   **Compression:** Scrubby handles `.gz` input and output automatically based on the file extension.

## Reference documentation
- [Scrubby GitHub Repository](./references/github_com_esteinig_scrubby.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_scrubby_overview.md)