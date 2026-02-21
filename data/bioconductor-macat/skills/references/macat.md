MACAT - MicroArray Chromosome Analysis Tool

Joern Toedling, Sebastian Schmeier,Matthias Heinig,
Benjamin Georgi, and Stefan Roepcke

Contents

1

1 Introduction

This project aims at linking the term diﬀerential gene expression to the chromosomal
localization of genes.
Microarray data analysts have deﬁned tumor subtypes by speciﬁc gene expression
proﬁles, consisting of genes that show diﬀerential expression between subtypes (see,
e.g., [?]). However, tumor subtypes have also been characterized by phenomena in-
volving large chromosomal regions. For instance, Christiansen et al. [?] report on a
subtype of acute myeloid leukemia, showing mutations in the AML1 gene on chromo-
some 21 along with deletions or loss of chromosome arm 7q. A natural approach to
bridging the gap between these two paradigms is to link scoring for diﬀerential gene
expression to the chromosomal localization of genes. Tumor subtypes can be deﬁned
by diﬀerential expression patterns aﬀecting sizeable regions of certain chromosomes.
In the following, we propose a statistical approach for identifying signiﬁcantly dif-
ferentially expressed regions on the chromosomes based on a regularized t-statistic
(see section ??). We address the problem of interpolating the scores between genes
by applying kernel functions (see section ??). In order to evaluate the signiﬁcance
of scores we conduct permutation experiments (section ??). An integral part of the
project is the visualization of the results in order to provide convenient access to the
statistical analysis without requiring a profound mathematical background (section
??).

The package is implemented in the R statistical programming language (www.r-
It requires functionalities provided by the Bioconductor package [?],
project.org).
which is a collection of R-libraries dealing with various aspects of the analysis of bio-
logical data including normalization, assessing background information on genes, and
visualization of data.
We apply our method on a publicly available data set of acute lymphoblastic leukemia
(ALL), described in [?]. This data set consists of 327 tumor samples subdivided into
10 classes. In order to investigate chromosomal phenomena deﬁning one tumor class,
we consider the expression levels of that class versus all the other subclasses.

2 Methods

2.1 Data Preprocessing

We assume normalized expression data, which can be provided already as a matrix
in R or in form of a delimited text ﬁle. In the preprocessing step the expression data
is integrated with gene location data for the given microarray into one common data
format. For this macat provides the preprocessedLoader or its convenience-wrapper
buildMACAT, which employ various Bioconductor [?] functions.
The resulting data format is a list containing:

(cid:136) Gene identiﬁer

2

(cid:136) Gene location (chromosome, strand, coordinate)

(cid:136) Sample labels, denoting for instance tumor (sub)types

(cid:136) Expression levels as a matrix

(cid:136) An identiﬁer for the type of microarray, used in the experiments

Currently macat is limited to commercial Aﬀymetrixﬁ oligonucleotide microarrays.

2.2 Scoring of Diﬀerential Gene Expression

For each gene we compute a statistic denoting the degree of diﬀerential expression
between two given groups of samples. In the context of the leukemia data set the two
groups of samples are given by one tumor class in the ﬁrst group and the remaining
nine classes forming the second. The statistic is the regularized t-score introduced in
[?]. This so-called relative diﬀerence is deﬁned as

d(i) =

xA(i) − xB(i)
s(i) + s0

where xA(i) and xB(i) are the mean expression levels of gene i in group A and B
respectively, s(i) is the pooled standard deviation of the expression values of gene i,
and s0 is constant for all genes. In essence, d(i) is Student’s t-statistic augmented by
a fudge factor s0 in the denominator, which is introduced to prevent a high statistic
for genes with a very low standard deviation s(i). We set s0 to the median over all
gene standard deviations s(i), analogous to [?].
Since the null-distribution of these regularized t-scores is conceptually diﬀerent from a
known t-distribution, we have to approximate it by random permutations (for details
see section ??).
However, macat also allows to compute Student’s classical t-statistic for each gene
and assess signiﬁcance based on the underlying t-distribution.

2.3 Smoothing Kernels

