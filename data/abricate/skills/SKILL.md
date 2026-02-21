---
name: abricate
description: "Could not get help from Singularity for: abricate"
homepage: https://github.com/tseemann/abricate
---

# abricate

## Overview

`abricate` is a specialized tool for the mass screening of DNA contigs to identify antimicrobial resistance and virulence factors. It works by performing nucleotide BLAST searches against curated databases. It is designed for speed and ease of use, allowing researchers to process multiple assemblies simultaneously and generate comparative summary matrices. Note that it only detects acquired genes and does not identify point mutations or chromosomal resistance markers.

## CLI Usage and Best Practices

### Initial Setup and Verification
Before running an analysis, verify that the environment and databases are correctly configured.

*   **Check dependencies**: Run `abricate --check` to ensure BLAST+ and required Perl modules are installed.
*   **List available databases**: Use `abricate --list` to see which databases are installed, their sequence counts, and last update dates.
*   **Update databases**: Use `abricate-get_db --db [dbname] --force` to download the latest versions of specific databases.

### Running Screenings
`abricate` accepts FASTA, Genbank, and EMBL files, including those compressed with gzip or bzip2.

*   **Basic screening**: Run `abricate assembly.fasta` (defaults to the NCBI database).
*   **Select a specific database**: Use the `--db` flag to target a specific resource (e.g., `abricate --db card assembly.fna`).
*   **Process multiple files**: Use wildcards to screen an entire directory: `abricate *.fna > results.tab`.
*   **Use a File of File Names (FOFN)**: For very large datasets, provide a text file containing paths to your assemblies: `abricate --fofn list_of_files.txt`.

### Generating Summaries
One of the most powerful features is the ability to create a presence/absence matrix across multiple samples.

*   **Create a summary matrix**: After running screenings on multiple files and saving to a single TSV, run `abricate --summary results.tab > summary.tab`.
*   **Switch summary metrics**: By default, the summary shows `%COVERAGE`. Use the `--identity` flag to show `%IDENTITY` instead.

### Output Interpretation
The output is a tab-separated file. Key columns to evaluate include:
*   **%COVERAGE**: The proportion of the reference gene covered by your contig.
*   **%IDENTITY**: The proportion of exact nucleotide matches.
*   **GAPS**: Indicates potential pseudogenes or fragmented assemblies if gaps are present.
*   **RESISTANCE**: The predicted antibiotic resistance phenotype.

## Expert Tips
*   **Contigs only**: Do not attempt to use raw FASTQ reads; `abricate` requires assembled contigs.
*   **Acquired vs. Mutational**: Always remember that `abricate` will not find resistance caused by SNPs (e.g., gyrA mutations). Use tools like AMRFinderPlus or RGI if point mutations are required.
*   **Database Selection**: Use `vfdb` or `ecoli_vf` for virulence factors, and `plasmidfinder` for identifying plasmid replicon types.
*   **Quiet Mode**: Use `--quiet` to suppress status messages when piping output to other tools.

## Reference documentation
- [ABRicate Main Documentation](./references/github_com_tseemann_abricate.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_abricate_overview.md)