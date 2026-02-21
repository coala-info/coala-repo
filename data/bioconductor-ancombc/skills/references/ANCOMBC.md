# ANCOM-BC Tutorial

#### Huang Lin\(^1\)

#### \(^1\)University of Maryland, College Park, MD 20742

#### October 29, 2025

```
knitr::opts_chunk$set(message = FALSE, warning = FALSE, comment = NA,
                      fig.width = 6.25, fig.height = 5)
library(ANCOMBC)
library(tidyverse)
library(DT)
options(DT.options = list(
  initComplete = JS("function(settings, json) {",
  "$(this.api().table().header()).css({'background-color':
  '#000', 'color': '#fff'});","}")))
```

# 1. Introduction

Analysis of Compositions of Microbiomes with Bias Correction (ANCOM-BC) (Lin and Peddada 2020) is a methodology of differential abundance (DA) analysis for microbial absolute abundances. ANCOM-BC estimates the unknown sampling fractions, corrects the bias induced by their differences through a log linear regression model including the estimated sampling fraction as an offset terms, and identifies taxa that are differentially abundant according to the variable of interest. For more details, please refer to the [ANCOM-BC](https://doi.org/10.1038/s41467-020-17041-7) paper.

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

# 3. Example Data

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

# 4 ANCOM-BC Implementation

## 4.1 Run `ancombc` function using the `phyloseq` object

```
out = ancombc(data = pseq, tax_level = "Family",
              formula = "age + region + bmi",
              p_adj_method = "holm", prv_cut = 0.10, lib_cut = 1000,
              group = "bmi", struc_zero = TRUE, neg_lb = TRUE, tol = 1e-5,
              max_iter = 100, conserve = TRUE, alpha = 0.05, global = TRUE,
              n_cl = 1, verbose = TRUE)

res = out$res
res_global = out$res_global
```

Tests for interactions are supported by specifying the interactions in the `fix_formula`. Please ensure that interactions between variables are included using the `*` operator, as the `:` operator is not recognized by the `ancombc` function and will result in an error.

Additionally, when the `group` variable contains interaction terms, only the main effect will be considered in multi-group comparisons.

```
out = ancombc(data = pseq, tax_level = "Family",
              formula = "age + region * bmi",
              p_adj_method = "holm", prv_cut = 0.10, lib_cut = 1000,
              group = "bmi", struc_zero = TRUE, neg_lb = TRUE, tol = 1e-5,
              max_iter = 100, conserve = TRUE, alpha = 0.05, global = TRUE,
              n_cl = 1, verbose = TRUE)

res = out$res
res_global = out$res_global
```

## 4.2 ANCOMBC primary result

Result from the ANCOM-BC log-linear model to determine taxa that are differentially abundant according to the covariate of interest. It contains: 1) log fold changes; 2) standard errors; 3) test statistics; 4) p-values; 5) adjusted p-values; 6) indicators whether the taxon is differentially abundant (TRUE) or not (FALSE).

### LFC

```
tab_lfc = res$lfc
col_name = c("Taxon", "Intercept", "Age", "NE - CE", "SE - CE",
             "US - CE", "Overweight - Obese", "Lean - Obese")
colnames(tab_lfc) = col_name
tab_lfc %>%
  datatable(caption = "Log Fold Changes from the Primary Result") %>%
  formatRound(col_name[-1], digits = 2)
```

### SE

```
tab_se = res$se
colnames(tab_se) = col_name
tab_se %>%
  datatable(caption = "SEs from the Primary Result") %>%
  formatRound(col_name[-1], digits = 2)
```

### Test statistic

```
tab_w = res$W
colnames(tab_w) = col_name
tab_w %>%
  datatable(caption = "Test Statistics from the Primary Result") %>%
  formatRound(col_name[-1], digits = 2)
```

### P-values

```
tab_p = res$p_val
colnames(tab_p) = col_name
tab_p %>%
  datatable(caption = "P-values from the Primary Result") %>%
  formatRound(col_name[-1], digits = 2)
```

### Adjusted p-values

```
tab_q = res$q
colnames(tab_q) = col_name
tab_q %>%
  datatable(caption = "Adjusted p-values from the Primary Result") %>%
  formatRound(col_name[-1], digits = 2)
```

### Differentially abundant taxa

```
tab_diff = res$diff_abn
colnames(tab_diff) = col_name
tab_diff %>%
  datatable(caption = "Differentially Abundant Taxa from the Primary Result")
```

### Bias-corrected abundances

To obtain bias-corrected abundances, the following steps can be taken:

Step 1: Calculate the estimated sample-specific sampling fractions, in log scale.

Step 2: Correct the log observed abundances by subtracting the estimated sampling fraction from the log observed abundances of each sample.

It is important to note that we can only estimate sampling fractions up to an additive constant, meaning that only the difference between bias-corrected abundances is meaningful. Additionally, taxon-specific biases are not taken into account in the calculation of bias-corrected abundances, as it is assumed that these biases vary across taxa but remain constant across samples within a taxon.

