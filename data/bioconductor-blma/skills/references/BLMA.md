BLMA: A package for bi-level meta-analysis

Tin Nguyen, Hung Nguyen and Sorin Draghici
Department of Computer Science, Wayne State University, Detroit MI 48202

October 29, 2025

Abstract

This package provides a bi-level meta-analysis (BLMA) framework that can be applied in a
wide range of applications: functional analysis, pathway analysis, differential expression analysis,
and general hypothesis testing. The framework is able to integrate multiple studies to gain more
statistical power, and can be used in conjunction with any statistical hypothesis testing method.
It exploits not only the vast number of studies performed in independent laboratories, but also
makes better use of the available number of samples within individual studies. In this document,
we provide example code that applies BLMA in all of the areas mentioned above.

Contents

1 Introduction

2 BLMA for classical hypothesis testing

Intra-experiment analysis

2.1
2.2 Bi-level meta-analysis

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3 BLMA for geneset/pathway analysis

3.1 Over-Representation Analysis (ORA) . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.2 Gene Set Analysis (GSA)
3.3 Pathway Analysis with Down-weighting of Overlapping Genes (PADOG) . . . . . . .
Impact Analysis (IA) . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.4

4 BLMA for differential expression analysis

Intra-experiment analysis

4.1
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4.2 Bi-level analysis . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

5 BLMA for network-based integrative analysis

1

2

2
2
5

6
6
7
8
8

9
9
11

11

1

Introduction

This document provides an introductory description on how to use the package. For the extended
description of the methods, please consult Nguyen et al. [1]. The bi-level meta-analysis (BLMA)
framework integrates independent experiments at two levels: an intra-experiment analysis, and
an inter-experiment analysis. First, for each experiment, the intra-experiment analysis splits the
dataset into smaller datasets, performs a statistical test on each of the newly created small datasets,
then combines the p-values. Next, the inter-experiment analysis combines those processed p-values,
from each of the individual experiments.

In this package, we implement useful functions that allow users to integrate data in many
applications. First, we implement classical methods for combining independent p-values, including
Fisher’s method [2], Stouffer’s method [3]. We also implement our new method named addCLT [1,
4, 5, 6], which is based on the Irwin-Hall distribution [7, 8] and the Central Limit Theorem [9].
These methods of combining p-values (addCLT, Fisher’s, Stouffer’s, minP, and maxP) are the basic
building blocks of the BLMA framework.

Second, we implement functions for BLMA that can be applied in conjunction with classical
tests, such as t-test, Wilcoxon test, etc. We provide code and examples for applying the intra-
experiment analysis and bi-level analysis in conjunction with t-test and Wilcoxon test. The functions
are flexible and can be applied for one-sample, two-samples, one-tailed, and two-tailed tests. By
default, addCLT [1, 4, 5, 6] is used to combine the p-values, but users can change it to Fisher’s
method [2], Stouffer’s method [3], minP [10], or maxP [11], according to their preference.

Third, we implement functions for functional analysis and pathway analysis. Users can choose
to apply the BLMA framework in conjunction with any of the 4 methods: Over-Representation
Analysis (ORA) [12, 13], Gene Set Analysis (GSA) [14], Pathway Analysis with Down-weighting of
Overlapping Genes (PADOG) [15], and Impact Analyis (IA) [16]. When there is only one dataset,
the analysis is reduced to an intra-experiment analysis. The functions are flexible and easy to run.
Fourth, we implement functions for differential expression analysis. The package uses the mod-
erated t-test (limma package [17]) as the test for differential expression. In the intra-experiment
analysis, the framework splits a dataset into smaller datasets, performs the moderated t-test on
these split datasets, and then combines the results. In the inter-experiment analysis, the framework
combines the results obtained from the intra-experiment analysis of individual datasets. The output
is a list of genes ranked according to how likely they are to be differentially expressed.

2 BLMA for classical hypothesis testing

Our bi-level meta-analysis framework is comprised of an intra-experiment and an inter-experiment
analysis. The reasoning for the intra-experiment is that performing a statistical test on a large
experiment is not as powerful as splitting it into smaller studies and then combining them. See
Nguyen et al. [1] for a detailed explanation.

2.1

Intra-experiment analysis

