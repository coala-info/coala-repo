# stageR: stage-wise analysis of high-throughput gene expression data in R

Koen Van den Berge and Lieven Clement

#### 2025-10-30

# Contents

* [1 Installing and loading the package](#installing-and-loading-the-package)
* [2 Differential gene expression: Hammer dataset](#differential-gene-expression-hammer-dataset)
  + [2.1 Conventional analysis](#conventional-analysis)
  + [2.2 Stage-wise analysis](#stage-wise-analysis)
* [3 Differential transcript expression/usage](#differential-transcript-expressionusage)
  + [3.1 Conventional analysis](#conventional-analysis-1)
  + [3.2 Stage-wise analysis](#stage-wise-analysis-1)
    - [3.2.1 Note on a stage-wise DEXSeq analysis.](#note-on-a-stage-wise-dexseq-analysis.)
* [References](#references)

This vignette describes how to use the stageR package that has been developed for stage-wise analysis of high throughput gene expression data in R. A stage-wise analysis was shown to be beneficial in terms of biological interpretation and statistical performance when multiple hypotheses per gene are of interest.
The stage-wise analysis has been adopted from (Heller et al. [2009](#ref-Heller2009)) and consists of a screening stage and a confirmation stage. In the screening stage, genes are screened by calculating p-values that aggregate evidence across the different hypotheses of interest for the gene. The screening p-values are then adjusted for FDR control after which significance of the screening hypothesis is assessed.
In the confirmation stage, only genes passing the screening stage are considered for analysis. For those genes, every hypothesis of interest is assessed separately and multiple testing correction is performed across hypotheses within a gene to control the FWER on the BH-adjusted significance level of the screening stage.
`stageR` provides an automated way to perform stage-wise testing, given p-values for the screening and confirmation stages. A number of FWER control procedures that take into account the logical relations among the hypotheses are implemented. Since the logical relations may be specific to the experiment, the user can also specify an adjustment deemed appropriate.

The vignette analyses two datasets. The Hammer dataset (Hammer et al. [2010](#ref-Hammer2010)) is a differential gene expression analysis for an experiment with a complex design. This type of analyses are supported by the `stageR` class. The Ren dataset (Ren et al. [2012](#ref-Ren2012)) analyses differential transcript usage (DTU) in tumoral versus normal tissue in Chinese patients. Transcript-level analyses are supported by the `stageRTx` class.

# 1 Installing and loading the package

The release version of the package is hosted on Bioconductor, and can be installed with the following code

```
#if (!requireNamespace("BiocManager", quietly=TRUE))
#    install.packages("BiocManager")
#BiocManager::install("stageR")
```

The development version of the package is hosted on GitHub and can be installed with the `devtools` library using `devtools::install_github("statOmics/stageR")`.

After installing, we will load the package.

```
library(stageR)
```

```
## Loading required package: SummarizedExperiment
```

```
## Loading required package: MatrixGenerics
```

```
## Loading required package: matrixStats
```

```
##
## Attaching package: 'MatrixGenerics'
```

```
## The following objects are masked from 'package:matrixStats':
##
##     colAlls, colAnyNAs, colAnys, colAvgsPerRowSet, colCollapse,
##     colCounts, colCummaxs, colCummins, colCumprods, colCumsums,
##     colDiffs, colIQRDiffs, colIQRs, colLogSumExps, colMadDiffs,
##     colMads, colMaxs, colMeans2, colMedians, colMins, colOrderStats,
##     colProds, colQuantiles, colRanges, colRanks, colSdDiffs, colSds,
##     colSums2, colTabulates, colVarDiffs, colVars, colWeightedMads,
##     colWeightedMeans, colWeightedMedians, colWeightedSds,
##     colWeightedVars, rowAlls, rowAnyNAs, rowAnys, rowAvgsPerColSet,
##     rowCollapse, rowCounts, rowCummaxs, rowCummins, rowCumprods,
##     rowCumsums, rowDiffs, rowIQRDiffs, rowIQRs, rowLogSumExps,
##     rowMadDiffs, rowMads, rowMaxs, rowMeans2, rowMedians, rowMins,
##     rowOrderStats, rowProds, rowQuantiles, rowRanges, rowRanks,
##     rowSdDiffs, rowSds, rowSums2, rowTabulates, rowVarDiffs, rowVars,
##     rowWeightedMads, rowWeightedMeans, rowWeightedMedians,
##     rowWeightedSds, rowWeightedVars
```

```
## Loading required package: GenomicRanges
```

```
## Loading required package: stats4
```

```
## Loading required package: BiocGenerics
```

```
## Loading required package: generics
```

```
##
## Attaching package: 'generics'
```

```
## The following objects are masked from 'package:base':
##
##     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
##     setequal, union
```

```
##
## Attaching package: 'BiocGenerics'
```

```
## The following objects are masked from 'package:stats':
##
##     IQR, mad, sd, var, xtabs
```

```
## The following objects are masked from 'package:base':
##
##     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
##     as.data.frame, basename, cbind, colnames, dirname, do.call,
##     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
##     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
##     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
##     unsplit, which.max, which.min
```

```
## Loading required package: S4Vectors
```

```
##
## Attaching package: 'S4Vectors'
```

```
## The following object is masked from 'package:utils':
##
##     findMatches
```

```
## The following objects are masked from 'package:base':
##
##     I, expand.grid, unname
```

```
## Loading required package: IRanges
```

```
## Loading required package: Seqinfo
```

```
## Loading required package: Biobase
```

```
## Welcome to Bioconductor
##
##     Vignettes contain introductory material; view with
##     'browseVignettes()'. To cite Bioconductor, see
##     'citation("Biobase")', and for packages 'citation("pkgname")'.
```

```
##
## Attaching package: 'Biobase'
```

```
## The following object is masked from 'package:MatrixGenerics':
##
##     rowMedians
```

```
## The following objects are masked from 'package:matrixStats':
##
##     anyMissing, rowMedians
```

```
##
## Attaching package: 'stageR'
```

```
## The following object is masked from 'package:methods':
##
##     getMethod
```

# 2 Differential gene expression: Hammer dataset

```
library(edgeR) ; library(Biobase) ; library(limma) ; library(utils) ; library(DEXSeq)
```

```
## Loading required package: limma
```

```
##
## Attaching package: 'limma'
```

```
## The following object is masked from 'package:BiocGenerics':
##
##     plotMA
```

```
## Loading required package: BiocParallel
```

```
## Loading required package: DESeq2
```

```
## Loading required package: AnnotationDbi
```

```
## Loading required package: RColorBrewer
```

As a case study for differential gene expression analysis, we analyse the Hammer dataset (Hammer et al. [2010](#ref-Hammer2010)). The dataset is provided with the stageR package and was originally downloaded from the ReCount project [website](http://bowtie-bio.sourceforge.net/recount) (Frazee, Langmead, and Leek [2011](#ref-Frazee2011)).

```
data(hammer.eset, package="stageR")
eset <- hammer.eset ; rm(hammer.eset)
```

The Hammer experiment investigated the effect of a spinal nerve ligation (SNL) versus control samples in rats at two weeks and two months after treatment. For every time \(\times\) treatment combination, 2 biological replicates were used. The hypotheses of interest are

* the treatment effect at the first timepoint,
* the treatment effect at the second timepoint and
* assessing whether the effect of the treatment is different between the two timepoints (i.e. the treatment-time interaction)

We use a contrast for the differential expression at the first and second timepoint and a difference in fold change between the two timepoints, respectively.
Therefore we create a design matrix consisting of two timepoints, two treatments and two biological replicates in every treatment \(\times\) time combination. Note there has been a typo in the phenoData, so we will correct this first.

```
pData(eset)$Time #typo. Will do it ourself
```

```
## [1] 2 months 2 months 2 months 2months  2 weeks  2 weeks  2 weeks  2 weeks
## Levels: 2months 2 months 2 weeks
```

```
time <- factor(rep(c("mo2","w2"),each=4),levels=c("w2","mo2"))
pData(eset)$protocol
```

```
## [1] control control L5 SNL  L5 SNL  control control L5 SNL  L5 SNL
## Levels: control L5 SNL
```

```
treat <- factor(c("control","control","SNL","SNL","control","control","SNL","SNL"),levels=c("control","SNL"))
design <- model.matrix(~time*treat)
rownames(design) = paste0(time,treat,rep(1:2,4))
colnames(design)[4] = "timeMo2xTreatSNL"
design
```

```
##             (Intercept) timemo2 treatSNL timeMo2xTreatSNL
## mo2control1           1       1        0                0
## mo2control2           1       1        0                0
## mo2SNL1               1       1        1                1
## mo2SNL2               1       1        1                1
## w2control1            1       0        0                0
## w2control2            1       0        0                0
## w2SNL1                1       0        1                0
## w2SNL2                1       0        1                0
## attr(,"assign")
## [1] 0 1 2 3
## attr(,"contrasts")
## attr(,"contrasts")$time
## [1] "contr.treatment"
##
## attr(,"contrasts")$treat
## [1] "contr.treatment"
```

We perform indpendent filtering (Bourgon, Gentleman, and Huber [2010](#ref-Bourgon2010)) of the genes and retain genes that are expressed with at least 2 counts per million in 2 samples.
The data is then normalised with TMM normalisation (Robinson and Oshlack [2010](#ref-Robinson2010)) to correct for differences in sequencing depth and RNA population between the samples.

```
cpmOffset <- 2
keep <- rowSums(cpm(exprs(eset))>cpmOffset)>=2 #2cpm in 2 samples
dge <- DGEList(exprs(eset)[keep,])
colnames(dge) = rownames(design)
dge <- calcNormFactors(dge)
```

## 2.1 Conventional analysis

We will first analyse the data with limma-voom (Law et al. [2014](#ref-Law2014)) in a standard way: the three contrasts are assessed separately on an FDR level of \(5\%\).

```
## regular analysis
voomObj <- voom(dge,design,plot=TRUE)
```

![](data:image/png;base64...)

```
fit <- lmFit(voomObj,design)
contrast.matrix <- makeContrasts(treatSNL, treatSNL+timeMo2xTreatSNL, timeMo2xTreatSNL, levels=design)
```

```
## Renaming (Intercept) to Intercept
```

```
fit2 <- contrasts.fit(fit, contrast.matrix)
fit2 <- eBayes(fit2)
res <- decideTests(fit2)
summary.TestResults(res) #nr of significant up-/downregulated genes
```

```
##        treatSNL treatSNL + timeMo2xTreatSNL timeMo2xTreatSNL
## Down       3433                        3415                0
## NotSig     5761                        6311            12893
## Up         3699                        3167                0
```

```
colSums(summary.TestResults(res)[c(1,3),]) #total nr of significant genes
```

```
##                    treatSNL treatSNL + timeMo2xTreatSNL
##                        7132                        6582
##            timeMo2xTreatSNL
##                           0
```

The conventional analysis does not find any genes that have a different effect of the treatment between the two timepoints (i.e. the interaction effect test), while many genes are differentially expressed between treatment and control within every timepoint.

To get a global picture of the effect of SNL on the transcriptome, we can check how many genes are significantly altered following SNL.

```
uniqueGenesRegular <- which(res[,1]!=0 | res[,2]!=0 | res[,3]!=0)
length(uniqueGenesRegular) #total nr of significant genes
```

```
## [1] 8205
```

In total, 8205 genes are found to be differentially expressed following a spinal nerve ligation. However, FDR was only controlled at the contrast level and not at the gene level so we cannot state a target FDR level together with this number.

## 2.2 Stage-wise analysis

The stage-wise analysis first considers an omnibus test that tests whether any of the three contrasts are significant, i.e. it tests whether there has been any effect of the treatment whatsoever.
For the screening hypothesis, we use the `topTableF` function from the `limma` package to perform an F-test across the three contrasts. The screening hypothesis p-values are then stored in the vector `pScreen`.

```
alpha <- 0.05
nGenes <- nrow(dge)
tableF <- topTableF(fit2, number=nGenes, sort.by="none") #screening hypothesis
```

```
## topTableF is obsolete and will be removed in a future version of limma. Please considering using topTable instead.
```

```
pScreen <- tableF$P.Value
names(pScreen) = rownames(tableF)
```

In the confirmation stage, every contrast is assessed separately. The confirmation stage p-values are adjusted to control the FWER across the hypotheses within a gene and are subsequently corrected to the BH-adjusted significance level of the screening stage. This allows a direct comparison of the adjusted p-values to the provided significance level `alpha` for both screening and confirmation stage adjusted p-values. The function `stageR` constructs an object from the `stageR` class and requires a (preferably named) vector of p-values for the screening hypothesis `pScreen` and a (preferably named) matrix of p-values for the confirmation stage `pConfirmation` with columns corresponding to the different contrasts of interest. Note that the rows in `pConfirmation` correspond to features (genes) and the features should be identically sorted in `pScreen` and `pConfirmation`. The constructor function will check whether the length of `pScreen` is identical to the number of rows in `pConfirmation` and return an error if this is not the case. Finally, the `pScreenAdjusted` argument specifies whether the screening p-values have already been adjusted according to FDR control.

```
pConfirmation <- sapply(1:3,function(i) topTable(fit2, coef=i, number=nGenes, sort.by="none")$P.Value)
dimnames(pConfirmation) <- list(rownames(fit2),c("t1","t2","t1t2"))
stageRObj <- stageR(pScreen=pScreen, pConfirmation=pConfirmation, pScreenAdjusted=FALSE)
```

The function `stageWiseAdjustment` then adjusts the p-values according to a stage-wise analysis. The `method` argument specifies the FWER correction procedure to be used in the confirmation stage. More details on the different methods can be found in the help file for `stageWiseAdjustment`. The `alpha` argument specifies the target OFDR level that is used for controlling the fraction of false positive genes across all rejected genes over the entire stage-wise testing procedure. The adjusted p-values for genes that did not pass the screening stage are by default set to `NA`.

Note that when a gene passed the screening hypothesis in the Hammer experiment, only one null hypothesis can still be true: there has to be DE at timepoint 1 or timepoint 2; if the DE only occurs on one timepoint there also exist an interaction; if DE occurs at both timepoints, the \(H\_0\) of no interaction can still be true. Thus, according to Shaffer’s MSRB procedure (Shaffer [1986](#ref-Shaffer1986)), no correction is required in the confirmation stage for this experiment to control the FWER. This can be specified with the `method="none"` argument.

```
stageRObj <- stageWiseAdjustment(object=stageRObj, method="none", alpha=0.05)
```

We can explore the results of the stage-wise analysis by querying the object returned by `stageWiseAdjustment`. **Note that the confirmation stage adjusted p-values returned by the function are only valid for the OFDR level provided. If a different OFDR level is of interest, the stage-wise testing adjustment of p-values should be re-run entirely with the other OFDR level specified in `stageWiseAdjustment`.** The adjusted p-values from the confirmation stage can be accessed with the `getAdjustedPValues` function

```
head(getAdjustedPValues(stageRObj, onlySignificantGenes=FALSE, order=FALSE))
```

```
## The returned adjusted p-values are based on a stage-wise testing approach and are only valid for the provided target OFDR level of 5%. If a different target OFDR level is of interest,the entire adjustment should be re-run.
```

```
##                      padjScreen           t1           t2      t1t2
## ENSRNOG00000000001 1.412119e-05 6.171392e-06 0.0004200199 0.4481483
## ENSRNOG00000000010 2.190789e-01           NA           NA        NA
## ENSRNOG00000000017 4.670563e-05 3.046936e-05 0.0007379041 0.8497619
## ENSRNOG00000000024 9.821934e-02           NA           NA        NA
## ENSRNOG00000000028 2.286433e-05 1.260112e-05 0.0004206436 1.0000000
## ENSRNOG00000000029 3.898560e-02 1.677562e-02 0.3691801555 0.6603609
```

```
head(getAdjustedPValues(stageRObj, onlySignificantGenes=TRUE, order=TRUE))
```

```
## The returned adjusted p-values are based on a stage-wise testing approach and are only valid for the provided target OFDR level of 5%. If a different target OFDR level is of interest,the entire adjustment should be re-run.
```

```
##                      padjScreen           t1           t2        t1t2
## ENSRNOG00000004805 6.528799e-11 2.404851e-14 2.077969e-12 1.000000000
## ENSRNOG00000004874 2.659925e-10 4.037117e-13 6.152318e-12 0.208666028
## ENSRNOG00000004731 5.586952e-10 3.281511e-12 1.733696e-11 0.635755014
## ENSRNOG00000004899 5.586952e-10 7.368985e-12 3.327081e-12 0.000962923
## ENSRNOG00000009768 5.586952e-10 1.092184e-12 5.294558e-11 0.205510526
## ENSRNOG00000001416 7.204616e-10 3.665075e-12 1.161256e-10 0.012618520
```

and may either return all p-values or only those from the significant genes, as specified by the `onlySignificantGenes` argument which can then be ordered or not as specified by the `order` argument.

Finally, the `getResults` function returns a binary matrix where rows correspond to features and columns correspond to hypotheses, including the screening hypothesis. For every feature \(\times\) hypothesis combination, it indicates whether the test is significant (1) or not (0) according to the stage-wise testing procedure.

```
res <- getResults(stageRObj)
```

```
## The returned adjusted p-values are based on a stage-wise testing approach and are only valid for the provided target OFDR level of 5%. If a different target OFDR level is of interest,the entire adjustment should be re-run.
```

```
head(res)
```

```
##                    padjScreen t1 t2 t1t2
## ENSRNOG00000000001          1  1  1    0
## ENSRNOG00000000010          0  0  0    0
## ENSRNOG00000000017          1  1  1    0
## ENSRNOG00000000024          0  0  0    0
## ENSRNOG00000000028          1  1  1    0
## ENSRNOG00000000029          1  1  0    0
```

```
colSums(res) #stage-wise analysis results
```

```
## padjScreen         t1         t2       t1t2
##       7891       6890       6556        658
```

The `adjustment` argument from the `stageWiseAdjustment` function allows the user to specify the FWER adjustment correction. It requires a numeric vector of the same length as the number of columns in `pConfirmation`. The first element of the vector is the adjustment for the most significant p-value of the gene, the second element for the second most significant p-value etc. Since the Hammer dataset did not require any adjustment, identical results are obtained when manually specifying the adjustments to equal \(1\).

```
stageRObj <- stageR(pScreen=pScreen, pConfirmation=pConfirmation, pScreenAdjusted=FALSE)
adjustedPSW <- stageWiseAdjustment(object=stageRObj, method="user", alpha=0.05, adjustment=c(1,1,1))
res <- getResults(adjustedPSW)
```

```
## The returned adjusted p-values are based on a stage-wise testing approach and are only valid for the provided target OFDR level of 5%. If a different target OFDR level is of interest,the entire adjustment should be re-run.
```

```
colSums(res)
```

```
## padjScreen         t1         t2       t1t2
##       7891       6890       6556        658
```

# 3 Differential transcript expression/usage

Multiple hypotheses of interest per gene also arise in transcript-level studies, where the different hypotheses correspond to the different isoforms from a gene.
We analyse differential transcript usage for a case study that investigated expression in prostate cancer tumoral tissue versus normal tissue in 14 Chinese patients (Ren et al. [2012](#ref-Ren2012)).
The raw sequences have been preprocessed with kallisto (Bray et al. [2016](#ref-Bray2016)) and transcript-level abundance estimates can be downloaded from The Lair project (Pimentel et al. [2016](#ref-Pimentel2016b)) [website](http://pachterlab.github.io/lair/). We used the unnormalized, unfiltered abundances for the analysis.
A subset of the dataset comes with the `stageR` package and can be accessed with `data(esetProstate)` after loading `stageR`. The `ExpressionSet` contains the metadata for the samples in `pData(esetProstate)` and corresponding gene identifiers for the transcripts are stored in `fData(esetProstate)`. The dataset contains 945 transcripts from 456 genes.

```
data("esetProstate", package="stageR") #from stageR package
head(pData(esetProstate))
```

```
##           condition patient
## ERR031017         N      10
## ERR031018         T      10
## ERR031019         N      11
## ERR299295         T      11
## ERR299296         N      12
## ERR031022         T      12
```

```
head(fData(esetProstate))
```

```
##                      transcript            gene
## ENST00000002501 ENST00000002501 ENSG00000003249
## ENST00000005374 ENST00000005374 ENSG00000006625
## ENST00000007510 ENST00000007510 ENSG00000004777
## ENST00000008440 ENST00000008440 ENSG00000010072
## ENST00000010299 ENST00000010299 ENSG00000009780
## ENST00000011684 ENST00000011684 ENSG00000008323
```

We will perform some basic data exploration on the transcripts in the dataset. Since the dataset was preprocessed for the purposes of this vignette, every gene has at least two transcripts, and all transcripts are expressed in at least 1 sample.

```
tx2gene <- fData(esetProstate)
colnames(tx2gene) <- c("transcript","gene")
barplot(table(table(tx2gene$gene)), main="Distribution of number of tx per gene")
```

![](data:image/png;base64...)

```
#the dataset contains
length(unique(tx2gene$gene)) #nr genes
```

```
## [1] 456
```

```
median(table(as.character(tx2gene$gene))) #median nr of tx/gene
```

```
## [1] 2
```

## 3.1 Conventional analysis

We will show how to use the `stageR` package to analyse DTU with a stage-wise approach. We start with a regular DEXseq analysis to obtain p-values for every transcript and q-values for every gene. Since both control and tumoral tissue are derived from the same patient for all 14 patients, we add a block effect for the patient to account for the correlation between samples within every patient.

```
### regular DEXSeq analysis
sampleData <- pData(esetProstate)
geneForEachTx <- tx2gene[match(rownames(exprs(esetProstate)),tx2gene[,1]),2]
dxd <- DEXSeqDataSet(countData = exprs(esetProstate),
                     sampleData = sampleData,
                     design = ~ sample + exon + patient + condition:exon,
                     featureID = rownames(esetProstate),
                     groupID = as.character(geneForEachTx))
```

```
## converting counts to integer mode
```

```
## Warning in DESeqDataSet(rse, design, ignoreRank = TRUE): some variables in
## design formula are characters, converting to factors
```

```
dxd <- estimateSizeFactors(dxd)
dxd <- estimateDispersions(dxd)
dxd <- testForDEU(dxd, reducedModel=~ sample + exon + patient)
```

```
## 1 rows did not converge in beta, labelled in mcols(object)$fullBetaConv. Use larger maxit argument with nbinomLRT
```

```
dxr <- DEXSeqResults(dxd)
qvalDxr <- perGeneQValue(dxr)
```

## 3.2 Stage-wise analysis

The code above is a conventional `DEXSeq` analysis for analysing differential transcript usage. It would proceed by either assessing the significant genes according to the gene-wise q-values or by assessing the significant transcripts according to the transcript-level p-values, after adjustment for multiple testing. Performing and interpreting both analyses does not provide appropriate FDR control and thus should be avoided. However, interpretation on the gene level combined with transcript-level results can provide useful biological insights and this can be achieved through stage-wise testing. In the following code, we show how to automatically perform a stage-wise analysis using `stageR`. We start by constructing

* a named vector of gene-wise q-values `pScreen`
* a named matrix with transcript-level p-values `pConfirmation`
* a `data.frame` with transcript identifiers and corresponding gene identifiers `tx2gene`

These three objects provide everything we need to construct an instance from the `stageRTx` class for the stage-wise analysis. Note that a different class and thus a different constructor function is used for transcript-level analyses in comparison to DE analysis for complex designs.

```
pConfirmation <- matrix(dxr$pvalue,ncol=1)
dimnames(pConfirmation) <- list(c(dxr$featureID),c("transcript"))
pScreen <- qvalDxr
tx2gene <- fData(esetProstate)
```

Next we build an object from the `stageRTx` class and indicate that the screening hypothesis p-values were already adjusted by setting `pScreenAdjusted=TRUE`. Similar as in the DGE example, we port this object to the `stageWiseAdjustment` function for correcting the p-values. We control the analysis on a \(5\%\) target OFDR (`alpha=0.05`). `method="dtu"` indicates the adapted Holm-Shaffer FWER correction that was specifically tailored for DTU analysis as described in the manuscript. In brief, the Holm procedure (Holm [1979](#ref-Holm1979)) is used from the third transcript onwards and the two most significant p-values are tested on a \(\alpha\_I/(n\_g-2)\) significance level, with \(\alpha\_I\) the BH adjusted significance level from the screening stage and \(n\_g\) the number of transcripts for gene \(g\). The method will return `NA` p-values for genes with only one transcript if the stage-wise testing method equals `"dtu"`.

```
stageRObj <- stageRTx(pScreen=pScreen, pConfirmation=pConfirmation, pScreenAdjusted=TRUE, tx2gene=tx2gene)
stageRObj <- stageWiseAdjustment(object=stageRObj, method="dtu", alpha=0.05)
```

We can then explore the results using a range of accessor functions. The significant genes can be returned with the `getSignificantGenes` function.

```
head(getSignificantGenes(stageRObj))
```

```
## The returned adjusted p-values are based on a stage-wise testing approach and are only valid for the provided target OFDR level of 5%. If a different target OFDR level is of interest,the entire adjustment should be re-run.
```

```
##                 FDR adjusted p-value
## ENSG00000063245          0.002725921
## ENSG00000106948          0.003579448
## ENSG00000117751          0.027993016
## ENSG00000120910          0.029061483
## ENSG00000124831          0.010006999
## ENSG00000005483          0.038112160
```

Similar, the significant transcripts can be returned with `getSignificantTx`.

```
head(getSignificantTx(stageRObj))
```

```
## The returned adjusted p-values are based on a stage-wise testing approach and are only valid for the provided target OFDR level of 5%. If a different target OFDR level is of interest,the entire adjustment should be re-run.
```

```
##                 stage-wise adjusted p-value
## ENST00000085079                 0.000000000
## ENST00000223791                 0.001100416
## ENST00000236412                 0.000000000
## ENST00000240139                 0.000000000
## ENST00000257745                 0.000000000
## ENST00000261017                 0.033809304
```

The stage-wise adjusted p-values are returned using the `getAdjustedPValues` function. The screening (gene) hypothesis p-values were adjusted according to the BH FDR criterion, and the confirmation (transcript) hypothesis p-values were adjusted to control for the full stage-wise analysis, by adopting the correction method specified in `stageWiseAdjustment`. Hence, the confirmation adjusted p-values returned from this function can be directly compared to the significance level `alpha` as provided in the `stageWiseAdjustment` function. `getAdjustedPValues` returns a matrix where the different rows correspond to transcripts and the respective gene and transcript identifiers are given in the first two columns. Transcript-level adjusted p-values for genes not passing the screening stage are set to `NA` by default. Note, that the stage-wise adjusted p-values are only valid for the provided significance level and must not be compared to a different significance level. If this would be of interest, the entire stage-wise testing adjustment should be re-run with the other significance level provided in `alpha`.

```
padj <- getAdjustedPValues(stageRObj, order=TRUE, onlySignificantGenes=FALSE)
```

```
## The returned adjusted p-values are based on a stage-wise testing approach and are only valid for the provided target OFDR level of 5%. If a different target OFDR level is of interest,the entire adjustment should be re-run.
```

```
head(padj)
```

```
##            geneID            txID        gene   transcript
## 1 ENSG00000063245 ENST00000085079 0.002725921 0.0000000000
## 2 ENSG00000063245 ENST00000270460 0.002725921 0.0000000000
## 3 ENSG00000106948 ENST00000307564 0.003579448 0.0003366727
## 4 ENSG00000106948 ENST00000223791 0.003579448 0.0011004159
## 5 ENSG00000106948 ENST00000312033 0.003579448 1.0000000000
## 6 ENSG00000149136 ENST00000278412 0.006951262 0.0000000000
```

The output indeed shows that 2 genes and three transcripts are significant because their adjusted p-values are below the specified `alpha` level of \(0.05\). The third gene in the list is not significant and thus the p-value of the transcript is set to `NA`.

### 3.2.1 Note on a stage-wise DEXSeq analysis.

By default, DEXSeq performs an independent filtering step. This may result in a number of genes that have been filtered and thus no q-value for these genes is given in the output of `perGeneQValue`. This can cause an error in the stage-wise analysis, since we have confirmation stage p-values for transcripts but no q-value for their respective genes. In order to avoid this, one should filter these transcripts in the `pConfirmation` and `tx2gene` objects.

```
rowsNotFiltered <- tx2gene[,2]%in%names(qvalDxr)
pConfirmation <- matrix(pConfirmation[rowsNotFiltered,],ncol=1,dimnames=list(dxr$featureID[rowsNotFiltered],"transcript"))
tx2gene <- tx2gene[rowsNotFiltered,]
```

After which the stage-wise analysis may proceed.

# References

Bourgon, Richard, Robert Gentleman, and Wolfgang Huber. 2010. “Independent filtering increases detection power for high-throughput experiments.” *Proceedings of the National Academy of Sciences of the United States of America* 107 (21): 9546–51. <https://doi.org/10.1073/pnas.0914005107>.

Bray, Nicolas L, Harold Pimentel, Páll Melsted, and Lior Pachter. 2016. “Near-optimal probabilistic RNA-seq quantification.” *Nature Biotechnology* 34 (5): 525–27. <https://doi.org/10.1038/nbt.3519>.

Frazee, Alyssa C, Ben Langmead, and Jeffrey T Leek. 2011. “ReCount: A multi-experiment resource of analysis-ready RNA-seq gene count datasets.” *BMC Bioinformatics* 12 (1): 449. <https://doi.org/10.1186/1471-2105-12-449>.

Hammer, Paul, Michaela S Banck, Ronny Amberg, Cheng Wang, Gabriele Petznick, Shujun Luo, Irina Khrebtukova, Gary P Schroth, Peter Beyerlein, and Andreas S Beutler. 2010. “mRNA-seq with agnostic splice site discovery for nervous system transcriptomics tested in chronic pain.” *Genome Research* 20 (6): 847–60. <https://doi.org/10.1101/gr.101204.109>.

Heller, Ruth, Elisabetta Manduchi, Gregory R Grant, and Warren J Ewens. 2009. “A flexible two-stage procedure for identifying gene sets that are differentially expressed.” *Bioinformatics (Oxford, England)* 25 (8): 1019–25. <https://doi.org/10.1093/bioinformatics/btp076>.

Holm, Sture. 1979. “A Simple Sequentially Rejective Multiple Test Procedure.” *Scandinavian Journal of Statistics* 6 (2): 65–70.

Law, Charity W, Yunshun Chen, Wei Shi, and Gordon K Smyth. 2014. “voom: Precision weights unlock linear model analysis tools for RNA-seq read counts.” *Genome Biology* 15 (2): R29. <https://doi.org/10.1186/gb-2014-15-2-r29>.

Pimentel, Harold, Pascal Sturmfels, Nicolas Bray, Páll Melsted, and Lior Pachter. 2016. “The Lair: a resource for exploratory analysis of published RNA-Seq data.” *BMC Bioinformatics* 17 (1): 490. <https://doi.org/10.1186/s12859-016-1357-2>.

Ren, Shancheng, Zhiyu Peng, Jian-Hua Mao, Yongwei Yu, Changjun Yin, Xin Gao, Zilian Cui, et al. 2012. “RNA-seq analysis of prostate cancer in the Chinese population identifies recurrent gene fusions, cancer-associated long noncoding RNAs and aberrant alternative splicings.” *Cell Research* 22 (5): 806–21. <https://doi.org/10.1038/cr.2012.30>.

Robinson, Mark D, and Alicia Oshlack. 2010. “A scaling normalization method for differential expression analysis of RNA-seq data.” *Genome Biology* 11 (3): R25. <https://doi.org/10.1186/gb-2010-11-3-r25>.

Shaffer, Juliet Popper. 1986. “Modified Sequentially Rejective Multiple Test Procedures.” *Journal of the American Statistical Association* 81 (395): 826. <https://doi.org/10.2307/2289016>.