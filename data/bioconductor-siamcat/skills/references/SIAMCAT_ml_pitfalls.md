# Machine learning pitfalls

Jakob Wirbel and Georg Zeller1\*

1EMBL Heidelberg

\*georg.zeller@embl.de

#### Date last modified: 2020-11-07

# Contents

* [1 About This Vignette](#about-this-vignette)
  + [1.1 Setup](#setup)
* [2 Supervised Feature Selection](#supervised-feature-selection)
  + [2.1 Load the Data](#load-the-data)
  + [2.2 Train Model without Feature Selection](#train-model-without-feature-selection)
  + [2.3 Incorrect Procedure: Train with Supervised Feature Selection](#incorrect-procedure-train-with-supervised-feature-selection)
  + [2.4 Correct Procedure: Train with Nested Feature Selection](#correct-procedure-train-with-nested-feature-selection)
  + [2.5 Plot the Results](#plot-the-results)
* [3 Naive Splitting of Dependent Data](#naive-splitting-of-dependent-data)
  + [3.1 Load the Data](#load-the-data-1)
  + [3.2 Train with Naive Cross-validation](#train-with-naive-cross-validation)
  + [3.3 Train with Blocked Cross-validation](#train-with-blocked-cross-validation)
  + [3.4 Apply to External Datasets](#apply-to-external-datasets)
  + [3.5 Plot the Results](#plot-the-results-1)
* [4 Session Info](#session-info)

# 1 About This Vignette

In this vignette, we want to explore two pitfalls for machine learning analysis
that can lead to overly optimistic performance estimates.
When setting up cross-validation workflows, the main objective is usually to
estimate how well a trained model would perform on external data, which is
specifically important when considering biomarker discovery. However, more
complex workflows involving feature selection or time-course data can be
challenging to setup correctly. Incorrect workflows in which information leaks
from the test to the training data can lead to overfitting and poor
generalization to external datasets.
Here, we focus on supervised feature selection and the naive splitting of
dependent data.

## 1.1 Setup

First, we load the packages needed to perform the analyses.

```
library("tidyverse")
library("SIAMCAT")
```

# 2 Supervised Feature Selection

Supervised feature selection means that the label information is taken into
account before the cross-validation split. Within this procedure, the features
are selected if they are associated with the label (for example after
differential abundance testing), using the complete dataset for the calculation
of feature association and leaving no data aside for unbiased model
evaluation.
A correct way to perform feature selection would be to nest the selection step
into the cross-validation procedure. That means that the calculation of
feature association is performed for each training fold separately.

## 2.1 Load the Data

As an example, we are going to use two datasets of colorectal cancer (CRC)
which are available through the `curatedMetagenomicData` package.
Since the model trainig procedure takes a long time, this vignette is not
evaluated upon build of the package, but if you execute the code chunks for
yourself, you should get similar results.

```
library("curatedMetagenomicData")
```

First, we are going to load the dataset from
[Thomas et al](https://doi.org/10.1038/s41591-019-0405-7)
as training dataset.

```
x <- 'ThomasAM_2018a.metaphlan_bugs_list.stool'
feat.t <- curatedMetagenomicData(x=x, dryrun=FALSE)
feat.t <- feat.t[[x]]@assayData$exprs
# clean up metaphlan profiles to contain only species-level abundances
feat.t <- feat.t[grep(x=rownames(feat.t), pattern='s__'),]
feat.t <- feat.t[grep(x=rownames(feat.t),pattern='t__', invert = TRUE),]
stopifnot(all(colSums(feat.t) != 0))
feat.t <- t(t(feat.t)/100)
```

As an external dataset, we are going to use the data from
[Zeller et al.](https://doi.org/10.15252/msb.20145645).

```
x <- 'ZellerG_2014.metaphlan_bugs_list.stool'
feat.z <- curatedMetagenomicData(x=x, dryrun=FALSE)
feat.z <- feat.z[[x]]@assayData$exprs
# clean up metaphlan profiles to contain only species-level abundances
feat.z <- feat.z[grep(x=rownames(feat.z), pattern='s__'),]
feat.z <- feat.z[grep(x=rownames(feat.z),pattern='t__', invert = TRUE),]
stopifnot(all(colSums(feat.z) != 0))
feat.z <- t(t(feat.z)/100)
```

We can also extract the corresponding metadata from the `combined_metadata`
object which is part of the `curatedMetagenomicData` package.

```
meta.t <- combined_metadata %>%
    filter(dataset_name == 'ThomasAM_2018a') %>%
    filter(study_condition %in% c('control', 'CRC'))
rownames(meta.t) <- meta.t$sampleID
meta.z <- combined_metadata %>%
    filter(dataset_name == 'ZellerG_2014') %>%
    filter(study_condition %in% c('control', 'CRC'))
rownames(meta.z) <- meta.z$sampleID
```

The MetaPhlAn2 profiler used for the profiles outputs only species which are
present in the dataset. Therefore, we can have the case that there are species
in the matrix for `ThomasAM_2018` which are not present in the matrix for
`ZellerG_2014` and vice verse. In order to use them as training and external
test set for `SIAMCAT`, we have to first make sure that the set of
features for both datasets overlap completely (see also the **Holdout Testing
with SIAMCAT** vignette).

```
species.union <- union(rownames(feat.t), rownames(feat.z))
# add Zeller_2014-only species to the Thomas_2018 matrix
add.species <- setdiff(species.union, rownames(feat.t))
feat.t <- rbind(feat.t,
            matrix(0, nrow=length(add.species), ncol=ncol(feat.t),
                dimnames = list(add.species, colnames(feat.t))))

# add Thomas_2018-only species to the Zeller_2014 matrix
add.species <- setdiff(species.union, rownames(feat.z))
feat.z <- rbind(feat.z,
            matrix(0, nrow=length(add.species), ncol=ncol(feat.z),
                dimnames = list(add.species, colnames(feat.z))))
```

Now, we are ready to start the model training process. For this, we chose
three different feature selection cutoffs and prepare a tibble to hold the
results:

```
fs.cutoff <- c(20, 100, 250)

auroc.all <- tibble(cutoff=character(0), type=character(0),
                    study.test=character(0), AUC=double(0))
```

## 2.2 Train Model without Feature Selection

First, we will train a model without any feature selection, using all the
available features. We add it to the results matrix twice (both with `correct`
and `incorrect`) for easier plotting later.

```
sc.obj.t <- siamcat(feat=feat.t, meta=meta.t,
                    label='study_condition', case='CRC')
sc.obj.t <- filter.features(sc.obj.t, filter.method = 'prevalence',
                            cutoff = 0.01)
sc.obj.t <- normalize.features(sc.obj.t, norm.method = 'log.std',
                                norm.param=list(log.n0=1e-05, sd.min.q=0))
sc.obj.t <- create.data.split(sc.obj.t,
                                num.folds = 10, num.resample = 10)
sc.obj.t <- train.model(sc.obj.t, method='lasso')
sc.obj.t <- make.predictions(sc.obj.t)
sc.obj.t <- evaluate.predictions(sc.obj.t)

auroc.all <- auroc.all %>%
    add_row(cutoff='full', type='correct',
            study.test='Thomas_2018',
            AUC=as.numeric(sc.obj.t@eval_data$auroc)) %>%
    add_row(cutoff='full', type='incorrect', study.test='Thomas_2018',
            AUC=as.numeric(sc.obj.t@eval_data$auroc))
```

We then also apply the model to the external dataset and record the
generalization to another dataset:

```
sc.obj.z <- siamcat(feat=feat.z, meta=meta.z,
                    label='study_condition', case='CRC')
sc.obj.z <- make.predictions(sc.obj.t, sc.obj.z)
sc.obj.z <- evaluate.predictions(sc.obj.z)
auroc.all <- auroc.all %>%
    add_row(cutoff='full', type='correct',
            study.test='Zeller_2014',
            AUC=as.numeric(sc.obj.z@eval_data$auroc)) %>%
    add_row(cutoff='full', type='incorrect',
            study.test='Zeller_2014',
            AUC=as.numeric(sc.obj.z@eval_data$auroc))
```

## 2.3 Incorrect Procedure: Train with Supervised Feature Selection

For the incorrect feature selection procedure, we can test the features for
differential abundance, using the complete dataset, and then chose the top
associated features.

```
sc.obj.t <- check.associations(sc.obj.t, detect.lim = 1e-05,
                                fn.plot = 'assoc_plot.pdf')
mat.assoc <- associations(sc.obj.t)
mat.assoc$species <- rownames(mat.assoc)
# sort by p-value
mat.assoc <- mat.assoc %>% as_tibble() %>% arrange(p.val)
```

Based on the P values from the `check.association` function, we now
chose `X` number of features on which to train the model.

```
for (x in fs.cutoff){
    # select x number of features based on p-value ranking
    feat.train.red <- feat.t[mat.assoc %>%
                                slice(seq_len(x)) %>%
                                pull(species),]
    sc.obj.t.fs <- siamcat(feat=feat.train.red, meta=meta.t,
                            label='study_condition', case='CRC')
    # normalize the features without filtering
    sc.obj.t.fs <- normalize.features(sc.obj.t.fs, norm.method = 'log.std',
        norm.param=list(log.n0=1e-05,sd.min.q=0),feature.type = 'original')
    # take the same cross validation split as before
    data_split(sc.obj.t.fs) <- data_split(sc.obj.t)
    # train
    sc.obj.t.fs <- train.model(sc.obj.t.fs, method = 'lasso')
    # make predictions
    sc.obj.t.fs <- make.predictions(sc.obj.t.fs)
    # evaluate predictions and record the result
    sc.obj.t.fs <- evaluate.predictions(sc.obj.t.fs)
    auroc.all <- auroc.all %>%
        add_row(cutoff=as.character(x), type='incorrect',
                study.test='Thomas_2018',
                AUC=as.numeric(sc.obj.t.fs@eval_data$auroc))
    # apply to the external dataset and record the result
    sc.obj.z <- siamcat(feat=feat.z, meta=meta.z,
                        label='study_condition', case='CRC')
    sc.obj.z <- make.predictions(sc.obj.t.fs, sc.obj.z)
    sc.obj.z <- evaluate.predictions(sc.obj.z)
    auroc.all <- auroc.all %>%
        add_row(cutoff=as.character(x), type='incorrect',
                study.test='Zeller_2014',
                AUC=as.numeric(sc.obj.z@eval_data$auroc))
}
```

## 2.4 Correct Procedure: Train with Nested Feature Selection

Feature selection can be performed correctly if it is nested within the
cross-validation procedure. We can do it using `SIAMCAT` by specifying the
`perform.fs` parameter in the `train.model` function.

```
for (x in fs.cutoff){
    # train using the original SIAMCAT object
    # with correct version of feature selection
    sc.obj.t.fs <- train.model(sc.obj.t, method = 'lasso', perform.fs = TRUE,
        param.fs = list(thres.fs = x,method.fs = "AUC",direction='absolute'))
    # make predictions
    sc.obj.t.fs <- make.predictions(sc.obj.t.fs)
    # evaluate predictions and record the result
    sc.obj.t.fs <- evaluate.predictions(sc.obj.t.fs)
    auroc.all <- auroc.all %>%
        add_row(cutoff=as.character(x), type='correct',
                study.test='Thomas_2018',
                AUC=as.numeric(sc.obj.t.fs@eval_data$auroc))
    # apply to the external dataset and record the result
    sc.obj.z <- siamcat(feat=feat.z, meta=meta.z,
                        label='study_condition', case='CRC')
    sc.obj.z <- make.predictions(sc.obj.t.fs, sc.obj.z)
    sc.obj.z <- evaluate.predictions(sc.obj.z)
    auroc.all <- auroc.all %>%
        add_row(cutoff=as.character(x), type='correct',
                study.test='Zeller_2014',
                AUC=as.numeric(sc.obj.z@eval_data$auroc))
}
```

## 2.5 Plot the Results

Now, we can plot the resulting performance estimates for the cross-validation
and the external validation as well:

```
auroc.all %>%
    # facetting for plotting
    mutate(split=case_when(study.test=="Thomas_2018"~
                            'Cross validation (Thomas 2018)',
                        TRUE~"External validation (Zeller 2014)")) %>%
    # convert to factor to enforce ordering
    mutate(cutoff=factor(cutoff, levels = c(fs.cutoff, 'full'))) %>%
    ggplot(aes(x=cutoff, y=AUC, col=type)) +
        geom_point() + geom_line(aes(group=type)) +
        facet_grid(~split) +
        scale_y_continuous(limits = c(0.5, 1), expand = c(0,0)) +
        xlab('Features selected') +
        ylab('AUROC') +
        theme_bw() +
        scale_colour_manual(values = c('correct'='blue', 'incorrect'='red'),
            name='Feature selection procedure') +
        theme(panel.grid.minor = element_blank(), legend.position = 'bottom')
```

![](data:image/png;base64...)

As you can see, the incorrect feature selection procedure leads to inflated
AUROC values but lower generalization to a truly external dataset, especially
when very few features were selected. In contrast, the correct procedure
gives a lower cross-validation results but a better estimation for how the
model would perform on external data.

# 3 Naive Splitting of Dependent Data

Another issue in machine learning workflows can occur when samples are not
independent. For example, microbiome samples taken from the same individual
at different time points are usually more similar to each other than to samples
from other individuals. If these samples are split randomly in a naive
cross-validation procedure, the case could arise that samples from the same
individual will end up in the training and the test fold. In this case, the
model would learn to generalize across time-points for the same individual
compared to the desired model that should learn to distinguish the label
across individuals.
To avoid this issue, dependent measurements need to be blocked during
cross-validation, to ensure that samples within the same block will stay in the
same fold (for training and testing).

## 3.1 Load the Data

As an example, we are going to use several datasets of Crohn’s disease (CD)
which are available through the EMBL cluster. The data have already been
filtered and cleaned.
Since the model training would take again quite a long time, this part of the
vignette is not evaluated upon building of the package, but you should be
able to execute it yourself.

```
data.loc <- 'https://zenodo.org/api/files/d81e429c-870f-44e0-a44a-2a4aa541b6c1/'

# metadata
meta.all <- read_tsv(paste0(data.loc, 'meta_all_cd.tsv'))
## Rows: 1597 Columns: 6
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: "\t"
## chr (4): Sample_ID, Group, Individual_ID, Study
## dbl (2): Library_Size, Timepoint
##
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

# features
feat.motus <- read.table(paste0(data.loc, 'feat_rel_filt_cd.tsv'),
                        sep='\t', stringsAsFactors = FALSE,
                        check.names = FALSE)
```

When we look at the number of samples and number of individuals, we see that
that there are several samples per individual for example in the `HMP2` study.

```
x <- meta.all %>%
    group_by(Study, Group) %>%
    summarise(n.all=n(), .groups='drop')
y <- meta.all %>%
    select(Study, Group, Individual_ID) %>%
    distinct() %>%
    group_by(Study, Group) %>%
    summarize(n.indi=n(),  .groups='drop')
full_join(x,y)
## Joining with `by = join_by(Study, Group)`
## # A tibble: 10 × 4
##    Study         Group n.all n.indi
##    <chr>         <chr> <int>  <int>
##  1 Franzosa_2019 CD       88     88
##  2 Franzosa_2019 CTR      56     56
##  3 HMP2          CD      583     50
##  4 HMP2          CTR     357     26
##  5 He_2017       CD       49     49
##  6 He_2017       CTR      53     53
##  7 Lewis_2015    CD      294     85
##  8 Lewis_2015    CTR      25     25
##  9 metaHIT       CD       21     13
## 10 metaHIT       CTR      71     59
```

Therefore, we are going to train a model on the `HMP2` study. However, the
number of samples per individual varies quite a lot across samples, therefore
we want to randomly select a set of 5 samples per individual:

```
meta.all %>%
    filter(Study=='HMP2') %>%
    group_by(Individual_ID) %>%
    summarise(n=n(), .groups='drop') %>%
    pull(n) %>% hist(20)
```

![](data:image/png;base64...)

```
# sample 5 samples per individual
meta.train <- meta.all %>%
    filter(Study=='HMP2') %>%
    group_by(Individual_ID) %>%
    sample_n(5, replace = TRUE) %>%
    distinct() %>%
    as.data.frame()
rownames(meta.train) <- meta.train$Sample_ID
```

For evaluation, we only want a single sample per individual, therefore we
can create a new matrix removing repeated samples for the other studies:

```
meta.ind <- meta.all %>%
    group_by(Individual_ID) %>%
    filter(Timepoint==min(Timepoint)) %>%
    ungroup()
```

Lastly, we can already create a tibble to hold the resulting AUROC values:

```
auroc.all <- tibble(type=character(0), study.test=character(0), AUC=double(0))
```

## 3.2 Train with Naive Cross-validation

The naive way to split samples for cross-validation does not take into account
the dependency between samples. Therefore, the pipeline would look basically
like this:

```
sc.obj <- siamcat(feat=feat.motus, meta=meta.train,
                    label='Group', case='CD')
sc.obj <- normalize.features(sc.obj, norm.method = 'log.std',
    norm.param=list(log.n0=1e-05,sd.min.q=1),feature.type = 'original')
sc.obj.naive <- create.data.split(sc.obj, num.folds = 10, num.resample = 10)
sc.obj.naive <- train.model(sc.obj.naive, method='lasso')
sc.obj.naive <- make.predictions(sc.obj.naive)
sc.obj.naive <- evaluate.predictions(sc.obj.naive)
auroc.all <- auroc.all %>%
    add_row(type='naive', study.test='HMP2',
        AUC=as.numeric(eval_data(sc.obj.naive)$auroc))
```

## 3.3 Train with Blocked Cross-validation

The correct way to to take into account repeated samples would be to block
the cross-validation procedure by individuals. This way, samples from the same
individual will always end up in the same fold. This can be performed in
`SIAMCAT` by specifying the `inseparable` parameter in the `create.data.split`
function:

```
sc.obj.block <- create.data.split(sc.obj, num.folds = 10, num.resample = 10,
                                inseparable = 'Individual_ID')
sc.obj.block <- train.model(sc.obj.block, method='lasso')
sc.obj.block <- make.predictions(sc.obj.block)
sc.obj.block <- evaluate.predictions(sc.obj.block)
auroc.all <- auroc.all %>%
    add_row(type='blocked', study.test='HMP2',
        AUC=as.numeric(eval_data(sc.obj.block)$auroc))
```

## 3.4 Apply to External Datasets

Now, we can apply both models to external datasets and record the resulting
accuracy:

```
for (i in setdiff(unique(meta.all$Study), 'HMP2')){
    meta.test <- meta.ind %>%
        filter(Study==i) %>%
        as.data.frame()
    rownames(meta.test) <- meta.test$Sample_ID
    # apply naive model
    sc.obj.test <- siamcat(feat=feat.motus, meta=meta.test,
                            label='Group', case='CD')
    sc.obj.test <- make.predictions(sc.obj.naive, sc.obj.test)
    sc.obj.test <- evaluate.predictions(sc.obj.test)
    auroc.all <- auroc.all %>%
    add_row(type='naive', study.test=i,
            AUC=as.numeric(eval_data(sc.obj.test)$auroc))
    # apply blocked model
    sc.obj.test <- siamcat(feat=feat.motus, meta=meta.test,
                            label='Group', case='CD')
    sc.obj.test <- make.predictions(sc.obj.block, sc.obj.test)
    sc.obj.test <- evaluate.predictions(sc.obj.test)
    auroc.all <- auroc.all %>%
        add_row(type='blocked', study.test=i,
                AUC=as.numeric(eval_data(sc.obj.test)$auroc))
}
```

## 3.5 Plot the Results

Now, we can compare the resulting AUROC values between the two different
approaches:

```
auroc.all %>%
    # convert to factor to enforce ordering
    mutate(type=factor(type, levels = c('naive', 'blocked'))) %>%
    # facetting for plotting
    mutate(CV=case_when(study.test=='HMP2'~'CV',
                        TRUE~'External validation')) %>%
    ggplot(aes(x=study.test, y=AUC, fill=type)) +
        geom_bar(stat='identity', position = position_dodge(), col='black') +
        theme_bw() +
        coord_cartesian(ylim=c(0.5, 1)) +
        scale_fill_manual(values=c('red', 'blue'), name='') +
        facet_grid(~CV, space = 'free', scales = 'free') +
        xlab('') + ylab('AUROC') +
        theme(legend.position = c(0.8, 0.8))
```

![](data:image/png;base64...)

As you can see, the naive cross-validation procedure leads to a inflated
performance estimation compared to the blocked cross-validation. However,
when assessing generalization to truly external datasets, the blocked
procedure results in better performance.

# 4 Session Info

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
##  [79] utf8_1.2.6           car_3.1-3            XVector_0.50.0
##  [82] BiocGenerics_0.56.0  foreach_1.5.2        pillar_1.11.1
##  [85] vroom_1.6.6          bbotk_1.7.1          splines_4.5.1
##  [88] lattice_0.22-7       survival_3.8-3       bit_4.6.0
##  [91] tidyselect_1.2.1     Biostrings_2.78.0    knitr_1.50
##  [94] reformulas_0.4.2     infotheo_1.2.0.1     gridExtra_2.3
##  [97] bookdown_0.45        IRanges_2.44.0       Seqinfo_1.0.0
## [100] stats4_4.5.1         xfun_0.53            Biobase_2.70.0
## [103] matrixStats_1.5.0    stringi_1.8.7        yaml_2.3.10
## [106] boot_1.3-32          evaluate_1.0.5       codetools_0.2-20
## [109] archive_1.1.12       BiocManager_1.30.26  cli_3.6.5
## [112] Rdpack_2.6.4         jquerylib_0.1.4      mlr3learners_0.13.0
## [115] dichromat_2.0-0.1    Rcpp_1.1.0           globals_0.18.0
## [118] parallel_4.5.1       prettyunits_1.2.0    paradox_1.0.1
## [121] lme4_1.1-37          listenv_0.9.1        glmnet_4.1-10
## [124] lmerTest_3.1-3       scales_1.4.0         crayon_1.5.3
## [127] rlang_1.1.6          mlr3measures_1.1.0
```