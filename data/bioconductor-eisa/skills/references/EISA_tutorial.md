The Iterative Signature Algorithm for Gene
Expression Data

G´abor Cs´ardi

October 30, 2018

Contents

1 Introduction

2 Preparing the data

2.1 Loading the data . . . . . . . . . . . . . . . . . . . . . . . . . . .

3 Simple ISA runs

4 Inspect the result

5 Enrichment calculations

5.1 Gene Ontology . . . . . . . . . . . . . . . . . . . . . . . . . . . .
5.1.1 Multiple testing correction . . . . . . . . . . . . . . . . . .

6 How ISA works

ISA iteration . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
6.1
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
6.2 Parameters
6.3 Random seeding and smart seeding . . . . . . . . . . . . . . . . .
6.4 Normalization . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . .
6.5 Gene and sample scores

7 Bicluster coherence and robustness measures

7.1 Coherence . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
7.2 Robustness

8 The isa2 and eisa packages

9 Finer control over ISA parameters

9.1 Non-speciﬁc ﬁltering . . . . . . . . . . . . . . . . . . . . . . . . .
9.2 Entrez Id matching . . . . . . . . . . . . . . . . . . . . . . . . . .
9.3 Normalizing the data . . . . . . . . . . . . . . . . . . . . . . . . .
9.4 Generating starting seeds for the ISA . . . . . . . . . . . . . . . .
9.5 Performing the ISA iteration . . . . . . . . . . . . . . . . . . . .

1

2

2
2

3

3

9
9
12

12
12
12
13
13
13

14
14
14

15

15
15
16
16
17
18

9.6 Dropping non-unique modules . . . . . . . . . . . . . . . . . . . .
9.7 Dropping non-robust modules . . . . . . . . . . . . . . . . . . . .

10 More information

11 Session information

1

Introduction

18
18

19

19

The Iterative Signature Algorithm (ISA) [Ihmels et al., 2002, Bergmann et al., 2003,
Ihmels et al., 2004] is a biclustering method. The input of a biclustering method
is a matrix and the output is a set of biclusters that fulﬁll some criteria. A bi-
cluster is a block of the potentially reordered input matrix.
Most commonly, biclustering algorithms are used on microarray expression
data, to ﬁnd gene sets that are coexpressed across a subset of the original
samples. In the ISA papers the biclusters are called transription modules
(TM), we will often refer them under this name in the following.
This tutorial speciﬁcally deals with the modular analysis of gene expression
data. Section 6 gives a short summary of how ISA works. If you need more
information of the underlying math or want to apply it to other data, then
please see the referenced papers, the vignette titled “The Iterative Signature
Algorithm” in the isa2 R package, or the ISA homepage at http://www.
unil.ch/cbg/homepage/software.html.

2 Preparing the data

2.1 Loading the data

First, we load the required packages and the data to analyze. ISA is imple-
mented in the eisa and isa2 packages, see Section 8 for a more elaborated
summary about the two packages. It is enough to load the eisa package, isa2
and other required packages are loaded automatically:

> library(eisa)

In this tutorial we will use the data in the ALL package.

> library(ALL)
> library(hgu95av2.db)
> data(ALL)

This is a data set from a clinical trial in acute lymphoblastic leukemia and it
contains 128 samples altogether.

2

3 Simple ISA runs

The simplest way to run ISA is to choose the two threshold parameters and
then call the ISA() function on the ExpressionSet object. The threshold pa-
rameters tune the size of the modules, less stringent (i.e. smaller) values result
bigger, less correlated modules. The optimal values depend on your data and
some experimentation is needed to determine them.
Since running ISA might take a couple of minutes and the results depend on
the random number generator used, the ISA run is commented out from the
next code block, and we just load a precomputed set of modules that is dis-
tributed with the eisa package.

> thr.gene <- 2.7
> thr.cond <- 1.4
> set.seed(1) # to get the same results, always
> # modules <- ISA(ALL, thr.gene=thr.gene, thr.cond=thr.cond)
> data(ALLModulesSmall)
> modules <- ALLModulesSmall

This ﬁrst applies a non-speciﬁc ﬁlter to the data set and then runs ISA from
100 random seeds (the default). See Section 9 if the default parameters are
not appropriate for you and need more control.

4

Inspect the result

The ISA() function returns an ISAModules object. By typing in its name we
can get a brief summary of the results:

> modules

An ISAModules instance.
Number of modules: 8
Number of features: 3522
Number of samples: 128
Gene threshold(s): 2.7
Conditions threshold(s): 1.4