On each chromosome only a limited number of genes can be measured with a microar-
ray. The distance in base pairs between measured genes also varies greatly. Since we
want to compute diﬀerential expression statistics for larger chromosomal regions, we
need a method to interpolate scores between measured values. This interpolation,
however, does not aim to assign statistics to non-coding regions, but to provide a
smooth estimate of diﬀerential expression over large chromosomal regions.
Formally this can be seen as a regression problem, y = f (x), with y being the t-score
and x being one base pair position on the chromosome. (In the following, x will often
be called chromosomal coordinate.) Score yj is to be estimated for a large number
of coordinates xj, when f (x) is known only for few observations xi. Kernel methods
achieve smooth estimates of the function f (x) by ﬁtting diﬀerent models at each query

3

point x0 using only observations close to x0 [?].
Three diﬀerent kernel approaches will be discussed here:

(cid:136) k-Nearest Neighbor: For every chromosomal coordinate compute the average of

the k nearest genes.

(cid:136) Radial basis function (rbf): For every chromosomal coordinate compute the

average over all genes weighted by distance as explained in detail below.

(cid:136) Base-Pair-Distance Kernel: Similar to the k-Nearest-Neighbors, but using this
kernel the average is taken over all genes within a certain radius of the position,
whose value has to be determined.

The kernel approaches presented above can be expressed as weighted sums of scores.
Thus, we use a matrix multiplication as the basic framework for the computations,
where we multiply our score matrix with the so called kernel matrix.

Let E be the score matrix, with rows corresponding to n genes and columns corre-
sponding to m samples. For each gene g the chromosomal coordinate geneLocationg
is known. Further, let K be the kernel matrix. Let us assume that we want to inter-
polate the scores at s genomic locations that are stored in a vector we call (cid:126)s. So the
kernel matrix has the dimensions (n × s). One entry of K(g, l) represents the weight
that the gene g has at the location l. So the product

ET K = S

gives the smoothed matrix S of dimension (m × s), where one entry S(i, l) represents
the interpolation of the score of sample i at location (cid:126)sl.

The smoothed matrix S is the product of the score matrix E times the kernel matrix
K. The weights in K depend only on the location of the genes relative to the steps,
for which interpolated values are to be computed.
For the three kernels listed above the kernel functions are:

(cid:136) k-nearest neighbors

KkN N (k, g, l) =

(cid:26) 1 if g is one of the k nearest neighbors of l

0 else

(cid:136) radial basis function

Krbf (γ, g, l) = exp(−γ · (cid:107)geneLocationg − (cid:126)sl(cid:107)2)

(cid:136) base-pair distance

Kbpd(d, g, l) =

(cid:26) 1 if geneLocationg is within radius d of l

0 else

4

The free parameters (k, γ, d) of the kernel functions determine the degree of smooth-
ing. Take for instance the kNN kernel: the smaller k gets, the fewer genes are averaged
and in the extreme case interpolations take only the value of the next gene (k = 1).
In the case of the base-pair distance kernel with a very small distance d, you will
see spikes at the locations, where genes are located, and zero elsewhere. For very
large distances the smoothing will remove all spikes and the value for each position
is roughly the same.
More formally, kernel parameters deﬁne the width of the window, over which values
are used to estimate the regression function. Changing the window width is a bias-
variance tradeoﬀ situation. If the window around x0 is narrow, only a small number
of observations will be used to estimate f (x0). In this case the estimate will have
a relatively large variance but only a small bias. However, if the window is wide, a
large number of observations will be used for the estimate. This estimate tends to
show a low variance but comes with a high bias, since now observations xi far from
x0 are used as well and we still assume that f (xi) is close to f (x0) [?].
This shows that a good choice of the kernel parameters is very important. For the
three kernel functions presented above, we ﬁt the parameters from the data:

(cid:136) kNN: The number of genes on the chromosome is determined and k is set to

cover approximately 10% of the genes.

(cid:136) rbf: The width of the window is controlled by the parameter γ. We require that
for each position l, for which we interpolate the score, there should be at least
two genes within the window for averaging. If both of these genes are located
equally far from l, both will receive a weight of 1/2, thus resulting in a simple
average over these two genes’ scores. To allow for these weights, the maximal
gene distance (max) between any two neighboring genes on the chromosome
has to be determined. Then γ can be computed as:

γ =

ln 2
(max/2)2

(cid:136) base-pair distance: as with the rbf kernel, we require that the average is com-
puted at least over two genes. So the parameter d, which describes the radius,
within which genes are to be used to compute the average, is set to max, the
maximal gene distance between any two genes on the chromosome.