We design the function intraAnalysisClassic in a way that it can be used in conjunction with classical
tests without any restriction. For example, intead of calling one-sample left-tailed t-test or Wilcoxon
test, users can call the function intraAnalysisClassic with the same parameters. Below are examples
of how to use t-test and Wilcoxon test:

2

> # one-sample tests
> library(BLMA)
> set.seed(1)
> x <- rnorm(10, mean = 0)
> # one-sample left-tailed t-test
> t.test(x, mu=1, alternative = "less")$p.value

[1] 0.003280397

> # one-sample left-tailed intra-experiment analysis with t-test
> intraAnalysisClassic(x, func=t.test, mu=1, alternative = "less")

[1] 0.003090177

> # one-sample right-tailed t-test
> t.test(x, mu=1, alternative = "greater")$p.value

[1] 0.9967196

> # one-sample right-tailed intra-experiment analysis with t-test
> intraAnalysisClassic(x, func=t.test, mu=1, alternative = "greater")

[1] 0.9969098

> # one-sample two-tailed t-test
> t.test(x, mu=1)$p.value

[1] 0.006560794

> # one-sample two-tailed intra-experiment analysis with t-test
> intraAnalysisClassic(x, func=t.test, mu=1)

[1] 0.01236071

> # one-sample left-tailed Wilcoxon test
> wilcox.test(x, mu=1, alternative = "less")$p.value

[1] 0.006835938

> # one-sample left-tailed intra-experiment analysis with Wilcoxon test
> intraAnalysisClassic(x, func=wilcox.test, mu=1, alternative = "less")

[1] 0.004394531

> # one-sample right-tailed Wilcoxon test
> wilcox.test(x, mu=1, alternative = "greater")$p.value

[1] 0.9951172

> # one-sample right-tailed intra-experiment analysis with Wilcoxon test
> intraAnalysisClassic(x, func=wilcox.test, mu=1, alternative = "greater")

3

[1] 0.9995117

> # one-sample two-tailed Wilcoxon test
> wilcox.test(x, mu=1)$p.value

[1] 0.01367188

> # one-sample two-tailed intra-experiment analysis with Wilcoxon test
> intraAnalysisClassic(x, func=wilcox.test, mu=1)

[1] 0.01757812

Similarly, the intra-experiment analysis can be used with two-sample tests:

> # two-sample tests
> set.seed(1)
> x <- rnorm(20, mean=0); y=rnorm(20, mean=1)
> # two-sample left-tailed t-test
> t.test(x,y,alternative="less")$p.value

[1] 0.003561452

> # two-sample left-tailed intra-experiment analysis with t-test
> intraAnalysisClassic(x, y, func=t.test, alternative = "less")

[1] 0.0001387321

> # two-sample right-tailed t-test
> t.test(x,y,alternative="greater")$p.value

[1] 0.9964385

> # two-sample right-tailed intra-experiment analysis with t-test
> intraAnalysisClassic(x, y, func=t.test, alternative = "greater")

[1] 0.9998613

> # two-sample two-tailed t-test
> t.test(x,y)$p.value

[1] 0.007122904

> # two-sample two-tailed intra-experiment analysis with t-test
> intraAnalysisClassic(x, y, func=t.test)

[1] 0.002219713

4

2.2 Bi-level meta-analysis

Some example code for bi-level meta-analysis:

> # one-sample tests
> set.seed(1)
> l1 <- lapply(as.list(seq(3)),FUN=function (x) rnorm(n=10, mean=1))
> l0 <- lapply(as.list(seq(3)),FUN=function (x) rnorm(n=10, mean=0))
> # one-sample right-tailed t-test
> lapply(l1, FUN=function(x) t.test(x, alternative="greater")$p.value)

[[1]]
[1] 0.0006575675

[[2]]
[1] 0.002488991

[[3]]
[1] 0.009286192

> # combining the p-values of one-sample t-test:
> addCLT(unlist(lapply(l1, FUN=function(x)
+

t.test(x, alternative="greater")$p.value)))

[1] 3.202952e-07

> #Bi-level meta-analysis with one-sample right-tailed t-test
> bilevelAnalysisClassic(x=l1, func=t.test, alternative="greater")

[1] 2.765896e-07

> # two-sample left-tailed t-test
> lapply(seq(l1), FUN=function(i,l1,l0)
+

t.test(l1[[i]], l0[[i]], alternative="greater")$p.value, l1, l0)

