---
name: bioconductor-allelicimbalance
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/AllelicImbalance.html
---

# bioconductor-allelicimbalance

name: bioconductor-allelicimbalance
description: Analysis of allelic imbalance (ASE) in RNA-seq data. Use this skill to import BAM/VCF files into ASEset objects, perform statistical tests for imbalance (chi-square, binomial), and visualize allele-specific expression using barplots and genomic location plots.

# bioconductor-allelicimbalance

## Overview

The `AllelicImbalance` package provides a framework for investigating Allele-Specific Expression (ASE) in RNA-seq data. It centers around the `ASEset` object (extending `RangedSummarizedExperiment`), which stores allele counts for heterozygous SNPs across multiple samples. The package facilitates the transition from raw BAM files to statistical significance testing and high-quality visualizations of genomic imbalance.

## Core Workflow

### 1. Creating an ASEset Object

The most common way to start is by importing allele counts from BAM files at specific genomic positions.

```r
library(AllelicImbalance)
library(GenomicRanges)

# Define regions of interest
searchArea <- GRanges(seqnames = "17", ranges = IRanges(79478301, 79478361))

# Import reads from BAM files
pathToFiles <- system.file("extdata/ERP000101_subset", package = "AllelicImbalance")
reads <- impBamGAL(pathToFiles, searchArea)

# Identify heterozygous positions (or provide your own via VCF)
heterozygotePositions <- scanForHeterozygotes(reads)

# Get allele counts and build the ASEset
countList <- getAlleleCounts(reads, heterozygotePositions)
ase <- ASEsetFromCountList(heterozygotePositions, countList)
```

### 2. Adding Metadata (Genotypes, Phase, and Reference)

For advanced analysis (like mapping bias detection or maternal/paternal plotting), you must define reference alleles and phase.

```r
# Set reference alleles (can be from Fasta or manual)
ref(ase) <- c("G", "T", "C") 

# Infer genotypes and alternative alleles from counts
genotype(ase) <- inferGenotypes(ase)
alt(ase) <- inferAltAllele(ase)

# Add phase information (maternal|paternal)
# Usually imported from VCF via VariantAnnotation::readGT
phase(ase) <- phase_matrix 
```

### 3. Statistical Testing

Test for significant deviation from the expected 50/50 allele distribution.

```r
# Binomial test (good for low counts)
binom_results <- binom.test(ase, strand = "*")

# Chi-square test
chisq_results <- chisq.test(ase, strand = "*")
```

### 4. Visualization

The package provides both base R and Grid-based (Gviz compatible) plotting functions.

```r
# Standard barplot of counts
barplot(ase[1], strand = "+", type = "counts")

# Fraction plot (useful for comparing many samples)
barplot(ase[1], type = "fraction", top.fraction.criteria = "ref")

# Genomic location plot (ASE across a region/gene)
locationplot(ase, type = "fraction")

# Gviz integration
library(Gviz)
genome(ase) <- "hg19"
glocationplot(ase, strand = "+")
```

## Key Functions Reference

- `impBamGAL`: Imports BAM files into a GAlignmentsList.
- `getAlleleCounts`: Extracts nucleotide counts per sample at specified GRanges.
- `ASEsetFromCountList`: Constructor for the main `ASEset` object.
- `regionSummary`: Summarizes AI effects over a region (e.g., a whole transcript).
- `fraction`: Calculates the ratio of specific alleles (e.g., reference allele fraction).
- `getAreaFromGeneNames`: Helper to get GRanges for a gene symbol using `org.Hs.eg.db`.

## Tips for Success

- **Strand Specificity**: If your RNA-seq protocol is strand-specific, ensure you use `strand="+"` and `strand="-"` during import and plotting to avoid mixing signals.
- **Mapping Bias**: Use `fraction(ase, top.fraction.criteria="ref")` to check if the reference allele is globally over-represented, which indicates alignment bias.
- **Object Updates**: If using old `ASEset` objects from Bioconductor versions < 3.2, they may need to be recreated or updated to match the modern `SummarizedExperiment` structure.

## Reference documentation

- [AllelicImbalance Vignette](./references/AllelicImbalance-vignette.md)