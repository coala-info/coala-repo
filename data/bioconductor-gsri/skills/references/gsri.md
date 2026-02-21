Introduction to the GSRI package:
Estimating Regulatory Effects utilizing the
Gene Set Regulation Index

Julian Gehring, Clemens Kreutz, Kilian Bartholome, Jens Timmer

October 30, 2025

1

Introduction

The GSRI package estimates the number of significantly regulated genes in
gene sets, assessing their differential effects between groups through statistical
testing. The approach is based on the fact that p-values of a statistical test
are uniformly distributed under the null hypothesis and shifted towards small
values in the case of its violation. The resulting density distribution ρ(p) of the
p-values p is then given as

ρ(p) = (1 − r)ρ0(p) + rρA(p),

with the fraction r of significant p-values, the uniform distribution ρ0(p) of the
p-values under the null hypothesis, and the alternative distribution ρA(p) of
the p-values with a significant effect. In the cumulative density function (CDF)
F (p) this is equivalent to

F (p) = (1 − r)p + r,

with the uniformly distributed ρ0(p) translating to a linear CDF with slope 1−r
and intercept r. Through iterative fitting of this linear component, r and thus
the number of regulated genes can be estimated. An example for the probability
and cumulative density distribution is shown in Figure 1.

The approach applied here does not require a cut-off value for the distinction
between regulated and unregulated genes, nor any assumptions about the alter-
native distribution ρA(p) of the p-values. Further, the method is independent
of the statistical test used to assess the differential effect of genes in terms of
p-values.

Estimates of the method include the number and fraction of regulated genes
as well as the Gene Set Regulation Index η (GSRI) for gene set. The GSRI η
is the 5% quantile of the distribution of the estimated number of differentially
expressed genes obtained from bootstrapping the group samples. It indicates
that with a probability of 95% more than η genes in the gene set are differentially
expressed. Utilizing the 5% quantile instead of the expectation ˆr introduces
a bias, but reduces the variability of the estimates and thereby improves the
performance for a ranking of gene sets. The index can also be employed to test
the hypothesis whether at least one gene in a gene set is regulated. Further,

1

Figure 1: Distributions of p-values in the probability and cumulative density,
as shown in the left and right panel, respectively. The ratio r of significant
tests have an unknown distribution shifted towards zero, while the remaining
fraction of 1 − r tests exhibits a uniform distribution. This translates to a
linear CDF with slope 1 − r and intercept r. By fitting the linear component
of the CDF, as indicated by the dashed line, the ratio of significant tests can
be estimated.

different gene sets can be compared or ranked according to the estimated amount
of regulation. For details of the method, an application to experimental data,
and a comparison with related approaches, see [1].

2 Data set

In this introduction we use the expression data set provided with the Biobase
package. It contains the expression intensities of 26 microarray samples with a
subset of 500 probe sets. The phenotypes associated with the samples are stored
in the pheno data of the ExpressionSet, including the categorical variables
type of disease and sex represented as factors, as well as the continuous score
indicating the progress of the disease.

> library(Biobase)
> data(sample.ExpressionSet)
> eset <- sample.ExpressionSet
> eset

ExpressionSet (storageMode: lockedEnvironment)
assayData: 500 features, 26 samples
element names: exprs, se.exprs

protocolData: none
phenoData

sampleNames: A B ... Z (26 total)
varLabels: sex type score
varMetadata: labelDescription

2

p−value pprobability density r(p)00.510121-r1-rrp−value pcumulative density F(p)00.5100.51r1-rfeatureData: none
experimentData: use 'experimentData(object)'
Annotation: hgu95av2

> exprs <- exprs(eset)
> phenotypes <- pData(phenoData(eset))
> summary(phenotypes)

sex

type

score

Female:11
:15
Male

:15
Case
Control:11

:0.1000
Min.
1st Qu.:0.3275
Median :0.4150
Mean
:0.5369
3rd Qu.:0.7650
:0.9800
Max.

Please note that we are using this sample data to illustrate general workflows
for the analysis of gene sets with the GSRI package. Therefore, the results ob-
tained here should not be interpreted in the context of their biological meaning.

3 Analysis for a single gene set

Given the expression data we want to find out how many genes show a differ-
ential effect with respect to the phenotypic variables, in our case the groups sex
and type. In a first step we include all genes in the analysis and focus on the
type phenotype.

