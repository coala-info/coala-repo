Clipper package (Version 1.50.0)

Paolo Martini, Gabriele Sales and Chiara Romualdi

October 29, 2025

1

Along signal paths: an empirical gene set approach
exploiting pathway topology

1.1

clipper approach

Different experimental conditions are usually compared in terms of their gene expression mean
differences.
In the univariate case, if a gene set changes significantly its multivariate mean
expression in one condition with respect to the other, it is said to be differentially expressed.
However, the difference in mean expression levels does not necessarily result in a change of the
interaction strength among genes. In this case, we will have pathways with significant altered
mean expression levels but unaltered biological interactions. On the contrary, if transcripts
abundances ratios are altered, we expect a significant alteration not only of their mean, but
also of the strength of their connections, resulting in pathways with completely corrupted
functionality. Therefore, to look for pathways strongly involved in a biological process, we
should look at pathways with both mean and variance significantly altered. clipper is based
on a two-step approach: 1) it selects pathways with covariance matrices and/or means
significantly different between experimental conditions and 2) on such pathways, it identifies
the sub-paths mostly associated to the phenotype. This is a very peculiar feature in pathway
analysis. To our knowledge this is the first approach able to systematically inspect a pathway
deep in its different portions.

1.2

Other approaches on Bioconductor

Currently there are some pathway analysis methods implemented in Bioconductor (probably
the most famous is GSEA), but very few of them try to exploit pathway topology. Example
of the latter category are SPIA and DEGraph.

In Martini et al. 2012 is provided a detailed comparison of the performance of non-topological
analysis (GSEA) and topological analysis (SPIA and clipper ) using both real and simulated
data. In the next few words, we are going to highlight the defferences of these apperoaches.

GSEA uses pathway as a list of genes without taking into account the structure of the
pathway while SPIA takes into account pathway topological information, gene fold-changes
and pathway enrichment scores. Then SPIA takes as input only the list of differentially
expressed genes. So, from a practical point of view clipper and SPIA test different null
hypotheses.

More importantly, clipper is able to highlight the portions (sub-path) of the pathway that
are mostly involved in the phenotype under study using graph decomposition theory.

For more ditails please refer to Martini et al. 2012.

Clipper package (Version 1.50.0)

2

Performing pathway analysis

In this section, we describe how to perform the topological pathway analysis on a whole
pathway. As an example we used the gene expression data published by Chiaretti et al. on
acute lymphocytic leukemia (ALL) cells associated with known genotypic abnormalities in
adult patients. Several distinct genetic mechanisms lead to ALL malignant transformations
deriving from distinct lymphoid precursor cells that have been committed to either T-lineage
or B-lineage differentiation. Chromosome translocations and molecular rearrangements are
common events in B-lineage ALL and reflect distinct mechanisms of transformation. The
BCR breakpoint cluster region and the c-abl oncogene 1 (BCR/ABL) gene rearrangement
occurs in about 25% of cases in adult ALL.

The expression values (available through Bioconductor) deriving from Affymetrix single chan-
nel technology, consist of 37 observations from one experimental condition (class 2, n1 37,
BCR; presence of BCR/ ABL gene rearrangement) and 42 observations from another exper-
imental condition (class 1, n2 41, NEG; absence of rearrangement). The clipper method
is based on Gaussian graphical models, therefore it is strongly recommended to use log-
transformed data.

In this example, we are going to evidence the differences between BCR/ABL (class 2) and
NEG (class 1) though a topological pathway analysis.

We use the graphite bioconductor R package as a source of pathway topological information.
In our test dataset, given the presence of the BCR/ABL chimera, we expect that all the
pathways including BCR and/or ABL1 will be impacted. Here we retrieve, for example, the
KEGG "Chronic myeloid leukemia" pathway.

> library(graphite)

> kegg <- pathways("hsapiens", "kegg")

> graph <- convertIdentifiers(kegg[["Chronic myeloid leukemia"]], "entrez")

> graph <- pathwayGraph(graph)

> genes <- nodes(graph)

> head(genes)

[1] "ENTREZID:10000"

"ENTREZID:1019"

[3] "ENTREZID:1021"

"ENTREZID:1026"

[5] "ENTREZID:1029"

"ENTREZID:110117499"

Once the pathway (converted to a graphNEL object) is loaded in the workspace, we need to
retrieve the expression matrix and the corresponding sample annotations (2 denoting samples
with translocation and 1 denoting samples with no BCR/ABL translocation). We use as an
example the ALL Bioconductor package.

> library(ALL)

> data(ALL)

Fist of all, we should take a look at the phenoData.

