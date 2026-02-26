---
name: scorpio
description: Scorpio identifies and categorizes viral variants by evaluating genomic alignments against predefined sets of mutations called constellations. Use when user asks to classify sequences into lineages, generate haplotype barcodes for recombination analysis, or define new variant constellations.
homepage: https://github.com/cov-lineages/scorpio
---


# scorpio

## Overview
Scorpio is a specialized genomic utility designed to identify and categorize viral variants using "constellations"—predefined sets of mutations and logical rules. While originally developed for the SARS-CoV-2 pandemic, the tool is species-agnostic and can be applied to any organism provided with the appropriate constellation definitions. It excels at processing large-scale alignments to provide rapid lineage assignments and detailed haplotype information, helping researchers identify recombination, contamination, or novel variant emergence.

## Installation and Setup
Install scorpio via Bioconda for the most stable environment:
```bash
conda install -c bioconda scorpio
```
Note: Scorpio typically requires the `constellations` repository to be present or installed to provide the specific definitions for SARS-CoV-2.

## Core Workflows

### 1. Sequence Classification
The `classify` command is the primary tool for assigning sequences to known lineages. It evaluates sequences against constellation rules (e.g., minimum alternative alleles required).

*   **Basic Classification**:
    ```bash
    scorpio classify -i alignment.fasta --prefix output_results
    ```
*   **Detailed Output**: Use `--long` to include count information for the winning constellation.
    ```bash
    scorpio classify -i alignment.fasta --prefix output_results --long
    ```
*   **Targeted Classification**: Limit the search to specific constellations using the `-n` flag.
    ```bash
    scorpio classify -i alignment.fasta -n "B.1.1.7" "B.1.617.2-like" --prefix targeted_output
    ```

### 2. Haplotype Barcoding
The `haplotype` command generates "barcodes" representing the state (ref, alt, ambig, or other) at each defining site. This is critical for identifying recombination or sequencing issues like amplicon dropout.

*   **Generate Barcodes**:
    ```bash
    scorpio haplotype -i alignment.fasta --prefix barcodes -n "Omicron (BA.1-like)"
    ```
*   **Per-site Genotypes**: Use `--append-genotypes` to see the specific call for every mutation site in the constellation.
    ```bash
    scorpio haplotype -i alignment.fasta --prefix detailed_haplo --append-genotypes --output-counts
    ```

### 3. Defining New Constellations
If you have a group of sequences and want to extract their common mutations to create a new definition:
```bash
scorpio define --group <group_column> --mutations <mutation_column>
```
*Note: This command expects a CSV input where mutations are already identified and listed (usually pipe-separated).*

## Expert Tips and Best Practices

### Input Requirements
*   **MSA Format**: Scorpio requires a reference-coordinate-based Multiple Sequence Alignment (MSA) FASTA. It does not support insertions; it only tracks SNPs and deletions relative to the reference.
*   **Alignment Preparation**: To generate a compatible MSA from raw sequences, use `minimap2` followed by `gofasta`:
    ```bash
    minimap2 -a --secondary=no -x asm20 <ref.fa> <query.fa> | gofasta sam toMultiAlign --reference <ref.fa> --pad -o alignment.fasta
    ```

### Understanding Rules
Constellations use a JSON format with a `rules` object. When troubleshooting classification:
*   `min_alt`: Minimum number of alternative (mutant) alleles required.
*   `max_ref`: Maximum number of reference alleles allowed for a positive match.
*   If a sequence fails classification, use the `haplotype` command to see if specific sites are consistently "ambiguous" (N), which may indicate low coverage or primer issues.

### Integration with Pangolin
Scorpio is often used as a verification step for Pangolin. If Pangolin assignments seem inconsistent, running `scorpio list` can help you confirm which constellation definitions are currently loaded in your environment.

## Reference documentation
- [Scorpio Wiki](./references/github_com_cov-lineages_scorpio_wiki.md)
- [GitHub Repository Overview](./references/github_com_cov-lineages_scorpio.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_scorpio_overview.md)