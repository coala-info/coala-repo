TDARACNE

P. Zoppoli, S. Morganella, M. Ceccarelli

Contents

1 Overview

2 Data Description

3 main function

4 Output File Format

1 Overview

1

3

3

4

This document describes classes and functions of TD-ARACNE (TimeDelay
ARACNE) package.
One of main aims of Molecular Biology is the gain of knowledge about how
molecular components interact each other and to understand gene function
regulations. Using microarray technology, it is possible to extract measure-
ments of thousands of genes into a single analysis step having a picture of
the cell gene expression. Several methods have been developed to infer gene
networks from steady-state data, much less literature is produced about time-
course data, so the development of algorithms to infer gene networks from
time-series measurements is a current challenge into bioinformatics research
area. In order to detect dependencies between genes at diﬀerent time delays,
we propose an approach to infer gene regulatory networks from time-series
measurements starting from a well known algorithm based on information
theory.
We have shown [6] how the ARACNE (Algorithm for the Reconstruction of
Accurate Cellular Networks) algorithm [5] can be used for gene regulatory

1

network inference in the case of time-course expression proﬁles. The resulting
method is called TimeDelay-ARACNE. It just tries to extract dependencies
between two genes at diﬀerent time delays, providing a measure of these de-
pendencies in terms of mutual information. The basic idea of the proposed
algorithm is to detect time-delayed dependencies between the expression pro-
ﬁles by assuming as underlying probabilistic model a stationary Markov Ran-
dom Field. Less informative dependencies are ﬁltered out using an auto cal-
culated threshold, retaining most reliable connections. TimeDelay-ARACNE
can infer small local networks of time regulated gene-gene interactions de-
tecting their versus and also discovering cyclic interactions also when only a
medium-small number of measurements are available.
The idea on which TimeDelay-ARACNE is based comes from the consider-
ation that the expression of a gene at a certain time could depend by the
expression level of another gene at previous time point or at very few time
points before. TimeDelay-ARACNE is a three-steps algorithm: ﬁrst it de-
tects, for all genes, the time point of the initial changes in the expression,
secondly there is network construction and ﬁnally a network pruning step.
The goal of TimeDelay-ARACNE is to recover gene time dependencies from
time-course data producing oriented graph. To do this we introduce time Mu-
tual Information and Inﬂuence concepts. First tests on synthetic networks
and on yeast cell cycle, SOS pathway data and IRMA give good results but
many other tests should be made. Particular attention is to be made to
the data normalization step because the lack of a rule. According to the
little performance loss linked to the increasing gene numbers shown in [6],
next developmental step will be the extension from little-medium networks
to medium networks.
TD-ARACNE algorithm given time-course gene expression values allows to
obtain an oriented graph representing a gene regulatory network. The goal of
this package is to create a tool useful to gene regulation’s researchers in order
to obtain a ﬁrst unvalidated look at the regulatory network. The package
makes use of the GenKern [4] package to compute the kernel, the Biobase
package [2] and the Rgraphviz package [3]. The functions in the package will
work on numeric data organized in a matrix. The results of these procedures
will change slightly depending on normalization choice and the number of the
classes in the discretization step. The example data included in the package
are used in [6]

2

2 Data Description

Input data is an ExpressionSet object. An example can be a dataset down-
loaded from GEO or ArrayExpress converted in an ExpressionSet object . In
the TDARACNE package you can found 3 example datasets. The ﬁrst one
is the Yeast dataset, a time course proﬁle made by a set of 11 genes, part of
the G1 step of yeast cell cycle, selected from the widely used yeast, Saccha-
romyces cerevisiae, previously published by [8] for which 16 time points are
available. The data can be loaded as follows:

> data(dataYeast)
> data(threshYeast)

The second dataset is made by the time course proﬁles for a set of 8 genes,
part of the SOS pathway of E. coli [7] from which the ﬁrst 14 points (exclud-
ing the ﬁrst point of the data which is zero) are used.

> data(dataSOSmean)
> data(threshSOSmean)

The third one is a 5 genes sets of time course proﬁles provided by real-time
PCR from an in vivo yeast synthetic network [1]. The Switch ON data set,
is the result of the time measurements, every 20 minutes for 5 hours, of the
mRNA concentration after shifting cells from glucose to galactose, for a total
of 5 proﬁles of 16 points.