There are various other ISAModules methods that help to access the modules
themselves and the ISA parameters that were used for the run.
Calling length() on modules returns the number of ISA modules in the set,
dim() gives the dimension of the input expression matrix: the number of fea-
tures (after the ﬁltering) and the number of samples:

> length(modules)

[1] 8

> dim(modules)

3

[1] 3522 128

Functions featureNames() and sampleNames() return the names of the fea-
tures and samples, just like the functions with the same name for an Expres-
sionSet:

> featureNames(modules)[1:5]

[1] "907_at"

"35430_at" "374_f_at" "33886_at" "34332_at"

> sampleNames(modules)[1:5]

[1] "01005" "01010" "03002" "04006" "04007"

The getNoFeatures() function returns a numeric vector, the number of fea-
tures (probesets in our case) in each module. Similarly, getNoSamples() re-
turns a numeric vector, the number of samples in each module. pData() re-
turns the phenotype data of the expression set as a data frame. The getOr-
ganism() function returns the scientiﬁc name of the organism under study,
annotation() the name of the chip. For the former the appropriate annota-
tion package must be installed.

> getNoFeatures(modules)

[1] 38 30 26 63 23 24 45 36

> getNoSamples(modules)

[1] 21 18 22 11 21 20 13 22

> colnames(pData(modules))

[1] "cod"
[4] "age"
[7] "CR"

[10] "t(9;22)"
[13] "mol.biol"
[16] "kinet"
[19] "transplant"

"sex"
"remission"
"t(4;11)"
"citog"

"diagnosis"
"BT"
"date.cr"
"cyto.normal"
"fusion protein" "mdr"
"ccr"
"f.u"

"relapse"
"date last seen"

> getOrganism(modules)

[1] "Homo sapiens"

> annotation(modules)

[1] "hgu95av2"

