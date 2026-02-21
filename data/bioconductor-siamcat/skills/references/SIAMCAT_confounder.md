# Example dataset with Confoundering

Jakob Wirbel and Georg Zeller1\*

1EMBL Heidelberg

\*georg.zeller@embl.de

#### Date last modified: 2020-11-11

# Contents

* [1 About This Vignette](#about-this-vignette)
  + [1.1 Setup](#setup)
* [2 Preparations](#preparations)
  + [2.1 curatedMetagenomicsData](#curatedmetagenomicsdata)
    - [2.1.1 Metadata](#metadata)
    - [2.1.2 Taxonomic Profiles](#taxonomic-profiles)
  + [2.2 mOTUs2 Profiles](#motus2-profiles)
* [3 SIAMCAT Workflow (without Confounders)](#siamcat-workflow-without-confounders)
  + [3.1 The SIAMCAT Object](#the-siamcat-object)
  + [3.2 Filtering](#filtering)
  + [3.3 Association Plot](#association-plot)
  + [3.4 Confounder Analysis](#confounder-analysis)
  + [3.5 Machine Learning Workflow](#machine-learning-workflow)
    - [3.5.1 Model Evaluation Plot](#model-evaluation-plot)
    - [3.5.2 Model Interpretation Plot](#model-interpretation-plot)
* [4 Confounder Analysis](#confounder-analysis-1)
  + [4.1 Country Confounder](#country-confounder)
  + [4.2 Association Testing](#association-testing)
  + [4.3 Machine Learning](#machine-learning)
* [5 Session Info](#session-info)

# 1 About This Vignette

Here, we demonstrate the standard workflow of the `SIAMCAT` package using as
an example the dataset from [Nielsen et al. *Nat Biotechnol*
2014](https://www.ncbi.nlm.nih.gov/pubmed/24997787).
This dataset contains samples from patients with inflammatory bowel disease and
from controls.
More importantly, these samples have been collected in two different countries,
Spain and Denmark. Together with technical differences between these samples,
this introduces a potent confounding factor into the data. Here we are going
to explore how `SIAMCAT` would identify the confounding factor and what the
results would be if you account for the confounder or not.

## 1.1 Setup

First, we load the packages needed to perform the analyses.

```
library("tidyverse")
library("SIAMCAT")
library("ggpubr")
```

# 2 Preparations

There are two different ways to access the data for our example dataset. On
the one hand, it is available through the `curatedMetagenomicData` R package.
However, using it here would create many more dependencies for the `SIAMCAT`
package.
Therefore, we here use data available through the EMBL cluster.

In the `SIAMCAT` paper, we performed the presented analyses on the datasets
available through `curatedMetagenomicData`. If you want to reproduce the
analysis from the `SIAMCAT` paper, you can execute the code chunks in
the `curatedMetageomicData` section, otherwise execute the code in the
mOTUs2 section.

## 2.1 curatedMetagenomicsData

First, we load the package:

```
library("curatedMetagenomicData")
```

### 2.1.1 Metadata

The data are part of the `combined_metadata`

```
meta.nielsen.full <- combined_metadata %>%
    filter(dataset_name=='NielsenHB_2014')
```

One thing we have to keep in mind are repeated samples per subject (see also
the **Machine learning pitfalls** vignette).

```
print(length(unique(meta.nielsen.full$subjectID)))
print(nrow(meta.nielsen.full))
```

Some subjects (but not all) had been sampled multiple times.
Therefore, we want to remove repeated samplings for the same subject, since
the samples would otherwise not be indepdenent from another.

The visit number is encoded in the `sampleID`. Therefore, we can use this
information to extract when the samples have been taken and use only the
first visit for each subject.

```
meta.nielsen <- meta.nielsen.full %>%
    select(sampleID, subjectID, study_condition, disease_subtype,
        disease, age, country, number_reads, median_read_length, BMI) %>%
    mutate(visit=str_extract(sampleID, '_[0-9]+$')) %>%
    mutate(visit=str_remove(visit, '_')) %>%
    mutate(visit=as.numeric(visit)) %>%
    mutate(visit=case_when(is.na(visit)~0, TRUE~visit)) %>%
    group_by(subjectID) %>%
    filter(visit==min(visit)) %>%
    ungroup() %>%
    mutate(Sample_ID=sampleID) %>%
    mutate(Group=case_when(disease=='healthy'~'CTR',
                            TRUE~disease_subtype))
```

Now, we can restrict our metadata to samples with `UC` and healthy control
samples:

```
meta.nielsen <- meta.nielsen %>%
    filter(Group %in% c('UC', 'CTR'))
```

As a last step, we can adjust the column names for the metadata so that they
agree with the data available from the EMBL cluster. Also, we add rownames to
the dataframe since `SIAMCAT` needs rownames to match samples across metadata
and features.

```
meta.nielsen <- meta.nielsen %>%
    mutate(Country=country)
meta.nielsen <- as.data.frame(meta.nielsen)
rownames(meta.nielsen) <- meta.nielsen$sampleID
```

### 2.1.2 Taxonomic Profiles

We can load the taxonomic profiles generated with MetaPhlAn2 via the
*curatedMetagenomicsData* R package.

```
x <- 'NielsenHB_2014.metaphlan_bugs_list.stool'
feat <- curatedMetagenomicData(x=x, dryrun=FALSE)
feat <- feat[[x]]@assayData$exprs
```

The MetaPhlAn2 profiles contain information on different taxonomic levels.
Therefore, we want to restrict them to species-level profiles. In a second step,
we convert them into relative abundances (summing up to 1) instead of using
the percentages (summing up to 100) that MetaPhlAn2 outputs.

```
feat <- feat[grep(x=rownames(feat), pattern='s__'),]
feat <- feat[grep(x=rownames(feat),pattern='t__', invert = TRUE),]
feat <- t(t(feat)/100)
```

The feature names are very long and may be a bit un-wieldy for plotting later
on, so we shorten them to only the species name:

```
rownames(feat) <- str_extract(rownames(feat), 's__.*$')
```

## 2.2 mOTUs2 Profiles

Both metadata and features are available through the EMBL cluster:

```
# base url for data download
data.loc <- 'https://zenodo.org/api/files/d81e429c-870f-44e0-a44a-2a4aa541b6c1/'
## metadata
meta.nielsen <- read_tsv(paste0(data.loc, 'meta_Nielsen.tsv'))
## Rows: 396 Columns: 9
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: "\t"
## chr (5): Sample_ID, Individual_ID, Country, Gender, Group
## dbl (4): Sampling_day, Age, BMI, Library_Size
##
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
# also here, we have to remove repeated samplings and CD samples
meta.nielsen <- meta.nielsen %>%
    filter(Group %in% c('CTR', 'UC')) %>%
    group_by(Individual_ID) %>%
    filter(Sampling_day==min(Sampling_day)) %>%
    ungroup() %>%
    as.data.frame()
rownames(meta.nielsen) <- meta.nielsen$Sample_ID

## features
feat <- read.table(paste0(data.loc, 'metaHIT_motus.tsv'),
                    stringsAsFactors = FALSE, sep='\t',
                    check.names = FALSE, quote = '', comment.char = '')
feat <- feat[,colSums(feat) > 0]
feat <- prop.table(as.matrix(feat), 2)
```

# 3 SIAMCAT Workflow (without Confounders)

## 3.1 The SIAMCAT Object

Now, we have everything ready to create a `SIAMCAT` object which stores
the feature matrix, the meta-variables, and the label. Here, the label is
created using the information in the metadata.
To demonstrate the normal `SIAMCAT` workflow, we remove the confounding factor
by only looking at samples from Spain. Below, we have a look what would have
happened if we had not removed them.

```
# remove Danish samples
meta.nielsen.esp <- meta.nielsen[meta.nielsen$Country == 'ESP',]
sc.obj <- siamcat(feat=feat, meta=meta.nielsen.esp, label='Group', case='UC')
## + starting create.label
## Label used as case:
##    UC
## Label used as control:
##    CTR
## + finished create.label.from.metadata in 0.004 s
## + starting validate.data
## +++ checking overlap between labels and features
## + Keeping labels of 128 sample(s).
## +++ checking sample number per class
## +++ checking overlap between samples and metadata
## + finished validate.data in 0.596 s
```

## 3.2 Filtering

Now, we can filter feature with low overall abundance and prevalence.

```
sc.obj <- filter.features(sc.obj, cutoff=1e-04,
                            filter.method = 'abundance')
## Features successfully filtered
sc.obj <- filter.features(sc.obj, cutoff=0.05,
                            filter.method='prevalence',
                            feature.type = 'filtered')
## Features successfully filtered
```

## 3.3 Association Plot

The `check.assocation` function calculates the significance of enrichment and
metrics of association (such as generalized fold change and single-feature
AUROC).

```
sc.obj <- check.associations(sc.obj, log.n0 = 1e-06, alpha=0.1)
association.plot(sc.obj, fn.plot = './association_plot_nielsen.pdf',
                panels = c('fc'))
```

![](data:image/png;base64...)

## 3.4 Confounder Analysis

We can also check the supplied meta-variables for potential confounding.

```
check.confounders(sc.obj, fn.plot = './confounders_nielsen.pdf')
## ++ remove metadata variables, since all subjects have the same value
##  Country
## Finished checking metadata for confounders, results plotted to: ./confounders_nielsen.pdf
```

![](data:image/png;base64...)

The function produces one plot for each meta-variable. Here, we show only the
example of the body mass index (BMI). The BMI distributions look very similar
for both controls and UC cases, so it is unlikely that the BMI would
confound the analyses.

## 3.5 Machine Learning Workflow

The machine learning workflow can be easily implemented in `SIAMCAT`. It
contains the following steps:

* Feature normalization
* Data splitting for cross-validation
* Model training
* Making model predictions (on left-out data)
* Evaluating model predictions (using AUROC and AUPRC)

```
sc.obj <- normalize.features(sc.obj, norm.method = 'log.std',
                            norm.param = list(log.n0=1e-06, sd.min.q=0))
## Features normalized successfully.
sc.obj <- create.data.split(sc.obj, num.folds = 5, num.resample = 5)
## Features splitted for cross-validation successfully.
sc.obj <- train.model(sc.obj, method='lasso')
## Trained lasso models successfully.
sc.obj <- make.predictions(sc.obj)
## Made predictions successfully.
sc.obj <- evaluate.predictions(sc.obj)
## Evaluated predictions successfully.
```

### 3.5.1 Model Evaluation Plot

The model evaluation plot will produce one plot with the ROC curve and another
one with the precision-recall curve (not shown here).

```
model.evaluation.plot(sc.obj, fn.plot = './eval_plot_nielsen.pdf')
## Plotted evaluation of predictions successfully to: ./eval_plot_nielsen.pdf
```

![](data:image/png;base64...)

### 3.5.2 Model Interpretation Plot

The model interpretation plot can give you additional information about the
trained machine learning model. It will show you:

* the feature importance as barplot,
* the feature robustness (in how many of the models in the repeated
  cross-validation this feature has been selected into the model),
* the normalized feature abundances across samples as heatmap,
* the optional metadata as heatmap below, and
* a boxplot showing the proportion of the model weight that is explained by
  the selected features.

```
model.interpretation.plot(sc.obj, consens.thres = 0.8,
                            fn.plot = './interpret_nielsen.pdf')
## Successfully plotted model interpretation plot to: ./interpret_nielsen.pdf
```

![](data:image/png;base64...)

# 4 Confounder Analysis

As already mentioned above, the Nielsen dataset contains samples from both
Spain and Denmark. How would `SIAMCAT` have alerted us to this?

```
table(meta.nielsen$Group, meta.nielsen$Country)
##
##       DNK ESP
##   CTR 177  59
##   UC    0  69
```

## 4.1 Country Confounder

First, we create a `SIAMCAT` object again, this time including the
Danish controls:

```
sc.obj.full <- siamcat(feat=feat, meta=meta.nielsen,
                        label='Group', case='UC')
## + starting create.label
## Label used as case:
##    UC
## Label used as control:
##    CTR
## + finished create.label.from.metadata in 0.002 s
## + starting validate.data
## +++ checking overlap between labels and features
## + Keeping labels of 291 sample(s).
## + Removed 14 samples from the label object...
## +++ checking sample number per class
## +++ checking overlap between samples and metadata
## + finished validate.data in 0.748 s
sc.obj.full <- filter.features(sc.obj.full, cutoff=1e-04,
                                filter.method = 'abundance')
## Features successfully filtered
sc.obj.full <- filter.features(sc.obj.full, cutoff=0.05,
                                filter.method='prevalence',
                                feature.type = 'filtered')
## Features successfully filtered
```

The confounder plot would show us that the meta-variable “country” might be
problematic:

```
check.confounders(sc.obj.full, fn.plot = './confounders_dnk.pdf')
```

![](data:image/png;base64...)

## 4.2 Association Testing

First, we can use `SIAMCAT` to test for associations including the Danish
samples.

```
sc.obj.full <- check.associations(sc.obj.full, log.n0 = 1e-06, alpha=0.1)
```

Confounders can lead to biases in association testing. After using `SIAMCAT` to
test for associations in both datasets (one time including the Danish samples,
the other time restricted to samples from Spain only), we can extract the
association metrics from both `SIAMCAT` objects and compare them in a
scatter plot.

```
assoc.sp <- associations(sc.obj)
assoc.sp$species <- rownames(assoc.sp)
assoc.sp_dnk <- associations(sc.obj.full)
assoc.sp_dnk$species <- rownames(assoc.sp_dnk)

df.plot <- full_join(assoc.sp, assoc.sp_dnk, by='species')
df.plot %>%
    mutate(highlight=str_detect(species, 'formicigenerans')) %>%
    ggplot(aes(x=-log10(p.adj.x), y=-log10(p.adj.y), col=highlight)) +
    geom_point(alpha=0.3) +
        xlab('Spanish samples only\n-log10(q)') +
        ylab('Spanish and Danish samples only\n-log10(q)') +
        theme_classic() +
        theme(panel.grid.major = element_line(colour='lightgrey'),
            aspect.ratio = 1.3) +
        scale_colour_manual(values=c('darkgrey', '#D41645'), guide='none') +
        annotate('text', x=0.7, y=8, label='Dorea formicigenerans')
```

![](data:image/png;base64...)

This result shows that several species are only signficant if the Danish
control samples are included, but not when considering only the Spanish samples.

As an example, we highlighted the species *“Dorea formicigenerans”* in the plot
above. The test is not significant in the Spanish cohort, but is highly
significant when the Danish samples are included.

```
# extract information out of the siamcat object
feat.dnk <- get.filt_feat.matrix(sc.obj.full)
label.dnk <- label(sc.obj.full)$label
country <- meta(sc.obj.full)$Country
names(country) <- rownames(meta(sc.obj.full))

df.plot <- tibble(dorea=log10(feat.dnk[
    str_detect(rownames(feat.dnk),'formicigenerans'),
    names(label.dnk)] + 1e-05),
    label=label.dnk, country=country) %>%
    mutate(label=case_when(label=='-1'~'CTR', TRUE~"UC")) %>%
    mutate(x_value=paste0(country, '_', label))

df.plot %>%
    ggplot(aes(x=x_value, y=dorea)) +
        geom_boxplot(outlier.shape = NA) +
        geom_jitter(width = 0.08, stroke=0, alpha=0.2) +
        theme_classic() +
        xlab('') +
        ylab("log10(Dorea formicigenerans)") +
        stat_compare_means(comparisons = list(c('DNK_CTR', 'ESP_CTR'),
                                                c('DNK_CTR', 'ESP_UC'),
                                                c('ESP_CTR', 'ESP_UC')))
```

![](data:image/png;base64...)

## 4.3 Machine Learning

The results from the machine learning workflows can also be biased by the
differences between countries, leading to exaggerated performance estimates.

```
sc.obj.full <- normalize.features(sc.obj.full, norm.method = 'log.std',
                                norm.param = list(log.n0=1e-06, sd.min.q=0))
## Features normalized successfully.
sc.obj.full <- create.data.split(sc.obj.full, num.folds = 5, num.resample = 5)
## Features splitted for cross-validation successfully.
sc.obj.full <- train.model(sc.obj.full, method='lasso')
## Trained lasso models successfully.
sc.obj.full <- make.predictions(sc.obj.full)
## Made predictions successfully.
sc.obj.full <- evaluate.predictions(sc.obj.full)
## Evaluated predictions successfully.
```

When we compare the performance of the two different models, the model with the
Danish and Spanish samples included seems to perform better (higher AUROC
value). However, the previous analysis suggests that this performance estimate
is biased and exaggerated because differences between Spanish and Danish
samples can be very large.

```
model.evaluation.plot("Spanish samples only"=sc.obj,
                    "Danish and Spanish samples"=sc.obj.full,
                    fn.plot = './eval_plot_dnk.pdf')
## Plotted evaluation of predictions successfully to: ./eval_plot_dnk.pdf
```

![](data:image/png;base64...)

To demonstrate how machine learning models can exploit this confounding factor,
we can train a model to distinguish between Spanish and Danish control samples.
As you can see, the model can distinguish between the two countries with
almost perfect accuracy.

```
meta.nielsen.country <- meta.nielsen[meta.nielsen$Group=='CTR',]

sc.obj.country <- siamcat(feat=feat, meta=meta.nielsen.country,
                            label='Country', case='ESP')
sc.obj.country <- filter.features(sc.obj.country, cutoff=1e-04,
                            filter.method = 'abundance')
sc.obj.country <- filter.features(sc.obj.country, cutoff=0.05,
                            filter.method='prevalence',
                            feature.type = 'filtered')
sc.obj.country <- normalize.features(sc.obj.country, norm.method = 'log.std',
                                    norm.param = list(log.n0=1e-06,
                                        sd.min.q=0))
sc.obj.country <- create.data.split(sc.obj.country,
                                    num.folds = 5, num.resample = 5)
sc.obj.country <- train.model(sc.obj.country, method='lasso')
sc.obj.country <- make.predictions(sc.obj.country)
sc.obj.country <- evaluate.predictions(sc.obj.country)

print(eval_data(sc.obj.country)$auroc)
## Area under the curve: 0.9701
```

# 5 Session Info

```
sessionInfo()
## R version 4.5.1 Patched (2025-08-23 r88802)
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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
##  [1] ggpubr_0.6.2     SIAMCAT_2.14.0   phyloseq_1.54.0  mlr3_1.2.0
##  [5] lubridate_1.9.4  forcats_1.0.1    stringr_1.5.2    dplyr_1.1.4
##  [9] purrr_1.1.0      readr_2.1.5      tidyr_1.3.1      tibble_3.3.0
## [13] ggplot2_4.0.0    tidyverse_2.0.0  BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3   jsonlite_2.0.0       shape_1.4.6.1
##   [4] magrittr_2.0.4       magick_2.9.0         farver_2.1.2
##   [7] corrplot_0.95        nloptr_2.2.1         rmarkdown_2.30
##  [10] vctrs_0.6.5          multtest_2.66.0      minqa_1.2.8
##  [13] PRROC_1.4            tinytex_0.57         rstatix_0.7.3
##  [16] htmltools_0.5.8.1    progress_1.2.3       curl_7.0.0
##  [19] broom_1.0.10         Rhdf5lib_1.32.0      Formula_1.2-5
##  [22] rhdf5_2.54.0         pROC_1.19.0.1        sass_0.4.10
##  [25] parallelly_1.45.1    bslib_0.9.0          plyr_1.8.9
##  [28] palmerpenguins_0.1.1 mlr3tuning_1.4.0     cachem_1.1.0
##  [31] uuid_1.2-1           igraph_2.2.1         lifecycle_1.0.4
##  [34] iterators_1.0.14     pkgconfig_2.0.3      Matrix_1.7-4
##  [37] R6_2.6.1             fastmap_1.2.0        rbibutils_2.3
##  [40] future_1.67.0        digest_0.6.37        numDeriv_2016.8-1.1
##  [43] S4Vectors_0.48.0     mlr3misc_0.19.0      vegan_2.7-2
##  [46] labeling_0.4.3       timechange_0.3.0     abind_1.4-8
##  [49] mgcv_1.9-3           compiler_4.5.1       beanplot_1.3.1
##  [52] bit64_4.6.0-1        withr_3.0.2          S7_0.2.0
##  [55] backports_1.5.0      carData_3.0-5        ggsignif_0.6.4
##  [58] LiblineaR_2.10-24    MASS_7.3-65          biomformat_1.38.0
##  [61] permute_0.9-8        tools_4.5.1          ape_5.8-1
##  [64] glue_1.8.0           lgr_0.5.0            nlme_3.1-168
##  [67] rhdf5filters_1.22.0  grid_4.5.1           checkmate_2.3.3
##  [70] gridBase_0.4-7       cluster_2.1.8.1      reshape2_1.4.4
##  [73] ade4_1.7-23          generics_0.1.4       gtable_0.3.6
##  [76] tzdb_0.5.0           data.table_1.17.8    hms_1.1.4
##  [79] car_3.1-3            XVector_0.50.0       BiocGenerics_0.56.0
##  [82] foreach_1.5.2        pillar_1.11.1        vroom_1.6.6
##  [85] bbotk_1.7.1          splines_4.5.1        lattice_0.22-7
##  [88] survival_3.8-3       bit_4.6.0            tidyselect_1.2.1
##  [91] Biostrings_2.78.0    knitr_1.50           reformulas_0.4.2
##  [94] infotheo_1.2.0.1     gridExtra_2.3        bookdown_0.45
##  [97] IRanges_2.44.0       Seqinfo_1.0.0        stats4_4.5.1
## [100] xfun_0.53            Biobase_2.70.0       matrixStats_1.5.0
## [103] stringi_1.8.7        yaml_2.3.10          boot_1.3-32
## [106] evaluate_1.0.5       codetools_0.2-20     BiocManager_1.30.26
## [109] cli_3.6.5            Rdpack_2.6.4         jquerylib_0.1.4
## [112] mlr3learners_0.13.0  dichromat_2.0-0.1    Rcpp_1.1.0
## [115] globals_0.18.0       parallel_4.5.1       prettyunits_1.2.0
## [118] paradox_1.0.1        lme4_1.1-37          listenv_0.9.1
## [121] glmnet_4.1-10        lmerTest_3.1-3       scales_1.4.0
## [124] crayon_1.5.3         rlang_1.1.6
```