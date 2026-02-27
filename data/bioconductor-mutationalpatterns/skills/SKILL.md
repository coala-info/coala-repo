---
name: bioconductor-mutationalpatterns
description: This tool performs comprehensive analysis and visualization of mutational patterns and signatures in genomic data. Use when user asks to load VCF files for mutational analysis, extract de novo signatures using NMF, refit profiles to known COSMIC signatures, or analyze transcriptional and replicative strand bias.
homepage: https://bioconductor.org/packages/release/bioc/html/MutationalPatterns.html
---


# bioconductor-mutationalpatterns

name: bioconductor-mutationalpatterns
description: Comprehensive analysis of mutational patterns in genomic data using the MutationalPatterns R package. Use this skill when you need to: (1) Load and process VCF files for mutational analysis, (2) Extract de novo mutational signatures using NMF, (3) Refit mutational profiles to known COSMIC or SIGNAL signatures, (4) Analyze transcriptional or replicative strand bias, (5) Evaluate genomic distribution and enrichment in specific regions, or (6) Calculate and visualize lesion segregation.

# bioconductor-mutationalpatterns

## Overview

The `MutationalPatterns` package is a Bioconductor tool designed to characterize mutational processes by analyzing the footprints they leave in genomic DNA. It supports Single Nucleotide Variants (SNVs), Indels, Double Base Substitutions (DBSs), and Multi-Base Substitutions (MBSs). The package facilitates the entire workflow from raw VCF loading to signature extraction, refitting, and advanced genomic association analyses.

## Core Workflow

### 1. Data Loading and Preparation
Load VCF files into a `GRangesList` and specify the reference genome (e.g., `BSgenome.Hsapiens.UCSC.hg19`).

```r
library(MutationalPatterns)
library(BSgenome.Hsapiens.UCSC.hg19)

ref_genome <- "BSgenome.Hsapiens.UCSC.hg19"
vcf_files <- list.files(path, pattern = ".vcf", full.names = TRUE)
sample_names <- c("sample1", "sample2")

# Load SNVs (default)
grl <- read_vcfs_as_granges(vcf_files, sample_names, ref_genome)

# Load all types (SNV, Indel, DBS, MBS)
grl_all <- read_vcfs_as_granges(vcf_files, sample_names, ref_genome, type = "all")
snv_grl <- get_mut_type(grl_all, type = "snv")
indel_grl <- get_mut_type(grl_all, type = "indel")
```

### 2. Mutation Characteristics and Spectrum
Analyze the base substitution types and trinucleotide contexts.

```r
# Count occurrences
type_occurrences <- mut_type_occurrences(grl, ref_genome)

# Plot 6-type spectrum
plot_spectrum(type_occurrences, CT = TRUE, by = tissue_metadata)

# Create 96-trinucleotide matrix
mut_mat <- mut_matrix(vcf_list = grl, ref_genome = ref_genome)
plot_96_profile(mut_mat[, 1:2])
```

### 3. Mutational Signatures

#### De Novo Extraction (NMF)
Extract signatures without prior knowledge. Use `nmf` to estimate rank first if the number of signatures is unknown.

```r
# Add pseudocount to avoid zeros
mut_mat <- mut_mat + 0.0001
nmf_res <- extract_signatures(mut_mat, rank = 2, nrun = 10)

# Visualize
plot_contribution(nmf_res$contribution, nmf_res$signature, mode = "relative")
```

#### Signature Refitting
Quantify the contribution of known signatures (e.g., COSMIC) to your samples.

```r
signatures <- get_known_signatures() # Defaults to COSMIC SNV
fit_res <- fit_to_signatures(mut_mat, signatures)

# Strict refitting to reduce overfitting
strict_refit <- fit_to_signatures_strict(mut_mat, signatures, max_delta = 0.004)
plot_contribution(strict_refit$fit_res$contribution)
```

### 4. Strand Bias Analysis
Evaluate if mutations are biased toward the transcribed/untranscribed or leading/lagging strands.

```r
# Transcriptional Strand Bias
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
genes_hg19 <- genes(TxDb.Hsapiens.UCSC.hg19.knownGene)
mut_mat_s <- mut_matrix_stranded(grl, ref_genome, genes_hg19)
strand_counts <- strand_occurrences(mut_mat_s, by = tissue)
strand_bias <- strand_bias_test(strand_counts)
plot_strand_bias(strand_bias)
```

### 5. Genomic Distribution
Test for enrichment or depletion of mutations in specific genomic regions (e.g., promoters, enhancers).

```r
# regions is a GRangesList of genomic features
# surveyed_list is a list of GRanges representing callable loci
distr <- genomic_distribution(grl, surveyed_list, regions)
distr_test <- enrichment_depletion_test(distr)
plot_enrichment_depletion(distr_test)
```

### 6. Lesion Segregation
Identify strand-coordinated mutagenesis (Watson vs. Crick asymmetry) across cell divisions.

```r
# Visualize strand distribution per chromosome
plot_lesion_segregation(grl)

# Statistical test
calc_lesion <- calculate_lesion_segregation(grl, sample_names)
```

## Tips for Success
- **Reference Genomes**: Ensure the `BSgenome` object exactly matches the assembly used for VCF calling.
- **Indel Contexts**: Use `get_indel_context(indel_grl, ref_genome)` before `count_indel_contexts()` to follow COSMIC standards.
- **Overfitting**: Always prefer `fit_to_signatures_strict` or tissue-specific signatures (via `get_known_signatures(source = "SIGNAL", sig_type = "tissue", ...)` ) over naive refitting to avoid signature misattribution.
- **Visualization**: Most plots return `ggplot` objects and can be further customized using `+ theme()` or `+ scale_fill_manual()`.

## Reference documentation
- [Introduction to MutationalPatterns](./references/Introduction_to_MutationalPatterns.md)