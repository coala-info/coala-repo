# Non-detects in qPCR data: methods to model and impute non-detects in the results

## Valeriia Sherina, Matthew N. McCall

### 2025-10-30

# 1 Background on non-detects in qPCR data

Quantitative real-time PCR (qPCR) measures gene expression for a
subset of genes through repeated cycles of sequence-specific DNA
amplification and expression measurements. During the exponential
amplification phase, each cycle results in an approximate doubling of
the quanitity of each target transcript. The threshold cycle (Ct) –
the cycle at which the target gene’s expression first exceeds a
predetermined threshold – is used to quantify the expression of each
target gene. These Ct values typically represent the raw data from a
qPCR experiment.

One challenge of qPCR data is the presence of *non-detects* those reactions failing to attain the expression threshold. While most
current software replaces these non-detects with the maximum possible
Ct value (typically 40), recent work has shown that this introduces
large biases in estimation of both absolute and differential
expression. Here, we treat the non-detects as missing data, model the
missing data mechanism, and use this model to impute Ct values for the
non-detects.

# 2 A statistical model for qPCR non-detects

We propose the following generative model for qPCR data in which \(Y\_{ij}\) is the measured expression value for gene \(i\) in sample \(j\), some of which are missing (non-detects), \(X\_{ij}\) represents the fully observed expression values, and \(Z\_{ij}\) indicates whether a value is detected:
$$ X\_{ij} = f(\theta\_{ij}, \eta) + \varepsilon\_{ij} $$
$$ Y\_{ij} = \left{ \begin{array}
{rr}
X\_{ij} & \textrm{if \(Z\_{ij}=1\)}\
\textrm{non-detect} & \textrm{if \(Z\_{ij}=0\)}
\end{array} \right.$$;kvil`

In this model, we assume that the fully observed expression values, \(X\_{ij}\) are a function of the true gene expression, \(\theta\_{ij}\), non-biological factors, \(\eta\), and random measurement error, \(\varepsilon\_{ij}\). The probability of an expressed value being detected is assumed to be a function of the expression value itself, \(g(X\_{ij})\), for values below the detection limit, \(S\). The following logistic regression model is a natural choice for such a relationship:

$$ Pr(Z\_{ij}=1) = \left{ \begin{array}
{rr}
g(X\_{ij}) & \textrm{if \(X\_{ij} < 40\)} \
0 & \textrm{otherwise}
\end{array} \right.$$;kvil`

Here, \(g(X\_{ij})\) can be estimated via the following logistic regression:
[
logit(Pr(Z\_{ij}=1)) = \beta\_0 + \beta\_1 X\_{ij}
]

# 3 Example

## Data from Sampson *et al.* Oncogene 2013

Two cell types – young adult mouse colon (YAMC) cells and
mutant-p53/activated-Ras transformed YAMC cells – in combination with
three treatments – untreated, sodium butyrate, or valproic acid. Four
replicates were performed for each cell-type/treatment combination
[ [Sampson 2013](#ref-sampson2012gene)].

## Load the data

```
library(HTqPCR)
```

```
## Loading required package: Biobase
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
## Welcome to Bioconductor
##
##     Vignettes contain introductory material; view with
##     'browseVignettes()'. To cite Bioconductor, see
##     'citation("Biobase")', and for packages 'citation("pkgname")'.
```

```
## Loading required package: RColorBrewer
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
library(mvtnorm)
library(nondetects)
data(oncogene2013)
```

## Examine residuals when non-detects are replaced by 40

Normalize to Becn1:

```
normCt <- normalizeCtData(oncogene2013, norm = "deltaCt", deltaCt.genes = "Becn1")
```

```
## Calculating deltaCt values
## 	Using control gene(s): Becn1
## 	Card 1:	Mean=26.17	Stdev=NA
## 	Card 2:	Mean=25.5	Stdev=NA
## 	Card 3:	Mean=25.85	Stdev=NA
## 	Card 4:	Mean=26.22	Stdev=NA
## 	Card 5:	Mean=26.59	Stdev=NA
## 	Card 6:	Mean=25.35	Stdev=NA
## 	Card 7:	Mean=25.73	Stdev=NA
## 	Card 8:	Mean=26.36	Stdev=NA
## 	Card 9:	Mean=26.13	Stdev=NA
## 	Card 10:	Mean=25.38	Stdev=NA
## 	Card 11:	Mean=25.61	Stdev=NA
## 	Card 12:	Mean=26.52	Stdev=NA
## 	Card 13:	Mean=26.12	Stdev=NA
## 	Card 14:	Mean=26.56	Stdev=NA
## 	Card 15:	Mean=26.02	Stdev=NA
## 	Card 16:	Mean=25.5	Stdev=NA
## 	Card 17:	Mean=25.76	Stdev=NA
## 	Card 18:	Mean=26.03	Stdev=NA
## 	Card 19:	Mean=26.67	Stdev=NA
## 	Card 20:	Mean=26.69	Stdev=NA
## 	Card 21:	Mean=26.11	Stdev=NA
## 	Card 22:	Mean=25.86	Stdev=NA
## 	Card 23:	Mean=26.27	Stdev=NA
## 	Card 24:	Mean=26.26	Stdev=NA
```

Calculate residuals for each set of replicates:

```
conds <- paste(pData(normCt)$sampleType,pData(normCt)$treatment,sep=":")
resids <- matrix(nrow=nrow(normCt), ncol=ncol(normCt))
for(i in 1:nrow(normCt)){
  for(j in 1:ncol(normCt)){
    ind <- which(conds==conds[j])
    resids[i,j] <- exprs(normCt)[i,j]-mean(exprs(normCt)[i,ind])
  }
}
```

Create boxplots of residuals stratified by the presence of a non-detect:

```
iND <- which(featureCategory(normCt)=="Undetermined", arr.ind=TRUE)
iD <- which(featureCategory(normCt)!="Undetermined", arr.ind=TRUE)
boxes <- list("observed"=-resids[iD], "non-detect"=-resids[iND])
```

```
boxplot(boxes, main="",ylim=c(-5,5),
        ylab=expression(paste("-",Delta,"Ct residuals",sep="")))
```

![plot of chunk unnamed-chunk-5](data:image/png;base64...)

## Impute non-detects

```
oncogene2013_1 <- qpcrImpute(oncogene2013,
groupVars=c("sampleType","treatment"), outform = c("Multy"),
vary_fit=FALSE, vary_model=TRUE, add_noise=TRUE, numsam=2,
linkglm = c("logit"))
```

```
## ~0 + nrep
## <environment: 0x64412e77ba00>
## [1] "1 / 100"
```

```
## -1585.93719357229
```

```
## Warning: fitted probabilities numerically 0 or 1 occurred
```

```
## [1] "2 / 100"
```

```
## -1547.65473798079
```

```
## [1] "3 / 100"
```

```
## -1525.63747493401
```

```
## [1] "4 / 100"
```

```
## -1507.70854344257
```

```
## [1] "5 / 100"
```

```
## -1494.34791647616
```

```
## [1] "6 / 100"
```

```
## -1486.84145953593
```

```
## [1] "7 / 100"
```

```
## -1482.65081095015
```

```
## [1] "8 / 100"
```

```
## -1480.02741565204
```

```
## [1] "9 / 100"
```

```
## -1478.28522499918
```

```
## [1] "10 / 100"
```

```
## -1477.09557013291
```

```
## [1] "11 / 100"
```

```
## -1476.26802386548
```

```
## [1] "Multy"
## vary model= TRUE vary_fit= FALSE add_noise= TRUE
##  creating data set  1
```

```
## Warning in rbind(deparse.level, ...): number of columns of result, 1, is not a
## multiple of vector length 5 of arg 2
```

```
##
##  creating data set  2
```

```
## Warning in rbind(deparse.level, ...): number of columns of result, 1, is not a
## multiple of vector length 5 of arg 2
```

## Examine residuals when non-detects are replaced by imputed values

Normalize to Becn1:

```
normCt <- normalizeCtData(oncogene2013_1[[1]], norm = "deltaCt", deltaCt.genes = "Becn1")
```

```
## Calculating deltaCt values
## 	Using control gene(s): Becn1
## 	Card 1:	Mean=26.17	Stdev=NA
## 	Card 2:	Mean=25.5	Stdev=NA
## 	Card 3:	Mean=25.85	Stdev=NA
## 	Card 4:	Mean=26.22	Stdev=NA
## 	Card 5:	Mean=26.59	Stdev=NA
## 	Card 6:	Mean=25.35	Stdev=NA
## 	Card 7:	Mean=25.73	Stdev=NA
## 	Card 8:	Mean=26.36	Stdev=NA
## 	Card 9:	Mean=26.13	Stdev=NA
## 	Card 10:	Mean=25.38	Stdev=NA
## 	Card 11:	Mean=25.61	Stdev=NA
## 	Card 12:	Mean=26.52	Stdev=NA
## 	Card 13:	Mean=26.12	Stdev=NA
## 	Card 14:	Mean=26.56	Stdev=NA
## 	Card 15:	Mean=26.02	Stdev=NA
## 	Card 16:	Mean=25.5	Stdev=NA
## 	Card 17:	Mean=25.76	Stdev=NA
## 	Card 18:	Mean=26.03	Stdev=NA
## 	Card 19:	Mean=26.67	Stdev=NA
## 	Card 20:	Mean=26.69	Stdev=NA
## 	Card 21:	Mean=26.11	Stdev=NA
## 	Card 22:	Mean=25.86	Stdev=NA
## 	Card 23:	Mean=26.27	Stdev=NA
## 	Card 24:	Mean=26.26	Stdev=NA
```

Remove the normalization gene:

```
normCt <- normCt[-which(featureNames(normCt)=="Becn1"),]
```

Calculate residuals for each set of replicates:

```
conds <- paste(pData(normCt)$sampleType,
               pData(normCt)$treatment,sep=":")
resids <- matrix(nrow=nrow(normCt), ncol=ncol(normCt))
for(i in 1:nrow(normCt)){
  for(j in 1:ncol(normCt)){
    ind <- which(conds==conds[j])
    resids[i,j] <- exprs(normCt)[i,j]-mean(exprs(normCt)[i,ind])
  }
}
```

Create boxplots of residuals stratified by the presence of a non-detect:

```
iI <- which(featureCategory(normCt)=="Imputed", arr.ind=TRUE)
iD <- which(featureCategory(normCt)!="Imputed", arr.ind=TRUE)
boxes <- list("observed"=-resids[iD], "imputed"=-resids[iI])
```

```
boxplot(boxes, main="",ylim=c(-5,5),
        ylab=expression(paste("-",Delta,"Ct residuals",sep="")))
```

![plot of chunk unnamed-chunk-11](data:image/png;base64...)

# Additional examples

Two additional example data sets are used in the paper and included in
the package. These are each briefly described below.

## Data from Almudevar *et al.* SAGMB 2011

Cells transformed to malignancy by mutant p53 and activated Ras are
perturbed with the aim of restoring gene expression to levels found in
non-transformed parental cells via retrovirus-mediated re-expression
of corresponding cDNAs or shRNA-dependent stable knock-down. The data
contain 4-6 replicates for each perturbation, and each perturbation
has a corresponding control sample in which only the vector has been
added [ [Almudevar 2011](#ref-almudevar2011fitting)].

```
library(nondetects)
data(sagmb2011)
```

## Data from McMurray *et al.* Nature 2008

A study of the effect of p53 and/or Ras mutations on gene
expression. The third dataset is a comparison between four cell types
– YAMC cells, mutant-p53 YAMC cells, activated-Ras YAMC cells, and
p53/Ras double mutant YAMC cells. Three replicates were performed for
the untransformed YAMC cells, and four replicates were performed for
each of the other cell types [ [McMurray 2008](#ref-mcmurray2008synergistic)].

```
library(nondetects)
data(nature2008)
```

# Funding

This work was supported by National Institutes of Health [grant
numbers CA009363, CA138249, HG006853]; and an Edelman-Gardner
Foundation Award.

# Session Info

```
sessionInfo()
```

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
## [1] nondetects_2.40.0   mvtnorm_1.3-3       HTqPCR_1.64.0
## [4] limma_3.66.0        RColorBrewer_1.1-3  Biobase_2.70.0
## [7] BiocGenerics_0.56.0 generics_0.1.4
##
## loaded via a namespace (and not attached):
##  [1] nlme_3.1-168          gplots_3.2.0          knitr_1.50
##  [4] xfun_0.53             reformulas_0.4.2      KernSmooth_2.23-26
##  [7] minqa_1.2.8           gtools_3.9.5          statmod_1.5.1
## [10] lme4_1.1-37           stats4_4.5.1          arm_1.14-4
## [13] grid_4.5.1            abind_1.4-8           evaluate_1.0.5
## [16] caTools_1.18.3        MASS_7.3-65           bitops_1.0-9
## [19] BiocManager_1.30.26   compiler_4.5.1        preprocessCore_1.72.0
## [22] coda_0.19-4.1         Rcpp_1.1.0            lattice_0.22-7
## [25] nloptr_2.2.1          Rdpack_2.6.4          splines_4.5.1
## [28] rbibutils_2.3         affy_1.88.0           Matrix_1.7-4
## [31] tools_4.5.1           boot_1.3-32           affyio_1.80.0
```

# References

Almudevar A, McCall MN, McMurray H, Land H (2011).
“Fitting Boolean networks from steady state perturbation data.”
*Statistical applications in genetics and molecular biology*, **10**(1), 47.

McMurray HR, Sampson ER, Compitello G, Kinsey C, Newman L, Smith B, Chen S, Klebanov L, Salzman P, Yakovlev A, Land H (2008).
“Synergistic response to oncogenic mutations defines gene class critical to cancer phenotype.”
*Nature*, **453**(7198), 1112–1116.

Sampson ER, McMurray HR, Hassane DC, Newman L, Salzman P, Jordan CT, Land H (2013).
“Gene signature critical to cancer phenotype as a paradigm for anticancer drug discovery.”
*Oncogene*, **32**(33), 3809–18.