# Dealing with Multiple Imputations

Carles Hernandez-Ferrer and Juan R. Gonzalez

#### 30 October 2025

#### Abstract

An introductory guide to analysing multiple imputed exposome data with R package `rexposome`. The areas covered in this document are: loading the multiple imputations of both exposures and phenotypes from common `data.frame`s, exploration the exposome data, and testing association between exposures and health outcomes.

#### Package

rexposome 1.32.0

# Contents

* [1 Introduction](#introduction)
  + [1.1 Dummy Imputation with `mice`](#dummy-imputation-with-mice)
  + [1.2 Data Format](#data-format)
  + [1.3 Creating an `imExposomeSet`](#creating-an-imexposomeset)
    - [1.3.1 Accessing to Exposome Data](#accessing-to-exposome-data)
    - [1.3.2 Exposures Behaviour](#exposures-behaviour)
  + [1.4 Extracting an `ExposomeSet` from an `imExposomeSet`](#extracting-an-exposomeset-from-an-imexposomeset)
* [2 Exposome-Wide Association Studies (ExWAS)](#exposome-wide-association-studies-exwas)
  + [2.1 Extract the exposures over the *threshold of effective tests*](#extract-the-exposures-over-the-threshold-of-effective-tests)
* [Session info](#session-info)

# 1 Introduction

## 1.1 Dummy Imputation with `mice`

To illustrate how to perform a multiple imputation using `mice` we start loading both `rexposome` and `mice` libraries.

```
library(rexposome)
library(mice)
```

The we load the `txt` files includes in `rexposome` package so we can load the exposures and see the amount of missing data (check vignette *Exposome Data Analysis* for more information).

The following lines locates where the `txt` files were installed.

```
path <- file.path(path.package("rexposome"), "extdata")
description <- file.path(path, "description.csv")
phenotype <- file.path(path, "phenotypes.csv")
exposures <- file.path(path, "exposures.csv")
```

Once the files are located we load them as `data.frames`:

```
dd <- read.csv(description, header=TRUE, stringsAsFactors=FALSE)
ee <- read.csv(exposures, header=TRUE)
pp <- read.csv(phenotype, header=TRUE)
```

In order to speed up the imputation process that will be carried in this vignette, we will remove four families of exposures.

```
dd <- dd[-which(dd$Family %in% c("Phthalates", "PBDEs", "PFOAs", "Metals")), ]
ee <- ee[ , c("idnum", dd$Exposure)]
```

We can check the amount of missing data in both exposures and phenotypes `data.frames`:

```
data.frame(
    Set=c("Exposures", "Phenotypes"),
    Count=c(sum(is.na(ee)), sum(is.na(pp)))
)
```

```
##          Set Count
## 1  Exposures   304
## 2 Phenotypes     5
```

Before running `mice`, we need to collapse both the exposures and the phenotypes in a single `data.frame`.

```
rownames(ee) <- ee$idnum
rownames(pp) <- pp$idnum

dta <- cbind(ee[ , -1], pp[ , -1])
dta[1:3, c(1:3, 52:56)]
```

```
##            DDE       DDT      HCB  birthdate  sex age cbmi blood_pre
## id001       NA        NA       NA 2004-12-29 male 4.2 16.3       120
## id002 1.713577 0.6931915 1.270750 2005-01-05 male 4.2 16.4       121
## id003 2.594590 0.7448906 2.205519 2005-01-05 male 4.2 19.0       120
```

Once this is done, the *class* of each column needs to be set, so `mice` will be able to differentiate between continuous and categorical exposures.

```
for(ii in c(1:13, 18:47, 55:56)) {
    dta[, ii] <- as.numeric(dta[ , ii])
}
for(ii in c(14:17, 48:54)) {
    dta[ , ii] <- as.factor(dta[ , ii])
}
```

With this `data.frame` we perform the imputation calling `mice` functions (for more information about this call, check `mice`’s vignette). We remove the columns *birthdate* since it is not necessary for the imputations and carries lots of categories.

```
imp <- mice(dta[ , -52], pred = quickpred(dta[ , -52], mincor = 0.2,
    minpuc = 0.4), seed = 38788, m = 5, maxit = 10, printFlag = FALSE)
```

```
## Warning: Number of logged events: 223
```

```
class(imp)
```

```
## [1] "mids"
```

The created object `imp`, that is an object of class `mids` contains 20 data-sets with the imputed exposures and the phenotypes. To work with this information we need to extract each one of these sets and create a new data-set that includes all of them. This new `data.frame` will be passed to `rexposome` (check next section to see the requirements).

`mice` package includes the function `complete` that allows to extract a single data-set from an object of class `mids`. We will use this function to extract the sets and join them in a single `data.frame`.

If we set the argument `action` of the `complete` function to `0`, it will return the original data:

```
me <- complete(imp, action = 0)
me[ , ".imp"] <- 0
me[ , ".id"] <- rownames(me)
dim(me)
```

```
## [1] 109  57
```

```
summary(me[, c("H_pesticides", "Benzene")])
```

```
##  H_pesticides    Benzene
##  0   :68      Min.   :-0.47427
##  1   :35      1st Qu.:-0.19877
##  NA's: 6      Median :-0.11975
##               Mean   :-0.12995
##               3rd Qu.:-0.06879
##               Max.   : 0.13086
##               NA's   :3
```

If the `action` number is between 1 and the `m` value, it will return the selected set.

```
for(set in 1:5) {
    im <- complete(imp, action = set)
    im[ , ".imp"] <- set
    im[ , ".id"] <- rownames(im)
    me <- rbind(me, im)
}
me <- me[ , c(".imp", ".id", colnames(me)[-(97:98)])]
rownames(me) <- 1:nrow(me)
dim(me)
```

```
## [1] 654  59
```

## 1.2 Data Format

The format of the multiple imputation data for `rexposome` needs to follow some restrictions:

1. Both the **exposures** and the **phenotypes** are stored in the same `data.frame`.
2. This `data.frame` must have a column called `.imp` indicating the number of imputation. This imputation tagged as `0` are raw exposures (no imputation).
3. This `data.frame` must have a column called `.id` indicating the name of samples. This will be converted to character.
4. A `data.frame` with the *description* with the relation between exposures and families.

## 1.3 Creating an `imExposomeSet`

With the exposome `data.frame` and the description `data.frame` an object of class `imExposomeSet` can be created. To this end, the function `loadImputed` is used:

```
ex_imp <- loadImputed(data = me, description = dd,
                       description.famCol = "Family",
                       description.expCol = "Exposure")
```

The function `loadImputed` has several arguments:

```
args(loadImputed)
```

```
## function (data, description, description.famCol = "family", description.expCol = "exposure",
##     exposures.asFactor = 5, warnings = TRUE)
## NULL
```

The argument `data` is filled with the `data.frame` of exposures. The argument `decription` with the `data.frame` with the exposures’ description. `description.famCol` indicates the column on the description that corresponds to the family. `description.expCol` indicates the column on the description that corresponds to the exposures. Finally, `exposures.asFactor` indicates that the exposures with less that, by default, five different values are considered categorical exposures, otherwise continuous.

```
ex_imp
```

```
## Object of class 'imExposomeSet'
##  . exposures description:
##     . categorical:  4
##     . continuous:  43
##  . #imputations: 6 (raw detected)
##  . assayData: 47 exposures 109 individuals
##  . phenoData: 109 individuals 12 phenotypes
##  . featureData: 47 exposures 3 explanations
```

The output of this object indicates that we loaded 14 exposures, being 13 continuous and 1 categorical.

### 1.3.1 Accessing to Exposome Data

The class `ExposomeSet` has several accessors to get the data stored in it. There are four basic methods that returns the names of the individuals (`sampleNames`), the name of the exposures (`exposureNames`), the name of the families of exposures (`familyNames`) and the name of the phenotypes (`phenotypeNames`).

```
head(sampleNames(ex_imp))
```

```
## [1] "id001" "id002" "id003" "id004" "id005" "id006"
```

```
head(exposureNames(ex_imp))
```

```
## [1] "DDE"    "DDT"    "HCB"    "bHCH"   "PCB118" "PCB153"
```

```
familyNames(ex_imp)
```

```
## [1] "Organochlorines"   "Bisphenol A"       "Water Pollutants"
## [4] "Cotinine"          "Home Environment"  "Air Pollutants"
## [7] "Built Environment" "Noise"             "Temperature"
```

```
phenotypeNames(ex_imp)
```

```
##  [1] "whistling_chest" "flu"             "rhinitis"        "wheezing"
##  [5] "sex"             "age"             "cbmi"            "blood_pre"
##  [9] ".imp.1"          ".id.1"
```

`fData` will return the description of the exposures (including internal information to manage them).

```
head(fData(ex_imp), n = 3)
```

```
## DataFrame with 3 rows and 4 columns
##              Family    Exposure                   Name       .type
##         <character> <character>            <character> <character>
## DDE Organochlorines         DDE Dichlorodiphenyldich..     numeric
## DDT Organochlorines         DDT Dichlorodiphenyltric..     numeric
## HCB Organochlorines         HCB      Hexachlorobenzene     numeric
```

`pData` will return the phenotypes information.

```
head(pData(ex_imp), n = 3)
```

```
## DataFrame with 3 rows and 12 columns
##        .imp         .id whistling_chest      flu rhinitis wheezing      sex
##   <numeric> <character>        <factor> <factor> <factor> <factor> <factor>
## 1         0       id001        never          no       no      no      male
## 2         0       id002        never          no       no      no      male
## 3         0       id003        7-12 epi       no       no      yes     male
##        age      cbmi blood_pre    .imp.1       .id.1
##   <factor> <numeric> <numeric> <numeric> <character>
## 1      4.2      16.3       120         0       id001
## 2      4.2      16.4       121         0       id002
## 3      4.2      19.0       120         0       id003
```

### 1.3.2 Exposures Behaviour

The behavior of the exposures through the imputation process can be studies using the `plotFamily` method. This method will draw the behavior of the exposures in each imputation set in a single chart.

The method required an argument `family` and it will draw a mosaic with the plots from the exposures within the family. Following the same strategy than using an `ExposomeSet`, when the exposures are continuous box-plots are used.

```
plotFamily(ex_imp, family = "Organochlorines")
```

```
## Warning: Removed 104 rows containing non-finite outside the scale range
## (`stat_boxplot()`).
```

![](data:image/png;base64...)

For categorical exposures, the method draws accumulated bar-plot:

```
plotFamily(ex_imp, family = "Home Environment")
```

![](data:image/png;base64...)

The arguments `group` and `na.omit` are not available when `plotFamily` is used with an `imExposomeSet`.

## 1.4 Extracting an `ExposomeSet` from an `imExposomeSet`

Once an `imExposomeSet` is created, an `ExposomeSet` can be obtained by selecting one of the internal imputed-sets. This is done using the method `toES` and setting the argument `rid` with the number of the imputed-set to use:

```
ex_1 <- toES(ex_imp, rid = 1)
ex_1
```

```
## Object of class 'ExposomeSet' (storageMode: environment)
##  . exposures description:
##     . categorical:  4
##     . continuous:  43
##  . exposures transformation:
##     . categorical: 0
##     . transformed: 0
##     . standardized: 0
##     . imputed: 0
##  . assayData: 47 exposures 109 individuals
##     . element names: exp
##     . exposures: AbsPM25, ..., Temp
##     . individuals: id001, ..., id108
##  . phenoData: 109 individuals 10 phenotypes
##     . individuals: id001, ..., id108
##     . phenotypes: whistling_chest, ..., .imp.1
##  . featureData: 47 exposures 8 explanations
##     . exposures: AbsPM25, ..., Temp
##     . descriptions: Family, ..., .imp
## experimentData: use 'experimentData(object)'
## Annotation:
```

```
ex_3 <- toES(ex_imp, rid = 3)
ex_3
```

```
## Object of class 'ExposomeSet' (storageMode: environment)
##  . exposures description:
##     . categorical:  4
##     . continuous:  43
##  . exposures transformation:
##     . categorical: 0
##     . transformed: 0
##     . standardized: 0
##     . imputed: 0
##  . assayData: 47 exposures 109 individuals
##     . element names: exp
##     . exposures: AbsPM25, ..., Temp
##     . individuals: id001, ..., id108
##  . phenoData: 109 individuals 10 phenotypes
##     . individuals: id001, ..., id108
##     . phenotypes: whistling_chest, ..., .imp.1
##  . featureData: 47 exposures 8 explanations
##     . exposures: AbsPM25, ..., Temp
##     . descriptions: Family, ..., .imp
## experimentData: use 'experimentData(object)'
## Annotation:
```

# 2 Exposome-Wide Association Studies (ExWAS)

The interesting point on working with multiple imputations is to test the association of the different version of the exposures with a target phenotype. `rexposome` implements the method `exwas` to be used with an `imExposomeSet`.

```
as_iew <- exwas(ex_imp, formula = blood_pre~sex+age, family = "gaussian")
as_iew
```

```
## An object of class 'ExWAS'
##
##        ~ blood_pre sex + age
##
## Tested exposures:  47
## Threshold for effective tests (TEF):  2.43e-03
##  . Tests < TEF: 7
## Robust standar errors: Computed
```

As usual, the object obtained from `exwas` method can be plotted using `plotExwas`:

```
clr <- rainbow(length(familyNames(ex_imp)))
names(clr) <- familyNames(ex_imp)
plotExwas(as_iew, color = clr)
```

![](data:image/png;base64...)

## 2.1 Extract the exposures over the *threshold of effective tests*

The method `extract` allows to obtain a table of P-Values from an `ExWAS` object. At the same time, the `tef` method allows to obtain the *threshold of effective tests* computed at `exwas`. We can use them combined in order to create a table with the P-Value of the exposures that are beyond the *threshold of efective tests*.

1. First we get the *threshold of effective tests*

```
(thr <- tef(as_iew))
```

```
## [1] 0.002426352
```

2. Second we get the table of P-Values

```
tbl <- extract(as_iew)
```

3. Third we filter the table with the threshold

```
(sig <- tbl[tbl$pvalue <= thr, ])
```

```
## DataFrame with 11 rows and 4 columns
##              pvalue    effect      X2.5     X97.5
##           <numeric> <numeric> <numeric> <numeric>
## AbsPM25 5.26794e-05  20.09668  10.68607  29.50729
## NOx     7.96448e-05  12.85241   6.69541  19.00941
## NO      8.27436e-05  10.67213   5.55743  15.78682
## NO2     9.90808e-05  15.06292   7.77227  22.35356
## PM25CU  4.00711e-04  11.39992   5.23645  17.56340
## PM25    5.62435e-04  35.76444  16.11183  55.41704
## Temp    1.11891e-03  88.57154  36.30290 140.84017
## PCB180  1.37441e-03   4.00055   1.59345   6.40765
## PCB153  1.67554e-03   3.99374   1.54289   6.44459
## PM10Fe  2.07052e-03  13.57084   5.06769  22.07398
## PCB138  2.21163e-03   4.48011   1.65837   7.30184
```

# Session info

```
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
## [1] mice_3.18.0         ggplot2_4.0.0       rexposome_1.32.0
## [4] Biobase_2.70.0      BiocGenerics_0.56.0 generics_0.1.4
## [7] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] Rdpack_2.6.4         bitops_1.0-9         gridExtra_2.3
##   [4] formatR_1.14         sandwich_3.1-1       rlang_1.1.6
##   [7] magrittr_2.0.4       multcomp_1.4-29      ggridges_0.5.7
##  [10] compiler_4.5.1       reshape2_1.4.4       vctrs_0.6.5
##  [13] stringr_1.5.2        crayon_1.5.3         pkgconfig_2.0.3
##  [16] shape_1.4.6.1        fastmap_1.2.0        backports_1.5.0
##  [19] labeling_0.4.3       caTools_1.18.3       rmarkdown_2.30
##  [22] nloptr_2.2.1         purrr_1.1.0          jomo_2.7-6
##  [25] xfun_0.53            glmnet_4.1-10        cachem_1.1.0
##  [28] jsonlite_2.0.0       flashClust_1.01-2    gmm_1.9-1
##  [31] pan_1.9              pryr_0.1.6           broom_1.0.10
##  [34] cluster_2.1.8.1      R6_2.6.1             bslib_0.9.0
##  [37] stringi_1.8.7        RColorBrewer_1.1-3   boot_1.3-32
##  [40] rpart_4.1.24         jquerylib_0.1.4      estimability_1.5.1
##  [43] Rcpp_1.1.0           bookdown_0.45        iterators_1.0.14
##  [46] knitr_1.50           zoo_1.8-14           base64enc_0.1-3
##  [49] Matrix_1.7-4         splines_4.5.1        nnet_7.3-20
##  [52] tidyselect_1.2.1     rstudioapi_0.17.1    dichromat_2.0-0.1
##  [55] yaml_2.3.10          gplots_3.2.0         codetools_0.2-20
##  [58] plyr_1.8.9           lattice_0.22-7       tibble_3.3.0
##  [61] withr_3.0.2          S7_0.2.0             coda_0.19-4.1
##  [64] evaluate_1.0.5       tmvtnorm_1.7         foreign_0.8-90
##  [67] survival_3.8-3       norm_1.0-11.1        circlize_0.4.16
##  [70] pillar_1.11.1        BiocManager_1.30.26  KernSmooth_2.23-26
##  [73] corrplot_0.95        stats4_4.5.1         checkmate_2.3.3
##  [76] DT_0.34.0            foreach_1.5.2        reformulas_0.4.2
##  [79] S4Vectors_0.48.0     scales_1.4.0         minqa_1.2.8
##  [82] gtools_3.9.5         xtable_1.8-4         leaps_3.2
##  [85] glue_1.8.0           emmeans_2.0.0        scatterplot3d_0.3-44
##  [88] Hmisc_5.2-4          tools_4.5.1          lsr_0.5.2
##  [91] data.table_1.17.8    lme4_1.1-37          imputeLCMD_2.1
##  [94] mvtnorm_1.3-3        grid_4.5.1           impute_1.84.0
##  [97] tidyr_1.3.1          rbibutils_2.3        colorspace_2.1-2
## [100] nlme_3.1-168         htmlTable_2.4.3      Formula_1.2-5
## [103] cli_3.6.5            dplyr_1.1.4          pcaMethods_2.2.0
## [106] gtable_0.3.6         sass_0.4.10          digest_0.6.37
## [109] ggrepel_0.9.6        TH.data_1.1-4        FactoMineR_2.12
## [112] htmlwidgets_1.6.4    farver_2.1.2         htmltools_0.5.8.1
## [115] lifecycle_1.0.4      multcompView_0.1-10  mitml_0.4-5
## [118] GlobalOptions_0.1.2  MASS_7.3-65
```