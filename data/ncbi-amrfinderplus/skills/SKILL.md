---
name: ncbi-amrfinderplus
description: AMRFinderPlus is a bioinformatics tool designed to identify acquired antimicrobial resistance genes in bacterial protein or nucleotide sequences.
homepage: https://github.com/ncbi/amr/wiki
---

# ncbi-amrfinderplus

## Overview

AMRFinderPlus is a bioinformatics tool designed to identify acquired antimicrobial resistance genes in bacterial protein or nucleotide sequences. Beyond AMR, it can detect virulence factors and genes related to biocide, heat, acid, and metal resistance. It functions by combining BLAST searches against a curated database with HMMER-based profile hidden Markov model searches. This tool is a standard for genomic surveillance and the characterization of bacterial isolates, providing high-confidence gene identification and nomenclature based on the NCBI Reference Gene Hierarchy.

## Core Command Usage

### 1. Database Management
Always ensure the database is current before running an analysis.
*   **Update database**: `amrfinder -u`
*   **Check versions**: `amrfinder -V` (Displays both software and database versions)

### 2. Basic Search Modes
*   **Protein input**: `amrfinder -p proteins.faa`
*   **Nucleotide input (translated search)**: `amrfinder -n assembly.fna`
*   **Combined analysis (Recommended)**: Use both protein and nucleotide inputs with a GFF file to provide coordinates. This allows the tool to resolve overlaps and identify partial genes or point mutations more accurately.
    `amrfinder -p proteins.faa -n assembly.fna -g annotation.gff`

### 3. Identifying Point Mutations
Point mutation detection is not enabled by default. You must specify the organism.
*   **List supported organisms**: `amrfinder -l`
*   **Run with organism**: `amrfinder -p proteins.faa -O Campylobacter`

### 4. Expanding Search Scope
By default, AMRFinderPlus only reports "core" AMR genes.
*   **Include virulence and stress genes**: Add the `--plus` flag.
    `amrfinder -p proteins.faa --plus`

## Expert Tips and Best Practices

### Interpreting the "Method" Column
The `Method` column in the output indicates the evidence used for the call:
*   **ALLELE/EXACT**: 100% sequence identity to a known reference.
*   **BLAST**: High identity (>90% by default) but not an exact match.
*   **HMM**: Identified via profile HMM; often indicates a more distant relative or a novel variant.
*   **PARTIAL**: The hit covers 50-90% of the reference. If it ends near a contig boundary, it is labeled `PARTIAL_CONTIG_END`.

### Handling GFF Formats
AMRFinderPlus is sensitive to GFF formatting. If using output from specific pipelines, use the `--annotation_format` flag:
*   Options include: `prokka`, `bakta`, `pgap`, `rast`, and `patric`.
*   Example: `amrfinder -p proteins.faa -g annotation.gff --annotation_format prokka`

### Performance Optimization
*   **Threading**: Use `--threads [N]`. Note that increasing threads beyond 4 provides diminishing returns for protein-only searches but significantly speeds up nucleotide (translated) searches.
*   **Filtering**: Use `awk` to filter the tab-delimited output for specific classes (e.g., `awk -F'\t' '$12 == "BETA-LACTAM" {print}'`).

### Genotype vs. Phenotype
Always remember that AMRFinderPlus reports the **presence** of a gene or mutation. It does not predict phenotypic resistance, as expression levels, regulatory mutations, or unknown mechanisms may influence the actual resistance profile.

## Reference documentation

- [Running AMRFinderPlus](./references/github_com_ncbi_amr_wiki_Running-AMRFinderPlus.md)
- [Interpreting results](./references/github_com_ncbi_amr_wiki_Interpreting-results.md)
- [Methods](./references/github_com_ncbi_amr_wiki_Methods.md)
- [Tips and tricks](./references/github_com_ncbi_amr_wiki_Tips-and-tricks.md)
- [New in AMRFinderPlus](./references/github_com_ncbi_amr_wiki_New-in-AMRFinderPlus.md)