[[1]]
[1] 0.005366316

[[2]]
[1] 0.006030029

[[3]]
[1] 0.05919203

> # combining the p-values of one-sample t-test:
> addCLT(unlist(lapply(seq(l1), FUN=function(i,l1,l0)
+

t.test(l1[[i]], l0[[i]], alternative="greater")$p.value, l1, l0)))

[1] 5.862034e-05

5

> #Bi-level meta-analysis with two-sample right-tailed t-test
> bilevelAnalysisClassic(x=l1, y=l0, func=t.test, alternative="greater")

[1] 7.899649e-06

> #Bi-level meta-analysis with two-sample left-tailed t-test
> bilevelAnalysisClassic(x=l1, y=l0, func=t.test, alternative="less")

[1] 0.9999921

3 BLMA for geneset/pathway analysis

For pathway/geneset analysis, the input of the framework is as follows. First, we have multiple
studies (datasets) of the same disease. Each dataset consists of a group of control samples and a
group of disease samples. Second, we have a list of genesets or pathways from an existing pathway
database.

With the current implementation, the meta-analysis can be used in conjunction with the follow-
ing approaches: Over-Representation Analysis (ORA) [12], Gene Set Analysis (GSA) [14], Pathway
Analysis with Down-weighting of Overlapping Genes (PADOG) [15], and Impact Analyis (IA) [16].
By default, we use ORA as the enrichment method, which is very fast and is able to integrate hun-
dreds of samples in a matter of seconds. Other enrichment methods are slower than ORA, and we
encourage users to take advantage of our parallel computing by providing the number of processes
via the mc.cores parameter.

3.1 Over-Representation Analysis (ORA)

We demonstrate this functionality using 4 acute myeloid leukemia (AML) datasets: GSE17054 (9
samples) [18], GSE57194 (12 samples) [19], GSE33223 (30 samples) [20], and GSE42140 (31 sam-
ples). The platform for all datasets is Affymetrix Human Genome U133 Plus 2.0 array. Affymetrix
CEL files containing raw expression data were downloaded from GEO for each dataset and processed
using R and Bioconductor 2.13. Quality control was performed using the qc method from the pack-
age simpleaffy 2.38.0 [21]. Pre-processing was performed on individual datasets using the threestep
function from the package affyPLM version 1.38.0 [22, 23, 24]. We calculate the expression value
of a gene by taking the median of the probesets that are mapped to the gene. Below is the code for
performing BLMA in conjunction with ORA [12, 13] for the 4 datasets:

> library(BLMA)
> # load KEGG pathways and create genesets
> x=loadKEGGPathways()
> gslist <- lapply(x$kpg,FUN=function(y){return (nodes(y));})
> gs.names <- x$kpn[names(gslist)]
> # load the 4 AML datasets
> dataSets <- c("GSE17054", "GSE57194", "GSE33223", "GSE42140")
> data(list=dataSets, package="BLMA")
> # prepare dataList and groupList
> names(dataSets) <- dataSets
> dataList <- lapply(dataSets, function(dataset) get(paste0("data_", dataset)))
> groupList <- lapply(dataSets, function(dataset) get(paste0("group_", dataset)))

6

> # perform bi-level meta-analysis in conjunction with ORA
> system.time(ORAComb <- bilevelAnalysisGeneset(gslist, gs.names, dataList,
+

groupList, enrichment = "ORA"))

Working on dataset GSE17054, 9 samples
Working on dataset GSE57194, 12 samples
Working on dataset GSE33223, 30 samples
Working on dataset GSE42140, 31 samples

user
2.208

system elapsed
2.249

0.041

> #print the results
> options(digits=2)
> head(ORAComb[, c("Name", "pBLMA", "pBLMA.fdr", "rBLMA")])

Name

Pathways in cancer 2.9e-05
path:hsa05200
p53 signaling pathway 3.9e-04
path:hsa04115
Acute myeloid leukemia 5.9e-04
path:hsa05221
Apoptosis 1.1e-03
path:hsa04210
path:hsa04390
Hippo signaling pathway 4.8e-03
path:hsa05169 Epstein-Barr virus infection 5.8e-03

pBLMA pBLMA.fdr rBLMA
1
2
3
4
5
6