The double bracket indexing operator (‘[[’) can be used to select some mod-
ules from the complete set, the result is another, smaller ISAModules object.
The following selects the ﬁrst ﬁve modules.

4

> modules[[1:5]]

An ISAModules instance.
Number of modules: 5
Number of features: 3522
Number of samples: 128
Gene threshold(s): 2.7
Conditions threshold(s): 1.4

The single bracket indexing operator can be used to restrict an ISAModules
object to a subset of features and/or samples. E.g. selecting all features that
map to a gene on chromosome 1 can be done with

> chr <- get(paste(annotation(modules), sep="", "CHR"))
> chr1features <- sapply(mget(featureNames(modules), chr),
function(x) "1" %in% x)

> modules[chr1features,]

An ISAModules instance.
Number of modules: 8
Number of features: 332
Number of samples: 128
Gene threshold(s): 2.7
Conditions threshold(s): 1.4

Similarly, selecting all B-cell samples can be performed with

> modules[ ,grep("^B", pData(modules)$BT)]

An ISAModules instance.
Number of modules: 8
Number of features: 3522
Number of samples: 95
Gene threshold(s): 2.7
Conditions threshold(s): 1.4

getFeatureNames() lists the probesets (more precisely, the feature names
coming from the ExpressionSet object) in the modules. It returns a list, here
we just print the ﬁrst entry.

> getFeatureNames(modules)[[1]]

[1] "34332_at"
"39829_at"
[5] "34033_s_at" "39930_at"
"37497_at"
[9] "40688_at"
[13] "38096_f_at" "37039_at"
[17] "172_at"
[21] "38147_at"

"41348_at"
"40147_at"
"38067_at"
"41819_at"
"38833_at"
"37344_at"
"41723_s_at" "39248_at"
"32184_at"
"33039_at"

"2047_s_at" "33238_at"
"38750_at"
"38051_at"

5

"32794_g_at" "33121_g_at" "33369_at"
[25] "33705_at"
"633_s_at"
"32649_at"
"35839_at"
[29] "39709_at"
[33] "37759_at"
"39226_at"
"38319_at"
"33514_at"
[37] "1096_g_at" "35016_at"

The getSampleNames() function does the same for the samples. Again, the
sample names are taken from the ExpressionSet object that was passed to
ISA():

> getSampleNames(modules)[[1]]

[1] "01003" "01007" "04018" "09002" "12008" "15006" "16002"
[8] "16007" "19002" "19017" "24006" "26009" "28008" "28009"
[15] "37001" "43006" "44001" "49004" "56007" "64005" "65003"

ISA biclustering is not binary, every feature (and similarly, every sample) has
a score between -1 and 1; the further the score is from zero the stronger the
association between the feature (or sample) and the module. If two features
both have scores with the same sign, then they are correlated, if the sign of
their scores are opposite, then they are anti-correlated. You can query the
scores of the features with the getFeatureScores() function, and similarly,
the getSampleScores() function queries the sample scores. You can supply
the modules you want to query as an optional argument:

> getFeatureScores(modules, 3)

[[1]]

529_at

1292_at

36711_at

41233_at

40375_at

32833_at

40220_at

33849_at

1891_at
-0.9053170 -0.9327898 -0.8120785 -0.8507266 -0.8195864
36669_at
-0.7520874 -0.7887937 -0.8565162 0.7589608 -0.8510981
280_g_at 32901_s_at
-0.8675340 -0.7641193 -0.8338932 -0.8395013 -0.9076414
35372_r_at
37623_at
-0.8283072 -0.9081089 -0.8603682 -0.9134679 -0.8346154
40790_at
34304_s_at
-0.9245084 -0.8015006 -1.0000000 -0.8029958 -0.8685983

33146_at 39822_s_at

37187_at

39715_at

36674_at

39420_at

36979_at

40448_at

287_at

1237_at
-0.9964699

> getSampleScores(modules, 3)

[[1]]

03002

04008

04007

08001
-0.9606187 -0.6681491 -0.6835771 -1.0000000 -0.7404822
27004
-0.7130576 -0.6552245 -0.8367460 -0.8245874 0.5244274
28035

15001

04016

12026

24008

28021

28019

28023

12007

28003

6

0.4237176 0.5766343 0.5617935 0.4674956 0.4881987
19017
0.3756713 0.4524610 0.4401485 0.3822326 -0.9345939

28047

43012

28044

28037

28008

64005
0.4862616 -0.7058733

You can also query the scores in a matrix form, that is probably better if you
need many or all of them at the same time. The getFeatureMatrix() and
getSampleMatrix() functions are deﬁned for this. The probes/samples that
are not included in a module will have a zero score by deﬁnition.

> dim(getFeatureMatrix(modules))

[1] 3522

8

> dim(getSampleMatrix(modules))

[1] 128

8

Objects from the ISAModules class store various information about the ISA
run and the convergence of the seeds. Information associated with the indi-
vidual seeds can be queried with the seedData() function, it returns a data
frame, with as many rows as the number of seeds and various seed-level infor-
mation, e.g. the number of iterations required for the seed to converge. See
the manual page of ISA() for details.

> seedData(modules)

iterations oscillation thr.row thr.col freq
0
0
0
0
0
0
0
0

1.4
1.4
1.4
1.4
1.4
1.4
1.4
1.4

2.7
2.7
2.7
2.7
2.7
2.7
2.7
2.7

22
10
26
8
7
11
16
12

rob
1 21.98199
1 24.31987
1 23.77689
1 26.23544
1 22.47315
1 22.05568
1 23.97600
1 22.84282

1
2
3
11
61
62
63
99

rob.limit
21.98116
1
21.98116
2
21.98116
3
11 21.98116
61 21.98116
62 21.98116
63 21.98116
99 21.98116

The runData() function returns additional information about the ISA run,
see the ISA() manual page for details.

7

> runData(modules)

$direction
[1] "updown" "updown"

$eps
[1] 1e-04

$cor.limit
[1] 0.99

$maxiter
[1] 100

$N
[1] 100

$convergence
[1] "corx"

$prenormalize
[1] FALSE

$hasNA
[1] FALSE

$corx
[1] 3

$unique
[1] TRUE

$oscillation
[1] FALSE

$rob.perms
[1] 1

$annotation
[1] "hgu95av2"

$organism
[1] "Homo sapiens"

8

5 Enrichment calculations

The eisa package provides some functions to perform enrichment tests for the
gene sets corresponding to the ISA modules against various databases. These
tests are usually simpliﬁed and less sophisticated versions than the ones in the
Category, GOstats or topGO packages, but they are much faster and this is
important if we need to perform them for many modules.

5.1 Gene Ontology

To perform enrichment analysis against the Gene Ontology database, all you
have to do is to supply your ISAModules object to the ISAGO() function.

> GO <- ISAGO(modules)

The ISAGO() function requires the annotation package of the chip, e.g. for the
ALL data, the hgu95av2.db package is required.
The GO object is a list with three elements, these correspond to the GO on-
tologies, they are: biological function, cellular component and molecular func-
tion, in this order.

> GO

$BP
Gene to GO List BP test for over-representation
11754 GO List BP ids tested (0-56 have p < 0.05)
Selected gene set sizes: 21-56

Gene universe size: 3190
Annotation package: hgu95av2

$CC
Gene to GO List CC test for over-representation
1710 GO List CC ids tested (0-29 have p < 0.05)
Selected gene set sizes: 21-57

Gene universe size: 3238
Annotation package: hgu95av2

$MF
Gene to GO List MF test for over-representation
1798 GO List MF ids tested (0-15 have p < 0.05)
Selected gene set sizes: 20-56

Gene universe size: 3177
Annotation package: hgu95av2

We can see the number of categories tested, this is diﬀerent for each ontology,
as they have diﬀerent number of terms. The gene universe size is also diﬀer-
ent, because it contains only genes that have at least one annotation in the
given category.

9

For extracting the results themselves, the summary() function can be used,
this converts them to a simple data frame. A p-value limit can be supplied
to summary(). Note, that since ISAGO() calculates enrichment for many gene
sets (i.e. for all biclusters), summary() returns a list of data frames, one for
each bicluster. A table for the ﬁrst module:

> summary(GO$BP, p=0.001)[[1]][,-6]

GO:0050852 1.194888e-08 24.744000 0.8351097
GO:0050851 2.124101e-08 20.035141 1.1134796
GO:0002429 1.453922e-07 14.994698 1.5890282
GO:0002768 5.017594e-07 13.503197 1.7398119
GO:0002757 7.754747e-06 10.680818 2.1341693
GO:0050778 8.132119e-06 9.206086 2.9808777
GO:0002764 1.777776e-05 9.936455 2.2733542
GO:0002253 2.313492e-05 9.709677 2.3197492
GO:0002684 9.076700e-05 7.246828 4.0363636
GO:0002682 1.336313e-04 6.560386 5.2890282
GO:0050776 1.701595e-04 7.219111 3.6768025

Pvalue OddsRatio ExpCount Count Size
72
12
13
96
14 137
14 150
14 184
16 257
14 196
14 200
17 348
19 456
16 317

We omitted the sixth column of the result, because it is very wide and would
look bad in this vignette. This column is called drive and lists the Entrez IDs
of the genes that are in the intersection of the bicluster and the GO category;
or in other words, the genes that drive the enrichment. These genes can also
be obtained with the geneIdsByCategory() function. The following returns
the genes in the ﬁrst module and the third GO BP category. (The GO cate-
gories are ordered according to the enrichment p-values, just like in the output
of summary().)

> geneIdsByCategory(GO$BP)[[1]][[3]]

[1] "11027" "2533" "27040" "28639" "3113" "3115" "3122"
[8] "3635" "3932" "50852" "5142" "915"

"930"

"917"

You can use the GO.db package to obtain more information about the enriched
GO categories.

> sigCategories(GO$BP)[[1]]

[1] "GO:0050852" "GO:0050851" "GO:0002429" "GO:0002768"
[5] "GO:0002757" "GO:0050778" "GO:0002764" "GO:0002253"
[9] "GO:0002684" "GO:0002682" "GO:0050776" "GO:0048584"
[13] "GO:0006955" "GO:0002376" "GO:0002250" "GO:0007166"
[17] "GO:0046649"

> library(GO.db)
> mget(na.omit(sigCategories(GO$BP)[[1]][1:3]), GOTERM)

10

‘

‘

GO:0050852

$
GOID: GO:0050852
Term: T cell receptor signaling pathway
Ontology: BP
Definition: A series of molecular signals initiated

by the cross-linking of an antigen receptor on a
T cell.

Synonym: T lymphocyte receptor signaling pathway
Synonym: T lymphocyte receptor signalling pathway
Synonym: T-cell receptor signaling pathway
Synonym: T-cell receptor signalling pathway
Synonym: T-lymphocyte receptor signaling pathway
Synonym: T-lymphocyte receptor signalling pathway
Synonym: TCR signaling pathway

GO:0050851

$
GOID: GO:0050851
Term: antigen receptor-mediated signaling pathway
Ontology: BP
Definition: A series of molecular signals initiated

by the cross-linking of an antigen receptor on a
B or T cell.

Synonym: antigen receptor-mediated signalling pathway

‘

‘

‘

‘

GO:0002429

$
GOID: GO:0002429
Term: immune response-activating cell surface

receptor signaling pathway

Ontology: BP
Definition: A series of molecular signals initiated

by the binding of an extracellular ligand to a
receptor on the surface of a cell capable of
activating or perpetuating an immune response.

Synonym: activation of immune response by cell

surface receptor signaling pathway

Synonym: immune response-activating cell surface

receptor signalling pathway

In addition, the following functions are implemented to work on the objects
returned by ISAGO(): htmlReport(), pvalues(), geneCounts(), oddsRa-
tios(), expectedCounts(), universeCounts(), universeMappedCount(),
geneMappedCount(), geneIdUniverse(). These functions do essentially the
same as they counterparts for GOHyperGResult objects, see the documenta-
tion of the GOstats package. The only diﬀerence is, that since here we are
testing a list of gene sets (=biclusters), they calculate the results for all gene
sets and usually return lists.

11

5.1.1 Multiple testing correction

By default, the ISAGO() function performs multiple testing correction us-
ing the Holm method, this can be changed via the correction and correc-
tion.method arguments. See the manual page of the ISAGO() function for
details, and also the p.adjust() function for the possible multiple testing cor-
rection schemes.

6 How ISA works

6.1 ISA iteration

ISA works in an iterative way. For an E(m × n) input matrix it starts from
a seed vector r0, which is typically a sparse 0/1 vector of length m. The non-
zero elements in the seed vector deﬁne a set of genes in E. Then the trans-
posed of E, E(cid:48) is multiplied by r0 and the result is thresholded.
The thresholding is an important step of the ISA, without thresholding ISA
would be equivalent to a (not too eﬀective) numerical singular value decom-
position (SVD) algorithm. Currently thresholding is done by calculating the
mean and standard deviation of the vector and keeping only elements that
are further than a given number of standard deviations from the mean. Using
the “direction” parameter, one can keep values that are (a) signiﬁcantly higher
(“up”); (b) lower (“down”) than the mean; or (c) both (“updown”).
The thresholded vector c0 is the (sample) signature of r0. Then the (gene)
signature of c0 is calculated, E is multiplied by c0 and then thresholded to get
r1.
This iteration is performed until it converges, i.e. ri−1 and ri are close, and
ci−1 and ci are also close. The convergence criteria, i.e. what close means, is
by default deﬁned by high Pearson correlation.
It is very possible that the ISA ﬁnds the same module more than once; two or
more seeds might converge to the same module. The function ISAUnique()
eliminates every module from the result of ISAIterate() that is very similar
(in terms of Pearson correlation) to the one that was already found before.
It might be also apparent from the description of ISA, that the biclusters are
soft, i.e. they might have an overlap in their genes, samples, or both. It is also
possible that some genes and/or samples of the input matrix are not found to
be part of any ISA biclusters. Depending on the stringency parameters in the
thresholding (i.e. how far the values should be from the mean), it might even
happen that ISA does not ﬁnd any biclusters.

6.2 Parameters

The two main parameters of ISA are the two thresholds (one for the genes
and one for the samples). They basically deﬁne the stringency of the modules.
If the gene threshold is high, then the modules will have very similar genes.
If it is mild, then modules will be bigger, with less similar genes than in the

12

ﬁrst case. The same applies to the sample threshold and the samples of the
modules.

6.3 Random seeding and smart seeding

By default (i.e. if the ISA() function is used) the ISA is performed from ran-
dom sparse starting seeds, generated by the generate.seeds() function. This
way the algorithm is completely unsupervised, but also stochastic: it might
give diﬀerent results for diﬀerent runs.
It is possible to use non-random seeds as well. If you have some knowledge
about the data or are interested in a particular subset of genes/samples, then
you can feed in your seeds into the ISAIterate() function directly. In this
case the algorithm is deterministic, for the same seed you will always get the
same results. Using smart (i.e. non-random) seeds can be considered as a
semi-supervised approach. We show an example of using smart seeds in Sec-
tion 9.

6.4 Normalization

Using in silico data we observed that ISA has the best performance if the in-
put matrix is normalized (see ISANormalize()). The normalization produces
two matrices: Er and Ec. Er is calculated by transposing E and centering
and scaling its expression values for each sample (see the scale() R func-
tion). Ec is calculated by centering and scaling the genes of E. Er is used to
calculate the sample signature of genes and Ec is used to calculate the gene
signature of the samples.
It is possible to use another normalization, or not to use normalization at all;
the user has to construct an ISAExpressionSet object containing the three
matrices corresponding to the raw data, the gene-wise normalized data and
the sample-wise normalized data. This object can be passed to the ISAIter-
ate() function. The matrices are not required to be diﬀerent, the user can
supply the raw data matrix three times, if desired.

6.5 Gene and sample scores

In addition to ﬁnding biclusters in the input matrix, the ISA also assigns
scores to the genes and samples, separately for each module. The scores are
between minus one and one and they are by deﬁnition zero for the genes/samples
that are not included in the module. For the non-zero entries, the further the
score of a gene/samples is from zero, the stronger the association between
the gene/sample and the module. If the signs of two genes/samples are the
same, then they are correlated, if they have opposite signs, then they are anti-
correlated.

13

7 Bicluster coherence and robustness measures

7.1 Coherence

Madeira and Oliviera[Madeira and Oliveira, 2004] deﬁne various coherence
scores for biclusters, these measure how well the rows and or columns are cor-
related. It is possible to use these measures for ISA as well, after converting
the output of ISA to a biclust object. We use the Bc object that was created
in Section ??. Here are the measures for the ﬁrst bicluster:

> library(biclust)
> Bc <- as(modules, "Biclust")
> constantVariance(exprs(ALL), Bc, number=1)

[1] 4.041903

> additiveVariance(exprs(ALL), Bc, number=1)

[1] 2.055509

> multiplicativeVariance(exprs(ALL), Bc, number=1)

[1] 0.3876909

> signVariance(exprs(ALL), Bc, number=1)

[1] 2.611917

You can use sapply() to perform the calculation for many or all modules, e.g.
for this data set ‘constant variance’ and ‘additive variance’ are not the same:

> cv <- sapply(seq_len(Bc@Number),

function(x) constantVariance(exprs(ALL), Bc, number=x))

> av <- sapply(seq_len(Bc@Number),

function(x) additiveVariance(exprs(ALL), Bc, number=x))

> cor(av, cv)

[1] 0.3582246

Please see the manual pages of these functions and the paper cited above for
more details.

7.2 Robustness

The eisa package uses a measure that is related to coherence; it is called ro-
bustness. Robustness is a generalization of the singular value of a matrix. If
there were no thresholding during the ISA iteration, then ISA would be equiv-
alent to a numerical method for singular value decomposition and robustness
would be the same the principal singular value of the input matrix.

14

If the ISA() function was used to ﬁnd the transcription modules, then the ro-
bustness measure is used automatically to ﬁlter the results. This is done by
ﬁrst scrambling the input matrix and then running ISA on it. As ISA is an
unsupervised algorithm it usually ﬁnds some (although less and smaller) mod-
ules even in such a scrambled data set. Then the robustness scores are calcu-
lated for the proper and the scrambled modules and only (proper) modules
that have a higher score than the highest scrambled module are kept. The
robustness scores are stored in the seed data during this process, so you can
check them later:

> seedData(modules)$rob

[1] 21.98199 24.31987 23.77689 26.23544 22.47315 22.05568
[7] 23.97600 22.84282

8 The isa2 and eisa packages

ISA and its companion functions for visualization, functional enrichment cal-
culation, etc. are distributed in two separate R packages, isa2 and eisa.
isa2 contains the implementation of ISA itself, and eisa speciﬁcally deals
with supplying expression data to isa2 and visualizing the results.
If you analyze gene expression data, then we suggest using the interface pro-
vided in the eisa package. For other data, use the isa2 package directly.

9 Finer control over ISA parameters

The ISA() function takes care of all steps performed in a modular study, and
for each step it uses parameters, that work reasonably well. In some cases,
however, one wants to access these steps individually, to use custom parame-
ters instead of the defaults.
In this section, we will still use the acute lymphoblastic leukemia gene expres-
sion data from the ALL package.

9.1 Non-speciﬁc ﬁltering

The ﬁrst step of the analysis typically involves non-speciﬁc ﬁltering of the
probesets. The aim is to eliminate the probesets that do not show variation
across the samples, as they only contribute noise to the data.
By default (i.e. if the ISA() function is called) this is performed using the
genefilter package, and the default ﬁlter is based on the inter-quantile ra-
tio of the probesets’ expression values, a robust measure of variance.
If other ﬁlters are desired, then these can be implemented by using the func-
tions of the genefilter package directly. Possible ﬁltering techniques include
using the AﬀyMetrix present/absent calls produced by the mas5calls() func-
tion of the affy package, but this requires the raw data, so in this vignette we

15

use a simple method based on variance and minimum expression value: only
probesets that have a variance of at least varLimit and that have at least
kLimit samples with expression values over ALimit are kept.

> library(genefilter)
> varLimit <- 0.5
> kLimit <- 4
> ALimit <- 5
> flist <- filterfun(function(x) var(x)>varLimit, kOverA(kLimit,ALimit))
> ALL.filt <- ALL[genefilter(ALL, flist), ]

The original expression set had 12625 features, the ﬁltered one has only 1313.

9.2 Entrez Id matching

In this step we match the probesets to Entrez identiﬁers and remove the ones
that don’t map to any Entrez gene.

> ann <- annotation(ALL.filt)
> library(paste(ann, sep=".", "db"), character.only=TRUE)
> ENTREZ <- get( paste(ann, sep="", "ENTREZID") )
> EntrezIds <- mget(featureNames(ALL.filt), ENTREZ)
> keep <- sapply(EntrezIds, function(x) length(x) >= 1 && !is.na(x))
> ALL.filt.2 <- ALL.filt[keep,]

To reduce ambiguity in the interpretation of the results, we might also want
to keep only single probeset for each Entrez gene. The following code snipplet
keeps the probeset with the highest variance.

> vari <- apply(exprs(ALL.filt.2), 1, var)
> larg <- findLargest(featureNames(ALL.filt.2), vari, data=annotation(ALL.filt.2))
> ALL.filt.3 <- ALL.filt.2[larg,]

9.3 Normalizing the data

The ISA works best, if the expression matrix is scaled and centered. In fact,
the two sub-steps of an ISA step require expression matrices that are nor-
malized diﬀerently. The ISANormalize() function can be used to calculate
the normalized expression matrices; it returns an ISAExpressionSet object.
This is a subclass of ExpressionSet, and contains three expression matrices:
the original raw expression, the row-wise (=gene-wise) normalized and the
column-wise (=sample-wise) normalized expression matrix. The normalized
expression matrices can be queried with the featExprs() and sampExprs()
functions.

> ALL.normed <- ISANormalize(ALL.filt.3)
> ls(assayData(ALL.normed))

[1] "ec.exprs" "er.exprs" "exprs"

16

> dim(featExprs(ALL.normed))

[1] 1080 128

> dim(sampExprs(ALL.normed))

[1] 1080 128

9.4 Generating starting seeds for the ISA

The ISA is an iterative algorithm that starts with a set of input seeds. An
input seed is basically a set of probesets and the ISA stepwise reﬁnes this set
by 1) including other probesets in the set that are coexpressed with the input
probesets and 2) removing probesets from it that are not coexpressed with the
rest of the input set.
The generate.seeds() function generates a set of random seeds (i.e. a set of
random gene sets). See its documentation if you need to change the sparsity
of the seeds.

