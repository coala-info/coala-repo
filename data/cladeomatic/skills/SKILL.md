---
name: cladeomatic
description: Clade-o-matic partitions genomic sequences into hierarchical clades and identifies canonical SNPs to create typing schemes. Use when user asks to create a typing scheme from a phylogenetic tree, generate a scheme from predefined groups, genotype samples using a VCF file, or benchmark a scheme against labeled samples.
homepage: https://github.com/phac-nml/cladeomatic
metadata:
  docker_image: "quay.io/biocontainers/cladeomatic:0.1.1--pyhdfd78af_0"
---

# cladeomatic

## Overview

Clade-o-matic is a specialized bioinformatics tool used to partition genomic sequences into hierarchical clusters (clades, lineages, or genotypes). Unlike general clustering tools, it identifies canonical SNPs that are both exclusive to and conserved within specific phylogenetic clades. It generates a typing scheme that includes unique kmers, allowing for the identification of these SNPs directly from raw sequencing data. This skill provides the necessary command-line patterns to create schemes from trees or predefined groups and to perform downstream genotyping.

## Core Workflows

### 1. Creating a Typing Scheme

There are two primary modes for scheme generation: de novo discovery based on a phylogenetic tree, or definition based on existing group assignments.

#### Option A: De Novo Tree-Based Discovery
Use this when you have a phylogenetic tree and want Clade-o-matic to discover valid clades based on membership size and SNP requirements.

```bash
cladeomatic create \
  --in_nwk tree.nwk \
  --in_var snps.vcf \
  --in_meta sample.meta.txt \
  --reference root.gbk \
  --root_name root_sequence_id \
  --outdir output_directory
```

#### Option B: Predefined Groups
Use this when you already have samples assigned to specific genotypes and want to generate a formal SNP/kmer scheme for them.

```bash
cladeomatic create \
  --in_groups groups.tsv \
  --in_var snps.vcf \
  --in_meta sample.meta.txt \
  --reference root.gbk \
  --root_name root_sequence_id \
  --outdir output_directory
```

### 2. Genotyping Samples
Once a scheme is created, use the `genotype` command to assign genotypes to new samples using a VCF file.

```bash
cladeomatic genotype \
  --in_var samples.vcf \
  --in_scheme cladeomatic-kmer.scheme.txt \
  --outdir genotyping_results
```

### 3. Benchmarking and Renaming
*   **Benchmark**: Validate a developed scheme against labeled samples to ensure accuracy.
*   **Namer**: Update or standardize the nomenclature of genotypes within an existing scheme file.

## Key Input Requirements

*   **VCF File**: Must be generated using the same reference sequence provided to Clade-o-matic.
*   **Reference**: Can be in `.fasta` or `.gbk` format.
*   **Metadata**: A tab-delimited file containing sample information.
*   **Group File (for --in_groups)**: A TSV with `sample_id` and `genotype` columns. Note that every group ID must be unique across all ranks.

## Expert Tips and Best Practices

*   **Organism Selection**: Clade-o-matic is most effective for clonal or near-clonal organisms. High recombination rates can obscure the canonical SNP signals the tool relies on.
*   **Granularity Control**: You can adjust the resolution of the scheme by modifying the required number of SNPs to support a clade and the minimum number of members required for a clade to be considered valid.
*   **Kmer Identification**: The tool produces a `biohansel` compatible kmer fasta file. This is highly useful for rapid subtyping directly from raw reads without requiring full assembly or alignment for every new sample.
*   **Output Analysis**: 
    *   Check `{prefix}-clades.info.txt` for detailed statistics on supporting SNPs.
    *   Review `{prefix}-genotypes.selected.txt` to see which nodes met your specific filtering criteria.



## Subcommands

| Command | Description |
|---------|-------------|
| cladeomatic | Clade-O-Matic: Benchmarking Genotyping scheme development v. 0.1.1 |
| cladeomatic | Clade-O-Matic: Genotyping scheme development v. 0.1.1 |
| cladeomatic | Clade-O-Matic: Genotyping scheme genotype namer v. 0.1.1 |
| cladeomatic create | Create a clade from a phylogenetic tree and a set of sequences. |

## Reference documentation
- [Clade-o-matic GitHub README](./references/github_com_phac-nml_cladeomatic_blob_main_README.md)
- [Clade-o-matic Repository Overview](./references/github_com_phac-nml_cladeomatic.md)