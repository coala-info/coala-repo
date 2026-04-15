---
name: kaiju
description: Kaiju is a taxonomic classifier that translates metagenomic DNA reads into amino acid sequences to search against protein reference databases. Use when user asks to classify metagenomic reads, perform taxonomic assignment, or generate abundance reports for microbial communities.
homepage: https://kaiju.binf.ku.dk/
metadata:
  docker_image: "quay.io/biocontainers/kaiju:1.10.1--h5ca1c30_3"
---

# kaiju

## Overview
Kaiju is a taxonomic classifier that translates metagenomic DNA reads into amino acid sequences and searches them against a reference database of protein sequences (e.g., NCBI nr, proGenomes). By working in the protein space, Kaiju achieves higher sensitivity than DNA-based classifiers, especially for identifying highly divergent sequences or novel species that are not identical to known genomes but share conserved protein domains.

## Usage Guidelines

### Core Workflow
The standard Kaiju pipeline involves three main steps: classification, taxonomic assignment, and visualization.

1.  **Classification**: Run the core engine to compare reads against the index.
    ```bash
    kaiju -t nodes.dmp -f kaiju_db.fmi -i input_reads.fastq -o output.kaiju
    ```
    *   `-t`: Path to the NCBI taxonomy `nodes.dmp` file.
    *   `-f`: Path to the Kaiju index file (`.fmi`).
    *   `-i`: Input file (supports FASTQ/FASTA). For paired-end, use `-i read1.fq -j read2.fq`.

2.  **Taxonomic Assignment**: Convert the raw output into a human-readable format with taxon names.
    ```bash
    kaiju-addTaxon -t nodes.dmp -n names.dmp -i output.kaiju -o output.names.kaiju
    ```

3.  **Abundance Reporting**: Generate a summary table of taxa at a specific rank (e.g., genus).
    ```bash
    kaiju2table -t nodes.dmp -n names.dmp -r genus -o abundance_table.tsv output.kaiju
    ```

### Optimization Tips
*   **Search Modes**: Use `-a` to toggle between "greedy" (default, allows substitutions) and "mem" (exact matches). Greedy mode is generally preferred for higher sensitivity.
*   **Filtering**: Use the `-e` parameter to specify the number of allowed mismatches in greedy mode. Increasing this can find more distant homologs but may increase false positives.
*   **Parallelization**: Always use the `-z` flag to specify the number of threads (e.g., `-z 16`) to significantly speed up the classification of large datasets.
*   **Memory Management**: Kaiju loads the entire index into RAM. Ensure your system has enough memory to accommodate the specific database used (e.g., the NCBI nr database requires >100GB RAM).

### Common CLI Patterns
*   **Paired-end reads**: `kaiju -t nodes.dmp -f db.fmi -i R1.fq -j R2.fq -z 8`
*   **Filtering low-confidence hits**: Use `kaiju2table -m 0.1` to only include taxa that represent at least 0.1% of the total reads, reducing noise in the final report.
*   **Creating Krona charts**:
    ```bash
    kaiju2krona -t nodes.dmp -n names.dmp -i output.kaiju -o output.krona
    ktImportText -o report.html output.krona
    ```

## Reference documentation
- [Kaiju Overview](./references/anaconda_org_channels_bioconda_packages_kaiju_overview.md)