> head(pData(ALL))

cod diagnosis sex age BT remission CR

date.cr

01005 1005 5/21/1997

M 53 B2

01010 1010 3/29/2000

M 19 B2

03002 3002 6/24/1998

F 52 B4

04006 4006 7/17/1997

M 38 B1

CR CR

8/6/1997

CR CR 6/27/2000

CR CR 8/17/1998

CR CR

9/8/1997

2

Clipper package (Version 1.50.0)

04007 4007 7/22/1997

M 57 B2

04008 4008 7/30/1997

M 17 B1

CR CR 9/17/1997

CR CR 9/27/1997

t(4;11) t(9;22) cyto.normal

citog mol.biol

01005

01010

03002

04006

04007

04008

01005

01010

03002

04006

04007

04008

FALSE

FALSE

NA

TRUE

FALSE

FALSE

TRUE

FALSE

NA

FALSE

FALSE

FALSE

FALSE

t(9;22)

BCR/ABL

FALSE

simple alt.

NEG

NA

FALSE

FALSE

<NA>

BCR/ABL

t(4;11) ALL1/AF4

del(6q)

NEG

NEG

FALSE complex alt.

fusion protein mdr

kinet

ccr relapse transplant

p210 NEG dyploid FALSE

FALSE

<NA> POS dyploid FALSE

p190 NEG dyploid FALSE

<NA> NEG dyploid FALSE

<NA> NEG dyploid FALSE

<NA> NEG hyperd. FALSE

f.u date last seen

TRUE

TRUE

TRUE

TRUE

TRUE

TRUE

FALSE

FALSE

FALSE

FALSE

FALSE

01005 BMT / DEATH IN CR

<NA>

01010

03002

04006

04007

04008

REL

REL

REL

REL

REL

8/28/2000

10/15/1999

1/23/1998

11/4/1997

12/15/1997

> dim(pData(ALL))

[1] 128 21

This data.frame summarized all the phenotypic features of the samples. In our analysis, we
are interested in B-cell. This information is hosted in the column called ‘BT‘.

> pData(ALL)$BT

[1] B2 B2 B4 B1 B2 B1 B1 B1 B2 B2 B3 B3 B3 B2 B3 B

B2 B3

[19] B2 B3 B2 B2 B2 B1 B1 B2 B1 B2 B1 B2 B

B

B2 B2 B2 B1

[37] B2 B2 B2 B2 B2 B4 B4 B2 B2 B2 B4 B2 B1 B2 B2 B3 B4 B3

[55] B3 B3 B4 B3 B3 B1 B1 B1 B1 B3 B3 B3 B3 B3 B3 B3 B3 B1

[73] B3 B1 B4 B2 B2 B1 B3 B4 B4 B2 B2 B3 B4 B4 B4 B1 B2 B2

[91] B2 B1 B2 B B T T3 T2 T2 T3 T2 T

T4 T2 T3 T3 T

T2

[109] T3 T2 T2 T2 T1 T4 T T2 T3 T2 T2 T2 T2 T3 T3 T3 T2 T3

[127] T2 T

Levels: B B1 B2 B3 B4 T T1 T2 T3 T4

> pAllB <- pData(ALL)[grep("B", pData(ALL)$BT),]

> dim(pAllB)

[1] 95 21

After this selection, we are interest in the isolation of sample with translocation from those
without translocation. This information is hosted in the column ‘mol.biol‘.

> pAllB$'mol.biol'

[1] BCR/ABL NEG

BCR/ABL ALL1/AF4 NEG

[7] NEG

NEG

NEG

BCR/ABL

BCR/ABL

NEG

NEG

3

Clipper package (Version 1.50.0)

[13] E2A/PBX1 NEG

BCR/ABL NEG

BCR/ABL

BCR/ABL

[19] BCR/ABL BCR/ABL NEG

BCR/ABL

BCR/ABL

NEG

[25] ALL1/AF4 BCR/ABL ALL1/AF4 NEG

ALL1/AF4 BCR/ABL

[31] NEG

[37] NEG

BCR/ABL NEG

BCR/ABL

BCR/ABL

ALL1/AF4

BCR/ABL BCR/ABL BCR/ABL

NEG

E2A/PBX1

[43] BCR/ABL NEG

NEG

NEG

BCR/ABL

p15/p16

[49] ALL1/AF4 BCR/ABL BCR/ABL NEG

E2A/PBX1 NEG

[55] NEG

NEG

BCR/ABL BCR/ABL

NEG

[61] ALL1/AF4 NEG

ALL1/AF4 NEG

BCR/ABL

NEG

NEG

[67] NEG

