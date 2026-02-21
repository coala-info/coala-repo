# ANCOM Tutorial

#### Huang Lin\(^1\)

#### \(^1\)University of Maryland, College Park, MD 20742

#### October 29, 2025

```
knitr::opts_chunk$set(message = FALSE, warning = FALSE, comment = NA,
                      fig.width = 6.25, fig.height = 5)
library(ANCOMBC)
library(tidyverse)
```

# 1. Introduction

Analysis of Composition of Microbiomes (ANCOM) (Mandal et al. 2015) is a differential abundance (DA) analysis for microbial absolute abundances. It accounts for the compositionality of microbiome data by performing the additive log ratio (ALR) transformation. ANCOM employs a heuristic strategy to declare taxa that are significantly differentially abundant. For a given taxon, the output W statistic represents the number ALR transformed models where the taxon is differentially abundant with regard to the variable of interest. The larger the value of W, the more likely the taxon is differentially abundant. For more details, please refer to the [ANCOM](https://www.tandfonline.com/doi/full/10.3402/mehd.v26.27663) paper.

# 2. Installation

Download package.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("ANCOMBC")
```

Load the package.

```
library(ANCOMBC)
```

# 3. Run ANCOM on a real cross-sectional dataset

## 3.1 Import example data

The HITChip Atlas dataset contains genus-level microbiota profiling with HITChip for 1006 western adults with no reported health complications, reported in (Lahti et al. 2014). The dataset is available via the microbiome R package (Lahti et al. 2017) in phyloseq (McMurdie and Holmes 2013) format. In this tutorial, we consider the following covariates:

* Continuous covariates: “age”
* Categorical covariates: “region”, “bmi”
* The group variable of interest: “bmi”

  + Three groups: “lean”, “overweight”, “obese”
  + The reference group: “obese”

```
data(atlas1006, package = "microbiome")

# Subset to baseline
pseq = phyloseq::subset_samples(atlas1006, time == 0)

# Re-code the bmi group
meta_data = microbiome::meta(pseq)
meta_data$bmi = recode(meta_data$bmi_group,
                       obese = "obese",
                       severeobese = "obese",
                       morbidobese = "obese")

# Note that by default, levels of a categorical variable in R are sorted
# alphabetically. In this case, the reference level for `bmi` will be
# `lean`. To manually change the reference level, for instance, setting `obese`
# as the reference level, use:
meta_data$bmi = factor(meta_data$bmi, levels = c("obese", "overweight", "lean"))
# You can verify the change by checking:
# levels(meta_data$bmi)

# Create the region variable
meta_data$region = recode(as.character(meta_data$nationality),
                          Scandinavia = "NE", UKIE = "NE", SouthEurope = "SE",
                          CentralEurope = "CE", EasternEurope = "EE",
                          .missing = "unknown")

phyloseq::sample_data(pseq) = meta_data

# Subset to lean, overweight, and obese subjects
pseq = phyloseq::subset_samples(pseq, bmi %in% c("lean", "overweight", "obese"))
# Discard "EE" as it contains only 1 subject
# Discard subjects with missing values of region
pseq = phyloseq::subset_samples(pseq, ! region %in% c("EE", "unknown"))

print(pseq)
```

```
phyloseq-class experiment-level object
otu_table()   OTU Table:         [ 130 taxa and 873 samples ]
sample_data() Sample Data:       [ 873 samples by 12 sample variables ]
tax_table()   Taxonomy Table:    [ 130 taxa by 3 taxonomic ranks ]
```

## 3.2 Run `ancom` function using `phyloseq` data

```
set.seed(123)
out = ancom(data = pseq, tax_level = "Family", meta_data = NULL,
            p_adj_method = "holm", prv_cut = 0.10,
            lib_cut = 1000, main_var = "bmi", adj_formula = "age + region",
            rand_formula = NULL, lme_control = NULL, struc_zero = TRUE,
            neg_lb = TRUE, alpha = 0.05, n_cl = 2, verbose = TRUE)

res = out$res

# Similarly, if the main variable of interest is continuous, such as age, the
# ancom model can be specified as
# out = ancom(data = pseq, tax_level = "Family", meta_data = NULL,
#             p_adj_method = "holm", prv_cut = 0.10,
#             lib_cut = 1000, main_var = "age", adj_formula = "bmi + region",
#             rand_formula = NULL, lme_control = NULL, struc_zero = FALSE,
#             neg_lb = FALSE, alpha = 0.05, n_cl = 2, verbose = TRUE)
```

## 3.3 Scatter plot for W statistics

```
q_val = out$q_data
beta_val = out$beta_data
# Only consider the effect sizes with the corresponding q-value less than alpha
beta_val = beta_val * (q_val < 0.05)
# Choose the maximum of beta's as the effect size
beta_pos = apply(abs(beta_val), 2, which.max)
beta_max = vapply(seq_along(beta_pos), function(i)
    beta_val[beta_pos[i], i], FUN.VALUE = double(1))
# Number of taxa except structural zeros
n_taxa = ifelse(is.null(out$zero_ind),
                nrow(tse),
                sum(apply(out$zero_ind[, -1], 1, sum) == 0))
# Cutoff values for declaring differentially abundant taxa
cut_off = 0.7 * (n_taxa - 1)

df_fig_w = res %>%
  dplyr::mutate(beta = beta_max,
                direct = case_when(
                  detected_0.7 == TRUE & beta > 0 ~ "Positive",
                  detected_0.7 == TRUE & beta <= 0 ~ "Negative",
                  TRUE ~ "Not Significant"
                  )) %>%
  dplyr::arrange(W)
df_fig_w$taxon = factor(df_fig_w$taxon, levels = df_fig_w$taxon)
df_fig_w$W = replace(df_fig_w$W, is.infinite(df_fig_w$W), n_taxa - 1)
df_fig_w$direct = factor(df_fig_w$direct,
                         levels = c("Negative", "Positive", "Not Significant"))

p_w = df_fig_w %>%
  ggplot(aes(x = taxon, y = W, color = direct)) +
  geom_point(size = 2, alpha = 0.6) +
  labs(x = "Taxon", y = "W") +
  scale_color_discrete(name = NULL) +
  geom_hline(yintercept = cut_off, linetype = "dotted",
             color = "blue", size = 1.5) +
  geom_text(aes(x = 2, y = cut_off + 0.5, label = "W[0.7]"),
            size = 5, vjust = -0.5, hjust = 0, color = "orange", parse = TRUE) +
  theme_bw() +
  theme(axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        panel.grid.major = element_blank())
p_w
```

![](data:image/png;base64...)

## 3.4 Run `ancom` function using `tse` data

```
tse = mia::makeTreeSummarizedExperimentFromPhyloseq(pseq)

set.seed(123)
out = ancom(data = tse, assay_name = "counts",
            tax_level = "Family", meta_data = NULL,
            p_adj_method = "holm", prv_cut = 0.10,
            lib_cut = 1000, main_var = "bmi", adj_formula = "age + region",
            rand_formula = NULL, lme_control = NULL, struc_zero = TRUE,
            neg_lb = TRUE, alpha = 0.05, n_cl = 2, verbose = TRUE)

res = out$res
```

## 3.5 Run `ancom` function by directly providing the abundance and metadata

```
abundance_data = microbiome::abundances(pseq)
aggregate_data = microbiome::abundances(microbiome::aggregate_taxa(pseq, "Family"))
meta_data = microbiome::meta(pseq)

set.seed(123)
out = ancom(data = abundance_data, aggregate_data = aggregate_data,
            meta_data = meta_data, p_adj_method = "holm", prv_cut = 0.10,
            lib_cut = 1000, main_var = "bmi", adj_formula = "age + region",
            rand_formula = NULL, lme_control = NULL, struc_zero = TRUE,
            neg_lb = TRUE, alpha = 0.05, n_cl = 2, verbose = TRUE)

res = out$res
```

# 4. Run ANCOM on a real longitudinal dataset

## 4.1 Import example data

A two-week diet swap study between western (USA) and traditional (rural Africa) diets (Lahti et al. 2014). The dataset is available via the microbiome R package (Lahti et al. 2017) in phyloseq (McMurdie and Holmes 2013) format. In this tutorial, we consider the following fixed effects:

* Continuous covariates: “timepoint”
* Categorical covariates: “nationality”
* The group variable of interest: “group”

  + Three groups: “DI”, “ED”, “HE”
  + The reference group: “DI”

and the following random effects:

* A random intercept
* A random slope: “timepoint”

```
data(dietswap, package = "microbiome")
print(dietswap)
```

```
phyloseq-class experiment-level object
otu_table()   OTU Table:         [ 130 taxa and 222 samples ]
sample_data() Sample Data:       [ 222 samples by 8 sample variables ]
tax_table()   Taxonomy Table:    [ 130 taxa by 3 taxonomic ranks ]
```

## 4.2 Run `ancom` function using `phyloseq` data

```
set.seed(123)
out = ancom(data = dietswap, tax_level = "Family",
            p_adj_method = "holm", prv_cut = 0.10, lib_cut = 1000,
            main_var = "group",
            adj_formula = "nationality + timepoint",
            rand_formula = "(timepoint | subject)",
            lme_control = lme4::lmerControl(),
            struc_zero = TRUE, neg_lb = TRUE, alpha = 0.05, n_cl = 2)

res = out$res
```

## 4.3 Visualization for W statistics

```
q_val = out$q_data
beta_val = out$beta_data
# Only consider the effect sizes with the corresponding q-value less than alpha
beta_val = beta_val * (q_val < 0.05)
# Choose the maximum of beta's as the effect size
beta_pos = apply(abs(beta_val), 2, which.max)
beta_max = vapply(seq_along(beta_pos), function(i) beta_val[beta_pos[i], i],
                  FUN.VALUE = double(1))
# Number of taxa except structural zeros
n_taxa = ifelse(is.null(out$zero_ind),
                nrow(tse),
                sum(apply(out$zero_ind[, -1], 1, sum) == 0))
# Cutoff values for declaring differentially abundant taxa
cut_off = 0.7 * (n_taxa - 1)

df_fig_w = res %>%
  dplyr::mutate(beta = beta_max,
                direct = case_when(
                  detected_0.7 == TRUE & beta > 0 ~ "Positive",
                  detected_0.7 == TRUE & beta <= 0 ~ "Negative",
                  TRUE ~ "Not Significant"
                  )) %>%
  dplyr::arrange(W)
df_fig_w$taxon = factor(df_fig_w$taxon, levels = df_fig_w$taxon)
df_fig_w$W = replace(df_fig_w$W, is.infinite(df_fig_w$W), n_taxa - 1)
df_fig_w$direct = factor(df_fig_w$direct,
                     levels = c("Negative", "Positive", "Not Significant"))

p_w = df_fig_w %>%
  ggplot(aes(x = taxon, y = W, color = direct)) +
  geom_point(size = 2, alpha = 0.6) +
  labs(x = "Taxon", y = "W") +
  scale_color_discrete(name = NULL) +
  geom_hline(yintercept = cut_off, linetype = "dotted",
             color = "blue", size = 1.5) +
  geom_text(aes(x = 2, y = cut_off + 0.5, label = "W[0.7]"),
            size = 5, vjust = -0.5, hjust = 0, color = "orange", parse = TRUE) +
  theme_bw() +
  theme(axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        panel.grid.major = element_blank())
p_w
```

![](data:image/png;base64...)

## 4.4 Run `ancom` function using `tse` data

```
tse = mia::makeTreeSummarizedExperimentFromPhyloseq(dietswap)

set.seed(123)
out = ancom(data = tse, assay_name = "counts", tax_level = "Family",
            p_adj_method = "holm", prv_cut = 0.10, lib_cut = 1000,
            main_var = "group",
            adj_formula = "nationality + timepoint",
            rand_formula = "(timepoint | subject)",
            lme_control = lme4::lmerControl(),
            struc_zero = TRUE, neg_lb = TRUE, alpha = 0.05, n_cl = 2)

res = out$res
```

## 4.5 Run `ancom` function by directly providing the abundance and metadata

```
abundance_data = microbiome::abundances(dietswap)
aggregate_data = microbiome::abundances(microbiome::aggregate_taxa(dietswap, "Family"))
meta_data = microbiome::meta(dietswap)

set.seed(123)
out = ancom(data = abundance_data, aggregate_data = aggregate_data,
            meta_data = meta_data, p_adj_method = "holm",
            prv_cut = 0.10, lib_cut = 1000, main_var = "group",
            adj_formula = "nationality + timepoint",
            rand_formula = "(timepoint | subject)",
            lme_control = lme4::lmerControl(),
            struc_zero = TRUE, neg_lb = TRUE, alpha = 0.05, n_cl = 2)

res = out$res
```

# Session information

```
sessionInfo()
```

```
R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default
BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0

locale:
 [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
 [3] LC_TIME=en_GB              LC_COLLATE=C
 [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
 [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
 [9] LC_ADDRESS=C               LC_TELEPHONE=C
[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base

other attached packages:
 [1] lubridate_1.9.4 forcats_1.0.1   stringr_1.5.2   dplyr_1.1.4
 [5] purrr_1.1.0     readr_2.1.5     tidyr_1.3.1     tibble_3.3.0
 [9] ggplot2_4.0.0   tidyverse_2.0.0 ANCOMBC_2.12.0

loaded via a namespace (and not attached):
  [1] RColorBrewer_1.1-3  rstudioapi_0.17.1   jsonlite_2.0.0
  [4] magrittr_2.0.4      TH.data_1.1-4       farver_2.1.2
  [7] nloptr_2.2.1        rmarkdown_2.30      fs_1.6.6
 [10] vctrs_0.6.5         multtest_2.66.0     minqa_1.2.8
 [13] base64enc_0.1-3     htmltools_0.5.8.1   energy_1.7-12
 [16] haven_2.5.5         cellranger_1.1.0    Rhdf5lib_1.32.0
 [19] Formula_1.2-5       rhdf5_2.54.0        sass_0.4.10
 [22] bslib_0.9.0         htmlwidgets_1.6.4   plyr_1.8.9
 [25] sandwich_3.1-1      rootSolve_1.8.2.4   zoo_1.8-14
 [28] cachem_1.1.0        igraph_2.2.1        lifecycle_1.0.4
 [31] iterators_1.0.14    pkgconfig_2.0.3     Matrix_1.7-4
 [34] R6_2.6.1            fastmap_1.2.0       rbibutils_2.3
 [37] digest_0.6.37       Exact_3.3           numDeriv_2016.8-1.1
 [40] colorspace_2.1-2    S4Vectors_0.48.0    Hmisc_5.2-4
 [43] vegan_2.7-2         labeling_0.4.3      timechange_0.3.0
 [46] mgcv_1.9-3          httr_1.4.7          compiler_4.5.1
 [49] rngtools_1.5.2      proxy_0.4-27        bit64_4.6.0-1
 [52] withr_3.0.2         doParallel_1.0.17   gsl_2.1-8
 [55] htmlTable_2.4.3     S7_0.2.0            backports_1.5.0
 [58] MASS_7.3-65         biomformat_1.38.0   permute_0.9-8
 [61] gtools_3.9.5        CVXR_1.0-15         gld_2.6.8
 [64] tools_4.5.1         foreign_0.8-90      ape_5.8-1
 [67] nnet_7.3-20         glue_1.8.0          nlme_3.1-168
 [70] rhdf5filters_1.22.0 grid_4.5.1          Rtsne_0.17
 [73] checkmate_2.3.3     cluster_2.1.8.1     reshape2_1.4.4
 [76] ade4_1.7-23         generics_0.1.4      microbiome_1.32.0
 [79] gtable_0.3.6        tzdb_0.5.0          class_7.3-23
 [82] data.table_1.17.8   lmom_3.2            hms_1.1.4
 [85] XVector_0.50.0      BiocGenerics_0.56.0 foreach_1.5.2
 [88] pillar_1.11.1       splines_4.5.1       lattice_0.22-7
 [91] survival_3.8-3      gmp_0.7-5           bit_4.6.0
 [94] tidyselect_1.2.1    Biostrings_2.78.0   knitr_1.50
 [97] reformulas_0.4.2    gridExtra_2.3       phyloseq_1.54.0
[100] IRanges_2.44.0      Seqinfo_1.0.0       stats4_4.5.1
[103] xfun_0.53           expm_1.0-0          Biobase_2.70.0
[106] stringi_1.8.7       yaml_2.3.10         boot_1.3-32
[109] evaluate_1.0.5      codetools_0.2-20    cli_3.6.5
[112] rpart_4.1.24        DescTools_0.99.60   Rdpack_2.6.4
[115] jquerylib_0.1.4     dichromat_2.0-0.1   Rcpp_1.1.0
[118] readxl_1.4.5        parallel_4.5.1      doRNG_1.8.6.2
[121] lme4_1.1-37         Rmpfr_1.1-2         mvtnorm_1.3-3
[124] lmerTest_3.1-3      scales_1.4.0        e1071_1.7-16
[127] crayon_1.5.3        rlang_1.1.6         multcomp_1.4-29
```

# References

Lahti, Leo, Jarkko Salojärvi, Anne Salonen, Marten Scheffer, and Willem M De Vos. 2014. “Tipping Elements in the Human Intestinal Ecosystem.” *Nature Communications* 5 (1): 1–10.

Lahti, Leo, Sudarshan Shetty, T Blake, J Salojarvi, and others. 2017. “Tools for Microbiome Analysis in R.” *Version* 1: 10013.

Mandal, Siddhartha, Will Van Treuren, Richard A White, Merete Eggesbø, Rob Knight, and Shyamal D Peddada. 2015. “Analysis of Composition of Microbiomes: A Novel Method for Studying Microbial Composition.” *Microbial Ecology in Health and Disease* 26 (1): 27663.

McMurdie, Paul J, and Susan Holmes. 2013. “Phyloseq: An R Package for Reproducible Interactive Analysis and Graphics of Microbiome Census Data.” *PloS One* 8 (4): e61217.