> set.seed(3)
> random.seeds <- generate.seeds(length=nrow(ALL.normed), count=100)

In addition to random seeds, it is possible to start the ISA iteration from
“educated” seeds, i.e. gene sets the user is interested in, or a set of samples
that are supposed to have coexpressed genes. We create another set of start-
ing seeds here, based on the type of acute lymphoblastic leukemia: “B”, “B1”,
“B2”, “B3”, “B4” or “T”, “T1”, “T2”, “T3” and “T4”.

> type <- as.character(pData(ALL.normed)$BT)
> ss1 <- ifelse(grepl("^B", type), -1, 1)
> ss2 <- ifelse(grepl("^B1", type), 1, 0)
> ss3 <- ifelse(grepl("^B2", type), 1, 0)
> ss4 <- ifelse(grepl("^B3", type), 1, 0)
> ss5 <- ifelse(grepl("^B4", type), 1, 0)
> ss6 <- ifelse(grepl("^T1", type), 1, 0)
> ss7 <- ifelse(grepl("^T2", type), 1, 0)
> ss8 <- ifelse(grepl("^T3", type), 1, 0)
> ss9 <- ifelse(grepl("^T4", type), 1, 0)
> smart.seeds <- cbind(ss1, ss2, ss3, ss4, ss5, ss6, ss7, ss8, ss9)

