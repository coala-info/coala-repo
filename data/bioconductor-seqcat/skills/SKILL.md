---
name: bioconductor-seqcat
description: The seqCAT package authenticates biological samples and detects sample swaps by comparing Single Nucleotide Variant profiles generated from VCF files. Use when user asks to verify cell line identity, perform pairwise or many-to-many sample comparisons, calculate genotype concordance, or authenticate samples against the COSMIC database.
homepage: https://bioconductor.org/packages/release/bioc/html/seqCAT.html
---


# bioconductor-seqcat

## Overview
The `seqCAT` package (High Throughput Sequencing Cell Authentication Toolkit) provides a workflow for verifying the identity and genetic consistency of biological samples. It works by creating Single Nucleotide Variant (SNV) profiles from VCF files and performing pairwise or many-to-many comparisons. It is particularly useful for cell line authentication, detecting sample swaps, and analyzing the functional impact of variants in specific genes or regions.

## Core Workflow

### 1. Creating SNV Profiles
Profiles are created from VCF files (e.g., GATK output). The process filters for high-confidence variants and can prioritize variants with high biological impact if the VCF is annotated (e.g., with SnpEff).

```r
library(seqCAT)

# Create a profile for a specific sample within a VCF
vcf_file <- "path/to/sample.vcf.gz"
profile_hct116 <- create_profile(vcf_file, "HCT116")

# Create profiles for all VCFs in a directory
vcf_dir <- "path/to/vcf_directory"
profiles_list <- create_profiles(vcf_dir)
```

**Filtration Options:**
- `min_depth`: Minimum sequencing depth (default: 10).
- `filter_vc`: Filter based on VCF FILTER column (default: TRUE).
- `filter_mt`: Remove mitochondrial variants (default: TRUE).
- `filter_gd`: De-duplicate at the gene level (default: TRUE).

### 2. Comparing Profiles
Compare two profiles to find overlapping variants and calculate genotype matches.

```r
# Pairwise comparison (intersection of variants by default)
comparison <- compare_profiles(profile_hct116, profile_rko)

# Union mode (includes variants present in only one sample)
comparison_union <- compare_profiles(profile_hct116, profile_rko, mode = "union")
```

### 3. Evaluating Similarity
Calculate concordance and a weighted similarity score. A score > 90 is generally considered a match for cell line authentication.

```r
sim_stats <- calculate_similarity(comparison)
# Returns: overlaps, matches, concordance (%), and similarity_score
```

### 4. Functional Characterization
Analyze the distribution of variant impacts (HIGH, MODERATE, LOW, MODIFIER) or check specific genes of interest.

```r
# Plot impact distribution
plot_impacts(comparison)

# Filter for specific genes or regions
kras_variants <- comparison[comparison$gene == "KRAS", ]

# List genotypes for specific coordinates across multiple profiles
known_pos <- data.frame(chr = c(12, 12), pos = c(25398281, 21797029))
variant_list <- list_variants(list(profile_hct116, profile_rko), known_pos)
```

## Working with COSMIC
`seqCAT` can authenticate samples against the COSMIC database. You must provide the COSMIC TSV files (e.g., `CosmicCLP_MutantExport.tsv.gz`).

```r
cosmic_file <- "CosmicCLP_MutantExport.tsv.gz"

# List available cell lines in COSMIC
cell_lines <- list_cosmic(cosmic_file)

# Read a specific COSMIC profile
profile_cosmic <- read_cosmic(cosmic_file, "HCT116")

# Compare your sample to COSMIC
cosmic_comp <- compare_profiles(profile_hct116, profile_cosmic)
```

## Multiple Comparisons
For large projects, use `compare_many` to generate a matrix of similarities.

```r
# Many-to-many comparison
all_comps <- compare_many(list(p1, p2, p3))

# Visualise with a heatmap
plot_heatmap(all_comps[[1]])
```

## Profile Management
Profiles can be saved to and loaded from disk to save time on re-analysis.

```r
# Write to disk (supports .txt, .bed, .gtf, .gff)
write_profile(profile_hct116, "HCT116.profile.txt")

# Read from disk
profile_hct116 <- read_profile("HCT116.profile.txt")
```

## Reference documentation
- [seqCAT](./references/seqCAT.md)