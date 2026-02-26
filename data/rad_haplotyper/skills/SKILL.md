---
name: rad_haplotyper
description: rad_haplotyper converts SNP data into multi-allelic haplotypes using read-level information from RAD-seq experiments. Use when user asks to phase SNPs into haplotypes, filter out paralogous sequences, or generate population genetic outputs like Genepop files.
homepage: https://github.com/chollenbeck/rad_haplotyper
---


# rad_haplotyper

## Overview
rad_haplotyper is a specialized tool for converting SNP data into multi-allelic haplotypes using read-level information from RAD-seq experiments. By phasing SNPs that occur on the same RAD locus, the tool helps researchers avoid the statistical pitfalls of physical linkage and provides a robust method for filtering out paralogous sequences. It supports both de novo assemblies and genomic reference-based alignments, producing standardized outputs for downstream population genetic analysis.

## Installation
The most reliable way to install rad_haplotyper and its dependencies (including Perl modules like Bio::Cigar and Vcf) is via Bioconda:

```bash
conda install -c bioconda rad_haplotyper
```

## Core Workflows

### 1. Basic Haplotype Calling (De Novo)
Use this mode when your reference genome consists of discrete RAD loci (e.g., a de novo assembly where each contig is a RAD tag).
*   **Requirement**: VCF file and BAM files must be in the current working directory.

```bash
perl rad_haplotyper.pl -v snps.vcf
```

### 2. Genomic Reference Mode
Use this mode when reads are aligned to a full genomic reference. You must provide a BED file defining the RAD loci intervals.

```bash
perl rad_haplotyper.pl -v snps.vcf -b rad_loci.bed --genomic_ref -r reference.fasta
```

### 3. Generating Population Genetic Outputs
To produce a Genepop file for downstream analysis, you must provide a population map (`-p`).

```bash
perl rad_haplotyper.pl -v snps.vcf -g output.genepop -p popmap.txt
```

## Key Parameters and Options
- `-v, --vcf`: Input VCF file containing SNP calls.
- `-b, --bed`: BED file containing intervals for RAD loci (required for `--genomic_ref`).
- `-r, --reference`: FASTA reference genome.
- `-p, --popmap`: Tab-separated file mapping individuals to populations.
- `-m, --max_count`: Maximum number of haplotypes allowed per individual (default is 2 for diploids; higher values suggest paralogy).
- `-u, --out_vcf`: Output the results in VCF format.

## Expert Tips and Best Practices
- **Pre-filter your VCF**: rad_haplotyper is sensitive to low-quality SNP calls. A single poorly called SNP can cause an entire RAD locus to fail the haplotyping process. Filter your VCF for quality and depth before running this tool.
- **BAM Location**: Ensure all BAM files referenced in the VCF are present in the directory where you execute the script, as the tool parses these to determine phase.
- **Quality Control via `stats.out`**: Always inspect the `stats.out` file. It categorizes failures into "possible paralogs," "low-coverage/genotyping errors," or "complex polymorphisms." Use this file in R to set custom thresholds for locus filtering.
- **Individual Performance**: Check `ind_stats.out` to identify problematic individuals with high rates of missing or failed haplotypes, which may indicate poor library preparation or sequencing quality.
- **Paralog Detection**: If a locus consistently shows more than two haplotypes in diploid individuals, it is a strong candidate for a paralogous region and should likely be excluded from neutral genetic analyses.

## Reference documentation
- [rad_haplotyper GitHub Repository](./references/github_com_chollenbeck_rad_haplotyper.md)
- [Bioconda rad_haplotyper Overview](./references/anaconda_org_channels_bioconda_packages_rad_haplotyper_overview.md)