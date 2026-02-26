---
name: cladeomatic
description: Clade-O-Matic is a phylogenetic tool that identifies canonical SNPs and k-mers to automate the discovery of population structures and the creation of typing schemes. Use when user asks to create a de novo typing scheme from a phylogenetic tree, generate a scheme from predefined groups, or assign genotypes to samples using an existing scheme.
homepage: https://github.com/phac-nml/cladeomatic
---


# cladeomatic

## Overview
Clade-O-Matic is a phylogenetic tool that automates the discovery of population structures. It identifies "canonical" SNPs—those that are both exclusive to and conserved within specific clades—to build robust typing schemes. Unlike tools that use fixed hierarchical levels, Clade-O-Matic uses underlying genetic distance distributions to define the most representative hierarchy. A key advantage is its ability to generate k-mer sets for each SNP, facilitating the identification of genotypes directly from raw sequencing data.

## Command Line Usage

### 1. Creating a Typing Scheme (De Novo)
Use this mode when you have a phylogenetic tree and want the tool to discover valid clades based on membership size and SNP support.

```bash
cladeomatic create \
  --in_nwk tree.nwk \
  --in_var snps.vcf \
  --in_meta metadata.txt \
  --reference root.gbk \
  --root_name "root_sequence_id" \
  --outdir output_directory
```

**Critical Requirements:**
*   The `--root_name` must exactly match the sequence ID of the reference/outgroup used in the VCF and the tree.
*   The VCF must be derived from the same reference sequence provided in `--reference`.

### 2. Creating a Scheme from Predefined Groups
Use this mode if you already have samples assigned to specific genotypes and want to generate a formal SNP/k-mer scheme for them.

```bash
cladeomatic create \
  --in_groups groups.tsv \
  --in_var snps.vcf \
  --in_meta metadata.txt \
  --reference root.gbk \
  --root_name "root_sequence_id" \
  --outdir output_directory
```
*Note: Every group ID in the TSV must be unique across all ranks.*

### 3. Calling Genotypes
Once a scheme is created, use the `genotype` command to assign genotypes to new samples based on their VCF files.

```bash
cladeomatic genotype \
  --in_var samples.vcf \
  --in_scheme cladeomatic-snp.scheme.txt \
  --sample_meta sample_metadata.txt \
  --genotype_meta genotype.meta.txt \
  --outfile genotype.calls.txt
```

## Expert Tips and Best Practices

*   **Granularity Control:** You can adjust the resolution of the scheme by specifying the minimum number of SNPs required to support a clade and the minimum number of members required for a clade to be considered valid.
*   **VCF Limitations:** Standard VCF files often omit positions that match the reference or are missing. Clade-O-Matic handles this by reconstructing pseudo-sequences to distinguish between a reference state and missing data, ensuring more accurate genotype calls.
*   **Output Selection:** 
    *   Use `{prefix}-snps.scheme.txt` for traditional SNP-based pipelines.
    *   Use `{prefix}-biohansel.fasta` if you intend to use the scheme with the biohansel tool for rapid k-mer matching.
*   **Hierarchy Compression:** The tool automatically compresses the hierarchy into the minimum set of levels that retain the tree structure, preventing redundant or uninformative genotype levels.

## Reference documentation
- [Clade-O-Matic Main Documentation](./references/github_com_phac-nml_cladeomatic.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_cladeomatic_overview.md)