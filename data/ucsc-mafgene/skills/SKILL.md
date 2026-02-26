---
name: ucsc-mafgene
description: The `ucsc-mafgene` tool converts genomic DNA alignments into protein alignments based on gene structures. Use when user asks to convert genomic MAF alignments to protein alignments, extract protein alignments for specific genes, analyze protein conservation across species, or translate genomic DNA to protein sequences.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-mafgene

## Overview
The `ucsc-mafgene` skill provides a specialized interface for the `mafGene` utility, part of the UCSC Genome Browser "kent" toolset. This tool bridges the gap between genomic sequence alignments and functional protein analysis. It takes a genomic MAF file (containing multi-species alignments) and a genePred file (defining gene structures and coding frames) to produce alignments at the amino acid level. Use this when you need to visualize or analyze how specific genes are conserved or divergent across species at the protein level.

## Command Line Usage
The primary binary for this skill is `mafGene`.

### Basic Syntax
```bash
mafGene database genePredFile mafFile outputProteinAlignment
```

### Common Patterns
*   **Standard Extraction**: To extract protein alignments for a specific set of gene predictions:
    ```bash
    mafGene hg38 myGenes.gp multiz100way.maf out.prot.maf
    ```
*   **Using with Pipes**: Like many UCSC tools, it can often handle standard input/output or be part of a pipeline involving `mafFrag` to subset the genomic data first.

## Best Practices and Expert Tips
*   **Database Matching**: Ensure the `database` argument matches the assembly used to generate the MAF and genePred files (e.g., `hg38`, `mm10`).
*   **GenePred Format**: The tool expects standard genePred format. If you have GTF/GFF3 files, convert them first using `gtfToGenePred` or `gff3ToGenePred` (also part of the UCSC suite).
*   **Frame Awareness**: `mafGene` is frame-aware. It uses the exon coordinates and frame information in the genePred file to correctly translate genomic DNA into protein sequences, accounting for introns.
*   **MAF Indexing**: For large MAF files, ensure you are working with a subset or have sufficient memory, as genomic alignments can be extremely large. Use `mafFrag` to isolate the genomic region of interest before running `mafGene` if performance is an issue.
*   **Permission Errors**: If running the binary directly from a download, remember to set execution permissions: `chmod +x mafGene`.

## Reference documentation
- [UCSC Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-mafgene_overview.md)
- [UCSC Executable Directory Listing](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)