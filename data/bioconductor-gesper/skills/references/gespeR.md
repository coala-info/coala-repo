Estimating Gene-Speciﬁc Phenotpes with gespeR

Fabian Schmich

January 4, 2019

Contents

1 The gespeR Model

2 Working Example

3 sessionInfo()

1 The gespeR Model

1

1

7

This package provides algorithms for deconvoluting oﬀ-target confounded phenotypes from RNA interference
screens. The packages uses (predicted) siRNA-to-gene target relations in a regularised linear regression
model, in order to infer individual gene-speciﬁc phenotype (GSP) contributions. The observed siRNA-
speciﬁc phenotypes (SSPs) for reagent i = 1, . . . , n as the weighted linear sum of GSPs of all targeted genes
j = 1, . . . , p

Yi = xi1βj + . . . + xipβp + (cid:15)i,

(1)

where xij represents the strength of knockdown of reagent i on gene j, βj corresponds to the GSP of gene j
and (cid:15)i is the error term for SSP i. The linear reegression model is ﬁt using elastic net regularization:

ˆβ = argmin

β






n
(cid:88)

i=1



yi −

p
(cid:88)

j=1


2

xijβj



+ λ

p
(cid:88)

j=1

(cid:0)αβ2

j + (1 − α) |βj|(cid:1)






.

(2)

Here λ determines the amount of regualrisation and α is the mixing parameter between the ridge and lasso
penalty with 0 ≤ α ≤ 1. The elastic net penalty selects variables like the lasso and shrinks together the
coeﬃcients of correlated predictors like ridge. This allows for a sparse solution of nonzero GSPs, while
retaining simultaneous selection of genes with similar RNAi reagent binding patterns in their respective 3’
UTRs. For more information and for citing the gespeR package please refer to:

Schmich F (2019). gespeR: Gene-Speciﬁc Phenotype EstimatoR. R package version 1.14.1, http://
www.cbg.ethz.ch/software/gespeR.

2 Working Example

In this example, we load ﬁrst load simulated phenotypic readout and siRNA-to-gene target relations. The
toy data consists of four screens (A, B, C, D) of 1,000 siRNAs and a limited gene universe of 1,500 genes.
Detailed description of how the data was simulated can be accessed using ?simData. First, we load the
package:

1

library(gespeR)

Now the phenotypes and target relations can be initialised using the Phenotypes and TargetRelations
commands. First, we load the four phenotypes vectors:

phenos <- lapply(LETTERS[1:4], function(x) {
sprintf("Phenotypes_screen_%s.txt", x)

})
phenos <- lapply(phenos, function(x) {

Phenotypes(system.file("extdata", x, package="gespeR"),

type = "SSP",
col.id = 1,
col.score = 2)

})
show(phenos[[1]])

ID
<fct>

Scores
<dbl>

## 1000 SSP Phenotypes
##
## # A tibble: 1,000 x 2
##
##
## 1 siRNAID_0001 -0.930
## 2 siRNAID_0002 -1.13
## 3 siRNAID_0003 -1.05
## 4 siRNAID_0004
## 5 siRNAID_0005 -1.42
## 6 siRNAID_0006
1.64
## 7 siRNAID_0007 -0.157
## 8 siRNAID_0008
0.748
## 9 siRNAID_0009 -0.959
## 10 siRNAID_0010 -0.0440
## # ... with 990 more rows

0.808

A visual representation of the phenotypes can be obtained with the plot method:

plot(phenos[[1]])

## ‘stat bin()‘ using ‘bins = 30‘.

Pick better value with ‘binwidth‘.

2

Now, we load the target relations for all four screens using the constructor of the TargetRelations class:

tr <- lapply(LETTERS[1:4], function(x) {

sprintf("TR_screen_%s.rds", x)

})
tr <- lapply(tr, function(x) {

TargetRelations(system.file("extdata", x, package="gespeR"))

})
show(tr[[2]])

colnames

## 1000 x 1500 siRNA-to-gene relations.
## 10 x 5 sparse Matrix of class "dgCMatrix"
##
## rownames
##
##
##
##
##
##
##
##
##
##
## ...