```
samp_frac = out$samp_frac
# Replace NA with 0
samp_frac[is.na(samp_frac)] = 0
# Add pesudo-count (1) to avoid taking the log of 0
log_obs_abn = log(out$feature_table + 1)
# Adjust the log observed abundances
log_corr_abn = t(t(log_obs_abn) - samp_frac)
# Show the first 6 samples
round(log_corr_abn[, 1:6], 2) %>%
  datatable(caption = "Bias-corrected log observed abundances")
```

### Visualization for age

```
df_lfc = data.frame(res$lfc[, -1] * res$diff_abn[, -1], check.names = FALSE) %>%
    mutate(taxon_id = res$diff_abn$taxon) %>%
    dplyr::select(taxon_id, everything())
df_se = data.frame(res$se[, -1] * res$diff_abn[, -1], check.names = FALSE) %>%
  mutate(taxon_id = res$diff_abn$taxon) %>%
    dplyr::select(taxon_id, everything())
colnames(df_se)[-1] = paste0(colnames(df_se)[-1], "SE")

df_fig_age = df_lfc %>%
  dplyr::left_join(df_se, by = "taxon_id") %>%
  dplyr::transmute(taxon_id, age, ageSE) %>%
  dplyr::filter(age != 0) %>%
  dplyr::arrange(desc(age)) %>%
  dplyr::mutate(direct = ifelse(age > 0, "Positive LFC", "Negative LFC"))
df_fig_age$taxon_id = factor(df_fig_age$taxon_id, levels = df_fig_age$taxon_id)
df_fig_age$direct = factor(df_fig_age$direct,
                        levels = c("Positive LFC", "Negative LFC"))

p_age = ggplot(data = df_fig_age,
           aes(x = taxon_id, y = age, fill = direct, color = direct)) +
  geom_bar(stat = "identity", width = 0.7,
           position = position_dodge(width = 0.4)) +
  geom_errorbar(aes(ymin = age - ageSE, ymax = age + ageSE), width = 0.2,
                position = position_dodge(0.05), color = "black") +
  labs(x = NULL, y = "Log fold change",
       title = "Log fold changes as one unit increase of age") +
  scale_fill_discrete(name = NULL) +
  scale_color_discrete(name = NULL) +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5),
        panel.grid.minor.y = element_blank(),
        axis.text.x = element_text(angle = 60, hjust = 1))
p_age
```

![](data:image/png;base64...)

### Visualization for BMI

```
df_fig_bmi = df_lfc %>%
  filter(bmioverweight != 0 | bmilean != 0) %>%
  transmute(taxon_id,
            `Overweight vs. Obese` = round(bmioverweight, 2),
            `Lean vs. Obese` = round(bmilean, 2)) %>%
  pivot_longer(cols = `Overweight vs. Obese`:`Lean vs. Obese`,
               names_to = "group", values_to = "value") %>%
  arrange(taxon_id)
lo = floor(min(df_fig_bmi$value))
up = ceiling(max(df_fig_bmi$value))
mid = (lo + up)/2
p_bmi = df_fig_bmi %>%
  ggplot(aes(x = group, y = taxon_id, fill = value)) +
  geom_tile(color = "black") +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white",
                       na.value = "white", midpoint = mid, limit = c(lo, up),
                       name = NULL) +
  geom_text(aes(group, taxon_id, label = value), color = "black", size = 4) +
  labs(x = NULL, y = NULL, title = "Log fold changes as compared to obese subjects") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))
p_bmi
```

![](data:image/png;base64...)

## 4.3 ANCOMBC global test result

Result from the ANCOM-BC global test to determine taxa that are differentially abundant between at least two groups across three or more different groups. In this example, we want to identify taxa that are differentially abundant between at least two regions across CE, NE, SE, and US. The result contains: 1) test statistics; 2) p-values; 3) adjusted p-values; 4) indicators whether the taxon is differentially abundant (TRUE) or not (FALSE).

### Test statistics

```
tab_w = res_global[, c("taxon", "W")]
tab_w %>% datatable(caption = "Test Statistics
                    from the Global Test Result") %>%
      formatRound(c("W"), digits = 2)
```

### P-values

```
tab_p = res_global[, c("taxon", "p_val")]
tab_p %>% datatable(caption = "P-values
                    from the Global Test Result") %>%
      formatRound(c("p_val"), digits = 2)
```

### Adjusted p-values

```
tab_q = res_global[, c("taxon", "q_val")]
tab_q %>% datatable(caption = "Adjusted p-values
                    from the Global Test Result") %>%
      formatRound(c("q_val"), digits = 2)
```

### Differentially abundant taxa

```
tab_diff = res_global[, c("taxon", "diff_abn")]
tab_diff %>% datatable(caption = "Differentially Abundant Taxa
                       from the Global Test Result")
```

### Visualization

