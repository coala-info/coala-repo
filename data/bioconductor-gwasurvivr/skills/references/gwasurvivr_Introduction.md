# gwasurvivr Vignette

Abbas Rizvi1, Ezgi Karaesmen1, Martin Morgan2 and Lara Sucheston-Campbell1

1The Ohio State University, Columbus, OH
2Roswell Park Comprehensive Cancer Center, Buffalo, NY

#### October 30, 2025

#### Package

gwasurvivr 1.28.0

# 1 Introduction

`gwasurvivr` can be used to perform survival analyses of imputed genotypes from Sanger and Michigan imputation servers and IMPUTE2 software. This vignette is a tutorial on how to perform these analyses. This package can be run locally on a Linux, Mac OS X, Windows or conveniently batched on a high performing computing cluster. `gwasurvivr` iteratively processes the data in chunks and therefore intense memory requirements are not necessary.

1. `michiganCoxSurv`: Performs survival analysis on imputed genetic data stored in compressed VCF files generated via Michigan imputation server.
2. `sangerCoxSurv`: Performs survival analysis on imputed genetic data stored in compressed VCF files generated via Sanger imputation server.
3. `impute2CoxSurv`: Performs survival analysis on imputed genetic data from IMPUTE2 output.
4. `plinkCoxSurv`: Performs survival analysis on directly typed genetic data from PLINK files (.BED, .BIM, and .FAM)
5. `gdsCoxSurv`: Performs survival analysis on genetic data that user has already converted from IMPUTE2 format to GDS format.

All functions fit a Cox PH model to each SNP including other user defined covariates and will save the results as a text file directly to the disk that contains survival analysis results. `gwasurvivr` functions can also test for interaction of SNPs with a given covariate. See examples for further details.

## 1.1 Main input arguments

All three functions require the following main arguments:

* `vcf.file`: A character string giving the path to genotype data file (`impute.file` for IMPUTE2; `b.file` for PLINK)
* `covariate.file`: A data frame comprising sample IDs (that link to the genotype data samples), phenotype (time, event) and additional covariate data
* `id.column`: A character string providing sample ID column name in covariate.file
* `time.to.event`: A character string that contains the time column name in covariate.file
* `event`: Character string that contains the event column name in covariate.file
* `covariates`: Character vector with contains column names in covariate.file of covariates to include in model
* `out.file`: A character string giving output file name

Further arguments can be passed depending on the user preference. For example, user can define minor allele frequency (MAF) or info/R2 score threshold to filter out SNPs that have low MAF or info/R2 score to avoid false-positive signals and to reduce computing time. User can also define a subset of samples to be analyzed by providing the set of sample IDs. Users can also control how chunk size – the number of rows (SNPs) to include for each iteration.

**IMPORTANT: In the `covariate.file`, categorical variables need to be converted to indicator (dummy) variables and be of class `numeric`. Ordinal variables represented as characters, ie “low”, “medium” and “high” should be converted to the appropriate numeric values as well.**

## 1.2 Main output format

The output for the 3 main functions in `gwasurvivr` are very similar but with subtle differences. In general the output includes the following main fields: RSID, TYPED, CHR, POS, REF, ALT, Allele Frequencies\*, INFO\*, PVALUES, HRs, HR confidence intervals, coefficient estimates, standard errors, Z-statistic, N, and NEVENT. Allele frequencies and INFO differ by the input imputation software.

**Note: Invoking the `inter.term` argument for any of the functions will make the PVALUE and HRs and HR confidence intervals represent the INTERACTION term and not the SNP alone.**

The non-software specific fields are summarized below:

| Column | Description |
| --- | --- |
| RSID | SNP ID |
| CHR | Chromosome number |
| POS | Genomic Position (BP) |
| REF | Reference Allele |
| ALT | Alternate Allele |
| SAMP\_FREQ\_ALT | Alternate Allele frequency in sample being tested |
| SAMP\_MAF | Minor allele frequency in sample being tested |
| PVALUE | P-value of single SNP or interaction term |
| HR | Hazard Ratio (HR) |
| HR\_lowerCI | Lower bound 95% CI of HR |
| HR\_upperCI | Upper bound 95% CI of HR |
| COEF | Estimated coefficient of SNP |
| SE.COEF | Standard error of coefficient estimate |
| Z | Z-statistic |
| N | Number of individuals in sample being tested |
| NEVENT | Number of events that occurred in sample being tested |

The software specific fields are summarized below:
1. `michiganCoxSurv` unique output columns are AF, MAF, R2, ER2. They are summarized below.

| Column | Description |
| --- | --- |
| TYPED | Imputation status: TRUE (SNP IS TYPED)/FALSE (SNP IS IMPUTED) |
| AF | Minimac3 output Alternate Allele Frequency |
| MAF | Minimac3 output of Minor Allele Frequency |
| R2 | Imputation R2 score (minimac3 \(R^2\)) |
| ER2 | Minimac3 ouput empirical \(R^2\) |