> library(GSRI)
> gAllProbes <- gsri(eset, phenotypes$type)
> gAllProbes

pRegGenes pRegGenesSd nRegGenes GSRI(5%) nGenes
500

0.1428812

1 0.1425405

71

0

This indicates that around 14% of the genes seem to be regulated. However,
taking the corresponding standard deviation of around 14% and the GSRI of
0% at the 5% confidence level into account, we have just an indication for a
differential effect.

In the next step we exclude the controls of the Affymetrix microarray since
they do not contain relevant information for our analysis. For this we define
an object gsAllGenes of the class GeneSet with the subset of genes of interest.
Note that in this case we could also use a subset of eset or exprs without an
additional GeneSet object. For more details on how to define, import, and ma-
nipulate gene sets, please refer to the documentation of the GSEABase package
[2].

> library(GSEABase)
> gs <- GeneSet(eset, setName="allGenes")
> ind <- grep("^AFFX", geneIds(gs), invert=TRUE)
> gsAllGenes <- gs[ind]
> gsAllGenes

3

setName: allGenes
geneIds: 31307_at, 31308_at, ..., 31739_at (total: 433)
geneIdType: Annotation (hgu95av2)
collectionType: ExpressionSet
details: use 'details(object)'

> gAllGenesType <- gsri(eset, phenotypes$type, gsAllGenes, name="allGenesType")
> gAllGenesSex <- gsri(exprs, phenotypes$sex, gsAllGenes, name="allGenesSex")
> gAllGenesType

allGenesType 0.1626202

pRegGenes pRegGenesSd nRegGenes GSRI(5%) nGenes
433

0.1386983

70

0

> gAllGenesSex

allGenesSex

pRegGenes pRegGenesSd nRegGenes GSRI(5%) nGenes
433

0.1101468

0

0

0

Taking only probes for human genes into acount we explore the effect of the
type and sex variable. While the type of disease seems to have a differential
effect on the gene expression, the sex of the patient shows no indication to play
a role in this example.

The GSEABase package provides methods for importing gene sets from dif-
ferent sources. Here we import a gene set from an .xml file, with genes located
on chromosome 17.

> gsChr17 <- getBroadSets(system.file("extdata", "c1chr17.xml", package="GSRI"))
> gsChr17

GeneSetCollection

names: chr17 (1 total)
unique identifiers: 32120_at, 40008_at, ..., 36103_at (526 total)
types in collection:

geneIdType: SymbolIdentifier (1 total)
collectionType: BroadCollection (1 total)

> gChr17 <- gsri(eset, phenotypes$type, gsChr17)
> gChr17

pRegGenes pRegGenesSd nRegGenes

chr17 0.2398971

0.1387606

GSRI(5%) nGenes
12

2 0.02437104

4 Analysis for multiple gene sets

It is often desirable to perform the GSRI analysis for an experimental data set,
comparing several gene sets. This task can be approached with an object of the
class GeneSetCollection combining multiple GeneSet objects.

We import five gene sets from a .gmt file and perform the analysis for those
with respect to the type variable. Afterwards, we sort the gene sets according
to the estimated number and fraction of genes, and export the results as a table
to disk. The summary method provides a more detailed overview including the
parameters used for the analysis.

4

> gmt <- getGmt(system.file("extdata", "c1c10.gmt", package="GSRI"))
> gCol5 <- gsri(eset, phenotypes$type, gmt)
> gCol5

pRegGenes pRegGenesSd nRegGenes
0.0000000
chr2
chr19q13 0.4010159
0.4679782
chr6
0.1126934
chr8
0.3778584
chr9

0.1451871
0.1746595
0.1312175
0.1742302
0.1491297

GSRI(5%) nGenes
24
12
23
12
10

0 0.00000000
4 0.09083227
10 0.24046927
1 0.00000000
3 0.13259385

> gCol5Sort <- sortGsri(gCol5, c("nRegGenes", "pRegGenes"))
> summary(gCol5Sort)

* Summary of the GSRI analysis for 5 gene sets:

** Results

chr6
chr19q13
chr9
chr8
chr2

pRegGenes pRegGenesSd nRegGenes GSRI(5%) nGenes
23
12
10
12
24

0.2405
0.0908
0.1326
0.0000
0.0000

