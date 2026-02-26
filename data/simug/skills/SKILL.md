---
name: simug
description: "simuG generates synthetic genomes by introducing a full spectrum of genomic variations into an existing reference sequence. Use when user asks to generate synthetic genomes, simulate random mutations, create personalized reference genomes from VCF files, or model mutation parameters from real-world datasets."
homepage: https://github.com/yjx1217/simuG
---


# simug

## Overview
simuG is a lightweight and versatile tool for generating synthetic genomes. It allows researchers to take an existing reference FASTA and introduce a full spectrum of genomic variations. Whether you need to inject specific variants from a VCF file or generate a set of random mutations based on statistical models, simuG provides fine-grained control over the simulation process, including coding-region specificity and transition/transversion ratios.

## Installation and Environment
simuG is implemented in Perl 5 and has no external library dependencies, though it requires GNU Gzip for handling compressed files.

- **Conda**: `conda install bioconda::simug`
- **Manual**: Clone the repository and run the `.pl` scripts directly.

## Core CLI Patterns

### 1. Random Variant Simulation
To generate a genome with a specific number of random mutations:

```bash
# Simulate 1000 random SNPs and 100 INDELs
perl simuG.pl -refseq reference.fa -snp_count 1000 -indel_count 100 -prefix sim_output
```

### 2. VCF-Driven Simulation
To create a "personalized" reference genome based on known variants:

```bash
# Apply variants from a VCF to a reference
perl simuG.pl -refseq reference.fa -snp_vcf variants.vcf.gz -prefix vcf_sim
```
*Note: You can use `-indel_vcf`, `-cnv_vcf`, `-inversion_vcf`, and `-translocation_vcf` similarly.*

### 3. Modeling Real Data
Use the ancillary script `vcf2model.pl` to extract mutation parameters from real-world datasets to make random simulations more realistic.

```bash
# Generate SNP and INDEL models from real data
perl vcf2model.pl -vcf real_samples.vcf.gz -prefix yeast_model

# Use the generated models for simulation
perl simuG.pl -refseq reference.fa -snp_model yeast_model.snp.model.txt -snp_count 5000 -prefix modeled_sim
```

## Advanced Configuration

### Genomic Partitioning
You can restrict mutations to specific genomic regions (e.g., non-coding regions) by providing a GFF3 file:

```bash
perl simuG.pl \
  -refseq reference.fa \
  -snp_count 1000 \
  -coding_partition_for_snp_simulation noncoding \
  -gene_gff annotations.gff3 \
  -prefix noncoding_snps
```

### Chromosome Filtering
To avoid simulating variants on specific contigs (like mitochondria or unplaced scaffolds), use an exclusion list:

```bash
# excluded_chrs.txt should contain one chromosome name per line
perl simuG.pl -refseq ref.fa -snp_count 100 -excluded_chr_list excluded_chrs.txt -prefix filtered_sim
```

## Expert Tips
- **Transition/Transversion Ratio**: When simulating random SNPs, use `-titv_ratio` (default is 0.5) to match the biological expectations of your organism (e.g., ~2.0 for humans).
- **Compressed Inputs**: simuG natively handles `.gz` files for reference sequences and VCFs, saving significant disk space.
- **Output Files**: The tool generates a simulated FASTA and a "map" file. Always check the `.map` file to verify the exact positions and types of introduced variants.
- **Quality Filtering**: When using `vcf2model.pl`, use the `-qual` flag to ensure your statistical model isn't skewed by low-confidence variant calls.

## Reference documentation
- [simuG GitHub Repository](./references/github_com_yjx1217_simuG.md)
- [Bioconda simuG Overview](./references/anaconda_org_channels_bioconda_packages_simug_overview.md)