A tutorial for the Bioconductor package hierGWAS

Laura Buzdugan

October 30, 2025

Contents

1 Introduction
1.1 Model

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

1.2 Workflow . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2 Preparing Data

2.1 Data Formats . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2.2 Missingness . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2.3 Toy Data . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3 Data Analysis

3.1 Hierarchical Clustering of SNPs . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3.2 Multiple Sample Splitting and LASSO Regression . . . . . . . . . . . . . . . . . . .

3.3 Hierarchical Testing of SNPs

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3.4 Computation of explained variance . . . . . . . . . . . . . . . . . . . . . . . . . . .

4 Session Info

References

1

Introduction

1
1

2

2
2

3

3

4
4

5

6

8

8

9

hierGWAS tests statistical significance in Genome Wide Association Studies (GWAS), using a joint
model of all SNPs. This leads to a stronger interpretation of single, or groups of SNPs compared
to the marginal approach. The method provides an asymptotic control of the Family Wise Error
Rate (FWER), as well as an automatic, data-driven refinement of the SNP clusters to smaller
groups or single markers [1].

The method can be used for case-control studies, as well as for continuous trait studies. Aditionally,
one can control for one or more covariates.

1.1 Model

The two components of the model are the genotype X and the phenotype Y . Y is a vector of length
n, where n represents the number of samples (e.g. subjects). Yi, the phenotype corresponding to

1

person i, can encode either the disease status (0 or 1), or the continuous value of a trait. X is a
matrix of size n × p, where p is the number of SNPs to be analyzed. Xi,j encodes the number of
minor alleles of the jth SNP for person i, thus it can take values 0, 1, 2.
The genotype-phenotype relationship is expressed using a generalized linear model [2].
phenotype is continuous, this translates to a linear model:

If the

Yi = β0 +

p
(cid:88)

j=1

βjXi,j + ϵi

(i = 1, .., n)

where ϵi, .., ϵn are independent and identically distributed error terms with expectation 0. If the
phenotype is binary, representing case (=1) or control (=0) status, we use a logistic regression
model:

πi = P (Yi = 1|Xi, β) =

exp(ηi)
1 + exp(ηi)

(i = 1, .., n)

ln

πi
1 − πi

= ηi = β0 +

p
(cid:88)

j=1

βjXi,j

where π represents the probability of a subject having case status, given its SNPs Xi.
In both models β0 represents the intercept and βj are the (logistic) regression coefficients which
quantify the association between the response and SNP j.
Our goal is to assess the statistical significance of single SNPs, or groups of correlated SNPs, with
respect to the phenotype. This has to be made precise: we aim for p-values, adjusted for multiple
testing, when testing the hypotheses: for single SNP j

or for a group G ⊆ {1, . . . , p} of SNPs

H0,j : βj = 0 versus HA,j : βj ̸= 0,

H0,G : βj = 0 for all j ∈ G

versus HA,G : at least for one j ∈ G we have that βj ̸= 0.

(1)

(2)

The obtained p-values are with respect to a regression model and hence, they share the interpre-
tation with the regression parameters described above.

1.2 Workflow

The entire procedure for hierarchical inference is schematically summarized in Figure 1. Prepro-
cessing refers to the steps taken to clean the data, by removing SNPs, samples. This should be
performed before starting the analysis. The three stages of the procedure are described in detail
in sections 3.1, 3.2 and 3.3.

2 Preparing Data

2.1 Data Formats

The two required variables in order to perform the analysis are the phenotype and genotype data.
The genotype data, x, should be a matrix of size n x p, where n represents the number of samples
(subjects), and p the number of SNPs. The SNPs must be coded numerically (0,1,2 copies of a
specific allele). The phenotype data, y should be a vector of length n, and it should have either
binary (0,1), or continuous valued elements.

2

Figure 1: Flowchart of the method.

If one is working with PLINK, these two data structures can easily be created in R after the PLINK
data file is read.

There are two optional input variables. SNP_index, a vector of length p, assigns a label to each
SNP. These could represent chromosomes, or some other grouping of the SNPs. covar, either of
vector of length n, or a matrix of size n x c, stores the covariates one wishes to control for.

2.2 Missingness

In general, even after preprocessing, SNP data contains missing values. While this is not an issue
in a marginal analysis, where missing data are omitted, multivariate methods such as lm, glm, do
not allow for data with missingness.

