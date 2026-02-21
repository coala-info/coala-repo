# Population Structure and Relatedness Inference using the GENESIS Package

Matthew P. Conomos

#### 2025-10-30

# Contents

* [1 Overview](#overview)
  + [1.1 Principal Components Analysis in Related Samples (PC-AiR)](#principal-components-analysis-in-related-samples-pc-air)
  + [1.2 Relatedness Estimation Adjusted for Principal Components (PC-Relate)](#relatedness-estimation-adjusted-for-principal-components-pc-relate)
* [2 Data](#data)
  + [2.1 Reading in Genotype Data](#reading-in-genotype-data)
    - [2.1.1 R Matrix](#r-matrix)
    - [2.1.2 GDS files](#gds-files)
    - [2.1.3 PLINK files](#plink-files)
  + [2.2 HapMap Data](#hapmap-data)
* [3 Principal Components Analysis in Related Samples (PC-AiR)](#principal-components-analysis-in-related-samples-pc-air-1)
  + [3.1 LD pruning](#ld-pruning)
  + [3.2 Pairwise Measures of Ancestry Divergence](#pairwise-measures-of-ancestry-divergence)
  + [3.3 Running PC-AiR](#running-pc-air)
    - [3.3.1 Reference Population Samples](#reference-population-samples)
    - [3.3.2 Partition a Sample without Running PCA](#partition-a-sample-without-running-pca)
  + [3.4 Output from PC-AiR](#output-from-pc-air)
    - [3.4.1 Plotting PC-AiR PCs](#plotting-pc-air-pcs)
* [4 Relatedness Estimation Adjusted for Principal Components (PC-Relate)](#relatedness-estimation-adjusted-for-principal-components-pc-relate-1)
  + [4.1 Running PC-Relate](#running-pc-relate)
  + [4.2 Output from PC-Relate](#output-from-pc-relate)
* [5 References](#references)
* **Appendix**

# 1 Overview

*[GENESIS](https://bioconductor.org/packages/3.22/GENESIS)* provides statistical methodology for analyzing genetic data from samples with population structure and/or familial relatedness. This vignette provides a description of how to use *[GENESIS](https://bioconductor.org/packages/3.22/GENESIS)* for inferring population structure, as well as estimating relatedness measures such as kinship coefficients, identity by descent (IBD) sharing probabilities, and inbreeding coefficients. *[GENESIS](https://bioconductor.org/packages/3.22/GENESIS)* uses PC-AiR for population structure inference that is robust to known or cryptic relatedness, and it uses PC-Relate for accurate relatedness estimation in the presence of population structure, admixutre, and departures from Hardy-Weinberg equilibrium.

## 1.1 Principal Components Analysis in Related Samples (PC-AiR)

Principal Components Analysis (PCA) is commonly applied to genome-wide SNP genotype data from samples in genetic studies for population structure (i.e. ancestry) inference. PCA takes genotype values at hundreds of thousands of SNPs as input and performs a dimension reduction to principal components (PCs) that best reflect the variability of the data. Typically the top PCs calculated from the genotype data reflect population structure among the sample individuals. However, when a sample contains familial relatives, either known or unknown (cryptic), the top PCs obtained from a standard PCA are often confounded by this family structure and reflect clusters of close relatives.

The PC-AiR method is used to perform a PCA for the detection of population structure that is robust to possible familial relatives in the sample. Unlike a standard PCA, PC-AiR accounts for relatedness (known or cryptic) in the sample and identifies PCs that accurately capture population structure and not family structure. In order to accomplish this, PC-AiR uses measures of pairwise relatedness (kinship coefficients) and measures of pairwise ancestry divergence to identify an ancestry representative subset of mutually unrelated individuals. A standard PCA is performed on this “unrelated subset” of individuals, and PC values for the excluded “related subset” of indivdiuals are predicted from genetic similarity.

## 1.2 Relatedness Estimation Adjusted for Principal Components (PC-Relate)

Many estimators exist that use genome-wide SNP genotype data from samples in genetic studies to estimate measures of recent genetic relatedness such as pairwise kinship coefficients, pairwise IBD sharing probabilities, and individual inbreeding coefficients. However, many of these estimators either make simplifying assumptions that do not hold in the presence of population structure and/or ancestry admixture, or they require reference population panels of known ancestry from pre-specified populations. When assumptions are violated, these estimators can provide highly biased estimates.

The PC-Relate method is used to accurately estimate measures of recent genetic relatedness in samples with unknown or unspecified population structure without requiring reference population panels. PC-Relate uses ancestry representative principal components to account for sample ancestry differences and provide estimates that are robust to population structure, ancestry admixture, and departures from Hardy-Weinberg equilibirum.

# 2 Data

## 2.1 Reading in Genotype Data

The functions in the *[GENESIS](https://bioconductor.org/packages/3.22/GENESIS)* package can read genotype data from a `GenotypeData` class object as created by the *[GWASTools](https://bioconductor.org/packages/3.22/GWASTools)* package. Through the use of *[GWASTools](https://bioconductor.org/packages/3.22/GWASTools)*, a `GenotypeData` class object can easily be created from:

* an R matrix of SNP genotype data
* a GDS file
* PLINK files

Example R code for creating a `GenotypeData` object is presented below. Much more detail can be found in the *[GWASTools](https://bioconductor.org/packages/3.22/GWASTools)* package reference manual.

*[GENESIS](https://bioconductor.org/packages/3.22/GENESIS)* can also work with genotype data from sequencing, starting with a VCF file. For examples using this format, see the vignette “Analyzing Sequence Data using the *[GENESIS](https://bioconductor.org/packages/3.22/GENESIS)* Package”.

### 2.1.1 R Matrix

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

### 2.1.2 GDS files

```
geno <- GdsGenotypeReader(filename = "genotype.gds")
genoData <- GenotypeData(geno)
```

* `filename` is the file path to the GDS object

### 2.1.3 PLINK files

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

## 2.2 HapMap Data

To demonstrate PC-AiR and PC-Relate analyses with the *[GENESIS](https://bioconductor.org/packages/3.22/GENESIS)* package, we analyze SNP data from the Mexican Americans in Los Angeles, California (MXL) and African American individuals in the southwestern USA (ASW) population samples of HapMap 3. Mexican Americans and African Americans have a diverse ancestral background, and familial relatives are present in these data. Genotype data at a subset of 20K autosomal SNPs for 173 individuals are provided as a GDS file.

```
gdsfile <- system.file("extdata", "HapMap_ASW_MXL_geno.gds", package="GENESIS")
```

# 3 Principal Components Analysis in Related Samples (PC-AiR)

## 3.1 LD pruning

Before running PCA, we use LD pruning to select a set of independent SNPs for analysis. We use the `snpgdsLDpruning` in the *[SNPRelate](https://bioconductor.org/packages/3.22/SNPRelate)* package, which returns a list of snp IDs.

```
library(SNPRelate)
# read in GDS data
gds <- snpgdsOpen(gdsfile)
snpset <- snpgdsLDpruning(gds, method="corr", slide.max.bp=10e6,
                          ld.threshold=sqrt(0.1), verbose=FALSE)
pruned <- unlist(snpset, use.names=FALSE)
length(pruned)
```

```
## [1] 3655
```

```
head(pruned)
```

```
## [1]  6  7 10 13 28 32
```

```
snpgdsClose(gds)
```

## 3.2 Pairwise Measures of Ancestry Divergence

It is possible to identify a subset of mutually unrelated individuals in a sample based solely on pairwise measures of genetic relatedness (i.e. kinship coefficients). However, in order to obtain accurate population structure inference for the entire sample, it is important that the ancestries of all individuals in the sample are represented by at least one individual in this subset. In order to identify a mutually unrelated and ancestry representative subset of individuals, PC-AiR also utilizes measures of ancestry divergence. These measures are calculated using the KING-robust kinship coefficient estimator (Manichaikul et al., 2010), which provides systematically negative estimates for unrelated pairs of individuals with different ancestry. The number of negative pairwise estimates that an individual has provides information regarding how different that individual’s ancestry is from the rest of the sample, which helps to prioritize individuals that should be kept in the ancestry representative subset.

The relevant output from the KING software is two text files with the file extensions .kin0 and .kin. The `kingToMatrix` function can be used to extract the kinship coefficients (which we use as divergence measures) from this output and create a matrix usable by the `*[GENESIS](https://bioconductor.org/packages/3.22/GENESIS)*` functions.

```
# create matrix of KING estimates
library(GENESIS)
KINGmat <- kingToMatrix(
    c(system.file("extdata", "MXL_ASW.kin0", package="GENESIS"),
      system.file("extdata", "MXL_ASW.kin", package="GENESIS")),
      estimator = "Kinship")
KINGmat[1:5,1:5]
```

```
## 5 x 5 Matrix of class "dsyMatrix"
##         NA19625 NA19649 NA19650 NA19651 NA19652
## NA19625  0.5000 -0.0761 -0.0656 -0.0497 -0.0486
## NA19649 -0.0761  0.5000  0.2513 -0.0187 -0.0141
## NA19650 -0.0656  0.2513  0.5000 -0.0037 -0.0033
## NA19651 -0.0497 -0.0187 -0.0037  0.5000  0.0112
## NA19652 -0.0486 -0.0141 -0.0033  0.0112  0.5000
```

The column and row names of the matrix are the individual IDs, and each off-diagonal entry is the KING-robust estimate for the specified pair of individuals.

Alternative to running the KING software, the `snpgdsIBDKING` function from the *[SNPRelate](https://bioconductor.org/packages/3.22/SNPRelate)* package can be used to calculate the KING-robust estimates directly from a GDS file. The ouput of this function contains a matrix of pairwise estimates, which can be used by the *[GENESIS](https://bioconductor.org/packages/3.22/GENESIS)* functions.

## 3.3 Running PC-AiR

The PC-AiR algorithm requires pairwise measures of both kinship and ancestry divergence in order to partition the sample into an “unrelated subset” and a “related subset.” The kinship coefficient estimates are used to identify relatives, as only one individual from a set of relatives can be included in the “unrelated subset,” and the rest must be assigned to the “related subset.” The ancestry divergence measures calculated from KING-robust are used to help select which individual from a set of relatives has the most unique ancestry and should be given priority for inclusion in the “unrelated subset.”

The KING-robust estimates read in above are always used as measures of ancestry divergence for unrelated pairs of individuals, but they can also be used as measures of kinship for relatives (NOTE: they may be biased measures of kinship for admixed relatives with different ancestry). The `pcair` function performs the PC-AiR analysis.

We use the *[GWASTools](https://bioconductor.org/packages/3.22/GWASTools)* package to create the GenotypeData object needed by *[GENESIS](https://bioconductor.org/packages/3.22/GENESIS)*.

```
library(GWASTools)
HapMap_geno <- GdsGenotypeReader(filename = gdsfile)
# create a GenotypeData class object
HapMap_genoData <- GenotypeData(HapMap_geno)
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
## NULL
```

```
# run PC-AiR on pruned SNPs
mypcair <- pcair(HapMap_genoData, kinobj = KINGmat, divobj = KINGmat,
                 snp.include = pruned)
```

```
## Principal Component Analysis (PCA) on genotypes:
## Excluding 16,345 SNPs (non-autosomes or non-selection)
## Excluding 478 SNPs (monomorphic: TRUE, MAF: NaN, missing rate: 0.01)
##     # of samples: 97
##     # of SNPs: 3,177
##     using 1 thread/core
##     # of principal components: 32
## PCA:    the sum of all selected genotypes (0,1,2) = 157260
## CPU capabilities: Double-Precision SSE2
## 2025-10-30 00:08:23    (internal increment: 32048)
##
[..................................................]  0%, ETC: ---
[==================================================] 100%, completed, 0s
## 2025-10-30 00:08:23    Begin (eigenvalues and eigenvectors)
## 2025-10-30 00:08:23    Done.
```

```
## SNP Loading:
##     # of samples: 97
##     # of SNPs: 3,177
##     using 1 thread/core
##     using the top 32 eigenvectors
## SNP Loading:    the sum of all selected genotypes (0,1,2) = 157260
## 2025-10-30 00:08:23    (internal increment: 65536)
##
[..................................................]  0%, ETC: ---
[==================================================] 100%, completed, 0s
## 2025-10-30 00:08:23    Done.
## Sample Loading:
##     # of samples: 76
##     # of SNPs: 3,177
##     using 1 thread/core
##     using the top 32 eigenvectors
## Sample Loading:    the sum of all selected genotypes (0,1,2) = 122656
## 2025-10-30 00:08:23    (internal increment: 65536)
##
[..................................................]  0%, ETC: ---
[==================================================] 100%, completed, 0s
## 2025-10-30 00:08:23    Done.
```

* `genoData` is a `GenotypeData` class object
* `kinobj` is a matrix of pairwise kinship coefficient estimates
* `divobj` is a matrix of pairwise measures of ancestry divergence (KING-robust estimates)
* `snp.include` is a vector of snp IDs

If better estimates of kinship coefficients are available, then the `kinobj` input can be replaced with a similar matrix of these estimates. The `divobj` input should always remain as the KING-robust estimates.

### 3.3.1 Reference Population Samples

As PCA is an unsupervised method, it is often difficult to identify what population structure each of the top PCs represents. In order to provide some understanding of the inferred structure, it is sometimes recommended to include reference population samples of known ancestry in the analysis. If the data set contains such reference population samples, we may want to make sure that these reference population samples are included in the “unrelated subset.” This can be accomplished by setting the input `unrel.set` equal to a vector, `IDs`, of the individual IDs for the reference population samples.

```
mypcair <- pcair(HapMap_genoData, kinobj = KINGmat, divobj = KINGmat,
                 snp.include = pruned, unrel.set = IDs)
```

This will force individuals specified with `unrel.set` into the “unrelated subset,” move any of their relatives into the “related subset,” and then perform the PC-AiR partitioning algorithm on the remaining samples.

### 3.3.2 Partition a Sample without Running PCA

It may be of interest to partition a sample into an ancestry representative “unrelated subset” of individuals and a “related subset” of individuals without performing a PCA. The `pcairPartition` function, which is called within the `pcair` function, enables the user to do this.

```
part <- pcairPartition(kinobj = KINGmat, divobj = KINGmat)
```

The output contains two vectors that give the individual IDs for the “unrelated subset” and the “related subset.”

```
head(part$unrels); head(part$rels)
```

```
## [1] "NA19708" "NA19711" "NA19712" "NA19737" "NA19740" "NA19741"
```

```
## [1] "NA19686" "NA20346" "NA20345" "NA20347" "NA19664" "NA19677"
```

As with the `pcair` function, the input `unrel.set` can be used to specify certain individuals that must be part of the “unrelated subset.”

## 3.4 Output from PC-AiR

An object returned from the `pcair` function has class `pcair`. A `summary` method for an object of class `pcair` is provided to obtain a quick overview of the results.

```
summary(mypcair)
```

```
## Call:
## .pcair(gdsobj = gdsobj, kinobj = kinobj, divobj = divobj, kin.thresh = kin.thresh,
##     div.thresh = div.thresh, unrel.set = unrel.set, sample.include = sample.include,
##     snp.include = snp.include, num.cores = num.cores, verbose = verbose)
##
## PCA Method: PC-AiR
##
## Sample Size: 173
## Unrelated Set: 97 Samples
## Related Set: 76 Samples
##
## Kinship Threshold: 0.02209709
## Divergence Threshold: -0.02209709
##
## Principal Components Returned: 32
## Eigenvalues: 3.018 1.729 1.34 1.316 1.293 1.29 1.276 1.269 1.245 1.238 ...
## SNPs Used: 3177
```

The output provides the total sample size along with the number of individuals assigned to the unrelated and related subsets, as well as the threshold values used for determining which pairs of individuals were related or ancestrally divergent. The eigenvalues for the top PCs are also shown, which can assist in determining the number of PCs that reflect structure. The minor allele frequency (MAF) filter used for excluding SNPs is also specified, along with the total number of SNPs analyzed after this filtering. Details describing how to modify the analysis parameters and the available output of the function can be found with the command `help(pcair)`.

### 3.4.1 Plotting PC-AiR PCs

The *[GENESIS](https://bioconductor.org/packages/3.22/GENESIS)* package also provides a `plot` method for an object of class `pcair` to quickly visualize pairs of PCs. Each point in one of these PC pairs plots represents a sample individual. These plots help to visualize population structure in the sample and identify clusters of individuals with similar ancestry.

```
# plot top 2 PCs
plot(mypcair)
# plot PCs 3 and 4
plot(mypcair, vx = 3, vy = 4)
```

![](data:image/png;base64...)![](data:image/png;base64...)

The default is to plot PC values as black dots and blue pluses for individuals in the “unrelated subset” and “related subsets” respectively. The plotting colors and characters, as well as other standard plotting parameters, can be changed with the standard input to the `plot` function.

# 4 Relatedness Estimation Adjusted for Principal Components (PC-Relate)

## 4.1 Running PC-Relate

PC-Relate uses the ancestry representative principal components (PCs) calculated from PC-AiR to adjust for the population structure and ancestry of individuals in the sample and provide accurate estimates of recent genetic relatedness due to family structure. The `pcrelate` function performs the PC-Relate analysis.

The `training.set` input of the `pcrelate` function allows for the specification of which samples are used to estimate the ancestry adjustment at each SNP. The adjustment tends to perform best when close relatives are excluded from `training.set`, so the individuals in the “unrelated subset” from the PC-AiR analysis are typically a good choice. However, when an “unrelated subset” is not available, the adjustment still works well when estimated using all samples (`training.set = NULL`).

In order to run PC-Relate, we first need to create an iterator object to read SNPs in blocks. We create the iterator such that only pruned SNPs are returned in each block.

```
# run PC-Relate
HapMap_genoData <- GenotypeBlockIterator(HapMap_genoData, snpInclude=pruned)
mypcrelate <- pcrelate(HapMap_genoData, pcs = mypcair$vectors[,1:2],
                       training.set = mypcair$unrels,
                       BPPARAM = BiocParallel::SerialParam())
```

* `genoData` is a `GenotypeIterator` class object
* `pcs` is a matrix whose columns are the PCs used for the ancestry adjustment
* `training.set` is a vector of individual IDs specifying which samples are used to esimate the ancestry adjustment at each SNP

If estimates of IBD sharing probabilities are not desired, then setting the input `ibd.probs = FALSE` will speed up the computation.

## 4.2 Output from PC-Relate

The `pcrelate` function will return an object of class `pcrelate`, which is a list of two data.frames: `kinBtwn` with pairwise kinship values, and `kinSelf` with inbreeding coefficients.

```
plot(mypcrelate$kinBtwn$k0, mypcrelate$kinBtwn$kin, xlab="k0", ylab="kinship")
```

![](data:image/png;base64...)

A function is provided for making a genetic relationship matrix (GRM). Using a threshold for kinship will create a sparse matrix by setting kinship for pairs less than the threshold to 0. This can be useful to reduce memory usage for very large sample sizes.

```
iids <- as.character(getScanID(HapMap_genoData))
pcrelateToMatrix(mypcrelate, sample.include = iids[1:5], thresh = 2^(-11/2), scaleKin = 2)
```

```
## 5 x 5 sparse Matrix of class "dsCMatrix"
##             NA19835    NA19916     NA19919   NA19703   NA20282
## NA19835  0.97142031 0.03207052 -0.03115029 .         .
## NA19916  0.03207052 1.01892951  0.02693604 .         .
## NA19919 -0.03115029 0.02693604  0.98123343 .         .
## NA19703  .          .           .          0.9861918 0.0260987
## NA20282  .          .           .          0.0260987 0.9357145
```

* `pcrelobj` is the output from `pcrelate`; either a class `pcrelate` object or a GDS file
* `sample.include` is a vector of individual IDs specifying which individuals to include in the table or matrix
* `thresh` specifies a minimum kinship coefficient value to include in the GRM
* `scaleKin` specifies a factor to multiply the kinship coefficients by in the GRM

# 5 References

# Appendix

* Conomos M.P., Reiner A.P., Weir B.S., & Thornton T.A. (2016). Model-free Estimation of Recent Genetic Relatedness. American Journal of Human Genetics, 98(1), 127-148.
* Conomos M.P., Miller M.B., & Thornton T.A. (2015). Robust Inference of Population Structure for Ancestry Prediction and Correction of Stratification in the Presence of Relatedness. Genetic Epidemiology, 39(4), 276-293.
* Gogarten, S.M., Bhangale, T., Conomos, M.P., Laurie, C.A., McHugh, C.P., Painter, I., … & Laurie, C.C. (2012). GWASTools: an R/Bioconductor package for quality control and analysis of Genome-Wide Association Studies. Bioinformatics, 28(24), 3329-3331.
* Manichaikul, A., Mychaleckyj, J.C., Rich, S.S., Daly, K., Sale, M., & Chen, W.M. (2010). Robust relationship inference in genome-wide association studies. Bioinformatics, 26(22), 2867-2873.