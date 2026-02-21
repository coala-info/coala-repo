Bioconductor’s Trigger package

Lin Chen, Dipen Sangurdekar, and John D. Storey‡
‡Email: jstorey@princeton.edu

October 30, 2017

Contents

1 Overview

2 A yeast data set

3 Genome-wide eQTL analysis

4 Multi-locus linkage (epistasis) analysis

5 Proportion of genome-wide variation captured by each eQTL

6 Network-Trigger analysis

7 Visualize directed network from estimated regulatory probability matrix

8 Trait-Trigger analysis

1 Overview

1

2

3

4

5

6

8

9

The trigger package guides an integrative genomic analysis. Integrative genomic data usually con-
sists of genomic information from various sources, which includes genetic information (genotype),
high-dimensional intermediate traits in the genome (e.g., gene expression, protein abundance)
and/or higher-order traits (phenotypes) for an organism.
In the following examples, we mainly
discuss intermediate traits of gene expression. It should be noted that this package can also be
applied to protein abundance and/or other continuous trait expression.

The package contains functions to: (1) construct global linkage map between genetic marker and
gene expression; (2) analyze multiple-locus linkage (epistasis) for gene expression; (3) quantify the
proportion of genome-wide variation explained by each locus and identify eQTL linkage hotspots;
(4) estimate pair-wise causal gene regulatory probability and construct gene regulatory networks;
and (5) identify causal genes for a quantitative trait of interest.

This document provides a tutorial for using the trigger package. The package contains the fol-
lowing functions:

(cid:136) trigger.build: Format the input data

(cid:136) trigger.link: Genome-wide eQTL analysis

1

(cid:136) trigger.mlink: Multi-locus linkage (epistasis) analysis

(cid:136) trigger.eigenR2: Estimate the proportion of genome-wide variation explained by each eQTL

(cid:136) trigger.loclink and trigger.net: Network-Trigger analysis

(cid:136) trigger.netPlot2ps: Write the network from a trigger probability matrix to a postscript

ﬁle

(cid:136) trigger.trait: Trait-Trigger analysis

To view the help ﬁle for the function trigger.link within R, type ?trigger.link.
If you
identify bugs related to basic usage please contact the authors directly. Otherwise, any questions
or problems rergarding snm should be sent to the Bioconductor mailing list. Please do not send
requests for general usage to the authors.

2 A yeast data set

The basic input data of this package consists of (1) a mm × n marker genotype matrix with mm
marker genotypes in rows and n samples/arrays in columns; (2) a me × n gene expression matrix
(or intermediate trait expression matrix) with me genes in rows andn samples/arrays in columns;
(3) a mm × 2 marker position matrix, of which the ﬁrst column is the chromosome name, and
the second column is the position of each marker, with each row corresponding to one marker in
the marker genotype matrix; and (4) a me × 3 gene position matrix, of which the ﬁrst column
is the chromosome name, and the second/third column is the starting/ending coordinate of each
gene, with each row corresponding to one gene in the expression matrix. Please code the names of
autosomal chromosomes to be integers and the name of sex chromsome to be “X”. Also note that
the same unit (e.g., base pair, kb, or cM) should be used for marker positions and gene positions.
As an illustration of input data format and various analysis oﬀered in this package, we demonstrate
the functionality of this package using a data set from a yeast eQTL study [1, 4]. In the study, a
genetic cross of Saccharomyces cerevisiase BY4716 and RM11-1a strains was utilized to generated
112 F1 recombinant segregants. Each individual strain was then genotyped and gene expression
measurements were done in a controlled growth environment. The data set consists of a list of four
matrices:

(cid:136) marker: A 3244 × 112 genotype matrix

(cid:136) exp: A 6216 × 112 gene expression matrix

(cid:136) marker.pos: A 3244 × 2 matrix of marker position information

(cid:136) exp.pos: A 6216 × 3 matrix of gene position information.

This yeast data set is included in the package as the dataset yeast. To load the data, type
data(yeast), and to view a description of this data type ?yeast. Once the data is loaded, one
can type attach(yeast) to attach the yeast data. After the analysis is done, type detach(yeast)
to detach the data set. We use a randomly generated subset of the data for the purpose of this
vignette.

> library(trigger)
> data(yeast)
> names(yeast)

2

[1] "marker"

"exp"

"marker.pos" "exp.pos"