The ss1 seed includes all samples, but their sign is opposite for B-cell leukemia
samples and T-cell samples. This way ISA is looking for sets of genes that
are diﬀerently regulated in these two groups of samples. ss2 contains only B1
type samples, so here we look for genes that are speciﬁc to this variant of the
disease. The other seeds are similar, for the other subtypes.

17

9.5 Performing the ISA iteration

We perform the ISA iterations for our two sets of seeds separately. The two
threshold parameters we use here were chosen after some experimentation;
these result modules of the “right” size.

> modules1 <- ISAIterate(ALL.normed, feature.seeds=random.seeds,

thr.feat=1.5, thr.samp=1.8, convergence="cor")

> modules2 <- ISAIterate(ALL.normed, sample.seeds=smart.seeds,

thr.feat=1.5, thr.samp=1.8, convergence="cor")

9.6 Dropping non-unique modules

ISAIterate() returns the same number of modules as the number of input
seeds; these are, however, not always meaningful, the input seeds can converge
to an all-zero vector, or occasionally they may not converge at all. It is also
possible that two or more input seeds converge to the same module.
The ISAUnique() function eliminates the all-zero or non-convergent input
seeds and keeps only one instance of the duplicated ones.

> modules1.unique <- ISAUnique(ALL.normed, modules1)
> modules2.unique <- ISAUnique(ALL.normed, modules2)
> length(modules1.unique)

