metaSeq: Meta-analysis of RNA-seq count data

Koki Tsuyuzaki1, and Itoshi Nikaido2.

October 30, 2025

1Department of Medical and Life Science, Tokyo University of Science.
2Bioinformatics Research Unit, Advanced Center for Computing and Communication,
RIKEN.

k.t.the-answer@hotmail.co.jp

Contents

1 Introduction

2 RSE: Read-Size Effect

3 Robustness against RSE

4 Getting started

5 Meta-analysis by non-NOISeq method

6 Setup

2

2

3

4

7

9

1

1

Introduction

This document provides the way to perform meta-analysis of RNA-seq data using metaSeq
package. Meta-analysis is a attempt to integrate multiple data in different studies and
retrieve much reliable and reproducible result. In transcriptome study, the goal of analysis
may be differentially expressed genes (DEGs). In our package, the probability of one-sided
NOISeq [1] is applied in each study. This is because the numbers of reads are often different
depending on its study and NOISeq is robust method against its difference (see the next
section). By meta-analysis, genes which differentially expressed in many studies are detected
as DEGs.

2 RSE: Read-Size Effect

In many cases, the number of reads are depend on study. For example, here we prepared
multiple RNA-Seq count data designed as Breast Cancer cell lines vs Normal cells measured
in 4 different studies (this data is also accessible by data(BreastCancer)).

ID in this vignette Accession (SRA / ERA Accession)

StudyA
StudyB
StudyC
StudyD

SRP008746
SRP006726
SRP005601
ERP000992

Experimental Design
Breast Cancer (n=3) vs Normal (n=2)
Breast Cancer (n=1) vs Normal (n=1)
Breast Cancer (n=7) vs Normal (n=1)
Breast Cancer (n=2) vs Normal (n=1)

Figure 1: Difference of the number of reads

2

As shown in the figure 1, the number of reads in StudyA, B, C, and D are relatively
different. Generally, statistical test is influenced by the number of reads; the more the
number of reads is large, the more the statistical tests are tend to be significant (see the
next section). Therefore, in meta-analysis of RNA-seq data, data may be suffered from this
bias. Here we call this bias as RSE (Read Size Effect).

3 Robustness against RSE

In the point of view of robustness against RSE, we evaluated five widely used method in
RNA-seq; DESeq [2], edgeR [3], baySeq [4], and NOISeq [1]. Here we used only StudyA data.
All counts in the matrix are repeatedly down-sampled in accordance with distributions of
binomial (the probability equals 0.5). 1 (original), 1/2, 1/4, 1/8, 1/16, and 1/32-fold data
are prepared as low read size situation. In each read size, four methods are conducted (figure
2.A, this data is also accessible by data(StudyA) and data(pvals)), then we focussed on
how top500 genes of original data in order of significance will change its members, influenced
by low read size (figure 2.B).

Figure 2: A(left): RSE in each RNA-Seq method, B(right): Top 500 genes in order of
significance

Ideal method will returns same result regardless of read size, because same data was used.
As shown in figure 2, NOISeq is not almost affected by the number of reads and robustlly
detects same genes as DEGs. Therefore, we concluded that NOISeq is suitable method at
least in the point of view of meta-analysis. Note that probability of NOISeq is not equal to
p-value; it is the probability that a gene is differentially expressed [1]. Our package integrates
its probability by Fisher’s method [5] or Stouffer’s method (inverse normal method) [6]. In
regard to Stouffer’s method, weighting by the number of replicates (sample size) is used.

3

4 Getting started

At first, install and load the metaSeq and snow .

> library("metaSeq")
> library("snow")

The RNA-seq expression data in breast cancer cell lines and normal cells is prepared.
The data is measured from 4 different studies.The data is stored as a matrix (23368 rows ×
18 columns).

> data(BreastCancer)

We need to prepare two vectors. First vector is for indicating the experimental condition
(e.g., 1: Cancer, 2: Normal) and second one is for indicating the source of data (e.g., A:
StudyA, B: StudyB, C: StudyC, D: StudyD).

> flag1 <- c(1,1,1,0,0, 1,0, 1,1,1,1,1,1,1,0, 1,1,0)
> flag2 <- c("A","A","A","A","A", "B","B", "C","C","C","C","C","C","C","C", "D","D","D")

