---
name: krakentools
description: KrakenTools is a suite of Python scripts designed to process, manipulate, and visualize taxonomic classification data from the Kraken software family. Use when user asks to extract specific sequences by taxonomy ID, merge multiple metagenomic reports, convert classification data into MPA or Krona formats, or calculate alpha and beta diversity metrics.
homepage: https://github.com/jenniferlu717/KrakenTools
metadata:
  docker_image: "quay.io/biocontainers/krakentools:1.2.1--pyh7e72e81_0"
---

# krakentools

## Overview
KrakenTools is a suite of specialized Python scripts designed to process the output of the Kraken software family. While Kraken provides the initial taxonomic classification, KrakenTools enables the practical manipulation of that data. Use this skill when you need to isolate sequences belonging to specific taxa, compare multiple metagenomic samples, or transform classification reports into formats compatible with other bioinformatics tools like Krona or MetaPhlAn.

## Core CLI Patterns

### Extracting Classified Reads
Use `extract_kraken_reads.py` to isolate sequences assigned to specific Taxonomy IDs. This is particularly useful for pulling out all viral reads or specific pathogen sequences from a large metagenomic dataset.

*   **Basic Extraction:**
    `python extract_kraken_reads.py -k input.kraken -s input.fastq -o extracted.fastq -t <TaxID>`
*   **Extracting a Subtree (Children):**
    Include the `--include-children` flag and provide the Kraken report file (`-r`) to extract the specified TaxID and everything below it in the lineage.
    `python extract_kraken_reads.py -k input.kraken -s input.fastq -r input.kreport -t 2 --include-children -o bacteria_reads.fastq`
*   **Excluding Taxa:**
    Use `--exclude` to get everything *except* the specified TaxID (e.g., removing human contamination).
    `python extract_kraken_reads.py -k input.kraken -s input.fastq -t 9606 --exclude -o non_human.fastq`

### Merging and Comparing Samples
When working with multiple samples, use these scripts to create comparative tables.

*   **Combine Kraken Reports:**
    Merges multiple `.kreport` files into a single tab-delimited file.
    `python combine_kreports.py --report-files sample1.kreport sample2.kreport --output combined_reports.txt`
*   **Convert to MPA Format:**
    Converts a Kraken report to the MetaPhlAn-style 2-column format (taxonomy string and count), which is often required for downstream statistical tools.
    `python kreport2mpa.py -r input.kreport -o output.mpa.txt`

### Visualization and Diversity
*   **Krona Visualization:**
    Convert a Kraken report into a format compatible with `ktImportText` to create interactive pie charts.
    `python kreport2krona.py -r input.kreport -o output.krona`
*   **Diversity Metrics:**
    Calculate alpha diversity (within-sample) or beta diversity (between-sample) using scripts in the `DiversityTools` directory.
    `python alpha_diversity.py -f combined_reports.txt -a shannon`

## Expert Tips
*   **Gzipped Input:** Most KrakenTools scripts automatically detect and handle `.gz` files for sequence inputs, saving disk space and decompression time.
*   **Paired-End Reads:** When extracting reads from paired-end data, always provide both input files (`-s1`, `-s2`) and both output files (`-o`, `-o2`) to maintain pair synchronization.
*   **Taxonomy Requirements:** Scripts that involve lineage logic (like `--include-children`) require the Kraken report file (`-r`), not just the raw classification file, because the report contains the tree structure.
*   **Dependencies:** Ensure `Biopython` is installed in your environment, as it is required for sequence extraction scripts.

## Reference documentation
- [KrakenTools GitHub README](./references/github_com_jenniferlu717_KrakenTools.md)
- [DiversityTools Overview](./references/github_com_jenniferlu717_KrakenTools_tree_master_DiversityTools.md)
- [Bioconda Installation](./references/anaconda_org_channels_bioconda_packages_krakentools_overview.md)