> #reduce data size for vignette run time
> set.seed(123)
> #select subset of 400 traits
> gidx = sort(sample(1:6216, size = 400))
> yeast$exp = yeast$exp[gidx,]
> yeast$exp.pos = yeast$exp.pos[gidx,]
> #select subset of markers
> midx = sort(sample(1:3244, size = 500))
> yeast$marker = yeast$marker[midx,]
> yeast$marker.pos = yeast$marker.pos[midx,]
> attach(yeast)
> dim(exp)

[1] 400 112

The function trigger.build formats the input data and returns a S4 class object for the
It will convert the marker genotype matrix to a matrix of
convenience of subsequent analyses.
integers starting from 1 (a matrix of 1 or 2 for haploid genotypes, or 1, 2, or 3 for diploid genotypes).

> trig.obj <- trigger.build(marker=marker, exp=exp,
+
> trig.obj

marker.pos=marker.pos, exp.pos=exp.pos)

*** TRIGGER object ***
Marker matrix with 500 rows and 112 columns
Expression matrix with 400 rows and 112 columns

> detach(yeast)

3 Genome-wide eQTL analysis

The function trigger.link computes pair-wise likelihood ratio statistic for linkage of each gene-
marker pair in the genome. If there are markers on sex chromosome, gender of each sample should
be speciﬁed and the gender-speciﬁc mean will be computed for each genotype to obtain a likelihood
ratio statistic. When the option norm is TRUE, each gene (row) of expression data matrix will be
normalized to standard N (0, 1) based on the rank of the expression values for each gene. Since the
null likelihood ratio statistic follow a chi-square distribution, parametric p-values will be computed
based on the observed statistics. The function updates trig.obj with a matrix stat of likelihood
ratio statistics and a matrix of p-values pvalue corresponding to gene-marker pairs in the genome,
with genes in rows and markers in columns.

The function plot with the argument type = "link" takes the matrix of p-values for linkage of
each gene-marker pair, calls the measures below a cutoff to be signiﬁcant and plots the signiﬁcant
gene-marker pairs in a genome-wide eQTL linkage map. Genes and markers are ordered according
to their genome positions. Applying the functions to the yeast data set, in Figure 1 we plot
the genome-wide linkage map of eQTL and gene expression at p-value cutoﬀ 3.3 × 10−4, which

3

corresponds to 5% FDR[5]. Note that the function plot thresholds the signiﬁcance measures
pvalue below cutoﬀ. If one would like to threshold the signiﬁcance measures above a threshold,
one can apply the function to the negative matrix of signiﬁcance measures and choose a negative
cutoﬀ.

> trig.obj = trigger.link(trig.obj, norm = TRUE)

> plot(trig.obj, type = "link", cutoff = 1e-5)

Figure 1: Genome-wide eQTL and gene expression linkage map.

4 Multi-locus linkage (epistasis) analysis

The function mlink performs multi-locus linkage (epistasis) analysis for each selected gene ex-
pression. The option idx in the function can be used to select a subset of genes at a time. The
function identiﬁes a major locus and a secondary locus for each selected gene and estimates the
likelihood ratio statistics of linkage. It then computes the posterior probabilities of major locus
linkage, secondary locus linkage and joint linkage. Q-values (estimated false discovery rates) can
be estimated for the joint linkage probabilities. A detailed description of the algorithm can be
found in [4]. The function outputs a list of indices of major locus and secondary locus for each
selected gene, a matrix of major locus linkage probability, secondary locus linkage probability and
joint linkage probability, and a vector of q-values for joint linkage.

To visualize the signiﬁcant epistasis loci in the genome, the function plot with argument type =
"mlink" takes the output from mlink and plots the locus-pair showing signiﬁcant epistasis eﬀect

4

llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllCutoff =1e−05marker positionexpression−trait position13457891011121314151612345678910111213141516at a q-value cutoﬀ qcut. Each number in the output plot indicates the number of signiﬁcant genes
that are aﬀected by the epistasis eﬀect from a marker pair (if bin.size = NULL). If the option
bin.size is speciﬁed, each chromosome will be divided into several bins, each with size bin.size.
Markers within a bin will be considered as at a same position. Each number in the output plot
indicates the number of signiﬁcant genes that are aﬀected by the epistasis eﬀect from two markers,
one from each bin. We plot the marker/bins with according to their genome positions. The x and
y axis are the positions of the markers/bins.