0.0043
0.0289
0.0291
0.0401
0.1288
0.1288

The running time for ORA is only 4 seconds. With a cutoff of 0.05, there are 4 significant
pathways, among which the target pathway Acute myeloid leukemia is ranked 3rd with a FDR-
corrected p-value 0.029.

3.2 Gene Set Analysis (GSA)

We can also perform BLMA in conjunction with GSA [14]. Since the function GSA (from the GSA
package) is not as fast as ORA, we recommend users to take advantage of our parallel computing,
by setting the number of cores using the mc.cores parameter:

> # perform bi-level meta-analysis in conjunction with GSA
> system.time(GSAComb <- bilevelAnalysisGeneset(gslist, gs.names, dataList,
+
+

groupList, enrichment = "GSA",
nperms=200, random.seed = 1))

Working on dataset GSE17054, 9 samples
Working on dataset GSE57194, 12 samples
Working on dataset GSE33223, 30 samples
Working on dataset GSE42140, 31 samples

user
19.64

system elapsed
19.92

0.26

> #print the results
> options(digits=2)
> head(GSAComb[, c("Name", "pBLMA", "pBLMA.fdr", "rBLMA")])

7

Name

Apoptosis 0.00056
path:hsa04210
path:hsa05161
Hepatitis B 0.00082
path:hsa05221 Acute myeloid leukemia 0.00086
path:hsa05222 Small cell lung cancer 0.00464
path:hsa05212
Pancreatic cancer 0.00570
path:hsa04012 ErbB signaling pathway 0.00648

pBLMA pBLMA.fdr rBLMA
1
2
3
4
5
6

0.042
0.042
0.042
0.160
0.160
0.160

The running time of the meta-analysis in conjunction with GSA is approximately 1 minutes with
1 core. With a cutoff of FDR=0.05, there are 2 significant pathways: Apoptosis and Acute myeloid
leukemia . The target pathway Acute myeloid leukemia is ranked 2rd with a FDR-corrected p-value
0.023.

3.3 Pathway Analysis with Down-weighting of Overlapping Genes (PADOG)

Below is an example code for running BLMA in conjunction with PADOG [15]:

> set.seed(1)
> system.time(PADOGComb <- bilevelAnalysisGeneset(gslist, gs.names, dataList,
+

groupList, enrichment = "PADOG", NI=200))

Working on dataset GSE17054, 9 samples
Working on dataset GSE57194, 12 samples
Working on dataset GSE33223, 30 samples
Working on dataset GSE42140, 31 samples

user
47.36

system elapsed
47.75

0.39

> #print the results
> options(digits=2)
> head(PADOGComb[, c("Name", "pBLMA", "pBLMA.fdr", "rBLMA")])

Name

ErbB signaling pathway 0.0031
path:hsa04012
Hippo signaling pathway 0.0033
path:hsa04390
path:hsa05221
Acute myeloid leukemia 0.0040
path:hsa04810 Regulation of actin cytoskeleton 0.0056
path:hsa04210
Apoptosis 0.0068
Amphetamine addiction 0.0073
path:hsa05031

pBLMA pBLMA.fdr rBLMA
1
2
3
4
5
6

0.18
0.18
0.18
0.18
0.18
0.18

3.4

Impact Analysis (IA)

Impact Analysis (IA) is a topology-based pathway analysis approach that is able to take into
consideration the interaction between genes [16]. Pathway information can be provided in the format
of pathway graphs (e.g., graphNEL). Below is an example code for running BLMA in conjunction
with IA:

> x <- loadKEGGPathways()
> system.time(IAComb <- bilevelAnalysisPathway(x$kpg, x$kpn, dataList, groupList))

8

Working on dataset GSE17054, 9 samples
Working on dataset GSE57194, 12 samples
Working on dataset GSE33223, 30 samples
Working on dataset GSE42140, 31 samples

user
53.50

system elapsed
53.79

0.28

> #print the results
> options(digits=2)
> head(IAComb[, c("Name", "pBLMA", "pBLMA.fdr", "rBLMA")])

Transcriptional misregulation in cancer 6.0e-06
path:hsa05202
path:hsa05221
Acute myeloid leukemia 4.7e-05
path:hsa04650 Natural killer cell mediated cytotoxicity 3.1e-03
Pathways in cancer 3.1e-03
path:hsa05200
p53 signaling pathway 4.8e-03
path:hsa04115
Pancreatic cancer 6.9e-03
path:hsa05212

