---
name: lorikeet-genome
description: Lorikeet is a metagenomic pipeline that performs local re-assembly to identify within-species variants and strain-level diversity. Use when user asks to call SNPs and indels in metagenomes, calculate dN/dS values for evolutionary analysis, or generate consensus genomes from read mappings.
homepage: https://github.com/rhysnewell/Lorikeet
---


# lorikeet-genome

## Overview

Lorikeet is a specialized pipeline for within-species variant analysis in metagenomic communities. It distinguishes itself from standard variant callers by re-implementing the GATK HaplotypeCaller algorithm to perform local re-assembly of active regions within candidate genomes. This approach is particularly effective for resolving complex strain-level variation. The tool is versatile, supporting both short-read and long-read data (or hybrid sets) and provides downstream analysis for evolutionary pressure (dN/dS) and strain clustering.

## Core Subcommands

- **`call`**: The primary subcommand for variant calling. It identifies SNPs and indels without performing downstream strain resolution.
- **`genotype`**: (Experimental) Used to resolve specific strain-level genotypes from the microbial community.
- **`consensus`**: Generates consensus genomes for each input reference based on the samples provided.
- **`evolve`**: Calculates dN/dS values for genes based on read mappings, useful for detecting selection pressure.

## Common CLI Patterns

### Variant Calling from BAM Files
When you already have aligned reads, use the `--bam-files` and `--genome-fasta-directory` flags. This is the most efficient way to run Lorikeet if alignments are pre-computed.

```bash
lorikeet call \
    --bam-files sample1.bam,sample2.bam \
    --longread-bam-files long_reads.bam \
    --genome-fasta-directory ./genomes/ \
    --extension fna \
    --output-directory lorikeet_results/ \
    --threads 12 \
    --plot
```

### Variant Calling from Raw Reads
If starting from FASTQ files, Lorikeet can handle the alignment internally if a reference genome is provided.

```bash
lorikeet call \
    -r reference_genome.fna \
    -1 forward_reads.fastq.gz \
    -2 reverse_reads.fastq.gz \
    -l longread_alignment.bam \
    --output-directory variant_output/
```

### Evolutionary Analysis
To calculate dN/dS values for coding regions across samples:

```bash
lorikeet evolve \
    --bam-files sample.bam \
    --genome-fasta-directory ./genomes/ \
    --gff-file annotations.gff \
    --output-directory evolution_results/
```

## Expert Tips and Best Practices

- **Hybrid Data**: Lorikeet is optimized for hybrid metagenomics. Providing long-read BAM files (`-l` or `--longread-bam-files`) significantly improves the resolution of local re-assemblies in repetitive or complex regions.
- **Caching**: Use `--bam-file-cache-directory` when running multiple analyses on the same data to avoid redundant processing of BAM headers and indices.
- **Resource Management**: Local re-assembly is computationally intensive. Always specify `--threads` to match your environment's capabilities.
- **File Extensions**: When pointing to a genome directory, use the `-x` or `--extension` flag (e.g., `fna`, `fasta`) to ensure the tool correctly identifies your reference files.
- **Shell Completion**: For frequent CLI use, generate completion scripts to speed up command entry:
  `lorikeet shell-completion --shell bash --output-file ~/.lorikeet_completion`

## Reference documentation
- [Lorikeet GitHub Repository](./references/github_com_rhysnewell_Lorikeet.md)
- [Lorikeet Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_lorikeet-genome_overview.md)