```
sig_taxa = res_global %>%
  dplyr::filter(diff_abn == TRUE) %>%
  .$taxon

df_bmi = tab_lfc %>%
    dplyr::select(Taxon, `Overweight - Obese`, `Lean - Obese`) %>%
    filter(Taxon %in% sig_taxa)

df_heat = df_bmi %>%
    pivot_longer(cols = -one_of("Taxon"),
                 names_to = "region", values_to = "value") %>%
    mutate(value = round(value, 2))
df_heat$Taxon = factor(df_heat$Taxon, levels = sort(sig_taxa))

lo = floor(min(df_heat$value))
up = ceiling(max(df_heat$value))
mid = (lo + up)/2
p_heat = df_heat %>%
  ggplot(aes(x = region, y = Taxon, fill = value)) +
  geom_tile(color = "black") +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white",
                       na.value = "white", midpoint = mid, limit = c(lo, up),
                       name = NULL) +
  geom_text(aes(region, Taxon, label = value), color = "black", size = 4) +
  labs(x = NULL, y = NULL,
       title = "Log fold changes for globally significant taxa") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))
p_heat
```

![](data:image/png;base64...)

## 4.4 Run `ancombc` function using the `tse` object

```
tse = mia::makeTreeSummarizedExperimentFromPhyloseq(pseq)

out = ancombc(data = tse, assay_name = "counts", tax_level = "Family",
              formula = "age + region + bmi",
              p_adj_method = "holm", prv_cut = 0.10, lib_cut = 1000,
              group = "bmi", struc_zero = TRUE, neg_lb = TRUE, tol = 1e-5,
              max_iter = 100, conserve = TRUE, alpha = 0.05, global = TRUE,
              n_cl = 1, verbose = TRUE)

res = out$res
res_global = out$res_global
```

## 4.5 Run `ancombc` function by directly providing the abundance and metadata

```
abundance_data = microbiome::abundances(pseq)
aggregate_data = microbiome::abundances(microbiome::aggregate_taxa(pseq, "Family"))
meta_data = microbiome::meta(pseq)

out = ancombc(data = abundance_data, aggregate_data = aggregate_data,
              meta_data = meta_data, formula = "age + region + bmi",
              p_adj_method = "holm", prv_cut = 0.10, lib_cut = 1000,
              group = "bmi", struc_zero = TRUE, neg_lb = TRUE, tol = 1e-5,
              max_iter = 100, conserve = TRUE, alpha = 0.05, global = TRUE,
              n_cl = 1, verbose = TRUE)

res = out$res
res_global = out$res_global
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
 [1] doRNG_1.8.6.2   rngtools_1.5.2  foreach_1.5.2   DT_0.34.0
 [5] lubridate_1.9.4 forcats_1.0.1   stringr_1.5.2   dplyr_1.1.4
 [9] purrr_1.1.0     readr_2.1.5     tidyr_1.3.1     tibble_3.3.0
[13] ggplot2_4.0.0   tidyverse_2.0.0 ANCOMBC_2.12.0

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
 [40] colorspace_2.1-2    S4Vectors_0.48.0    crosstalk_1.2.2
 [43] Hmisc_5.2-4         vegan_2.7-2         labeling_0.4.3
 [46] timechange_0.3.0    mgcv_1.9-3          httr_1.4.7
 [49] compiler_4.5.1      proxy_0.4-27        bit64_4.6.0-1
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
 [85] XVector_0.50.0      BiocGenerics_0.56.0 pillar_1.11.1
 [88] splines_4.5.1       lattice_0.22-7      survival_3.8-3
 [91] gmp_0.7-5           bit_4.6.0           tidyselect_1.2.1
 [94] Biostrings_2.78.0   knitr_1.50          reformulas_0.4.2
 [97] gridExtra_2.3       phyloseq_1.54.0     IRanges_2.44.0
[100] Seqinfo_1.0.0       stats4_4.5.1        xfun_0.53
[103] expm_1.0-0          Biobase_2.70.0      stringi_1.8.7
[106] yaml_2.3.10         boot_1.3-32         evaluate_1.0.5
[109] codetools_0.2-20    cli_3.6.5           rpart_4.1.24
[112] DescTools_0.99.60   Rdpack_2.6.4        jquerylib_0.1.4
[115] dichromat_2.0-0.1   Rcpp_1.1.0          readxl_1.4.5
[118] parallel_4.5.1      lme4_1.1-37         Rmpfr_1.1-2
[121] mvtnorm_1.3-3       lmerTest_3.1-3      scales_1.4.0
[124] e1071_1.7-16        crayon_1.5.3        rlang_1.1.6
[127] multcomp_1.4-29
```

# References

Lahti, Leo, Jarkko Salojärvi, Anne Salonen, Marten Scheffer, and Willem M De Vos. 2014. “Tipping Elements in the Human Intestinal Ecosystem.” *Nature Communications* 5 (1): 1–10.

Lahti, Leo, Sudarshan Shetty, T Blake, J Salojarvi, and others. 2017. “Tools for Microbiome Analysis in R.” *Version* 1: 10013.

Lin, Huang, and Shyamal Das Peddada. 2020. “Analysis of Compositions of Microbiomes with Bias Correction.” *Nature Communications* 11 (1): 1–11.

McMurdie, Paul J, and Susan Holmes. 2013. “Phyloseq: An R Package for Reproducible Interactive Analysis and Graphics of Microbiome Census Data.” *PloS One* 8 (4): e61217.