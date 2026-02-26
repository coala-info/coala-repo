---
name: svjedi-graph
description: SVJedi-graph is a structural variation genotyper that uses variation graphs and long reads to estimate genotypes for structural variants. Use when user asks to genotype structural variants, represent SV alleles using variation graphs, or resolve genotypes in complex genomic regions using long-read alignments.
homepage: https://github.com/SandraLouise/SVJedi-graph
---


# svjedi-graph

## Overview

SVJedi-graph is a structural variation genotyper that leverages variation graphs to represent SV alleles. By building a graph from a reference genome and an input VCF, it allows long reads to be mapped directly to variant paths using `minigraph`. This method is particularly effective for resolving genotypes in complex genomic regions or for overlapping variants. The tool estimates genotypes based on allele-specific alignment counts and outputs a VCF file updated with genotyping information.

## Core Workflow

To run a standard genotyping analysis, use the following command structure:

```bash
svjedi-graph.py -v <input.vcf> -r <reference.fasta> -q <reads.fastq> -p <output_prefix> -t <threads>
```

### Input Requirements

For SVJedi-graph to process variants correctly, the input VCF must adhere to specific formatting standards:

*   **SVTYPE Tag**: Every record must have the `SVTYPE` tag in the INFO field (e.g., `SVTYPE=DEL`, `SVTYPE=INS`, `SVTYPE=INV`, or `SVTYPE=BND`).
*   **Insertions & Duplications**: These must be sequence-resolved. The full inserted or duplicated sequence must be provided in the `ALT` field.
*   **Deletions & Inversions**: The INFO field must contain the `END` tag indicating the second breakpoint or the end of the affected segment.
*   **Translocations**: Use the `BND` (breakend) type. The `ALT` field must follow standard VCF breakend notation (e.g., `t[pos[`, `]pos]t`).
*   **Chromosome Names**: Ensure that chromosome identifiers in the VCF exactly match those in the reference FASTA file.

## Command Line Parameters

| Parameter | Description |
| :--- | :--- |
| `-v`, `--vcf` | Input VCF file containing SVs to genotype. |
| `-r`, `--ref` | Reference genome FASTA file. |
| `-q`, `--reads` | Long-read file (FASTA/FASTQ). Use commas to separate multiple files (e.g., `read1.fq,read2.fq`). |
| `-p`, `--prefix` | Prefix for all output files. |
| `-t`, `--threads` | Number of threads for the mapping step (minigraph). |
| `-ms`, `--minsupport` | Minimum number of alignments required to assign a genotype (default: 3). |

## Expert Tips and Best Practices

*   **Handling High Coverage**: If working with high-depth sequencing data, consider increasing the `-ms` (minimum support) parameter. The default of 3 is optimized for lower coverage; higher values can help filter out noise and improve genotype confidence in high-coverage samples.
*   **Multi-file Input**: If your sample data is spread across multiple FASTQ files, do not merge them manually. Pass them as a comma-separated list to the `-q` parameter to ensure the tool handles the input stream correctly.
*   **Resource Allocation**: The mapping step performed by `minigraph` is the most computationally intensive part of the workflow. Always utilize the `-t` parameter to match the available CPU cores on your system to significantly reduce processing time.
*   **Intermediate File Inspection**: SVJedi-graph produces several intermediate files that are useful for debugging:
    *   `.gfa`: The constructed variation graph. You can visualize this in tools like Bandage.
    *   `.gaf`: The mapping results in Graphical Alignment Format.
    *   `_informative_aln.json`: A dictionary containing the specific read support counts for each allele, which is useful for manual verification of ambiguous genotypes.

## Reference documentation

- [svjedi-graph - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_svjedi-graph_overview.md)
- [GitHub - SandraLouise/SVJedi-graph: SV genotyper for long reads with a variation graph](./references/github_com_SandraLouise_SVJedi-graph.md)