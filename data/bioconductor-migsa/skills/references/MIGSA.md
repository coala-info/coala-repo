MIGSA: Massive and Integrative Gene Set Analysis

Juan C Rodriguez
CONICET
Universidad Cat´olica de C´ordoba
Universidad Nacional de C´ordoba

Crist´obal Fresno
Instituto Nacional de Medicina Gen´omica

Andrea S Llera
CONICET
Fundaci´on Instituto Leloir

Elmer A Fern´andez
CONICET
Universidad Cat´olica de C´ordoba
Universidad Nacional de C´ordoba

Abstract

The MIGSA package allows to perform a massive and integrative gene set analysis over
several experiments and gene sets simultaneously. It provides a common gene expression
analytic framework that grants a comprehensive and coherent analysis. Only a minimal
user parameter setting is required to perform both singular and gene set enrichment
analyses in an integrative manner by means of enhanced versions of the best available
methods, i.e. dEnricher and mGSZ respectively.

One of the greatest strengths of this big omics data tool is the availability of several
functions to explore, analyze and visualize its results in order to facilitate the data mining
task over huge information sources.

The MIGSA package also allows to easily load the most updated gene sets collections

from several repositories.

Keywords: singular enrichment analysis, over representation analysis, gene set enrichment
analysis, functional class scoring, big omics data, r package, bioconductor.

1. Introduction

The functional analysis methodology allows researchers to gain biological insight from a list of
deregulated gene sets between experimental conditions of interest. As suggested by (Rodriguez
et al. 2016) both singular enrichment analysis (SEA) and gene set enrichment analysis (GSEA)
must be performed over the same dataset in order to gain as much biological insight as possible.
This strategy is known as Integrative Functional Analysis (IFA) and integrates into the same
analysis with enhanced versions of the dEnricher (Fang and Gough 2014) and mGSZ (Mishra
et al. 2014) methods.

At present, there are several freely available datasets which provide data over the same disease,
characteristic of interest (e.g. survival), or subjects studied over several diﬀerent platforms.
The Cancer Genome Atlas (TCGA) among other projects makes possible the study and
comparison in a massive way of these datasets, not only among them but, also against our
own population of interest. This unprecedented opportunity allows researchers to search for

2

MIGSA: Massive and Integrative Gene Set Analysis

common functional patterns between these studies, or, more interestingly, particular patterns
of our experiment in question. However, this type of approach has not been implemented in
any existing tool yet, leaving aside valuable biological information that might assist research
hypotheses.

Here, we present a Massive and Integrative Gene Set Analysis tool called MIGSA. It allows
to evaluate and compare, massively and transparently, a large collection of datasets coming
from diverse sources, maintaining the gene set enrichment ideas of IFA and minimizing pa-
rameter settings. In addition, it includes a gene ranking score alternative for RNAseq data by
integrating the Voom+Limma methodological approach. It provides an enhanced version of
mGSZ (MIGSAmGSZ) faster than the default implementation, in order to speed up even more
its execution, MIGSA can be run using multicore architectures. In this sense it can be applied
over a large collection of datasets on many gene sets in a fast way. Finally, MIGSA provides
several user-friendly methods to easily explore and visualize results at gene set, dataset and
individual gene level to aid researchers in their biological hypothesis understanding.

2. Preliminaries

2.1. Citing MIGSA

MIGSA implements a body of methodological research by the authors and co-workers. Cita-
tions are the main means by which the authors receive professional credit for their work. The
MIGSA package can be cited as:

Rodriguez JC, Gonz´alez GA, Fresno C, Llera AS, Fern´andez EA (2016).
“Improving information retrieval in functional analysis.” Computers in Biology and Medicine,
79, 10–20.

2.2. Installation

MIGSA is a package for the R computing environment and it is assumed that you have already
installed R. See the R project at http://www.r-project.org. To install the latest version of
MIGSA, you will need to be using the latest version of R.
MIGSA is part of the Bioconductor project at http://www.bioconductor.org. (Prior to R
3.4).
To get MIGSA package you can type in an R session:

> ## try http:// if https:// URLs are not supported
> if (!requireNamespace("BiocManager", quietly=TRUE))
+
> BiocManager::install("MIGSA");

install.packages("BiocManager");

2.3. Class deﬁnitions

MIGSA basically consists of six classes and various functions that interact with them. The
following is a simpliﬁed class diagram of MIGSA.

Juan C Rodriguez, Crist´obal Fresno, Andrea S Llera, Elmer A Fern´andez

3

Following we present a detailed diagram of each class, including the functions that interact
in each case. It should be noted that these diagrams represent a general overview of MIGSA,
for a detailed explanation of each class and function please refer to the user manual.

4

MIGSA: Massive and Integrative Gene Set Analysis

Juan C Rodriguez, Crist´obal Fresno, Andrea S Llera, Elmer A Fern´andez

5

6

MIGSA: Massive and Integrative Gene Set Analysis

3. Gene sets

MIGSA allows to perform the functional analysis of any type of gene sets provided by the
user. Such gene sets should be present as GeneSetCollection objects from the GSEABase R
library, in this section we will give a brief introduction on how to construct such an object
from our own gene sets. In addition, the tools provided by MIGSA to automatically load
various collections of known gene sets will be presented.

3.1. Sample GeneSetCollection creation

Here we present a simple way to create a GeneSetCollection object from own gene sets, for
more detailed information please refer to the GSEABase documentation.
For this example we are going to manually create the GeneSetCollection object for the gene
sets hsa00232, hsa00130 and hsa00785 from KEGG.
First, we will have to create each gene set separately, and then the GeneSetCollection object.

> library(GSEABase);

Juan C Rodriguez, Crist´obal Fresno, Andrea S Llera, Elmer A Fern´andez

7

> gs1 <- GeneSet(c("10", "1544", "1548", "1549", "1553", "7498", "9"),
+
+
> gs1;

setName="hsa00232",
setIdentifier="Caffeine metabolism");

setName: hsa00232
geneIds: 10, 1544, ..., 9 (total: 7)
geneIdType: Null
collectionType: Null
details: use

details(object)

’

’

setName="hsa00130",
setIdentifier="Ubiquinone and other terpenoid-quinone biosynthesis");

