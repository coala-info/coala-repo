# Exposome Data Analysis

Carles Hernandez-Ferrer1, Xavier Escriba-Montagut2 and Juan R. Gonzalez2,3\*

1Spanish National Center for Genomic Analysis (CNAG)
2Bioinformatics Research Group in Epidemiolgy (BRGE), Barcelona Insitute for Global Health (ISGlobal)
3Department of Mathematics, Autonomous University of Barcelona (UAB)

\*juanr.gonzalez@isglobal.org

#### 30 October 2025

#### Abstract

An introductory guide to analysing exposome data with R package `rexposome`. The areas covered in this document are: loading exposome data from files and matrices, exploration the exposome data including missing data quantification and individual clustering, and testing association between exposures and health outcomes.

#### Package

rexposome 1.32.0

# Contents

* [1 Introduction](#introduction)
  + [1.1 Installation](#installation)
  + [1.2 Pipeline](#pipeline)
  + [1.3 Data Format](#data-format)
    - [1.3.1 Three table format](#three-table-format)
    - [1.3.2 Single table format](#single-table-format)
* [2 Analysis](#analysis)
  + [2.1 Loading Exposome Data](#loading-exposome-data)
    - [2.1.1 From `TXT` files](#from-txt-files)
    - [2.1.2 From `data.frame`](#from-data.frame)
    - [2.1.3 Accessing to Exposome Data](#accessing-to-exposome-data)
  + [2.2 Exposome Pre-process](#exposome-pre-process)
    - [2.2.1 Missing Data in Exposures and Phenotypes](#missing-data-in-exposures-and-phenotypes)
    - [2.2.2 Exposures Normality](#exposures-normality)
    - [2.2.3 Exposures Imputation](#exposures-imputation)
    - [2.2.4 Exposures Characterization (i.e. data visualization)](#exposures-characterization-i.e.-data-visualization)
    - [2.2.5 Exposures PCA](#exposures-pca)
    - [2.2.6 Exposures Correlation](#exposures-correlation)
    - [2.2.7 Individuals Clustering](#individuals-clustering)
  + [2.3 Exposure associations](#exposure-associations)
    - [2.3.1 Understanding Principal Component Analysis](#understanding-principal-component-analysis)
    - [2.3.2 Exposure/Enviroment/Exposome Wide Association Studies (ExWAS)](#exposureenviromentexposome-wide-association-studies-exwas)
    - [2.3.3 Inverse ExWAS](#inverse-exwas)
    - [2.3.4 Variable selection ExWAS](#variable-selection-exwas)
* [Session info](#session-info)

# 1 Introduction

`rexposome` is an R package designed for the analysis of *exposome* data. The *exposome* can be defined as the measure of all the exposures of an individual in a lifetime and how those exposures relate to health. Hence, the aim or `rexposome` is to offer a set of functions to incorporate *exposome* data to R framework. Also to provide a series of tools to analyse *exposome* data using standard methods from Biocondcutor.

## 1.1 Installation

`rexposome` is currently in development and not available from CRAN nor Bioconductor. Anyway, the package can be installed by using `devtools` R package and taking the source from Bioinformatic Research Group in Epidemiology’s GitHub repository.

This can be done by opening an R session and typing the following code:

```
devtools::install_github("isglobal-brge/rexposome")
```

User must take into account that this sentence do not install the packages dependencies.

## 1.2 Pipeline

The following pictures illustrates the `rexposome`’s pipeline:

![](data:image/png;base64...)

Pipeline for exposome analysis

The first step is to load *exposome* data on R. `rexposome` provides to functions for this aim: one to load three `TXT` files and another to use three `data.frames`. Then the quantification of missing data and values under limit of detection (LOD) is done, and it helps to consider imputation processes. The *exposome* characterization is useful to understand the nature of the *exposome* and the relations between exposures. The clustering processes on individual exposure data is done to find exposure-signatures which association with health outcomes can be tested in the next step. From both exposures and exposure-signatures levels, the association with health outcomes is tested using *Exposome-Wide Association Studies* (ExWAS).

## 1.3 Data Format

### 1.3.1 Three table format

`rexposome` defines the *exposome* data as a three different data-sets:

1. Description Data
2. Exposure Data
3. Phenotype Data

The *description data* is a file describing the *exposome*. This means that has a row for each exposure and, at last, defined the families of exposures. Usually, this file incorporates a description of the exposures, the matrix where it was obtained and the units of measurement among others.

The following is an example of a *description data* file:

```
exposure  family  matrix         description
bde100    PBDEs   colostrum       BDE 100 - log10
bde138    PBDEs   colostrum       BDE 138 - log10
bde209    PBDEs   colostrum       BDE 209 - log10
PFOA      PFAS    cord blood      PFOA - log10
PFNA      PFAS    cord blood      PFNA - log10
PFOA      PFAS    maternal serum  PFOA - log10
PFNA      PFAS    maternal serum  PFNA - log10
hg        Metals  cord blood      hg - log 10
Co        Metals  urine           Co (creatinine) - log10
Zn        Metals  urine           Zn (creatinine) - log10
Pb        Metals  urine           Pb (creatinine) - log10
THM       Water   ---             Average total THM uptake - log10
CHCL3     Water   ---             Average Chloroform uptake - log10
BROM      Water   ---             Average Brominated THM uptake - log10
NO2       Air     ---             NO2 levels whole pregnancy- log10
Ben       Air     ---             Benzene levels whole pregnancy- log10
```

The *exposures data* file is the one containing the measures of each exposures for all the individuals included in the analysis. It is a matrix-like file having a row per individual and a column per exposures. It must includes a column with the subject’s identifier.

The following is an example of a *exposures data* file:

```
id    bde100  bde138  bde209  PFOA    ...
sub01  2.4665  0.7702  1.6866  2.0075 ...
sub02  0.7799  1.4147  1.2907  1.0153 ...
sub03 -1.6583 -0.9851 -0.8902 -0.0806 ...
sub04 -1.0812 -0.6639 -0.2988 -0.4268 ...
sub05 -0.2842 -0.1518 -1.5291 -0.7365 ...
...   ...     ...     ...     ...
```

The last of the data-sets is the *phenotype data* files. This file contains the covariates to be included in the analysis as well as the health outcomes of interest. It contains a row per individual included in the analysis and a column for each covariate and outcome. Moreover, it must include a column with the individual’s identifier.

The following is an example of a *phenotype data* file:

```
id    asthma   BMI      sex  age  ...
sub01 control  23.2539  boy  4    ...
sub02 asthma   24.4498  girl 5    ...
sub03 asthma   15.2356  boy  4    ...
sub04 control  25.1387  girl 4    ...
sub05 control  22.0477  boy  5    ...
...   ...      ...      ...  ...
```

To properly coordinate the *exposome* data, the information included in the three data-sets must follow some rules:

* *description data* files has a column identifying the exposures
* *exposures data* file has a column for each exposures defined in *description data* file
* *exposures data* file has a column identifying the individuals
* *phenotype data* files has a column identifying the same individuals included in the *exposures data* file

This rules are easy seen in the following figure:

![](data:image/png;base64...)

Links Between Files

In summary: All the exposures, rows, in the *description data* file are columns in the *exposures data* file (plus the column for identifying subjects). All the subjects in the *exposures data* files are, also, in the *phenotype data* file.

### 1.3.2 Single table format

To ease the life of researchers that have their datasets as one big table (exposures and phenotypes combined in a single table), we offer the option of using it as a input to `rexposome`. Please look into the documentation of the `loadExposome_plain()` function for further details on how to load this type of data. A few remarks on that methodology:

* The exposures can be grouped into families by passing a list argument
* Internally this function converts an exposures/phenotypes table into the three individual tables needed by `rexposome`
* There is no option of adding description fields to the exposures

An example of single table is the following:

```
id    bde100  bde138  bde209    asthma   BMI      ...
sub01  2.4665  0.7702  1.6866   control  23.2539  ...
sub02  0.7799  1.4147  1.2907   asthma   24.4498  ...
sub03 -1.6583 -0.9851 -0.8902   asthma   15.2356  ...
sub04 -1.0812 -0.6639 -0.2988   control  25.1387  ...
sub05 -0.2842 -0.1518 -1.5291   control  22.0477  ...
...   ...     ...      ...      ...      ...
```

And a visual representation of this single tables is the following:

![](data:image/png;base64...)

# 2 Analysis

`rexposome` R package is loaded using the standard `library` command:

```
library(rexposome)
```

`rexposome` provides two functions to load the *exposome* data: `readExposome` and `loadexposome`. The function `readExposome` will load the exposome data from txt files and `loadExposome` will do the same from standard R `data.frame`s. Both functions will create an `ExposomeSet` object. The `ExposomeSet` is a standard S4 class that will encapsulate the *exposome* data.

## 2.1 Loading Exposome Data

### 2.1.1 From `TXT` files

The function `readExposome` will create an `ExposomeSet` from the three `txt` files. The following lines are used to locate these three files, that were included in the package for demonstration purposes.

```
path <- file.path(path.package("rexposome"), "extdata")
description <- file.path(path, "description.csv")
phenotype <- file.path(path, "phenotypes.csv")
exposures <- file.path(path, "exposures.csv")
```

These files follows the rules described in **Data Format** section. They are `csv` files, meaning each values is split from the others by a comma (`,`). Function `readExposome` allows to load most any type of files containing *exposome* data:

```
args(readExposome)
```

```
## function (exposures, description, phenotype, sep = ",", na.strings = c("NA",
##     "-", "?", " ", ""), exposures.samCol = "sample", description.expCol = "exposure",
##     description.famCol = "family", phenotype.samCol = "sample",
##     exposures.asFactor = 5, warnings = TRUE)
## NULL
```

`readExposome` expects, by default, `csv` files. Changing the content of the argument `sep` will allow to load other files types. The missing values are set using the argument `na.strings`. This means that the character assigned to this argument will be interpreted as a missing value. By default, those characters are `"NA"`, `"-"`, `"?"`, `" "` and `""`. Then, the columns with the exposures’ names and the individual’s names need to be indicated. Arguments `exposures.samCol` and `phenotype.samCol` indicates the column with the individuals’ names at *exposures file* and *phenotypes file*. The arguments `description.expCol` and `description.famCol` indicates the column containing the exposures’ names and the exposures’ family in the *description file*.

```
exp <- readExposome(exposures = exposures, description = description, phenotype = phenotype,
    exposures.samCol = "idnum", description.expCol = "Exposure", description.famCol = "Family",
    phenotype.samCol = "idnum")
```

The result is an object of class `ExposomeSet`, that can show all the information of the loaded exposome:

```
exp
```

```
## Object of class 'ExposomeSet' (storageMode: environment)
##  . exposures description:
##     . categorical:  4
##     . continuous:  84
##  . exposures transformation:
##     . categorical: 0
##     . transformed: 0
##     . standardized: 0
##     . imputed: 0
##  . assayData: 88 exposures 109 individuals
##     . element names: exp
##     . exposures: AbsPM25, ..., Zn
##     . individuals: id001, ..., id108
##  . phenoData: 109 individuals 9 phenotypes
##     . individuals: id001, ..., id108
##     . phenotypes: whistling_chest, ..., cbmi
##  . featureData: 88 exposures 7 explanations
##     . exposures: AbsPM25, ..., Zn
##     . descriptions: Family, ..., .imp
## experimentData: use 'experimentData(object)'
## Annotation:
```

Under the section *exposures description* the number of continuous (84) and categorical (4) exposures are shown. The *assayData*, *phenoData* and *featureData* shows the content of the files we loaded with `readExposome`.

### 2.1.2 From `data.frame`

The function `loadExposome` allows to create an `ExposomeSet` through three `data.frames`: one as *description data*, one as *exposures data* and one as *phenotypes data*. The arguments are similar to the ones from `readExposome`:

```
args(loadExposome)
```

```
## function (exposures, description, phenotype, description.famCol = "family",
##     exposures.asFactor = 5, warnings = TRUE)
## NULL
```

In order to illustrate how to use `loadExposome`, we are loading the previous `csv` files as `data.frames`:

```
dd <- read.csv(description, header = TRUE)
ee <- read.csv(exposures, header = TRUE)
pp <- read.csv(phenotype, header = TRUE)
```

Then we rearrange the `data.frames` to fulfil with the requirements of the *exposome* data. The `data.frame` corresponding to *description data* needs to have the exposure’s names as rownames.

```
rownames(dd) <- dd[, 2]
dd <- dd[, -2]
```

The `data.frame` corresponding to *exposures data* needs to have the individual’s identifiers as rownames:

```
rownames(ee) <- ee[, 1]
ee <- ee[, -1]
```

The `data.frame` corresponding to *phenotypes data* needs to have the individual’s identifiers as a rownames, as the previous `data.frame`:

```
rownames(pp) <- pp[, 1]
pp <- pp[, -1]
```

Then, the `ExposomeSet` is creating by giving the three `data.frames` to `loadExposome`:

```
exp <- loadExposome(exposures = ee, description = dd, phenotype = pp, description.famCol = "Family")
```

### 2.1.3 Accessing to Exposome Data

The class `ExposomeSet` has several accessors to get the data stored in it. There are four basic methods that returns the names of the individuals (`sampleNames`), the name of the exposures (`exposureNames`), the name of the families of exposures (`familyNames`) and the name of the phenotypes (`phenotypeNames`).

```
head(sampleNames(exp))
```

```
## [1] "id001" "id002" "id003" "id004" "id005" "id006"
```

```
head(exposureNames(exp))
```

```
## [1] "AbsPM25" "As"      "BDE100"  "BDE138"  "BDE153"  "BDE154"
```

```
familyNames(exp)
```

```
##  [1] "Air Pollutants"    "Metals"            "PBDEs"
##  [4] "Bisphenol A"       "Water Pollutants"  "Built Environment"
##  [7] "Cotinine"          "Organochlorines"   "Home Environment"
## [10] "Phthalates"        "Noise"             "PFOAs"
## [13] "Temperature"
```

```
phenotypeNames(exp)
```

```
## [1] "whistling_chest" "flu"             "rhinitis"        "wheezing"
## [5] "birthdate"       "sex"             "age"             "cbmi"
## [9] "blood_pre"
```

`fData` will return the description of the exposures (including internal information to manage them).

```
head(fData(exp), n = 3)
```

```
##                 Family                                          Name .fct .trn
## AbsPM25 Air Pollutants Measurement of the blackness of PM2.5 filters
## As              Metals                                        Asenic
## BDE100           PBDEs            Polybrominated diphenyl ether -100
##         .std .imp   .type
## AbsPM25           numeric
## As                numeric
## BDE100            numeric
```

`pData` will return the phenotypes information.

```
head(pData(exp), n = 3)
```

```
##       whistling_chest flu rhinitis wheezing  birthdate  sex age cbmi blood_pre
## id001           never  no       no       no 2004-12-29 male 4.2 16.3       120
## id002           never  no       no       no 2005-01-05 male 4.2 16.4       121
## id003        7-12 epi  no       no      yes 2005-01-05 male 4.2 19.0       120
```

Finally, the method `expos` allows to obtain the matrix of exposures as a `data.frame`:

```
expos(exp)[1:10, c("Cotinine", "PM10V", "PM25", "X5cxMEPP")]
```

```
##          Cotinine       PM10V     PM25 X5cxMEPP
## id001  0.03125173  0.10373078 1.176255       NA
## id002  1.59401990 -0.47768393 1.155122       NA
## id003  1.46251090          NA 1.215834 1.859045
## id004  0.89059991          NA 1.171610       NA
## id005          NA          NA 1.145765       NA
## id006  0.34818304          NA 1.145382       NA
## id007  1.53591130          NA 1.174642       NA
## id008  2.26864700          NA 1.165078 1.291871
## id009  1.24842660          NA 1.171406 1.650948
## id010 -0.36758339  0.01593277 1.179240 2.112357
```

## 2.2 Exposome Pre-process

### 2.2.1 Missing Data in Exposures and Phenotypes

The number of missing data on each exposure and on each phenotype can be found by using the function `tableMissings`. This function returns a vector with the amount of missing data in each exposure or phenotype. The argument `set` indicates if the number of missing values is counted on exposures of phenotypes. The argument `output` indicates if it is shown as counts (`output="n"`) or as percentage (`output="p"`).

The current exposome data has no missing in the exposures nor in the phenotypes:

```
tableMissings(exp, set = "exposures", output = "n")
```

```
##         Dens         Temp         Conn      AbsPM25           NO          NO2
##            0            0            1            2            2            2
##          NOx         PM10       PM10Cu       PM10Fe        PM10K       PM10Ni
##            2            2            2            2            2            2
##        PM10S       PM10SI       PM10Zn         PM25       PM25CU       PM25FE
##            2            2            2            2            2            2
##        PM25K       PM25Ni        PM25S       PM25Sl       PM25Zn     PMcoarse
##            2            2            2            2            2            2
##      Benzene        PM25V          ETS G_pesticides          Gas         BTHM
##            3            3            5            5            5            6
##        CHCl3 H_pesticides      Noise_d      Noise_n          THM     Cotinine
##            6            6            6            6            6            7
##          DDE          DDT          HCB       PCB118       PCB138       PCB153
##           13           13           13           13           13           13
##       PCB180         bHCH          BPA           As           Cs           Mo
##           13           13           21           24           24           24
##           Ni           Tl           Zn           Hg           Cd           Sb
##           24           24           24           27           28           30
##        Green           Cu        PM10V           Se         MBzP        MEHHP
##           31           40           41           45           46           46
##         MEHP        MEOHP          MEP         MiBP         MnBP     X5cxMEPP
##           46           46           46           46           46           46
##           Co        PFHxS         PFNA         PFOA         PFOS    X7OHMMeOP
##           47           48           48           48           48           49
##           Pb     X2cxMMHP       BDE100       BDE138       BDE153       BDE154
##           59           64           76           76           76           76
##        BDE17       BDE183       BDE190       BDE209        BDE28        BDE47
##           76           76           76           76           76           76
##        BDE66        BDE71        BDE85        BDE99
##           76           76           76           76
```

```
tableMissings(exp, set = "phenotypes", output = "n")
```

```
## whistling_chest             flu        rhinitis        wheezing             sex
##               0               0               0               0               0
##             age            cbmi       blood_pre       birthdate
##               0               0               2               3
```

Alternatively to `tableMissings`, the function `plotMissings` draw a bar plot with the percentage of missing data in each exposure of phenotype.

```
plotMissings(exp, set = "exposures")
```

![](data:image/png;base64...)

### 2.2.2 Exposures Normality

Most of the test done in *exposome* analysis requires that the exposures must follow a normal distribution. The function `normalityTest` performs a test on each exposure for normality behaviour. The result is a `data.frame` with the exposures’ names, a flag `TRUE`/`FALSE` for normality and the p-value obtained from the *Shapiro-Wilk Normality Test* (if the p-value is under the threshold, then the exposure is not normal).

```
nm <- normalityTest(exp)
table(nm$normality)
```

```
##
## FALSE  TRUE
##    55    29
```

So, the exposures that do not follow a normal distribution are:

```
nm$exposure[!nm$normality]
```

```
##  [1] "DDT"      "PM10SI"   "PM25K"    "PM25Sl"   "PCB118"   "Tl"
##  [7] "PM10V"    "PM25Zn"   "PM25FE"   "PM10K"    "BDE17"    "PM25"
## [13] "PMcoarse" "PM10"     "BPA"      "Green"    "NO2"      "Cs"
## [19] "PFNA"     "PCB153"   "PM25CU"   "MEOHP"    "Cu"       "HCB"
## [25] "MEHHP"    "DDE"      "BDE190"   "bHCH"     "PM10Zn"   "MnBP"
## [31] "NO"       "NOx"      "PM10S"    "MEHP"     "PCB138"   "Zn"
## [37] "X2cxMMHP" "PCB180"   "PFOA"     "PFHxS"    "Cotinine" "PM25S"
## [43] "Co"       "Conn"     "PM25Ni"   "PM10Ni"   "Cd"       "Dens"
## [49] "Se"       "X5cxMEPP" "BDE183"   "BDE28"    "Sb"       "BDE138"
## [55] "PM25V"
```

Some of these exposures are categorical so they must not follow a normal distribution. This is the case, for example, of `G_pesticides`. If we plot the histogram of the values of the exposures it will make clear:

```
library(ggplot2)
plotHistogram(exp, select = "G_pesticides") + ggtitle("Garden Pesticides")
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the rexposome package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

Some others exposures are continuous variables that do not overpass the normality test. A visual inspection is required in this case.

```
plotHistogram(exp, select = "BDE209") + ggtitle("BDE209 - Histogram")
```

![](data:image/png;base64...)

If the exposures were following an anon normal distribution, the method `plotHistogram` has an argument `show.trans` that set to `TRUE` draws the histogram of the exposure plus three typical transformations:

```
plotHistogram(exp, select = "BDE209", show.trans = TRUE)
```

![](data:image/png;base64...)

### 2.2.3 Exposures Imputation

The imputation process is out of `rexposome` scope. Nevertheless, `rexposome` incorporates a wrapper to run the imputation tools from the R packages and `Hmisc`. The imputation of the exposures in the `ExposomeSet` is done by using this code:

```
exp <- imputation(exp)
```

To use `mice` package instead of `hmisc`, see the vignette entitles *Dealing with Multiple Imputations*.

### 2.2.4 Exposures Characterization (i.e. data visualization)

We can get a snapshot of the behaviour of the full *exposome* using the method `plotFamily` or its wrapper `plot`. This function allows drawing a plot of a given family of exposures or a mosaic with all the exposures.

```
plotFamily(exp, family = "all")
```

![](data:image/png;base64...)

This plotting method allows to group the exposure by a given phenotype using the argument `group`:

```
plotFamily(exp, family = "Phthalates", group = "sex")
```

![](data:image/png;base64...)

The same method allows to include a second group using the argument `group2`:

```
plotFamily(exp, family = "Phthalates", group = "rhinitis", group2 = "rhinitis")
```

![](data:image/png;base64...)

### 2.2.5 Exposures PCA

To properly perform a PCA analysis the exposures needs to be standardised. The standardisation is done using function `standardize` that allows using a *normal* and a *robust* approaches or use the *interquartile range*. The *normal aproache* scales the exposures using the mean as a centre and the standard variation used as dispersion. In *robust aproach* the median and the median absolute deviation are used. This transformation are only applied to continuous exposures. When *interquartile range* is used, the median is used as a center and the coeficient between the interquartile range of the exposure and the normal range between the percentile 75 and 25 as variance.

```
exp_std <- standardize(exp, method = "normal")
exp_std
```

```
## Object of class 'ExposomeSet' (storageMode: environment)
##  . exposures description:
##     . categorical:  4
##     . continuous:  84
##  . exposures transformation:
##     . categorical: 0
##     . transformed: 0
##     . standardized: 84
##     . imputed: 88
##  . assayData: 88 exposures 109 individuals
##     . element names: exp
##     . exposures: AbsPM25, ..., Zn
##     . individuals: id001, ..., id108
##  . phenoData: 109 individuals 9 phenotypes
##     . individuals: id001, ..., id108
##     . phenotypes: whistling_chest, ..., cbmi
##  . featureData: 88 exposures 7 explanations
##     . exposures: AbsPM25, ..., Zn
##     . descriptions: Family, ..., .imp
## experimentData: use 'experimentData(object)'
## Annotation:
```

Once the exposures are standardized we can run a PCA on the `ExposomeSet` using the method `pca`. Typically, exposome datasets contain both numerical and categorical variables, for that reason, a Factor Analysis of Mixed Data (FAMD) is performed by default rather than a PCA (which only uses numerical variables). To perform a regular PCA, provide the argument `pca = TRUE` to the `pca` function.

```
# FAMD
exp_pca <- pca(exp_std)

# PCA
exp_pca <- pca(exp_std, pca = TRUE)
```

The method `pca` returns an object of class `ExposomePCA`. This object encapsulates all the information generated by the principal component analysis. The method `plotPCA` can be used in several ways. The first way is setting the argument `set` to `"all"` to create a mosaic of plots.

```
plotPCA(exp_pca, set = "all")
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the rexposome package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

The plots in the first row correspond to the exposures and samples space. The first plot shows all the exposures on the axis for the first and the second principal components. The second plot shows all the individuals on the axis for the first and second principal components.

The plots on the second row are a summary of the variability explained by each component. The first plot is a bar plot with the variability explained by each component highlighting the components that are being drawn in the two first plots. The second plot is a line plot indicating the cumulative variability explained until each principal component. The vertical dashed line indicates the last principal component that is drawn in the first two plots. The horizontal dashed line indicates the amount of explained variability.

A second way of using `plotPCA` is changing the content of the argument `set` to `"samples"` to see the samples’ space. When the `set` argument is filled with `samples`, the argument `phenotype` can be used to colour each sample with its phenotype value.

```
plotPCA(exp_pca, set = "samples", phenotype = "sex")
```

![](data:image/png;base64...)

This plot shows the sample space of the first and the second principal component. Each dot is a sample and it is coloured depending on its value in `sex`. We can see that no cluster is done in terms of sex.

This view be recreated in a 3D space using the function `plot3PCA`:

```
plot3PCA(exp_pca, cmpX = 1, cmpY = 2, cmpZ = 3, phenotype = "sex")
```

![](data:image/png;base64...)

### 2.2.6 Exposures Correlation

The correlation between exposures, in terms of intra-family and inter-family exposures, is interesting to take into account. The correlation of the exposome can be computed using `correlation`.

```
exp_cr <- correlation(exp, use = "pairwise.complete.obs", method.cor = "pearson")
```

The values of the correlation can be obtained using the method `extract`. This returns a `data.frame`.

```
extract(exp_cr)[1:4, 1:4]
```

```
##             AbsPM25         As     BDE100      BDE138
## AbsPM25  1.00000000 -0.1681446  0.1098427 -0.03196037
## As      -0.16814460  1.0000000 -0.3727296  0.13768481
## BDE100   0.10984268 -0.3727296  1.0000000  0.11482844
## BDE138  -0.03196037  0.1376848  0.1148284  1.00000000
```

The best option to see the inter-family correlations is the *circos of correlations* while the *matrix of correlations* is a better way for studying the intra-family correlations. Both of them are drawn using the method `plotCorrelation`.

```
plotCorrelation(exp_cr, type = "circos")
```

![](data:image/png;base64...)

```
plotCorrelation(exp_cr, type = "matrix")
```

![](data:image/png;base64...)

### 2.2.7 Individuals Clustering

Clustering analysis on exposures data results in exposure profile. The method `clustering` allows applying most of any clustering method to an `ExposomeSet` method.

The argument of the method `clustering` are:

```
args(clustering)
```

```
## function (object, method, cmethod, ..., warnings = TRUE)
## NULL
```

The argument `method` is filled with the *clustering function*. This *clustering function* needs to accept an argument called `data`, that will be filled with the exposures-matrix. The object obtained from the *clustering function* needs to have an accessor called `classification`. Otherwise the argument `cmethod` needs to be filled with a function that takes the results of the *clustering function* and returns a vector with the classification of each individual.

In this analysis we apply the clustering method `hclust`. Hence we create a function to accept an argument called `data`.

```
hclust_data <- function(data, ...) {
    hclust(d = dist(x = data), ...)
}
```

The argument `...` allows passing arguments from `recposome`’s `clustering` method to `hclust`.

Then, a function to obtain the classification of each sample is also required. This function will use the `cutree` function to obtain the labels.

```
hclust_k3 <- function(result) {
    cutree(result, k = 3)
}
```

The new function `hclust_k3` is a function that takes the results of `hclust_data` and applies it the `cutree` function, requesting 3 groups of individuals.

Having both *clustering function* (`hclust_data`) and the *classification function* (`hclust_k3`) we use them in the `clustering` method:

```
exp_c <- clustering(exp, method = hclust_data, cmethod = hclust_k3)
```

```
## Warning in clustering(exp, method = hclust_data, cmethod = hclust_k3): Non
## continuous exposures will be discarded.
```

```
exp_c
```

```
## Object of class 'ExposomeClust' (storageMode: environment)
##  . Method: .... TRUE
##  . assayData: 84 exposures 109 samples
##     . element names: exp
##     . exposures: AbsPM25, ..., Zn
##     . samples: id001, ..., id108
##  . featureData: 84 exposures 7 explanations
##     . exposures: AbsPM25, ..., Zn
##     . descriptions: Family, ..., .imp
##     . #Cluster: 3
```

The profile for each group of individuals can be plotted with `plotClassification` method.

```
plotClassification(exp_c)
```

![](data:image/png;base64...)

The classification of each individual can be obtained using the method `classification`. We can get a table with the number of samples per group with:

```
table(classification(exp_c))
```

```
##
##  1  2  3
## 80 24  5
```

As seen, the groups are given as numbers and the `plotClassification` transforms it to names (*Group 1*, *Group 2* and *Group 3*).

## 2.3 Exposure associations

Once preprocessed the exposome its association with health outcomes can be tested through three different approaches:

1. Using the results of the PCA
2. Testing the association of each exposure to a given trait (single exposure association)
3. Testing the association of the exposome to a given trait (multiple exposure associations)

### 2.3.1 Understanding Principal Component Analysis

From the results of the PCA on the exposome data, two measures can be obtained: the correlation of the exposures with the principal components and the association of the phenotypes with the principal components.

The method `plotEXP` draws a heat map with the correlation of each exposure to the principal components.

```
plotEXP(exp_pca) + theme(axis.text.y = element_text(size = 6.5)) + ylab("")
```

![](data:image/png;base64...)

From the plot, some conclusions can be obtained:

* **PC 1** is hight correlated with **particle matter** (*PM*) exposures.
* **PC 2** is correlated with the **Polybrominated Diphenyl Ethers** (*BDES*) exposures.
* **PC 5** is negative correlated with **Perfluorooctanoic Acid** (*PFOAS*) and **Polychlorinated Biphenyl** (*PCBS*).

These conclusions are useful to give a meaning to the Principal Components in terms of exposures.

The method `plotPHE` test the association between the phenotypes and the principal components and draws a heat map with the score of the association.

```
plotPHE(exp_pca)
```

![](data:image/png;base64...)

The conclusions that can be taken from the heat map are:

* **age** is associated to **PC 10**.
* **sex** is associated to **PC 6** and **PC 10**.
* **flu** is associated to **PC 5**.

### 2.3.2 Exposure/Enviroment/Exposome Wide Association Studies (ExWAS)

Method `exwas` performs univariate test of the association between exposures and health outcomes. This method requests a `formula` to test and the family of the distribution of the health outcome (dependent variable). The models fitted are:

```
phenotype ~ exposure_1 + covar1 + ... + covarN
phenotype ~ exposure_2 + covar1 + ... + covarN
phenotype ~ exposure_3 + covar1 + ... + covarN
...
phenotype ~ exposure_M + covar1 + ... + covarN
```

The following line performs an ExWAS on flu and wheezing adjusted by sex and age. Since the content of `flu` and others in the `ExposomeSet` is dichotomous, the `family` is set to binomial (for more information see `?glm`).

```
fl_ew <- exwas(exp, formula = blood_pre ~ sex + age, family = "gaussian")
fl_ew
```

```
## An object of class 'ExWAS'
##
##        ~ blood_pre sex + age
##
## Tested exposures:  88
## Threshold for effective tests (TEF):  1.28e-03
##  . Tests < TEF: 2
## Robust standar errors: Computed
```

```
we_ew <- exwas(exp, formula = wheezing ~ sex + age, family = "binomial")
we_ew
```

```
## An object of class 'ExWAS'
##
##        ~ wheezing sex + age
##
## Tested exposures:  88
## Threshold for effective tests (TEF):  1.28e-03
##  . Tests < TEF: 0
## Robust standar errors: Computed
```

The method `exwas` calculates the effective number of tests in base of the correlation between the exposures. This is transformed into a *threshold* for the p-values of the association. This threshold can be obtained using the method `tef`.

A table with the associations between the exposures and `flu` is obtained with method `extract`:

```
head(extract(fl_ew))
```

```
## DataFrame with 6 rows and 4 columns
##              pvalue    effect      X2.5     X97.5
##           <numeric> <numeric> <numeric> <numeric>
## NOx     8.47991e-06   13.3616   7.77552   18.9477
## NO      1.11507e-05   10.9207   6.28755   15.5539
## NO2     1.16036e-05   15.4009   8.85282   21.9489
## AbsPM25 1.66436e-05   20.2280  11.45428   29.0018
## PM25    3.71920e-05   37.7805  20.60678   54.9543
## PM25CU  1.35029e-04   11.5171   5.82592   17.2082
```

A Manhattan-like plot with the p-values of the association between each exposure and asthma, coloured by families of exposures, is draw by method `plotExwas`.

```
clr <- rainbow(length(familyNames(exp)))
names(clr) <- familyNames(exp)
plotExwas(fl_ew, we_ew, color = clr) + ggtitle("Exposome Association Study - Univariate Approach")
```

![](data:image/png;base64...)

Then a plot for the effects of a given model can be obtained with `plotEffect`:

```
plotEffect(fl_ew)
```

![](data:image/png;base64...)

#### 2.3.2.1 Sensitivity analysis: stratified models

No direct method is implemented to perform a stratified exposome wide analysis, however it may be of interest for some researchers, so a small code sample is provided to perform such studies. On this example a stratified analysis using the `sex` phenotype as stratifying variable is used, the formula associates the exposures to the phenotype `cbmi` with no covariates.

```
strat_variable <- "sex"
formula <- cbmi ~ 1
family <- "gaussian"

strat_ex <- lapply(levels(as.factor(pData(exp)[[strat_variable]])), function(i) {
    mask <- pData(exp)[[strat_variable]] == i
    exwas_i <- rexposome::exwas(exp[, mask], formula = formula, family = family,
        tef = FALSE)
    exwas_i@formula <- update.formula(exwas_i@formula, as.formula(paste0("~ . + strata(",
        strat_variable, "_", gsub("[[:space:]]|-|+|(|)", "", i), ")")))
    return(exwas_i)
})
```

We have created a list of ExWAS objects that we can plot together using the following:

```
do.call(plotExwas, strat_ex)
```

![](data:image/png;base64...)

### 2.3.3 Inverse ExWAS

Method `invExWAS` performs a similar association test between exposures and health outcomes. The method asks for a `formula` to indicate the health outcome and covariables of interest for the association test. The difference to the regular ExWAS is on the model fitted, which on the inverse ExWAS is:

```
exposure_1 ~ phenotype + covar1 + ... + covarN
exposure_2 ~ phenotype + covar1 + ... + covarN
exposure_3 ~ phenotype + covar1 + ... + covarN
...
exposure_M ~ phenotype + covar1 + ... + covarN
```

Since not all exposures on a dataset have to be of the same family, linear models (`lm`) are fitted for numerical exposures, while multinomial log-linear models (`nnet::multinom`) are fitted for categorical variables.

The following examples perforns an inverse ExWAS analysis on flu adjusted by sex, note that no left hand side term needs to be supplied, since the left term will be all the exposures on the dataset, if a left han side term is supplied it will be ignored.

```
inv_ex <- invExWAS(exp, formula = ~flu + sex)
```

```
## Warning in stats::chisq.test(...): Chi-squared approximation may be incorrect
## Warning in stats::chisq.test(...): Chi-squared approximation may be incorrect
## Warning in stats::chisq.test(...): Chi-squared approximation may be incorrect
## Warning in stats::chisq.test(...): Chi-squared approximation may be incorrect
## Warning in stats::chisq.test(...): Chi-squared approximation may be incorrect
## Warning in stats::chisq.test(...): Chi-squared approximation may be incorrect
## Warning in stats::chisq.test(...): Chi-squared approximation may be incorrect
```

```
inv_ex
```

```
## An object of class 'ExWAS'
##
##        ~ expositions flu + sex
##
## Tested exposures:  88
## Threshold for effective tests (TEF):  1.28e-03
##  . Tests < TEF: 0
## Robust standar errors: Computed
```

Since the object returned by `invExWAS` is of class `ExWAS`, all the previous manipulation explained can be used on it. Following the example we can extract the table of results:

```
head(extract(inv_ex))
```

```
## DataFrame with 6 rows and 4 columns
##            pvalue      effect       X2.5      X97.5
##         <numeric>   <numeric>  <numeric>  <numeric>
## As     0.00151377  0.23157105  0.0519541  0.4111880
## BDE28  0.01576420 -0.01815712 -0.1025770  0.0662627
## PFNA   0.01788771 -0.08982500 -0.1637145 -0.0159355
## BDE66  0.04975334 -0.00946186 -0.0844738  0.0655500
## BDE154 0.05357511  0.09111855  0.0162881  0.1659490
## BDE71  0.07885360  0.00156862 -0.1044215  0.1075588
```

And we can also use the visualization methods:

```
clr <- rainbow(length(familyNames(exp)))
names(clr) <- familyNames(exp)
plotExwas(inv_ex, color = clr) + ggtitle("Inverse Exposome Association Study - Univariate Approach")
```

![](data:image/png;base64...)

### 2.3.4 Variable selection ExWAS

The last approach is a multivariate analysis in order to find the group of exposures related to the health outcome. This can be done using methods like Elastic Net. The method `mexwas` applies elastic net to the exposures given a health outcome of interest.

```
bl_mew <- mexwas(exp_std, phenotype = "blood_pre", family = "gaussian")
we_mew <- mexwas(exp_std, phenotype = "wheezing", family = "binomial")
```

The coefficient of each exposure is plotted with `plotExwas`. The method draws a heat map with two columns and the exposures as rows. The heat map is coloured with the coefficient of each exposure in relation with the health outcome, so the ones in white are not interesting. The two columns of the heat map correspond to the minimum lambda (`Min`) and to the lambda which gives the most regularised model such that error is within one standard error of the minimum (`1SE`).

```
plotExwas(bl_mew, we_mew) + ylab("") + ggtitle("Exposome Association Study - Multivariate Approach")
```

```
## Ignoring unknown labels:
## • colour : ""
```

![](data:image/png;base64...)

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
## [1] ggplot2_4.0.0       rexposome_1.32.0    Biobase_2.70.0
## [4] BiocGenerics_0.56.0 generics_0.1.4      BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] Rdpack_2.6.4         bitops_1.0-9         gridExtra_2.3
##   [4] formatR_1.14         sandwich_3.1-1       rlang_1.1.6
##   [7] magrittr_2.0.4       multcomp_1.4-29      ggridges_0.5.7
##  [10] compiler_4.5.1       reshape2_1.4.4       vctrs_0.6.5
##  [13] stringr_1.5.2        crayon_1.5.3         pkgconfig_2.0.3
##  [16] shape_1.4.6.1        fastmap_1.2.0        backports_1.5.0
##  [19] labeling_0.4.3       caTools_1.18.3       rmarkdown_2.30
##  [22] nloptr_2.2.1         xfun_0.53            glmnet_4.1-10
##  [25] cachem_1.1.0         jsonlite_2.0.0       flashClust_1.01-2
##  [28] gmm_1.9-1            pryr_0.1.6           cluster_2.1.8.1
##  [31] R6_2.6.1             bslib_0.9.0          stringi_1.8.7
##  [34] RColorBrewer_1.1-3   boot_1.3-32          rpart_4.1.24
##  [37] jquerylib_0.1.4      estimability_1.5.1   Rcpp_1.1.0
##  [40] bookdown_0.45        iterators_1.0.14     knitr_1.50
##  [43] zoo_1.8-14           base64enc_0.1-3      Matrix_1.7-4
##  [46] splines_4.5.1        nnet_7.3-20          tidyselect_1.2.1
##  [49] rstudioapi_0.17.1    dichromat_2.0-0.1    yaml_2.3.10
##  [52] gplots_3.2.0         codetools_0.2-20     plyr_1.8.9
##  [55] lattice_0.22-7       tibble_3.3.0         withr_3.0.2
##  [58] S7_0.2.0             coda_0.19-4.1        evaluate_1.0.5
##  [61] tmvtnorm_1.7         foreign_0.8-90       survival_3.8-3
##  [64] norm_1.0-11.1        circlize_0.4.16      pillar_1.11.1
##  [67] BiocManager_1.30.26  KernSmooth_2.23-26   corrplot_0.95
##  [70] stats4_4.5.1         checkmate_2.3.3      DT_0.34.0
##  [73] foreach_1.5.2        reformulas_0.4.2     S4Vectors_0.48.0
##  [76] scales_1.4.0         minqa_1.2.8          gtools_3.9.5
##  [79] xtable_1.8-4         leaps_3.2            glue_1.8.0
##  [82] emmeans_2.0.0        scatterplot3d_0.3-44 Hmisc_5.2-4
##  [85] tools_4.5.1          lsr_0.5.2            data.table_1.17.8
##  [88] lme4_1.1-37          imputeLCMD_2.1       mvtnorm_1.3-3
##  [91] grid_4.5.1           impute_1.84.0        rbibutils_2.3
##  [94] colorspace_2.1-2     nlme_3.1-168         htmlTable_2.4.3
##  [97] Formula_1.2-5        cli_3.6.5            dplyr_1.1.4
## [100] pcaMethods_2.2.0     gtable_0.3.6         sass_0.4.10
## [103] digest_0.6.37        ggrepel_0.9.6        TH.data_1.1-4
## [106] FactoMineR_2.12      htmlwidgets_1.6.4    farver_2.1.2
## [109] htmltools_0.5.8.1    lifecycle_1.0.4      multcompView_0.1-10
## [112] GlobalOptions_0.1.2  MASS_7.3-65
```