NEG

NEG

NEG

BCR/ABL

ALL1/AF4

[73] BCR/ABL NEG

E2A/PBX1 NEG

BCR/ABL

BCR/ABL

[79] NEG

NEG

NEG

NEG

BCR/ABL

[85] BCR/ABL BCR/ABL BCR/ABL ALL1/AF4 NEG

NEG

NEG

[91] BCR/ABL NEG

BCR/ABL BCR/ABL

E2A/PBX1

Levels: ALL1/AF4 BCR/ABL E2A/PBX1 NEG NUP-98 p15/p16

> NEG <- pAllB$'mol.biol' == "NEG"

> BCR <- pAllB$'mol.biol' == "BCR/ABL"

> pAll <- pAllB[(NEG | BCR),]

Now we have to build the vector of classes.

> classesUn <- as.character(pAll$'mol.biol')

> classesUn[classesUn=="BCR/ABL"] <- 2

> classesUn[classesUn=="NEG"] <- 1

> classesUn <- as.numeric(classesUn)

> names(classesUn) <- row.names(pAll)

> classes <- sort(classesUn)

Now that we have the vector of classes, we can isolate the subset of sample from the original
expression set and subsequently we convert affymetrix probe names into entrez gene ids.

> library("hgu95av2.db")

> all <- ALL[,names(classes)]

> probesIDS <- row.names(exprs(all))

> featureNames(all@assayData)<-unlist(mget(probesIDS, hgu95av2ENTREZID))

> all <- all[(!is.na(row.names(exprs(all))))]

To be compliant with graphite we need to explicit in the row names that the IDs are Entrez-
Gene.

> all_rnames <- featureNames(all@assayData)
> featureNames(all@assayData) <- paste("ENTREZID", all_rnames, sep = ":")

At this point, we compute the intersection between pathway nodes and the genes for which an
expression value is available. Thus we obtain a subgraph of the original graph. Moreover, we
can extract from the expression set a smaller expression set corresponding to the expression
of the genes in the pathway under investigation.

> library(graph)

> genes <- intersect(genes, row.names(exprs(all)))

> graph <- subGraph(genes, graph)

> exp <- all[genes,,drop=FALSE]

4

Clipper package (Version 1.50.0)

> exp

ExpressionSet (storageMode: lockedEnvironment)

assayData: 72 features, 79 samples

element names: exprs

protocolData: none

phenoData

sampleNames: 01010 04007 ... 84004 (79 total)

varLabels: cod diagnosis ... date last seen (21

total)

varMetadata: labelDescription

featureData: none

experimentData: use 'experimentData(object)'

pubMedIds: 14684422 16243790

Annotation: hgu95av2

> dim(exprs(exp))

[1] 72 79

Note that the usage of ’exp’ as ExpressionSet or exprs(exp) as expression matrix leads exactly
at the same result. Here we will use the ExpressionSet but all our function can be used with
a simple expression matrix.

The analysis is performed using pathQ function as follows:

> library(clipper)

> pathwayAnalysis <- pathQ(exp, classes, graph, nperm=100, alphaV=0.05, b=100)

> pathwayAnalysis

$alphaVar

[1] 0.32

$alphaMean

[1] 0

The returned list contains the pvalue for the test on the concentration matrices (alphaVar)
and the pvalue for the test on the means (alphaMean).

3

Performing clipper analysis

After a global inspection and identification of the most interesting/impacted pathways (the
global analysis we have seen in the previous section), it is important to focus on the genes
that drive the differences between the two phenotypes. The following example shows how to
identify the sub-paths mostly associated to the phenotype.

> clipped <- clipper(exp, classes, graph, "var", trZero=0.01, permute=FALSE)

> clipped[,1:5]

startIdx endIdx maxIdx lenght

maxScore

1;4

1;9

1;10

1;17

1

1

1

1

4

9

10

17

1

2

3

7

4 1.07518794226094

5 3.56236878201274

6 6.75554607050997

9 23.5836375910436

5

Clipper package (Version 1.50.0)

1;23

1;30

1

1

23

30

2

2

10 1.78118439100637

5 3.56236878201274

The analyzed cliques are indexed by the maximum cardinality search (mcs) algorithm and
identified hereafter with the index number. The result of the clipper analysis is the matrix de-
scribed in the following. For each analyzed path (named as <starting clique index>;<ending
clique index>) the followiong information are reported:

1 Index of the starting clique

2 Index of the ending clique

3 Index of the clique where the maximum value is reached

4 Length of the path

5 Maximum score of the path

6 Average score along the path

7 Percentage of path activation

8 Impact of the path on the entire pathway