Thus, one must impute these missing values before starting the analysis. There are several different
methods to do this, either in R, after the data is imported, or before. If done inside R, one can
choose from packages such as mice, mi or missforest, which perform multiple imputation.
If one wishes to use methods tailored for GWAS data, software such as SHAPEIT [3] can be employed.
Although the goal of SHAPEIT is to impute additional SNPs that were not genotyped, it will also
impute the missing values for the genotyped SNPs. This is done in the process of phasing the
chromosomes, when missing values are already imputed.

2.3 Toy Data

Given the usual size of GWAS data, performing the analysis on a real dataset with > 105 SNPs
is computationally expensive. For this reason, in order to illustrate the method, we generated a
small toy dataset using PLINK.
The data contains n = 500 samples (250 cases, 250 controls) and p = 1000 SNPs. Out of these
1000 SNPs, 990 have no association with the phenotype, while the remaining 10 have a population
odds ratio of 2. The SNPs were binned into different allele frequency ranges, to create a more
realistic example.

The SNPs are separated into two chromosomes: the first half of the SNPs are from chromosome
1, while the second half from chromosome 2. Finally, there are two control variables: sex (0 for
males, 1 for females) and age (between 18 and 65).

The data structure, entitled simGWAS, has the following components:

• SNP.1: The first SNP, of dimension 500 × 1. Each row represents a subject.

• ...

3

Data	  Sample	  Split	  1	  Mul.-­‐Sample	  Spli0ng	  	  &	  SNP	  Screening	  Hierarchical	  Tes.ng	  Output	  Clustering	  Preprocessing	  • SNP.1000: The last SNP, of dimension 500 × 1. Each row represents a subject.

• y: The response vector. It can be continuous or discrete.

• sex: The first covariate, represeting the sex of the subjects: 0 for men and 1 for women.

• age: The second covariate, represeting the age of the subjects.

3 Data Analysis

The hierGWAS R-package contains the following functions:

Function
cluster.snp
multisplit
test.hierarchy
compute.r2

Description
clusters the SNP hierarchically
performs the multiple sample splitting and LASSO regression
hierarchically tests the SNPs
computes the r2 for a group of SNPs

The first three functions perform the clustering, regression and testing. The outputs of cluster.snp
and multisplit are required as inputs for test.hierarchy, so these two functions need to be exe-
cuted before the third one. On the other hand, cluster.snp and multisplit are independent, so
they can be run in any order. In order to speed up the computations, one should consider running
them in parallel if the resoures allow it. The last function, compute.r2, allows the user to calculate
the variance explained by any group of SNPs of arbitrary size.

> library(hierGWAS)
> data(simGWAS)
> sim.geno <- data.matrix(simGWAS[,1:1000])
> sim.pheno <- simGWAS$y
> sim.covar <- cbind(simGWAS$sex,simGWAS$age)

In the following we will describe each of the four functions, and show how they should be used.

3.1 Hierarchical Clustering of SNPs

The first step is to hierarchically cluster the SNPs. cluster.snp uses the hclust function from
R, but provides a different distance measure. Hierarchical clustering is a computationally intensive
procedure, and for large datasets it becomes unfeasible. For this reason, one can divide the SNPs
into non-overlapping sets, and cluster each set separately. One natural division is the grouping of
SNPs into distinct chromosomes, but the user is free to define alternative divisions.

In the case of our toy data, the SNPs belong to either chromosome 1 or 2, so we cluster them into
two distinct hierarchies, by specifying the indices of the SNPs which come from either chromosome
1 or 2. Note that in this case, due to the small size of the data, it would be equally feasible to
cluster all the SNPs into a single tree.

> # cluster SNPs in chromosome 1
> SNPindex.chrom1 <- seq(1,500)
> dendr.chrom1 <- cluster.snp(sim.geno,SNP_index = SNPindex.chrom1)
> # cluster SNPs in chromosome 2
> SNPindex.chrom2 <- seq(501,1000)
> dendr.chrom2 <- cluster.snp(sim.geno,SNP_index = SNPindex.chrom2)

4

The inputs for cluster.snp are x, the genotype matrix, respectively SNPindex.chrom1 and
SNPindex.chrom2, the indices of SNPs in chromosomes 1 and 2. x was used to compute the
dissimilarity measure between the SNPs.

The default dissimilarity measure between two SNPs is 1 - LD (Linkage Disequilibrium), where LD
is defined as the square of the Pearson correlation coefficient. If the user wishes to use a different
dissimilarity measure, this will then be the sole input to cluster.snp. For example, if we were
to use a different measure, the input would have been only the dissimilarity matrix. Thus, for our
toy data, we would have had to provide either two 500 × 500 matrices, one per chromosome, and
execute the function separately for each chromosome, or give one 1000 × 1000 dissimilarity matrix
for the entire dataset.