pBLMA pBLMA.fdr rBLMA
1
2
3
4
5
6

0.00088
0.00347
0.11517
0.11517
0.13996
0.16822

Name

4 BLMA for differential expression analysis

The package also provides functions for differential expression analysis across multiple datasets.
The input is a set of datasets from the same condition while the output is a list of genes ranked
according to their p-values. Here we use the moderated t-test (limma package [17]) as the test for
differential expression. As described above, BLMA performs the hypothesis testing at two levels:
an intra-experiment analysis and an inter-experiment analysis. At the intra-experiment analysis,
BLMA splits a dataset into smaller datasets, performs the moderated t-test for individual genes,
and then combines the results obtained from these split datasets. At the inter-experiment analysis,
the processed p-values from individual experiments are combined again. By default, the method
addCLT is used to combine the p-values, but users can set it to Fisher’s, Stouffer’s method, minP,
or maxP, according to their preference.

4.1

Intra-experiment analysis

The input for intra-experiment analysis is a dataset provided in a data frame. The output consists of
the following information: i) logFC: log foldchanges, ii) pLimma: p-values calculated by limma with
out intra-experiment analysis, iii) FDR-correct p-values of pLimma, iv) pIntra: p-values obtained
from the intra-experiment analysis, and v) FDR-corrected p-values of pIntra. The code for analyzing
the dataset GSE33223 is as follows:

> #perform intra-experiment analysis of the dataset GSE33223 using addCLT
> library(BLMA)
> data(GSE33223)
> system.time(X <- intraAnalysisGene(data_GSE33223, group_GSE33223))

user
0.46

system elapsed
0.46

0.00

9

> X <- X[order(X$pIntra), ]
> # top 10 genes
> head(X)

logFC

pLimma pLimma.fdr

hsa:8761
hsa:801
hsa:2744
hsa:3625
hsa:5872
hsa:81691

0.88 2.9e-07
-0.79 4.6e-08
0.80 7.7e-06
-0.47 1.2e-07
-2.33 2.8e-04
1.26 7.9e-07

> # bottom 10 genes
> tail(X)

0.00040 9.3e-12
0.00019 1.4e-11
0.00291 3.0e-11
0.00025 3.1e-11
0.01561 6.4e-11
0.00081 6.5e-11

pIntra pIntra.fdr
2.8e-08
2.8e-08
3.2e-08
3.2e-08
4.4e-08
4.4e-08

hsa:26664 -0.0152
0.0365
hsa:9451
-0.0131
hsa:2961
-0.0295
hsa:712
-0.0119
hsa:904
-0.0065
hsa:655

logFC pLimma pLimma.fdr pIntra pIntra.fdr
1
0.92
1
0.94
1
0.96
1
0.95
1
0.97
1
0.96

0.85
0.90
0.94
0.92
0.96
0.93

1
1
1
1
1
1

> #perform intra-experiment analysis of GSE33223 using Fisher's method
> system.time(Y <- intraAnalysisGene(data_GSE33223, group_GSE33223,
+

metaMethod=fisherMethod))

user
0.36

system elapsed
0.36

0.00

> Y = Y[order(Y$pIntra), ]
> # top 10 genes
> head(Y)

logFC

pLimma pLimma.fdr

hsa:81691
hsa:2744
hsa:5872
hsa:3625
hsa:8761
hsa:1029

1.26 7.9e-07
0.80 7.7e-06
-2.33 2.8e-04
-0.47 1.2e-07
0.88 2.9e-07
1.29 4.1e-04

> # bottom 10 genes
> tail(Y)

0.00081 3.5e-11
0.00291 1.6e-10
0.01561 3.5e-10
0.00025 1.1e-09
0.00040 1.5e-09
0.01821 1.7e-09

pIntra pIntra.fdr
1.4e-07
3.2e-07
4.8e-07
1.2e-06
1.2e-06
1.2e-06

hsa:26664 -0.0152
0.0365
hsa:9451
-0.0131
hsa:2961
-0.0295
hsa:712
-0.0119
hsa:904
-0.0065
hsa:655