These biologically motivated heuristics for choosing the kernel parameters provide
good smoothing results on test data without any overﬁtting of estimated scores to
the observed values.
Nevertheless, we recommend to determine the optimal parameter settings by cross-
validation [?], for which macat provides the function evaluateParameters. Hereby,
one part of the genes is left out, the interpolation is computed based on the remain-
ing genes only, and the quality of interpolation is assessed by the residual sum of
squares between the scores of the left-out genes and their interpolated values. The
above mentioned biologically heuristics, by default, provide a starting point for a
grid-search over multiples of these parameter settings. The optimal parameter set-
ting is the one with the minimal residual sum of squares. For instance, in Figure ??,

5

the result of an evaluation of the parameter k from the k-nearest-neighbor kernel is
depicted. From this evaluation, the optimal k seems to be approximately 30.

Figure 1: Result plot for evaluating kNN parameter settings

2.4 Statistical Evaluation

To judge the signiﬁcance of diﬀerential gene expression, we propose to investigate
random permutations of the class labels. To obtain a reliable simulation of the em-
pirical distribution, we suggest to choose at least B ≥ 1000 permutations, preferably
more. For each of these permutations the (regularized) t-statistic is recomputed for
each gene. Thus, for each gene we obtain B permutation statistics and consequently
an empirical p-value, denoting the proportion of the B permutation statistics being
greater or equal than the actual statistic that is based on the true class labels. The
permutation statistics also provide upper and lower signiﬁcance borders, which are
smoothed using the same kernel function as for the original statistics.

6

050100150480490500510520530Cross−validation ResultskAverage Residual Sum−of−SquaresOptionally, to judge the signiﬁcance of diﬀerential expression over whole chromoso-
mal regions, one could instead investigate permutations of the ordering of genes on
chromosomes. For each of these permutations the smoothing of gene-speciﬁc scores
is recalculated. This way, one obtains a null-distribution for scores over chromosomal
regions. Given this null-distribution, it is possible to deﬁne conﬁdence intervals for
scores from random sample groupings and assess signiﬁcance of scores observed in a
relevant sample grouping.
However, the standard procedure in macat is to permute the class labels, which is
considerably faster and yields results that are easier to validate and interpret statis-
tically.
This approach is implemented in the macat-function evalScoring, which can be seen
as the core function of macat. See appendix ?? for an exemplary use of the function
and its arguments.
One important issue is that, when analyzing many chromosomes and classes, one
might obtain statistically signiﬁcant results by chance (multiple- testing problem). In
the given setting, classical procedures correcting for multiple testing, such as the Bon-
ferroni correction, cannot be applied. We advise the user to be aware of the problem
and to validate results by alternative methods.

2.5 Visualization

In order to facilitate a better understanding of both the data and the statistical
analysis, it is helpful to employ meaningful and concise visualizations. macat includes
plotting functionality for several questions of interest.

(cid:136) Plotting raw and kernelized expression levels versus coordinates of genes on one

chromosome.

(cid:136) Visualize raw and kernelized statistical scores versus coordinates of genes on

one chromosome.

(cid:136) Emphasis of interesting chromosomal regions with listing of relevant genes.

Chromosomal regions showing signiﬁcant diﬀerential expression can be visualized by
plotting the result of the evalScoring function (see ﬁgure ??). Hereby scores for
genes (black dots), the sliding average of the 0.025 and 0.975 quantiles of the permuted
scores (grey lines), the sliding average permuted scores (red line), and highlighted
regions (yellow dotted), where the score exceeds the quantiles, are plotted along one
chromosome. The yellow regions are deemed interesting, showing signiﬁcant over- or
under-expression according to the underlying statistic. The plot region ranges from
zero to the length of the respective chromosome.

One can generate an HTML-page (see ﬁgure ??) on-the-ﬂy by setting the argument
output in the function plot.MACATevalScoring to “html”. The generated HTML-
page provides information about genes located within the highlighted chromosomal
regions. For each gene some annotation, a click-able LocusID linked to the NCBI web
site, and the empirical p-value is provided.

7

Figure 2: Example plot of plot.MACATevalScoring

Figure 3: Example for a generated HTML-page

8

−20−10010ScoreClass T , Scores for Chromosome 60.0e+005.0e+071.0e+081.5e+08Coordinate3 Results