geneID_0001 geneID_0002 geneID_0003 geneID_0004 geneID_0005
.
.
.
.
.
.
.
.
.
.

siRNAID_0001
siRNAID_0002
siRNAID_0003
siRNAID_0004
siRNAID_0005
siRNAID_0006
siRNAID_0007
siRNAID_0008
siRNAID_0009
siRNAID_0010

.
.
0.4385757
.
.
.
.
.
.
.

.
.
.
.
.
.
.
.
.
.

.
.
.
.
.
.
.
.
.
.

.
.
.
.
.
.
.
.
.
.

3

Scores−5050100200300PhenotypeFrequencySSP PhenotypesFor large data sets, e.g. genome–wide screens, target relations objects can become very big and the user may
not want to keep all values in the RAM. For this purpose, we can use the unloadValues method. In this
example, we write the values to a temp-ﬁle, i.e. not the original source ﬁle, which may be required, when we
do not want to overwrite exisiting data, after, for instance, subsetting the target relations object.

# Size of object with loaded values
format(object.size(tr[[1]]), units = "Kb")

## [1] "717.7 Kb"

tempfile <- paste(tempfile(pattern = "file", tmpdir = tempdir()), ".rds", sep="")
tr[[1]] <- unloadValues(tr[[1]], writeValues = TRUE, path = tempfile)

# Size of object after unloading
format(object.size(tr[[1]]), units = "Kb")

## [1] "178.8 Kb"

# Reload values
tr[[1]] <- loadValues(tr[[1]])

In order to obtain deconvoluted gene-speciﬁc phenotypes (GSPs), we ﬁt four models on the four separate
data sets using cross validation by setting mode = "cv". We set the elastic net mixing parameter to 0.5 and
use only one core in this example:

res.cv <- lapply(1:length(phenos), function(i) {

gespeR(phenotypes = phenos[[i]],

target.relations = tr[[i]],

mode = "cv",
alpha = 0.5,
ncores = 1)

})

The ssp and gsp methods can be used to obtain SSP and GSP scores from a gespeR object:

ssp(res.cv[[1]])

ID
<fct>

Scores
<dbl>

## 1000 SSP Phenotypes
##
## # A tibble: 1,000 x 2
##
##
## 1 siRNAID_0001 -0.930
## 2 siRNAID_0002 -1.13
## 3 siRNAID_0003 -1.05
## 4 siRNAID_0004 0.808
## 5 siRNAID_0005 -1.42
## 6 siRNAID_0006 1.64
## 7 siRNAID_0007 -0.157
## 8 siRNAID_0008 0.748
## 9 siRNAID_0009 -0.959
## 10 siRNAID_0010 -0.0440
## # ... with 990 more rows

gsp(res.cv[[1]])

4

ID
<fct>

Scores
<dbl>

## 1500 GSP Phenotypes
##
## # A tibble: 1,500 x 2
##
##
## 1 geneID_0001 NA
## 2 geneID_0002 NA
## 3 geneID_0003 NA
## 4 geneID_0004 NA
## 5 geneID_0005 0.0281
## 6 geneID_0006 NA
## 7 geneID_0007 NA
## 8 geneID_0008 NA
## 9 geneID_0009 NA
## 10 geneID_0010 NA
## # ... with 1,490 more rows

head(scores(res.cv[[1]]))

ID
<fct>

Scores
<dbl>

## # A tibble: 6 x 2
##
##
## 1 geneID_0001 NA
## 2 geneID_0002 NA
## 3 geneID_0003 NA
## 4 geneID_0004 NA
## 5 geneID_0005 0.0281
## 6 geneID_0006 NA

The ﬁtted models can also be visualised using the plot method:

plot(res.cv[[1]])

## ‘stat bin()‘ using ‘bins = 30‘.
## Warning: Removed 1116 rows containing non-finite values (stat bin).

Pick better value with ‘binwidth‘.

5

The concordance method can be used to compute the concordance between ranked lists of phenotypes. Here
we compute concordance between all pairs of GSPs, as well as between all pairs of SSPs, from all four data
sets:

conc.gsp <- concordance(lapply(res.cv, gsp))
conc.ssp <- concordance(lapply(res.cv, ssp))

We can visualise the concordance objects using the plot method:

plot(conc.gsp) + ggtitle("GSPs\n")
plot(conc.ssp) + ggtitle("SSPs\n")

6

Scores−5.0−2.50.02.55.0050100150200250PhenotypeFrequencyGSP Phenotypes3 sessionInfo()

• R version 3.5.2 (2018-12-20), x86_64-pc-linux-gnu

• Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_US.UTF-8, LC_COLLATE=C,

LC_MONETARY=en_US.UTF-8, LC_MESSAGES=en_US.UTF-8, LC_PAPER=en_US.UTF-8, LC_NAME=C,
LC_ADDRESS=C, LC_TELEPHONE=C, LC_MEASUREMENT=en_US.UTF-8, LC_IDENTIFICATION=C

• Running under: Ubuntu 16.04.5 LTS

• Matrix products: default

• BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so

• LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so

• Base packages: base, datasets, grDevices, graphics, methods, stats, utils

• Other packages: gespeR 1.14.1, ggplot2 3.1.0, knitr 1.21

• Loaded via a namespace (and not attached): AnnotationDbi 1.44.0, Biobase 2.42.0,

BiocGenerics 0.28.0, BiocManager 1.30.4, Category 2.48.0, DBI 1.0.0, DEoptimR 1.0-8,
GSEABase 1.44.0, IRanges 2.16.0, MASS 7.3-51.1, Matrix 1.2-15, R6 2.3.0, RBGL 1.58.1,
RColorBrewer 1.1-2, RCurl 1.95-4.11, RSQLite 2.1.1, Rcpp 1.0.0, S4Vectors 0.20.1, XML 3.98-1.16,
aﬀy 1.60.0, aﬀyio 1.52.0, annotate 1.60.0, assertthat 0.2.0, bindr 0.1.1, bindrcpp 0.2.2, biomaRt 2.38.0,
bit 1.1-14, bit64 0.9-7, bitops 1.0-6, blob 1.1.1, cellHTS2 2.46.1, cli 1.0.1, cluster 2.0.7-1,
codetools 0.2-16, colorspace 1.3-2, compiler 3.5.2, crayon 1.3.4, digest 0.6.18, doParallel 1.0.14,
dplyr 0.7.8, evaluate 0.12, fansi 0.4.0, foreach 1.4.4, geneﬁlter 1.64.0, glmnet 2.0-16, glue 1.3.0,
graph 1.60.0, grid 3.5.2, gtable 0.2.0, highr 0.7, hms 0.4.2, httr 1.4.0, hwriter 1.3.2, iterators 1.0.10,
labeling 0.3, lattice 0.20-38, lazyeval 0.2.1, limma 3.38.3, locﬁt 1.5-9.1, magrittr 1.5, memoise 1.1.0,
munsell 0.5.0, mvtnorm 1.0-8, parallel 3.5.2, pcaPP 1.9-73, pillar 1.3.1, pkgconﬁg 2.0.2, plyr 1.8.4,
prada 1.58.1, preprocessCore 1.44.0, prettyunits 1.0.2, progress 1.2.0, purrr 0.2.5, reshape2 1.4.3,
rlang 0.3.0.1, robustbase 0.93-3, rrcov 1.4-7, scales 1.0.0, splines 3.5.2, splots 1.48.0, stats4 3.5.2,
stringi 1.2.4, stringr 1.3.1, survival 2.43-3, tibble 2.0.0, tidyselect 0.2.5, tools 3.5.2, utf8 1.1.4,
vsn 3.50.0, withr 2.1.2, xfun 0.4, xtable 1.8-3, zlibbioc 1.28.0

7

0.000.250.500.751.00CorrelationRBO (top)RBO (bottom)Jaccard IndexGSPsl0.000.250.500.751.00CorrelationRBO (top)RBO (bottom)Jaccard IndexSSPs