logFC pLimma pLimma.fdr pIntra pIntra.fdr
1
0.92
1
0.94
1
0.96
1
0.95
1
0.97
1
0.96

0.85
0.90
0.94
0.92
0.96
0.93

1
1
1
1
1
1

10

4.2 Bi-level analysis

For bi-level analysis, the input is a list of multiple datasets. The ouput consists of the following in-
formation: i) pLimma: combined p-values of limma p-values obtained from individual expriments,
ii) pLimma.fdr: FDR-correct p-values of pLimma, iii) pBilevel: combined p-values of pIntra ob-
tained from individual experiments, and iv) pBilevel.fdr: FDR-corrected p-values of pBilevel. We
demonstrate the bi-level analysis using the 8 example datasets as follows:

> system.time(Z <- bilevelAnalysisGene(dataList = dataList, groupList = groupList))

Working on dataset GSE17054, 9 samples
Working on dataset GSE57194, 12 samples
Working on dataset GSE33223, 30 samples
Working on dataset GSE42140, 31 samples

user
1.824

system elapsed
1.865

0.041

> # top 10 genes
> head(Z)

hsa:3611
3.9e-06
hsa:54407 1.4e-06
hsa:55914 1.2e-05
1.3e-05
hsa:8660
hsa:4194
2.0e-05
hsa:23237 2.5e-05

pLimma pLimma.fdr pBilevel pBilevel.fdr
0.0018
0.0018
0.0018
0.0018
0.0020
0.0042

1.2e-06
1.4e-06
1.4e-06
1.7e-06
2.5e-06
6.2e-06

0.0079
0.0058
0.0110
0.0110
0.0134
0.0148

> # bottom 10 genes
> tail(Z)

hsa:64106
hsa:259291
hsa:6572
hsa:347733
hsa:116443
hsa:3605

pLimma pLimma.fdr pBilevel pBilevel.fdr
1
1
1
1
1
1

0.96
1.00
1.00
0.99
0.98
0.98

0.97
1.00
1.00
0.99
0.98
0.99

1
1
1
1
1
1

5 BLMA for network-based integrative analysis

BLMA also provides a function to estimate the effect sizes of genes across all studies (standardized
mean difference) and their p-values. The function also performs classical hypothesis testing and
meta-analysis to combine p-values for differential expressed genes across all studies. These statistics
can be used as input of both geneset- and network-based analysis [25].

> allGenes <- Reduce(intersect, lapply(dataList, rownames))
> system.time(geneStat <- getStatistics(allGenes, dataList = dataList, groupList = groupList))

11

user
58.38

system elapsed
58.70

0.31

> # top 10 genes
> head(Z)

hsa:3611
3.9e-06
hsa:54407 1.4e-06
hsa:55914 1.2e-05
1.3e-05
hsa:8660
2.0e-05
hsa:4194
hsa:23237 2.5e-05

pLimma pLimma.fdr pBilevel pBilevel.fdr
0.0018
0.0018
0.0018
0.0018
0.0020
0.0042

1.2e-06
1.4e-06
1.4e-06
1.7e-06
2.5e-06
6.2e-06

0.0079
0.0058
0.0110
0.0110
0.0134
0.0148

> # bottom 10 genes
> tail(Z)

hsa:64106
hsa:259291
hsa:6572
hsa:347733
hsa:116443
hsa:3605

pLimma pLimma.fdr pBilevel pBilevel.fdr
1
1
1
1
1
1

0.96
1.00
1.00
0.99
0.98
0.98

0.97
1.00
1.00
0.99
0.98
0.99

1
1
1
1
1
1

For the details of each column, please consult the documentation of getStatistics function.

> ?getStatistics

Per form pathway analysis

> library(ROntoTools)
> # get gene network
> kpg <- loadKEGGPathways()$kpg
> # get gene network name
> kpn <- loadKEGGPathways()$kpn
> # get geneset
> gslist <- lapply(kpg,function(y) nodes(y))
> # get differential expressed genes
> DEGenes.Left <- rownames(geneStat)[geneStat$pLeft < 0.05 & geneStat$ES.pLeft < 0.05]
> DEGenes.Right <- rownames(geneStat)[geneStat$pRight < 0.05 & geneStat$ES.pRight < 0.05]
> DEGenes <- union(DEGenes.Left, DEGenes.Right)
> # perform pathway analysis with ORA
> oraRes <- lapply(gslist, function(gs){
+
+ })
> oraRes <- data.frame(p.value = unlist(oraRes), pathway = names(oraRes))
> rownames(oraRes)
> # print results
> print(head(oraRes))

