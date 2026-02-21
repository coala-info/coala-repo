crlmm to downstream data analysis

VJ Carey, B Carvalho

March, 2012

1 Running CRLMM on a nontrivial set of CEL ﬁles

To use the crlmm algorithm, the user must load the crlmm package, as described below:

> library(crlmm)

We work with the 90 CEU samples hybridized to Aﬀy 6.0 chips. When CEL ﬁles are
available, they must be identiﬁed and passed to crlmm, as shown below. In this example,
we assume that the results are stored in a variable called crlmmResult.

> celFiles <- list.celfiles()
> crlmmResult <- crlmm(celFiles)

Alternatively, the data aforementioned are available through the hapmapsnp6 pack-

age (required minimum version 1.3.6) and can be loaded by using:

> suppressPackageStartupMessages(library(hapmapsnp6))
> data(crlmmResult)

This is currently a SnpSet object.

>

class(crlmmResult)

[1] "SnpSet"
attr(,"package")
[1] "Biobase"

2 Adding information to a SnpSet

We will use the GGdata package to obtain extra information on the samples. This will
be later used when building an eSet extension to store the genotyping results.

1

>
>
>
>
>
>
>

suppressPackageStartupMessages(library(GGdata))
hmceuB36 <- getSS('GGdata', as.character(1:22))
pd <- phenoData(hmceuB36)
ggn <- sampleNames(pd)
preSN <- sampleNames(crlmmResult)
simpSN <- gsub("_.*", "", preSN)
if (!all.equal(simpSN, ggn)) stop("align GGdata phenoData with crlmmResult read")

The additional information obtained from GGdata can be easily combined to what

is already available on crlmmResult.

>
>
>

sampleNames(crlmmResult) <- simpSN
phenoData(crlmmResult) <- combine(pd, phenoData(crlmmResult))
dim(calls(crlmmResult))

[1] 906600

90

>

dim(confs(crlmmResult, FALSE))

[1] 906600

90

>

calls(crlmmResult)[1:10, 1:2]

SNP_A-2131660
SNP_A-1967418
SNP_A-1969580
SNP_A-4263484
SNP_A-1978185
SNP_A-4264431
SNP_A-1980898
SNP_A-1983139
SNP_A-4265735
SNP_A-1995832

NA06985 NA06991
2
3
3
1
1
1
3
1
2
3

2
3
3
2
1
1
3
1
2
2

>

confs(crlmmResult, FALSE)[1:10, 1:2]

SNP_A-2131660
SNP_A-1967418
SNP_A-1969580
SNP_A-4263484
SNP_A-1978185
SNP_A-4264431
SNP_A-1980898
SNP_A-1983139
SNP_A-4265735
SNP_A-1995832

NA06985 NA06991
11574
14866
7606
20059
18021
17235
7642
8974
9153
17920

10561
12517
7632
15621
14030
17792
7640
14127
8976
10336

2

3 Coercing to SnpMatrix as a prelude to a GWAS

From this point on, we will use only the genotype calls. Therefore, to reduce memory
requirements, we will recode the crlmm genotype calls, so the snpStats package can be
used, and delete the remaining crlmm results.

> theCalls <- t(calls(crlmmResult))-1L
> rm(crlmmResult)

used (Mb) gc trigger

(Mb)
8125770 434.0
Ncells
Vcells 109939505 838.8 295584944 2255.2 295028076 2250.9

11161382 596.1

(Mb) max used

7631568 407.6

SNP’s for which all the samples have the same genotype are not informative for

association studies. Therefore, we remove such SNP’s prior to ﬁtting the models.

> gtypeCounts <- rbind(AA=colSums(theCalls == 0L),
AB=colSums(theCalls == 1L),
+
BB=colSums(theCalls == 2L))
+
> gtypeCounts[, 1:5]

SNP_A-2131660 SNP_A-1967418 SNP_A-1969580 SNP_A-4263484 SNP_A-1978185
90
0
0

0
2
88

3
14
73

8
40
42

1
32
57

AA
AB
BB

> toRemove <- which(colSums(gtypeCounts == 0) == 2L)
> gtypeCounts[, toRemove[1:4]]

SNP_A-1978185 SNP_A-1983139 SNP_A-1997689 SNP_A-1997709
90
0
0

0
0
90

90
0
0

90
0
0

AA
AB
BB

> theCalls <- theCalls[, -toRemove]

The snpStats provides tools to simplify the analysis of GWAS. The snippet below
shows how to load the package and convert the genotype calls to a format that snpStats
is able to handle.