> gs2 <- GeneSet(c("10229", "27235", "3242", "51004", "51805", "6898", "84274"),
+
+
> gs3 <- GeneSet(c("11019", "387787", "51601"),
+
setName="hsa00785",
setIdentifier="Lipoic acid metabolism");
+
> ## And now construct the GeneSetCollection object.
> gsetsColl <- GeneSetCollection(list(gs1, gs2, gs3));
> gsetsColl;

GeneSetCollection

names: hsa00232, hsa00130, hsa00785 (3 total)
unique identifiers: 10, 1544, ..., 51601 (17 total)
types in collection:

geneIdType: NullIdentifier (1 total)
collectionType: NullCollection (1 total)

3.2. MIGSA gene sets loading

As mentioned above, MIGSA provides functions for automatically loading known collections
of gene sets. These functions are loadGo and downloadEnrichrGeneSets, the ﬁrst constructs
the GeneSetCollection object using the org.Hs.eg.db R package. Meanwhile, downloadEn-
richrGeneSets constructs the object by downloading the gene sets from the Enrichr database
(http://amp.pharm.mssm.edu/Enrichr/#stats). Enrichr gene set names can be listed with
the enrichrGeneSets function.

> ## Not run:
>
> ## Load cellular component gene sets (another possibility would be "MF" or "BP")
> ccGsets <- loadGo("CC"); # It is a GeneSetCollection object
> ## Load KEGG and Reactome gene sets
> keggReact <- downloadEnrichrGeneSets(c("KEGG_2015", "Reactome_2015"));
> ## It is a list object containing two GeneSetCollection objects
>
> ## End(Not run)

8

MIGSA: Massive and Integrative Gene Set Analysis

4. MIGSAmGSZ

4.1. mGSZ speedup

As stated below, MIGSA provides the MIGSAmGSZ function, which implements mGSZ but
running much faster. In order to test MIGSAmGSZ’s correctness and speed up over mGSZ, it
was evaluated using the TCGA’s microarray breast cancer dataset. Basal vs. Luminal A
contrast was tested (16,207 genes x 237 subjects) over the Gene Ontology and KEGG gene
sets (20,425 gene sets).
This analysis was carried out using an Intel(R) Xeon(R) E5-2620 v3 @ 2.40GHz (24 cores),
128 GB RAM. Diﬀerent number of cores were used to analyze the speed up.
Let’s test it!
Note that we are using MulticoreParam as I am testing under Linux.

> library(BiocParallel);
> library(mGSZ);
> library(MIGSA);
> library(MIGSAdata);
> data(tcgaMAdata);
> subtypes <- tcgaMAdata$subtypes;
> geneExpr <- tcgaMAdata$geneExpr;
> ## MA data: filter genes with less than 30% of genes read per condition
> dim(geneExpr);

[1] 16207

237

rowSums(is.na(geneExpr[, subtypes == "Basal" ])) <

.3*sum(subtypes == "Basal") &

rowSums(is.na(geneExpr[, subtypes == "LumA" ])) <

.3*sum(subtypes == "LumA")

> geneExpr <- geneExpr[
+
+
+
+
+
, ];
> dim(geneExpr);

[1] 16207

237

> ## Not run:
>
> ## Download GO and KEGG gene sets using MIGSA
> gSets <- list(
+
+
+
+
> gSetsList <- do.call(c, lapply(gSets, MIGSA:::asList));
> rm(gSets);

KEGG=downloadEnrichrGeneSets("KEGG_2015")[[1]],
BP=loadGo("BP"),
CC=loadGo("CC"),
MF=loadGo("MF"));

Juan C Rodriguez, Crist´obal Fresno, Andrea S Llera, Elmer A Fern´andez

9

return(res);

progressbar=TRUE);

bp.param=bp_param);

newtimeSpent <- Sys.time()-newtimeSpent;

res <- list(timeSpent=newtimeSpent, res=MIGSAmGSZres);

