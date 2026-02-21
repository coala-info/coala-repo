ROTS: Reproducibility Optimized Test Statistic

Fatemeh Seyednasrollah, Tomi Suomi, Laura L. Elo

March 3, 2016

Contents

1 Introduction

2 Algorithm overview

3 Input data

4 Preprocessing

5 Differential expression testing

6 Visualization

7 References

2

3

4

4

4

7

8

1

1

Introduction

Differential expression testing is perhaps the most common approach among
current omics analysies. Reproducibility optimized test statistic (ROTS) aims
to rank genomic features of interest (such as genes, proteins and transcripts) in
order of evidence for differential expression in two-group comparisons. Initially,
ROTS was developed to test differential expression in microarray studies (Elo
2008). However, the general design of the algorithm supports the utility of the
method in proteomics and count-based technologies like RNA-seq and single cell
datasets (Seyednasrollah et al. 2015, Pursiheimo et al. 2015). ROTS is a data
adaptive method which can optimize its parameters based on intrinsic features
of input data. Also, the method aims to solve the common problem of small
sample size through a resampling procedure.

The ROTS statistic is optimized among a family of t-type statistics d = r/(α1 +
α2 × s), where r is the absolute difference between the group averages | ¯x1 − ¯x2|,
s is the pooled standard error, and α1 and α2 are the non-negative parameters
to be optimized. Two special cases of this family are the ordinary t-statistic
(α1 = 0, α2 = 1) and the signal log-ratio (α1 = 1, α2 = 0).

The optimality is defined in terms of maximal overlap of top-ranked features in
group-preserving bootstrap datasets. Importantly, besides the group labels, no
a priori information about the properties of the data is required and no fixed
cutoff for the gene rankings needs to be specified. The user is given the option
to adjust the largest top list size (K) considered in the reproducibility calcu-
lations, since lowering this size can markedly reduce the computation time. In
large data matrices with thousands of rows, we generally recommend using a
size of several thousands.

ROTS tolerates a moderate number of missing values in the data matrix by
effectively ignoring their contribution during the operation of the procedure.
However, each row of the data matrix must contain at least two values in both
groups. The rows containing only a few non-missing values should be removed;
or alternatively, the missing data entries can be imputed using, e.g., the K-
nearest neighbour imputation, which is implemented in the Bioconductor pack-
If the parameter values α1 and α2 are set by the user, then no
age impute.
optimization is performed but the statistic and FDR-values are calculated for
the given parameters. The false discovery rate (FDR) for the optimized test
statistic is calculated by permuting the sample labels. The results for all the
genes can be obtained by setting the FDR cutoff to 1.

2

2 Algorithm overview

ROTS optimizes the reproducibility among a family of modified statistics:

dα =

r
α1 + α2 × s

(1)

where r is a score, α1 and α2 are non-negative parameters to be optimized, and
s is standard deviation.

The optimal statistic is determined by maximizing the reproducibility Z-score:

Zk (dα) =

Rk (dα) − R0
sk (dα)

k (dα)

(2)

over a dence lattice α1 ∈ [0, 0.01, ..., 5] , α2 ∈ {0, 1}, k ∈ {1, 2, ..., G}. Here,
Rk (dα) is the observed reproducibility at top list size k, R0
k (dα) is the cor-
responding reproducibility in randomized datasets (permuted over samples),
sk (dα) is the standard deviation of the bootstrap distribution, and G is the
total number of genes/proteins in the data. Reproducibility is defined as the
average overlap of k top-ranked features over pairs of bootstrapped datasets.

In two-group comparisons, ROTS optimizes the reproducibility of top-ranked
features in group-preserving bootstrap datasets among a family of modified t-
statistics, where the score r is the absolute difference between the group averages
and s is the pooled standard error:

r = | ¯x1 − ¯x2|

s =

(cid:34) (cid:80)

(xi − ¯x1)2 + (cid:80)

i∈C2

i∈C1

(xi − ¯x2)2

n1 + n2 − 2

(cid:35)1/2

(1/n1 + 1/n2)

(3)

(4)

where i has the indices of observations in classes C1 and C2, and n1 and n2 are
the number samples in classes 1 and 2, respectively.

In multi-group comparisons, ROTS optimizes the reproducibility of top-ranked
features in group-preserving bootstrap datasets among a family of modified f-
statistics:

(cid:34)

r =

(cid:110)(cid:88)

nc/

(cid:89)

nc

(cid:111) C
(cid:88)

c=1

nc (¯xc − ¯x)2

(cid:35)1/2

(cid:34)

s =

1
(cid:80) (nc − 1)

(cid:18)(cid:88) 1
nc

(cid:19) C
(cid:88)

(cid:88)

c=1

i∈Cc

(cid:35)1/2

(xi − ¯xc)2

3

(5)

(6)

where c is the different classes {1, 2, ..., C}, nc is the number samples in class c,
and i has the indices of observations in class Cc.

In survival analysis, ROTS optimizes the reproducibility of top-ranked features
among Cox scores:

r =

T
(cid:88)

t=11

[xDt − dt ¯xt]