This section describes the results, we obtain from an exemplary analysis on “T- vs.
B-lymphocyte ALL”.
First the regularized t-score [?] is computed as described in section ??. To include
information about the distances between the genes, we used the radial basis kernel for
smoothing with the default parameters (see section ??). We have investigated regions
of chromosome six for signiﬁcant diﬀerential expression. Figure ?? shows that there
is a region on the p-arm of chromosome six that is signiﬁcantly under-expressed. The
genes within that region comprise also the well known MHC class II genes that are
known to be expressed by B-lymphocytes, but not by T-lymphocytes. Other genes
in this region remain to be investigated in more detail.
Apart from this region the data reveals no other signiﬁcant diﬀerences in gene ex-
pression between T- and B-lymphocyte ALL on chromosome six.

In table ??, we show a list of genes found to be located in signiﬁcantly diﬀeren-
tially expressed regions on diﬀerent chromosomes when analyzing diﬀerent subtypes
of leukemia versus all other subtypes.

4 Discussion and Outlook

As described in the previous section, applying our method, we detected a chromosomal
region as signiﬁcantly diﬀerentially expressed, which is in agreement with biological
knowledge of the two sample classes involved. This gives an indication that the chro-
mosomal regions annotated as being signiﬁcant by the method are indeed biologically
meaningful. Many of the genes found by MACAT (see table ??) are known oncogenes
or are at least associated with oncogenesis.

This ﬁts well with our expectation, since it appears reasonable that diﬀerent tumor
subtypes can be characterized on the molecular level by diﬀerent expression levels for
genes relevant to oncogenesis.

One point of interest for future research would be the application of macat on other
publicly available data sets and contrasting the results with relevant biological expert
knowledge to evaluate performance. This way, one could get an clearer impression of
the extend of possible applications.

Another point would be the exploration of diﬀerent approaches for obtaining relative
gene expression values for groups of samples. For instance one could use another
data set as a reference for samples with ”normal” gene expression levels (“normal”
denoting samples from patients with a tumor). Of course, due to the noisy nature of
microarray data, this approach would have to overcome some structural and technical
diﬃculties to make the measured expression levels comparable. Given that a suitable
data set could be found and the compatibility issues resolved, one could examine the
characteristic patterns of chromosomal phenomena in tumor subclasses as opposed to
normal tissue.

9

Class Chrom Cytoband LocusID OMIM Annotation
MLL

8q24.12

4609

8

”Alitalo et al. [?] found that the MYC gene,
which is involved by translocation in the gen-
eration of Burkitt lymphoma, is ampliﬁed, re-
sulting in homogeneously staining chromo-
somal regions (HSRs) in a human neuroen-
docrine tumor cell line derived from a colon
cancer. The HSR resided on a distorted X
chromosome; ampliﬁcation of MYC had been
accompanied by translocation of the gene
from its normal position on 8q24.”
”Mammalian SWI/SNF complexes are ATP-
dependent chromatin remodeling enzymes
that have been implicated in the regulation of
gene expression, cell cycle control, and onco-
genesis.”
” The suggested role for this protein is in tu-
morogenesis of renal cell carcinoma.”
”Mutations in this gene can be associated
with the development of Wilms tumors in the
kidney or with abnormalities of the genito-
urinary tract.”
”Wiemels et al.[?] sequenced the genomic fu-
sion between the PBX1 and E2A genes in 22
pre-B acute lymphoblastic leukemias and 2
[?] discussed the
cell lines. Kamps et al.
chimeric genes created by the human t(1;19)
translocation in pre-B-cell acute lymphoblas-
tic leukemias. The authors cloned 2 diﬀer-
ent E2A-PBX1 fusion transcripts and showed
that NIH-3T3 cells transfected with cDNAs
encoding the fusion proteins were able to
cause malignant tumors in nude mice.”
”By RT-PCR and Western blot analysis,
Sarkar et al.
[?] demonstrated that KANK
expression was suppressed in most renal tu-
mors and in kidney tumor cell lines due to
methylation at CpG sites in the gene.”

MLL

9

9p22.3

6595

MLL

9

9p24.3

23189

MLL

11

11p13

7490

E2A

1

1q23

5087

E2A

9

9p24.3

23189

Table 1: Example genes with OMIM annotation [?] detected by MACAT to be located
in diﬀerentially expressed regions. ’Class’ denotes the analyzed tumor subtype.

10

The method, which we have described, can detect signiﬁcant diﬀerential expression
for chromosomal regions. However, the reason for the diﬀerential expression, be it a
mutation, translocation, hypermethylation, loss of heterozygosity, or another event,
remains to be investigated.

