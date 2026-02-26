---
name: maast
description: Maast identifies core-genome single nucleotide polymorphisms and genotypes them in microbial genomes or sequencing reads using a k-mer based approach. Use when user asks to call SNPs from assemblies, build a k-mer database for genotyping, or perform end-to-end SNP discovery and sample genotyping.
homepage: https://github.com/zjshi/Maast
---


# maast

## Overview
Maast (Microbial agile accurate SNP Typer) is a high-performance bioinformatics tool designed to identify core-genome Single Nucleotide Polymorphisms (SNPs) and genotype them in conspecific genomes, contigs, or unassembled reads. By utilizing a k-mer based approach that bypasses the need for traditional read alignment or assembly, Maast achieves significant speedups and lower memory consumption compared to standard pipelines. It is specifically optimized to handle the redundancy found in large species-specific genomic databases by collapsing similar genomes before SNP discovery.

## Core Workflows

### 1. Automated End-to-End Processing
For most standard use cases where you have a directory containing both reference assemblies and target sequencing data, use the `end_to_end` command. This performs SNP calling, database construction, and genotyping in a single execution.

```bash
maast end_to_end \
  --in-dir /path/to/input_data/ \
  --out-dir /path/to/output/ \
  --min-prev 0.9 \
  --snp-freq 0.01
```

### 2. Step-by-Step Genotyping
For complex projects or when you need to reuse a SNP catalog across different datasets, run the modules individually.

**Step A: Call SNPs from assemblies**
This identifies common SNPs and selects "tag" genomes to represent diversity.
```bash
maast genomes --fna-dir /path/to/genomes/ --out-dir /path/to/output/
```

**Step B: Build the k-mer database**
Creates the binary database required for genotyping reads.
```bash
maast db \
  --ref-genome /path/to/output/reference.fna \
  --vcf /path/to/output/core_snps.vcf \
  --tag-fna-list /path/to/output/tag_paths.list \
  --out-dir /path/to/output/
```

**Step C: Genotype samples**
Apply the database to new assemblies or sequencing reads.
```bash
maast genotype \
  --in-dir /path/to/new_samples/ \
  --out-dir /path/to/genotypes/ \
  --db /path/to/output/kmer_db.bin
```

## Expert Tips and Best Practices

### Input Handling
- **File Extensions**: Maast automatically detects file types. Ensure assemblies use `.fa`, `.fsa`, `.fna`, or `.fasta`, and sequencing reads use `.fq` or `.fastq`.
- **Compression**: You do not need to decompress files. Maast natively supports `.gz`, `.lz4`, and `.bz2`.
- **Redundancy**: By default, Maast collapses redundant genomes. If you specifically need to include every genome in the SNP discovery phase, use the `--keep-redundancy` flag in the `genomes` subcommand.

### Parameter Tuning
- **Prevalence (`--min-prev`)**: Controls the "core" definition. A value of `0.9` means a SNP must be present in 90% of the tag genomes to be included. Increase this for a stricter core genome definition.
- **Minor Allele Frequency (`--snp-freq`)**: Use this to filter out rare variants. Setting this to `0.01` filters out SNPs where the minor allele appears in less than 1% of the population.

### Performance Optimization
- **Parallelization**: If `pigz`, `lbzip2`, or `lz4` are installed on the system, Maast will utilize them for faster decompression.
- **Memory Management**: Maast is designed to be RAM-efficient, but for extremely large databases, ensure the output directory is on a filesystem with fast I/O.

### Phylogenetic Analysis
If you have `FastTreeMP` installed, you can generate a SNP-based tree directly from the genotypes:
```bash
maast tree --in-dir /path/to/genotype_results/ --out-dir /path/to/tree_output/
```

## Reference documentation
- [Maast Main Documentation](./references/github_com_zjshi_Maast.md)
- [Maast Wiki and Tutorials](./references/github_com_zjshi_Maast_wiki.md)