We apply the function mlink to the yeast data set and use plot to plot the signiﬁcant epistasis
loci at a 10% FDR joint signiﬁcant level [5] in Figure 2.

> trig.obj = trigger.loclink(trig.obj)

[1] Computing local-linkages with a window size of 30 kb
[1] 10% completed
[1] 20% completed
[1] 30% completed
[1] 40% completed
[1] 50% completed
[1] 60% completed
[1] 70% completed
[1] 80% completed
[1] 90% completed
[1] 100% completed

> trig.obj = trigger.mlink(trig.obj, B = 10, idx = NULL)

[1] Start to calculate multi-locus linkage statistics ...
[1] 10% completed
[1] 20% completed
[1] 30% completed
[1] 40% completed
[1] 50% completed
[1] 60% completed
[1] 70% completed
[1] 80% completed
[1] 90% completed

> plot(trig.obj, type = "mlink", qcut = 0.2, bin.size = 50000)

5 Proportion of genome-wide variation captured by each eQTL

A classic R2 measure can be used to estimate the proportion of one gene expression variation that
captured by a locus of interest, and the R2 in this setting is often called “heritability” in genetics.
Recently, when genome-wide expression measurements are readily available, a high-dimensional
version of R2 is proposed to estimate the proportion of genome-wide expression variation explained
by a locus [3]. Here we call it as eigenR2. The function trigger.eigenR2 estimates the eigenR2
for each locus in the genome, and the plot function with argument type = "eigenR2" plots the

5

Figure 2: Plot of signiﬁcant epistasis loci at 10% FDR level.

estimated eigenR2 values for each marker versus its genome position. A locus with high eigenR2
is potentially a linkage hotspot that a lot of the genes are linked to. By chance, a random locus
1
not capturing any genome-wide expression variation will have an expected eigenR2 of
n−1 , where
If the logical option adjust=TRUE, the R2 estimates will be adjusted for
n is the sample size.
sample size eﬀect and the expected eigenR2 after adjustment is zero. One can also use the function
trigger.eigenR2 to compute the average of R2 of a locus for every gene expression, by setting the
logical option meanR2=TRUE (Fig 3).

> trig.obj = trigger.eigenR2(trig.obj, adjust = FALSE)

> plot(trig.obj, type = "eigenR2")

6 Network-Trigger analysis

The functions trigger.loclink and trigger.net provide an analysis based on an algorithm
called “Trigger” to construct gene regulatory network [2]. The algorithm establishes the equivalence
between a type of causal regulation of two genes to three testable conditions: 1) local linkage
of a ﬁrst gene, 2) secondary linkage of a second gene to the same locus, and 3) conditional
independence between locus to second gene given the expression of the ﬁrst one. The function
estimates the posterior probability of each condition for every selected pair of genes in the genome
and obtains the joint posterior probability of causal regulation for each gene pair as the product
of the probabilities of three conditions. These regulatory probabilities can further be used to

6

marker positionmarker position1111111121112111234578911121314151612345678910111213141516Figure 3: Plot of genome-wide eigenR2

construct a gene regulatory network.

The function trigger.loclink identiﬁes the best local linkage marker for every gene in the
genome and estimates the local linkage probability for each by borrowing information across genes.
One can use the option window.size to specify the size of a window that places a gene in the
center. Every marker within the window is a candidate marker for local-linkage to the gene. If
window.size = NULL, all the markers on a same chromosome as the gene will be used as candidate
markers for local-linkage.

The function trigger.net takes the output of trigger.loclink and further estimates the sec-
ondary linkage and conditional independence probabilities. By specifying the probability threshold
prob.cut, one can choose to only compute regulatory probabilities of a regulator to all the other
genes, if the local-linkage probability of the regulator is above the threshold. The local linkage
condition is not a necessary condition for establishing causality. The inclusion of this condition will
increase the estimation eﬃciency and accuracy, and make the estimates conservative. An option of
not including this condition by setting include.loc = FALSE is also provided. One can also select
a subset of putative causal genes to construct the network, by speciﬁc the indices of the genes in
the argument idx. In the following example, the network is constructed by analyzing by selecting
all genes idx = NULL in the dataset. The function trigger.net outputs a matrix of genome-wide
regulatory probabilities with putative regulators in rows and regulated genes in columns. The ma-
trix is not symmetric. If gene i is estimated to be causal for gene j with high probability, then
the probability of regulation from gene j to gene i should be low. Note that the function writes
the data to a ﬁle net_trigg_prob.txt in the working directory and reads in the ﬁle at the end of

