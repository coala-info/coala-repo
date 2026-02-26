---
name: hla-asm
description: The hla-asm tool performs high-resolution HLA typing and exon identification from assembled genomic data. Use when user asks to perform HLA typing on a FASTA assembly, identify HLA exon coordinates, or extract HLA sequences from de novo assemblies.
homepage: https://github.com/DiltheyLab/HLA-LA/blob/master/HLA-ASM.md
---


# hla-asm

## Overview
The `hla-asm` tool is designed for high-resolution HLA typing specifically from assembled genomic data rather than raw reads. It bridges the gap between long-read assembly and clinical-grade HLA nomenclature by identifying exon coordinates and matching them against the IMGT/HLA database. This is particularly useful for validating MHC region reconstructions or extracting HLA sequences from personalized de novo assemblies.

## Core Usage Patterns

### Basic HLA Typing from Assembly
To perform HLA typing on a FASTA assembly, use the `HLA-ASM.pl` script. You must provide the assembly file and a sample identifier.

```bash
perl HLA-ASM.pl --assembly sample_assembly.fasta --sampleID Patient01 --outputDir ./hla_results
```

### Key Parameters
- `--assembly`: Path to the FASTA file containing the assembled contigs or scaffolds.
- `--sampleID`: A unique string used to prefix output files.
- `--outputDir`: Directory where results and intermediate alignments will be stored.
- `--threads`: (Optional) Number of CPU cores to use for alignment steps.

## Workflow Best Practices

### Input Preparation
- **Assembly Quality**: Ensure the assembly has sufficient coverage and accuracy in the MHC region (6p21.3). Low-quality assemblies with high indel rates (common in older Nanopore basecallers) may lead to frame-shifts in exon detection.
- **Contig Naming**: Use simple, alphanumeric contig names in your FASTA file to avoid parsing issues during the alignment phase.

### Interpreting Results
The tool produces several output files in the specified directory:
- **G group resolution**: Look for the `_G.txt` suffix in the output files. This provides the typing at the level of groups of alleles with identical nucleotide sequences across the peptide-binding grooves.
- **Exon Coordinates**: The tool generates coordinates relative to your input assembly, which can be used to extract specific HLA gene sequences for further phylogenetic or functional analysis.

### Troubleshooting
- **Missing Genes**: If a specific HLA locus is not reported, check if the corresponding contig in your assembly is truncated or if the MHC region was split across multiple small contigs.
- **Dependencies**: Ensure `bwa`, `samtools`, and `picard` are in your PATH, as `hla-asm` relies on these for the underlying alignment and data processing tasks.

## Reference documentation
- [HLA-ASM Documentation](./references/github_com_DiltheyLab_HLA-LA_blob_master_HLA-ASM.md)
- [HLA-LA Repository Overview](./references/github_com_DiltheyLab_HLA-LA.md)