Then, we use meta.readData to create R object for meta.oneside.noiseq.

> cds <- meta.readData(data = BreastCancer, factor = flag1, studies = flag2)

Onesided-NOISeq is performed in each studies and each probabilities are summalized as

a member of list object.

> ## This is very time consuming step.
> # cl <- makeCluster(4, "SOCK")
> # result <- meta.oneside.noiseq(cds, k = 0.5, norm = "tmm", replicates = "biological",
> # factor = flag1, conditions = c(1, 0), studies = flag2, cl = cl)
> # stopCluster(cl)
>
> ## Please load pre-calculated result (Result.Meta)
> ## by data function instead of scripts above.
> data(Result.Meta)
> result <- Result.Meta

Fisher’s method and Stouffer’s method can be applied to the result of meta.oneside.noiseq.

> F <- Fisher.test(result)
> S <- Stouffer.test(result)

These outputs are summalized as list whose length is 3. First member is the probability
which means a gene is upper-regulated genes, and Second member is lower-regulated genes.
Weight in each study is also saved as its third member (weight is used only by Stouffer’s
method).

4

> head(F$Upper)

A1BG
0.5316118

A1BG-AS1
0.5325544

A1CF
NA

A2LD1
0.1358559

1/2-SBSRNA4
0.3842542
A2M
0.2252807

> head(F$Lower)

A1BG
0.6078896

A1BG-AS1
0.4047202

A1CF
NA

A2LD1
0.3661371

1/2-SBSRNA4
0.8420357
A2M
0.6197968

> F$Weight

Study 1 Study 2 Study 3 Study 4
3

5

2

8

> head(S$Upper)

A1BG
0.2663748

A1BG-AS1
0.2711745

A1CF
NA

A2LD1
0.2957139

1/2-SBSRNA4
0.3709297
A2M
0.2996707

> head(S$Lower)

A1BG
0.7336252

A1BG-AS1
0.7288255

A1CF
NA

A2LD1
0.7042861

1/2-SBSRNA4
0.6290703
A2M
0.7003293

> S$Weight

Study 1 Study 2 Study 3 Study 4
3

5

2

8

5

Generally, by meta-analysis, detection power will improved and much genes are detected

as DEGs.

Method
NOISeq
NOISeq
NOISeq
NOISeq
NOISeq
metaSeq (Fisher, Upper)
metaSeq (Fisher, Lower)
metaSeq (Stouffer, Upper)
metaSeq (Stouffer, Lower)

Study
A
B
C
D
A, B, C, D (not meta-analysis)
A, B, C, D
A, B, C, D
A, B, C, D
A, B, C, D

Number of DEGs
86
563
99
210
21
407
1483
116
2271

6

5 Meta-analysis by non-NOISeq method

For some reason, we may want to use non-NOISeq method like DESeq, edgeR, or even cuffdiff
[7]. We prepared other.oneside.noiseq as optional function for such methods. Returned
object can be directlly applied to Fisher.test and Stouffer.test.

We have to prepare at least 2 matrix filled with p-value or probability. First matrix is
for upper-regulated genes between control group and treatment group. On the other hand,
second matrix is for lower-regulated genes. As optional parameter, weight in each study is
also avilable. Weight is need for Stouffer’s method but not necessary for Fisher’s method.

> ## Assume this matrix as one-sided p-values
> ## generated by non-NOISeq method (e.g., cuffdiff)
> upper <- matrix(runif(300), ncol=3, nrow=100)
> lower <- 1 - upper
> rownames(upper) <- paste0("Gene", 1:100)
> rownames(lower) <- paste0("Gene", 1:100)
> weight <- c(3,6,8)

Next, other.oneside.pvalues will return a list object for Fisher.test or Stouffer.test

by upper, lower, and weight.

> ## other.oneside.pvalues function return a matrix
> ## which can input Fisher.test or Stouffer.test
> result <- other.oneside.pvalues(upper, lower, weight)

result above can be applied to Fisher.test and Stouffer.test.

> F <- Fisher.test(result)
> str(F)

List of 3

$ Upper : Named num [1:100] 0.643 0.805 0.513 0.577 0.779 ...