set.seed(8818);
newtimeSpent <- Sys.time();
MIGSAmGSZres <- MIGSAmGSZ(geneExpr, gSetsList, subtypes,

> nCores <- c(1,2,4,8,10,12,14);
> allRes <- lapply(nCores, function(actCores) {
# setting in how many cores to run
+
+
bp_param <- MulticoreParam(workers=actCores, threshold="DEBUG",
+
+
+
+
+
+
+
+
+
+
+
+ })
> set.seed(8818);
> timeSpent <- Sys.time();
> mGSZres <- mGSZ(geneExpr, gSetsList, subtypes);
> timeSpent <- Sys.time()-timeSpent;
> mGSZres <- mGSZres$mGSZ;
> ## this tests that the returned values are equal, must give all TRUE
> lapply(allRes, function(actRes) {
+
+
+
+
+
+
+
+
+ })
> ## End(Not run)

actRes <- actRes$res;
actRes <- actRes[,1:4];
mergedRes <- merge(mGSZres, actRes, by="gene.sets",

all.equal(mergedRes[,x], mergedRes[,x+3])

all(unlist(lapply(2:4, function(x) {

suffixes=c("mGSZ", "MIGSAmGSZ"));

})));

> ## As last chunk of code was not executed, we load that data:
> library(MIGSAdata);
> data(mGSZspeedup);
> nCores <- mGSZspeedup$nCores;
> allRes <- mGSZspeedup$allRes;
> timeSpent <- mGSZspeedup$timeSpent;
> ## End(Loading data)
>
> newtimeSpent <- lapply(allRes, function(actRes) {
+
+ })
> names(newtimeSpent) <- nCores;
> speeduptable <- c(timeSpent, unlist(newtimeSpent));

actRes$timeSpent;

10

MIGSA: Massive and Integrative Gene Set Analysis

’

s put all times in the same unit in order to measure speedup

units(acttime) <- "secs";
return(acttime);

> names(speeduptable) <- c(1, nCores);
> ## Let
> newtimeSpent <- lapply(newtimeSpent, function(acttime) {
+
+
+ });
> units(timeSpent) <- "secs";
> speedup <- do.call(c, lapply(newtimeSpent, function(acttime)
+
> speeduptable <- rbind(speeduptable, c(1, speedup));
> ## calculate efficiency
> speeduptable <- rbind(speeduptable,
speeduptable[2,] / as.numeric(colnames(speeduptable)));
+
> rownames(speeduptable) <- c("Runtime", "Speedup", "Efficiency");
> round(speeduptable, 2);

as.numeric(timeSpent)/as.numeric(acttime)));

1

1

14
2.46 1.55 46.50 24.98 15.63 13.67 14.79 28.43
Runtime
Speedup
1.00 1.58 3.18 5.91 9.45 10.81 9.98 5.19
Efficiency 1.00 1.58 1.59 1.48 1.18 1.08 0.83 0.37

12

10

2

4

8

As it can be seen in Table 1, no matter the number of cores in which MIGSAmGSZ was tested,
it outperformed mGSZ. Running in one core, it has shown a speedup of 1.6X, reaching for
a top of 10.8X speedup with ten cores, giving the same results in 14 minutes in contrast to
mGSZ ’s 2.46 hours execution.

#cores
Runtime
Speedup
Eﬃciency

mGSZ
1
2.46h
1
1

Table 1: MIGSAmGSZ speedup

MIGSAmGSZ

1

2

4

8

10

12

14

1.55h 46.5m 24.98m 15.63m 13.67m 14.79m 28.43m
1.58
1.58

10.81
1.08

3.18
1.59

5.91
1.48

9.45
1.18

5.19
0.37

9.98
0.83

4.2. MIGSAmGSZ simple example

Following, we show how to simply execute one MIGSAmGSZ analysis.
In this example we will generate an expression matrix with 200 genes (ten diﬀerentially
expressed) and eight subjects (four of condition “C1” and four of “C2”), and 50 gene sets of
ten genes each one.

s create our gene expression matrix with 200 genes and 8 subjects

> library(MIGSA);
’
> ## Let
> nSamples <- 8; # 8 subjects
> nGenes <- 200; # 200 genes
> geneNames <- paste("g", 1:nGenes, sep = ""); # with names g1 ... g200
> ## Create random gene expression data matrix.

Juan C Rodriguez, Crist´obal Fresno, Andrea S Llera, Elmer A Fern´andez

11

s generate the offsets to sum to the differentially expressed genes.

> set.seed(8818);
> exprMatrix <- matrix(rnorm(nGenes*nSamples),ncol=nSamples);
> ## It must have rownames, as they will be treated as the gene names!
> rownames(exprMatrix) <- geneNames;
> ## There will be 10 differentially expressed genes.
> nDeGenes <- 10;
’
> ## Let
> deOffsets <- matrix(2*abs(rnorm(nDeGenes*nSamples/2)), ncol=nSamples/2);
> ## Randomly select which are the DE genes.
> deIndexes <- sample(1:nGenes, nDeGenes, replace=FALSE);
> exprMatrix[deIndexes, 1:(nSamples/2)] <-
+
> ## 4 subjects with condition C1 and 4 with C2.
> conditions <- rep(c("C1", "C2"),c(nSamples/2,nSamples/2));
> nGSets <- 50; # 50 gene sets
> ## Let
> gSets <- lapply(1:nGSets, function(i) sample(geneNames, size=10));
> names(gSets) <- paste("set", as.character(1:nGSets), sep="");
> ## with names set1 ... set50
>
> ## And simply execute MIGSAmGSZ
> MIGSAmGSZres <- MIGSAmGSZ(exprMatrix, gSets, conditions);

exprMatrix[deIndexes, 1:(nSamples/2)] + deOffsets;

s create randomly 50 gene sets, of 10 genes each

’

INFO [2018-10-30 21:47:58] Number of unique permutations: 63
INFO [2018-10-30 21:47:58] Getting ranking at cores: 4

> ## It is just a simple data.frame
> head(MIGSAmGSZres);

gene.sets

pvalue mGszScore
set14 0.01436984 2.842219
set26 0.03195210 -2.127805
set1 0.06608332 -1.825934
set42 0.07087139 1.439009
set47 0.07924634 1.344799
set40 0.09196656 -1.866621

set14
set26
set1
set42
set47
set40

impGenes
set14
g65, g195, g20, g176, g26, g47, g180
set26 g40, g130, g1, g119, g107, g163, g102, g131, g80, g185
set1 g98, g93, g157, g190, g186, g135, g160, g73, g114, g177
g102, g69, g50, g192, g43, g182, g10, g47, g26, g189
set42
set47
g191, g156, g124, g90, g99, g31, g23, g152, g29
g189, g192, g50, g54, g64, g103, g135, g44, g58, g8
set40

5. MIGSA simple example

Following, we show how to simply execute one MIGSA analysis.

12

MIGSA: Massive and Integrative Gene Set Analysis

In this example we will generate two expression matrices with 300 genes (30 diﬀerentially
expressed) and 16 subjects (8 of condition “C1” and 8 of “C2”), and two sets of 30 gene sets
of ten genes each one.

’

exprData1[deIndexes1, 1:(nSamples/2)] + deOffsets;

s simulate two expression matrices of 300 genes and 16 subjects.

s generate the offsets to sum to the differentially expressed genes.

> library(MIGSA);
’
> ## Let
> nGenes <- 300; # 300 genes
> nSamples <- 16; # 16 subjects
> geneNames <- paste("g", 1:nGenes, sep = ""); # with names g1 ... g300
> ## Create the random gene expression data matrices.
> set.seed(8818);
> exprData1 <- matrix(rnorm(nGenes*nSamples),ncol=nSamples);
> rownames(exprData1) <- geneNames;
> exprData2 <- matrix(rnorm(nGenes*nSamples),ncol=nSamples);
> rownames(exprData2) <- geneNames;
> ## There will be 30 differentially expressed genes.
> nDeGenes <- nGenes/10;
> ## Let
> deOffsets <- matrix(2*abs(rnorm(nDeGenes*nSamples/2)), ncol=nSamples/2);
> ## Randomly select which are the DE genes.
> deIndexes1 <- sample(1:nGenes, nDeGenes, replace=FALSE);
> exprData1[deIndexes1, 1:(nSamples/2)] <-
+
> deIndexes2 <- sample(1:nGenes, nDeGenes, replace=FALSE);
> exprData2[deIndexes2, 1:(nSamples/2)] <-
+
> exprData1 <- new("MAList",list(M=exprData1));
> exprData2 <- new("MAList",list(M=exprData2));
> ## 8 subjects with condition C1 and 8 with C2.
> conditions <- rep(c("C1", "C2"),c(nSamples/2,nSamples/2));
> fitOpts <- FitOptions(conditions);
> nGSets <- 30; # 30 gene sets
> ## Let
>
> gSets1 <- lapply(1:nGSets, function(i) sample(geneNames, size=10));
> names(gSets1) <- paste("set", as.character(1:nGSets), sep="");
> myGSs1 <- as.Genesets(gSets1);
> gSets2 <- lapply(1:nGSets, function(i) sample(geneNames, size=10));
> names(gSets2) <- paste("set", as.character((nGSets+1):(2*nGSets)), sep="");
> myGSs2 <- as.Genesets(gSets2);
> igsaInput1 <- IGSAinput(name="igsaInput1", expr_data=exprData1,
+
> igsaInput2 <- IGSAinput(name="igsaInput2", expr_data=exprData2,
+
> experiments <- list(igsaInput1, igsaInput2);
> ## As we did not set gene sets for each IGSAinput, then we will have to
> ## provide them in MIGSA function

exprData2[deIndexes2, 1:(nSamples/2)] + deOffsets;

s create randomly 30 gene sets, of 10 genes each

fit_options=fitOpts);

fit_options=fitOpts);

’

Juan C Rodriguez, Crist´obal Fresno, Andrea S Llera, Elmer A Fern´andez

13

fit_options=fitOpts,
gene_sets_list=list(myGeneSets1=myGSs1, myGeneSets2=myGSs2));

>
> ## another way of generating the same MIGSA input would be setting the
> ## gene sets individually to each IGSAinput:
> igsaInput1 <- IGSAinput(name="igsaInput1", expr_data=exprData1,
+
+
> igsaInput2 <- IGSAinput(name="igsaInput2", expr_data=exprData2,
+
+
> experiments <- list(igsaInput1, igsaInput2);
> ## And then simply run MIGSA
> migsaRes <- MIGSA(experiments);

fit_options=fitOpts,
gene_sets_list=list(myGeneSets1=myGSs1, myGeneSets2=myGSs2));

INFO [2018-10-30 21:47:59] *************************************
INFO [2018-10-30 21:47:59] Starting MIGSA analysis.
INFO [2018-10-30 21:47:59] *************************************
INFO [2018-10-30 21:47:59] igsaInput1 : Starting IGSA analysis.
INFO [2018-10-30 21:47:59] 60 Gene Sets.
INFO [2018-10-30 21:47:59] igsaInput1 : dEnricher starting.
INFO [2018-10-30 21:47:59] DE genes 7 of a total of 300 ( 2.33 %)
INFO [2018-10-30 21:47:59] Using BRIII: 300 genes.
INFO [2018-10-30 21:47:59] Running SEA at cores: 4
INFO [2018-10-30 21:47:59] igsaInput1 : dEnricher finnished.
INFO [2018-10-30 21:47:59] igsaInput1 : mGSZ starting.
INFO [2018-10-30 21:47:59] Number of unique permutations: 198
INFO [2018-10-30 21:47:59] Getting ranking at cores: 4
INFO [2018-10-30 21:48:00] igsaInput1 : mGSZ finnished.
INFO [2018-10-30 21:48:00] igsaInput1 : IGSA analysis ended.
INFO [2018-10-30 21:48:00] *************************************
INFO [2018-10-30 21:48:00] igsaInput2 : Starting IGSA analysis.
INFO [2018-10-30 21:48:01] 60 Gene Sets.
INFO [2018-10-30 21:48:01] igsaInput2 : dEnricher starting.
INFO [2018-10-30 21:48:01] DE genes 3 of a total of 300 ( 1 %)
INFO [2018-10-30 21:48:01] Using BRIII: 300 genes.
INFO [2018-10-30 21:48:01] Running SEA at cores: 4
INFO [2018-10-30 21:48:01] igsaInput2 : dEnricher finnished.
INFO [2018-10-30 21:48:01] igsaInput2 : mGSZ starting.
INFO [2018-10-30 21:48:01] Number of unique permutations: 199
INFO [2018-10-30 21:48:01] Getting ranking at cores: 4
INFO [2018-10-30 21:48:02] igsaInput2 : mGSZ finnished.
INFO [2018-10-30 21:48:02] igsaInput2 : IGSA analysis ended.

> ## migsaRes contains the p-values obtained in each experiment for each gene set
> head(migsaRes);

id Name

1 set1

GS_Name igsaInput1 igsaInput2
myGeneSets1 0.69760989 0.67067126

14

MIGSA: Massive and Integrative Gene Set Analysis

2 set10
3 set11
4 set12
5 set13
6 set14

myGeneSets1 0.33645471 0.05331946
myGeneSets1 0.72236131 0.23921454
myGeneSets1 0.65533918 0.55771735
myGeneSets1 0.45011198 0.21997850
myGeneSets1 0.03478516 0.27108191

fit_options=fitOpts, gene_sets_list=list(myGeneSets1=myGSs1));

fit_options=fitOpts, gene_sets_list=list(myGeneSets2=myGSs2));

