# Genetic Association Testing using the GENESIS Package

Matthew P. Conomos

#### 2025-10-30

# Contents

* [1 Overview](#overview)
* [2 Data](#data)
  + [2.1 Preparing Scan Annotation Data](#preparing-scan-annotation-data)
  + [2.2 Reading in Genotype Data](#reading-in-genotype-data)
    - [2.2.1 R Matrix](#r-matrix)
    - [2.2.2 GDS files](#gds-files)
    - [2.2.3 PLINK files](#plink-files)
  + [2.3 HapMap Data](#hapmap-data)
  + [2.4 Reading in the GRM from PC-Relate](#reading-in-the-grm-from-pc-relate)
* [3 Mixed Model Association Testing](#mixed-model-association-testing)
  + [3.1 Fit the Null Model](#fit-the-null-model)
    - [3.1.1 Quantitative Phenotypes](#quantitative-phenotypes)
    - [3.1.2 Binary Phentoypes](#binary-phentoypes)
  + [3.2 Run SNP-Phenotype Association Tests](#run-snp-phenotype-association-tests)
  + [3.3 Output](#output)
    - [3.3.1 The Null Model](#the-null-model)
    - [3.3.2 The Association Tests](#the-association-tests)
* [4 Heritability Estimation](#heritability-estimation)
* [5 References](#references)
* **Appendix**

# 1 Overview

This vignette provides a description of how to use the *[GENESIS](https://bioconductor.org/packages/3.22/GENESIS)* package to run genetic association tests on array (SNP) data. *[GENESIS](https://bioconductor.org/packages/3.22/GENESIS)* uses mixed models for genetic association testing, as PC-AiR PCs can be used as fixed effect covariates to adjust for population stratification, and a kinship matrix (or genetic relationship matrix) estimated from PC-Relate can be used to account for phenotype correlation due to genetic similarity among samples.

# 2 Data

## 2.1 Preparing Scan Annotation Data

The `fitNullModel` function in the *[GENESIS](https://bioconductor.org/packages/3.22/GENESIS)* package reads sample data from either a standard `data.frame` class object or a `ScanAnnotationDataFrame` class object as created by the *[GWASTools](https://bioconductor.org/packages/3.22/GWASTools)* package. This object must contain all of the outcome and covariate data for all samples to be included in the mixed model analysis. Additionally, this object must include a variable called “scanID” which contains a unique identifier for each sample in the analysis. While a standard `data.frame` can be used, we recommend using a `ScanAnnotationDataFrame` object, as it can be paired with the genotype data (see below) to ensure matching of sample phenotype and genotype data. Through the use of *[GWASTools](https://bioconductor.org/packages/3.22/GWASTools)*, a `ScanAnnotationDataFrame` class object can easily be created from a `data.frame` class object. Example R code for creating a `ScanAnnotationDataFrame` object is presented below. Much more detail can be found in the *[GWASTools](https://bioconductor.org/packages/3.22/GWASTools)* package reference manual.

```
# mypcair contains PCs from a previous PC-AiR analysis
# pheno is a vector of Phenotype values

# make a data.frame
mydat <- data.frame(scanID = mypcair$sample.id, pc1 = mypcair$vectors[,1],
                    pheno = pheno)
head(mydat)
```

```
##          scanID         pc1      pheno
## NA19919 NA19919 -0.12494973  0.1917649
## NA19916 NA19916 -0.13189955 -0.5688725
## NA19835 NA19835 -0.08817987  0.8735087
## NA20282 NA20282 -0.08752413  0.5784758
## NA19703 NA19703 -0.12130589  1.6113568
## NA19902 NA19902 -0.11357612  0.6665602
```

```
# make ScanAnnotationDataFrame
scanAnnot <- ScanAnnotationDataFrame(mydat)
scanAnnot
```

```
## An object of class 'ScanAnnotationDataFrame'
##   scans: NA19919 NA19916 ... NA19764 (173 total)
##   varLabels: scanID pc1 pheno
##   varMetadata: labelDescription
```

## 2.2 Reading in Genotype Data

The `assocTestSingle` function in the *[GENESIS](https://bioconductor.org/packages/3.22/GENESIS)* package reads genotype data from a `GenotypeData` class object as created by the *[GWASTools](https://bioconductor.org/packages/3.22/GWASTools)* package. Through the use of *[GWASTools](https://bioconductor.org/packages/3.22/GWASTools)*, a `GenotypeData` class object can easily be created from:

* an R matrix of SNP genotype data
* a GDS file
* PLINK files

Example R code for creating a `GenotypeData` object is presented below. Much more detail can be found in the *[GWASTools](https://bioconductor.org/packages/3.22/GWASTools)* package reference manual.

### 2.2.1 R Matrix

```
geno <- MatrixGenotypeReader(genotype = genotype, snpID = snpID,
                             chromosome = chromosome, position = position,
                             scanID = scanID)
genoData <- GenotypeData(geno)
```

* `genotype` is a matrix of genotype values coded as 0 / 1 / 2, where rows index SNPs and columns index samples
* `snpID` is an integer vector of unique SNP IDs
* `chromosome` is an integer vector specifying the chromosome of each SNP
* `position` is an integer vector specifying the position of each SNP
* `scanID` is a vector of unique individual IDs

### 2.2.2 GDS files

```
geno <- GdsGenotypeReader(filename = "genotype.gds")
genoData <- GenotypeData(geno)
```

* `filename` is the file path to the GDS object

### 2.2.3 PLINK files

The *[SNPRelate](https://bioconductor.org/packages/3.22/SNPRelate)* package provides the `snpgdsBED2GDS` function to convert binary PLINK files into a GDS file.

```
snpgdsBED2GDS(bed.fn = "genotype.bed",
              bim.fn = "genotype.bim",
              fam.fn = "genotype.fam",
              out.gdsfn = "genotype.gds")
```

* `bed.fn` is the file path to the PLINK .bed file
* `bim.fn` is the file path to the PLINK .bim file
* `fam.fn` is the file path to the PLINK .fam file
* `out.gdsfn` is the file path for the output GDS file

Once the PLINK files have been converted to a GDS file, then a `GenotypeData` object can be created as described above.

## 2.3 HapMap Data

To demonstrate association testing with the *[GENESIS](https://bioconductor.org/packages/3.22/GENESIS)* package, we analyze SNP data from the Mexican Americans in Los Angeles, California (MXL) and African American individuals in the southwestern USA (ASW) population samples of HapMap 3. Mexican Americans and African Americans have a diverse ancestral background, and familial relatives are present in these data. Genotype data at a subset of 20K autosomal SNPs for 173 individuals are provided as a GDS file.

```
# read in GDS data
gdsfile <- system.file("extdata", "HapMap_ASW_MXL_geno.gds", package="GENESIS")
HapMap_geno <- GdsGenotypeReader(filename = gdsfile)
```

```
# create a GenotypeData class object with paired ScanAnnotationDataFrame
HapMap_genoData <- GenotypeData(HapMap_geno, scanAnnot = scanAnnot)
HapMap_genoData
```

```
## An object of class GenotypeData
##  | data:
## File: /tmp/RtmpVbtNG8/Rinst96ae5430f0d61/GENESIS/extdata/HapMap_ASW_MXL_geno.gds (901.8K)
## +    [  ] *
## |--+ sample.id   { Int32,factor 173 ZIP(40.9%), 283B } *
## |--+ snp.id   { Int32 20000 ZIP(34.6%), 27.1K }
## |--+ snp.position   { Int32 20000 ZIP(34.6%), 27.1K }
## |--+ snp.chromosome   { Int32 20000 ZIP(0.13%), 103B }
## \--+ genotype   { Bit2 20000x173, 844.7K } *
##  | SNP Annotation:
## NULL
##  | Scan Annotation:
## An object of class 'ScanAnnotationDataFrame'
##   scans: NA19919 NA19916 ... NA19764 (173 total)
##   varLabels: scanID pc1 pheno
##   varMetadata: labelDescription
```

## 2.4 Reading in the GRM from PC-Relate

A mixed model for genetic association testing typically includes a genetic relationship matrix (GRM) to account for genetic similarity among sample individuals. If we are using kinship coefficient estimates from PC-Relate to construct this GRM, then the function `pcrelateToMatrix` should be used to provide the matrix in the appropriate format for `fitNullModel`.

```
# mypcrel contains Kinship Estimates from a previous PC-Relate analysis
myGRM <- pcrelateToMatrix(mypcrel)
myGRM[1:5,1:5]
```

```
## 5 x 5 Matrix of class "dsyMatrix"
##               NA19625      NA19649      NA19650      NA19651       NA19652
## NA19625  0.9802700234 -0.001203139 -0.001421550 -0.008106978  0.0003847439
## NA19649 -0.0012031394  1.041215459  0.569824603  0.004914127 -0.0128737567
## NA19650 -0.0014215499  0.569824603  1.053721139  0.006963955  0.0145901433
## NA19651 -0.0081069777  0.004914127  0.006963955  1.011778815  0.0093444310
## NA19652  0.0003847439 -0.012873757  0.014590143  0.009344431  0.9830241834
```

Note that both the row and column names of this matrix are the same scanIDs as used in the scan annotation data.

# 3 Mixed Model Association Testing

There are two steps to performing genetic association testing with *[GENESIS](https://bioconductor.org/packages/3.22/GENESIS)*. First, the null model (i.e. the model with no SNP genotype term) is fit using the `fitNullModel` function. Second, the output of the null model fit is used in conjunction with the genotype data to quickly run SNP-phenotype association tests using the `assocTestSingle` function. There is a computational advantage to splitting these two steps into two function calls; the null model only needs to be fit once, and SNP association tests can be paralelized by chromosome or some other partitioning to speed up analyses (details below).

## 3.1 Fit the Null Model

The first step for association testing with *[GENESIS](https://bioconductor.org/packages/3.22/GENESIS)* is to fit the mixed model under the null hypothesis that each SNP has no effect. This null model contains all of the covariates, including ancestry representative PCs, as well as any random effects, such as a polygenic effect due to genetic relatedness, but it does not include any SNP genotype terms as fixed effects.

Using the `fitNullModel` function, random effects in the null model are specified via their covariance structures. This allows for the inclusion of a polygenic random effect using a kinship matrix or genetic relationship matrix (GRM).

### 3.1.1 Quantitative Phenotypes

A linear mixed model (LMM) should be fit when analyzing a quantitative phenotype. The example R code below fits a basic null mixed model.

```
# fit the null mixed model
nullmod <- fitNullModel(scanAnnot, outcome = "pheno", covars = "pc1",
                        cov.mat = myGRM, family = "gaussian")
```

```
## [1]    0.4545276    0.4545276 -240.5782603    1.0923208
## [1]    0.07914947    0.76999944 -237.49261995    1.07518867
## [1]    0.09956112    0.80948611 -237.48705339    1.00502586
## [1]    0.1003705    0.8132376 -237.4870516    1.0000251
```

* the first argument is the class `ScanAnnotationDataFrame` or `data.frame` object containing the sample data
* `outcome` specifies the name of the outcome variable in `scanAnnot`
* `covars` specifies the names of the covariates in `scanAnnot`
* `cov.mat` specifies the covariance structures for the random effects included in the model
* `family` should be gaussian for a quantitative phenotype, specifying a linear mixed model

The Average Information REML (AIREML) procedure is used to estimate the variance components of the random effects. When `verbose = TRUE`, the variance component estimates, the log-likelihood, and the residual sum of squares in each iteration are printed to the R console (shown above). In this example, `Sigma^2_A` is the variance component for the random effect specified in `cov.mat`, and `Sigma^2_E` is the residual variance component.

#### 3.1.1.1 Multiple Fixed Effect Covariates

The model can be fit with multiple fixed effect covariates by setting `covars` equal to vector of covariate names. For example, if we wanted to include the variables “pc1”, “pc2”, “sex”, and “age” all as covariates in the model:

```
nullmod <- fitNullModel(scanAnnot, outcome = "pheno",
                        covars = c("pc1","pc2","sex","age"),
                        cov.mat = myGRM, family = "gaussian")
```

#### 3.1.1.2 Multiple Random Effects

The model also can be fit with multiple random effects. This is done by setting `cov.mat` equal to a list of matrices. For example, if we wanted to include a polygenic random effect with covariance structure given by the matrix “myGRM” and a household random effect with covariance structure specified by the matrix “H”:

```
nullmod <- fitNullModel(scanAnnot, outcome = "pheno", covars = "pc1",
                        cov.mat = list("GRM" = myGRM, "House" = H),
                        family = "gaussian")
```

The names of the matrices in `cov.mat` determine the names of the variance component parameters. Therefore, in this example, the output printed to the R console will include `Sigma^2_GRM` for the random effect specified by “myGRM”, `Sigma^2_House` for the random effect specified by “H”, and `Sigma^2_E` for the residual variance component.

Note: the row and column names of each matrix used to specify the covariance structure of a random effect in the mixed model must be the unique scanIDs for each sample in the analysis.

#### 3.1.1.3 Heterogeneous Residual Variances

LMMs are typically fit under an assumption of constant (homogeneous) residual variance for all observations. However, for some outcomes, there may be evidence that different groups of observations have different residual variances, in which case the assumption of homoscedasticity is violated. `group.var` can be used in order to fit separate (heterogeneous) residual variance components by some grouping variable. For example, if we have a categorical variable “study” in our `scanAnnot`, then we can estimate a different residual variance component for each unique value of “study” by using the following code:

```
nullmod <- fitNullModel(scanAnnot, outcome = "pheno", covars = "pc1",
                        cov.mat = myGRM, family = "gaussian",
                        group.var = "study")
```

In this example, the residual variance component `Sigma^2_E` is replaced with group specific residual variance components `Sigma^2_study1`, `Sigma^2_study2`, …, where “study1”, “study2”, … are the unique values of the “study” variable.

### 3.1.2 Binary Phentoypes

Ideally, a generalized linear mixed model (GLMM) would be fit for a binary phenotype; however, fitting a GLMM is much more computationally demanding than fitting an LMM. To provide a compuationally efficient approach to fitting such a model, `fitNullModel` uses the penalized quasi-likelihood (PQL) approximation to the GLMM (Breslow and Clayton). The implementation of this procedure in *[GENESIS](https://bioconductor.org/packages/3.22/GENESIS)* is the same as in GMMAT (Chen et al.), and more details can be found in that manuscript. If our outcome variable, “pheno”, were binary, then the same R code could be used to fit the null model, but with `family = binomial`.

```
nullmod <- fitNullModel(scanAnnot, outcome = "pheno", covars = "pc1",
                        cov.mat = myGRM, family = "binomial")
```

Multiple fixed effect covariates and multiple random effects can be specified for binary phenotypes in the same way as they are for quantitative phenotypes. `group.var` does not apply here.

## 3.2 Run SNP-Phenotype Association Tests

The second step for association testing with *[GENESIS](https://bioconductor.org/packages/3.22/GENESIS)* is to use the fitted null model to test the SNPs in the `GenotypeData` object for association with the specified outcome variable. This is done with the `assocTestSingle` function. The use of `assocTestSingle` for running association tests with a quantitative or binary phenotype is identical.

Before we can run an association test on a `GenotypeData` object, we much first decide how many SNPs we want to read at a time. We do this by creating a `GenotypeBlockIterator` object that defines blocks of SNPs. The default setting is to read 10,000 SNPs in each block, but this may be changed with the `snpBlock` argument.

```
genoIterator <- GenotypeBlockIterator(HapMap_genoData, snpBlock=5000)
```

The example R code below runs the association analyses using the null model we fit using `fitNullModel` in the previous section.

```
assoc <- assocTestSingle(genoIterator, null.model = nullmod,
                         BPPARAM = BiocParallel::SerialParam())
```

* `genoData` is a `GenotypeData` class object
* `null.model` is the output from `fitNullModel`

By default, the function will perform association tests at all SNPs in the `genoData` object. However, for computational reasons it may be practical to parallelize this step, partitioning SNPs by chromosome or some other pre-selected grouping. If we only want to test a pre-specified set of SNPs, this can be done by passing a vector of snpID values to the `snpInclude` argument when we create the iterator.

```
# mysnps is a vector of snpID values for the SNPs we want to test
genoIterator <- GenotypeBlockIterator(HapMap_genoData, snpInclude=mysnps)
assoc <- assocTestSingle(genoIterator, null.model = nullmod)
```

## 3.3 Output

### 3.3.1 The Null Model

The `fitNullModel` function will return a list with a large amount of data. Some of the more useful output for the user includes:

* `varComp`: the variance component estimates for the random effects
* `fixef`: a `data.frame` with point estimates, standard errors, test statistics, and p-values for each of the fixed effect covariates
* `fit`: a `data.frame` with the outcome, the fitted values, and various residuals from the model

There are also metrics assessing model fit such as the log-likelihood (`logLik`), restricted log-likelihood (`logLikR`), and the Akaike information criterion (`AIC`). Additionally, there are some objects such as the working outcome vector (`workingY`) and the Cholesky decomposition of the inverse of the estimated phenotype covariance matrix (`cholSigmaInv`) that are used by the `assocTestSingle` function for association testing. Further details describing all of the output can be found with the command `help(fitNullModel)`.

### 3.3.2 The Association Tests

The `assocTestSingle` function will return a `data.frame` with summary information from the association test for each SNP. Each row corresponds to a different SNP.

```
head(assoc)
```

```
##   variant.id chr pos n.obs      freq MAC     Score Score.SE Score.Stat
## 1          1   1   1   173 0.3901734 135  1.180707 8.675574  0.1360955
## 2          2   1   2   173 0.4942197 171 -6.933808 9.151961 -0.7576309
## 3          3   1   3   173 0.1011561  35 -1.403564 5.439172 -0.2580474
## 4          4   1   4   173 0.4855491 168 -7.178855 9.427487 -0.7614813
## 5          5   1   5   172 0.4447674 153  7.284553 8.701407  0.8371695
## 6          6   1   6   172 0.2093023  72 10.374277 7.376141  1.4064641
##   Score.pval         Est    Est.SE          PVE
## 1  0.8917458  0.01568721 0.1152661 0.0001083131
## 2  0.4486720 -0.08278346 0.1092662 0.0033566681
## 3  0.7963703 -0.04744240 0.1838515 0.0003893964
## 4  0.4463696 -0.08077246 0.1060728 0.0033908730
## 5  0.4024973  0.09621082 0.1149239 0.0040984515
## 6  0.1595864  0.19067750 0.1355723 0.0115677875
```

* `variant.id`: the unique snp ID
* `chr`: the chromosome
* `pos`: the position
* `n.obs`: the number of samples analyzed at that SNP
* `freq`: the frequency of the tested (“A”) allele
* `MAC`: the minor allele count
* `Score`: the value of the score function
* `Score.SE`: the estimated standard error of the score
* `Score.Stat`: the score Z test statistic
* `Score.pval`: the p-value based on the score test statistic
* `Est`: an approximation of the effect size estimate (beta) for that SNP
* `Est.SE`: an approximation of the standard error of the effect size estimate
* `PVE`: an approximation of the proportion of phenotype variance explained

Further details describing all of the output can be found with the command `help(assocTestSingle)`.

# 4 Heritability Estimation

It is often of interest to estimate the proportion of the total phenotype variability explained by the entire set of genotyped SNPs avaialable; this provides an estimate of the narrow sense heritability of the trait. One method for estimating heritability is to use the variance component estimates from the null mixed model. *[GENESIS](https://bioconductor.org/packages/3.22/GENESIS)* includes the `varCompCI` function for computing the proportion of variance explained by each random effect along with 95% confidence intervals.

```
varCompCI(nullmod, prop = TRUE)
```

```
##             Proportion   Lower 95  Upper 95
## V_A          0.1098617 -0.2198243 0.4395477
## V_resid.var  0.8901383  0.5604523 1.2198243
```

* the first argument is the output from `fitNullModel`
* `prop` is a logical indicator of whether the point estimates and confidence intervals should be returned as the proportion of total variability explained (TRUE) or on the orginal scale (FALSE)

When additional random effects are included in the model (e.g. a shared household effect), `varCompCI` will also return the proportion of variability explained by each of these components.

Note: `varCompCI` can not compute proportions of variance explained when heterogeneous residual variances are used in the null model (i.e. `group.var` is used in `fitNullModel`). Confidence intervals can still be computed for the variance component estimates on the original scale by setting `prop = FALSE`.

Note: variance component estimates are not interpretable for binary phenotypes when fit using the PQL method implemented in `fitNullModel`; proportions of variance explained should not be calculated for these models.

# 5 References

# Appendix

* Breslow NE and Clayton DG. (1993). Approximate Inference in Generalized Linear Mixed Models. Journal of the American Statistical Association 88: 9-25.
* Chen H, Wang C, Conomos MP, Stilp AM, Li Z, Sofer T, Szpiro AA, Chen W, Brehm JM, Celedon JC, Redline S, Papanicolaou GJ, Thornton TA, Laurie CC, Rice K and Lin X. Control for Population Structure and Relatedness for Binary Traits in Genetic Association Studies Using Logistic Mixed Models. American Journal of Human Genetics, 98(4):653-66.
* Gogarten, S.M., Bhangale, T., Conomos, M.P., Laurie, C.A., McHugh, C.P., Painter, I., … & Laurie, C.C. (2012). GWASTools: an R/Bioconductor package for quality control and analysis of Genome-Wide Association Studies. Bioinformatics, 28(24), 3329-3331.