[1] 29

> length(modules2.unique)

[1] 5

29 modules were kept for the ﬁrst set of seeds and 5 for the second set.

9.7 Dropping non-robust modules

The ISAFilterRobust() function ﬁlters a set of modules by running ISA with
the same parameters on the scrambled data set and then calculating a robust-
ness score, both for the real modules and the ones from the scrambled data.
The highest robustness score obtained from the scrambled data is used as a
threshold to ﬁlter the real modules.

> modules1.robust <- ISAFilterRobust(ALL.normed, modules1.unique)
> modules2.robust <- ISAFilterRobust(ALL.normed, modules2.unique)
> length(modules1.robust)

[1] 18

> length(modules2.robust)

[1] 5

We still have 18 modules for the ﬁrst set of seeds and 5 for the second set.

18

10 More information

For more information about the ISA, please see the references below. The ISA
homepage at http://www.unil.ch/cbg/homepage/software.html has exam-
ple data sets, and all ISA related tutorials and papers.

11 Session information

The version number of R and packages loaded for generating this vignette
were:

(cid:136) R version 3.5.1 Patched (2018-07-12 r74967), x86_64-pc-linux-gnu

(cid:136) Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_US.UTF-8,
LC_COLLATE=C, LC_MONETARY=en_US.UTF-8, LC_MESSAGES=en_US.UTF-8,
LC_PAPER=en_US.UTF-8, LC_NAME=C, LC_ADDRESS=C, LC_TELEPHONE=C,
LC_MEASUREMENT=en_US.UTF-8, LC_IDENTIFICATION=C

