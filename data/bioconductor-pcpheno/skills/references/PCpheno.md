PCpheno: assessing the role cellular organizational
units in determining phenotype

Nolwenn Le Meur and Robert Gentleman

October 30, 2017

1

Introduction

We propose computational methods and statistical paradigms to explore the
relationships between phenotypic data and cellular organizational units, such
as multi-protein complexes or pathways. Indeed, while proteins are often the
primary unit used by cells to carry out the many diﬀerent functions that the
cell requires for life, they seldom accomplish important tasks alone, but
rather assemble into organizational units. Recent studies suggest that some
control of phenotype can be usefully attributed to multi-protein complexes
rather than genes (Deutschbauer et al., 2005; Spirin et al., 2006) and hence
may help provide elucidation of the underlying roles or mechanisms that
directly control changes in phenotype.

2 Data sources

In this package, we currently present yeast phenotypic datasets and use of
the yeast cellular organizational units deﬁned in the Bioconductor package
ScISI package and the KEGG pathways listed in the org.Sc.sgd.db package
(formerly the YEAST package).

Nevertheless our methods can easily be applied to other species and other
estimates of organizational units within the genome, or proteome, and in no
way rely on the particular choices we have made here.

2.1 Phenotypic data

We currently propose 7 Yeast phenotypic datasets, downloaded from the the
literature and the Saccharomyces Genome Database (http://www.yeastgenome.org/).

1

(cid:136) Giaever et al. (2002) collection of single gene-deletion mutants under

6 diﬀerent experimental conditions.

(cid:136) Dudley et al. (2005) collection of single gene-deletion mutants under

21 diﬀerent experimental conditions.

(cid:136) Deutschbauer et al. (2005) collection of haploinsuﬃcient genes.

(cid:136) Lesage et al. (2005) network of genetic interactions.

(cid:136) Kastenmayer et al. (2006) collection single gene-deletion mutants un-

der 5 diﬀerent experimental conditions.

(cid:136) Osterberg et al. (2006) collection of overexpression 600 C-terminal
tagged integral membrane under 4 diﬀerent experimental conditions.

(cid:136) Balakrishnan et al. (2006) list of phenotypes and associated genes from

several published experiments.

While our approach focuses on understanding the functional roles that
underly phenotypic changes when manipulating single genes, we hope that
these methods will also form the basis for the analysis of more complex gene
manipulation experiments.

To illustrate this vignette, we will use the data by Dudley et al. (2005).

> library(PCpheno)
> data(DudleyPhenoM)
> ##Number of genes sensitive at each condition
> colSums(DudleyPhenoM)

benomyl
34
HU
87
Sorb
8

CaCl2
180
HygroB
264
UV
32

CAD
83
lowPO4
34
YPGal
41

Caff cyclohex
164
NaCl
57
YPLac
159

208
MPA
11
YPGly
206

DTT
5
Paraq
36
YPRaff
31

EtOH
75
pH3
16

FeLim
35
rap
119

> ##Retrieve the name of the sensitive genes in each condition
> DudleyPhenoL <- apply(DudleyPhenoM,2,function(x) names(which(x==1)))
> DudleyPhenoL[1]

2

$benomyl

[1] "YLR085C" "YOR035C" "YPL241C" "YBR231C" "YPL129W" "YDR388W" "YER007W"
[8] "YDR120C" "YER083C" "YDR138W" "YHL020C" "YHR012W" "YOR139C" "YJL179W"
[15] "YDR195W" "YBL031W" "YNL148C" "YGL086W" "YJL030W" "YJR074W" "YDR028C"
[22] "YJR053W" "YLR447C" "YCR063W" "YNR052C" "YER110C" "YDL020C" "YGR162W"
[29] "YMR055C" "YLR399C" "YLR244C" "YLR338W" "YLR304C" "YDR532C"

2.2 Cellular organizational units

As previously mentioned, here we are interested in yeast datasets and the
yeast cellular organizational units deﬁned in the Bioconductor package ScISI
package and the KEGG pathways relevant to the yeast genome and available
in the YEAST annotation package. However our methods can easily be
applied to other species and other estimates of organizational units within
the genome, or proteome.

The cellular organizational units should be represented as an adjacency
matrix. The row names are the gene names and the column names the
cellular organizational units. A 1 means that this particular gene belongs
to this particular organizational units. Below is an example of yeast KEGG
pathways. The org.Sc.sgd.db annotation package contains KEGG pathways
annotation for the yeast genes and the PWAmat, available in the annotate
package, allows to build the adjacency matrix.

> library(org.Sc.sgd.db) ## new YEAST annotation package
> ##library(annotate)
> KeggMat <- PWAmat("org.Sc.sgd")
> KeggMat[1:5, 1:5]

YAL062W
YJL130C
YJR109C
YKL106W
YKL104C

00250 00330 00910 01100 00650
0
0
0
0
0

1
0
0
0
0

1
1
1
1
1

1
0
0
1
0

1
1
1
1
1

To build such interactome for a particular species, one should ﬁrst have
an annotation package for its species of interest. For instance, one can create
this annotation package using the Bioconductor package AnnBuilder which
retrieves, among other annotation, the KEGG pathways associated with
the genome of interest. For protein complexes, it might be slightly more
complicated but one can use the GO categories that refer to complexes and

3

create a similar binary matrix. In the case of the yeast genome, we use the
interactome available in the Bioconductor package ScISI.

The ScISI package or In Silico Interactome for Saccharomyces cere-
visiae provides an interactome built for computational experimentation.
The ScISI is binary incidence matrix where the rows are indexed by the
gene locus names and the columns are indexed by the identiﬁcation codes
for the protein complexes based on the repository from where they are ob-
tained. This interactome is currently built from the Intact, Gene Ontology
and Mips curated databases, and estimated protein complexes from the ap-
Complex package. In this vignette, we will make use of a subset of the ScISI
interactome, the ScISIC data, that only contains the data from the curated
databases.

> library(ScISI)
> data(ScISIC)
> ScISIC[1:5, 1:5]

EBI-913756
EBI-876785
EBI-852570
EBI-866976
EBI-1180400

EBI-913756 EBI-876785 EBI-852570 EBI-866976 EBI-1180400
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

0
0
0
0
0

3 Computational and Statistical Methods

In order to test for association between 2 datasets or 2 phenomenon, one
has to deﬁne a null hypothesis.
In our case, our null hypothesis is that
there is no association between the collection of genes that induce the phe-
notypic change and the organizational units (e.g., multi-protein complexes,
pathways). To test this hypothesis we consider a multi-faceted approach.

First, for any level of organization, we use a hypothesis test designed to
determine whether there is an eﬀect that can be attributed to that speciﬁc
groupings of genes, without testing which cellular organizational units are
involved. Then, if we reject the null hypothesis of no association between the
collection of genes that induce the phenotypic change and the organizational
units, the next step is to identify those speciﬁc organizational units.

4

3.1 Global testing

We currently have devised two diﬀerent methods of performing the om-
nibus test. One test is based on density estimation (Silverman, 1986) and
provides valuable visual information, but for which we do not have an ex-
plicit P -value. The second approach is based on the permutation of graphs
(Balasubramanian et al., 2004) and while it provides an explicit P -value, it
provides little insight into the reasons for rejecting, or not, the hypothesis.
See below for more details.

3.1.1 Density Estimation

For each cellular organizational unit, we compute the proportion of genes
that aﬀect the phenotype. We then compute the smoothed histogram of the
proportions and compare it to a reference distribution. Our reference dis-
tribution is obtained by randomly permuting 1,000 times the gene labels for
the interactome and computing, for each permutation, the new (simulated)
proportions of genes that aﬀects the phenotype and the associated smoothed
histograms.

As example, we test whether the genes sensitive to paraquat in the Dud-
ley et al. (2005) experiment are randomly distributed among multi-protein
complexes.

> perm <- 10
> paraquat <- DudleyPhenoL[["Paraq"]]
> parDensity <- densityEstimate(genename=paraquat, interactome=ScISIC, perm=perm)

Then, we can visualize the result of this test using the plot function.

3.1.2 Graph Theory

The graph theory procedure is based on the permutation of graphs pro-
posed by Balasubramanian et al. (2004). Two distinct graphs, Gi = (V, Ei),
i = 1, 2, are formed. The nodes, V , are in our case the S. cerevisiae genes,
and they are common to both graphs. In one graph G1 two proteins have
an edge between them if, and only if, they are co-members of one, or more,
cellular organizational units. In the second graph G2 edges are created be-
tween all proteins that are associated with a phenotype of interest, so that
if there are k genes associated with the phenotype of interest then there is
k(k − 1)/2 edges. We exclude self-loops in both graphs. We then compute

5

> plot(parDensity, main="Effect of paraquat on S. cerevisiae genes")

Figure 1: Genes sensitive to paraquat are not well represented in our in-
teractome. A high frequency of protein complexes have zero ”paraquat-sensitive”
genes. Grey lines represent the permutation data and the black line is the observed
data.

6

0.00.20.40.60.81.00102030Effect of paraquat on S. cerevisiae genesN = 418   Bandwidth = 0.02458Densitythe intersection of these two graphs and count the edges in common. To
test whether the number of edges in the third graph is unexpectedly large, a
permutation analysis is performed. A reference distribution is computed by
permuting n times the labels on either G1 or G2 and counting the number of
edges in common obtained. A p-value can be obtained by comparing the ob-
served test statistic to the observed distribution of the counts of intersecting
edges from the permutations.

> parGraph <- graphTheory(genename=paraquat, interactome=ScISIC, perm=perm)

Then, we can visualize the result of this test using the plot function.

> plot(parGraph, main="Effect of paraquat S. cerevisiae genes")

Figure 2: Genes sensitive to paraquat are not randomly distributed in our
interactome. The ”paraquat-sensitive” genes gather among complexes more than
expected by chance. the grey histogram represent the observed distributions and
the red dashed line the observed data.

7

Effect of paraquat S. cerevisiae genesEdgesFrequency020406080100120012343.2 Hypergeometric Test

A Hypergeometric test can be used to assess whether a cellular organiza-
tional unit contains more genes that aﬀect the phenotype than expected by
chance. We rank the multi-protein complexes by their p-value and classify
a complex as being associated with the phenotype if the Hypergeometric
p-value was less than a threshold, e.g., 0.01. The Hypergeometric test is
the equivalent of Fisher’s exact test for two-by-two tables and the function
repot the p-value, expected values and odds ratio for all tests.

> params <- new("CoHyperGParams",
geneIds=paraquat,
+
universeGeneIds=rownames(ScISIC),
+
annotation="org.Sc.sgd",
+
categoryName="ScISIC",
+
pvalueCutoff=0.01,
+
+
testDirection="over")
> paraquat.complex <- hyperGTest(params)

We can display the results using the summary function (Note that for

visualization purposes we only show the ﬁrst 6 columns).

> summary(paraquat.complex)[,1:6]

ID

Pvalue OddsRatio

1
MIPS-220 3.082381e-11 121.68750 0.15941296
2 GO:0016469 7.909231e-08 43.04444 0.25506073
3 GO:0000220 3.239645e-07 153.09804 0.07439271
4 GO:0000814 1.035862e-06
Inf 0.03188259
5 GO:0000221 5.605086e-05 65.00000 0.08502024
Inf 0.02125506
6 MIPS-90.30 1.076206e-04
7 GO:0000813 6.374648e-04 102.78947 0.04251012
8 GO:0000815 6.374648e-04 102.78947 0.04251012

ExpCount Count Size
15
24
7
3
8
2
4
4

7
6
4
3
3
2
2
2

Finally, you can classify the complexes as signiﬁcant or not and annotate

them if they are a GO, MIPS or KEGG term.

> status <- complexStatus(data=paraquat.complex,
+
+
> descr <- getDescr(status$A, database= c("GO","MIPS"))
> data.frame( descr,"pvalues"=paraquat.complex@pvalues[status$A])

phenotype=paraquat,
interactome=ScISIC, threshold=0.01)

8

MIPS-220
GO:0016469
GO:0000220
GO:0000814
GO:0000221
MIPS-90.30
GO:0000813
GO:0000815

descr

pvalues
H+-transporting ATPase, vacuolar 3.082381e-11
FALSE 7.909231e-08
FALSE 3.239645e-07
FALSE 1.035862e-06
FALSE 5.605086e-05
ER assembly complex 1.076206e-04
FALSE 6.374648e-04
FALSE 6.374648e-04

Those results are in concordance with the known eﬀect of paraquat on
H+-transporting. Indeed, the mechanisms of the toxic eﬀects of paraquat
are largely the result of a metabolically catalyzed single-electron reduction-
oxidation reaction, resulting in depletion of cellular NADPH and the gener-
ation of potentially toxic forms of oxygen such as the superoxide radical. It
also highlight the critical role of the ESCRT complexes (Endosomal Sorting
Complex Required for Transport).

4 Conclusion

This package oﬀers computational methods and statistical paradigms to ex-
plore the relationships between phenotype and cellular organizational units.
We demonstrated its usefulness in S. cerevisiae using Dudley et al. (2005)
dataset and multi-protein complexes. While this is one example, we believe
that those approaches are powerful enough to investigate many other pheno-
types and estimates of organizational units within the genome, or proteome.

References

R. Balakrishnan, K. R. Christie, M. C. Costanzo, et al. Saccharomyces

genome database. 2006. URL http://www.yeastgenome.org/.

R. Balasubramanian, T. LaFramboise, D. Scholtens, and R. Gentleman.
A graph-theoretic approach to testing associations between disparate
sources of functional genomics data. Bioinformatics, 20(18):3353–3362,
Dec 2004. doi: 10.1093/bioinformatics/bth405. URL http://dx.doi.
org/10.1093/bioinformatics/bth405.

A. M. Deutschbauer, D. F. Jaramillo, M. Proctor, et al. Mechanisms of
haploinsuﬃciency revealed by genome-wide proﬁling in yeast. Genetics,
169:1915–1925, 2005.

9

A. M. Dudley, D. M. Janse, A. Tanay, R. Shamir, and G. McDonald Church.
A global view of pleiotropy and phenotypically derived gene function in
yeast. Molecular Systems Biology, 1:E1–E11, 2005.

G. Giaever et al. Functional proﬁling of the saccharomyces cerevisiae
genome. Nature, 418(6896):387–391, Jul 2002. URL http://dx.doi.
org/10.1038/nature00935.

J.P. Kastenmayer, L. Ni, A. Chu, L.E. Kitchen, W.C. Au, H. Yang, C.D.
Carter, D. Wheeler, R.W. Davis, J.D. Boeke, M.A. Snyder, and M.A.
Basrai. Functional genomics of genes with small open reading frames
(sorfs) in s. cerevisiae. Genome Research, 16(3):365–373, 2006.

G. Lesage, J. Shapiro, C.A. Specht, A.M. Sdicu, P. Menard, S. Hussein,
A.H. Tong, C. Boone, and H. Bussey. An interactional network of genes
involved in chitin synthesis in saccharomyces cerevisiae. BMC Genet., 6
(1):1–8, 2005.

M. Osterberg, H. Kim, J. Warringer, K. Melen, A. Blomberg, and G. von
Heijne. Phenotypic eﬀects of membrane protein overexpression in saccha-
romyces cerevisiae. PNAS, 103(30):11148–53, 2006.

B. W. Silverman. Density Estimation for Statistics and Data Analysis.

Chapman and Hall, 1986.

V. Spirin, M.S. Gelfand, A.A. Mironov, and L.A. Mirny. A metabolic net-
work in the evolutionary context: multiscale structure and modularity.
PNAS, 23:8774–8779, 2006.

10

