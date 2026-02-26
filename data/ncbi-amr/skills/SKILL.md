---
name: ncbi-amr
description: ncbi-amr identifies antimicrobial resistance genes, virulence factors, and stress-response genes in bacterial protein or nucleotide sequences. Use when user asks to identify AMR genes, screen for virulence factors, detect point mutations in specific organisms, or update the AMRFinderPlus database.
homepage: https://github.com/ncbi/amr/wiki
---


# ncbi-amr

## Overview

AMRFinderPlus (the `amrfinder` tool) is the NCBI-standardized method for identifying acquired antimicrobial resistance (AMR) genes in bacterial protein or nucleotide sequences. Beyond AMR, it can screen for virulence factors, biocide, heat, acid, and metal resistance genes. It utilizes a curated database of protein profile Hidden Markov Models (HMMs) and a hierarchical tree of gene families to provide high-confidence nomenclature. The tool is most powerful when performing "combined" searches that integrate protein annotations with genomic coordinates to resolve overlapping hits and identify point mutations.

## Core Workflows

### 1. Database Management
Always ensure the database is current before starting an analysis.
```bash
# Download or update to the latest AMRFinderPlus database
amrfinder -u

# Check current software and database versions
amrfinder -V
```

### 2. Basic Searches
Choose the input type based on available data.
```bash
# Search protein sequences only
amrfinder -p proteins.fasta

# Search assembled nucleotide sequences (translated BLAST)
amrfinder -n assembly.fasta
```

### 3. The "Gold Standard" Combined Search
For the most accurate results, provide proteins, their genomic coordinates (GFF), and the assembly. This allows the tool to identify point mutations and resolve partial/split genes.
```bash
amrfinder -p proteins.fasta -g annotations.gff -n assembly.fasta -O Escherichia
```

## Expert Usage and Best Practices

### Point Mutation Screening
Point mutations are only identified if the `--organism` (or `-O`) flag is used. 
- Use `amrfinder -l` to see the list of supported organisms (e.g., *Salmonella*, *Campylobacter*, *Escherichia*, *Staphylococcus_aureus*).
- Point mutations are reported with methods like `POINTX` (translated), `POINTP` (protein), or `POINTN` (nucleotide/rRNA).

### Broadening the Search Scope
By default, AMRFinderPlus only reports "core" AMR genes.
- Use `--plus` to include virulence factors, stress-response genes, and biocide resistance.
- Use `--report_all_stops` if you need to see internal stop codons in potentially pseudogenized resistance genes.

### Interpreting the "Method" Column
The quality of a hit is determined by the identification method:
- **ALLELE/EXACT**: 100% sequence identity to a known reference. High confidence.
- **BLAST**: High identity (>90% by default) but not an exact match.
- **PARTIAL**: Hit covers 50-90% of the reference length.
- **HMM**: Identified via HMM profile only; often indicates a distant relative or a novel variant within a family.
- **INTERNAL_STOP**: The gene contains a premature stop codon and may be non-functional.

### Batch Processing
To process multiple samples and combine them into a single report, use the `--name` flag in a loop:
```bash
for f in *.fasta; do
    base=$(basename $f .fasta)
    amrfinder -n $f --name $base > $base.tsv
done

# Combine results (keeping only one header)
head -n 1 $(ls *.tsv | head -n 1) > combined_results.tsv
grep -h -v "Protein identifier" *.tsv >> combined_results.tsv
```

## Reference documentation
- [Running AMRFinderPlus](./references/github_com_ncbi_amr_wiki_Running-AMRFinderPlus.md)
- [Interpreting results](./references/github_com_ncbi_amr_wiki_Interpreting-results.md)
- [Tips and tricks](./references/github_com_ncbi_amr_wiki_Tips-and-tricks.md)
- [Methods](./references/github_com_ncbi_amr_wiki_Methods.md)