0.1312
0.1747
0.1491
0.1742
0.1452

0.4680
0.4010
0.3779
0.1127
0.0000

10
4
3
1
0

** Parameter

nBoot alpha grenander weighting
FALSE

0.05

TRUE

100

> exportFile <- tempfile()
> export(gCol5Sort, exportFile)

5 Adaption of statistical tests

As pointed out in the introduction, the GSRI approach is independent of the
underlying statistical test. By default a t-test is used to assess the differential
effect between two groups. With an F-test an arbitrary number of groups can
be used for the analysis, while for two groups it is equivalent to the t-test.

As an example we arbitrarily define three groups based on the score variable
indicating the progress of the disease. For this analysis we use the F-test rowF
provided with this package.

> phenotypes$class <- cut(phenotypes$score, seq(0, 1, length.out=4), label=c("low", "medium", "high"))
> summary(phenotypes$class)

low medium
8

7

high
11

> g3 <- gsri(eset, phenotypes$class, gsChr17, test=rowF)
> g3

chr17 0.07862739

pRegGenes pRegGenesSd nRegGenes GSRI(5%) nGenes
12

0.1329572

0

0

5

The GSRI approach has several parameters that can be changed in order to
adapt the analysis. For illustration we rename the gene set, change the number
of bootstraps and confidence level for the GSRI calculation, and use a classical
ECDF instead of the modified Grenander estimator for the cumulative density.

> g3arg2 <- gsri(eset, phenotypes$class, gsChr17, test=rowF, name="chr17_2", nBoot=50, alpha=0.1, grenander=FALSE)
> g3arg2

chr17_2 0.1055541

pRegGenes pRegGenesSd nRegGenes GSRI(10%) nGenes
12

0.1167119

1

0

We can also easily implement our own statistical tests for the GSRI anal-
ysis. Next, we want to apply an approach taken by the limma package [3]
which as an increased power for small sample sizes. The canonical structure of
the test function has to be called as function(exprs, groups, id, index,
testArgs), with exprs the matrix of expression intensities, groups the factor of
groups defining the differential contrast, id the indices for the genes part of the
current gene set, index the indices for the samples in the bootstrapping, and
testArgs the list with optional arguments used by the test function.

design <- cbind(offset=1, diff=groups)
fit <- lmFit(exprs[ ,index], design)
fit <- eBayes(fit)
pval <- fit$p.value[id,"diff"]
return(pval)

> library(limma)
> limmaTest <- function(exprs, groups, id, index, testArgs) {
+
+
+
+
+
+ }
> g3Limma <- gsri(eset, phenotypes$type, gsChr17, test=limmaTest)
> g3Limma

pRegGenes pRegGenesSd nRegGenes

GSRI(5%) nGenes
12

2 0.005084557

chr17 0.2397355

0.1506783

6 Visualization

The results of the GSRI analysis can be visualized, showing the empirical cu-
mulative p-values distribution along with the fit of the null distribution ρ0(p)
as well as the estimated fraction ˆr of significant genes and the GSRI η.

> plot(g3)

The plot method has an advanced system in order to customize the plot in
different aspects. This allows us to directly adapt nearly any property of the
figure. For a detailed description, please refer to the documentation of the plot
method.

> plot(gCol5, 5, ecdf=list(type="o"), plot=list(xlab="p", main="GSRI results: chr9"), reg=list(col="lightblue", lty=1, lwd=1.5), gsri=list(col="darkblue"))

6

Figure 2: Visualization of GSRI results

7 Weighting of genes in gene sets

In contrast to other approaches estimating the degree of regulation, the GSRI
package does also allow assign the weighting of each gene in the calculation. Such
a step is useful for including additional information in the estimation process,
for example the certainty that a gene is part of a gene set.

In the following we use a very simple approach in defining weights for the gene
sets based on the Gene Ontology (GO) annotation. For genes with experimental
evidence, we assign higher weights than for those without. Please note that the
weights used here are defined arbitrarily and more sophisticated approaches can
be used in the actual analysis.

> library(hgu95av2.db)
> gNames <- rownames(exprs(eset))
> ind <- Lkeys(hgu95av2GO) %in% gNames
> evidence <- factor(toTable(hgu95av2GO)[ind,"Evidence"])
> summary(evidence)

EXP
27
ISA

HDA HEP
352
1
ISS NAS
45 1104 438

