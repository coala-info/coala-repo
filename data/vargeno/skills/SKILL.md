---
name: vargeno
description: vargeno performs targeted genotyping of known Single Nucleotide Polymorphisms (SNPs) from raw sequencing reads. Use when user asks to genotype known SNPs or index a reference and SNP list for genotyping.
homepage: https://github.com/medvedevgroup/vargeno
---


# vargeno

## Overview

vargeno is a high-performance bioinformatics tool designed for the targeted genotyping of known Single Nucleotide Polymorphisms (SNPs) from raw sequencing reads. By focusing on a specific SNP database rather than performing de novo variant calling, vargeno achieves significant speed improvements suitable for bedside diagnostics. It processes FASTQ sequencing data against a reference genome and a VCF file of known variants, producing a genotyped VCF output containing genotype calls (GT) and Phred-scaled quality scores (GQ).

## Command Line Usage

The vargeno workflow consists of two primary stages: index construction and genotyping.

### 1. Indexing the Reference and SNPs
Before genotyping, you must generate a specialized index from your reference genome and the target SNP list.

```bash
vargeno index <reference.fa> <variants.vcf> <index_prefix>
```

*   **reference.fa**: The reference genome sequence in FASTA format.
*   **variants.vcf**: The list of known SNPs to be genotyped in VCF format.
*   **index_prefix**: The base name for the generated index files.

### 2. Genotyping Sequencing Reads
Once the index is created, use the `geno` command to process the donor genome reads.

```bash
vargeno geno <index_prefix> <reads.fq> <variants.vcf> <output.vcf>
```

*   **index_prefix**: Must match the prefix used during the indexing step.
*   **reads.fq**: Sequencing reads from the donor genome in FASTQ format.
*   **variants.vcf**: The same VCF file used during indexing.
*   **output.vcf**: The filename for the resulting genotyped VCF.

## Best Practices and Expert Tips

*   **Memory Requirements**: vargeno is memory-intensive. Genotyping a small subset of human chromosome 22 can require approximately 34 GB of RAM. Ensure your environment (especially in HPC or cloud settings) has sufficient memory allocation for whole-genome processing.
*   **VCF Compatibility**: Ensure your input VCF follows the VCF 4.2 specification. vargeno specifically populates the `GT` (0/0, 0/1, 1/1) and `GQ` fields in the `FORMAT` column.
*   **Index Reuse**: You only need to run the `index` command once for a specific combination of reference genome and SNP database. This index can be reused for genotyping any number of individual donor FASTQ files.
*   **Input Validation**: Verify that the chromosome names in your FASTA reference exactly match the chromosome names in your VCF file to avoid indexing errors or empty outputs.
*   **Alternative Version**: If memory constraints are a significant bottleneck, consider using "VarGeno-Lite," which is maintained as a separate project for lower-memory environments.

## Reference documentation
- [vargeno - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_vargeno_overview.md)
- [GitHub - medvedevgroup/vargeno](./references/github_com_medvedevgroup_vargeno.md)