Thus, results obtained by our method should be veriﬁed by suitable experiments.
One could think of a customized cDNA or oligo chip that contains all known genes,
including fusion-genes, stemming from translocation events, in the regions that were
found to be diﬀerentially expressed. To validate the borders of found regions, it would
be useful to also incorporate genes that neighbor found regions.

Other possibly useful experiments include Real-time PCR to measure the amount of
mRNA for one (or few) speciﬁc genes, comparing the results to measured expression
levels. The nature of the chromosomal event leading to the diﬀerential expression
can be investigated by methylation array experiments or by ﬂuorescence in situ hy-
bridization.

Nevertheless, we have shown that our method provides a solid baseline for gene-wise
experiments.

11

A Example Session

A.1 The Beginning

In this section, we show an example macat session. First of all, one has to include
the library and to load the data set provided in the data package stjudem.

> library(macat)
> loaddatapkg("stjudem")
> data(stjude)

We now have a data object called stjude.

A.2 First Investigation

Let us have a closer look on the data. The data is already in the right format. It has
been pre-processed by the function preprocessedLoader.

> summary(stjude)

geneName
geneLocation
chromosome
expr
labels
chip

Length Class Mode

12637 -none- character
12637 -none- numeric
12637 -none- character

4128375 -none- numeric

327 -none- character
1 -none- character

We can for example access the ﬁrst 10 gene names by typing

> stjude$geneName[1:10]

[1] "34916_s_at" "34917_at"
[6] "35219_at"

"34462_at"
"31641_s_at" "33300_at"

"163_at"
"33301_g_at" "38950_r_at"

"163_at"

The diﬀerent labels in the data set can be accessed by

> unique(stjude$labels)

[1] "BCR"
[6] "MLL"

"E2A"
"Normal"

"Hyperdip"
"Pseudodip" "T"

"Hyperdip47" "Hypodip"

"TEL"

12

> table(stjude$labels)

BCR
15
Pseudodip
29

E2A
27
T
43

Hyperdip Hyperdip47
23

64
TEL
79

Hypodip
9

MLL
20

Normal
18

There are ten diﬀerent classes of tumor patients. The next question is how many
probe sets are mapped to chromosome 1.

> sum(stjude$chromosome==1)

[1] 1255

Now for some visualization. We want to plot the sliding average of the expression
values from sample 3 along chromosome 6 with the default rbf-kernel (for details see
section ??).

> plotSliding(stjude, 6, sample=3, kernel=rbf)

Figure 4: Sliding Average of the expression values of chromosome 6 with rbf-kernel.

See the result in ﬁgure ??.

13

0.0e+005.0e+071.0e+081.5e+08012345Sliding AverageCoordinateExpressionA.3 Deeper Investigation

Next we investigate the data for chromosomal regions showing diﬀerential expression.
Again, we search chromosome 6 for some speciﬁc diﬀerences between T-lymphocyte
ALL (class ”T”) and B-lymphocyte ALL (all other classes). Take a look on section
?? (Scoring diﬀerential expression) for details on the score.
We want to use a kNN-kernel for interpolation between the scores. First, we determine
the optimal parameter settings, using the function evaluateParameters.

> evalkNN6 = evaluateParameters(stjude, class="T", chromosome=6, kernel=kNN,
+

paramMultipliers=c(0.01,seq(0.1,2.0,0.1),2.5))

Let’s have a look at the result:

> evalkNN6$best

$k
[1] 30

> plot(evalkNN6)

The result should look similar to Figure ??. According to this result, the optimal
parameter setting for the kNN kernel with our data seems to be k = 30. We use this
k for the search for signiﬁcantly diﬀerentially expressed chromosome regions. The
evalScoring is used to build a MACATevalScoring object. This may take some time
due to the number of permutations.

> e1 = evalScoring(stjude, class = "T", chromosome = 6, nperms = 1000,

kernel = kNN, kernelparams = evalkNN6$best, cross.validate= FALSE)

Investigating 43 samples of class T ...
Compute observed test statistics...
Building permutation matrix...
Compute 1000 permutation test statistics...
250 ...500 ...750 ...1000 ...
Compute empirical p-values...
Compute quantiles of empirical distributions...
Computing sliding values for scores...
Compute sliding values for permutations...
All done.

A.4 Collecting Results

