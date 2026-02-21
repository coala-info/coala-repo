---
name: vcfkit
description: VCF-kit (invoked via the command `vk`) is a specialized suite of utilities for downstream VCF analysis.
homepage: https://github.com/AndersenLab/VCF-kit
---

# vcfkit

## Overview
VCF-kit (invoked via the command `vk`) is a specialized suite of utilities for downstream VCF analysis. It bridges the gap between raw variant calling and biological insight by providing high-level functions for population genetics, phylogenetics, and laboratory validation. Use this skill to streamline workflows that involve reference genome management, genotype frequency calculations, and automated primer design for specific genomic variants.

## Command Reference and Usage Patterns

### Reference Genome Management
Before performing operations like primer design or variant calling, you must set up a reference genome.
- **Install a genome**: `vk genome location <genome_name>`
- **List available genomes**: `vk genome list`
- **Remove a genome**: `vk genome rm <genome_name>`

### Population Genetics and Statistics
- **Tajima's D**: Calculate Tajima's D across the genome.
  `vk tajima <window_size> <step_size> input.vcf.gz`
- **Genotype Calculations**: Obtain frequencies and counts of genotypes and alleles.
  `vk calc genotypes input.vcf.gz`

### Variant Validation and Primers
One of VCF-kit's most powerful features is automated primer design for variants.
- **Generate Primers**: Design primers for variants in a VCF file.
  `vk primer template --reference=<genome> input.vcf.gz`
- **Specific Region**: `vk primer design <region> --reference=<genome>`

### Phylogenetics
- **Generate Trees**: Create dendrograms directly from VCF data.
  `vk phylo tree nj input.vcf.gz` (Neighbor-Joining tree)
  `vk phylo fasta input.vcf.gz` (Convert VCF to FASTA for other tree-building tools)

### Data Manipulation and Conversion
- **VCF to TSV**: Convert complex VCF data into a flat tab-separated file for use in R or Excel.
  `vk vcf2tsv input.vcf.gz`
- **Rename Samples**: Modify sample names using prefixes, suffixes, or string substitution.
  `vk rename --prefix=STUDY1_ input.vcf.gz`
- **Filtering**: Filter variants based on specific call counts (REF, HET, ALT, or missing).
  `vk filter --min-alt=2 input.vcf.gz`

## Expert Tips and Best Practices
- **Piping**: VCF-kit is designed to work with standard streams. You can pipe `bcftools` output directly into `vk` commands:
  `bcftools view -v snps input.vcf.gz | vk vcf2tsv`
- **Dependencies**: Ensure that external dependencies (`bwa`, `samtools`, `bcftools`, `blast`, and `primer3`) are installed and available in your PATH, as many `vk` modules (like `primer` and `call`) rely on them.
- **Genotype Imputation**: Use the `vk hmm` module for linkage studies to impute genotypes from parental data using a Hidden Markov Model.
- **Memory Management**: For large VCF files, ensure the file is indexed (`.tbi`) to allow faster access by certain `vk` modules.

## Reference documentation
- [VCF-kit GitHub Repository](./references/github_com_AndersenLab_VCF-kit.md)
- [VCF-kit Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_vcfkit_overview.md)