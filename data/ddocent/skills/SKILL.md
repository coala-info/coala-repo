---
name: ddocent
description: dDocent is an interactive pipeline that processes raw RADseq data into high-quality SNP calls by integrating trimming, mapping, and variant calling tools. Use when user asks to process RADseq reads, perform de novo assembly of RAD data, or call SNPs using FreeBayes.
homepage: https://ddocent.com
---


# ddocent

## Overview
dDocent is an interactive bash-based pipeline that streamlines the complex process of turning raw RADseq reads into high-quality SNP calls. It acts as a wrapper for several bioinformatics tools, including Trimmomatic for trimming, BWA for mapping, and FreeBayes for haplotype-based variant calling. It is specifically designed to handle the unique properties of RAD data, such as high levels of polymorphism and the requirement for significant data reduction to achieve accurate de novo assemblies.

## Core Usage and Best Practices

### 1. Data Preparation and Naming
dDocent relies on a strict naming convention to parse population and individual metadata. Files must be gzipped FASTQ.
- **Format**: `Population_Individual.F.fq.gz` (Forward) and `Population_Individual.R.fq.gz` (Reverse).
- **Constraint**: Do not use underscores `_` within the Population or Individual identifiers themselves; use only one underscore to separate them.

### 2. Running the Pipeline
The tool is primarily interactive. To start the process, navigate to your data directory and run:
```bash
dDocent
```
The pipeline will prompt you for:
- Number of processors to use.
- Maximum memory usage.
- Trimming parameters (defaulting to Trimmomatic best practices).
- Assembly parameters (if performing de novo assembly).

### 3. De Novo Assembly Optimization
For de novo assembly, choosing the correct "K" cutoffs (k1: within-individual coverage; k2: number of individuals) is critical.
- **ReferenceOpt.sh**: Run this script on a subset of your data (e.g., 1-2 individuals per population) to test a range of similarity thresholds.
- **RefMapOpt.sh**: Use this after `ReferenceOpt.sh` to determine which assembly parameters maximize properly paired reads and minimize mismatches.
- **Rule of Thumb**: Look for the "point of inflection" in the assembly curves where the number of contigs stabilizes.

### 4. Using a Pre-existing Reference
If you already have a reference genome or a previously generated assembly:
- Name the file `reference.fasta`.
- Place it in the working directory.
- When prompted by dDocent, choose to skip the assembly step.

### 5. SNP Calling with FreeBayes
dDocent uses FreeBayes for variant calling, which is population-aware and haplotype-based.
- It automatically handles INDELs and complex polymorphisms.
- It uses a "scatter-gather" technique to parallelize calling across processing cores, significantly speeding up the process for large datasets.

### 6. Filtering Strategy
dDocent performs minimal initial filtering (keeping SNPs called in 90% of individuals). You should perform secondary filtering using VCFtools or the provided helper scripts:
- **Missing Data**: Filter individuals with high missingness (e.g., >50%) before final SNP filtering.
- **Depth**: While dDocent allows low-depth calls due to the Bayesian nature of FreeBayes, a minimum genotype depth (minDP) of 3 is a common starting point for RAD data.
- **Paralogs**: Use the `test_HWE.sh` or haplotyping scripts to identify and remove potential paralogs (loci with excessive heterozygosity).

## Expert Tips
- **Memory Management**: RADseq assembly is memory-intensive. If the pipeline crashes during the CD-HIT or Rainbow steps, reduce the number of processors to allow more RAM per thread.
- **Trimming**: If you have already trimmed your reads using a different tool, ensure they still follow the naming convention and contain the `.R1.fq.gz` / `.R2.fq.gz` suffix so dDocent recognizes them as processed.
- **Data Reduction**: In the assembly step, setting the k1 cutoff too low will include sequencing errors in your reference, while setting it too high will lose rare alleles.

## Reference documentation
- [User Guide](./references/ddocent_com_UserGuide.md)
- [Quick Start Guide](./references/ddocent_com_quick.md)
- [De Novo Assembly Details](./references/ddocent_com_assembly.md)
- [SNP Filtering Tutorial](./references/ddocent_com_filtering.md)
- [Why dDocent?](./references/ddocent_com_why.md)