HMP
5
ND
2

HTP IBA
32 1903
RCA TAS
2 1391

IC
IDA IEA
60 3153 7274

IEP
34

IGI IMP
851

86

IPI
673

> l <- lapply(gNames, function(name, names, evidence) evidence[names %in% name], gNames, evidence)
> expInd <- sapply(l, function(l) any(l %in% "EXP"))

7

0.00.20.40.60.81.00.00.20.40.60.81.0chr17p−valuesECDF(p)%RegGenes=0.08%GSRI=0.00Figure 3: Visualization of GSRI results, with customized parameters.

> goWeight <- rep(0.5, length.out=length(expInd))
> goWeight[expInd] <- 1
> gCol5go <- gsri(eset, phenotypes$type, weight=goWeight)
> gCol5go

pRegGenes pRegGenesSd nRegGenes GSRI(5%) nGenes
500

0.1346015

1 0.1409507

70

0

> gCol5go2 <- gsri(eset, phenotypes$type, gmt, weight=goWeight)
> gCol5go2

pRegGenes pRegGenesSd nRegGenes

GSRI(5%) nGenes
24
12
23
12
10

0 0.00000000
4 0.10779447
10 0.25938753
1 0.00000000
3 0.08867302

2.220446e-16
chr2
chr19q13 4.010159e-01
4.634156e-01
chr6
1.319030e-01
chr8
3.778584e-01
chr9

0.1324177
0.1962047
0.1227771
0.1734587
0.1621898

8

0.00.20.40.60.81.00.00.20.40.60.81.0GSRI results: chr9pECDF(p)%RegGenes=0.38%GSRI=0.13References

[1] Kilian Bartholome, Clemens Kreutz, and Jens Timmer. Estimation of gene
induction enables a relevance-based ranking of gene sets. Journal of Com-
putational Biology: A Journal of Computational Molecular Cell Biology,
16(7):959–967, July 2009. PMID: 19580524.

[2] Martin Morgan, Seth Falcon, and Robert Gentleman. GSEABase: Gene set

enrichment data structures and methods.

[3] Gordon K. Smyth. Limma: linear models for microarray data. In R. Gentle-
man, V. Carey, S. Dudoit, R. Irizarry, and W. Huber, editors, Bioinformat-
ics and Computational Biology Solutions using R and Bioconductor, pages
397–420. Springer, New York, 2005.

Session info

• R version 4.5.1 Patched (2025-08-23 r88802), x86_64-pc-linux-gnu

• Running under: Ubuntu 24.04.3 LTS

• Matrix products: default

• BLAS: /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

• LAPACK:

/usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

• Base packages: base, datasets, grDevices, graphics, methods, stats,

stats4, utils

• Other packages: AnnotationDbi 1.72.0, Biobase 2.70.0,

BiocGenerics 0.56.0, GSEABase 1.72.0, GSRI 2.58.0, IRanges 2.44.0,
S4Vectors 0.48.0, XML 3.99-0.19, annotate 1.88.0, fdrtool 1.2.18,
generics 0.1.4, graph 1.88.0, hgu95av2.db 3.13.0, limma 3.66.0,
org.Hs.eg.db 3.22.0

• Loaded via a namespace (and not attached): Biostrings 2.78.0,

DBI 1.2.3, KEGGREST 1.50.0, KernSmooth 2.23-26, Matrix 1.7-4,
MatrixGenerics 1.22.0, R6 2.6.1, RColorBrewer 1.1-3, RSQLite 2.4.3,
Seqinfo 1.0.0, XVector 0.50.0, bit 4.6.0, bit64 4.6.0-1, bitops 1.0-9,
blob 1.2.4, boot 1.3-32, caTools 1.18.3, cachem 1.1.0, cli 3.6.5,
compiler 4.5.1, crayon 1.5.3, fastmap 1.2.0, genefilter 1.92.0, gplots 3.2.0,
grid 4.5.1, gtools 3.9.5, httr 1.4.7, lattice 0.22-7, les 1.60.0,
matrixStats 1.5.0, memoise 2.0.1, pkgconfig 2.0.3, png 0.1-8, rlang 1.1.6,
splines 4.5.1, statmod 1.5.1, survival 3.8-3, tools 4.5.1, vctrs 0.6.5,
xtable 1.8-4

9