9 Involved and significant cliques

10 Cliques forming the path

11 Genes forming the significant cliques

12 Genes forming the path

A deeper look at the clipper matrix reveals that many paths overlap. To help users in focusing
on the best candidates, we devised a function to prune the paths that are already part of
other ones. The pruning process is performed according to a dissimilarity threshold thr (if
paths dissimilarity value is greater than thr they are retained).

> clipped <- prunePaths(clipped, thr=0.2)

> clipped[,1:5]

startIdx endIdx maxIdx lenght

maxScore

1;17

1

17

7

9 23.5836375910436

After the pruning, the results are smaller and much clear to read and interpret.

4

Visualizing clipper results.

WARNING: RCytoscape is no longer support in some Platform so we use RCy3. clipper uses
the RCy3 package to connect to Cytoscape and display its results. Cytoscape is a Java based
software specifically built to manage biological network complexity and for this reason it is
widely used by the biological community.

> plotInCytoscape(graph, clipped[1,])

After the export of the pathway to Cytoscape, you can choose between different layouts. In
figure 1 we show the KEGG "Chronic myeloid leukemia" pathway with an hierarchical layout
and with the genes that belong to the most impacted path highlighted in blue.

6

Clipper package (Version 1.50.0)

Figure 1: clipper visualization of the "Chronic myeloid leukemia" pathway from KEGG: nodes of the most
significant path are reported in blue.

5

Easy clipper analysis

The package provides also a function to easily run the analysis described in Martini et al.
2012. This analysis is able to start from a expression matrix and a pathway and returns the
paths in the pathway that are altered between the two conditions.

> clipped <- easyClip(exp, classes, graph, method="mean")

> clipped[,1:5]

startIdx endIdx maxIdx lenght

maxScore

1;17

1;12

1

1

17

12

9

3

9 51.0841685716396

3 11.7253302376214

A short summary of the results can be obtained with easyLook function.

> easyLook(clipped)

maxScore

1;17 51.0841685716396

1;12 11.7253302376214

1;17 ENTREZID:10000;ENTREZID:1029;ENTREZID:207;ENTREZID:208;ENTREZID:4193;ENTREZID:1147;ENTREZID:3551;ENTREZID:8517;ENTREZID:1398;ENTREZID:1399;ENTREZID:25;ENTREZID:613;ENTREZID:867;ENTREZID:9846;ENTREZID:572;ENTREZID:6776;ENTREZID:6777;ENTREZID:25759;ENTREZID:4609;ENTREZID:53358;ENTREZID:6464

1;12

ENTREZID:10000;ENTREZID:1029;ENTREZID:207;ENTREZID:208;ENTREZID:4193;ENTREZID:1019;ENTREZID:1021;ENTREZID:1026;ENTREZID:595;ENTREZID:1869;ENTREZID:1870;ENTREZID:1871;ENTREZID:5925

involvedGenes

6

Bibliography

References

[1] Chiaretti, S. and Li, X. and Gentleman, R. and Vitale, A. and Wang, K.S. and Mandelli,

F. and Foà, R. and Ritz, J. Gene expression profiles of B-lineage adult acute
lymphocytic leukemia reveal genetic patterns that identify lineage derivation
and distinct mechanisms of transformation. Clinical cancer research. 2005.

7

Clipper package (Version 1.50.0)

[2] Martini P, Sales G, Massa MS, Chiogna M, Romualdi C. Along signal paths: an

empirical gene set approach exploiting pathway topology. Nucleic Acids Research.
2012.

[3] Massa MS, Chiogna M, Romualdi C. Gene set analysis exploiting the topology of a

pathway. BMC System Biol. 2010.

[4] Sales, G. and Calura, E. and Cavalieri, D. and Romualdi, C. graphite-a Bioconductor
package to convert pathway topology to gene network. BMC bioinformatics. 2012.

[5] Laurent J, Pierre N and DudoitS. More power via graph-structured tests for

differential expression of gene networks The Annals of Applied Statistics. 2012.

[6] Tarca AL, Draghici S, Khatri P, Hassan SS, Mittal P, and Kim J, and Kim CJ,
Kusanovic JP and Romero R. A novel signaling pathway impact analysis
Bioinformatics. 2009.

[7] Subramanian A, Tamayo P, Mootha VK, Mukherjee S, Ebert BL, Gillette MA, Paulovich
A, Pomeroy SL, Golub TR, Lander ES, and others. Gene set enrichment analysis: a
knowledge-based approach for interpreting genome-wide expression profiles
Proceedings of the National Academy of Sciences of the United States of America. 2005.

8