> suppressPackageStartupMessages(library(snpStats))
> crlmmSM <- new("SnpMatrix", theCalls)

coercing object of mode numeric to SnpMatrix

> crlmmSM

A SnpMatrix with 90 rows and 774475 columns
Row names: NA06985 ... NA12892
Col names: SNP_A-2131660 ... SNP_A-8573964

3

4 Conducting a GWAS

We want to ﬁnd SNP for which genotype is predictive of expression of CPNE1. We will
use expression data available from GGdata, using a naive analysis.

> suppressPackageStartupMessages(library(illuminaHumanv1.db))
> rmm <- revmap(illuminaHumanv1SYMBOL)
> mypr <- get("CPNE1", rmm)
> ex <- as.numeric(exprs(hmceuB36)[mypr[1],])
> subjdata <- pData(hmceuB36)
> subjdata[["ex"]] <- ex
> head(subjdata)

famid persid mothid fathid sampid isFounder male

NA06985 1341
NA06991 1341
NA06993 1341
NA06994 1340
NA07000 1340
NA07019 1340

14
2
13
9
10
2

0
14
0
0
0
12

0 NA06985
13 NA06991
0 NA06993
0 NA06994
0 NA07000
11 NA07019

ex
TRUE FALSE 9.654887
FALSE FALSE 9.551434
TRUE TRUE 10.083945
TRUE TRUE 9.930053
TRUE FALSE 9.645724
FALSE FALSE 9.788195

With the expression data now available in subjdata, we can use the tools from
SnpMatrix to ﬁt models that will be used to evaluate the association between the geno-
types of each available SNP and the expression levels of CPNE1.

> gwas <- snp.rhs.tests(ex~male, data=subjdata, snp.data=crlmmSM, family="gaussian")
> ok <- which(p.value(gwas) < 1e-10)
> gwas[ok,]

SNP_A-2047882
SNP_A-2216659
SNP_A-2220183
SNP_A-2231469
SNP_A-2275065
SNP_A-1890801

Chi.squared Df

p.value
41.82453 1 9.984311e-11
41.82453 1 9.984311e-11
46.38761 1 9.702689e-12
46.38761 1 9.702689e-12
46.38761 1 9.702689e-12
42.67888 1 6.450512e-11

> snp <- names(gwas[ok,])[1]
> gtypes <- theCalls[,snp]+1L
> boxplot(ex~gtypes, xlab=paste("Genotype Call for", snp),
+
> points(ex~jitter(gtypes), col=gtypes, pch=19)
> axis(1, at=1:3, labels=c("AA", "AB", "BB"))

ylab="CPNE1 Expression", xaxt="n", range=0)

4

5 Session Info

This vignette was created using the following packages:

> sessionInfo()

R version 2.15.0 beta (2012-03-20 r58793)
Platform: x86_64-apple-darwin9.8.0/x86_64 (64-bit)

locale:
[1] en_GB.UTF-8/en_GB.UTF-8/en_GB.UTF-8/C/en_GB.UTF-8/en_GB.UTF-8

attached base packages:
[1] splines
[8] base

stats

graphics grDevices datasets utils

methods

5

8.08.59.09.510.0Genotype Call for SNP_A−2047882CPNE1 ExpressionllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllAAABBBother attached packages:

[1] GGdata_1.0.18
[3] org.Hs.eg.db_2.7.1
[5] DBI_0.2-5
[7] GGBase_3.16.5
[9] Matrix_1.0-6

[11] survival_2.36-12
[13] BiocGenerics_0.1.14
[15] crlmm_1.13.16
[17] RColorBrewer_1.0-5

illuminaHumanv1.db_1.12.2
RSQLite_0.11.1
AnnotationDbi_1.17.27
snpStats_1.5.5
lattice_0.20-6
Biobase_2.15.4
hapmapsnp6_1.3.6
oligoClasses_1.17.36
BiocInstaller_1.1.28

[1] affyio_1.23.2
[4] bit_1.1-9
[7] ff_2.2-5

loaded via a namespace (and not attached):
annotate_1.33.8
codetools_0.2-8
foreach_1.3.5
IRanges_1.13.32
preprocessCore_1.17.7 stats4_2.15.0
xtable_1.7-0

[10] grid_2.15.0
[13] mvtnorm_0.9-9992
[16] tools_2.15.0

Biostrings_2.23.6
ellipse_0.3-7
genefilter_1.37.1
iterators_1.0.5

zlibbioc_1.1.1

6

