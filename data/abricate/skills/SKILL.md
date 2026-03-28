---
name: abricate
description: "ABRicate identifies acquired antibiotic resistance and virulence genes in genomic assemblies using BLASTN against curated databases. Use when user asks to screen contigs for resistance factors, identify virulence genes, list available databases, or generate a gene presence/absence summary matrix."
homepage: https://github.com/tseemann/abricate
---


# abricate

## Overview

ABRicate is a specialized tool for the rapid identification of acquired resistance and virulence factors within genomic contigs. It utilizes a DNA-based approach (blastn) to match input sequences against a variety of integrated databases. This skill should be used to automate the screening of assemblies, manage database updates, and generate presence/absence matrices for comparative genomic analysis. It is important to note that ABRicate identifies acquired genes rather than chromosomal point mutations and requires assembled contigs rather than raw FASTQ reads.

## Functional Guidance

### Database Management
Before running an analysis, verify the available databases and their last update timestamps.
- **List databases**: `abricate --list`
- **Update a specific database**: `abricate-get_db --db ncbi --force`
- **Check dependencies**: `abricate --check`

### Common CLI Patterns

**Basic Screening**
Run a default scan (usually against the NCBI database) on a single assembly:
`abricate assembly.fasta > results.tab`

**Using Specific Databases**
To screen for virulence factors or specific AMR sets, specify the database:
`abricate --db vfdb assembly.fasta`
`abricate --db card assembly.fasta`

**Batch Processing**
ABRicate handles multiple files efficiently. You can use wildcards or a File of File Names (FOFN):
`abricate *.fna > combined_results.tab`
`abricate --fofn list_of_files.txt > combined_results.tab`

**Generating Summary Reports**
To create a gene presence/absence matrix across multiple samples (useful for pangenome or population studies):
`abricate --summary combined_results.tab > summary_matrix.tab`

### Output Filtering and Refinement
- **Identity and Coverage**: By default, ABRicate uses a 80% threshold for both. Adjust these for higher stringency:
  `abricate --minid 95 --mincov 90 assembly.fasta`
- **CSV Output**: If TSV is not preferred, use the `--csv` flag.
- **Quiet Mode**: Use `--quiet` to suppress status messages during pipeline execution.

## Expert Tips and Best Practices

1. **Input Formats**: ABRicate uses `any2fasta`, meaning it can accept Genbank and EMBL files directly without manual conversion. It also supports `.gz` and `.bz2` compressed files.
2. **Point Mutations**: Always remember that ABRicate will not find resistance caused by SNPs (e.g., gyrA mutations). For those cases, consider tools like AMRFinderPlus or PointFinder.
3. **Summary Metrics**: When using `--summary`, the values in the matrix represent the `%COVERAGE`. If you prefer to see the `%IDENTITY`, add the `--identity` flag to the summary command.
4. **Database Selection**: For general AMR screening, `ncbi` or `card` are standard. For E. coli specific virulence, `ecoli_vf` or `ecoh` provide more granular results than the general `vfdb`.

## Reference documentation

- [ABRicate Main Documentation](./references/github_com_tseemann_abricate.md)
- [ABRicate Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_abricate_overview.md)