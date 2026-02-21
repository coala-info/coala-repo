[[![](data:image/png;base64...)](http://bioconductor.org/packages/release/bioc/html/sesame.html)](index.html)

* [Basics](sesame.html)
* [QC](QC.html)
* [Non-human Array](nonhuman.html)
* [Modeling](modeling.html)
* [Inference](inferences.html)
* [KnowYourCG](https://bioconductor.org/packages/release/bioc/html/knowYourCG.html)
* [Supplemental](https://zhou-lab.github.io/sesame/dev/supplemental.html)

# Modeling

#### 25 November 2025

# Differential Methylation

Here we demonstrate the analysis of DNA methylation dependent on one or more predictors. The predictors might be tissue, cell type, sex, age, tumor/normal, case/control or a combination of these factors. The `DML` (Differential Methylation Locus) function models *β* values (DNA methylation levels) using mixed linear models. This general supervised learning framework identifies CpG loci whose differential methylation is associated with known co-variates and can be used to perform epigenome-wide association studies (EWAS). Let’s first load the needed packages:

```
library(sesame)
library(SummarizedExperiment)
sesameDataCache() # required at new sesame installation
```

In the following, we will use an MM285 dataset of 10 mouse samples. This dataset contains mouse samples from different tissues and mice of different ages and sexes. The dataset is stored in a `SummarizedExperiment` object, which contains a data matrix combined with column-wise metadata accessible with `colData`:

```
se = sesameDataGet("MM285.10.SE.tissue")[1:1000,] # an arbitrary 1000 CpGs
cd = as.data.frame(colData(se)); rownames(cd) = NULL
cd
```

**CRITICAL:** If your data contains `NA`, it is required that you exclude CpGs with missing levels. For example, one cannot assess sex-specific DNA methylation for a CpG that only has non-NA measurement on one sex. Exclusion of such CpGs for differential methylation modeling can be done using the `checkLevels` function. Here, we will check this for both sex and tissue:

```
se_ok = (checkLevels(assay(se), colData(se)$sex) &
    checkLevels(assay(se), colData(se)$tissue))
sum(se_ok)                      # the number of CpGs that passes
```

```
## [1] 995
```

```
se = se[se_ok,]
```

**NOTE:** If your model include discrete contrast variables like tissue and sex as in the current example, you should consider explicitly turning it into a factor variable with a reference level (we use `treatment coding`, see [different coding systems](https://stats.idre.ucla.edu/r/library/r-library-contrast-coding-systems-%20for-categorical-variables/)).

For example, to use `Colon` as the reference tissue and `Female` as the reference sex, one can do the following

```
colData(se)$tissue <- relevel(factor(colData(se)$tissue), "Colon")
colData(se)$sex <- relevel(factor(colData(se)$sex), "Female")
```

Then we will model DNA methylation variation treating tissue and sex as covariates. To do that we will call the `DML` function and specify the R formula `~tissue + sex`. This function fits DNA methylation reading to a linear model and perform the corresponding slope test and goodness-of-fit test (F-test holding out each contrast variable). See also [formula](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/formula.html) for how to specify lm/glm-like symbolic form for regression. All these results are returned in an object of class `DMLSummary`:

```
smry = DML(se, ~tissue + sex)
smry
```

```
## DMLSummary Object with 995 Loci, 10 samples.
```

```
## Contrasts: tissue, sex
```

You can use `DML(..., BPPARAM=BiocParallel::MulticoreParam(8))` argument to parallelize the computing.

# Test Interpretation

The `DMLSummary` object is a list of slightly expanded `summary.lm` objects as is typically returned by `summary(lm())`. The `summaryExtractTest` function extracts some key test statistics from the `DMLSummary` object and store them in a data frame. Rows of the data frame correspond to CpGs/loci and columns contain the slopes and p-values of each variable.

```
test_result = summaryExtractTest(smry)
colnames(test_result) # the column names, show four groups of statistics
```

```
##  [1] "Probe_ID"             "Est_X.Intercept."     "Est_tissueCecum"
##  [4] "Est_tissueEsophagus"  "Est_tissueFat"        "Est_tissueHeart"
##  [7] "Est_sexMale"          "Pval_X.Intercept."    "Pval_tissueCecum"
## [10] "Pval_tissueEsophagus" "Pval_tissueFat"       "Pval_tissueHeart"
## [13] "Pval_sexMale"         "FPval_tissue"         "FPval_sex"
## [16] "Eff_tissue"           "Eff_sex"
```

```
head(test_result)
```

With the exception of the `Intercept`, there are four groups of columns, each starting with “Est\_”, “Pval\_”, “FPval\_”, and “Eff\_” as prefix. Here are what they represent:

* **Est\_\*** : The slope estimate (aka the *β* coefficient, not to be confused with the DNA methylation *β*-value though) for continuous variable. DNA methylation difference of the current level with respect to the reference level for nominal contrast variables. Each suffix is concatenated from the contrast variable name (e.g., tissue, sex) and the level name if the contrast variable is discrete (e.g, Cecum, Esophagus, Fat). For example, `Est_tissueFat` should be interpreted as the estimated methylation level difference of Fat compared to the reference tissue (which is `Colon`, as set above). If reference is not set, the first level in the alphabetic order is used as the reference level. There is a special column named `` Est_`(Intercept)` ``. It corresponds to the base-level methylation of the reference (in this case a Female Colon sample).
* **Pval\_\*** : The unadjusted p-values of t-testing the slope. This represents the statistical significance of the methylation difference. For example, `Pval_tissueFat` tests whether `Fat` is significantly different from `Colon` (the reference level) in DNA methylation. The `` Pval_`(Intercept)` `` tests whether the reference level is significantly different from zero.
* **FPval\_\*** : The unadjusted p-value of the F-test contrasting the full model against a reduced model with the labeled contrast variable held out. Note that “Pval\_” and “FPval\_” are equivalent when the contrast variable is a 2-level factor, i.e., in the case of a pairwise comparison.
* **Eff\_\*** : The effect size of each normial contrast variable. This is equivalent to the maximum slope subtracted by the minimum level including the reference level (0).

Multiple-testing adjustment can be done afterwards using R’s `p.adjust` function. It is integrated to the `DMR` function by default (see below).

# Goodness of Fit

One may want to ask a question like

> Is the CpG methylation tissue-specific?

rather than

> Is the CpG more methylated in fat compared to liver?

The first question ask about the contrast variable as a whole while the second question concerns only a specific level in the contrast variable. To answer this question, we can use an F-test contasting the full model with a reduced model with the target contrast held out. By default, this statistics is already computed in the `DML` function. The test result is recorded in the **FPval\_** columns. For example, to get all CpGs that are methylated specific to sex,

```
library(dplyr)
library(tidyr)
test_result %>% dplyr::filter(FPval_sex < 0.05, Eff_sex > 0.1) %>%
    select(FPval_sex, Eff_sex)
```

Here we used 0.1 as the effect size threshold. This means DNA methylation difference under 0.1 (10%) is considered not biologically meaningful. This can be a valid assumption for homogenous cell composition as most cells would be either biallelically methylated, unmethylated or monoallelically methylated. But different threshold can be used in different analysis scenarios.

We can define CpG methylation as sex-specific, tissue-specific or both, by:

```
test_result %>%
    mutate(sex_specific =
        ifelse(FPval_sex < 0.05 & Eff_sex > 0.1, TRUE, FALSE)) %>%
    mutate(tissue_specific =
        ifelse(FPval_tissue < 0.05 & Eff_tissue > 0.1, TRUE, FALSE)) %>%
    select(sex_specific, tissue_specific) %>% table
```

```
##             tissue_specific
## sex_specific FALSE TRUE
##        FALSE   891   99
##        TRUE      5    0
```

As you can see from the result, some probes are sex-specific and others are tissue-specific. There is no overlap between probes whose methylation reading is differential along both contrasts.

# Pairwise Comparison

From the test result, we can also ask whether the DNA methylation is different between two sexes or between two specific tissues. For example, `Est_sexMale` compares male from females. The following code creates a volcano plot.

```
library(ggplot2)
ggplot(test_result) + geom_point(aes(Est_sexMale, -log10(Pval_sexMale)))
```

![](data:image/png;base64...)

Likewise, we can ask whether DNA methylation might be different between fat and colon. We can do

```
ggplot(test_result) + geom_point(aes(Est_tissueFat, -log10(Pval_tissueFat)))
```

![](data:image/png;base64...)

# Continuous Predictors

The variable tested in the `DML` function can be continuous. Suppose we are interested in `age` besides `sex`. We will call the same function but with the following formula:

```
smry2 = DML(se, ~ age + sex)
test_result2 = summaryExtractTest(smry2) %>% arrange(Est_age)
```

Let’s verify the CpGs positively associated with age.

```
test_result2 %>% dplyr::select(Probe_ID, Est_age, Pval_age) %>% tail
```

```
df = data.frame(Age = colData(se)$age,
    BetaValue = assay(se)[test_result2$Probe_ID[nrow(test_result2)],])
ggplot(df, aes(Age, BetaValue)) + geom_smooth(method="lm") + geom_point()
```

```
## `geom_smooth()` using formula = 'y ~ x'
```

![](data:image/png;base64...)

# DMR

For a given contrast, one can merge neighboring CpGs that show consistent methylation variation into differentially methylated regions (DMRs). For example, we can merge sex-specific differential methylation identified above to chromosome X regions that show X-inactivation-related methylation difference. To do this, we need to pick a contrast:

```
dmContrasts(smry)                       # pick a contrast from below
```

```
## [1] "X.Intercept."    "tissueCecum"     "tissueEsophagus" "tissueFat"
## [5] "tissueHeart"     "sexMale"
```

```
merged = DMR(se, smry, "sexMale", platform="MM285") # merge CpGs to regions
```

```
## Merging correlated CpGs ... Done.
## Generated 509 segments.
## Combine p-values ...
##  - 25 significant segments.
##  - 1 significant segments (after BH).
## Done.
```

```
merged %>% dplyr::filter(Seg_Pval_adj < 0.01)
```

See [Supplemental Vignette](https://zhou-lab.github.io/sesame/v1.16/supplemental.html#track) for track-view visualization of the data.

# Session Info

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] ggplot2_4.0.1               tidyr_1.3.1
##  [3] dplyr_1.1.4                 SummarizedExperiment_1.40.0
##  [5] Biobase_2.70.0              GenomicRanges_1.62.0
##  [7] Seqinfo_1.0.0               IRanges_2.44.0
##  [9] S4Vectors_0.48.0            MatrixGenerics_1.22.0
## [11] matrixStats_1.5.0           knitr_1.50
## [13] sesame_1.28.1               sesameData_1.28.0
## [15] ExperimentHub_3.0.0         AnnotationHub_4.0.0
## [17] BiocFileCache_3.0.0         dbplyr_2.5.1
## [19] BiocGenerics_0.56.0         generics_0.1.4
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1      farver_2.1.2          blob_1.2.4
##  [4] filelock_1.0.3        Biostrings_2.78.0     S7_0.2.1
##  [7] fastmap_1.2.0         digest_0.6.39         lifecycle_1.0.4
## [10] KEGGREST_1.50.0       RSQLite_2.4.4         magrittr_2.0.4
## [13] compiler_4.5.2        rlang_1.1.6           sass_0.4.10
## [16] tools_4.5.2           yaml_2.3.10           labeling_0.4.3
## [19] S4Arrays_1.10.0       bit_4.6.0             curl_7.0.0
## [22] DelayedArray_0.36.0   plyr_1.8.9            RColorBrewer_1.1-3
## [25] abind_1.4-8           BiocParallel_1.44.0   withr_3.0.2
## [28] purrr_1.2.0           grid_4.5.2            preprocessCore_1.72.0
## [31] wheatmap_0.2.0        colorspace_2.1-2      MASS_7.3-65
## [34] scales_1.4.0          dichromat_2.0-0.1     cli_3.6.5
## [37] rmarkdown_2.30        crayon_1.5.3          reshape2_1.4.5
## [40] httr_1.4.7            tzdb_0.5.0            DBI_1.2.3
## [43] cachem_1.1.0          stringr_1.6.0         splines_4.5.2
## [46] parallel_4.5.2        AnnotationDbi_1.72.0  BiocManager_1.30.27
## [49] XVector_0.50.0        vctrs_0.6.5           Matrix_1.7-4
## [52] jsonlite_2.0.0        hms_1.1.4             bit64_4.6.0-1
## [55] fontawesome_0.5.3     jquerylib_0.1.4       glue_1.8.0
## [58] codetools_0.2-20      stringi_1.8.7         gtable_0.3.6
## [61] BiocVersion_3.22.0    tibble_3.3.0          pillar_1.11.1
## [64] rappdirs_0.3.3        htmltools_0.5.8.1     R6_2.6.1
## [67] httr2_1.2.1           evaluate_1.0.5        lattice_0.22-7
## [70] readr_2.1.6           png_0.1-8             memoise_2.0.1
## [73] BiocStyle_2.38.0      bslib_0.9.0           Rcpp_1.1.0
## [76] nlme_3.1-168          SparseArray_1.10.3    mgcv_1.9-4
## [79] xfun_0.54             pkgconfig_2.0.3
```