7

0.000.010.020.030.040.050.06Eigen−R2marker positioneqtl−R2 value12345678910111213141516computation. Before repeating the calculation, this ﬁle should be deleted since new results will be
appended to the ﬁle.

> trig.obj = trigger.loclink(trig.obj, window.size = 10000)

[1] Computing local-linkages with a window size of 10 kb
[1] 10% completed
[1] 20% completed
[1] 30% completed
[1] 40% completed
[1] 50% completed
[1] 60% completed
[1] 70% completed
[1] 80% completed
[1] 90% completed
[1] 100% completed

> trig.prob = trigger.net(trig.obj, Bsec = 100, idx = NULL)

[1] Computing network-Trigger regulatory probabilities ...
[1] 10% completed
[1] 20% completed
[1] 30% completed
[1] 40% completed
[1] 50% completed
[1] 60% completed
[1] 70% completed
[1] 80% completed
[1] 90% completed
[1] 100% completed

> dim(trig.prob)

[1] 400 400

7 Visualize directed network from estimated regulatory probabil-

ity matrix

The package also oﬀers a function trigger.netPlot2ps to visualize the structure of the causal
regulatory network from network-Trigger probabilities. The function inputs a regulatory probabil-
ity matrix trig.prob, constructs a directed network based on signiﬁcant regulatory relationships
above a threshold pcut and writes the network to a postscript ﬁle with name filenam. The
function is dependent on the software Graphviz (available at http://www.graphviz.org/). If the
total number of signiﬁcant regulatory relationships (directed edges) of the network is below 1000,
we plot each gene (node) with shape node.shape with its name labeled inside. The default shape
is box. Otherwise, we plot each gene as a dot without name. The top nreg (by default nreg=20)
regulators will be plotted in red ellipses with their names inside. One can also speciﬁed the color
of nodes and edges in the plot with node.color and edge.color, respectively. The default color
for genes (except for top regulators) is green, with blue edges connecting them. See manual of

8

Graphviz for other available colors and shapes of nodes.

Our function will output a filenam.dot ﬁle, which is then written to a postscript ﬁle using
Graphviz with the following four possible layouts: radial (default), energy-minimized, cir-
cular and hierarchical One can specify just the initial letter to choose one layout. For large
networks, radial or energy-minimized is recommended. Once the layout is chosen, the function
will run one of the following command to construct a network and write the network to a postscript
ﬁle.

$ twopi -Tps ﬁlenam.dot -o ﬁlenam.ps # radial layout, the default layout
$ neato -Tps -Gmaxiter=1000 ﬁlenam.dot -o ﬁlenam.ps # energy-minimized layout
$ circo -Tps ﬁlenam.dot -o ﬁlenam.ps # circular layout
$ dot -Tps ﬁlenam.dot -o ﬁlenam.ps # hierarchical layout

The command neato plots the network with energy-minimized layout. To avoid long waiting for
constructing a large network, we specify the maximum iteration to be 1000 (-Gmaxiter=1000).

In Figure 4, we apply the function trigger.netPlot2ps to the estimated yeast regulatory proba-
bility matrix from previous section (output from trigger.net function). The resulting network is
written to a postscript ﬁle net95.ps with energy-minimized layout.

trigger.netPlot2ps(trig.obj, trig.prob, pcut = 0.95, filenam = "net50", nreg = 20)

system("ps2pdf net50.ps")

8 Trait-Trigger analysis

Trait-Trigger is an algorithm that identiﬁes the causal genes involved in the pathway from a ﬁxed
QTL to a quantitative trait of interest, where the trait can either be a gene transcript or a complex
phenotypic trait. The function trigger.trait identiﬁes putative causal genes for a given trait of
interest, and then estimates the p-value for causal linkage for each regulator.

First, the genotype-expression data has to be exported to cross formation (See qtl package for
details). This is done by the function trigger.export2cross, which formats the data, writes it
to a .csv ﬁle in the working directory and then reads in the data and stores it in a cross ﬁle.

> # Re-attach dataset to re-include all traits for analysis
> data(yeast); attach(yeast)
> dim(exp)

[1] 6216 112

> trig.obj <- trigger.build(marker=marker, exp=exp,
+

marker.pos=marker.pos, exp.pos=exp.pos)

> cross = trigger.export2cross(trig.obj, plotarg = FALSE, verbose = FALSE)

9

Figure 4: A yeast causal regulatory network at 95% trigger probability cutoﬀ for the selected 400
genes.

--Read the following data:

112 individuals
3244 markers
6216 phenotypes

--Cross type: bc

We apply the function to identify the causal genes for a DSE1, a daughter cell-speciﬁc protein, which
was shown to be regulated by the regulator AMN1 responsible for daughter cell separation[6].
If addplot = TRUE, the function plots a linkage map (Figure 5) for the trait over the chromosome or
chromosome where the LOD score for linkage crosses the threshold speciﬁed by thr. The function
identiﬁes AMN1 as the putative causal regulator having the minimum p-value for causal linkage.
Alternatively, the trait could be also entered as an expression vector trait = exp[1727,] or a
phenotype vector having the same number of columns as the genotype data.

References

[1] Rachel B Brem, John D Storey, Jacqueline Whittle, and Leonid Kruglyak. Genetic interactions
between polymorphisms that aﬀect gene expression in yeast. Nature, 436(7051):701–703, Aug
2005.

[2] Lin S Chen, Frank Emmert-Streib, and John D Storey. Harnessing naturally randomized tran-

scription to infer regulatory relationships among genes. Genome Biol, 8(10):R219, 2007.

10

YOL047CNFS1LEU5OST2MRPL31HOM2YJR136CYKL053WYSH1MRP2RSM18ARC1NUP100YAK1UGP1WSC2FMP40OXR1SPO7MET8RIM1YDR266CHXT13ILV1ZRT1OST5PEX8CTT1YIL087CCOY1YLL020CVPS33URA4NAM7SIP18CLA4LSP1ATH1SUP45YBR197CYBR089WACS2EBP2NRG1CBF5CUP9SEC7YDR474CLSC2YHR159WYLR137WYOL079WCLP1YPL017CYCR016WSSF2YGL157WRTS3BFA1MAK11FMP46YML003WCBK1HHT2VAM3ALG5AMN1HDA1MRPS18GTT3YFR026CTAF1YHR131CYNL155WYOR338WRRP15RPL34AUBP10NMA1USA1YIR007WSUI3SUP35RPS26ABUD32FUR1RPS24BGCD14APE2YLL056CADH6DCP1STE4RHO2YGR228WRMD1YLR415CSIR3GNA1BEM1EMP24SPO13SPT2NIP1YAP6LTE1SPO73RPL11BVAN1PRT1NOG1QCR9TOM71YDR114CYGL242CDUS1YOR175CSSO1YNL089CMEX67ASM4MRPL36YDL203CKEL3GYP5SKO1RER1PDR5YPL073CYDR222WMSM1MTM1PTC2SGF29SUR7MMT2YNL193WDED81MRPL49PDS5YGL160WSER1BST1AAT2BIO5YLR255CNEJ1COX13YOR325WZEO1MRE11HMT1POL5VHS2YCK3HIS2NDT80ENT5YOR343CSEC24YER130CXBP1YIL082WAYLR232W> causreg = trigger.trait(trig.obj, trait = "DSE1", cross = cross, addplot = TRUE, thr = 3)

Number of significant surrogate variables is: 14
Iteration (out of 5 ):1 2 3 4 5 Fitting 3 genes on chromosome 2

> causreg

AMN1

CDC28
0.00000000 0.06312741 0.17088160

YBR159W

Figure 5: A linkage map for trait DSE1

[3] Lin S Chen and John D Storey. Eigen-R2 for dissecting variation in high-dimensional studies.

Bioinformatics, 24(19):2260–2262, Oct 2008.

[4] John D Storey, Joshua M Akey, and Leonid Kruglyak. Multiple locus linkage analysis of

genomewide expression in yeast. PLoS Biol, 3(8):e267, Aug 2005.

[5] John D Storey and Robert Tibshirani. Statistical signiﬁcance for genomewide studies. Proc

Natl Acad Sci U S A, 100(16):9440–9445, Aug 2003.

[6] Ga¨el Yvert, Rachel B Brem, Jacqueline Whittle, Joshua M Akey, Eric Foss, Erin N Smith,
Rachel Mackelprang, and Leonid Kruglyak. Trans-acting regulatory variation in saccharomyces
cerevisiae and the role of transcription factors. Nat Genet, 35(1):57–64, Sep 2003.

11

010020030040001020304050DSE1:chr2Map position (cM)lod