---
name: vargeno
description: VarGeno is a high-speed bioinformatics tool designed for genotyping a pre-defined set of SNPs using k-mer based approximate matching. Use when user asks to index a reference genome with known variants or genotype sequencing reads against a specific SNP list.
homepage: https://github.com/medvedevgroup/vargeno
---

# vargeno

## Overview
VarGeno is a specialized bioinformatics tool designed for high-speed SNP genotyping. Unlike general-purpose variant callers that perform de novo discovery, VarGeno focuses on efficiently determining the genotypes of a pre-defined set of SNPs. It utilizes k-mer based approximate matching to significantly accelerate the genotyping process, making it suitable for clinical diagnostics and large-scale genomic studies where speed is critical.

## Core Workflow

Genotyping with VarGeno is a two-step process: indexing the reference data and then performing the actual genotyping.

### 1. Indexing
Before processing donor reads, you must build an index from your reference genome and the target SNP list.

```bash
vargeno index <reference.fa> <variants.vcf> <index_prefix>
```
- **reference.fa**: The reference genome sequence in FASTA format.
- **variants.vcf**: The list of known SNPs to be genotyped.
- **index_prefix**: The base name for the generated index files.

### 2. Genotyping
Once the index is created, you can genotype an individual's sequencing reads.

```bash
vargeno geno <index_prefix> <reads.fq> <variants.vcf> <output.vcf>
```
- **index_prefix**: Must match the prefix used during the indexing step.
- **reads.fq**: Sequencing reads from the donor genome in FASTQ format.
- **variants.vcf**: The same VCF file used during indexing.
- **output.vcf**: The resulting file containing genotypes (GT) and genotype quality (GQ).

## Technical Specifications and Tips

### Output Interpretation
VarGeno populates specific fields in the "FORMAT" column of the output VCF:
- **GT (Genotype)**: Reported as `0/0` (homozygous reference), `0/1` (heterozygous), or `1/1` (homozygous alternate).
- **GQ (Genotype Quality)**: A Phred-scaled integer representing the confidence in the genotype call.

### Resource Management
- **Memory Usage**: VarGeno is memory-intensive. Genotyping a subset of human chromosome 22 can require approximately 34 GB of RAM. For whole-genome applications, ensure the system has significant memory capacity.
- **VarGeno-Lite**: If system memory is a bottleneck, consider using the "Memory Lite" version (vargeno_lite), which is maintained as a separate project for resource-constrained environments.

### Installation Best Practices
The most reliable way to deploy VarGeno is via Bioconda:
```bash
conda install vargeno
```



## Subcommands

| Command | Description |
|---------|-------------|
| vargeno | vargeno <option> [option parameters ...] |
| vargeno | vargeno |

## Reference documentation
- [VarGeno Main Repository](./references/github_com_medvedevgroup_vargeno.md)
- [VarGeno README and Usage](./references/github_com_medvedevgroup_vargeno_blob_master_README.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_vargeno_overview.md)