Please see [Minimac3 Info File](https://genome.sph.umich.edu/wiki/Minimac3_Info_File) for details on output

2. `sangerCoxSurv`

| Column | Description |
| --- | --- |
| TYPED | Imputation status: TRUE (SNP IS TYPED)/FALSE (SNP IS IMPUTED) |
| RefPanelAF | HRC Reference Panel Allele Frequency |
| INFO | Imputation INFO score from PBWT |

3. `impute2CoxSurv`

| Column | Description |
| --- | --- |
| TYPED | `---` is imputed, repeated RSID is typed |
| A0 | Allele coded 0 in IMPUTE2 |
| A1 | Allele coded 1 in IMPUTE2 |
| exp\_freq\_A1 | Expected allele frequency of alelle code A1 |

More statistics can be printed out by invoking the `print.covs` argument and setting it to `print.covs=all` (single SNP/SNP\*covariate interaction) or `print.covs=some` (SNP\*covariate ineraction). These options are available mainly for modeling purposes (covariate selection) and aren’t suggested for very large analyses as it will greatly increase the number of columns in the output, depending on how many covariates users are adjusting for.

# 2 Getting started

Install `gwasurvivr` from the [Sucheston-Campbell Lab Github repository](http://github.com/suchestoncampbelllab/gwasurvivr) using `devtools`.

```
devtools::install_github("suchestoncampbelllab/gwasurvivr")
```

Or please install from the `devel` branch of Bioconductor (R version >= 3.5)

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("gwasurvivr", version = "devel")
```

## 2.1 Dependencies

**Note**: This package depends on `GWASTools` which uses netcdf framework on linux. Therefore, for linux users, please install `libnetcdf-dev` and `netcdf-bin` before installing `gwasurvivr`. These linux libraries may already installed on an academic computing cluster.

CRAN packages:
1. `ncdf4`
2. `matrixStats`
3. `parallel`
4. `survival`

```
install.packages(c("ncdf4", "matrixStats", "parallel", "survival"))
```

Bioconductor packages:
1. `GWASTools`
2. `VariantAnnotation`
3. `SummarizedExperiment`
4. `SNPRelate`

```
BiocManager::install("GWASTools")
BiocManager::install("VariantAnnotation")
BiocManager::install("SummarizedExperiment")
BiocManager::install("SNPRelate")
```

Load `gwasurvivr`.

```
library(gwasurvivr)
```

## 2.2 User settings: parallelization setup

`gwasurvivr` uses `parallel` package for its internal parallelization to fit the Cox PH models. Users are not required to define a parallelization setup, by default `gwasurvivr` functions will detect the user’s operating system and set the cluster object to `FORK` if the platform is Linux/OS X and to `SOCK` if Windows. However, parallelization settings can be modified by the user if needed. Users are given two ways to define their cluster settings:

**1. Setting the number of cores to be used:**

Linux/OS X users can run analyses on a prespecified number of cores by setting the option in the R session as shown below. This option should be defined in the R session before running any of the `gwasurvivr` functions. Here we decide to use 4 cores. This option is not available to Windows users.

```
options("gwasurvivr.cores"=4)
```

**2. Providing a user defined cluster object**

To modify more settings, users can also provide a “cluster object” to any of the `gwasurvivr` functions. The cluster object can be generated via `makeCluster`, `makePSOCKcluster`, `makeForkCluster` functions from `parallel` package or similar cluster object functions from `snow` or `snowfall` packages. This method can be applied on any operating system. User can create a cluster object before running any of the functions and pass the cluster object to the `clusterObj` argument as shown below. For further details see `??parallel::parallel`.

```
library(parallel)
cl <- makeCluster(detectCores())

impute2CoxSurv(..., clusterObj=cl)
sangerCoxSurv(..., clusterObj=cl)
michiganCoxSurv(..., clusterObj=cl)
```

# 3 R Session Examples

## 3.1 Michigan Imputation Server

[Michigan Imputation Server](https://imputationserver.sph.umich.edu/index.html) pre-phases typed genotypes using HAPI-UR, SHAPEIT, or EAGLE (default is EAGLE2), imputes using Minimac3 imputation engine and outputs Blocked GNU Zip Format VCF files (`.vcf.gz`). These `.vcf.gz` files are used as input for `gwasurvivr`. Minimac uses slightly different metrics to assess imputation quality (\(R^2\) versus info score) and complete details as to minimac output are available on the [Minimac3 Wikipage](https://genome.sph.umich.edu/wiki/Minimac3_Imputation_Cookbook).

The function, `michiganCoxSurv` uses a modification of Cox proportional hazard regression from the R library `survival:::coxph.fit`. Built specifically for genetic data, `michiganCoxSurv` allows the user to filter on info (\(R^2\)) score (imputation quality metric) and minor allele frequency from the reference panel used for imputation using `RefPanelAF` as the input arguement for `maf.filter`. Users are also provided with the sample minor allele frequency (MAF) in the `sangerCoxSurv` output, which can be used for filtering post analysis.

Samples can be selected for analyses by providing a vector of `sample.ids`. The output from Sanger imputation server returns the samples as `SAMP1, ..., SAMPN`, where `N` is the total number of samples. The sample order corresponds to the sample order in the `vcf.file` used for imputation. Note, sample order can also be found in the `.fam` file if genotyping data were initially in `.bed`, `.bim` and `.fam` (PLINK) format prior to conversion to VCF. If no sample list is specified all samples are included in the analyses.

```
vcf.file <- system.file(package="gwasurvivr",
                        "extdata",
                        "michigan.chr14.dose.vcf.gz")
pheno.fl <- system.file(package="gwasurvivr",
                        "extdata",
                        "simulated_pheno.txt")
pheno.file <- read.table(pheno.fl,
                         sep=" ",
                         header=TRUE,
                         stringsAsFactors = FALSE)
head(pheno.file)
```

```
##   ID_1  ID_2 event  time   age DrugTxYes    sex        group
## 1    1 SAMP1     0 12.00 33.93         0   male      control
## 2    2 SAMP2     1  7.61 58.71         1   male experimental
## 3    3 SAMP3     0 12.00 39.38         0 female      control
## 4    4 SAMP4     0  4.30 38.85         0   male      control
## 5    5 SAMP5     0 12.00 43.58         0   male experimental
## 6    6 SAMP6     1  2.60 57.74         0   male      control
```

```
# recode sex column and remove first column
pheno.file$SexFemale <- ifelse(pheno.file$sex=="female", 1L, 0L)
# select only experimental group sample.ids
sample.ids <- pheno.file[pheno.file$group=="experimental",]$ID_2
head(sample.ids)
```

```
## [1] "SAMP2"  "SAMP5"  "SAMP7"  "SAMP9"  "SAMP11" "SAMP12"
```

In this example, we will select samples from the `experimental` group and will test survival only on these patients. The first column in the `pheno.file` are sample IDs, which link the phenotype file to the imputation file. We include `age`, `DrugTxYes`, and `sex` in the survival model as covariates.

We perform the analysis using the `experimental` group to demonstrate how one may want to prepare their data if interested in testing only on a subset of samples (i.e. a case-control study and survival of cases is of interest). Note that how the IDs (`sample.ids`) need to be a vector of class `character`. The `chunk.size` refers to size of each data chunk read in and is defaulted to 10,000 rows. Users can customize that to their needs. The larger the `chunk.size` the more memory (RAM) required to run the analysis. The recommended `chunk.size=10000` and probably should not exceed `chunk.size=100000`. This does not mean that `gwasurvivr` is limited to only 100,000 SNPs, it just is how many SNPs are analyzed for each iteration.

By default survival estimates and pvalues for the SNP adjusted for other covariates are outputted (`print.covs='only'`), however users can select `print.covs=all` to get the coefficient estimates for covariates included in the model. Depending on the number of covariates included this can add substantially to output file size.

### 3.1.1 Single SNP analysis

Next we run `michiganCoxSurv` with the default, `print.covs="only"`, load the results into R and provide descriptions of output by column. We will then run the analysis again using `print.covs="all"`. `verbose=TRUE` is used for these examples so the function display messages while running.

Use `?michiganCoxSurv` for argument specific documentation.

`print.covs="only"`

```
michiganCoxSurv(vcf.file=vcf.file,
                covariate.file=pheno.file,
                id.column="ID_2",
                sample.ids=sample.ids,
                time.to.event="time",
                event="event",
                covariates=c("age", "SexFemale", "DrugTxYes"),
                inter.term=NULL,
                print.covs="only",
                out.file="michigan_only",
                r2.filter=0.3,
                maf.filter=0.005,
                chunk.size=100,
                verbose=TRUE,
                clusterObj=NULL)
```

```
## Analysis started on 2025-10-30 at 00:23:35
```

```
## Covariates included in the models are: age, DrugTxYes, SexFemale
```

```
## 52 samples are included in the analysis
```

```
## Analyzing chunk 0-100
```

```
## Analyzing chunk 100-200
```

```
## Analysis completed on 2025-10-30 at 00:23:54
```

```
## 0 SNPs were removed from the analysis for not meeting the threshold criteria.
```

```
## List of removed SNPs can be found in /tmp/RtmpABctHY/michigan_onlyd85017690499d.snps_removed
```

```
## 3 SNPs were analyzed in total
```

```
## The survival output can be found at /tmp/RtmpABctHY/michigan_onlyd85017690499d.coxph
```

Here we load the data and glimpse the first few values in each column outputted from the SNP\*interaction survival analyses using `print.covs="only"`.

```
michigan_only <- read.table("michigan_only.coxph", sep="\t", header=TRUE, stringsAsFactors = FALSE)
```

```
str(head(michigan_only))
```

```
## 'data.frame':    3 obs. of  21 variables:
##  $ RSID         : chr  "rs34919020" "rs8005305" "rs757545375"
##  $ TYPED        : logi  FALSE FALSE FALSE
##  $ CHR          : int  14 14 14
##  $ POS          : int  19459185 20095842 20097287
##  $ REF          : chr  "C" "G" "A"
##  $ ALT          : chr  "T" "T" "G"
##  $ AF           : num  0.301 0.515 0.52
##  $ MAF          : num  0.301 0.485 0.48
##  $ SAMP_FREQ_ALT: num  0.355 0.517 0.52
##  $ SAMP_MAF     : num  0.355 0.483 0.48
##  $ R2           : num  0.552 0.479 0.481
##  $ ER2          : logi  NA NA NA
##  $ PVALUE       : num  0.713 0.805 0.798
##  $ HR           : num  1.224 0.885 0.881
##  $ HR_lowerCI   : num  0.417 0.333 0.332
##  $ HR_upperCI   : num  3.6 2.35 2.34
##  $ Z            : num  0.368 -0.246 -0.255
##  $ COEF         : num  0.203 -0.123 -0.127
##  $ SE.COEF      : num  0.55 0.498 0.498
##  $ N            : int  52 52 52
##  $ N.EVENT      : int  21 21 21
```

### 3.1.2 SNP with covariate interaction

A SNP\*covariate interaction can be implemented using the `inter.term` argument. In this example, we will use `DrugTxYes` from the covariate file as the covariate we want to test for interaction with the SNP.

`print.covs="only"`

```
michiganCoxSurv(vcf.file=vcf.file,
                covariate.file=pheno.file,
                id.column="ID_2",
                sample.ids=sample.ids,
                time.to.event="time",
                event="event",
                covariates=c("age", "SexFemale", "DrugTxYes"),
                inter.term="DrugTxYes",
                print.covs="only",
                out.file="michigan_intx_only",
                r2.filter=0.3,
                maf.filter=0.005,
                chunk.size=100,
                verbose=FALSE,
                clusterObj=NULL)
```

Here we load the data and glimpse the first few values in each column outputted from the SNP\*interaction survival analyses using `print.covs="only"`.

```
michigan_intx_only <- read.table("michigan_intx_only.coxph", sep="\t", header=TRUE, stringsAsFactors = FALSE)
```

```
str(head(michigan_intx_only))
```

```
## 'data.frame':    3 obs. of  21 variables:
##  $ RSID         : chr  "rs34919020" "rs8005305" "rs757545375"
##  $ TYPED        : logi  FALSE FALSE FALSE
##  $ CHR          : int  14 14 14
##  $ POS          : int  19459185 20095842 20097287
##  $ REF          : chr  "C" "G" "A"
##  $ ALT          : chr  "T" "T" "G"
##  $ AF           : num  0.301 0.515 0.52
##  $ MAF          : num  0.301 0.485 0.48
##  $ SAMP_FREQ_ALT: num  0.355 0.517 0.52
##  $ SAMP_MAF     : num  0.355 0.483 0.48
##  $ R2           : num  0.552 0.479 0.481
##  $ ER2          : logi  NA NA NA
##  $ PVALUE       : num  0.9017 0.0806 0.0786
##  $ HR           : num  1.15 7.03 7.11
##  $ HR_lowerCI   : num  0.127 0.789 0.799
##  $ HR_upperCI   : num  10.4 62.7 63.2
##  $ Z            : num  0.124 1.747 1.759
##  $ COEF         : num  0.139 1.951 1.961
##  $ SE.COEF      : num  1.12 1.12 1.11
##  $ N            : int  52 52 52
##  $ N.EVENT      : int  21 21 21
```

## 3.2 Sanger Imputation Server

[Sanger Imputation Server](https://imputation.sanger.ac.uk/) pre-phases typed genotypes using either SHAPEIT or EAGLE, imputes genotypes using PBWT algorithm and outputs a `.vcf.gz` file for each chromosome. These `.vcf.gz` files are used as input for `gwasurvivr`. The function, `sangerCoxSurv` uses a modification of Cox proportional hazard regression from `survival::coxph.fit`. Built specifically for genetic data, `sangerCoxSurv` allows the user to filter on info score (imputation quality metric) and minor allele frequency from the reference panel used for imputation using `RefPanelAF` as the input arguement for `maf.filter`. Users are also provided with the sample minor allele frequency in the `sangerCoxSurv` output.

Samples can be selected for analyses by providing a vector of `sample.ids`. The output from Sanger imputation server returns the samples as `SAMP1, ..., SAMPN`, where `N` is the total number of samples. The sample order corresponds to the sample order in the VCF file used for imputation. Note, sample order can also be found in the `.fam` file if genotyping data were initially in `.bed`, `.bim` and `.fam` (PLINK) format prior to conversion to VCF. If no sample list is specified, all samples are included in the analyses.

In this example, we will select samples from the `experimental` group and will test survival only on these patients. The first column in the `pheno.file` are sample IDs (we will match on these). We include `age`, `DrugTxYes`, and `sex` in the survival model as covariates.

```
vcf.file <- system.file(package="gwasurvivr",
                        "extdata",
                        "sanger.pbwt_reference_impute.vcf.gz")
pheno.fl <- system.file(package="gwasurvivr",
                        "extdata",
                        "simulated_pheno.txt")
pheno.file <- read.table(pheno.fl,
                         sep=" ",
                         header=TRUE,
                         stringsAsFactors = FALSE)
head(pheno.file)
```

```
##   ID_1  ID_2 event  time   age DrugTxYes    sex        group
## 1    1 SAMP1     0 12.00 33.93         0   male      control
## 2    2 SAMP2     1  7.61 58.71         1   male experimental
## 3    3 SAMP3     0 12.00 39.38         0 female      control
## 4    4 SAMP4     0  4.30 38.85         0   male      control
## 5    5 SAMP5     0 12.00 43.58         0   male experimental
## 6    6 SAMP6     1  2.60 57.74         0   male      control
```

```
# recode sex column and remove first column
pheno.file$SexFemale <- ifelse(pheno.file$sex=="female", 1L, 0L)
# select only experimental group sample.ids
sample.ids <- pheno.file[pheno.file$group=="experimental",]$ID_2
head(sample.ids)
```

```
## [1] "SAMP2"  "SAMP5"  "SAMP7"  "SAMP9"  "SAMP11" "SAMP12"
```

We perform the analysis using the `experimental` group to demonstrate how one may want to prepare their data if not initially all samples are patients or cases (i.e. a case-control study and survival of cases is of interest). We also are showing how the IDs (`sample.ids`) need to be a vector of class `character`. The `chunk.size` refers to size of each data chunk read in and is defaulted to 10,000 rows, users can customize that to their needs. The larger the `chunk.size` the more memory (RAM) required to run the analysis. The recommended `chunk.size=10000` and probably should not exceed `chunk.size=100000`. This does not mean that `gwasurvivr` is limited to only 100,000 SNPs, it just is how many SNPs are analyzed for each iteration.

By default survival estimates and pvalues for the SNP adjusted for other covariates are outputted (`print.covs='only'`), however users can select `print.covs=all` to get the coefficient estimates for covariates included in the model. Depending on the number of covariates included this can add substantially to output file size.

Use `?sangerCoxSurv` for argument specific documentation.

### 3.2.1 Single SNP analysis

Next we run `sangerCoxSurv` with the default, `print.covs="only"`, load the results into R and provide descriptions of output by column. `verbose=TRUE` is used for these examples so the function display messages while running.

`print.covs="only"`

```
sangerCoxSurv(vcf.file=vcf.file,
              covariate.file=pheno.file,
              id.column="ID_2",
              sample.ids=sample.ids,
              time.to.event="time",
              event="event",
              covariates=c("age", "SexFemale", "DrugTxYes"),
              inter.term=NULL,
              print.covs="only",
              out.file="sanger_only",
              info.filter=0.3,
              maf.filter=0.005,
              chunk.size=100,
              verbose=TRUE,
              clusterObj=NULL)
```

```
## Analysis started on 2025-10-30 at 00:24:13
```

```
## Covariates included in the models are: age, DrugTxYes, SexFemale
```

```
## 52 samples are included in the analysis
```

```
## Analyzing chunk 0-100
```

```
## Analyzing chunk 100-200
```

```
## Analysis completed on 2025-10-30 at 00:24:35
```

```
## 0 SNPs were removed from the analysis for not meeting the threshold criteria.
```

```
## List of removed SNPs can be found in /tmp/RtmpABctHY/sanger_onlyd85015772ea2f.snps_removed
```

```
## 3 SNPs were analyzed in total
```

```
## The survival output can be found at /tmp/RtmpABctHY/sanger_onlyd85015772ea2f.coxph
```

Here we load the data and glimpse the first few values in each column from the survival analyses.

```
str(head(sanger_only))
```

```
## 'data.frame':    3 obs. of  19 variables:
##  $ RSID         : chr  "rs34919020" "rs8005305" "rs757545375"
##  $ TYPED        : logi  FALSE FALSE FALSE
##  $ CHR          : int  14 14 14
##  $ POS          : int  19459185 20095842 20097287
##  $ REF          : chr  "C" "G" "A"
##  $ ALT          : chr  "T" "T" "G"
##  $ RefPanelAF   : num  0.301 0.515 0.52
##  $ SAMP_FREQ_ALT: num  0.355 0.517 0.52
##  $ SAMP_MAF     : num  0.355 0.483 0.48
##  $ INFO         : num  0.552 0.479 0.481
##  $ PVALUE       : num  0.713 0.805 0.798
##  $ HR           : num  1.224 0.885 0.881
##  $ HR_lowerCI   : num  0.417 0.333 0.332
##  $ HR_upperCI   : num  3.6 2.35 2.34
##  $ Z            : num  0.368 -0.246 -0.255
##  $ COEF         : num  0.203 -0.123 -0.127
##  $ SE.COEF      : num  0.55 0.498 0.498
##  $ N            : int  52 52 52
##  $ N.EVENT      : int  21 21 21
```

Column names with descriptions from the survival analyses with covariates, specifying the default `print.covs="only"`

### 3.2.2 SNP with covariate interaction

A SNP\*covariate interaction can be implemented using the `inter.term` argument. In this example, we will use `DrugTxYes` from the covariate file as the covariate we want to test for interaction with the SNP.

`print.covs="only"`

```
sangerCoxSurv(vcf.file=vcf.file,
              covariate.file=pheno.file,
              id.column="ID_2",
              sample.ids=sample.ids,
              time.to.event="time",
              event="event",
              covariates=c("age", "SexFemale", "DrugTxYes"),
              inter.term="DrugTxYes",
              print.covs="only",
              out.file="sanger_intx_only",
              info.filter=0.3,
              maf.filter=0.005,
              chunk.size=100,
              verbose=TRUE,
              clusterObj=NULL)
```

## 3.3 IMPUTE2 Imputation

IMPUTE2 is a genotype imputation and haplotype phasing program (Howie et al 2009). IMPUTE2 outputs 6 files for each chromosome chunk imputed (usually 5 MB in size). Only 2 of these files are required for analyses using `gwasurvivr`:

* Genotype file (`.impute`)
* Sample file (`.sample`)

[More information can be read about these formats](http://www.stats.ox.ac.uk/~marchini/software/gwas/file_format.html)

We are going to load in and pre-process the genetic data and the phenotypic data (`covariate.file`).

```
impute.file <- system.file(package="gwasurvivr",
                            "extdata",
                            "impute_example.impute2.gz")
sample.file <- system.file(package="gwasurvivr",
                           "extdata",
                           "impute_example.impute2_sample")
covariate.file <- system.file(package="gwasurvivr",
                              "extdata",
                              "simulated_pheno.txt")
covariate.file <- read.table(covariate.file,
                             sep=" ",
                             header=TRUE,
                             stringsAsFactors = FALSE)
covariate.file$SexFemale <- ifelse(covariate.file$sex=="female", 1L, 0L)
sample.ids <- covariate.file[covariate.file$group=="experimental",]$ID_2
```

To perform survival analysis using IMPUTE2 the function arguments are very similarto `michiganCoxSurv` and `sangerCoxSurv`, however the function now takes a chromosome arguement. This is needed to properly annotate the file output with the chromosome that these SNPs are in. This is purely an artifact of IMPUTE2 and how we leverage `GWASTools` in this function.

### 3.3.1 Single SNP analysis

First we will do the analysis with no interaction term, followed by doing the analysis with the interaction term. The recommended output setting for single SNP analysis is `print.cov="only"`.

```
impute2CoxSurv(impute.file=impute.file,
               sample.file=sample.file,
               chr=14,
               covariate.file=covariate.file,
               id.column="ID_2",
               sample.ids=sample.ids,
               time.to.event="time",
               event="event",
               covariates=c("age", "SexFemale", "DrugTxYes"),
               inter.term=NULL,
               print.covs="only",
               out.file="impute_example_only",
               chunk.size=100,
               maf.filter=0.005,
               exclude.snps=NULL,
               flip.dosage=TRUE,
               verbose=TRUE,
               clusterObj=NULL)
```

```
## Covariates included in the models are: age, DrugTxYes, SexFemale
```

```
## 52 samples are included in the analysis
```

```
## Analysis started on 2025-10-30 at 00:24:52
```

```
## Determining number of SNPs and samples...
```

```
## Including all SNPs.
```

```
## scan.df not given. Assigning scanIDs automatically.
```

```
## Reading sample file...
```

```
## Reading genotype file...
```

```
## Block 1 of 1
```

```
## Writing annotation...
```

```
## Compressing...
```

```
## Clean up the fragments of GDS file:
##     open the file '/tmp/RtmpABctHY/d85011fbfc538.gds' (3.3K)
##     # of fragments: 30
##     save to '/tmp/RtmpABctHY/d85011fbfc538.gds.tmp'
##     rename '/tmp/RtmpABctHY/d85011fbfc538.gds.tmp' (2.4K, reduced: 987B)
##     # of fragments: 14
```

```
## ***** Compression time ******
## User:0.08
## System: 0.007
## Elapsed: 0.102
## *****************************
```

```
## Analyzing part 1/1...
```

```
## 0 SNPs were removed from the analysis for not meeting
## the given threshold criteria or for having MAF = 0
```

```
## List of removed SNPs are saved to /tmp/RtmpABctHY/impute_example_onlyd85013165d19b.snps_removed
```

```
## In total 3 SNPs were included in the analysis
```

```
## The Cox model results output was saved to /tmp/RtmpABctHY/impute_example_onlyd85013165d19b.coxph
```

```
## Analysis completed on 2025-10-30 at 00:24:54
```

Here we load the data and glimpse the first few values in each column output.

```
impute2_res_only <- read.table("impute_example_only.coxph", sep="\t", header=TRUE, stringsAsFactors = FALSE)
str(head(impute2_res_only))
```

```
## 'data.frame':    3 obs. of  17 variables:
##  $ RSID       : chr  "rs34919020" "rs8005305" "rs757545375"
##  $ TYPED      : chr  "---" "---" "---"
##  $ CHR        : int  14 14 14
##  $ POS        : int  19459185 20095842 20097287
##  $ A0         : chr  "C" "G" "A"
##  $ A1         : chr  "T" "T" "G"
##  $ exp_freq_A1: num  0.355 0.517 0.52
##  $ SAMP_MAF   : num  0.355 0.483 0.48
##  $ PVALUE     : num  0.713 0.805 0.798
##  $ HR         : num  1.224 0.885 0.881
##  $ HR_lowerCI : num  0.417 0.333 0.332
##  $ HR_upperCI : num  3.6 2.35 2.34
##  $ Z          : num  0.368 -0.246 -0.255
##  $ COEF       : num  0.203 -0.123 -0.127
##  $ SE.COEF    : num  0.55 0.498 0.498
##  $ N          : int  52 52 52
##  $ N.EVENT    : int  21 21 21
```

### 3.3.2 SNP covariate interaction

Now we will perform a SNP\*covariate interaction survival analysis using `impute2CoxSurv`.

```
impute2CoxSurv(impute.file=impute.file,
               sample.file=sample.file,
               chr=14,
               covariate.file=covariate.file,
               id.column="ID_2",
               sample.ids=sample.ids,
               time.to.event="time",
               event="event",
               covariates=c("age", "SexFemale", "DrugTxYes"),
               inter.term="DrugTxYes",
               print.covs="only",
               out.file="impute_example_intx",
               chunk.size=100,
               maf.filter=0.005,
               flip.dosage=TRUE,
               verbose=FALSE,
               clusterObj=NULL,
               keepGDS=FALSE)
```

```
## Determining number of SNPs and samples...
```

```
## Including all SNPs.
```

```
## scan.df not given. Assigning scanIDs automatically.
```

```
## Reading sample file...
```

```
## Reading genotype file...
```

```
## Block 1 of 1
```

```
## Writing annotation...
```

```
## Compressing...
```

```
## Clean up the fragments of GDS file:
##     open the file '/tmp/RtmpABctHY/d85011c70d084.gds' (3.3K)
##     # of fragments: 30
##     save to '/tmp/RtmpABctHY/d85011c70d084.gds.tmp'
##     rename '/tmp/RtmpABctHY/d85011c70d084.gds.tmp' (2.4K, reduced: 987B)
##     # of fragments: 14
```

```
## ***** Compression time ******
## User:0.047
## System: 0.014
## Elapsed: 0.078
## *****************************
```

Here we load the data and glimpse the first few values in each column outputted from the SNP\*interaction survival analyses using `print.covs="only"`.

```
impute2_res_intx <- read.table("impute_example_intx.coxph", sep="\t", header=TRUE, stringsAsFactors = FALSE)
str(head(impute2_res_intx))
```

```
## 'data.frame':    3 obs. of  17 variables:
##  $ RSID       : chr  "rs34919020" "rs8005305" "rs757545375"
##  $ TYPED      : chr  "---" "---" "---"
##  $ CHR        : int  14 14 14
##  $ POS        : int  19459185 20095842 20097287
##  $ A0         : chr  "C" "G" "A"
##  $ A1         : chr  "T" "T" "G"
##  $ exp_freq_A1: num  0.355 0.517 0.52
##  $ SAMP_MAF   : num  0.355 0.483 0.48
##  $ PVALUE     : num  0.9017 0.0806 0.0786
##  $ HR         : num  1.15 7.03 7.11
##  $ HR_lowerCI : num  0.127 0.789 0.799
##  $ HR_upperCI : num  10.4 62.7 63.2
##  $ Z          : num  0.124 1.747 1.759
##  $ COEF       : num  0.139 1.951 1.961
##  $ SE.COEF    : num  1.12 1.12 1.11
##  $ N          : int  52 52 52
##  $ N.EVENT    : int  21 21 21
```

# 4 plinkCoxSurv

# 5 Batch Examples

## 5.1 Batch Example sangerCoxSurv

Batch jobs for multiple analyses and different subsets are easy to implement using `gwasurvivr`. These types of analyses should be reserved for usage on a UNIX-based high performance computing cluster. This is facilitated by the package `batch`, which can internalize R variables from bash. First write an R script (e.g. `mysurvivalscript.R`) to pass in bash.

**Note: it is important to refer to the Getting Started part of the manual for packages that need to be installed for this**

```
## mysurvivalscript.R
library(gwasurvivr)
library(batch)

parseCommandArgs(evaluate=TRUE) # this is loaded in the batch package

options("gwasurvivr.cores"=4)

vcf.file <- system.file(package="gwasurvivr",
                        "extdata",
                        vcf.file)
pheno.fl <- system.file(package="gwasurvivr",
                        "extdata",
                        pheno.file)
pheno.file <- read.table(pheno.fl,
                         sep=" ",
                         header=TRUE,
                         stringsAsFactors = FALSE)
# recode sex column and remove first column
pheno.file$SexFemale <- ifelse(pheno.file$sex=="female", 1L, 0L)
# select only experimental group sample.ids
sample.ids <- pheno.file[pheno.file$group=="experimental",]$ID_2
## -- unlist the covariates
## (refer below to the shell script as to why we are doing this)
covariates <- unlist(sapply(covariates, strsplit, "_", 1, "[["))

sangerCoxSurv(vcf.file=vcf.file,
              covariate.file=pheno.file,
              id.column="ID_2",
              sample.ids=sample.ids,
              time.to.event=time,
              event=event,
              covariates=covariates,
              inter.term=NULL,
              print.covs="only",
              out.file=out.file,
              info.filter=0.3,
              maf.filter=0.005,
              chunk.size=100,
              verbose=TRUE,
              clusterObj=NULL)
```

Now we can run a shell script. This can be used well with manifest files to set up multiple runs with different outcomes and different subsets of samples. We define a manifest file has columns that corresond to the functions that the user wants to pass and each row is a separate analysis that a user may want to run. The covariates are separated by an underscore (`"_"`). This is so it can be passed properly, and also why we used `str_split` to split the covariates.

```
#!/bin/bash
DIRECTORY=/path/to/dir/impute_chr

module load R

R --script ${DIRECTORY}/survival/code/mysurvivalscript.R -q --args \
        vcf.file ${DIRECTORY}/sanger.pbwt_reference_impute.vcf.gz \
        pheno.file ${DIRECTORY}/phenotype_data/simulated_pheno.txt \
        covariates DrugTxYes_age_SexFemale\
        time.to.event time \
        event event \
        out.file ${DIRECTORY}/survival/results/sanger_example_output
```

The file paths above are completely arbitrary and were just used as an example of how file structure may be and where desirable output would be stored.

## 5.2 Batch Example impute2CoxSurv

Exactly the same as for `sangerCoxSurv` but this time with the input arguments for `impute2CoxSurv`. See `?impute2CoxSurv` for help

## 5.3 Batch Example michiganCoxSurv

Exactly the same as for `sangerCoxSurv` but this time with the input arguments for `michiganCoxSurv`. See `?michiganCoxSurv` for help

# Session info

Here is the output of `sessionInfo()` on the system that this document was compiled:

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
## [1] gwasurvivr_1.28.0 knitr_1.50        BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] Rdpack_2.6.4                DBI_1.2.3
##   [3] gdsfmt_1.46.0               bitops_1.0-9
##   [5] sandwich_3.1-1              rlang_1.1.6
##   [7] magrittr_2.0.4              multcomp_1.4-29
##   [9] matrixStats_1.5.0           compiler_4.5.1
##  [11] RSQLite_2.4.3               GenomicFeatures_1.62.0
##  [13] mgcv_1.9-3                  png_0.1-8
##  [15] vctrs_0.6.5                 quantreg_6.1
##  [17] SNPRelate_1.44.0            crayon_1.5.3
##  [19] pkgconfig_2.0.3             shape_1.4.6.1
##  [21] fastmap_1.2.0               backports_1.5.0
##  [23] XVector_0.50.0              Rsamtools_2.26.0
##  [25] rmarkdown_2.30              nloptr_2.2.1
##  [27] GWASTools_1.56.0            MatrixModels_0.5-4
##  [29] purrr_1.1.0                 bit_4.6.0
##  [31] xfun_0.53                   glmnet_4.1-10
##  [33] jomo_2.7-6                  logistf_1.26.1
##  [35] cachem_1.1.0                cigarillo_1.0.0
##  [37] jsonlite_2.0.0              blob_1.2.4
##  [39] DelayedArray_0.36.0         pan_1.9
##  [41] BiocParallel_1.44.0         broom_1.0.10
##  [43] parallel_4.5.1              R6_2.6.1
##  [45] VariantAnnotation_1.56.0    bslib_0.9.0
##  [47] rtracklayer_1.70.0          boot_1.3-32
##  [49] DNAcopy_1.84.0              rpart_4.1.24
##  [51] lmtest_0.9-40               GenomicRanges_1.62.0
##  [53] jquerylib_0.1.4             estimability_1.5.1
##  [55] Rcpp_1.1.0                  Seqinfo_1.0.0
##  [57] bookdown_0.45               SummarizedExperiment_1.40.0
##  [59] iterators_1.0.14            zoo_1.8-14
##  [61] IRanges_2.44.0              Matrix_1.7-4
##  [63] splines_4.5.1               nnet_7.3-20
##  [65] tidyselect_1.2.1            abind_1.4-8
##  [67] yaml_2.3.10                 codetools_0.2-20
##  [69] curl_7.0.0                  lattice_0.22-7
##  [71] tibble_3.3.0                KEGGREST_1.50.0
##  [73] Biobase_2.70.0              quantsmooth_1.76.0
##  [75] coda_0.19-4.1               evaluate_1.0.5
##  [77] survival_3.8-3              Biostrings_2.78.0
##  [79] pillar_1.11.1               BiocManager_1.30.26
##  [81] MatrixGenerics_1.22.0       mice_3.18.0
##  [83] foreach_1.5.2               stats4_4.5.1
##  [85] reformulas_0.4.2            generics_0.1.4
##  [87] RCurl_1.98-1.17             S4Vectors_0.48.0
##  [89] minqa_1.2.8                 xtable_1.8-4
##  [91] GWASExactHW_1.2             RhpcBLASctl_0.23-42
##  [93] glue_1.8.0                  emmeans_2.0.0
##  [95] tools_4.5.1                 BiocIO_1.20.0
##  [97] data.table_1.17.8           lme4_1.1-37
##  [99] SparseM_1.84-2              BSgenome_1.78.0
## [101] GenomicAlignments_1.46.0    XML_3.99-0.19
## [103] mvtnorm_1.3-3               grid_4.5.1
## [105] tidyr_1.3.1                 rbibutils_2.3
## [107] AnnotationDbi_1.72.0        nlme_3.1-168
## [109] formula.tools_1.7.1         restfulr_0.0.16
## [111] cli_3.6.5                   S4Arrays_1.10.0
## [113] dplyr_1.1.4                 sass_0.4.10
## [115] digest_0.6.37               operator.tools_1.6.3
## [117] BiocGenerics_0.56.0         SparseArray_1.10.0
## [119] TH.data_1.1-4               rjson_0.2.23
## [121] memoise_2.0.1               htmltools_0.5.8.1
## [123] lifecycle_1.0.4             httr_1.4.7
## [125] mitml_0.4-5                 bit64_4.6.0-1
## [127] MASS_7.3-65
```

# References

# Appendix

1. Terry M. Therneau and Patricia M. Grambsch (2000). Modeling Survival Data: Extending the Cox Model. Springer, New York. ISBN 0-387-98784-3.
2. Martin Morgan, Valerie Obenchain, Jim Hester and Hervé Pagès (2017). SummarizedExperiment: SummarizedExperiment container. R package version 1.6.3.
3. Gogarten SM, Bhangale T, Conomos MP, Laurie CA, McHugh CP, Painter I, Zheng X, Crosslin DR, Levine D, Lumley T, Nelson SC, Rice K, Shen J, Swarnkar R, Weir BS and Laurie CC (2012). “GWASTools: an R/Bioconductor package for quality control and analysis of genome-wide association studies.” Bioinformatics, 28(24), pp. 3329-3331. doi: 10.1093/bioinformatics/bts610.
4. B. N. Howie, P. Donnelly and J. Marchini (2009) A flexible and accurate genotype imputation method for the next generation of genome-wide association studies. PLoS Genetics 5(6): e1000529
5. Das S, Forer L, Schönherr S, Sidore C, Locke AE, Kwong A, Vrieze S, Chew EY, Levy S, McGue M, Schlessinger D, Stambolian D, Loh PR, Iacono WG, Swaroop A, Scott LJ, Cucca F, Kronenberg F, Boehnke M, Abecasis GR, Fuchsberger C. **Next-generation genotype imputation service and methods.** Nature Genetics 48, 1284–1287 (2016). [27571263](https://www.ncbi.nlm.nih.gov/pubmed/27571263)
6. Efficient haplotype matching and storage using the Positional Burrows-Wheeler Transform (PBWT)", Richard Durbin Bioinformatics 30:1266-72 (2014).