(cid:136) Running under: Ubuntu 16.04.5 LTS

(cid:136) Matrix products: default

(cid:136) BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so

(cid:136) LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so

(cid:136) Base packages: base, datasets, grDevices, graphics, grid, methods,

parallel, stats, stats4, utils

(cid:136) Other packages: ALL 1.23.0, AnnotationDbi 1.44.0, Biobase 2.42.0,
BiocGenerics 0.28.0, GO.db 3.7.0, IRanges 2.16.0, MASS 7.3-51,
S4Vectors 0.20.0, biclust 2.0.1, colorspace 1.3-2, eisa 1.34.0,
geneﬁlter 1.64.0, hgu95av2.db 3.2.3, isa2 0.3.5, lattice 0.20-35,
org.Hs.eg.db 3.7.0

(cid:136) Loaded via a namespace (and not attached): Category 2.48.0, DBI 1.0.0,

GSEABase 1.44.0, Matrix 1.2-14, R6 2.3.0, RBGL 1.58.0,
RCurl 1.95-4.11, RSQLite 2.1.1, Rcpp 0.12.19, XML 3.98-1.16,
additivityTests 1.1-4, annotate 1.60.0, assertthat 0.2.0, bindr 0.1.1,
bindrcpp 0.2.2, bit 1.1-14, bit64 0.9-7, bitops 1.0-6, blob 1.1.1,
class 7.3-14, compiler 3.5.1, crayon 1.3.4, digest 0.6.18, dplyr 0.7.7,
ﬂexclust 1.4-0, ggplot2 3.1.0, glue 1.3.0, graph 1.60.0, gtable 0.2.0,
lazyeval 0.2.1, magrittr 1.5, memoise 1.1.0, modeltools 0.2-22,
munsell 0.5.0, pillar 1.3.0, pkgconﬁg 2.0.2, plyr 1.8.4, purrr 0.2.5,
rlang 0.3.0.1, scales 1.0.0, splines 3.5.1, survival 2.43-1, tibble 1.4.2,
tidyr 0.8.2, tidyselect 0.2.5, tools 3.5.1, xtable 1.8-3

19

References

[Bergmann et al., 2003] Bergmann, S., Ihmels, J., and Barkai, N. (2003). It-
erative signature algorithm for the analysis of large-scale gene expression
data. Phys Rev E Nonlin Soft Matter Phys, page 031902.

[Ihmels et al., 2004] Ihmels, J., Bergmann, S., and Barkai, N. (2004). Deﬁning
transcription modules using large-scale gene expression data. Bioinformat-
ics, pages 1993–2003.

[Ihmels et al., 2002] Ihmels, J., Friedlander, G., Bergmann, S., Sarig, O., Ziv,
Y., and Barkai, N. (2002). Revealing modular organization in the yeast
transcriptional network. Nat Genet, pages 370–377.

[Madeira and Oliveira, 2004] Madeira, S. and Oliveira, A. (2004). Biclustering
algorithms for biological data analysis: a survey. IEEE/ACM Transactions
on Computational Biology and Bioinformatics, 1:24–45.

20