pORACalc(geneSet = gs, DEGenes = DEGenes, measuredGenes = rownames(geneStat))

<- kpn[rownames(oraRes)]

12

p.value

pathway
Ribosome biogenesis in eukaryotes 8.6e-03 path:hsa03008
1.5e-05 path:hsa03013
RNA transport
2.4e-03 path:hsa03015
mRNA surveillance pathway
3.2e-01 path:hsa03018
RNA degradation
8.5e-01 path:hsa03320
PPAR signaling pathway
4.4e-04 path:hsa03460
Fanconi anemia pathway

> # perfrom pathway analysis with Pathway-Express from ROntoTools
> ES <- geneStat[DEGenes, "ES"]
> names(ES) <- DEGenes
> peRes = pe(x = ES, graphs = kpg, ref = allGenes, nboot = 1000, seed=1, verbose = F)
> peRes.Summary <- Summary(peRes, comb.pv.func = fisherMethod)
> peRes.Summary[, ncol(peRes.Summary) + 1] <- rownames(peRes.Summary)
> rownames(peRes.Summary) <- kpn[rownames(peRes.Summary)]
> colnames(peRes.Summary)[ncol(peRes.Summary)] = "pathway"
> # print results
> print(head(peRes.Summary))

RNA transport
Fanconi anemia pathway
Cell cycle
ErbB signaling pathway
Olfactory transduction
mRNA surveillance pathway

RNA transport
Fanconi anemia pathway
Cell cycle
ErbB signaling pathway
Olfactory transduction
mRNA surveillance pathway

RNA transport
Fanconi anemia pathway
Cell cycle
ErbB signaling pathway
Olfactory transduction
mRNA surveillance pathway

References

2.1
4.2
13.1
21.9
15.2
0.0

1.51
2.86
-0.54
4.49
3.54
NA

totalAcc totalPert totalAccNorm totalPertNorm pPert
0.71 0.495
2.10 0.033
-0.52 0.611
4.57 0.003
3.96 0.002
0.95 0.356

26
14
29
31
27
14
pComb pPert.fdr pAcc.fdr pORA.fdr
0.0022
0.0325
0.0348
0.9996
0.9996
0.0897

pORA
0.071 1.5e-05 9.6e-05
0.007 4.4e-04 1.8e-04
0.603 7.1e-04 3.8e-03
0.003 1.8e-01 4.7e-03
0.002 3.9e-01 6.3e-03
NA 2.4e-03 6.9e-03

0.53
0.16
0.82
0.16
0.16
NA

0.93
0.40
0.94
0.15
0.15
0.82

pAcc

pComb.fdr

pathway
0.013 path:hsa03013
0.013 path:hsa03460
0.169 path:hsa04110
0.169 path:hsa04012
0.169 path:hsa04740
0.169 path:hsa03015

[1] T. Nguyen, R. Tagett, M. Donato, C. Mitrea, and S. Drăghici. A novel bi-level meta-analysis

approach-applied to biological pathway analysis. Bioinformatics, 32(3):409–416, 2016.

[2] R. A. Fisher. Statistical methods for research workers. Oliver & Boyd, Edinburgh, 1925.

13

[3] S. Stouffer, E. Suchman, L. DeVinney, S. Star, and J. Williams, RM. The American Soldier:

Adjustment during army life, volume 1. Princeton University Press, Princeton, 1949.

[4] T. Nguyen, C. Mitrea, R. Tagett, and S. Drăghici. DANUBE: Data-driven meta-ANalysis using
UnBiased Empirical distributions - applied to biological pathway analysis. Proceedings of the
IEEE, PP(99):1–20, March 2016.

[5] T. Nguyen, D. Diaz, R. Tagett, and S. Draghici. Overcoming the matched-sample bottleneck:
an orthogonal approach to integrate omic data. Nature Scientific Reports, 6:29251, 2016.

[6] T. Nguyen, D. Diaz, and S. Draghici. TOMAS: A novel TOpology-aware Meta-Analysis ap-
proach applied to System biology. In Proceedings of the 7th ACM International Conference on
Bioinformatics, Computational Biology, and Health Informatics, pages 13–22. ACM, 2016.