> ## Other possible analyses:
> ## If we want some gene sets to be evaluated in just one IGSAinput we
> ## can do this:
>
> ## If we want to test myGSs1 in exprData1 and myGSs2 in exprData2:
> igsaInput1 <- IGSAinput(name="igsaInput1", expr_data=exprData1,
+
> igsaInput2 <- IGSAinput(name="igsaInput2", expr_data=exprData2,
+
> experiments <- list(igsaInput1, igsaInput2);
> ## If we want to test myGSs1 in exprData1 and both in exprData2:
> igsaInput1 <- IGSAinput(name="igsaInput1", expr_data=exprData1,
+
> igsaInput2 <- IGSAinput(name="igsaInput2", expr_data=exprData2,
+
+
> experiments <- list(igsaInput1, igsaInput2);
>
> ## And this way, all possible combinations.

fit_options=fitOpts,
gene_sets_list=list(myGeneSets1=myGSs1, myGeneSets2=myGSs2));

fit_options=fitOpts, gene_sets_list=list(myGeneSets1=myGSs1));

6. MIGSA’s utility

In this section we are going to demonstrate MIGSA’s utility by analyzing several well known
breast cancer datasets. For each dataset, subjects were classiﬁed into breast cancer intrinsic
subtypes (Basal-Like, Her2-Enriched, Luminal B, Luminal A and Normal-Like) using the
PAM50 algorithm (Parker et al. 2009) by means of the pbcmc R library (Fresno et al. 2016)
and processed as suggested by Sorlie et al. (Sørlie et al. 2010). Only those subjects classiﬁed
as Basal-Like or Luminal A were included.
Enrichment was tested over 20,245 Gene Ontology gene sets (14,291 biological processes, 1,692
cellular components and 4,263 molecular functions), and 179 from KEGG.

6.1. Used datasets

A total of eight datasets were tested, six of them were loaded by means of the pbcmc R
library, i.e., Mainz, Nki, Transbig, Unt, Upp and Vdx); and two were downloaded from the
TCGA repository, i.e., microarray and RNAseq data matrices. For each dataset, genes reliably
detected in less than 30% of the samples per condition were removed from the analysis. In
addition, in RNAseq data, genes with a mean less than 15 counts per condition were also
removed. Detailed datasets information can be seen in Table 2.

Juan C Rodriguez, Crist´obal Fresno, Andrea S Llera, Elmer A Fern´andez

15

Dataset

Platform

Table 2: Datasets details
Subjects
Basal Luminal A

Microarray
Microarray
Microarray
RNAseq

Mainz
Nki
TCGA
TCGA
Transbig Microarray
Microarray
Unt
Microarray
Upp
Microarray
Vdx
-
Total

18
66
95
95
37
22
19
80
432

117
100
142
142
89
42
150
134
916

Genes

13,091
12,975
16,207
16,741
13,091
18,528
18,528
13,091
-

6.2. MIGSA on TCGA data

Let’s run MIGSA over the TCGA RNAseq and microarray datasets. We are going to load
both datasets using the MIGSAdata package, please refer to the gettingTcgaData vignette
for details about these matrices.
NOTE: This chunk of code took 29.83m to execute on 10 cores.

> library(edgeR);
> library(limma);
> library(MIGSA);
> library(MIGSAdata);
> data(tcgaMAdata);
> data(tcgaRNAseqData);
> geneExpr <- tcgaMAdata$geneExpr;
> rnaSeq <- tcgaRNAseqData$rnaSeq;
> subtypes <- tcgaMAdata$subtypes; # or tcgaRNAseqData$subtypes; are the same
> fitOpts <- FitOptions(subtypes);
> ## MA data: filter genes with less than 30% of genes read per condition
> dim(geneExpr);

[1] 16207

237

rowSums(is.na(geneExpr[, subtypes == "Basal" ])) <

.3*sum(subtypes == "Basal") &

rowSums(is.na(geneExpr[, subtypes == "LumA" ])) <

.3*sum(subtypes == "LumA")

> geneExpr <- geneExpr[
+
+
+
+
+
, ];
> dim(geneExpr);

[1] 16207

237

> ## create our IGSAinput object
> geneExpr <- new("MAList", list(M=geneExpr));

16

MIGSA: Massive and Integrative Gene Set Analysis

> geneExprIgsaInput <- IGSAinput(
+
+
+
+
+
> summary(geneExprIgsaInput);

name="tcgaMA",
expr_data=geneExpr,
fit_options=fitOpts,
# with this treat we will get around 5% differentially expressed genes
sea_params=SEAparams(treat_lfc=1.05));

INFO [2018-10-30 21:48:07] DE genes 802 of a total of 16207 ( 4.95 %)
#C2
"142"
de_cutoff adjust_method
"fdr"

#C1
"95"

#samples

contrast
"237" "BasalVSLumA"
treat_lfc
"1.05"
perm_number
"200"

#genes
"16207"
br
"briii"

exp_name
"tcgaMA"
#gene_sets
"0"
#de_genes
"802"

"0.01"
%de_genes
"4.95"

> ## RNAseq data: filter genes with less than 30% of genes read per
> ## condition and (below)
> dim(rnaSeq);

[1] 19948

237

rowSums(is.na(rnaSeq[, subtypes == "Basal" ])) <

.3*sum(subtypes == "Basal") &

rowSums(is.na(rnaSeq[, subtypes == "LumA" ])) <

.3*sum(subtypes == "LumA")

> rnaSeq <- rnaSeq[
+
+
+
+
+
> dim(rnaSeq);

, ];

[1] 19948

237

> ## a mean less than 15 counts per condition.
> rnaSeq <- rnaSeq[
+
+
+
> dim(rnaSeq);

rowMeans(rnaSeq[, subtypes == "Basal" ], na.rm=TRUE) >= 15 &
rowMeans(rnaSeq[, subtypes == "LumA" ], na.rm=TRUE) >= 15
, ];

[1] 16741

237

> ## create our IGSAinput object
> rnaSeq <- DGEList(counts=rnaSeq);
> rnaSeqIgsaInput <- IGSAinput(
+
+

name="tcgaRNA",
expr_data=rnaSeq,

Juan C Rodriguez, Crist´obal Fresno, Andrea S Llera, Elmer A Fern´andez

17

fit_options=fitOpts,
# with this treat we will get around 5% differentially expressed genes
sea_params=SEAparams(treat_lfc=1.45));

+
+
+
> summary(rnaSeqIgsaInput);

INFO [2018-10-30 21:48:12] DE genes 826 of a total of 16741 ( 4.93 %)
#C2
"142"
de_cutoff adjust_method
"fdr"

#C1
"95"

#samples

contrast
"237" "BasalVSLumA"
treat_lfc
"1.45"
perm_number
"200"

#genes
"16741"
br
"briii"

exp_name
"tcgaRNA"
#gene_sets
"0"
#de_genes
"826"

"0.01"
%de_genes
"4.93"

> experiments <- list(geneExprIgsaInput, rnaSeqIgsaInput);

KEGG=downloadEnrichrGeneSets("KEGG_2015")[[1]],
BP=loadGo("BP"),
CC=loadGo("CC"),
MF=loadGo("MF"));

