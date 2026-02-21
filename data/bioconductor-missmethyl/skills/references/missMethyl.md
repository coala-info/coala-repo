# missMethyl: Analysing Illumina HumanMethylation BeadChip Data

Belinda Phipson and Jovana Maksimovic

#### 30 October 2025

#### Package

missMethyl 1.44.0

# Contents

* [1 Introduction](#introduction)
  + [1.1 Analysis of Illumina MethylationEPIC v2.0 beadchip datasets](#analysis-of-illumina-methylationepic-v2.0-beadchip-datasets)
* [2 Reading data into R](#reading-data-into-r)
  + [2.1 Annotation for Illumina MethylationEPIC v2.0 beadchip datasets](#annotation-for-illumina-methylationepic-v2.0-beadchip-datasets)
* [3 Subset-quantile within array normalization (SWAN)](#subset-quantile-within-array-normalization-swan)
* [4 Filter out poor quality probes](#filter-out-poor-quality-probes)
* [5 Extracting \(\beta\) and M-values](#extracting-beta-and-m-values)
  + [5.1 Filtering replicate probes in Illumina MethylationEPIC v2.0 beadchip datasets](#filtering-replicate-probes-in-illumina-methylationepic-v2.0-beadchip-datasets)
* [6 Testing for differential methylation using limma](#testing-for-differential-methylation-using-limma)
* [7 Removing unwanted variation when testing for differential methylation](#removing-unwanted-variation-when-testing-for-differential-methylation)
  + [7.1 Alternative approach for RUVm stage 1](#alternative-approach-for-ruvm-stage-1)
  + [7.2 Visualising the effect of RUVm adjustment](#visualising-the-effect-of-ruvm-adjustment)
* [8 Testing for differential variability (DiffVar)](#testing-for-differential-variability-diffvar)
  + [8.1 Methylation data](#methylation-data)
  + [8.2 RNA-Seq expression data](#rna-seq-expression-data)
* [9 Gene ontology analysis](#gene-ontology-analysis)
  + [9.1 CpG level analysis](#cpg-level-analysis)
  + [9.2 Region level analysis](#region-level-analysis)
* [10 Session information](#session-information)
* [References](#references)

# 1 Introduction

The *[missMethyl](https://bioconductor.org/packages/3.22/missMethyl)* package contains functions to analyse
methylation data from Illumina’s HumanMethylation450 and MethylationEPIC
beadchip. These arrays are a cost-effective alternative to whole genome
bisulphite sequencing, and as such are widely used to profile DNA methylation.
Specifically, *[missMethyl](https://bioconductor.org/packages/3.22/missMethyl)* contains functions to perform
SWAN normalisation (Maksimovic, Gordon, and Oshlack [2012](#ref-Maksimovic2012)),perform differential methylation analysis
using **RUVm** (Maksimovic et al. [2015](#ref-Maksimovic2015)), differential variability analysis
(Phipson and Oshlack [2014](#ref-Phipson2014)) and gene set enrichment analysis (Phipson, Maksimovic, and Oshlack [2016](#ref-Phipson2016)). As our lab’s
research into specialised analyses of these arrays continues we anticipate that
the package will be updated with new functions.

Raw data files are in IDAT format, which can be read into R using the
*[minfi](https://bioconductor.org/packages/3.22/minfi)* package (Aryee et al. [2014](#ref-Aryee2014)). Statistical analyses are
usually performed on M-values, and \(\beta\) values are used for visualisation,
both of which can be extracted from `MethylSet` data objects, which is a class
of object created by *[minfi](https://bioconductor.org/packages/3.22/minfi)*. For detecting
differentially variable CpGs we recommend that the analysis is performed on
M-values. All analyses described here are performed at the CpG site level.

## 1.1 Analysis of Illumina MethylationEPIC v2.0 beadchip datasets

The *[missMethyl](https://bioconductor.org/packages/3.22/missMethyl)* package has been updated to support
Illumina’s MethylationEPIC v2.0 beadchip. This array contains replicate probes
which map to the same CpG dinucleotides. We recommend filtering these replicates
prior to analysis with the *[missMethyl](https://bioconductor.org/packages/3.22/missMethyl)* package using
the *[DMRcate](https://bioconductor.org/packages/3.22/DMRcate)* package. An example of this is shown in
this vignette.

# 2 Reading data into R

We will use the data in the *[minfiData](https://bioconductor.org/packages/3.22/minfiData)* package to
demonstrate the functions in *[missMethyl](https://bioconductor.org/packages/3.22/missMethyl)*.
The example dataset has 6 samples across two slides. There are 3 cancer samples
and 3 normal sample. The sample information is in the targets file. An
essential column in the targets file is the `Basename` column which tells us
where the idat files to be read in are located. The R commands to read in the
data are taken from the *[minfi](https://bioconductor.org/packages/3.22/minfi)* User’s Guide. For
additional details on how to read the IDAT files into R, as well as information
regarding quality control please refer to the *[minfi](https://bioconductor.org/packages/3.22/minfi)*
User’s Guide.

```
library(missMethyl)
library(limma)
library(minfi)
library(minfiData)
```

```
baseDir <- system.file("extdata", package = "minfiData")
targets <- read.metharray.sheet(baseDir)
```

```
## [1] "/home/biocbuild/bbs-3.22-bioc/R/site-library/minfiData/extdata/SampleSheet.csv"
```

```
targets[,1:9]
```

```
##   Sample_Name Sample_Well Sample_Plate Sample_Group Pool_ID person age sex
## 1    GroupA_3          H5         <NA>       GroupA    <NA>    id3  83   M
## 2    GroupA_2          D5         <NA>       GroupA    <NA>    id2  58   F
## 3    GroupB_3          C6         <NA>       GroupB    <NA>    id3  83   M
## 4    GroupB_1          F7         <NA>       GroupB    <NA>    id1  75   F
## 5    GroupA_1          G7         <NA>       GroupA    <NA>    id1  75   F
## 6    GroupB_2          H7         <NA>       GroupB    <NA>    id2  58   F
##   status
## 1 normal
## 2 normal
## 3 cancer
## 4 cancer
## 5 normal
## 6 cancer
```

```
targets[,10:12]
```

```
##    Array      Slide
## 1 R02C02 5723646052
## 2 R04C01 5723646052
## 3 R05C02 5723646052
## 4 R04C02 5723646053
## 5 R05C02 5723646053
## 6 R06C02 5723646053
##                                                                                      Basename
## 1 /home/biocbuild/bbs-3.22-bioc/R/site-library/minfiData/extdata/5723646052/5723646052_R02C02
## 2 /home/biocbuild/bbs-3.22-bioc/R/site-library/minfiData/extdata/5723646052/5723646052_R04C01
## 3 /home/biocbuild/bbs-3.22-bioc/R/site-library/minfiData/extdata/5723646052/5723646052_R05C02
## 4 /home/biocbuild/bbs-3.22-bioc/R/site-library/minfiData/extdata/5723646053/5723646053_R04C02
## 5 /home/biocbuild/bbs-3.22-bioc/R/site-library/minfiData/extdata/5723646053/5723646053_R05C02
## 6 /home/biocbuild/bbs-3.22-bioc/R/site-library/minfiData/extdata/5723646053/5723646053_R06C02
```

```
rgSet <- read.metharray.exp(targets = targets)
```

The data is now an `RGChannelSet` object and needs to be normalised and
converted to a `MethylSet` object.

## 2.1 Annotation for Illumina MethylationEPIC v2.0 beadchip datasets

When using MethylationEPIC v2.0 datasets, the array and annotation details in
the `RGChannelSet` object must be set manually.

```
### This code is not run within this vignette

# If using EPIC_V2, please run these lines:
annotation(rgSet)["array"] = "IlluminaHumanMethylationEPICv2"
annotation(rgSet)["annotation"] = "20a1.hg38"

### End of not run
```

# 3 Subset-quantile within array normalization (SWAN)

SWAN (subset-quantile within array normalization) is a within-array
normalization method for Illumina 450k & EPIC BeadChips. Technical differencs
have been demonstrated to exist between the Infinium I and Infinium II
assays on a single Illumina HumanMethylation array
(Bibikova et al. [2011](#ref-Bibikova2011), @Dedeurwaerder2011). Using the SWAN method
substantially reduces the technical variability between the assay
designs whilst maintaining important biological differences. The SWAN
method makes the assumption that the number of CpGs within the 50bp
probe sequence reflects the underlying biology of the region being
interrogated. Hence, the overall distribution of intensities of probes
with the same number of CpGs in the probe body should be the same
regardless of assay type. The method then uses a subset quantile
normalization approach to adjust the intensities of each array
(Maksimovic, Gordon, and Oshlack [2012](#ref-Maksimovic2012)).

`SWAN` can take a `MethylSet`, `RGChannelSet` or `MethyLumiSet` as input. It
should be noted that, in order to create the normalization subset, `SWAN`
randomly selects Infinium I and II probes that have one, two and three
underlying CpGs; as such, we recommend using `set.seed` before to ensure that
the normalized intensities will be
identical, if the normalization is repeated.

The technical differences between Infinium I and II assay designs can
result in aberrant \(\beta\) value distributions (Figure [1](#fig:betasByType),
panel “Raw”). Using SWAN corrects for the technical differences between the
Infinium I and II assay designs and produces a smoother overall \(\beta\)
value distribution (Figure [1](#fig:betasByType), panel “SWAN”).

```
mSet <- preprocessRaw(rgSet)
```

```
mSetSw <- SWAN(mSet,verbose=TRUE)
```

```
## [SWAN] Preparing normalization subset
## 450k
## [SWAN] Normalizing methylated channel
## [SWAN] Normalizing array 1 of 6
## [SWAN] Normalizing array 2 of 6
## [SWAN] Normalizing array 3 of 6
## [SWAN] Normalizing array 4 of 6
## [SWAN] Normalizing array 5 of 6
## [SWAN] Normalizing array 6 of 6
## [SWAN] Normalizing unmethylated channel
## [SWAN] Normalizing array 1 of 6
## [SWAN] Normalizing array 2 of 6
## [SWAN] Normalizing array 3 of 6
## [SWAN] Normalizing array 4 of 6
## [SWAN] Normalizing array 5 of 6
## [SWAN] Normalizing array 6 of 6
```

```
par(mfrow=c(1,2), cex=1.25)
densityByProbeType(mSet[,1], main = "Raw")
densityByProbeType(mSetSw[,1], main = "SWAN")
```

![Beta value dustributions. Density distributions of beta values before and after using SWAN.](data:image/png;base64...)

Figure 1: Beta value dustributions
Density distributions of beta values before and after using SWAN.

# 4 Filter out poor quality probes

Poor quality probes can be filtered out based on the detection p-value.
For this example, to retain a CpG for further analysis, we require that
the detection p-value is less than 0.01 in all samples.

```
detP <- detectionP(rgSet)
keep <- rowSums(detP < 0.01) == ncol(rgSet)
mSetSw <- mSetSw[keep,]
```

# 5 Extracting \(\beta\) and M-values

Now that the data has been `SWAN` normalised we can extract \(\beta\) and
M-values from the object. We prefer to add an offset to the methylated
and unmethylated intensities when calculating M-values, hence we extract
the methylated and unmethylated channels separately and perform our own
calculation. For all subsequent analyses we use a random selection of
20000 CpGs to reduce computation time.

```
set.seed(10)
mset_reduced <- mSetSw[sample(1:nrow(mSetSw), 20000),]
meth <- getMeth(mset_reduced)
unmeth <- getUnmeth(mset_reduced)
Mval <- log2((meth + 100)/(unmeth + 100))
beta <- getBeta(mset_reduced)
dim(Mval)
```

```
## [1] 20000     6
```

```
par(mfrow=c(1,1))
plotMDS(Mval, labels=targets$Sample_Name, col=as.integer(factor(targets$status)))
legend("topleft",legend=c("Cancer","Normal"),pch=16,cex=1.2,col=1:2)
```

![MDS plot. A multi-dimensional scaling (MDS) plot of cancer and normal samples.](data:image/png;base64...)

Figure 2: MDS plot
A multi-dimensional scaling (MDS) plot of cancer and normal samples.

An MDS plot (Figure [2](#fig:mdsplot)) is a good sanity check to make sure
samples cluster together according to the main factor of interest, in
this case, cancer and normal.

## 5.1 Filtering replicate probes in Illumina MethylationEPIC v2.0 beadchip datasets

The MethylationEPIC v2.0 array contains replicate probes which map to the same
CpG dinucleotides. We recommend filtering these replicate probes prior to continuing analysis. The *[DMRcate](https://bioconductor.org/packages/3.22/DMRcate)* package contains [information](https://bioconductor.org/packages/release/bioc/vignettes/DMRcate/inst/doc/EPICv2.pdf) describing possible approaches for filtering replicate probes. We also suggest filtering out non-cg probes, as shown below.

```
### This code is not run within this vignette

# For EPIC_V2, please run these lines to remove replicate and non-cg probes:
# Remove non-cg probes
Mval <- Mval[grepl("^cg", rownames(Mval)),]

# Please also filter replicate probes using an appropriate strategy. See the
# DMRcate EPIC v2 vignette for details.

### End of not run
```

# 6 Testing for differential methylation using limma

To test for differential methylation we use the *[limma](https://bioconductor.org/packages/3.22/limma)*
package (Smyth [2005](#ref-Smyth2005)), which employs an empirical Bayes framework based on
Guassian model theory. First we need to set up the design matrix.
There are a number of ways to do this, the most straightforward is directly from
the targets file. There are a number of variables, with the `status` column
indicating **cancer/normal** samples. From the `person` column of the targets
file, we see that the **cancer/normal** samples are matched, with 3 individuals
each contributing both a **cancer** and **normal** sample. Since the
*[limma](https://bioconductor.org/packages/3.22/limma)* model framework can handle any experimental
design which can be summarised by a design matrix, we can take into account the
paired nature of the data in the analysis. For more complicated experimental
designs, please refer to the *[limma](https://bioconductor.org/packages/3.22/limma)* User’s Guide.

```
group <- factor(targets$status,levels=c("normal","cancer"))
id <- factor(targets$person)
design <- model.matrix(~id + group)
design
```

```
##   (Intercept) idid2 idid3 groupcancer
## 1           1     0     1           0
## 2           1     1     0           0
## 3           1     0     1           1
## 4           1     0     0           1
## 5           1     0     0           0
## 6           1     1     0           1
## attr(,"assign")
## [1] 0 1 1 2
## attr(,"contrasts")
## attr(,"contrasts")$id
## [1] "contr.treatment"
##
## attr(,"contrasts")$group
## [1] "contr.treatment"
```

Now we can test for differential methylation using the `lmFit` and `eBayes`
functions from *[limma](https://bioconductor.org/packages/3.22/limma)*. As input data we use the matrix of
M-values.

```
fit.reduced <- lmFit(Mval,design)
fit.reduced <- eBayes(fit.reduced, robust=TRUE)
```

The numbers of hyper-methylated (1) and hypo-methylated (-1) can be
displayed using the `decideTests` function in *[limma](https://bioconductor.org/packages/3.22/limma)*
and the top 10 differentially methylated CpGs for *cancer* versus *normal*
extracted using `topTable`.

```
summary(decideTests(fit.reduced))
```

```
##        (Intercept) idid2 idid3 groupcancer
## Down          6969     0   116         571
## NotSig        3361 20000 19879       18960
## Up            9670     0     5         469
```

```
top<-topTable(fit.reduced,coef=4)
top
```

```
##               logFC    AveExpr        t      P.Value adj.P.Val        B
## cg16969623 4.709963 -1.3299619 18.12759 5.219594e-06 0.0293723 4.433507
## cg24115221 4.242995 -0.4516116 16.28098 9.192073e-06 0.0293723 4.059392
## cg13692446 4.354869  0.3076255 15.76907 1.087256e-05 0.0293723 3.941788
## cg11334818 4.017615  0.9336370 15.25796 1.292550e-05 0.0293723 3.817541
## cg10341556 5.001372 -1.5737275 15.43631 1.314667e-05 0.0293723 3.793551
## cg17815252 3.708821 -2.3568260 14.72700 1.556271e-05 0.0293723 3.680713
## cg24331301 3.859817 -1.4268097 14.55374 1.655787e-05 0.0293723 3.634252
## cg26976732 3.852926 -0.9246160 14.37590 1.765855e-05 0.0293723 3.585601
## cg26328335 3.728350  0.3589687 14.14524 1.921778e-05 0.0293723 3.521004
## cg05621343 4.269988 -0.5599496 14.08388 2.025360e-05 0.0293723 3.477544
```

Note that since we performed our analysis on M-values, the `logFC` and
`AveExpr` columns are computed on the M-value scale. For interpretability
and visualisation we can look at the \(\beta\) values. The \(\beta\) values for
the top 4 differentially methylated CpGs shown in Figure [3](#fig:top4).

```
cpgs <- rownames(top)
par(mfrow=c(2,2))
for(i in 1:4){
stripchart(beta[rownames(beta)==cpgs[i],]~design[,4],method="jitter",
group.names=c("Normal","Cancer"),pch=16,cex=1.5,col=c(4,2),ylab="Beta values",
vertical=TRUE,cex.axis=1.5,cex.lab=1.5)
title(cpgs[i],cex.main=1.5)
}
```

![Top DM CpGs. The beta values for the top 4 differentially methylated CpGs.](data:image/png;base64...)

Figure 3: Top DM CpGs
The beta values for the top 4 differentially methylated CpGs.

# 7 Removing unwanted variation when testing for differential methylation

Like other platforms, 450k array studies are subject to unwanted
technical variation such as batch effects and other, often unknown,
sources of variation. The adverse effects of unwanted variation have
been extensively documented in gene expression array studies and have
been shown to be able to both reduce power to detect true differences
and to increase the number of false discoveries. As such, when it is
apparent that data is significantly affected by unwanted variation, it
is advisable to perform an adjustment to mitigate its effects.

*[missMethyl](https://bioconductor.org/packages/3.22/missMethyl)* provides a *[limma](https://bioconductor.org/packages/3.22/limma)*
inspired interface to functions from the CRAN package
*[ruv](https://CRAN.R-project.org/package%3Druv)*, which enable the removal of unwanted variation
when performing a differential methylation analysis (Maksimovic et al. [2015](#ref-Maksimovic2015)).

`RUVfit` uses the *RUV-inverse* method by default, as this does not require the
user to specify a \(k\) parameter. The ridged version of *RUV-inverse* is also
available by setting `method = rinv`. The *RUV-2* and *RUV-4* functions can also
be used by setting `method = ruv2` or `method = ruv4`, respectively, and
specifying an appropriate value for *k* (number of components of unwanted
variation to remove) where \(0 \leq k < no. samples\).

All of the methods rely on negative control features
to accurately estimate the components of unwanted variation. Negative
control features are probes/genes/etc. that are known *a priori* to not
truly be associated with the biological factor of interest, but are
affected by unwanted variation. For example, in a microarray gene
expression study, these could be house-keeping genes or a set of
spike-in controls. Negative control features are extensively discussed
in Gagnon-Bartsch and Speed ([2012](#ref-Gagnon-Bartsch2012)) and Gagnon-Bartsch et al.
([2013](#ref-Gagnon-Bartsch2013)). Once the unwanted factors are accurately estimated from
the data, they are adjusted for in the linear model that describes the
differential analysis.

If the negative control features are not known *a priori*, they can be
identified empirically. This can be achieved via a 2-stage approach,
**RUVm**. Stage 1 involves performing a differential methylation analysis using
*RUV-inverse* (by default) and the 613 Illumina negative controls (INCs) as
negative control features. This will produce a list of CpGs ranked by p-value
according to their level of association with the factor of interest.
This list can then be used to identify a set of empirical control probes (ECPs),
which will capture more of the unwanted variation than using the INCs alone.
ECPs are selected by designating a proportion of the CpGs least associated with
the factor of interest as negative control features; this can be done
based on either an FDR cut-off or by taking a fixed percentage of probes
from the bottom of the ranked list. Stage 2 involves performing a second
differential methylation analysis on the original data using *RUV-inverse*
(by default) and the ECPs. For simplicity, we are ignoring the paired
nature of the **cancer** and **normal** samples in this example.

```
# get M-values for ALL probes
meth <- getMeth(mSet)
unmeth <- getUnmeth(mSet)
M <- log2((meth + 100)/(unmeth + 100))
```

```
### This code is not run within this vignette

# For EPIC_V2, please run these lines to remove replicate and non-cg probes:
# remove non-cg probes
M <- M[grepl("^cg", rownames(M)),]

# Please also filter replicate probes using an appropriate strategy. See the
# DMRcate EPIC v2 vignette for details.

### End of not run
```

```
# setup the factor of interest
grp <- factor(targets$status, labels=c(0,1))
# extract Illumina negative control data
INCs <- getINCs(rgSet)
head(INCs)
```

```
##          5723646052_R02C02 5723646052_R04C01 5723646052_R05C02
## 13792480        -0.3299654        -1.0955482        -0.5266103
## 69649505        -1.0354488        -1.4943396        -1.0067050
## 34772371        -1.1286422        -0.2995603        -0.8192636
## 28715352        -0.5553373        -0.7599489        -0.7186973
## 74737439        -1.1169178        -0.8656399        -0.6429681
## 33730459        -0.7714684        -0.5622424        -0.7724825
##          5723646053_R04C02 5723646053_R05C02 5723646053_R06C02
## 13792480        -0.6374299         -1.116598        -0.4332793
## 69649505        -0.8854881         -1.586679        -0.9217329
## 34772371        -0.6895514         -1.161155        -0.6186795
## 28715352        -1.7903619         -1.348105        -1.0067259
## 74737439        -0.8872082         -1.064986        -0.9841833
## 33730459        -1.5623138         -2.079184        -1.0445246
```

```
# add negative control data to M-values
Mc <- rbind(M,INCs)
# create vector marking negative controls in data matrix
ctl1 <- rownames(Mc) %in% rownames(INCs)
table(ctl1)
```

```
## ctl1
##  FALSE   TRUE
## 485512    613
```

```
rfit1 <- RUVfit(Y = Mc, X = grp, ctl = ctl1) # Stage 1 analysis
rfit2 <- RUVadj(Y = Mc, fit = rfit1)
```

Now that we have performed an initial differential methylation analysis
to rank the CpGs with respect to their association with the factor of
interest, we can designate the CpGs that are least associated with the
factor of interest based on FDR-adjusted p-value as ECPs.

```
top1 <- topRUV(rfit2, num=Inf, p.BH = 1)
head(top1)
```

```
##                     F.p     F.p.BH       p_X1.1  p.BH_X1.1    b_X1.1     sigma2
## cg04743961 3.516091e-07 0.01017357 3.516091e-07 0.01017357 -4.838190 0.10749571
## cg07155336 3.583107e-07 0.01017357 3.583107e-07 0.01017357 -5.887409 0.16002329
## cg20925841 3.730375e-07 0.01017357 3.730375e-07 0.01017357 -4.790211 0.10714494
## cg03607359 4.721205e-07 0.01017357 4.721205e-07 0.01017357 -4.394397 0.09636129
## cg10566121 5.238865e-07 0.01017357 5.238865e-07 0.01017357 -4.787914 0.11780108
## cg07655636 6.080091e-07 0.01017357 6.080091e-07 0.01017357 -4.571758 0.11201883
##            var.b_X1.1 fit.ctl        mean
## cg04743961 0.07729156   FALSE -2.31731496
## cg07155336 0.11505994   FALSE -1.27676413
## cg20925841 0.07703935   FALSE -0.87168892
## cg03607359 0.06928569   FALSE -2.19187147
## cg10566121 0.08470133   FALSE  0.03138961
## cg07655636 0.08054378   FALSE -1.29294851
```

```
ctl2 <- rownames(M) %in% rownames(top1[top1$p.BH_X1.1 > 0.5,])
table(ctl2)
```

```
## ctl2
##  FALSE   TRUE
## 172540 312972
```

We can then use the ECPs to perform a second differential methylation
with *RUV-inverse*, which is adjusted for the unwanted variation
estimated from the data.

```
# Perform RUV adjustment and fit
rfit3 <- RUVfit(Y = M, X = grp, ctl = ctl2) # Stage 2 analysis
rfit4 <- RUVadj(Y = M, fit = rfit3)
# Look at table of top results
topRUV(rfit4)
```

```
##              F.p F.p.BH p_X1.1 p.BH_X1.1    b_X1.1    sigma2 var.b_X1.1 fit.ctl
## cg07155336 1e-24  1e-24  1e-24     1e-24 -5.769286 0.1668414  0.1349771   FALSE
## cg06463958 1e-24  1e-24  1e-24     1e-24 -5.733093 0.1668414  0.1349771   FALSE
## cg00024472 1e-24  1e-24  1e-24     1e-24 -5.662959 0.1668414  0.1349771   FALSE
## cg02040433 1e-24  1e-24  1e-24     1e-24 -5.651399 0.1668414  0.1349771   FALSE
## cg13355248 1e-24  1e-24  1e-24     1e-24 -5.595396 0.1668414  0.1349771   FALSE
## cg02467990 1e-24  1e-24  1e-24     1e-24 -5.592707 0.1668414  0.1349771   FALSE
## cg00817367 1e-24  1e-24  1e-24     1e-24 -5.527501 0.1668414  0.1349771   FALSE
## cg11396157 1e-24  1e-24  1e-24     1e-24 -5.487992 0.1668414  0.1349771   FALSE
## cg16306898 1e-24  1e-24  1e-24     1e-24 -5.466780 0.1668414  0.1349771   FALSE
## cg03735888 1e-24  1e-24  1e-24     1e-24 -5.396242 0.1668414  0.1349771   FALSE
##                  mean
## cg07155336 -1.2767641
## cg06463958  0.2776252
## cg00024472 -2.4445762
## cg02040433 -1.2918259
## cg13355248 -0.8483387
## cg02467990 -0.4154370
## cg00817367 -0.2911294
## cg11396157 -1.3800170
## cg16306898 -2.1469768
## cg03735888 -1.1527557
```

## 7.1 Alternative approach for RUVm stage 1

If the number of samples in your experiment is *greater* than the number of
Illumina negative controls on the array platform used - 613 for 450k, 411 for
EPIC - stage 1 of **RUVm** will not work. In such cases, we recommend performing
a standard *[limma](https://bioconductor.org/packages/3.22/limma)* analysis in stage 1.

```
# setup design matrix
des <- model.matrix(~grp)
des
```

```
##   (Intercept) grp1
## 1           1    1
## 2           1    1
## 3           1    0
## 4           1    0
## 5           1    1
## 6           1    0
## attr(,"assign")
## [1] 0 1
## attr(,"contrasts")
## attr(,"contrasts")$grp
## [1] "contr.treatment"
```

```
# limma differential methylation analysis
lfit1 <- lmFit(M, design=des)
lfit2 <- eBayes(lfit1) # Stage 1 analysis
# Look at table of top results
topTable(lfit2)
```

```
## Removing intercept from test coefficients
```

```
##                logFC   AveExpr         t      P.Value   adj.P.Val        B
## cg07155336 -6.037439 -1.276764 -19.22210 1.175108e-07 0.005755968 7.635736
## cg04743961 -4.887986 -2.317315 -19.21709 1.177367e-07 0.005755968 7.634494
## cg03607359 -4.393946 -2.191871 -18.07007 1.852304e-07 0.005755968 7.334032
## cg13272280 -4.559707 -2.099665 -17.25531 2.599766e-07 0.005755968 7.099628
## cg22263007 -4.438420 -1.010994 -17.12384 2.749857e-07 0.005755968 7.060036
## cg03556069 -5.456754 -1.811718 -17.00720 2.891269e-07 0.005755968 7.024476
## cg08443814 -4.597347 -2.062275 -16.80835 3.151706e-07 0.005755968 6.962907
## cg18672939 -5.159383 -0.705992 -16.65643 3.368597e-07 0.005755968 6.915046
## cg24385334 -4.157473 -1.943370 -16.59313 3.463909e-07 0.005755968 6.894890
## cg18044663 -4.426118 -1.197724 -16.57851 3.486357e-07 0.005755968 6.890216
```

The results of this can then be used to define ECPs for stage 2, as in the
previous example.

```
topl1 <- topTable(lfit2, num=Inf)
```

```
## Removing intercept from test coefficients
```

```
head(topl1)
```

```
##                logFC   AveExpr         t      P.Value   adj.P.Val        B
## cg07155336 -6.037439 -1.276764 -19.22210 1.175108e-07 0.005755968 7.635736
## cg04743961 -4.887986 -2.317315 -19.21709 1.177367e-07 0.005755968 7.634494
## cg03607359 -4.393946 -2.191871 -18.07007 1.852304e-07 0.005755968 7.334032
## cg13272280 -4.559707 -2.099665 -17.25531 2.599766e-07 0.005755968 7.099628
## cg22263007 -4.438420 -1.010994 -17.12384 2.749857e-07 0.005755968 7.060036
## cg03556069 -5.456754 -1.811718 -17.00720 2.891269e-07 0.005755968 7.024476
```

```
ctl3 <- rownames(M) %in% rownames(topl1[topl1$adj.P.Val > 0.5,])
table(ctl3)
```

```
## ctl3
##  FALSE   TRUE
## 199150 286362
```

We can then use the ECPs to perform a second differential methylation
with `RUV-inverse` as before.

```
# Perform RUV adjustment and fit
rfit5 <- RUVfit(Y = M, X = grp, ctl = ctl3) # Stage 2 analysis
rfit6 <- RUVadj(Y = M, fit = rfit5)
# Look at table of top results
topRUV(rfit6)
```

```
##              F.p F.p.BH p_X1.1 p.BH_X1.1    b_X1.1    sigma2 var.b_X1.1 fit.ctl
## cg06463958 1e-24  1e-24  1e-24     1e-24 -5.910598 0.1667397  0.1170589   FALSE
## cg07155336 1e-24  1e-24  1e-24     1e-24 -5.909549 0.1667397  0.1170589   FALSE
## cg02467990 1e-24  1e-24  1e-24     1e-24 -5.841079 0.1667397  0.1170589   FALSE
## cg00024472 1e-24  1e-24  1e-24     1e-24 -5.823529 0.1667397  0.1170589   FALSE
## cg01893212 1e-24  1e-24  1e-24     1e-24 -5.699627 0.1667397  0.1170589   FALSE
## cg11396157 1e-24  1e-24  1e-24     1e-24 -5.699331 0.1667397  0.1170589   FALSE
## cg13355248 1e-24  1e-24  1e-24     1e-24 -5.658606 0.1667397  0.1170589   FALSE
## cg00817367 1e-24  1e-24  1e-24     1e-24 -5.649284 0.1667397  0.1170589   FALSE
## cg16306898 1e-24  1e-24  1e-24     1e-24 -5.610118 0.1667397  0.1170589   FALSE
## cg16556906 1e-24  1e-24  1e-24     1e-24 -5.567659 0.1667397  0.1170589   FALSE
##                   mean
## cg06463958  0.27762518
## cg07155336 -1.27676413
## cg02467990 -0.41543703
## cg00024472 -2.44457624
## cg01893212 -0.08273355
## cg11396157 -1.38001701
## cg13355248 -0.84833866
## cg00817367 -0.29112939
## cg16306898 -2.14697683
## cg16556906 -0.96821744
```

## 7.2 Visualising the effect of RUVm adjustment

To visualise the effect that the **RUVm** adjustment is having on the data,
using an MDS plot for example, the `getAdj` function can be used to extract
the adjusted values from the **RUVm** fit object produced by `RUVfit`.
NOTE: The adjusted values should only be used for visualisations - it is NOT
recommended that they are used in any downstream analysis.

```
Madj <- getAdj(M, rfit5) # get adjusted values
```

The MDS plots below show how the relationship between the samples changes with and
without **RUVm** adjustment. **RUVm** reduces the distance between the samples in
each group by removing unwanted variation. It can be useful to examine this
type of plot when trying to decide on the best set of ECPs or to help select the
optimal value of \(k\), if using *RUV-4* or *RUV-2*.

```
par(mfrow=c(1,2))
plotMDS(M, labels=targets$Sample_Name, col=as.integer(factor(targets$status)),
        main="Unadjusted", gene.selection = "common")
legend("right",legend=c("Cancer","Normal"),pch=16,cex=1,col=1:2)
plotMDS(Madj, labels=targets$Sample_Name, col=as.integer(factor(targets$status)),
        main="Adjusted: RUV-inverse", gene.selection = "common")
```

```
## Warning in plotMDS.default(Madj, labels = targets$Sample_Name, col =
## as.integer(factor(targets$status)), : dimension 2 is degenerate or all zero
```

```
legend("topright",legend=c("Cancer","Normal"),pch=16,cex=1,col=1:2)
```

![RUVm adjusted data. An MDS plot of cancer and normal data, before and after RUVm adjustment.](data:image/png;base64...)

Figure 4: RUVm adjusted data
An MDS plot of cancer and normal data, before and after RUVm adjustment.

To illustrate how the `getAdj` function can be used to help select an
appropriate value for \(k\), we will run the second stage of the **RUVm** analysis
using *RUV-4* with two different \(k\) values.

```
# Use RUV-4 in stage 2 of RUVm with k=1 and k=2
rfit7 <- RUVfit(Y = M, X = grp, ctl = ctl3,
                method = "ruv4", k=1) # Stage 2 with RUV-4, k=1
rfit9 <- RUVfit(Y = M, X = grp, ctl = ctl3,
                method = "ruv4", k=2) # Stage 2 with RUV-4, k=2
# get adjusted values
Madj1 <- getAdj(M, rfit7)
Madj2 <- getAdj(M, rfit9)
```

The following MDS plots show how the relationship between the samples changes
from the unadjusted data to data adjusted with *RUV-inverse* and *RUV-4* with
two different \(k\) values. For this small dataset, *RUV-inverse* appears to be
removing far too much variation as we can see the samples in each group are
completely overlapping. Using *RUV-4* and choosing a smaller value for \(k\)
produces more sensible results.

```
par(mfrow=c(2,2))
plotMDS(M, labels=targets$Sample_Name, col=as.integer(factor(targets$status)),
        main="Unadjusted", gene.selection = "common")
legend("top",legend=c("Cancer","Normal"),pch=16,cex=1,col=1:2)
plotMDS(Madj, labels=targets$Sample_Name, col=as.integer(factor(targets$status)),
        main="Adjusted: RUV-inverse", gene.selection = "common")
```

```
## Warning in plotMDS.default(Madj, labels = targets$Sample_Name, col =
## as.integer(factor(targets$status)), : dimension 2 is degenerate or all zero
```

```
legend("topright",legend=c("Cancer","Normal"),pch=16,cex=1,col=1:2)
plotMDS(Madj1, labels=targets$Sample_Name, col=as.integer(factor(targets$status)),
        main="Adjusted: RUV-4, k=1", gene.selection = "common")
legend("bottom",legend=c("Cancer","Normal"),pch=16,cex=1,col=1:2)
plotMDS(Madj2, labels=targets$Sample_Name, col=as.integer(factor(targets$status)),
        main="Adjusted: RUV-4, k=2", gene.selection = "common")
legend("bottomright",legend=c("Cancer","Normal"),pch=16,cex=1,col=1:2)
```

![Effect of different adjustment methods and parameters. MDS plots of cancer and normal data before an after adjustment with RUV-inverse and RUV-4 with different k values.](data:image/png;base64...)

Figure 5: Effect of different adjustment methods and parameters
MDS plots of cancer and normal data before an after adjustment with RUV-inverse and RUV-4 with different k values.

More information about the various RUV methods can be found at
<http://www-personal.umich.edu/~johanngb/ruv/>,
including links to all relevant publications. Further examples of
RUV analyses, with code, can be found at <https://github.com/johanngb/ruv-useR2018>.
The tutorials demonstrate how the various plotting functions
available in the *[ruv](https://CRAN.R-project.org/package%3Druv)* package (which are not
covered in this vignette) can be used to select sensible parameters and assess
if the adjustment is “helping” your analysis.

# 8 Testing for differential variability (DiffVar)

## 8.1 Methylation data

Rather than testing for differences in mean methylation, we may be
interested in testing for differences between group variances. For
example, it has been hypothesised that highly variable CpGs in cancer
are important for tumour progression (Hansen et al. [2011](#ref-Hansen2011)). Hence we may be
interested in CpG sites that are consistently methylated in the normal
samples, but variably methylated in the cancer samples.

In general we recommend at least 10 samples in each group for accurate
variance estimation, however for the purpose of this vignette we perform
the analysis on 3 vs 3. In this example, we are interested in testing
for differential variability in the cancer versus normal group.

An important note on the `coef` parameter: please always explicitly state which
columns of design matrix correspond to the groups that you are interested in
testing for differential variability. The default setting for `coef` is to
include all columns of the design matrix when calculating the Levene residuals,
which is not suitable for when there are additional variables that need to be
taken into account in the linear model. To avoid misspecification of the model,
it is best to explicitly state the `coef` parameter. The additional nuisance or
confounding variables will still be taken into account in the linear
modelling step, however we find that including them when calculating Levene
residuals often removes all the (possibly interesting) variation in the data.

When the design matrix includes an intercept term, the `coef` parameter must
include both the intercept and groups of interest. Consider the design matrix
that was used when performing the limma analysis:

```
design
```

```
##   (Intercept) idid2 idid3 groupcancer
## 1           1     0     1           0
## 2           1     1     0           0
## 3           1     0     1           1
## 4           1     0     0           1
## 5           1     0     0           0
## 6           1     1     0           1
## attr(,"assign")
## [1] 0 1 1 2
## attr(,"contrasts")
## attr(,"contrasts")$id
## [1] "contr.treatment"
##
## attr(,"contrasts")$group
## [1] "contr.treatment"
```

The first column of the design matrix is the intercept term, and the fourth
column tells us which samples are cancer and normal samples. The 2nd and 3rd
columns correspond to the ID parameter, which is not interesting in terms of
finding differentially variable CpGs, but may be important to include in the
linear model. Hence for this example we would specify `coef = c(1,4)` in the
call to `varFit`.

For methylation data, the `varFit` function will take
either a matrix of M-values, \(\beta\) values or a `MethylSet` object as input. If
\(\beta\) values are supplied, a logit transformation is performed. Note
that as a default, `varFit` uses the robust setting in the
*[limma](https://bioconductor.org/packages/3.22/limma)* framework, which requires the use of the
*[statmod](https://CRAN.R-project.org/package%3Dstatmod)* package.

```
fitvar <- varFit(Mval, design = design, coef = c(1,4))
```

The numbers of hyper-variable (1) and hypo-variable (-1) genes in **cancer**
vs **normal** can be obtained using `decideTests`. In the cancer vs normal
context, we would expect to see more variability in methylation in cancer
compared to normal (i.e. hyper-variable).

```
summary(decideTests(fitvar))
```

```
##        (Intercept) idid2 idid3 groupcancer
## Down             0     3     1           0
## NotSig       19729 19996 19992       19991
## Up             271     1     7           9
```

```
topDV <- topVar(fitvar, coef=4)
topDV
```

```
##            SampleVar LogVarRatio DiffLevene        t      P.Value Adj.P.Value
## cg13516820  5.693633    3.440883   2.893331 5.428688 5.709927e-08 0.001141985
## cg14267725  8.273639    4.376505   2.887023 4.865584 1.145528e-06 0.008588383
## cg22091297  6.128033    4.057406   2.818603 4.842297 1.288257e-06 0.008588383
## cg26744375  6.096371    2.678234   2.470275 4.733205 2.217569e-06 0.011087843
## cg23071808  5.565394    3.374474   2.651520 4.686412 2.789507e-06 0.011158027
## cg24879782  4.762236    3.849243   2.718175 4.642914 3.446186e-06 0.011487287
## cg15174834  4.890373    3.839492   2.634932 4.427157 9.573588e-06 0.027353108
## cg09912667  4.224011    5.043604   2.779896 4.391108 1.130638e-05 0.028265943
## cg09028204  5.234278    2.963062   2.416096 4.341057 1.421467e-05 0.031588166
## cg17969902  4.847358    3.689861   2.492191 4.078774 4.536149e-05 0.090722987
```

An alternate parameterisation of the design matrix that does not include
an intercept term can also be used (i.e. a cell means model), and specific
contrasts tested with `contrasts.varFit`.
Here we specify the design matrix such that the first two columns
correspond to the **normal** and **cancer** groups, respectively. Note that we
now specify `coef=c(1,2)`.

```
design2 <- model.matrix(~0+group+id)
fitvar.contr <- varFit(Mval, design=design2, coef=c(1,2))
contr <- makeContrasts(groupcancer-groupnormal,levels=colnames(design2))
fitvar.contr <- contrasts.varFit(fitvar.contr,contrasts=contr)
```

The results are identical to before.

```
summary(decideTests(fitvar.contr))
```

```
##        groupcancer - groupnormal
## Down                           0
## NotSig                     19991
## Up                             9
```

```
topVar(fitvar.contr,coef=1)
```

```
##            SampleVar LogVarRatio DiffLevene        t      P.Value Adj.P.Value
## cg13516820  5.693633    3.440883   2.893331 5.428688 5.709927e-08 0.001141985
## cg14267725  8.273639    4.376505   2.887023 4.865584 1.145528e-06 0.008588383
## cg22091297  6.128033    4.057406   2.818603 4.842297 1.288257e-06 0.008588383
## cg26744375  6.096371    2.678234   2.470275 4.733205 2.217569e-06 0.011087843
## cg23071808  5.565394    3.374474   2.651520 4.686412 2.789507e-06 0.011158027
## cg24879782  4.762236    3.849243   2.718175 4.642914 3.446186e-06 0.011487287
## cg15174834  4.890373    3.839492   2.634932 4.427157 9.573588e-06 0.027353108
## cg09912667  4.224011    5.043604   2.779896 4.391108 1.130638e-05 0.028265943
## cg09028204  5.234278    2.963062   2.416096 4.341057 1.421467e-05 0.031588166
## cg17969902  4.847358    3.689861   2.492191 4.078774 4.536149e-05 0.090722987
```

The \(\beta\) values for the top 4 differentially variable CpGs can be
seen in Figure [6](#fig:top4DV).

```
cpgsDV <- rownames(topDV)
par(mfrow=c(2,2))
for(i in 1:4){
stripchart(beta[rownames(beta)==cpgsDV[i],]~design[,4],method="jitter",
group.names=c("Normal","Cancer"),pch=16,cex=1.5,col=c(4,2),ylab="Beta values",
vertical=TRUE,cex.axis=1.5,cex.lab=1.5)
title(cpgsDV[i],cex.main=1.5)
}
```

![Top DV CpGs. The beta values for the top 4 differentially variable CpGs.](data:image/png;base64...)

Figure 6: Top DV CpGs
The beta values for the top 4 differentially variable CpGs.

## 8.2 RNA-Seq expression data

Testing for differential variability in expression data is
straightforward if the technology is gene expression microarrays. The
matrix of expression values can be supplied directly to the `varFit` function.
For RNA-Seq data, the mean-variance relationship that occurs in count
data needs to be taken into account. In order to deal with this issue,
we apply a `voom` transformation (Law et al. [2014](#ref-Law2014)) to obtain observation weights, which
are then used in the linear modelling step. For RNA-Seq data, the `varFit`
function will take a `DGElist` object as input.

To demonstrate this, we use data from the
*[tweeDEseqCountData](https://bioconductor.org/packages/3.22/tweeDEseqCountData)* package. This data is part of the International HapMap project, consisting of
RNA-Seq profiles from 69 unrelated Nigerian individuals (Pickrell et al. [2010](#ref-Pickrell2010)). The
only covariate is gender, so we can look at differentially variable expression
between males and females. We follow the code from the
*[limma](https://bioconductor.org/packages/3.22/limma)* vignette to read in and process the data before
testing for differential variability.

First we load up the data and extract the relevant information.

```
library(tweeDEseqCountData)
data(pickrell1)
counts<-exprs(pickrell1.eset)
dim(counts)
```

```
## [1] 38415    69
```

```
gender <- pickrell1.eset$gender
table(gender)
```

```
## gender
## female   male
##     40     29
```

```
rm(pickrell1.eset)
data(genderGenes)
data(annotEnsembl63)
annot <- annotEnsembl63[,c("Symbol","Chr")]
rm(annotEnsembl63)
```

We now have the counts, gender of each sample and annotation (gene
symbol and chromosome) for each Ensemble gene. We can form a `DGElist` object
using the *[edgeR](https://bioconductor.org/packages/3.22/edgeR)* package.

```
library(edgeR)
y <- DGEList(counts=counts, genes=annot[rownames(counts),])
```

We filter out lowly expressed genes by keeping genes with at least 1
count per million reads in at least 20 samples, as well as genes that
have defined annotation. Finally we perform scaling normalisation.

```
isexpr <- rowSums(cpm(y)>1) >= 20
hasannot <- rowSums(is.na(y$genes))==0
y <- y[isexpr & hasannot,,keep.lib.sizes=FALSE]
dim(y)
```

```
## [1] 17310    69
```

```
y <- calcNormFactors(y)
```

We set up the design matrix and test for differential variability.

```
design.hapmap <- model.matrix(~gender)
fitvar.hapmap <- varFit(y, design = design.hapmap, coef=c(1,2))
```

```
## Converting counts to log counts-per-million using voom.
```

```
fitvar.hapmap$genes <- y$genes
```

We can display the results of the test:

```
summary(decideTests(fitvar.hapmap))
```

```
##        (Intercept) gendermale
## Down             0          2
## NotSig           0      17308
## Up           17310          0
```

```
topDV.hapmap <- topVar(fitvar.hapmap,coef=ncol(design.hapmap))
topDV.hapmap
```

```
##                       Symbol Chr  SampleVar LogVarRatio DiffLevene         t
## ENSG00000213318 RP11-331F4.1  16 5.69839463   -2.562939 -0.9873072 -8.043479
## ENSG00000129824       RPS4Y1   Y 2.32497726   -2.087025 -0.4581834 -4.942033
## ENSG00000233864       TTTY15   Y 6.79004140   -2.245369 -0.6084678 -4.529415
## ENSG00000176171        BNIP3  10 0.41317384    1.199292  0.3635909  4.221153
## ENSG00000197358      BNIP3P1  14 0.39969125    1.149754  0.3357314  4.061035
## ENSG00000025039        RRAGD   6 0.91837213    1.091229  0.4928779  3.976688
## ENSG00000103671        TRIP4  15 0.07456448   -1.457139 -0.1520311 -3.915810
## ENSG00000171100         MTM1   X 0.44049558   -1.133295 -0.3336303 -3.910918
## ENSG00000149476          DAK  11 0.13289523   -1.470460 -0.1920176 -3.787801
## ENSG00000157828       RPS4Y2   Y 2.95789619   -1.417305 -0.2793904 -3.782506
##                      P.Value  Adj.P.Value
## ENSG00000213318 6.980147e-12 1.208263e-07
## ENSG00000129824 4.219220e-06 3.651735e-02
## ENSG00000233864 2.058016e-05 1.187475e-01
## ENSG00000176171 6.417937e-05 2.777362e-01
## ENSG00000197358 1.138836e-04 3.942650e-01
## ENSG00000025039 1.532798e-04 4.170847e-01
## ENSG00000103671 1.895160e-04 4.170847e-01
## ENSG00000171100 1.927601e-04 4.170847e-01
## ENSG00000149476 2.942622e-04 4.609062e-01
## ENSG00000157828 2.996120e-04 4.609062e-01
```

The log counts per million for the top 4 differentially variable genes
can be seen in Figure [7](#fig:top4DVhapmap).

```
genesDV <- rownames(topDV.hapmap)
par(mfrow=c(2,2))
for(i in 1:4){
stripchart(cpm(y,log=TRUE)[rownames(y)==genesDV[i],]~design.hapmap[,ncol(design.hapmap)],method="jitter",
group.names=c("Female","Male"),pch=16,cex=1.5,col=c(4,2),ylab="Log counts per million",
vertical=TRUE,cex.axis=1.5,cex.lab=1.5)
title(genesDV[i],cex.main=1.5)
}
```

![Top DV CpGs. The log counts per million for the top 4 differentially variably expressed genes.](data:image/png;base64...)

Figure 7: Top DV CpGs
The log counts per million for the top 4 differentially variably expressed genes.

# 9 Gene ontology analysis

Once a differential methylation or differential variability analysis has
been performed, it may be of interest to know which gene pathways are
targeted by the significant CpG sites. Geeleher et al.
(Geeleher et al. [2013](#ref-Geeleher2013)) showed there is a severe bias when performing gene
ontology analysis with methylation data. This is due to the fact that
there are differing numbers of probes per gene on several different
array technologies. For the Illumina Infinium HumanMethylation450 array
the number of probes per gene ranges from 1 to 1299, with a median of 15
probes per gene. For the EPIC array, the range is 1 to 1487, with a
median of 20 probes per gene. This means that when annotating CpG sites to
genes, a gene is more likely to be identified as differentially methylated if
there are many CpG sites associated with the gene. We refer to this source of
bias as “probe number bias”.

One way to take into account this selection bias is to model the
relationship between the number of probes per gene and the probability
of being differentially methylated. This can be performed by adapting the
*[goseq](https://bioconductor.org/packages/3.22/goseq)* method of Young et al. (Young et al. [2010](#ref-Young2010)). Each gene
then has a prior probability associated with it, and a modified version of a
hypergeometric test can be performed, testing for over-representation of the
selected genes in each gene set. The *[BiasedUrn](https://bioconductor.org/packages/3.22/BiasedUrn)* package
can be used to obtain p-values from the Wallenius’ noncentral hypergeometric
distribution, taking into account the odds of differential methylation for each
gene set. Note that the *[BiasedUrn](https://bioconductor.org/packages/3.22/BiasedUrn)* package can
occassionally return p-values of 0. For the gene sets where a p-value of exactly
zero is outputted we perform a hypergeometric test, which ensures non-zero
p-values and hence false discovery rates.

We have recently uncovered a new source of bias in gene set testing for
methylation array data (Maksimovic, Oshlack, and Phipson [2020](#ref-Maksimovic2020.08.24.265702)) that we refer to as
“multi-gene bias”. This second source of bias arises due to the fact that
around 10% of gene-annotated CpGs are annotated to more than one gene, violating
assumptions of independently measured genes. This can lead to some GO categories
being identified as significantly enriched as they contain genes with
methylation measurements from shared CpGs. This can occur for large gene
families such as the protocadherin gamma gene cluster which happen to be
over-represented in the GO category “GO:0007156: homophilic cell adhesion via
plasma membrane adhesion molecules”. This is now taken into account in the
gene set testing functions in *[missMethyl](https://bioconductor.org/packages/3.22/missMethyl)*.

We have developed methods for both CpG and region level analyses. The `gometh`
function performs gene set testing on GO categories or KEGG pathways for
significant CpG sites. The `gsameth` function is a more generalised gene set
testing function which can take as input a list of user specified gene sets.
Note that for `gsameth`, the format for the gene ids for each gene in the gene
set needs to be **Entrez Gene IDs**. For example, the entire curated gene
set list (C2) from the Broad’s Molecular Signatures Database can be
specified as input. The R version of these lists can be downloaded from
[http://bioinf.wehi.edu.au/software/MSigDB/index.html](here). Both functions
take a vector of significant CpG probe names as input. For a region level
analysis, using the *[DMRcate](https://bioconductor.org/packages/3.22/DMRcate)* package, for example,
`goregion` and `gsaregion` can perform gene set enrichment analysis using the
ranged object as input.

NOTE ON UPDATES IN SEPTEMBER 2020: We have added new functionality to the
gene set testing functions to allow the user to limit the input CpGs to specific
genomic features of interest using the `genomic.features` argument. This is
based on the annotation information in the manifest files for the 450K and EPIC
arrays. Possible values are "“ALL”, “TSS200”, “TSS1500”, “Body”, “1stExon”,
“3’UTR”, “5’UTR” and “ExonBnd” (only for EPIC), and any combination can be
specified. In order to include the significant genes that overlap with the gene
set of interest, the `sig.genes` parameter can be set to `TRUE`. This adds an
additional column to the results dataframe.

## 9.1 CpG level analysis

To illustrate how to use `gometh`, consider the results from the differential
methylation analysis with **RUVm**.

```
top <- topRUV(rfit4, number = Inf, p.BH = 1)
table(top$p.BH_X1.1 < 0.01)
```

```
##
##  FALSE   TRUE
## 424168  61344
```

At a 1% false discovery rate cut-off, there are more than 60,000 CpG sites
differentially methylated. These CpGs are annotated to almost 10,000 genes,
which means that a gene ontology analysis is unlikely to be relevant or
reveal anything biologically interesting. One option for selecting CpGs in this
context is to apply not only a false discovery rate cut-off, but also a
\(\Delta\beta\) cut-off. However, for this dataset, taking a relatively large
\(\Delta\beta\) cut-off of 0.25 still leaves more than 30000 CpGs
differentially methylated, which can be annotated to more than 6000 genes.

```
beta <- getBeta(mSet)
# make sure that order of beta values matches orer after analysis
beta <- beta[match(rownames(top),rownames(beta)),]
beta_norm <- rowMeans(beta[,grp==0])
beta_can <- rowMeans(beta[,grp==1])
Delta_beta <- beta_can - beta_norm
sigDM <- top$p.BH_X1.1 < 0.01 & abs(Delta_beta) > 0.25
table(sigDM)
```

```
## sigDM
##  FALSE   TRUE
## 451760  33748
```

Instead, we take the top 10000 CpG sites as input to `gometh` which can be
annotated to around 2500 genes.

```
topCpGs<-topRUV(rfit4,number=10000)
sigCpGs <- rownames(topCpGs)
sigCpGs[1:10]
```

```
##  [1] "cg07155336" "cg06463958" "cg00024472" "cg02040433" "cg13355248"
##  [6] "cg02467990" "cg00817367" "cg11396157" "cg16306898" "cg03735888"
```

```
# Check number of genes that significant CpGs are annotated to
check <- getMappedEntrezIDs(sig.cpg = sigCpGs)
```

```
## All input CpGs are used for testing.
```

```
length(check$sig.eg)
```

```
## [1] 2490
```

The`gometh` function takes as input a character vector of CpG names, and
optionally, a character vector of all CpG sites tested. This is important to
include if filtering of the CpGs has been performed prior to differential
methylation analysis. If the `all.cpg` argument is omitted, all the CpGs on the
array are used as background. To change the array type, the `array.type`
argument can be specified as either “450K”, “EPIC” or “EPIC\_V2”. The default is
“450K”.

If the `plot.bias` argument is `TRUE`, a figure showing the relationship
between the probability of differential methylation and the number of probes per
gene will be displayed.

For testing of GO terms, the `collection` argument takes the value
“GO”, which is the default setting. For KEGG pathway analysis, set
`collection` to “KEGG”. The function `topGSA` shows the top enriched GO
categories. The `gsameth` function is called for GO and KEGG pathway analysis
with the appropriate inputs.

For GO testing on our example dataset:

```
library(IlluminaHumanMethylation450kanno.ilmn12.hg19)
gst <- gometh(sig.cpg=sigCpGs, all.cpg=rownames(top), collection="GO",
              plot.bias=TRUE)
```

```
## All input CpGs are used for testing.
```

![Probe number bias in the cancer dataset.](data:image/png;base64...)

Figure 8: Probe number bias in the cancer dataset

```
topGSA(gst, n=10)
```

```
##            ONTOLOGY                               TERM    N   DE         P.DE
## GO:0048731       BP                 system development 4182  933 8.174793e-40
## GO:0007399       BP         nervous system development 2650  667 2.338500e-35
## GO:0007275       BP multicellular organism development 4849 1002 3.570781e-32
## GO:0048699       BP              generation of neurons 1556  439 5.108098e-30
## GO:0048856       BP   anatomical structure development 6121 1162 9.220206e-30
## GO:0030182       BP             neuron differentiation 1477  419 6.305756e-29
## GO:0022008       BP                       neurogenesis 1818  484 1.005211e-27
## GO:0032502       BP              developmental process 6695 1220 5.290359e-27
## GO:0032501       BP   multicellular organismal process 7529 1292 1.759721e-25
## GO:0071944       CC                     cell periphery 5984 1057 5.704921e-24
##                     FDR
## GO:0048731 1.805403e-35
## GO:0007399 2.582289e-31
## GO:0007275 2.628690e-28
## GO:0048699 2.820309e-26
## GO:0048856 4.072565e-26
## GO:0030182 2.321044e-25
## GO:0022008 3.171440e-24
## GO:0032502 1.460470e-23
## GO:0032501 4.318161e-22
## GO:0071944 1.259932e-20
```

Testing all GO categories (>20,000) can be a little slow. To demonstrate
the `genomic.features` parameter, let us rather focus on KEGG pathways
(~330 pathways).

```
gst.kegg <- gometh(sig.cpg=sigCpGs, all.cpg=rownames(top), collection="KEGG")
```

```
## All input CpGs are used for testing.
```

```
topGSA(gst.kegg, n=10)
```

```
##                                      Description   N DE         P.DE
## hsa04080 Neuroactive ligand-receptor interaction 364 81 2.177236e-08
## hsa04020               Calcium signaling pathway 250 76 5.884977e-08
## hsa04082            Neuroactive ligand signaling 199 58 2.291602e-06
## hsa04514                 Cell adhesion molecules 153 48 8.833186e-06
## hsa04081                       Hormone signaling 217 52 2.657449e-05
## hsa04970                      Salivary secretion  92 27 1.100661e-04
## hsa04024                  cAMP signaling pathway 225 57 1.309032e-04
## hsa04950    Maturity onset diabetes of the young  26 12 2.855415e-04
## hsa04151              PI3K-Akt signaling pathway 347 79 7.369812e-04
## hsa04517                      IgSF CAM signaling 294 75 8.911533e-04
##                   FDR
## hsa04080 8.012229e-06
## hsa04020 1.082836e-05
## hsa04082 2.811032e-04
## hsa04514 8.126531e-04
## hsa04081 1.955882e-03
## hsa04970 6.750723e-03
## hsa04024 6.881767e-03
## hsa04950 1.313491e-02
## hsa04151 3.013434e-02
## hsa04517 3.279444e-02
```

We can limit the input CpGs to those in the promoter regions of genes:

```
gst.kegg.prom <- gometh(sig.cpg=sigCpGs, all.cpg=rownames(top),
                        collection="KEGG", genomic.features = c("TSS200",
                                                                "TSS1500",
                                                                "1stExon"))
topGSA(gst.kegg.prom, n=10)
```

```
##                                      Description   N DE         P.DE
## hsa04080 Neuroactive ligand-receptor interaction 364 58 2.740941e-09
## hsa04081                       Hormone signaling 217 38 1.758637e-06
## hsa04082            Neuroactive ligand signaling 199 39 2.903301e-06
## hsa04020               Calcium signaling pathway 250 46 8.316483e-06
## hsa04024                  cAMP signaling pathway 225 37 1.695552e-04
## hsa04514                 Cell adhesion molecules 153 29 2.072059e-04
## hsa04911                       Insulin secretion  86 19 5.015236e-04
## hsa04517                      IgSF CAM signaling 294 47 8.656899e-04
## hsa05032                      Morphine addiction  91 20 9.657744e-04
## hsa05217                    Basal cell carcinoma  63 15 1.529262e-03
##                   FDR
## hsa04080 1.008666e-06
## hsa04081 3.235893e-04
## hsa04082 3.561383e-04
## hsa04020 7.651164e-04
## hsa04024 1.247926e-02
## hsa04514 1.270863e-02
## hsa04911 2.636581e-02
## hsa04517 3.948944e-02
## hsa05032 3.948944e-02
## hsa05217 5.351874e-02
```

We can see if the results are different if we only include CpGs in gene bodies:

```
gst.kegg.body <- gometh(sig.cpg=sigCpGs, all.cpg=rownames(top),
                        collection="KEGG", genomic.features = c("Body"))
topGSA(gst.kegg.body, n=10)
```

```
##                                                       Description   N DE
## hsa04514                                  Cell adhesion molecules 153 29
## hsa04820                             Cytoskeleton in muscle cells 233 38
## hsa04974                         Protein digestion and absorption 102 19
## hsa04020                                Calcium signaling pathway 250 40
## hsa04512                                 ECM-receptor interaction  89 19
## hsa04640                               Hematopoietic cell lineage  93 15
## hsa04950                     Maturity onset diabetes of the young  26  7
## hsa04151                               PI3K-Akt signaling pathway 347 45
## hsa04550 Signaling pathways regulating pluripotency of stem cells 141 24
## hsa05410                              Hypertrophic cardiomyopathy  99 17
##                  P.DE        FDR
## hsa04514 0.0002590916 0.05167496
## hsa04820 0.0003508476 0.05167496
## hsa04974 0.0004212632 0.05167496
## hsa04020 0.0007278618 0.05384491
## hsa04512 0.0008302229 0.05384491
## hsa04640 0.0008779062 0.05384491
## hsa04950 0.0056792228 0.29856485
## hsa04151 0.0066321183 0.30507744
## hsa04550 0.0077294688 0.31604939
## hsa05410 0.0101644641 0.34842299
```

The KEGG pathways are quite different when limiting CpGs to those in gene bodies
versus CpGs in promoters. To include the significant genes that overlap with
each gene set, set the `sig.genes` parameter to TRUE.

```
gst.kegg.body <- gometh(sig.cpg=sigCpGs, all.cpg=rownames(top),
                        collection="KEGG", genomic.features = c("Body"),
                        sig.genes = TRUE)
topGSA(gst.kegg.body, n=5)
```

```
##                               Description   N DE         P.DE        FDR
## hsa04514          Cell adhesion molecules 153 29 0.0002590916 0.05167496
## hsa04820     Cytoskeleton in muscle cells 233 38 0.0003508476 0.05167496
## hsa04974 Protein digestion and absorption 102 19 0.0004212632 0.05167496
## hsa04020        Calcium signaling pathway 250 40 0.0007278618 0.05384491
## hsa04512         ECM-receptor interaction  89 19 0.0008302229 0.05384491
##                                                                                                                                                                                                                                                          SigGenesInSet
## hsa04514                                                                             CDH2,CDH4,CNTNAP2,ICOS,HLA-DQA2,HLA-DQB1,HLA-DQB2,HLA-F,HLA-G,ITGA4,ITGAM,MAG,NCAM1,CLDN11,CLDN18,PDCD1,PTPRM,PTPRS,JAM2,SDC2,JAM3,NTNG2,ITGA8,CLDN12,CLDN1,CD8A,NRXN1,NRXN2,CD34
## hsa04820                COL1A2,COL4A1,COL4A2,COL4A3,COL5A1,COL5A2,COL6A3,COL11A2,COMP,SGCZ,SYNE3,ELN,FBLN1,FBLN2,MYH15,SUN1,COL24A1,PDLIM3,LAMA1,ITGA4,ITGB4,ITGB5,AGRN,LAMA2,MYBPC3,MYH11,NID1,ATP1B2,FMN2,SPTBN4,ACTA1,SDC2,TNNI2,TNNT3,VIM,OBSCN,ITGA8,COL27A1,SGCE
## hsa04974                                                                                                                 COL1A2,COL4A1,COL4A2,COL4A3,COL5A1,COL5A2,COL6A3,COL11A2,COL15A1,CPA2,COL26A1,COL22A1,ELN,COL24A1,KCNQ1,ATP1B2,SLC8A2,COL18A1,COL27A1,COL23A1
## hsa04020 ADCY1,GRIN3A,ADRA1B,ADCY4,ERBB4,FGF3,FGFR2,P2RX2,FLT1,FLT4,GDNF,GRIN2A,GRIN2D,GRM5,HTR2A,ITPKB,ITPR2,NFATC1,ATP2A1,ATP2B2,NTRK1,NTRK2,NTRK3,PDE1A,PDGFB,PLCG2,PRKCB,RYR1,RYR2,RYR3,SLC8A2,CACNA1B,CACNA1D,PDGFD,CAMK4,CAMK2B,CACNA1I,CACNA1H,PLCZ1,CD38,FGF19
## hsa04512                                                                                                                                         COL1A2,COL4A1,COL4A2,COL4A3,COL6A3,COMP,LAMA1,FREM2,ITGA4,ITGB4,ITGB5,AGRN,LAMA2,LAMA4,GP6,RELN,TNXB,FRAS1,ITGA8,CD36
```

For a more generalised version of gene set testing in methylation data
where the user can specify the gene set to be tested, the function `gsameth` can
be used. To display the top 20 pathways, `topGSA` can be called. `gsameth` can
take a single gene set, or a list of gene sets. The gene identifiers in the
gene set must be **Entrez Gene IDs**. To demonstrate
`gsameth`, we download and use the Hallmark gene set.

```
hallmark <- readRDS(url("http://bioinf.wehi.edu.au/MSigDB/v7.1/Hs.h.all.v7.1.entrez.rds"))
gsa <- gsameth(sig.cpg=sigCpGs, all.cpg=rownames(top), collection=hallmark)
```

```
## All input CpGs are used for testing.
```

```
topGSA(gsa, n=10)
```

```
##                                              N DE         P.DE          FDR
## HALLMARK_EPITHELIAL_MESENCHYMAL_TRANSITION 199 62 1.502509e-07 7.512545e-06
## HALLMARK_KRAS_SIGNALING_DN                 200 47 1.599089e-04 3.997724e-03
## HALLMARK_PANCREAS_BETA_CELLS                40 14 7.598882e-04 1.266480e-02
## HALLMARK_MYOGENESIS                        200 46 1.784710e-02 2.230888e-01
## HALLMARK_APICAL_JUNCTION                   199 43 3.214686e-02 3.171141e-01
## HALLMARK_SPERMATOGENESIS                   135 25 3.805369e-02 3.171141e-01
## HALLMARK_UV_RESPONSE_DN                    144 36 9.675631e-02 6.186248e-01
## HALLMARK_HEDGEHOG_SIGNALING                 36 11 9.897998e-02 6.186248e-01
## HALLMARK_KRAS_SIGNALING_UP                 198 34 1.260699e-01 7.003883e-01
## HALLMARK_NOTCH_SIGNALING                    32  9 1.415457e-01 7.077283e-01
```

Note that if it is of interest to obtain the **Entrez Gene IDs** that the
significant CpGs are mapped to, the `getMappedEntrezIDs` function can be called.

## 9.2 Region level analysis

We have extended `gometh` and `gsameth` to perform gene set testing following
a region analysis. The region gene set testing function analogues are `goregion`
and `gsaregion`. Instead of inputting significant CpGs, a ranged object as
typically outputted from region finding software is used. The CpGs overlapping
the significant differentially methylated regions (DMRs) are extracted and the
same statistical framework in `gometh` and `gsameth` is applied to test for
enrichment of gene sets. We find that genes that have more CpGs measuring
methylation are more likely to be called as differentially methylated regions,
and hence it is important to take into account this bias when performing gene
set testing.

To demonstrate `goregion` and `gsaregion` we will perform a region analysis
on the cancer dataset using the *[DMRcate](https://bioconductor.org/packages/3.22/DMRcate)* package.

```
library(DMRcate)
```

First, the matrix of M-values is annotated with the relevant annotation
information about the probes such as their genomic position, gene annotation,
etc. By default, this is done using the ilmn12.hg19 annotation. The limma
pipeline is then used for differential methylation analysis to calculate
moderated t-statistics.

```
myAnnotation <- cpg.annotate(object = M, datatype = "array", what = "M",
                             arraytype = c("450K"),
                             analysis.type = "differential", design = design,
                             coef = 4)
```

```
## Your contrast returned 23435 individually significant probes. We recommend the default setting of pcutoff in dmrcate().
```

Next we can use the `dmrcate` function to combine the CpGs to identify
differentially methylated regions. We can use the `extractRanges` function to
extract a `GRanges` object with the genomic location and the relevant
statistics associated with each DMR. This object can then be used as input
to `goregion` and `gsaregion`.

```
DMRs <- dmrcate(myAnnotation, lambda=1000, C=2)
```

```
## Fitting chr1...
```

```
## Fitting chr2...
```

```
## Fitting chr3...
```

```
## Fitting chr4...
```

```
## Fitting chr5...
```

```
## Fitting chr6...
```

```
## Fitting chr7...
```

```
## Fitting chr8...
```

```
## Fitting chr9...
```

```
## Fitting chr10...
```

```
## Fitting chr11...
```

```
## Fitting chr12...
```

```
## Fitting chr13...
```

```
## Fitting chr14...
```

```
## Fitting chr15...
```

```
## Fitting chr16...
```

```
## Fitting chr17...
```

```
## Fitting chr18...
```

```
## Fitting chr19...
```

```
## Fitting chr20...
```

```
## Fitting chr21...
```

```
## Fitting chr22...
```

```
## Fitting chrX...
```

```
## Fitting chrY...
```

```
## Demarcating regions...
```

```
## Done!
```

```
results.ranges <- extractRanges(DMRs)
```

```
## see ?DMRcatedata and browseVignettes('DMRcatedata') for documentation
```

```
## loading from cache
```

```
results.ranges
```

```
## GRanges object with 2578 ranges and 8 metadata columns:
##          seqnames              ranges strand |   no.cpgs min_smoothed_fdr
##             <Rle>           <IRanges>  <Rle> | <integer>        <numeric>
##      [1]     chr4 154709441-154714069      * |        54                0
##      [2]     chr6 133561224-133564066      * |        50                0
##      [3]    chr13   78491982-78494462      * |        50                0
##      [4]    chr11   32454216-32461240      * |        43                0
##      [5]    chr10 118030292-118034357      * |        31                0
##      ...      ...                 ...    ... .       ...              ...
##   [2574]     chr6   91005117-91005162      * |         2      3.59972e-25
##   [2575]     chr2 241085024-241085043      * |         2      3.64478e-25
##   [2576]    chr17   48071685-48071706      * |         2      3.86812e-25
##   [2577]     chr6 166720997-166721155      * |         2      4.22386e-25
##   [2578]    chr19   58446898-58446988      * |         3      4.47316e-25
##             Stouffer      HMFDR      Fisher   maxdiff   meandiff
##            <numeric>  <numeric>   <numeric> <numeric>  <numeric>
##      [1] 1.14510e-52 0.00102944 3.61330e-54  0.586292   0.224951
##      [2] 3.29083e-86 0.00103909 4.98468e-81  0.653903   0.362511
##      [3] 5.17970e-75 0.00119367 4.78794e-69  0.548184   0.323927
##      [4] 1.59959e-71 0.00102449 1.02503e-64  0.648133   0.298009
##      [5] 5.43504e-75 0.00102449 1.44576e-66  0.688941   0.411306
##      ...         ...        ...         ...       ...        ...
##   [2574] 2.15797e-05 0.00197580 4.71393e-05  0.284672  0.2309882
##   [2575] 1.94558e-06 0.00113219 4.68351e-06 -0.344832 -0.3291230
##   [2576] 3.47644e-05 0.00256174 7.50944e-05  0.331912  0.3141771
##   [2577] 1.33409e-04 0.00251525 2.35477e-04  0.252990  0.2377386
##   [2578] 1.89862e-04 0.00923636 4.63475e-04 -0.200463  0.0256059
##          overlapping.genes
##                <character>
##      [1]             SFRP2
##      [2]              EYA4
##      [3] RNF219-AS1, EDNRB
##      [4]       WT1-AS, WT1
##      [5]             GFRA1
##      ...               ...
##   [2574]             BACH2
##   [2575]              <NA>
##   [2576]              DLX3
##   [2577]             PRR18
##   [2578]              <NA>
##   -------
##   seqinfo: 23 sequences from an unspecified genome; no seqlengths
```

We can visualise the top DMR using the `DMR.plot` function:

```
cols <- c(2,4)[group]
names(cols) <-group
beta <- getBeta(mSet)
par(mfrow=c(1,1))
DMR.plot(ranges=results.ranges, dmr=2, CpGs=beta, phen.col=cols,
         what="Beta", arraytype="450K", genome="hg19")
```

![Top DMR from DMRcate.](data:image/png;base64...)

Figure 9: Top DMR from DMRcate

Now that we have performed our region analysis, we can use `goregion` and
`gsaregion` to perform gene set testing. Setting `plot.bias` to TRUE, we can
see strong probe number bias in the data. This can be interpretted that a
gene is more likely to have a DMR called if it has more CpGs measuring
methylation.

```
gst.region <- goregion(results.ranges, all.cpg=rownames(M),
                       collection="GO", array.type="450K", plot.bias=TRUE)
```

```
## All input CpGs are used for testing.
```

![Probe number bias for DMRs in the cancer dataset.](data:image/png;base64...)

Figure 10: Probe number bias for DMRs in the cancer dataset

```
topGSA(gst.region, n=10)
```

```
##            ONTOLOGY
## GO:0007399       BP
## GO:0048731       BP
## GO:0007275       BP
## GO:0003700       MF
## GO:0048856       BP
## GO:0030182       BP
## GO:0000981       MF
## GO:0048699       BP
## GO:0022008       BP
## GO:0032502       BP
##                                                                             TERM
## GO:0007399                                            nervous system development
## GO:0048731                                                    system development
## GO:0007275                                    multicellular organism development
## GO:0003700                             DNA-binding transcription factor activity
## GO:0048856                                      anatomical structure development
## GO:0030182                                                neuron differentiation
## GO:0000981 DNA-binding transcription factor activity, RNA polymerase II-specific
## GO:0048699                                                 generation of neurons
## GO:0022008                                                          neurogenesis
## GO:0032502                                                 developmental process
##               N  DE         P.DE          FDR
## GO:0007399 2650 564 2.298210e-41 2.645961e-37
## GO:0048731 4182 758 2.396162e-41 2.645961e-37
## GO:0007275 4849 815 1.131927e-35 8.332871e-32
## GO:0003700 1352 303 1.289322e-32 7.118669e-29
## GO:0048856 6121 931 3.507615e-32 1.549314e-28
## GO:0030182 1477 355 1.231484e-31 4.532887e-28
## GO:0000981 1272 288 5.405217e-31 1.705346e-27
## GO:0048699 1556 366 7.165032e-31 1.977997e-27
## GO:0022008 1818 403 2.993678e-29 7.346154e-26
## GO:0032502 6695 972 4.523409e-29 9.989948e-26
```

We can also test for enrichment of KEGG pathways:

```
gst.region.kegg <- goregion(results.ranges, all.cpg=rownames(M),
                       collection="KEGG", array.type="450K")
```

```
## All input CpGs are used for testing.
```

```
topGSA(gst.region.kegg, n=10)
```

```
##                                      Description   N DE         P.DE
## hsa04080 Neuroactive ligand-receptor interaction 364 82 6.716191e-15
## hsa04082            Neuroactive ligand signaling 199 60 1.427663e-11
## hsa04081                       Hormone signaling 217 53 1.222949e-09
## hsa04514                 Cell adhesion molecules 153 44 2.428730e-07
## hsa04020               Calcium signaling pathway 250 61 5.226155e-07
## hsa04950    Maturity onset diabetes of the young  26 12 2.111128e-05
## hsa04024                  cAMP signaling pathway 225 48 6.025039e-05
## hsa04713                   Circadian entrainment  97 27 4.660464e-04
## hsa04970                      Salivary secretion  92 21 5.536101e-04
## hsa04517                      IgSF CAM signaling 294 62 5.910268e-04
##                   FDR
## hsa04080 2.471558e-12
## hsa04082 2.626900e-09
## hsa04081 1.500151e-07
## hsa04514 2.234432e-05
## hsa04020 3.846450e-05
## hsa04950 1.294825e-03
## hsa04024 3.167449e-03
## hsa04713 2.143813e-02
## hsa04970 2.174979e-02
## hsa04517 2.174979e-02
```

What is interesting is that although very similar pathways are highly
ranked compared to the CpG level analysis, gene set testing on the regions
is more powerful i.e. the p-values are more significant. In experiments
where there are tens of thousands of significant CpGs from a CpG level analysis,
we recommend that a good quality region analysis can be a more powerful approach
for gene set enrichment analysis.

We can also perform gene set testing on the Hallmark gene sets using
`gsaregion`:

```
gsa.region <- gsaregion(results.ranges, all.cpg=rownames(M),
                        collection=hallmark)
```

```
## All input CpGs are used for testing.
```

```
topGSA(gsa.region, n=10)
```

```
##                                              N DE        P.DE        FDR
## HALLMARK_EPITHELIAL_MESENCHYMAL_TRANSITION 199 41 0.001362907 0.06814533
## HALLMARK_PANCREAS_BETA_CELLS                40 11 0.002825619 0.07064047
## HALLMARK_KRAS_SIGNALING_DN                 200 33 0.005913953 0.09856588
## HALLMARK_SPERMATOGENESIS                   135 22 0.012088866 0.15111083
## HALLMARK_APICAL_JUNCTION                   199 34 0.043486809 0.43486809
## HALLMARK_MYOGENESIS                        200 34 0.067238289 0.55648384
## HALLMARK_KRAS_SIGNALING_UP                 198 28 0.077907738 0.55648384
## HALLMARK_ANGIOGENESIS                       36  7 0.107806996 0.67379373
## HALLMARK_APICAL_SURFACE                     44  7 0.287580480 1.00000000
## HALLMARK_INFLAMMATORY_RESPONSE             200 20 0.313507366 1.00000000
```

Note that the DMR analysis can be further refined by imposing a
\(\Delta\beta\) value cut-off and changing various parameters. Please refer to the
*[DMRcate](https://bioconductor.org/packages/3.22/DMRcate)* package vignette for more details on how to
do this.

# 10 Session information

```
sessionInfo()
```

R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86\_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default
BLAS: /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
LAPACK: /usr/lib/x86\_64-linux-gnu/lapack/liblapack.so.3.12.0 LAPACK version 3.12.0

locale:
[1] LC\_CTYPE=en\_US.UTF-8 LC\_NUMERIC=C

time zone: America/New\_York
tzcode source: system (glibc)

attached base packages:
[1] parallel stats4 stats graphics grDevices utils datasets
[8] methods base

other attached packages:
[1] DMRcatedata\_2.27.0

loaded via a namespace (and not attached):
[1] ProtGenerics\_1.42.0 bitops\_1.0-9
[3] httr\_1.4.7 RColorBrewer\_1.1-3
[5] tools\_4.5.1 doRNG\_1.8.6.2
[7] backports\_1.5.0 R6\_2.6.1
[9] HDF5Array\_1.38.0 lazyeval\_0.2.2
[11] Gviz\_1.54.0 rhdf5filters\_1.22.0
[13] permute\_0.9-8 withr\_3.0.2
[15] prettyunits\_1.2.0 gridExtra\_2.3
[17] base64\_2.0.2 preprocessCore\_1.72.0
[19] cli\_3.6.5 sass\_0.4.10
[21] S7\_0.2.0 readr\_2.1.5
[23] genefilter\_1.92.0 askpass\_1.2.1
[25] Rsamtools\_2.26.0 foreign\_0.8-90
[27] siggenes\_1.84.0 illuminaio\_0.52.0
[29] R.utils\_2.13.0 rentrez\_1.2.4
[31] dichromat\_2.0-0.1 scrime\_1.3.5
[33] BSgenome\_1.78.0 readxl\_1.4.5
[35] rstudioapi\_0.17.1 RSQLite\_2.4.3
[37] BiocIO\_1.20.0 gtools\_3.9.5
[39] dplyr\_1.1.4 GO.db\_3.22.0
[41] Matrix\_1.7-4 interp\_1.1-6
[43] abind\_1.4-8 R.methodsS3\_1.8.2
[45] lifecycle\_1.0.4 yaml\_2.3.10
[47] rhdf5\_2.54.0 SparseArray\_1.10.0
[49] grid\_4.5.1 blob\_1.2.4
[51] crayon\_1.5.3 lattice\_0.22-7
[53] beachmat\_2.26.0 GenomicFeatures\_1.62.0
[55] cigarillo\_1.0.0 annotate\_1.88.0
[57] KEGGREST\_1.50.0 magick\_2.9.0
[59] pillar\_1.11.1 knitr\_1.50
[61] beanplot\_1.3.1 rjson\_0.2.23
[63] codetools\_0.2-20 glue\_1.8.0
[65] data.table\_1.17.8 vctrs\_0.6.5
[67] png\_0.1-8 cellranger\_1.1.0
[69] gtable\_0.3.6 cachem\_1.1.0
[71] xfun\_0.53 S4Arrays\_1.10.0
[73] survival\_3.8-3 tinytex\_0.57
[75] statmod\_1.5.1 nlme\_3.1-168
[77] bit64\_4.6.0-1 bsseq\_1.46.0
[79] progress\_1.2.3 filelock\_1.0.3
[81] GenomeInfoDb\_1.46.0 bslib\_0.9.0
[83] nor1mix\_1.3-3 rpart\_4.1.24
[85] colorspace\_2.1-2 DBI\_1.2.3
[87] Hmisc\_5.2-4 nnet\_7.3-20
[89] tidyselect\_1.2.1 bit\_4.6.0
[91] compiler\_4.5.1 curl\_7.0.0
[93] httr2\_1.2.1 htmlTable\_2.4.3
[95] h5mread\_1.2.0 BiasedUrn\_2.0.12
[97] xml2\_1.4.1 DelayedArray\_0.36.0
[99] bookdown\_0.45 rtracklayer\_1.70.0
[101] checkmate\_2.3.3 scales\_1.4.0
[103] quadprog\_1.5-8 rappdirs\_0.3.3
[105] stringr\_1.5.2 digest\_0.6.37
[107] rmarkdown\_2.30 GEOquery\_2.78.0
[109] htmltools\_0.5.8.1 pkgconfig\_2.0.3
[111] jpeg\_0.1-11 base64enc\_0.1-3
[113] sparseMatrixStats\_1.22.0 ruv\_0.9.7.1
[115] fastmap\_1.2.0 ensembldb\_2.34.0
[117] rlang\_1.1.6 htmlwidgets\_1.6.4
[119] UCSC.utils\_1.6.0 DelayedMatrixStats\_1.32.0
[121] farver\_2.1.2 jquerylib\_0.1.4
[123] jsonlite\_2.0.0 BiocParallel\_1.44.0
[125] mclust\_6.1.1 R.oo\_1.27.1
[127] VariantAnnotation\_1.56.0 RCurl\_1.98-1.17
[129] magrittr\_2.0.4 Formula\_1.2-5
[131] Rhdf5lib\_1.32.0 Rcpp\_1.1.0
[133] stringi\_1.8.7 MASS\_7.3-65
[135] plyr\_1.8.9 org.Hs.eg.db\_3.22.0
[137] deldir\_2.0-4 splines\_4.5.1
[139] multtest\_2.66.0 hms\_1.1.4
[141] rngtools\_1.5.2 biomaRt\_2.66.0
[143] BiocVersion\_3.22.0 XML\_3.99-0.19
[145] evaluate\_1.0.5 latticeExtra\_0.6-31
[147] biovizBase\_1.58.0 BiocManager\_1.30.26
[149] tzdb\_0.5.0 tidyr\_1.3.1
[151] openssl\_2.3.4 purrr\_1.1.0
[153] reshape\_0.8.10 ggplot2\_4.0.0
[155] xtable\_1.8-4 restfulr\_0.0.16
[157] AnnotationFilter\_1.34.0 tibble\_3.3.0
[159] memoise\_2.0.1 AnnotationDbi\_1.72.0
[161] GenomicAlignments\_1.46.0 cluster\_2.1.8.1

# References

Aryee, Martin J, Andrew E Jaffe, Hector Corrada-Bravo, Christine Ladd-Acosta, Andrew P Feinberg, Kasper D Hansen, and Rafael a Irizarry. 2014. “Minfi: a flexible and comprehensive Bioconductor package for the analysis of Infinium DNA methylation microarrays.” *Bioinformatics (Oxford, England)* 30 (10): 1363–9. <https://doi.org/10.1093/bioinformatics/btu049>.

Bibikova, Marina, Bret Barnes, Chan Tsan, Vincent Ho, Brandy Klotzle, Jennie M Le, David Delano, et al. 2011. “High density DNA methylation array with single CpG site resolution.” *Genomics* 98 (4): 288–95. <https://doi.org/10.1016/j.ygeno.2011.07.007>.

Dedeurwaerder, Sarah, Matthieu Defrance, and Emilie Calonne. 2011. “Evaluation of the Infinium Methylation 450K technology.” *Epigenomics* 3 (6): 771–84. <http://www.futuremedicine.com/doi/abs/10.2217/epi.11.105>.

Gagnon-Bartsch, Johann A, Laurent Jacob, and Terence P Speed. 2013. *Removing Unwanted Variation from High Dimensional Data with Negative Controls.* Berkeley: Tech. Rep. 820, Department of Statistics, University of California.

Gagnon-Bartsch, Johann a, and Terence P Speed. 2012. “Using control genes to correct for unwanted variation in microarray data.” *Biostatistics (Oxford, England)* 13 (3): 539–52. <https://doi.org/10.1093/biostatistics/kxr034>.

Geeleher, Paul, Lori Hartnett, Laurance J Egan, Aaron Golden, Raja Affendi Raja Ali, and Cathal Seoighe. 2013. “Gene-set analysis is severely biased when applied to genome-wide methylation data.” *Bioinformatics (Oxford, England)* 29 (15): 1851–7. <https://doi.org/10.1093/bioinformatics/btt311>.

Hansen, Kasper Daniel, Winston Timp, Héctor Corrada Bravo, Sarven Sabunciyan, Benjamin Langmead, Oliver G McDonald, Bo Wen, et al. 2011. “Increased methylation variation in epigenetic domains across cancer types.” *Nature Genetics* 43 (8): 768–75. <https://doi.org/10.1038/ng.865>.

Law, Charity W, Yunshun Chen, Wei Shi, and Gordon K Smyth. 2014. “voom: Precision weights unlock linear model analysis tools for RNA-seq read counts.” *Genome Biology* 15 (2): R29. <https://doi.org/10.1186/gb-2014-15-2-r29>.

Maksimovic, Jovana, Johann A Gagnon-Bartsch, Terence P Speed, and Alicia Oshlack. 2015. “Removing unwanted variation in a differential methylation analysis of Illumina HumanMethylation450 array data.” *Nucleic Acids Research*, May, gkv526. <https://doi.org/10.1093/nar/gkv526>.

Maksimovic, Jovana, Lavinia Gordon, and Alicia Oshlack. 2012. “SWAN: Subset-quantile within array normalization for illumina infinium HumanMethylation450 BeadChips.” *Genome Biology* 13 (6): R44. <https://doi.org/10.1186/gb-2012-13-6-r44>.

Maksimovic, Jovana, Alicia Oshlack, and Belinda Phipson. 2020. “Gene set enrichment analysis for genome-wide DNA methylation data.” *bioRxiv*. <https://doi.org/10.1101/2020.08.24.265702>.

Phipson, Belinda, Jovana Maksimovic, and Alicia Oshlack. 2016. “missMethyl: an R package for analyzing data from Illumina’s HumanMethylation450 platform.” *Bioinformatics (Oxford, England)* 32 (2): 286–88. <https://doi.org/10.1093/bioinformatics/btv560>.

Phipson, Belinda, and Alicia Oshlack. 2014. “DiffVar: a new method for detecting differential variability with application to methylation in cancer and aging.” *Genome Biology* 15 (9): 465. <https://doi.org/10.1186/s13059-014-0465-4>.

Pickrell, Joseph K., John C. Marioni, Athma A. Pai, Jacob F. Degner, Barbara E. Engelhardt, Everlyne Nkadori, Jean-Baptiste Veyrieras, Matthew Stephens, Yoav Gilad, and Jonathan K. Pritchard. 2010. “Understanding mechanisms underlying human gene expression variation with RNA sequencing.” *Nature* 464 (7289): 768–72. <https://doi.org/10.1038/nature08872>.

Smyth, G. K. 2005. “limma: Linear Models for Microarray Data.” In *Bioinformatics and Computational Biology Solutions Using R and Bioconductor*, 397–420. New York: Springer-Verlag. <https://doi.org/10.1007/0-387-29362-0_23>.

Young, Matthew D, Matthew J Wakefield, Gordon K Smyth, and Alicia Oshlack. 2010. “Gene ontology analysis for RNA-seq: accounting for selection bias.” *Genome Biology* 11 (2): R14. <https://doi.org/10.1186/gb-2010-11-2-r14>.