Finally, the default agglomeration method is average linkage, however the user can choose between
multiple methods implemented by hclust.
For large datasets, one can speed up the analysis by running the clustering of separate chromosomes
in parallel. This can be done using the parallel R package.

3.2 Multiple Sample Splitting and LASSO Regression

The second step, which can be run independently from the first one, is to do repeated LASSO
regressions on random sample splits. This part of the analysis is implemented in the multisplit
function. This function takes as input the genotype and phenotype data, as well as one or more
covariates.

The procedure is as follows:

1. Randomly split the sample into two equal parts: I1 and I2

2. Do LASSO selection on the data from I1. Save the n/6 selected SNPs.

3. Repeat steps 1-2 B times. The default value for B is 50, but a different number of random

splits can be specified.

The output of this function is a list with two components:

• out.sample: a matrix of size B × [n/2] containing the second subsample (I2) for each split.

• sel.coeff: a matrix of size B × [n/6] containing the selected variables in each split.

For our example, the code is the following:

> res.multisplit <- multisplit(sim.geno,sim.pheno,covar = sim.covar)
> # the matrix of selected coefficients for each sample split
> show(res.multisplit$sel.coeff[1:10,1:10])

[,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
178
298
731
716
315
179
544
473
370
218

992 730
137 992
992 129
341 433
635 218
997 995
990 846
998 992
625 992
989 997

718 153
859 998
149 546
990 997
415 252
989 262
665 415
997 897
989 719
962 409

995 991
991 989
991 995
991 995
990 995
990 991
991 996
995 991
991 995
990 991

149
995
990
989
991
992
992
989
990
995

997
846
344
996
992
585
997
990
655
956

473
218
989
998
998
149
995
321
997
996

[1,]
[2,]
[3,]
[4,]
[5,]
[6,]
[7,]
[8,]
[9,]
[10,]

5

> # the samples which will be used for testing
> show(res.multisplit$out.sample[1:10,1:10])

[,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
25
14
13
16
16
18
26
15
18
17

16
10
9
10
11
13
21
12
14
11

22
13
12
15
13
15
25
14
16
14

19
11
11
13
12
14
24
13
15
13

14
9
8
8
9
11
14
7
12
9

9
8
7
7
8
10
13
6
11
7

3
1
3
1
2
2
1
1
1
1

6
3
5
4
4
5
8
4
6
4

4
2
4
2
3
3
4
3
5
2

8
7
6
6
7
7
9
5
7
5

[1,]
[2,]
[3,]
[4,]
[5,]
[6,]
[7,]
[8,]
[9,]
[10,]

3.3 Hierarchical Testing of SNPs

The last step of the procedure is the hierarchical testing of SNPs. We describe the steps for the
toy data:

1. Test the global hypothesis H0,Gglobal

where Gglobal = {1, . . . , p}: that is, we test whether all
SNPs have corresponding (generalized) regression coefficients equal to zero or alternatively,
whether there is at least one SNP which has a non-zero regression coefficient. If we can reject
this global hypothesis, we go to the next step.

2. Test the hypotheses H0,G1, . . . , H0,G2
For those chromosomes k where H0,Gk

where Gk contains all the SNPs from chromosome k.
can be rejected, we go to the next step.

3. Test hierarchically the groups G which correspond to chromosomes k where H0,Gk

is rejected:
first consider the largest groups and then proceed hierarchically (down the cluster tree) to
smaller groups until a hypothesis H0,G can not be rejected anymore or the level of single
SNPs is reached.

4. The output is a collection of groups Gfinal,1, . . . , Gfinal,m where H0,Gfinal,k

is rejected (k =
1, . . . , m) and all subgroups of Gfinal,k (k = 1, . . . , m) downwards in the cluster tree are not
significant anymore.

With this procedure, one needs to do the hypothesis tests in such a hierarchical procedure at certain
levels to guarantee that the familywise error, i.e., the probability for at least one false rejection of
the hypotheses among the multiple tests, is smaller or equal to α for some pre-spcified 0 < α < 1,
e.g., α = 0.05.
For our dataset, the test.hierarchy function takes as input the following variables:

• x: the genotype matrix

• y: the phenotype vector

• dendr: the hierarchical tree (of one of the chromosomes)

• res.multisplit: the output of the LASSO regression

• SNP_index: the indices of SNPs (in one of the chromosomes)

• global.test: specifies wether the global null hypothesis should be tested

• verbose: reports information on progress

6

We then run the function for both chromosomes 1 and 2.

> result.chrom1 <- test.hierarchy(sim.geno, sim.pheno, dendr.chrom1, res.multisplit,
+
> result.chrom2 <- test.hierarchy(sim.geno, sim.pheno, dendr.chrom1, res.multisplit,
+
+
> show(result.chrom2)

covar = sim.covar, SNP_index = SNPindex.chrom2,
global.test = FALSE, verbose = FALSE)

covar = sim.covar, SNP_index = SNPindex.chrom1)

[[1]]
[[1]]$label

[1] 552 828 589 800 662 693 741 829 685 718 618 820 629 857 930 824 935 725
[19] 855 757 775 503 574 991 519 731 808 950 986 861 563 583 817 821 525 769
[37] 815 534 767 788 949 679 834 759 907 810 946 511 696 523 770 858 558 573
[55] 727 801 676 961 513 732 657 983 572 714 913 567 867 545 738 909 626 754
[73] 566 621 642 825 582 764 687 697 873 656 976 677 746 937 777 862 716 999
[91] 865 879 517 853 510 600 509 651 846 761 993 518 684 713 956 719 766 575
[109] 870 627 889 560 979 728 792 968 910 939 875 715 787 507 721 543 595 786
[127] 790 533 632 635 745 596 740 668 848 551 881 931 971 617 934

[[1]]$pval
[1] 0.01245864

[[2]]
[[2]]$label

[1] 963 813 871 929 748 849 844 995 553 729 830 982 771 841 900 541 932 695 762
[20] 529 850 530 823 611 700 665 843 973 663 811 619 789 562 675 998 803 744 798

[[2]]$pval
[1] 0.0470368

[[3]]
[[3]]$label
[1] 992

[[3]]$pval
[1] 0.01789627

[[4]]
[[4]]$label
[1] 997

[[4]]$pval
[1] 0.03851764

The ouptput of test.hierarchy is a list containing groups or individually significant SNPs, as
well as their p-values.

Based on the indices of the significant SNPs, one can go back to the original data and retrieve the
SNP rsIDs.
Due to the fact that the procedure begins with testing the globall null H0,Gglobal

, if we subdivide

7

the SNPs into chromosomes or other groups, we will end up testing the global null for each division.
In order to save time, once the global null has been rejected (e.g. for chromosome 1), when testing
chromosome 2, the test.global parameter should be set to FALSE, to avoid retesting the null.
The final parameter of the function, verbose, offers the user updates about the progress of the
algorithm. By default this parameter is set to TRUE, but the messages can be suppressed by setting
it to FALSE.

3.4 Computation of explained variance

One has the option of calculating the variance explained by any group of SNPs, using the compute.r2
function. The inputs are:

• x: the genotype matrix

• y: the phenotype vector

• res.multisplit: the output of the LASSO regression

• covar: the matrix of covariates

• SNP_index: the indices of SNPs whose r2 will be computed

The r2 of a group is computed in the following way:

1. Intersect the group indices with those of the selected coefficients in split b

2. Compute the r2 of the model with SNPs from point 1.

3. Repeat steps 1-2 B times. The final r2 is the mean of the B r2 values.

For our toy data, given that we know a-priori that the last 10 SNPs are the ones that increase the
risk of disease, we chose to compute the variance explained jointly by them. This is done using
the following command:

> SNP_index <- seq(991,1000)
> res.r2 <- compute.r2(sim.geno, sim.pheno, res.multisplit, covar = sim.covar, SNP_index = SNP_index)
> show(res.r2)

[1] 0.2562907

4 Session Info

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

8

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
[1] stats

graphics

other attached packages:
[1] hierGWAS_1.40.0

grDevices utils

datasets

methods

base

loaded via a namespace (and not attached):

[1] compiler_4.5.1
[5] Rcpp_1.1.0
[9] iterators_1.0.14

[13] shape_1.4.6.1

Matrix_1.7-4
splines_4.5.1
foreach_1.5.2
glmnet_4.1-10

tools_4.5.1
codetools_0.2-20
fmsb_0.7.6
lattice_0.22-7

survival_3.8-3
grid_4.5.1
fastcluster_1.3.0

References

[1] L. Buzdugan et al. Assessing statistical significance in predictive genome-wide association

studies. (unpublished).

[2] P. McCullagh and J.A. Nelder. Generalized Linear Models. Chapman & Hall, London, 1989.

[3] O. Delaneau et al. Improved whole-chromosome phasing for disease and population genetic

studies. Nature Methods, 10(1):5-6, 2013.

9