> data(dataIRMAon)
> data(threshIRMAon)

3 main function

The main function is: TDARACNE(z, N, name, delta , likehood, norm,
logarithm, thresh, ksd, tolerance) Here follow a brief description of the argu-
ments: arguments eSet: eSet is the ExpressionSet object
N: N is respectively the number of bins in percentile normalization or in rank

normalization

delta: delta is the maximum time delay allowed to infer connections
likehood: likehood is the fold change used as threshold to state the initial

change expression (IcE)

3

norm: normalization;

if you want column percentile normalization (row normalization) put
norm == 1;
if you want Rank normalization put norm == 2;

logarithm: if z is log put logarithm == 0;
thresh: the Inﬂuence threshold.

if you have a threshold and a SD( standard deviation) put them here
in this format: c(thresh,SD);
if you don’t have threshold put 0 in thresh;

ksd: ksd is the standard deviation multiplier;
tolerance: tolerance is the DPI tolerance;

0 means no tolerance;
1 means no DPI;
0.15 is the default ARACNE tolerance as it is for TDARACNE;

plot: plot must be TRUE to obtain automatically the graph
dot: dot must be TRUE to obtain a .dot ﬁle
name: the name of the .dot ﬁle resulting in the end
adj: adj must be TRUE to obtain an adjacent matrix

TDARACNE() automatically load the libraries that needs but it requires
them installed when TDARACNE() starts. An example using the embedded
dataset is:

> TDARACNE(dataIRMAon,11,"netIRMAon",delta=3,likehood=1.2,norm=2,logarithm=1,thresh=threshIRMAon,ksd=0,0.15);

To obtain all the results published in the paper [6] you can use (attention is
time consuming):

> TDARACNEdataPublished()

4 Output File Format

At the end of the computation TDARACNE() returns a graphNEL object,
an adjacent matrix, a graph or a .dot ﬁle according to the parameter selected.
By default it returns a graphNEL object.

4

References

[1] I. Cantone, L. Marucci, F. Iorio, M.A. Ricci, V. Belcastro, M. Bansal,
S. Santini, M. di Bernardo, D. di Bernardo, and M.P. Cosma. A Yeast
Synthetic Network for In Vivo Assessment of Reverse-Engineering and
Modeling Approaches. Cell, 2009.

[2] Robert C Gentleman, Vincent J. Carey, Douglas M. Bates, et al. Bio-
conductor: Open software development for computational biology and
bioinformatics. Genome Biology, 5:R80, 2004.

[3] Jeﬀ Gentry, Li Long, Robert Gentleman, Seth Falcon, Florian Hahne,
Deepayan Sarkar, and Kasper Hansen. Rgraphviz: Provides plotting ca-
pabilities for R graph objects. R package version 1.26.0.

[4] David Lucy and Robert Aykroyd. GenKern: Functions for generating and
manipulating binned kernel density estimates, 2010. R package version
1.1-10.

[5] A A Margolin, I Nemenman, K Basso, C Wiggins, G Stolovitzky,
R Dalla Favera, and A Califano. Aracne: an algorithm for the recon-
struction of gene regulatory networks in a mammalian cellular context.
BMC Bioinformatics, 7(Suppl I):S7, March 2006.

[6] M. Ceccarelli P. Zoppoli, S. Morganella. Timedelay-aracne: Reverse en-
gineering of gene networks from time-course data by an information the-
oretic approach. BMC Bioinformatics, 2010.

[7] M Ronen, R Rosenberg, B I Shraiman, and U Alon. Assigning numbers
to the arrows: Parameterizing a gene regulation network by using accu-
rate expression kinetics. Proc Natl Acad Sci U S A, 99(16):10555–10560,
August 2002.

[8] P T Spellman, G Sherlock, M Q Zhang, V R Iyer, K Anders, M B Eisen,
P O Brown, D Botsein, and B Futcher. Comprehensive identiﬁcation of
cell cycle-regulated genes of the yeast saccharomyces cerevisiae by mi-
croarray hybridization. Molecular Biology of the Cell, 9(12):3273–3297,
December 1998.

5