> ## Not run:
>
> gSets <- list(
+
+
+
+
> set.seed(8818);
> tcgaMigsaRes <- MIGSA(experiments, geneSets=gSets);
>
> ## Time difference of 29.83318 mins in 10 cores
> ## End(Not run)

6.3. MIGSA on pbcmc datasets

Let’s run MIGSA over the pbcmc microarray datasets. We are going to load six datasets
using the MIGSAdata package, please refer to the gettingPbcmcData vignette for details on
how we got this matrices.
NOTE: This chunk of code took 1.27 hours to execute on 10 cores.

> library(limma);
> library(MIGSA);
> library(MIGSAdata);
> data(pbcmcData);
> ## with these treat log fold change values we will get around 5% of
> ## differentially expressed genes for each experiment
> treatLfcs <- c(0.7, 0.2, 0.6, 0.25, 0.4, 0.75);
> names(treatLfcs) <- c("mainz", "nki", "transbig", "unt", "upp", "vdx");
> experiments <- lapply(names(treatLfcs), function(actName) {
+
+

actData <- pbcmcData[[actName]];
actExprs <- actData$geneExpr;

MIGSA: Massive and Integrative Gene Set Analysis

actSubtypes <- actData$subtypes;

# filtrate genes with less than 30% per condition
actExprs <- actExprs[

rowSums(is.na(actExprs[, actSubtypes == "Basal" ])) <

.3*sum(actSubtypes == "Basal") &

rowSums(is.na(actExprs[, actSubtypes == "LumA" ])) <

.3*sum(actSubtypes == "LumA")

, ]

# create our IGSAinput object
actExprData <- new("MAList", list(M=actExprs));
actFitOpts <- FitOptions(actSubtypes);
actIgsaInput <- IGSAinput(

name=actName,
expr_data=actExprData,
fit_options=actFitOpts,
sea_params=SEAparams(treat_lfc=treatLfcs[[actName]]));

return(actIgsaInput);

18

+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+ })
>

KEGG=downloadEnrichrGeneSets("KEGG_2015")[[1]],
BP=loadGo("BP"),
CC=loadGo("CC"),
MF=loadGo("MF"));

