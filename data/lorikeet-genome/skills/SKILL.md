---
name: lorikeet-genome
description: Lorikeet is a metagenomic analysis pipeline that performs local re-assembly for high-resolution variant calling and strain genotyping. Use when user asks to call variants, resolve strain-level differences, generate consensus genomes, or calculate evolutionary metrics like dN/dS.
homepage: https://github.com/rhysnewell/Lorikeet
---

# lorikeet-genome

## Overview
Lorikeet is a specialized bioinformatics pipeline designed for high-resolution metagenomic analysis. It re-implements the GATK HaplotypeCaller algorithm to perform local re-assembly of active regions within candidate genomes, allowing for more accurate variant calling in complex microbial communities. Beyond simple variant calling, it can cluster variants into distinct strains using UMAP and HDBSCAN and calculate evolutionary metrics like dN/dS.

## Core Workflows

### Strain Genotyping
Use the `genotype` subcommand to resolve strain-level differences within MAGs. This is the primary workflow for identifying multiple strains of the same species in a sample.
```bash
lorikeet genotype --bam <input.bam> --genome <reference.fasta> --outdir <output_directory>
```

### Variant Calling
Use the `call` subcommand for standard variant calling without the downstream strain clustering. This is useful for generating VCF-like data for general population genetics.
```bash
lorikeet call --bam <input.bam> --genome <reference.fasta> --outdir <output_directory>
```

### Consensus Genome Generation
Use the `consensus` subcommand to create sample-specific consensus sequences based on the mapped reads and reference genome.
```bash
lorikeet consensus --bam <input.bam> --genome <reference.fasta> --outdir <output_directory>
```

### Evolutionary Analysis
Use the `evolve` subcommand to calculate dN/dS values for genes, which helps in understanding the selective pressures acting on specific populations within the metagenome.
```bash
lorikeet evolve --bam <input.bam> --genome <reference.fasta> --outdir <output_directory>
```

## Expert Tips and Best Practices

- **Input Flexibility**: Lorikeet accepts various input combinations:
    - Raw reads + Reference Genome/MAG.
    - Pre-aligned BAM file + Reference Genome.
- **Environment Setup**: Ensure both `lorikeet` and the helper binary `remove_minimap2_duplicated_headers` are in your PATH. The latter is required to handle specific header issues common in long-read alignments.
- **Hybrid Data**: While Lorikeet supports both long and short reads, it is particularly powerful for utilizing long reads to bridge complex regions during local re-assembly.
- **Resource Management**: Local re-assembly is computationally intensive. Ensure your environment has sufficient memory when processing high-coverage "active regions."



## Subcommands

| Command | Description |
|---------|-------------|
| lorikeet | Variant calling and strain genotyping analysis for metagenomics |
| lorikeet call | Perform read mapping and variant calling using local reassembly of active regions |
| lorikeet consensus | Consensus caller for lorikeet |
| lorikeet genotype | Report strain-level genotypes and abundances based on variant read mappings |
| lorikeet shell-completion | Generate a shell completion script for lorikeet |

## Reference documentation
- [Lorikeet GitHub Repository](./references/github_com_rhysnewell_Lorikeet.md)
- [Installation Guide](./references/github_com_rhysnewell_Lorikeet_blob_master_INSTALL.md)
- [Main README](./references/github_com_rhysnewell_Lorikeet_blob_master_README.md)