[7] P. Hall. The distribution of means for samples of size n drawn from a population in which
the variate takes values between 0 and 1, all such values being equally probable. Biometrika,
19(3-4):240–244, 1927.

[8] J. O. Irwin. On the frequency distribution of the means of samples from a population having any
law of frequency with finite moments, with special reference to Pearson’s Type II. Biometrika,
19(3-4):225–239, 1927.

[9] O. Kallenberg. Foundations of modern probability. Springer-Verlag, New York, 2002.

[10] L. H. C. Tippett. The methods of statistics. Williams & Norgate, London, 1931.

[11] B. Wilkinson. A statistical consideration in psychological research. Psychological Bulletin,

48(2):156, 1951.

[12] S. Drˇaghici, P. Khatri, R. P. Martins, G. C. Ostermeier, and S. A. Krawetz. Global functional

profiling of gene expression. Genomics, 81(2):98–104, 2003.

[13] S. Tavazoie, J. D. Hughes, M. J. Campbell, R. J. Cho, and G. M. Church. Systematic deter-

mination of genetic network architecture. Nature Genetics, 22:281–285, 1999.

[14] B. Efron and R. Tibshirani. On testing the significance of sets of genes. The Annals of Applied

Statistics, 1(1):107–129, 2007.

[15] A. L. Tarca, S. Drˇaghici, G. Bhatti, and R. Romero. Down-weighting overlapping genes im-

proves gene set analysis. BMC Bioinformatics, 13(1):136, 2012.

[16] S. Drˇaghici, P. Khatri, A. L. Tarca, K. Amin, A. Done, C. Voichiţa, C. Georgescu, and
R. Romero. A systems biology approach for pathway level analysis. Genome Research,
17(10):1537–1545, 2007.

[17] G. K. Smyth. Limma: linear models for microarray data. In R. Gentleman, V. Carey, S. Dudoit,
R. Irizarry, and W. Huber, editors, Bioinformatics and Computational Biology Solutions Using
R and Bioconductor, pages 397–420. Springer, New York, 2005.

[18] R. Majeti, M. W. Becker, Q. Tian, T.-L. M. Lee, X. Yan, R. Liu, J.-H. Chiang, L. Hood, M. F.
Clarke, and I. L. Weissman. Dysregulated gene expression networks in human acute myeloge-
nous leukemia stem cells. Proceedings of the National Academy of Sciences, 106(9):3396–3401,
2009.

14

[19] A. M. Abdul-Nabi, E. R. Yassin, N. Varghese, H. Deshmukh, and N. R. Yaseen.

In vitro
transformation of primary human CD34+ cells by AML fusion oncogenes: early gene expression
profiling reveals possible drug target in AML. PLoS One, 5(8):e12464, 2010.

[20] U. Bacher, S. Schnittger, K. Macijewski, V. Grossmann, A. Kohlmann, T. Alpermann,
A. Kowarsch, N. Nadarajah, W. Kern, C. Haferlach, et al. Multilineage dysplasia does not
influence prognosis in CEBPA-mutated AML, supporting the WHO proposal to classify these
patients as a unique entity. Blood, 119(20):4719–4722, 2012.

[21] C. J. Miller. simpleaffy: Very simple high level analysis of Affymetrix data, 2013. R package

version 2.38.0.

[22] B. M. Bolstad. Low-level analysis of high-density oligonucleotide array data: background, nor-

malization and summarization. PhD thesis, University of California, 2004.

[23] B. M. Bolstad, F. Collin, J. Brettschneider, K. Simpson, L. Cope, R. Irizarry, and T. P. Speed.
Quality assessment of Affymetrix GeneChip data. In Bioinformatics and computational biology
solutions using R and Bioconductor, pages 33–47. Springer, New York, 2005.

[24] J. Brettschneider, F. Collin, B. M. Bolstad, and T. P. Speed. Quality assessment for short

oligonucleotide microarray data. Technometrics, 50(3), 2008.

[25] T. Nguyen, A. Shafi, T.-M. Nguyen, A. G. Schissler, and S. Draghici. Nbia: a network-based
integrative analysis framework – applied to pathway analysis. Scientific reports, 10(1):1–11,
2020.

15