..- attr(*, "names")= chr [1:100] "Gene1" "Gene2" "Gene3" "Gene4" ...

$ Lower : Named num [1:100] 0.66 0.401 0.73 0.499 0.407 ...

..- attr(*, "names")= chr [1:100] "Gene1" "Gene2" "Gene3" "Gene4" ...

$ Weight: Named num [1:3] 3 6 8

..- attr(*, "names")= chr [1:3] "Exp 1" "Exp 2" "Exp 3"

> head(F$Upper)

Gene1

Gene6
0.6428518 0.8049875 0.5126057 0.5768678 0.7792825 0.8944042

Gene4

Gene5

Gene3

Gene2

> head(F$Lower)

Gene1

Gene6
0.66047057 0.40092604 0.73048385 0.49941332 0.40659406 0.05279191

Gene3

Gene5

Gene4

Gene2

7

> F$Weight

Exp 1 Exp 2 Exp 3
8

6

3

> S <- Stouffer.test(result)
> str(S)

List of 3

$ Upper : Named num [1:100] 0.473 0.667 0.321 0.381 0.654 ...

..- attr(*, "names")= chr [1:100] "Gene1" "Gene2" "Gene3" "Gene4" ...

$ Lower : Named num [1:100] 0.527 0.333 0.679 0.619 0.346 ...

..- attr(*, "names")= chr [1:100] "Gene1" "Gene2" "Gene3" "Gene4" ...

$ Weight: Named num [1:3] 3 6 8

..- attr(*, "names")= chr [1:3] "Exp 1" "Exp 2" "Exp 3"

> head(S$Upper)

Gene1

Gene6
0.4733269 0.6669196 0.3207565 0.3809677 0.6543542 0.9757633

Gene5

Gene4

Gene3

Gene2

> head(S$Lower)

Gene1

Gene6
0.52667310 0.33308042 0.67924347 0.61903229 0.34564578 0.02423673

Gene3

Gene5

Gene4

Gene2

> S$Weight

Exp 1 Exp 2 Exp 3
8

6

3

8

6 Setup

This vignette was built on:

> sessionInfo()

R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default
BLAS:
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

LAPACK version 3.12.0

locale:

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_GB
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:
[1] splines
[7] methods

stats
base

graphics grDevices utils

datasets

other attached packages:
[1] metaSeq_1.50.0
[4] NOISeq_2.54.0
[7] BiocGenerics_0.56.0 generics_0.1.4

Rcpp_1.1.0
Matrix_1.7-4

snow_0.4-4
Biobase_2.70.0

loaded via a namespace (and not attached):
[1] compiler_4.5.1 parallel_4.5.1 tools_4.5.1
[5] lattice_0.22-7

grid_4.5.1

9

References

[1] Tarazona, S. and Garcia-Alcalde, F. and Dopazo, J. and Ferrer, A. and Conesa, A.
Genome Research Differential expression in RNA-seq: A matter of depth, 21(12): 2213-
2223, 2011.

[2] Simon Anders and Wolfgang Huber Genome Biology Differential expression analysis for

sequence count data., 11: R106, 2010.

[3] Robinson, M. D. and McCarthy, D. J. and Smyth, G. K. Bioinformatics edgeR: a
Bioconductor package for differential expression analysis of digital gene expression data.,
26: 139-140, 2010

[4] Thomas J. Hardcastle R package version 1.14.1. baySeq: Empirical Bayesian analysis of

patterns of differential expression in count data., 2012.

[5] Fisher, R. A. Statistical Methods for Research Workers, 4th edition, Oliver and Boyd,

London, 1932.

[6] Stouffer, S. A. and Suchman, E. A. and DeVinney, L. C. and Star, S. A. and Williams,
R. M. Jr. The American Soldier, Vol. 1 - Adjustment during Army Life. Princeton,
Princeton University Press, 1949

[7] Trapnell, C. and Williams, B. A. and Pertea, G. and Mortazavi, A. and Kwan, G. and
Baren, M. J. and Salzberg, S. L. and Wold, B. J. and Pachter, L. Nature biotechnology
Transcript assembly and quantification by RNA-Seq reveals unannotated transcripts and
isoform switching during cell differentiaiton, 28: 511-515, 2010.

10

