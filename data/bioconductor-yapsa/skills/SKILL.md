---
name: bioconductor-yapsa
description: This tool performs supervised mutational signature analysis using Linear Combination Decomposition to attribute known signatures to mutation catalogues. Use when user asks to attribute mutational signatures to SNV or Indel catalogues, apply signature-specific cutoffs, calculate confidence intervals via profile likelihood, or perform stratified mutational catalogue analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/YAPSA.html
---

# bioconductor-yapsa

name: bioconductor-yapsa
description: Performs supervised mutational signature analysis using Linear Combination Decomposition (LCD). Use this skill to attribute mutational signatures (COSMIC, PCAWG) to SNV or Indel catalogues, apply signature-specific cutoffs, calculate confidence intervals via profile likelihood, and perform stratified mutational catalogue (SMC) analysis to identify enrichment/depletion patterns across genomic strata.

# bioconductor-yapsa

## Overview
YAPSA (Yet Another Package for Signature Analysis) is a Bioconductor package designed for the supervised analysis of mutational signatures. Unlike discovery-based methods (NMF), YAPSA uses Linear Combination Decomposition (LCD) to attribute known signatures to samples. This allows for analysis of small cohorts (even single samples) and provides advanced features like signature-specific cutoffs to reduce false positives, confidence interval estimation, and stratified analysis to see how signatures vary across different genomic regions or mutation densities.

## Core Workflow

### 1. Data Preparation
Load the package and required genome data. YAPSA typically works with data frames containing variant calls (CHROM, POS, REF, ALT, PID).

```r
library(YAPSA)
library(BSgenome.Hsapiens.UCSC.hg19)

# Load built-in signatures and cutoffs
data(sigs)
data(cutoffs)
```

### 2. Building a Mutational Catalogue
Convert variant data frames into a mutational catalogue matrix (96 features for SNVs).

```r
word_length <- 3
mutCat_list <- create_mutation_catalogue_from_df(
  variant_df,
  this_seqnames.field = "CHROM",
  this_start.field = "POS",
  this_end.field = "POS",
  this_PID.field = "PID",
  this_subgroup.field = "SUBGROUP",
  this_refGenome = BSgenome.Hsapiens.UCSC.hg19,
  this_wordLength = word_length
)
mutCat_df <- as.data.frame(mutCat_list$matrix)
```

### 3. Signature Attribution (LCD)
Perform the decomposition. It is highly recommended to use `LCD_complex_cutoff` or `LCD_complex_cutoff_combined` with signature-specific cutoffs to minimize false positive attributions.

```r
# Select COSMIC signatures and corresponding optimal cutoffs (cost factor 6)
current_sig_df <- AlexCosmicValid_sig_df
current_sigInd_df <- AlexCosmicValid_sigInd_df
current_cutoff_vector <- cutoffCosmicValid_abs_df[6,]

# Run supervised analysis
results <- LCD_complex_cutoff_combined(
  in_mutation_catalogue_df = mutCat_df,
  in_cutoff_vector = current_cutoff_vector,
  in_signatures_df = current_sig_df,
  in_sig_ind_df = current_sigInd_df
)

# Access exposures
exposures <- results$cohort$exposures
```

### 4. Visualization
YAPSA provides specialized plotting functions for exposures.

```r
# Create subgroup annotation if needed
subgroups_df <- make_subgroups_df(metadata_df, exposures)

# Plot absolute exposures
exposures_barplot(
  in_exposures_df = exposures,
  in_signatures_ind_df = results$cohort$out_sig_ind_df,
  in_subgroups_df = subgroups_df
)
```

## Advanced Features

### Stratified Mutational Catalogue (SMC)
Analyze if signatures are enriched in specific genomic regions (e.g., high vs. low mutation density, or specific chromatin states).

```r
# 1. Annotate variants with strata (e.g., density_cat)
# 2. Run SMC
mut_density_list <- run_SMC(
  variant_df,
  results$cohort$signatures,
  results$cohort$out_sig_ind_df,
  subgroups_df,
  column_name = "density_cat",
  refGenome = BSgenome.Hsapiens.UCSC.hg19
)

# 3. Test for significance
stat_res <- stat_test_SMC(mut_density_list, in_flag = "norm")
```

### Confidence Intervals
Calculate 95% CIs for exposures using the profile likelihood method.

```r
ci_df <- variateExp(
  in_catalogue_df = mutCat_df,
  in_sig_df = results$cohort$signatures,
  in_exposures_df = results$cohort$exposures,
  in_sigLevel = 0.025
)

plotExposuresConfidence(ci_df, subgroups_df, results$cohort$out_sig_ind_df)
```

### Whole Exome Sequencing (WES) Normalization
WES data must be corrected for the triplet frequency differences between the exome capture kit and the whole genome.

```r
data(targetCapture_cor_factors)
# Select kit, e.g., "AgilentSureSelectAllExon"
cor_factors <- targetCapture_cor_factors[["AgilentSureSelectAllExon"]]
corrected_mutCat <- normalizeMotifs_otherRownames(mutCat_df, cor_factors$rel_cor)
```

## Tips for Success
- **Signature Selection**: Use `AlexCosmicValid_sig_df` for standard COSMIC v2 analysis or `PCAWG_SP_SBS_sigs_Real_df` for PCAWG/COSMIC v3.
- **Cutoffs**: Always use signature-specific cutoffs. For WGS, use `_abs_` cutoffs; for WES, use `_rel_` cutoffs.
- **Indels**: For Indel analysis, use `PCAWG_SP_ID_sigs_df` and ensure your input data follows the 83-feature classification required by PCAWG.

## Reference documentation
- [Usage of YAPSA](./references/YAPSA.md)
- [Confidence Intervals](./references/vignette_confidenceIntervals.md)
- [Whole Exome Sequencing (WES) data](./references/vignette_exomes.md)
- [Signature-specific cutoffs](./references/vignette_signature_specific_cutoffs.md)
- [Stratified Analysis of Mutational Signatures](./references/vignette_stratifiedAnalysis.md)
- [Indel signature analysis](./references/vignettes_Indel.md)