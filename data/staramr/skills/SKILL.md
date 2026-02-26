---
name: staramr
description: staramr scans bacterial genome assemblies against ResFinder, PointFinder, and PlasmidFinder databases to detect antimicrobial resistance genes and plasmid replicons. Use when user asks to scan contigs for resistance genes, identify point mutations in specific organisms, detect plasmid types, or update resistance databases.
homepage: https://github.com/phac-nml/staramr
---


# staramr

## Overview
The `staramr` tool is a command-line utility that simplifies the detection of antimicrobial resistance in bacterial genome assemblies. Instead of running multiple separate tools, `staramr` provides a unified interface to scan contigs against the ResFinder, PointFinder, and PlasmidFinder databases. It is particularly useful for bioinformaticians who need to transform raw assembly data into actionable reports that include predicted phenotypes, specific resistance genes, and plasmid replicon types.

## Common CLI Patterns

### Basic AMR Gene Scanning
To perform a standard search for acquired resistance genes and plasmids:
```bash
staramr search -o output_directory input_contigs.fasta
```

### Scanning for Point Mutations
Point mutation detection is organism-specific. You must specify the organism to trigger PointFinder:
```bash
staramr search --pointfinder-organism salmonella -o output_dir *.fasta
```
*Supported organisms include: `salmonella`, `campylobacter`, `enterococcus faecalis`, and `enterococcus faecium`.*

### Specific Plasmid Searching
By default, `staramr` uses both Gram-positive and Enterobacteriaceae plasmid databases. You can restrict this to a specific type:
```bash
staramr search --plasmidfinder-database-type enterobacteriaceae -o output_dir *.fasta
```

### MLST Analysis
While `staramr` attempts to auto-detect the MLST scheme, you can manually specify one:
```bash
staramr search --mlst-scheme senterica -o output_dir *.fasta
```

### Database Management
To ensure you are using the most recent resistance data:
*   **Check current versions:** `staramr db info`
*   **Update databases:** `staramr db update --update-default`
*   **Revert to bundled version:** `staramr db restore-default`

## Expert Tips and Best Practices

*   **Phenotype Interpretation:** Remember that `staramr` predicts *microbiological* resistance (the presence of a gene/mutation associated with resistance), which may not always correlate perfectly with *clinical* resistance observed in a lab.
*   **Output Hierarchy:** 
    *   `summary.tsv`: Start here for a high-level overview of all isolates.
    *   `detailed_summary.tsv`: Use this for specific coordinates (contig, start, end) and identity percentages for every hit.
    *   `settings.txt`: Always keep this file to document the database versions and parameters used for your analysis to ensure reproducibility.
*   **Input Quality:** `staramr` is designed for contigs (assemblies). Do not provide raw FASTQ reads; perform assembly (e.g., using Shovill or SPAdes) before running this tool.
*   **Batch Processing:** You can pass multiple FASTA files or use wildcards (e.g., `*.fasta`) to process an entire directory of isolates at once.

## Reference documentation
- [staramr GitHub Repository](./references/github_com_phac-nml_staramr.md)
- [staramr Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_staramr_overview.md)