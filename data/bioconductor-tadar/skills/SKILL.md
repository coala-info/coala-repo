---
name: bioconductor-tadar
description: This tool performs Differential Allelic Representation analysis to identify and account for eQTL-driven expression biases in RNA-seq data. Use when user asks to quantify DAR from VCF files, moderate differential expression p-values, or identify genetic linkage confounding in non-isogenic experimental designs.
homepage: https://bioconductor.org/packages/release/bioc/html/tadar.html
---

# bioconductor-tadar

name: bioconductor-tadar
description: Perform Differential Allelic Representation (DAR) analysis to identify eQTL-driven expression biases in RNA-seq data. Use this skill when working with non-isogenic experimental designs (e.g., CRISPR mutants vs. wild-type) where genetic linkage might confound differential expression (DE) results. It provides tools for processing VCF genotypes, calculating DAR metrics (0 to 1), and moderating DE p-values to reduce false positives.

# bioconductor-tadar

## Overview

The `tadar` package addresses the issue of Differential Allelic Representation (DAR), which occurs when experimental groups have unequal distributions of polymorphic alleles. If these alleles are expression quantitative trait loci (eQTLs), they can cause expression differences that mimic functional responses to experimental conditions. This skill guides you through the sequential workflow of quantifying DAR from VCF files and using those values to moderate p-values from standard differential gene expression (DGE) analyses.

## Core Workflow

### 1. Data Preparation and Loading
Load multi-sample genotype calls from a VCF file. Phasing information is typically removed as it is not required for DAR.

```r
library(tadar)
library(GenomicRanges)

# Load genotypes from VCF
vcf_path <- "path/to/your/file.vcf.bgz"
genotypes <- readGenotypes(file = vcf_path)

# Load gene features (GRanges)
# data("your_features") 
```

### 2. Allele Counting and Filtering
Define your experimental groups and count alleles at each locus. Filter out low-information loci (e.g., those with too many missing genotypes).

```r
groups <- list(
    mutant = c("sample1", "sample2", "sample3"),
    wt = c("sample4", "sample5", "sample6")
)

# Count alleles per group
counts <- countAlleles(genotypes = genotypes, groups = groups)

# Filter loci (default: n_called > n_missing)
counts_filt <- filterLoci(counts = counts)
```

### 3. Normalization and DAR Calculation
Convert counts to proportions and calculate the DAR metric based on Euclidean distance between groups.

```r
# Normalize to proportions
props <- countsToProps(counts = counts_filt)

# Define contrasts (similar to limma)
library(limma)
contrasts <- makeContrasts(mut_vs_wt = mutant - wt, levels = names(groups))

# Calculate DAR (region_loci smooths values over neighboring SNPs)
dar_results <- dar(props = props, contrasts = contrasts, region_loci = 5)
```

### 4. Feature Assignment
Assign the calculated DAR values to your genomic features (e.g., genes). Use `flipRanges` to ensure DAR estimates cover the genomic regions between SNPs.

```r
# Extend ranges to cover chromosome edges and fill gaps
dar_regions <- flipRanges(dar_results, extend_edges = TRUE)

# Assign DAR to genes
gene_dar <- assignFeatureDar(dar = dar_regions, features = my_genes)
```

### 5. P-Value Moderation
Use the gene-level DAR values to moderate p-values from a DGE analysis (e.g., from `limma` or `DESeq2`). This reduces the significance of genes where expression differences are likely driven by DAR.

```r
# Assuming 'top_table' contains your DGE results
# Merge DAR values into your results table
results_merged <- merge(top_table, mcols(gene_dar$mut_vs_wt), by = "gene_id")

# Moderate p-values
results_merged$mod_PValue <- modP(results_merged$PValue, results_merged$dar)
```

## Visualization

### Chromosomal Trends
Visualize DAR trends along a chromosome to identify regions of high diversity.

```r
plotChrDar(
    dar = dar_results$mut_vs_wt, 
    dar_val = "region", 
    chr = "1",
    foi = mutation_locus_gr, # Feature of interest
    title = "DAR Trend on Chromosome 1"
)
```

### ECDF Comparison
Compare DAR distributions across different chromosomes to see if specific chromosomes (e.g., the one carrying a mutation) are outliers.

```r
plotDarECDF(dar = dar_results$mut_vs_wt, dar_val = "origin", highlight = "1")
```

## Implementation Tips
- **Region Selection**: Use `region_loci` in the `dar()` function to create "elastic" regions. This is generally more robust for gene assignment than fixed base-pair windows.
- **Filtering Stringency**: If you have high-quality data, use `filter = n_missing == 0` in `filterLoci()` for the most accurate allelic representation.
- **Interpretation**: A DAR value of 0 means identical allelic representation between groups; 1 means complete diversity. High DAR values in DE genes suggest the "expression" might be an eQTL artifact.

## Reference documentation
- [Differential Allelic Representation (DAR) analysis](./references/dar.md)