> ## Not run:
>
> gSets <- list(
+
+
+
+
> set.seed(8818);
> pbcmcMigsaRes <- MIGSA(experiments, geneSets=gSets);
>
> ## Time difference of 1.26684 hours in 10 cores
> ## End(Not run)

6.4. MIGSA exploring breast cancer enrichment results

Let’s start with the exploratory task. First, merge both MIGSAres objects into one with all
the datasets results.
NOTE: In order to follow this code, sections 6.2 and 6.3 must have been executed. If not,
jump to the next “End(Not run)” tag.

> ## Not run:
>
> dim(pbcmcMigsaRes);
> # [1] 20425

9

Juan C Rodriguez, Crist´obal Fresno, Andrea S Llera, Elmer A Fern´andez

19

’

5

> dim(tcgaMigsaRes);
> # [1] 20425
>
> ## Let
> bcMigsaRes <- merge(pbcmcMigsaRes, tcgaMigsaRes);
> dim(bcMigsaRes);
> # [1] 20425
> ## End(Not run)

11

s merge both results in one big MIGSAres object

> ## As last chunk of code was not executed, we load that data:
> library(MIGSA);
> library(MIGSAdata);
> data(bcMigsaResAsList);
> bcMigsaRes <- MIGSA:::MIGSAres.data.table(bcMigsaResAsList$dframe,
+ bcMigsaResAsList$genesRank);
> rm(bcMigsaResAsList);
> ## End(Loading data)
>
> ## Let
> summary(bcMigsaRes);

’

s see a summary of enriched gene sets at different cutoff values

enr_at_0_01
655 768
enr_at_0_05 1866 2217
2948 3492
enr_at_0_1

mainz nki tcgaMA tcgaRNA transbig unt upp vdx
821 958 1117 829
1873 1992 2325 2148
3137 3221 3612 3322

754
2098
3185

889
2224
3462

> ## We will set a cutoff of 0.01 (recommended)
> ## A gene set will be considered enriched if its p-value is < 0.01 on
> ## SEA or GSEA.
> bcMigsaRes <- setEnrCutoff(bcMigsaRes, 0.01);
>
> ## The bcMigsaRes data object that is included in MIGSA package is the
> ## following:
> # bcMigsaRes <- bcMigsaRes[1:200,];

Let’s start exploring this MIGSA results object.

> colnames(bcMigsaRes);

[1] "id"
[7] "tcgaRNA" "transbig" "unt"

"Name"

"GS_Name" "mainz"

"upp"

"nki"
"vdx"

"tcgaMA"

> dim(bcMigsaRes);

[1] 20425

11

> summary(bcMigsaRes);

20

MIGSA: Massive and Integrative Gene Set Analysis

INFO [2018-10-30 21:48:22] Gene sets enriched in 0 experiments: 18191
INFO [2018-10-30 21:48:22] Gene sets enriched in 1 experiments: 921
INFO [2018-10-30 21:48:22] Gene sets enriched in 2 experiments: 377
INFO [2018-10-30 21:48:22] Gene sets enriched in 3 experiments: 231
INFO [2018-10-30 21:48:22] Gene sets enriched in 4 experiments: 150
INFO [2018-10-30 21:48:22] Gene sets enriched in 5 experiments: 104
INFO [2018-10-30 21:48:22] Gene sets enriched in 6 experiments: 96
INFO [2018-10-30 21:48:22] Gene sets enriched in 7 experiments: 113
INFO [2018-10-30 21:48:22] Gene sets enriched in 8 experiments: 242
$consensusGeneSets

0
18191

1
921

2
377

3
231

4
150

5
104

6
96

7
113

8
242

$enrichmentIntersections

mainz nki tcgaMA tcgaRNA transbig unt upp vdx
421 485 477
655
mainz
457 508 424
393
nki
503 532 451
tcgaMA
397
457 480 434
tcgaRNA 372
550 605 573
transbig 489
958 679 510
421
unt
679 1117 596
485
upp
510 596 829
477
vdx

393 397
768 443
443 754
419 525
464 495
457 503
508 532
424 451

372
419
525
889
460
457
480
434

489
464
495
460
821
550
605
573

> ## We can see that 18,191 gene sets were not enriched, while 242 were
> ## enriched in every dataset.
> ## Moreover, there is a high consensus between datasets, with a maximum of 679
> ## enriched gene sets in common between upp and unt.
> ##
> ## Let
> bcMigsaRes <- bcMigsaRes[ rowSums(bcMigsaRes[,-(1:3)], na.rm=TRUE) > 0, ];
> dim(bcMigsaRes);

s keep only gene sets enriched in at least one data set

’

[1] 2234

11

’

s see enrichment heat map

> ## Let
> ## i.e. a heat map of binary data (enriched/not enriched)
> aux <- migsaHeatmap(bcMigsaRes);

Juan C Rodriguez, Crist´obal Fresno, Andrea S Llera, Elmer A Fern´andez

21

> ## In this heat map we can see a high number of gene sets that are being
> ## enriched in consensus by most of the datasets. Let
s explore them.
> ## We can obtain them (enriched in at least 80% of datasets) by doing
> consensusGsets <- bcMigsaRes[ rowSums(bcMigsaRes[, -(1:3)], na.rm=TRUE)
+
> dim(consensusGsets);

> 6.4,];

’

[1] 355 11

’

> ## And let
> table(consensusGsets$GS_Name);

s see from which sets are them

BP
287

CC KEGG_2015
1
49

MF
18

’

> ## Moreover, let
s see which are the genes that are mostly contributing
> ## to gene set enrichment (genes contributing in at least 70 gene sets)
> ## i.e. a heat map showing the number of datasets in which each gene (columns)
> ## contributed to enrich each gene set (rows).
> aux <- genesHeatmap(bcMigsaRes, enrFilter=6.4, gsFilter=70,
+

dendrogram="col");

tcgaMAtcgaRNAnkiuntuppmainztransbigvdxValueFALSETRUENA22

MIGSA: Massive and Integrative Gene Set Analysis

’

s explore them:

> ## Well, we could continue exploring them, however, at the first heat map we
> ## can see that TCGA datasets are defining a separate cluster, this is caused
> ## by a big group of gene sets that seem to be enriched mainly by TCGA.
> ## Let
> ## (gene sets enriched by both TCGA datasets and in less than 20% of the other)
> tcgaExclusive <- bcMigsaRes[
+
+
+
+ ,];
> dim(tcgaExclusive);

rowSums(bcMigsaRes[, c("tcgaMA", "tcgaRNA")], na.rm=TRUE) == 2 &
rowSums(bcMigsaRes[, c("mainz","nki","transbig","unt","upp","vdx")],

na.rm=TRUE) < 1.2

[1] 83 11

> table(tcgaExclusive$GS_Name);

BP
62

CC KEGG_2015
1

3

MF
17

’

> ## Let
> tcgaExclusive[ tcgaExclusive$GS_Name == "KEGG_2015", "id" ];

s see which is this KEGG enriched gene set

876665297001106572729911063408569970189153479834751106299283322912792126790Count02468Juan C Rodriguez, Crist´obal Fresno, Andrea S Llera, Elmer A Fern´andez

23

id
20362 nitrogen metabolism

’

> ## Let
> table(getHeights(
+

s see in which depths of the GO tree are these gene sets

tcgaExclusive[ tcgaExclusive$GS_Name != "KEGG_2015", "id", drop=TRUE]));

2 3 4 5 6 7 10
7 12 24 20 14 4 1

> ## We can see that the most of the gene sets are between depths three and five

> ## And plot the GO tree of the other gene sets (except of CC, as it
> ## has only three gene sets, and it will look bad)
> aux <- migsaGoTree(tcgaExclusive, ont="MF");

> aux <- migsaGoTree(tcgaExclusive, ont="BP");

MFllllllllllllllllllllllllllllllllllllDNAsecondarystructurebindingRNApolymeraseIItranscriptionfactorbindingarylamineN−acetyltransferaseactivitynucleotidediphosphataseactivityorganicacidtransmembranetransporteractivitycalciumionbindingcalcium−dependentphospholipidbindingorganicaniontransmembranetransporteractivityfattyacidelongaseactivityorganiccationtransmembranetransporteractivityaromaticaminoacidtransmembranetransportertoxintransmembranetransporteractivitynitric−oxidesynthaseregulatoractivityDNAinsertion ordeletionbindingNADHpyrophosphataseactivitycarboxylicacidtransmembranetransporteractivitysphingosineN−acyltransferaseactivityMFEnriched24

MIGSA: Massive and Integrative Gene Set Analysis

’

s explore which are the genes that repeat the most in these

> ## Let
> ## gene sets (that are present in at least 15% of the gene sets)
> ## i.e. a bar plot of the number of gene sets in which each gene contributed to
> ## enrich.
> mostEnrichedGenes <- genesBarplot(tcgaExclusive, gsFilter=12.45);

BPllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllcell morphogenesisovarianfollicledevelopmentmicrotubulebundleformationlymphoidprogenitorcell differentiationregulation ofpeptidesecretionregulation ofciliummovementglutamatebiosyntheticprocesscellularmodifiedaminoacidmetabolicprocessaniontransportaminoacidtransportregulation ofsisterchromatidcohesionpatternspecificationprocessdigestionbodyfluidsecretionanimal organmorphogenesisorganiccationtransportorganicaniontransportaromaticaminoacidtransportorganicacidtransportneuronremodelingnervedevelopmentneuraltubedevelopmentcellularprocessinvolvedinreproductioninmulticellular organismovulationcycleprocessreplicationforkprocessingnucleobase−containingsmallmoleculecatabolicprocessaxonemeassemblytubemorphogenesisouterdyneinarmassemblyinnerdyneinarmassemblyhormonemetabolicprocesscatagenovulationcycleDNA−dependentDNAreplicationmaintenance offidelityregulation ofhormonesecretioncarboxylicacidtransportdigestivetractmorphogenesisregulation ofcollateralsproutingembryonicneurocraniummorphogenesistissuemorphogenesiscalciumion−regulatedexocytosis ofneurotransmitterregulation ofinsulinsecretionestablishment ofmitochondrionlocalizationregulation oftiming ofcatagenvaginadevelopmentepithelialciliummovementinvolvedindetermination ofleft/rightasymmetrybranchinginvolvedinprostateglandmorphogenesismammaryglandmorphogenesisbranchinginvolvedinmammaryglandductmorphogenesisepithelialtubemorphogenesisendocrinehormonesecretionaxonemaldyneincomplexassemblynitrogencompoundtransportdetermination ofdigestivetractleft/rightasymmetryproteinK6−linkedubiquitinationcraniofacialsuturemorphogenesispilomotorreflexdenovocentrioleassemblyinvolvedinmulti−ciliatedepithelialcell differentiationpositiveregulation ofcell maturationpositiveregulation ofthyroidhormonegenerationregulation ofcytoplasmictranslationnegativeregulation ofcytoplasmictranslationBPEnrichedJuan C Rodriguez, Crist´obal Fresno, Andrea S Llera, Elmer A Fern´andez

25

> mostEnrichedGenes$data;

652
652
123872 123872
6422
6422
388389 388389
55036
55036
2099
2099

id number
15
14
13
13
13
13

> ## Gene 652 is contributing to enrichment in 15 gene sets. And in total
> ## there are 6 genes that are being really active in TCGA enriched
> ## gene sets
> tcgaImportantGenes <- as.character(mostEnrichedGenes$data$id);

’

s do the same analysis for the rest of the datasets, so we can filtrate

> ## Let
> ## which genes are acting exclusively in TCGA datasets
> consMostEnrichedGenes <- genesBarplot(consensusGsets, gsFilter=53.25);

0510156521238726422388389550362099idnumber26

MIGSA: Massive and Integrative Gene Set Analysis

> consImportantGenes <- as.character(consMostEnrichedGenes$data$id);
> ## Let
> intersect(tcgaImportantGenes, consImportantGenes);

s see which genes they share

’

[1] "652"

> ## And get the really tcga exclusive genes (5 genes)
> tcgaExclGenes <- setdiff(tcgaImportantGenes, consImportantGenes);

Another way of exploring the data is for example, suppose we have a list of genes of interest,
we can ﬁlter our results having the gene sets that were enriched by our interest genes as
follows:

s sample 4 genes from consImportantGenes (as if they are our interest

’

> ## Let
> ## genes)
> set.seed(8818);
> myInterestGenes <- sample(consImportantGenes, 4);
> ## So we can get the filtered MIGSAres object by doing:
> intGenesMigsa <- filterByGenes(bcMigsaRes, myInterestGenes);
> dim(intGenesMigsa);

0501001508915347106367909212701991408569910629831106572723329700992887666522912747512627111115592034799787595184399011313092421225591839371747414595698474941100426259493847225963480idnumberJuan C Rodriguez, Crist´obal Fresno, Andrea S Llera, Elmer A Fern´andez

27

[1] 392 11

> head(intGenesMigsa);

id
4 GO:0000003
14 GO:0000022
40 GO:0000070
41 GO:0000075
45 GO:0000082
46 GO:0000083

Name
reproduction
4
mitotic spindle elongation
14
mitotic sister chromatid segregation
40
cell cycle checkpoint
41
45
G1/S transition of mitotic cell cycle
46 regulation of transcription involved in G1/S transition of mitotic cell cycle

GS_Name mainz

nki tcgaMA tcgaRNA transbig unt upp

4
14
40
41
45
46

BP FALSE FALSE
BP TRUE TRUE
BP TRUE TRUE
BP TRUE TRUE
BP TRUE TRUE
BP TRUE TRUE

TRUE
TRUE
TRUE
TRUE
TRUE
TRUE

TRUE
TRUE
TRUE
FALSE
TRUE
TRUE

vdx
FALSE TRUE TRUE FALSE
TRUE TRUE TRUE TRUE
TRUE TRUE TRUE TRUE
TRUE TRUE TRUE TRUE
TRUE TRUE TRUE TRUE
TRUE TRUE TRUE TRUE

And with this new MIGSAres object reproduce the same analysis done below.

Session Info

> sessionInfo()

R version 3.5.1 Patched (2018-07-12 r74967)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 16.04.5 LTS

Matrix products: default
BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so
LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so

locale:

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_US.UTF-8
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C

28

MIGSA: Massive and Integrative Gene Set Analysis

[9] LC_ADDRESS=C

LC_TELEPHONE=C

[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

attached base packages:
[1] stats4
[8] methods

parallel stats
base

graphics grDevices utils

datasets

other attached packages:

[1] edgeR_3.24.0
[4] mGSZ_1.0
[7] nlme_3.1-137

MIGSAdata_1.5.0
ismev_1.42
MASS_7.3-51
BiocParallel_1.16.0 GSEABase_1.44.0
annotate_1.60.0

MIGSA_1.6.0
mgcv_1.8-25
limma_3.38.0

XML_3.98-1.16
S4Vectors_0.20.0

[10] GSA_1.03
[13] graph_1.60.0
[16] AnnotationDbi_1.44.0 IRanges_2.16.0
[19] Biobase_2.42.0

BiocGenerics_0.28.0

loaded via a namespace (and not attached):

[1] ggdendro_0.1-20
[4] assertthat_0.2.0
[7] Category_2.48.0
[10] lattice_0.20-35
[13] colorspace_1.3-2
[16] pkgconfig_2.0.2
[19] xtable_1.8-3
[22] tibble_1.4.2
[25] survival_2.43-1
[28] crayon_1.3.4
[31] vegan_2.5-3
[34] org.Hs.eg.db_3.7.0
[37] stringr_1.3.1
[40] cluster_2.0.7-1
[43] compiler_3.5.1
[46] grid_3.5.1
[49] labeling_0.3
[52] DBI_1.0.0
[55] dplyr_0.7.7
[58] futile.options_1.0.1
[61] stringi_1.2.4

bit64_0.9-7
RBGL_1.58.0
pillar_1.3.0
glue_1.3.0
Matrix_1.2-14
genefilter_1.64.0
GO.db_3.7.0
ggplot2_3.1.0
RJSONIO_1.3-0
memoise_1.1.0
tools_3.5.1
formatR_1.5
munsell_0.5.0
lambda.r_1.2.3
rlang_0.3.0.1
RCurl_1.95-4.11
bitops_1.0-6
reshape2_1.4.3
bit_1.1-14
permute_0.9-4
Rcpp_0.12.19

References

splines_3.5.1
blob_1.1.1
RSQLite_2.1.1
digest_0.6.18
plyr_1.8.4
purrr_0.2.5
scales_1.0.0
lazyeval_0.2.1
magrittr_1.5
GOstats_2.48.0
data.table_1.11.8
matrixStats_0.54.0
locfit_1.5-9.1
bindrcpp_0.2.2
futile.logger_1.4.3
AnnotationForge_1.24.0
gtable_0.2.0
R6_2.3.0
bindr_0.1.1
Rgraphviz_2.26.0
tidyselect_0.2.5

Fang H, Gough J (2014). “The dnet’approach promotes emerging research on cancer patient

survival.” Genome medicine, 6(8), 1.

Fresno C, Gonzalez GA, Llera AS, Fernandez EA (2016). pbcmc: Permutation-Based Conﬁ-

Juan C Rodriguez, Crist´obal Fresno, Andrea S Llera, Elmer A Fern´andez

29

dence for Molecular Classiﬁcation. R package version 1.3.2, URL http://www.bdmg.com.
ar/.

Mishra P, T¨or¨onen P, Leino Y, Holm L (2014). “Gene set analysis:

limitations in popular

existing methods and proposed improvements.” Bioinformatics, 30(19), 2747–2756.

Parker JS, Mullins M, Cheang MC, Leung S, Voduc D, Vickery T, Davies S, Fauron C, He X,
Hu Z, et al. (2009). “Supervised risk predictor of breast cancer based on intrinsic subtypes.”
Journal of clinical oncology, 27(8), 1160–1167.

Rodriguez JC, Gonz´alez GA, Fresno C, Llera AS, Fern´andez EA (2016). “Improving infor-
mation retrieval in functional analysis.” Computers in Biology and Medicine, 79, 10–20.

Sørlie T, Borgan E, Myhre S, Vollan HK, Russnes H, Zhao X, Nilsen G, Lingjærde OC,
Børresen-Dale AL, Rødland E (2010). “The importance of gene-centring microarray data.”
The lancet oncology, 11(8), 719–720.

Aﬃliation:

Juan C Rodriguez & Elmer A Fern´andez
Bioscience Data Mining Group
Facultad de Ingenier´ıa
Universidad Cat´olica de C´ordoba - CONICET
X5016DHK C´ordoba, Argentina
E-mail: jcrodriguez@bdmg.com.ar, efernandez@bdmg.com.ar
URL: http://www.bdmg.com.ar/

