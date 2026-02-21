# PharmacoGx: An R Package for Analysis of Large Pharmacogenomic Datasets

Petr Smirnov1\*, Christopher Eeles\*\*, Zhaleh Safikhani1,2 and Benjamin Haibe-Kains\*\*\*

1Princess Margaret Cancer Centre, University Health Network, Toronto Canada
2Department of Medical Biophysics, University of Toronto, Toronto Canada

\*petr.smirnov@uhnresearch.ca
\*\*christopher.eeles@uhnresearch.ca
\*\*\*benjamin.haibe.kains@utoronto.ca

#### 30 October 2025

#### Package

PharmacoGx 3.14.0

# Contents

* [1 Introduction](#introduction)
  + [1.1 Installation and Settings](#installation-and-settings)
  + [1.2 Requirements](#requirements)
* [2 Downloading PharmacoSet Objects](#downloading-pharmacoset-objects)
  + [2.1 Downlading Drug Signatures](#downlading-drug-signatures)
* [3 Case Study](#case-study)
  + [3.1 (In)Consistency across large pharmacogenomic studies](#inconsistency-across-large-pharmacogenomic-studies)
  + [3.2 Query the Connectivity Map](#query-the-connectivity-map)
* [4 Estimating Drug Sensitivity Measures](#estimating-drug-sensitivity-measures)
  + [4.1 Curve Fitting](#curve-fitting)
  + [4.2 Plotting Drug-Dose Response Data](#plotting-drug-dose-response-data)
* [5 Gene-Drug Association Modelling](#gene-drug-association-modelling)
  + [5.1 Sensitivity Modelling](#sensitivity-modelling)
  + [5.2 Perturbation Modelling](#perturbation-modelling)
* [6 Connectivity Scoring](#connectivity-scoring)
  + [6.1 GSEA](#gsea)
  + [6.2 GWC](#gwc)
* [7 Acknowledgements](#acknowledgements)
* [8 Session Info](#session-info)
* [References](#references)

# 1 Introduction

Pharmacogenomics holds much potential to aid in discovering drug response
biomarkers and developing novel targeted therapies, leading to development of
precision medicine and working towards the goal of personalized therapy.
Several large experiments have been conducted, both to molecularly
characterize drug dose response across many cell lines, and to examine the
molecular response to drug administration. However, the experiments lack a
standardization of protocols and annotations, hindering meta-analysis across
several experiments.

`PharmacoGx` was developed to address these challenges, by providing a
unified framework for downloading and analyzing large pharmacogenomic datasets
which are extensively curated to ensure maximum overlap and consistency.
`PharmacoGx` is based on a level of abstraction from the raw
experimental data, and allows bioinformaticians and biologists to work with
data at the level of genes, drugs and cell lines. This provides a more
intuitive interface and, in combination with unified curation, simplifies
analyses between multiple datasets.

To organize the data released by each experiment, we developed the
*PharmacoSet* class. This class efficiently stores different types of
data and facilitates interrogating the data by drug or cell line. The
*PharmacoSet* is also versatile in its ability to deal with two
distinct types of pharmacogenomic datasets. The first type, known as
*sensitivity* datasets, are datasets where cell lines were profiled
on the molecular level, and then tested for drug dose response. The second
type of dataset is the *perturbation* dataset. These types of
datasets profile a cell line on the molecular level before and after
administration of a compound, to characterize the action of the compound on
the molecular level.

With the first release of *PharmacoGx* we have fully curated and
created PharmacoSet objects for three publicly available large pharmacogenomic
datasets. Two of these datasets are of the *sensitivity* type. These
are the Genomics of Drug Sensitivity in Cancer Project (GDSC)
(Garnett et al. [2012](#ref-garnett_systematic_2012)) and the Cancer Cell Line Encyclopedia (CCLE)
(Barretina et al. [2012](#ref-barretina_cancer_2012)). The third dataset is of the *perturbation* type, the
Connectivity Map (CMAP) project (Lamb et al. [2006](#ref-lamb_connectivity_2006)).

Furthermore, `PharmacoGx` provides a suite of parallelized functions which
facilitate drug response biomarker discovery, and molecular drug
characterization. This vignette will provide two example analysis case
studies. The first will be comparing gene expression and drug sensitivity
measures across the CCLE and GDSC projects. The second case study will
interrogate the CMAP database with a known signature of up and down regulated
genes for HDAC inhibitors as published in [Glaser et al. ([2003](#ref-glaser_gene_2003))}. Using the
Connectivity Score as defined in (Lamb et al. [2006](#ref-lamb_connectivity_2006)), it will be seen that
known HDAC inhibitors have a high numerical score and high significance.

For the purpose of this vignette, an extremely minuscule subset of all three
*PharmacoSet* objects are included with the package as example data.
They are included for illustrative purposes only, and the results obtained
with them will likely be meaningless.

## 1.1 Installation and Settings

`PharmacoGx` requires that several packages are installed. However, all
dependencies are available from CRAN or Bioconductor.

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install('PharmacoGx')
```

Load `PharamacoGx` into your current workspace:

```
library(PharmacoGx)
```

## 1.2 Requirements

`PharmacoGx` has been tested on Windows, Mac and Cent OS platforms. The packages
uses the core R package `parallel` to preform parallel computations, and
therefore if parallelization is desired, the dependencies for the parallel
package must be met.

# 2 Downloading PharmacoSet Objects

We have made the PharmacoSet objects of the curated datasets available for
download using functions provided in the package. A table of available
PharmacoSet objects can be obtained by using the `availablePSets()` function.
Any of the PharmacoSets in the table can then be downloaded by calling
*downloadPSet*, which saves the datasets into a directory of the users choice,
and returns the data into the R session.

```
availablePSets()
GDSC <- downloadPSet("GDSC_2020(v2-8.2)")
```

## 2.1 Downlading Drug Signatures

The package also provides tools to compute drug perturbation and sensitivity
signatures, as explained below. However, the computation of the perturbation
signatures is very lengthy, so for users’ convenience we have precomputed the
signatures for our perturbation PharmacoSet objects and made them available for
download using the function `downloadPertSig()`.

# 3 Case Study

## 3.1 (In)Consistency across large pharmacogenomic studies

Our first case study illustrates the functions for analysis of the *sensitivity*
type of dataset. The case study will investigate the consistency between the
GDSC and CCLE datasets, recreating the analysis similar to our
*Inconsistency in Large Pharmacogenomic Studies* paper
(Haibe-Kains et al. [2013](#ref-haibe-kains_inconsistency_2013)). In both CCLE and GDSC, the transcriptome of
cells was profiled using an Affymatrix microarray chip. Cells were also tested
for their response to increasing concentrations of various compounds, and form
this the IC50 and AUC were computed. However, the cell and drugs names used
between the two datasets were not consistent. Furthermore, two different
microarray platforms were used. However, `PharmacoGx` allows us to overcome
these differences to do a comparative study between these two datasets.

GDSC was profiled using the hgu133a platform, while CCLE was profiled with the
expanded hgu133plus2 platform. While in this case the hgu133a is almost a strict
subset of hgu133plus2 platform, the expression information in `PharmacoSet`
objects is summarized by Ensemble Gene Ids, allowing datasets with different
platforms to be directly compared. The probe to gene mapping is done using the
BrainArray customCDF for each platform (Sabatti, Karsten, and Geschwind [2002](#ref-sabatti_thresholding_2002)).

To begin, you would load the datasets from disk or download them using the
*downloadPSet* function above. In the following example, we use the toy datasets
provided with the package to illustrate the process, but to recreate the full
analysis the full PharmacoSets have to be downloaded.

We want to investigate the consistency of the data between the two datasets. The
common intersection between the datasets can then be found using *intersectPSet*.
We create a summary of the gene expression and drug sensitivity measures for
both datasets, so we are left with one gene expression profile and one
sensitivity profile per cell line within each dataset. We can then compare the
gene expression and sensitivity measures between the datasets using a standard
correlation coefficient.

```
  library(Biobase)
  library(SummarizedExperiment)
  library(S4Vectors)
  library(PharmacoGx)
  data("GDSCsmall")
  data("CCLEsmall")
  commonGenes <- intersect(fNames(GDSCsmall, "rna"),
                           fNames(CCLEsmall,"rna"))
  common <- intersectPSet(list('CCLE'=CCLEsmall,
                               'GDSC'=GDSCsmall),
                          intersectOn=c("cell.lines", "drugs"),
                          strictIntersect=TRUE)

  GDSC.auc <- summarizeSensitivityProfiles(
                common$GDSC,
                sensitivity.measure='auc_published',
                summary.stat="median",
                verbose=FALSE)
  CCLE.auc <- summarizeSensitivityProfiles(
                common$CCLE,
                sensitivity.measure='auc_published',
                summary.stat="median",
                verbose=FALSE)

  GDSC.ic50 <- summarizeSensitivityProfiles(
                common$GDSC,
                sensitivity.measure='ic50_published',
                summary.stat="median",
                verbose=FALSE)
  CCLE.ic50 <- summarizeSensitivityProfiles(
                common$CCLE,
                sensitivity.measure='ic50_published',
                summary.stat="median",
                verbose=FALSE)

  GDSCexpression <- summarizeMolecularProfiles(common$GDSC,
                                        cellNames(common$GDSC),
                                        mDataType="rna",
                                        features=commonGenes,
                                        verbose=FALSE)
  CCLEexpression <- summarizeMolecularProfiles(common$CCLE,
                                         cellNames(common$CCLE),
                                         mDataType="rna",
                                         features=commonGenes,
                                         verbose=FALSE)
  gg <- fNames(common[[1]], 'rna')
  cc <- cellNames(common[[1]])

  ge.cor <- sapply(cc, function (x, d1, d2) {
    stats::cor(d1[ , x], d2[ , x], method="spearman",
                use="pairwise.complete.obs")
  ## TO DO:: Ensure all assays are name so we can call by name instead of index
  }, d1=assay(GDSCexpression, 1), d2=assay(CCLEexpression, 1))
  ic50.cor <- sapply(cc, function (x, d1, d2) {
    stats::cor(d1[, x], d2[ , x], method="spearman",
                use="pairwise.complete.obs")
  }, d1=GDSC.ic50, d2=CCLE.ic50)
  auc.cor <- sapply(cc, function (x, d1, d2) {
    stats::cor(d1[ , x], d2[ , x], method="spearman",
                use="pairwise.complete.obs")
  }, d1=GDSC.auc, d2=CCLE.auc)

  w1 <- stats::wilcox.test(x=ge.cor, y=auc.cor,
                           conf.int=TRUE, exact=FALSE)
  w2 <- stats::wilcox.test(x=ge.cor, y=ic50.cor,
                           conf.int=TRUE, exact=FALSE)
  yylim <- c(-1, 1)
  ss <- sprintf("GE vs. AUC = %.1E\nGE vs. IC50 = %.1E",
                w1$p.value, w2$p.value)
```

```
  boxplot(list("GE"=ge.cor,
               "AUC"=auc.cor,
               "IC50"=ic50.cor),
          main="Concordance between cell lines",
          ylab=expression(R[s]),
          sub=ss,
          ylim=yylim,
          col="lightgrey",
          pch=20,
          border="black")
```

![](data:image/png;base64...)

## 3.2 Query the Connectivity Map

The second case study illustrates the analysis of a perturbation type datasets,
where the changes in cellular molecular profiles are compared before and after
administering a compound to the cell line. Of these datasets, we have currently
curated and made available for download the Connectivity Map (CMAP) dataset
(Lamb et al. [2006](#ref-lamb_connectivity_2006)).

For this case study, we will recreate an analysis from the paper by Lamb et al.,
in which a known signature for HDAC inhibitors (Glaser et al. [2003](#ref-glaser_gene_2003)) is used to
recover drugs in the CMAP dataset that are also known HDAC inhibitors. For this
example, the package includes this signature, already mapped to the gene level,
and it can be loaded by calling `data(HDAC\_genes)`.

Once again, we load the dataset, downloading it if needed using `downloadPSet`
. We then recreate drug signatures for each drug using the function
`drugPerturbationSig` to preform statistical modelling of the transcriptomic
response to the application of each drug. We then compare the observed
up-regulated and down-regulated genes to a the known HDAC signature, using the
GSEA connectivity score to determine the correlation between the two signatures.

```
  library(PharmacoGx)
  library(pander)
  data(CMAPsmall)
  drug.perturbation <- drugPerturbationSig(CMAPsmall,
                                           mDataType="rna",
                                           verbose=FALSE)
  data(HDAC_genes)

  res <- apply(drug.perturbation[,,c("tstat", "fdr")],
               2, function(x, HDAC){
        return(connectivityScore(x=x,
                                 y=HDAC[,2,drop=FALSE],
                               method="fgsea", nperm=100))
    }, HDAC=HDAC_genes)

  rownames(res) <- c("Connectivity", "P Value")
  res <- t(res)
  res <- res[order(res[,1], decreasing=TRUE),]
  pander::pandoc.table(res,
    caption='Connectivity Score results for HDAC inhibitor gene signature.',
    style = 'rmarkdown')
```

Connectivity Score results for HDAC inhibitor gene signature.

|  | Connectivity | P Value |
| --- | --- | --- |
| **vorinostat** | 0.9449 | 0.007393 |
| **alvespimycin** | 0.8831 | 0.01149 |
| **acetylsalicylic acid** | 0 | 1 |
| **rosiglitazone** | -0.714 | 0.02402 |
| **pioglitazone** | -0.7335 | 0.1214 |

As we can see, the known HDAC inhibitor Varinostat has a very strong
connectivity score, as well as a very high significance as determined by
permutation testing, in comparison to the other drugs, which score poorly.

This example serves as a validation of the method, and demonstrates the ease
with which drug perturbation analysis can be done using `PharmacoGx`.
While in this case we were matching a drug signature with a drug class
signature, this method can also be used in the discovery of drugs that are
anti-correlated with known disease signatures, to look for potential new
treatments and drug repurposing.

# 4 Estimating Drug Sensitivity Measures

*PharmacoGx* includes functions to calculate estimated AUC (Area Under
drug response Curve) and IC50 values from drugs dose response experiments that
measure cell viability after applications of varying concentrations of drug.
Additionally, these measures are recomputed for every *sensitivity*
`PharmacoSet` we create and included alongside any measures published
with the original data. The AUC measures originally published are labelled as
*auc\_published*, while the recomputed measures are labelled as
*auc\_recomputed*, and likewise for the IC50.

While the *PharmacoSets* already contain the recomputed data, the AUC and
IC50 can be calculated for arbitrary data using the *computeIC50* and
*computeAUC* functions. The AUC can be calculated using either the area
under the curve defined by the actual points recorded, or the area under the
curve fitted to the data.

## 4.1 Curve Fitting

While AUC can be numerically calculated without curve fitting, to estimate the
IC50 a drug dose response curve must be fit to the data.The dose-response curves
are fitted to the equation
\[
y = E\_{\infty} + \frac{ 1 - E\_{\infty} }{1+(\frac{x}{IC50})^{HS}}
\]
where the maximum viability is normalized to be \(y = y(0) = 1\), \(E\_{\infty}\)
denotes the minimum possible viability achieved by administering any amount
of the drug, \(IC50\) is the concentration at which viability is reduced to half
of the viability observed in the presence of an arbitrarily large concentration
of drug, and \(HS\) is a parameter describing the cooperativity of binding.
\(HS < 1\) denotes negative binding cooperativity, \(HS = 1\) denotes noncooperative
binding, and \(HS > 1\) denotes positive binding cooperativity. The parameters of
the curves are fitted using the least squares optimization framework. The
fitting of these curves to arbitrary points is implemented by the
*logLogisticRegression* function.

## 4.2 Plotting Drug-Dose Response Data

Drug-Dose response data included in the PharmacoSet objects can be conviniently
plotted using the `drugDoseResponseCurve` function. Given a list of
PharmacoSets, a drug name and a cell name, it will plot the drug dose response
curves for the given cell-drug combination in each dataset, allowing direct
comparisons of data between datasets.

# 5 Gene-Drug Association Modelling

`PharmacoGx` provides methods to model the association between drugs and
molecular data such as transcriptomics, genomics and proteomics.

*Sensitivity* studies allow the discovery of molecular features that improve or
inhibit the sensitivity of cell lines to various compounds, by looking at the
association between the expression of the feature and the response towards each
compound. This allows the selection of drugs to be tailored to each specific
patient based on the expressed known sensitivity biomarkers. The function
*drugSensitivitySig* models these associations.

*Perturbation* studies on the other hand look at the molecular profiles of a
cell before and after application of a drug, and therefore can characterize the
action of a drug on the molecular level. It is hypothesized that drugs which act
to down-regulate expression of known disease biomarkers would be effective in
reversing the cell from a diseased to healthy state. The function
*drugPerturbationSig* models the molecular profiles of drugs tested in a
*perturbation* dataset.

## 5.1 Sensitivity Modelling

The association between molecular features and response to a given drug is modelled using a linear regression model adjusted for tissue source:

\[
Y = \beta\_{0} + \beta\_{i}G\_i + \beta\_{t}T + \beta\_{b}B
\]

where \(Y\) denotes the drug sensitivity variable, \(G\_i\), \(T\) and \(B\) denote the
expression of gene i, the tissue source and the experimental batch respectively,
and \(\beta\)s are the regression coefficients. The strength of gene-drug
association is quantified by \(\beta\_i\), above and beyond the relationship
between drug sensitivity and tissue source. The variables Y and G are scaled
(standard deviation equals to 1) to estimate standardized coefficients from the
linear model. Significance of the gene-drug association is estimated by the
statistical significance of \(\beta\_i\) (two-sided t test). P-values are then
corrected for multiple testing using the false discovery rate (FDR) approach.

As an example of the efficacy of the modelling approach, we can model the
significance of the association between two drugs and their known biomarkers in
CCLE. We examine the association between drug *17-AAG* and gene *NQO1*, as well
as drug *PD-0325901* and gene *BRAF*:

```
  library(pander)
  data(CCLEsmall)
  features <- fNames(CCLEsmall, "rna")[
                          which(featureInfo(CCLEsmall,
                                            "rna")$Symbol == "NQO1")]
  sig.rna <- drugSensitivitySig(object=CCLEsmall,
                            mDataType="rna",
                            drugs=c("17-AAG"),
                            features=features,
                            sensitivity.measure="auc_published",
                            molecular.summary.stat="median",
                            sensitivity.summary.stat="median",
                            verbose=FALSE)
  sig.mut <- drugSensitivitySig(object=CCLEsmall,
                            mDataType="mutation",
                            drugs=c("PD-0325901"),
                            features="BRAF",
                            sensitivity.measure="auc_published",
                            molecular.summary.stat="and",
                            sensitivity.summary.stat="median",
                            verbose=FALSE)
  sig <- rbind(sig.rna, sig.mut)
  rownames(sig) <- c("17-AAG + NQO1","PD-0325901 + BRAF")
  colnames(sig) <- dimnames(sig.mut)[[3]]
  pander::pandoc.table(t(sig), style = "rmarkdown", caption='P Value of Gene-Drug Association' )
```

P Value of Gene-Drug Association

|  | 17-AAG + NQO1 | PD-0325901 + BRAF |
| --- | --- | --- |
| **estimate** | 0.601 | 0.8252 |
| **se** | 0.05368 | 0.1339 |
| **n** | 492 | 472 |
| **tstat** | 11.2 | 6.161 |
| **fstat** | 125.3 | 37.95 |
| **pvalue** | 6.034e-26 | 1.613e-09 |
| **df** | 469 | 449 |
| **fdr** | 6.034e-26 | 1.613e-09 |

## 5.2 Perturbation Modelling

The molecular response profile of a given drug is modelled as a linear regression model adjusted experimental batch effects, cell specific differences, and duration of experiment to isolate the effect of the concentration of the drug applied:

\[
G = \beta\_{0} + \beta\_{i}C\_i + \beta\_{t}T + \beta\_{d}D + \beta\_{b}B
\]

where \(G\) denotes the molecular feature expression (gene), \(C\_i\) denotes the
concentration of the compound applied, \(T\) the cell line identity, \(D\) denotes
the duration of the experiment, \(B\) denotes the experimental batch, and
\(\beta\)s are the regression coefficients. The strength of feature response is
quantified by \(\beta\_i\). Unlike the sensitivity signatures, the \(G\) and \(C\)
variables are unscaled. Significance of the gene-drug association is estimated
by the statistical significance of \(\beta\_i\), calculated using an F-test on the
improvement in fit after the inclusion of the term. P-values are then corrected
for multiple testing using the false discovery rate (FDR) approach.

# 6 Connectivity Scoring

The package also provides two methods for quantifying the similarity between two
molecular signatures of the form returned by *drugPerturbationSig* and
*drugSensitivitySig*, or a set of up and down regulated genes as part of a
disease signature. The two methods are the *GSEA* method as introduced by
Subramanian et at (Subramanian et al. [2005](#ref-subramanian_gene_2005)), and *GWC*, a method based on a
weighted Spearman correlation coefficient. Both methods are implemented by the
*connectivityScore* function.

## 6.1 GSEA

The *GSEA* method is implemented to compare a signature returned by
*drugPerturbationSig* with a known set of up and down regulated genes in a
disease state. For the disease signature, the function expects a vector of
features with a value, either binary (1, -1) or continuous, where the sign
signifies if the gene is up or down regulated in the disease. The names of the
vector are expected to be the feature names, matching the feature names used in
the drug signature. The function then returns a GSEA score measuring the
concordance of the disease signature to the drug signature, as well as an
estimated P-Value for the significance of the connectivity determined by
permutation testing.

## 6.2 GWC

The GWC method (Genome Wide Correlation) is implemented to compare two
signatures of the same length, such as two drug signatures returned by
*drugPerturbationSig*. The score is a Spearman correlation weighted by the
normalized negative logarithm significance of each value. The normalization is
done so that datasets of different size can be compared without concern for
lower p-values in one dataset due to larger sample sizes.

More precisely, take \(X\_i\) and \(Y\_i\) to be the ranks of the first and second set
of data respectively, and \(Px\_i\), \(Py\_i\) to be the p-values of those
observations. The weight for each pair of observations is:

\[
Wx\_i = \frac{-\log\_{10}(Px\_i)}{\sum\_{i}-\log\_{10}(Px\_i)}
\]

\[
Wy\_i = \frac{-\log\_{10}(Py\_i)}{\sum\_{i}-\log\_{10}(Py\_i)}
\]

\[
W\_i = Wx\_i + Wy\_i
\]

If we further define the weighted mean as follows:
\[
m(X;W) = \frac{\sum\_i W\_i X\_i}{\sum\_i{W\_i}}
\]

Then the weighted correlation is given by:

\[
cor(X,Y,W) = \frac{\frac{\sum\_i W\_i (X\_i - m(X;W))(Y\_i -
m(Y,W))}{\sum\_i W\_i}}{\sqrt{(\frac{\sum\_i W\_i (X\_i - m(X;W))^2}{\sum\_i W\_i})
(\frac{\sum\_i W\_i (Y\_i - m(Y;W))^2}{\sum\_i W\_i})}}
\]

This correlation therefore takes into account not only the ranking of each
feature in a signature, but also of the significance of each rank.

# 7 Acknowledgements

The authors of the package would like to thank the investigators of the Genomics
of Drug Sensitivity in Cancer Project, the Cancer Cell Line Encyclopedia and the
Connectivity Map Project who have made their invaluable data available to the
scientific community. We would also like to thank Mark Freeman for contributing
the code for MLE fitting drug-dose response curves towards this package. We are
indebted to Nehme El-Hachem, Donald Wang and Adrian She for their contributions
towards the accurate curation of the datasets. Finally, it is important to
acknowledge all the members of the Benjamin Haibe-Kains lab for their
contribution towards testing and feedback during the design of the package.

# 8 Session Info

```
# set eval = FALSE if you don't want this info (useful for reproducibility) to appear
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
[1] stats4    stats     graphics  grDevices utils     datasets  methods
[8] base

other attached packages:
 [1] pander_0.6.6                ggplot2_4.0.0
 [3] data.table_1.17.8           PharmacoGx_3.14.0
 [5] CoreGx_2.14.0               SummarizedExperiment_1.40.0
 [7] Biobase_2.70.0              GenomicRanges_1.62.0
 [9] Seqinfo_1.0.0               IRanges_2.44.0
[11] S4Vectors_0.48.0            MatrixGenerics_1.22.0
[13] matrixStats_1.5.0           BiocGenerics_0.56.0
[15] generics_0.1.4              knitcitations_1.0.12
[17] knitr_1.50                  BiocStyle_2.38.0

loaded via a namespace (and not attached):
  [1] bitops_1.0-9                rlang_1.1.6
  [3] magrittr_2.0.4              shinydashboard_0.7.3
  [5] otel_0.2.0                  compiler_4.5.1
  [7] reshape2_1.4.4              vctrs_0.6.5
  [9] relations_0.6-15            stringr_1.5.2
 [11] pkgconfig_2.0.3             crayon_1.5.3
 [13] fastmap_1.2.0               magick_2.9.0
 [15] backports_1.5.0             XVector_0.50.0
 [17] caTools_1.18.3              promises_1.4.0
 [19] rmarkdown_2.30              tinytex_0.57
 [21] coop_0.6-3                  xfun_0.53
 [23] MultiAssayExperiment_1.36.0 cachem_1.1.0
 [25] jsonlite_2.0.0              RefManageR_1.4.0
 [27] SnowballC_0.7.1             later_1.4.4
 [29] DelayedArray_0.36.0         BiocParallel_1.44.0
 [31] parallel_4.5.1              sets_1.0-25
 [33] cluster_2.1.8.1             R6_2.6.1
 [35] bslib_0.9.0                 stringi_1.8.7
 [37] RColorBrewer_1.1-3          limma_3.66.0
 [39] boot_1.3-32                 lubridate_1.9.4
 [41] jquerylib_0.1.4             Rcpp_1.1.0
 [43] bookdown_0.45               R.utils_2.13.0
 [45] downloader_0.4.1            BiocBaseUtils_1.12.0
 [47] httpuv_1.6.16               Matrix_1.7-4
 [49] igraph_2.2.1                timechange_0.3.0
 [51] tidyselect_1.2.1            dichromat_2.0-0.1
 [53] abind_1.4-8                 yaml_2.3.10
 [55] gplots_3.2.0                codetools_0.2-20
 [57] lattice_0.22-7              tibble_3.3.0
 [59] plyr_1.8.9                  withr_3.0.2
 [61] shiny_1.11.1                BumpyMatrix_1.18.0
 [63] S7_0.2.0                    evaluate_1.0.5
 [65] bench_1.1.4                 xml2_1.4.1
 [67] pillar_1.11.1               lsa_0.73.3
 [69] BiocManager_1.30.26         KernSmooth_2.23-26
 [71] checkmate_2.3.3             DT_0.34.0
 [73] shinyjs_2.1.0               piano_2.26.0
 [75] scales_1.4.0                gtools_3.9.5
 [77] xtable_1.8-4                marray_1.88.0
 [79] glue_1.8.0                  slam_0.1-55
 [81] tools_4.5.1                 fgsea_1.36.0
 [83] visNetwork_2.1.4            fastmatch_1.1-6
 [85] cowplot_1.2.0               grid_4.5.1
 [87] bibtex_0.5.1                cli_3.6.5
 [89] S4Arrays_1.10.0             dplyr_1.1.4
 [91] gtable_0.3.6                R.methodsS3_1.8.2
 [93] sass_0.4.10                 digest_0.6.37
 [95] SparseArray_1.10.0          htmlwidgets_1.6.4
 [97] farver_2.1.2                R.oo_1.27.1
 [99] htmltools_0.5.8.1           lifecycle_1.0.4
[101] httr_1.4.7                  statmod_1.5.1
[103] mime_0.13
```

# References

Barretina, Jordi, Giordano Caponigro, Nicolas Stransky, Kavitha Venkatesan, Adam A Margolin, Sungjoon Kim, Christopher J Wilson, et al. 2012. “The Cancer Cell Line Encyclopedia Enables Predictive Modelling of Anticancer Drug Sensitivity.” *Nature* 483 (7391): 603–7.

Garnett, Mathew J, Elena J Edelman, Sonja J Heidorn, Chris D Greenman, Anahita Dastur, King Wai Lau, Patricia Greninger, et al. 2012. “Systematic Identification of Genomic Markers of Drug Sensitivity in Cancer Cells.” *Nature* 483 (7391): 570–75.

Glaser, Keith B, Michael J Staver, Jeffrey F Waring, Joshua Stender, Roger G Ulrich, and Steven K Davidsen. 2003. “Gene Expression Profiling of Multiple Histone Deacetylase (HDAC) Inhibitors: Defining a Common Gene Set Produced by HDAC Inhibition in T24 and MDA Carcinoma Cell Lines.” *Molecular Cancer Therapeutics* 2 (2): 151–63.

Haibe-Kains, Benjamin, Nehme El-Hachem, Nicolai Juul Birkbak, Andrew C Jin, Andrew H Beck, Hugo J W L Aerts, and John Quackenbush. 2013. “Inconsistency in Large Pharmacogenomic Studies.” *Nature* 504 (7480): 389–93.

Lamb, Justin, Emily D. Crawford, David Peck, Joshua W. Modell, Irene C. Blat, Matthew J. Wrobel, Jim Lerner, et al. 2006. “The Connectivity Map: Using Gene-Expression Signatures to Connect Small Molecules, Genes, and Disease.” *Science* 313 (5795): 1929–35. <https://doi.org/10.1126/science.1132939>.

Sabatti, Chiara, Stanislav L Karsten, and Daniel H Geschwind. 2002. “Thresholding Rules for Recovering a Sparse Signal from Microarray Experiments.” *Mathematical Biosciences* 176 (1): 17–34.

Subramanian, Aravind, Pablo Tamayo, Vamsi K. Mootha, Sayan Mukherjee, Benjamin L. Ebert, Michael A. Gillette, Amanda Paulovich, et al. 2005. “Gene Set Enrichment Analysis: A Knowledge-Based Approach for Interpreting Genome-Wide Expression Profiles.” *Proceedings of the National Academy of Sciences* 102 (43): 15545–50. <https://doi.org/10.1073/pnas.0506580102>.