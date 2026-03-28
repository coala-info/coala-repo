---
name: atlas
description: ATLAS processes low-depth and ancient DNA sequencing data by incorporating post-mortem damage patterns and error models into genotype likelihood calculations. Use when user asks to estimate post-mortem damage, call genotypes from ancient samples, calculate population genetics statistics, or filter and diagnose BAM files.
homepage: https://bitbucket.org/wegmannlab/atlas/wiki/Home
---


# atlas

## Overview
ATLAS (Analysis Tools for Low-depth and Ancient Samples) is designed to handle the unique challenges of ancient DNA, such as short fragments, post-mortem damage (C->T deaminations), and low sequencing depth. Unlike standard tools that might require hard-trimming read ends, ATLAS incorporates error models and PMD patterns directly into its genotype likelihood calculations. This allows for more accurate variant calling and diversity estimation without sacrificing data.

## Core Workflows

### 1. Initial Diagnostics and Filtering
Before analysis, assess the quality and properties of your BAM files.
- **BAM Statistics**: `atlas BAMDiagnostics --bam input.bam`
- **Soft-Clipping Assessment**: `atlas assessSoftClipping --bam input.bam`
- **Filtering**: Create a clean dataset by filtering on mapping quality or specific chromosomes.
  ```bash
  atlas filterBAM --bam input.bam --filterMQ "[50,256]" --chr "chr1,chr2" --out filtered
  ```

### 2. Error and PMD Estimation
For ancient samples, you must estimate the damage patterns to avoid false-positive variant calls.
- **Estimate Errors**: Learns PMD and recalibrates base qualities.
  ```bash
  atlas estimateErrors --bam input.bam --fasta reference.fasta --minDeltaLL 0.001 --out sample_err
  ```
- **Output**: This generates a `_RGInfo.json` file containing the learned parameters, which should be passed to subsequent tasks using `--RGInfo`.

### 3. Genotype Likelihoods and Calling
ATLAS prefers working with Genotype Likelihoods (GLF) to account for uncertainty.
- **Generate GLF**: `atlas GLF --bam input.bam --RGInfo sample_err_RGInfo.json`
- **Call Genotypes**: Use Maximum Likelihood (MLE) or Bayesian methods.
  ```bash
  atlas call --method MLE --bam input.bam --fasta reference.fasta --RGInfo sample_err_RGInfo.json
  ```

### 4. Population Genetics
- **Major/Minor Alleles**: Estimate from multiple GLF files.
  ```bash
  atlas majorMinor --glf sample1.glf.gz,sample2.glf.gz --out population
  ```
- **Heterozygosity**: Estimate directly from likelihoods to maintain accuracy at low depth.
  ```bash
  atlas summaryStats --bam input.bam --fasta reference.fasta --RGInfo sample_err_RGInfo.json
  ```
- **Inbreeding (F)**: `atlas inbreeding --vcf population.vcf.gz --minMAF 0.05`

## Expert Tips
- **Context Window**: When estimating errors, use a small `--minDeltaLL` (e.g., 0.001) for production runs, though higher values (0.1) can be used for quick testing.
- **Downsampling**: Use `atlas downsample --bam input.bam --prob 0.1` to test how your diversity estimates hold up at lower depths.
- **PMD Models**: For double-stranded libraries, the default is `CT5;GA3`. For single-stranded, C->T damage typically occurs at both ends.
- **VCF Formats**: Use `atlas convertVCF --format beagle` to prepare data for downstream tools like PCAngsd.



## Subcommands

| Command | Description |
|---------|-------------|
| atlas | Estimating population allele frequencies |
| atlas | Creating a mask BED file |
| atlas | Writing reads that pass filters to BAM file |
| atlas | ATLAS 2.0.1 |
| atlas | ATLAS 2.0.1 |
| atlas | Create bed file from pileup file |
| atlas | Printing a GLF file to screen |
| atlas | Generating a PSMC Input file probabilistically |
| atlas | Simulate bam- or vcf-file[s] |
| atlas | Comparing genotype calls in two VCF files |
| atlas ancestralalleles | Writing FASTA-file with ancestral alleles |
| atlas assessSoftClipping | Assessing level of soft clipping in BAM file |
| atlas mergeOverlappingReads | Merging paired-end reads in BAM file |
| atlas mutationLoad | Estimating mutation load across the genome |
| atlas qualityTransformation | Printing Quality Transformation |

## Reference documentation
- [BAM Diagnostics](./references/atlaswiki_netlify_app_bamdiagnostics.md)
- [Genotype Calling](./references/atlaswiki_netlify_app_call.md)
- [Error Estimation](./references/atlaswiki_netlify_app_estimateerrors.md)
- [Ancient DNA Workflow](./references/atlaswiki_netlify_app_ancient-dna.md)
- [Single Individual Tutorial](./references/atlaswiki_netlify_app_data-from-a-single-individual.md)