Next, we use the plot function plot.MACATevalScoring to generate an HTML-page.
Therefore, we set the parameter output to ”html” (see section ??).

14

> plot(e1, output="html")

See the result in your web browser; it should look similar to Figure ??. Some anno-
tation of genes, which lie in the highlighted regions, is provided.

This ends our short example session. Have fun using macat!

15

Acknowledgments

The authors would like to thank Stefanie Scheid and Florian Markowetz for helpful
discussions and proof-reading, Claudio Lottaz for countless hints on building an R-
package, and Alexander Schliep, Rainer Spang, Eike Staub, and Martin Vingron for
setting up our knowledge and motivation for this project. Our special thanks go to
two reviewers, whose comments have led to great improvements of macat.

References

[1] E.J. Yeoh et al. Classiﬁcation, subtype discovery, and prediction of outcome
in pediatric acute lymphoblastic leukemia by gene expression proﬁling. Cancer
Cell, 1(2):133–143, March 2002.

[2] D. H. Christiansen, M. K. Andersen, and J. Pedersen-Bjergaard. Mutations
of AML1 are common in therapy-related myelodysplasia following therapy with
alkylating agents and are signiﬁcantly associated with deletion or loss of chromo-
some arm 7q and with subsequent leukemic transformation. Blood, 104(5):1474–
1481, 2004.

[3] Robert C. Gentleman, Vincent J. Carey, Douglas J. Bates, Benjamin M. Bol-
stad, Marcel Dettling, Sandrine Dudoit, Byron Ellis, Laurent Gautier, Yongchao
Ge, Jeﬀ Gentry, Kurt Hornik, Torsten Hothorn, Wolfgang Huber, Stefano Iacus,
Rafael Irizarry, Friedrich Leisch, Cheng Li, Martin Maechler, Anthony J. Rossini,
Guenther Sawitzki, Colin Smith, Gordon K. Smyth, Luke Tierney, Yee Hwa
Yang, , and Jianhua Zhang. Bioconductor: Open software development for com-
putational biology and bioinformatics. Genome Biology, 5:R80, 2004.

[4] V.G. Tusher, R. Tisbhirani, and G. Chu. Signiﬁcance analysis of microarrays
applied to ionizing radiation response. Proc. Nat. Acad. Sci., 98(9):5116–5121,
April 2001.

[5] R. Tibshirani et al. Diagnosis of multiple cancer types by shrunken centroids of

gene expression. Proc. Nat. Acad. Sci., 99(10):6567–6572, 2002.

[6] T. Hastie, R. Tibshirani, and J. Friedman The Elements of Statistical Learning.

Chapter 6. Springer Verlag, New York, 2001.

[7] T. Hastie, R. Tibshirani, and J. Friedman The Elements of Statistical Learning.

Chapter 7. Springer Verlag, New York, 2001.

[8] K. Alitalo, M. Schwab, C. Lin, H.E. Varmus, and J.M. Bishop. Homogeneously
staining chromosomal regions contain ampliﬁed copies of an abundantly ex-
pressed cellular oncogene (c-myc) in malignant neuroendocrine cells from a hu-
man colon carcinoma. Proc. Nat. Acad. Sci., 80:1707–1711, 1983.

[9] J. L. Wiemels, B. C. Leonard, Y. Wang, M. R. Segal, S. P. Hunger, M. T. Smith,
V. Crouse, X. Ma, P. A. Buﬄer, and S. R. Pine. Site-speciﬁc translocation and

16

evidence of postnatal origin of the t(1;19) e2a-pbx1 fusion in childhood acute
lymphoblastic leukemia. Proc. Nat. Acad. Sci., 99:15101–15106, 2002.

[10] M. P. Kamps, A. T. Look, and D. Baltimore. The human t(1:19) translocation
in pre-b all produces multiple nuclear e2a-pbx1 fusion proteins with diﬀering
transforming potentials. Genes Dev., 5:358–368, 1991.

[11] S. Sarkar, B. C. Roy, N. Hatano, T. Aoyagi, K. Gohji, and R. Kiyama. A novel
ankyrin repeat-containing gene (kank) located at 9p24 is a growth suppressor of
renal cell carcinoma. J. Biol. Chem., 277:36585–36591, 2002.

[12] V.A. McKusick. Mendelian Inheritance in Man. A Catalog of Human Genes and
Genetic Disorders. Johns Hopkins University Press, Baltimore, 12 edition, 1982.

17