s =

(cid:34) T

(cid:88)

t=t1

(dt/kt)

(cid:88)

i∈Rt

(cid:35)1/2

(xi − ¯xt)2

(7)

(8)

where Dt is indices of observations at the different death times {t1, t2, ..., T },
Rt indices of the observations at risk at these times, and dt and kt the number
of deaths and individuals at risk, at the time, respectively.

For more detailed information about the ROTS algorithm, see Elo et al. (2008)
and Seyednasrollah et al. (2015).

3

Input data

ROTS expects the input data to be in form of a matrix with genomic features
as rows and samples as columns.
It is recommended to use normalized data
as the input for ROTS. The matrix can be either of integer numbers, e.g. for
RNA-seq and single cells, or float numbers, e.g. microarray intensities.

4 Preprocessing

For count-based data, we recommend the widely used preprocessing techniques
like TMM (Trimmed Mean of M-values) normalization available in edgeR Bio-
conductor package or TMM normalization plus Voom transformation available
in Limma Bioconductor package. For microarray and proteomics data, standard
normalization techniques are recommended.

5 Differential expression testing

We use here a proteomics dataset as an example for differential expression test-
ing. The overall approach is the same for other omics data along with recom-
mended preprocessing strategies.

The analysis starts by loading the ROTS package and the example dataset,
which contains two sample groups each having three replicates:

4

> library(ROTS)
> data(upsSpikeIn)
> input = upsSpikeIn

In the next step we determine the experimental design for differential expression
analysis. Please note that the order of the samples in the data matrix should
be exactly the same as the groups vector defined.

> groups = c(rep(0,3), rep(1,3))
> groups

[1] 0 0 0 1 1 1

The ROTS function performs the final differential expression testing. The user
can set the function parameters before running the analysis:

> results = ROTS(data = input, groups = groups , B = 100 , K = 500 , seed = 1234)
> names(results)

[1] "data"
[9] "k"

"B"
"R"

"d"
"Z"

"logfc"
"ztable" "cl"

"pvalue" "FDR"

"a1"

"a2"

In this example, we set the number of bootstrapping (B) and the number of top-
ranked features for reproducibility optimization (K) to 100 and 500 respectively,
to reduce running time of the example. In real analysis it is preferred to use a
higher number of bootstraps (e.g. 1000). The optimization parameters a1 and
a2 should always be non-negative. The output of ROTS function includes test
statistic (d), estimated p-value (pvalue), False Discovery Rate (FDR), optimized
test statistic parameters and top list size (a1, a2, k), optimized reproducibility
value (R) and Z-score (Z). In general, the Z-score and reproducibility are the
main indicators to decide the success of differential expression analysis. As a
rule of thumb, reproducibility Z-scores below 2 indicate that the data or the
statistics are not sufficient for reliable detection.

Finally, it is possible to summarize the results based on criteria selected by
the user. For instance, the following code lists the top ranked differentially
expressed features with FDR below 0.05:

> summary(results, fdr = 0.05)

ROTS results:

Number of resamplings:

100

a1:
a2:
Top list size:

1.4
1
20

5

Reproducibility value:
Z-score:

0.7945
4.530883

14 rows satisfy the condition. Only ten first rows are
displayed, see the return value for the whole output.

Row ROTS-statistic

P51965ups
P00441ups
P08758ups
O00762ups
P01375ups
P06396ups
P07339ups
P15559ups
P08263ups
P08311ups
...

13
24
16
19
22
27
11
80
1
9

2.598928 0.0002989130
2.315927 0.0004347826
2.176674 0.0005706522
2.139412 0.0008288043
2.059381 0.0009646739
2.001048 0.0011005435
1.958776 0.0012364130
1.864312 0.0015353261
1.802017 0.0016711957
1.698728 0.0019497283

pvalue FDR
0
0
0
0
0
0
0
0
0
0

6

6 Visualization

Results can also be visualized using the standard plot command:

> plot(results, fdr = 0.05, type = "volcano")

> plot(results, fdr = 0.05, type = "heatmap")

7

−8−6−4−20240.00.51.01.52.02.53.03.5log2 fold change−log10 p−valueA2A3A1C1C3C2P15559upsP08758upsP55957upsP06396upsP51965upsP02753upsP01375upsP00441upsO00762upsP63165upsP08263upsP00918upsP07339upsP08311ups7 References

Elo, L.L. et al., Reproducibility-optimized test statistic for ranking genes in mi-
croarray studies. IEEE/ACM transactions on computational biology and bioin-
formatics, 5, 423-431, 2008.

Elo, L.L. et al. Optimized detection of differential expression in global profiling
experiments: case studies in clinical transcriptomic and quantitative proteomic
datasets. Briefings in bioinformatics, 10, 547-555, 2009.

Seyednasrollah et al. ROTS: reproducible RNA-seq biomarker detector-prognostic
markers for clear cell renal cell cancer. Nucleic Acids Research, 2015.

Pursiheimo et al. Optimization of Statistical Methods Impact on Quantitative
Proteomics Data. J. Proteome Res., 2015.

8

