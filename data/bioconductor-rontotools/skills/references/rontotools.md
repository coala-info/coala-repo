ROntoTools: The R Onto-Tools suite

Calin Voichita, Sahar Ansari and Sorin Draghici
Department of Computer Science, Wayne State University, Detroit MI 48201

October 30, 2025

Abstract

This package is indented to be the R implementation of the web-based data mining and anal-
ysis suite of tools called Onto-Tools [10, 6, 5, 7, 8, 5, 12, 9, 4, 8, 9, 2, 9, 13, 3, 11]. Among these,
Onto-Express (OE) was the first publicly available tool for the GO profiling of high throughput
data and Pathway-Express (PE) the first tool to perform analysis of signaling pathways using
important biological factors like all the interactions between the genes, the type of interaction
between them and the position and magnitude of expression change for all the differentially
expressed genes. We currently have over 10,000 registered users from 53 countries. Approxi-
mately, 5,000 of these are regular users (more than 10 data sets processed). This R package
will provide these users with access to the direct functionalities of the online version, to new
analysis methods and also expose the tools to a larger audience. As part of the first version, the
pathway analysis tool Pathway-Express is made available.

1 Pathway-Express

Pathway-Express (pe) is a tool for the analysis of signaling pathways. Besides the original imple-
mentation [3, 14], this tool implements a number of improvements proposed in [15] that include the
incorporation of gene significance and the elimination of the need to select differentially expressed
genes. Pathway-Express uses two sources of data: one is the experiment data and the other is the
database of pathways.

1.1 Pathway database

Pathway-Express is a general tool that accepts any set of signaling pathways defined using the
standard implementation provided in the graph package. The only requirement is that each pathway,
defined as an object of type graph, has a weight defined for each edge, representing the efficiency of
the propagation between the two genes, and a weight for each node, that will capture the type of
gene or the significance of the measured expression change. This package provides tools to access
the KEGG database for signaling pathways and also tools to set these weights.

For example, to download and parse the signaling pathways available in KEGG use:

> require(graph)
> require(ROntoTools)
> kpg <- keggPathwayGraphs("hsa", verbose = FALSE)

The above code will load the available cached data for human (i.e., KEGG id hsa). To update

the cache and download the latest KEGG pathways available use the updateCache parameter:

> kpg <- keggPathwayGraphs("hsa", updateCache = TRUE, verbose = TRUE)

1

This command is time consuming and depends on the available bandwith.

The kpg is a list of graph objectes:

> head(names(kpg))

[1] "path:hsa03008" "path:hsa03013" "path:hsa03015" "path:hsa03018"
[5] "path:hsa03320" "path:hsa03460"

To inspect one of the pathway graphs, only the ID is required. Here is an example for the Cell
Cycle:

> kpg[["path:hsa04110"]]

A graphNEL graph with directed edges
Number of Nodes = 124
Number of Edges = 632

> head(nodes(kpg[["path:hsa04110"]]))

[1] "hsa:1029"

"hsa:51343" "hsa:4171" "hsa:4172"

"hsa:4173"

"hsa:4174"

> head(edges(kpg[["path:hsa04110"]]))

$`hsa:1029`
[1] "hsa:4193" "hsa:1019" "hsa:1021" "hsa:595" "hsa:894" "hsa:896"

"hsa:85417" "hsa:891"

"hsa:9133"

$`hsa:51343`
[1] "hsa:983"

$`hsa:4171`
character(0)

$`hsa:4172`
character(0)

$`hsa:4173`
character(0)

$`hsa:4174`
character(0)

In addition the parser extracted the type of interaction for each gene-gene interaction in an

attribute called subtype:

> head(edgeData(kpg[["path:hsa04110"]], attr = "subtype"))

$`hsa:1029|hsa:4193`
[1] "inhibition"

$`hsa:1029|hsa:1019`

2

[1] "inhibition"

$`hsa:1029|hsa:1021`
[1] "inhibition"

$`hsa:1029|hsa:595`
[1] "inhibition"

$`hsa:1029|hsa:894`
[1] "inhibition"

$`hsa:1029|hsa:896`
[1] "inhibition"

Using this attribute the function setEdgeWeights sets the same weight for all the interactions

of the same type:

> kpg <- setEdgeWeights(kpg, edgeTypeAttr = "subtype",
+
+
+

expression = 1, repression = -1),

defaultWeight = 0)

edgeWeightByType = list(activation = 1, inhibition = -1,

At this point, kpg contains a list of graphs with weighted edges:

> head(edgeData(kpg[["path:hsa04110"]], attr = "weight"))

$`hsa:1029|hsa:4193`
[1] -1

$`hsa:1029|hsa:1019`
[1] -1

$`hsa:1029|hsa:1021`
[1] -1

$`hsa:1029|hsa:595`
[1] -1

$`hsa:1029|hsa:894`
[1] -1

$`hsa:1029|hsa:896`
[1] -1

To retrieve the title of the pathways and not just their ids the function keggPathwayNames can

be used:

> kpn <- keggPathwayNames("hsa")
> head(kpn)

3

path:hsa03008
"Ribosome biogenesis in eukaryotes"
path:hsa03015
"mRNA surveillance pathway"
path:hsa03320
"PPAR signaling pathway"

1.2 Experiment data

path:hsa03013
"RNA transport"
path:hsa03018
"RNA degradation"
path:hsa03460
"Fanconi anemia pathway"

As an example, we provided a pre-processed data set from ArrayExpress (E-GEOD-21942) that
studies the expression change in peripheral blood mononuclear cells (PBMC) between 12 MS patients
and 15 controls. The data was preprocessed using the limma package. Only probe sets with a gene
associated to them have been kept and for each gene only the most significant probe set has been
selected (the table is already ordered by p-value):

> load(system.file("extdata/E-GEOD-21942.topTable.RData", package = "ROntoTools"))
> head(top)

logFC

P.Value

adj.P.Val
200946_x_at -1.0175141 5.833411e-13 4.172652e-09
228697_at
210254_at
3.2807123 3.086572e-12 9.677020e-09
234726_s_at -0.9792301 7.368175e-12 1.760593e-08
215905_s_at -1.7733135 7.861797e-12 1.760593e-08
235542_at

entrez
hsa:2746
-3.6479368 7.985427e-13 4.172652e-09 hsa:135114
hsa:932
hsa:64418
hsa:9410
-0.9447467 1.617944e-11 2.536288e-08 hsa:200424

Select differentially expressed genes at 1% and save their fold change in a vector f c and their

p-values in a vector pv:

> fc <- top$logFC[top$adj.P.Val <= .01]
> names(fc) <- top$entrez[top$adj.P.Val <= .01]
> pv <- top$P.Value[top$adj.P.Val <= .01]
> names(pv) <- top$entrez[top$adj.P.Val <= .01]
> head(fc)

hsa:2746 hsa:135114

hsa:9410 hsa:200424
-1.0175141 -3.6479368 3.2807123 -0.9792301 -1.7733135 -0.9447467

hsa:932 hsa:64418

> head(pv)

hsa:2746

hsa:200424
5.833411e-13 7.985427e-13 3.086572e-12 7.368175e-12 7.861797e-12 1.617944e-11

hsa:135114

hsa:64418

hsa:9410

hsa:932

Alternatively, an analysis with all genes can be performed:

> fcAll <- top$logFC
> names(fcAll) <- top$entrez
> pvAll <- top$P.Value
> names(pvAll) <- top$entrez

The reference contains all the genes measured in the analysis:

4

> ref <- top$entrez
> head(ref)

[1] "hsa:2746"
[6] "hsa:200424"

"hsa:135114" "hsa:932"

"hsa:64418" "hsa:9410"

1.3 Setting the node weights

The node weights are used to encode for the significance of each gene, the term described as α in
[15]. The two alternative formulas to incorporate the gene significance:

α = 1 − p/pthr and α = −log(p/pthr)

(1)

are implemented as two function alpha1MR and alphaMLG.

To set the node weights the function setNodeWeights is used:

> kpg <- setNodeWeights(kpg, weights = alphaMLG(pv), defaultWeight = 1)
> head(nodeWeights(kpg[["path:hsa04110"]]))

hsa:1029 hsa:51343 hsa:4171

hsa:4174
1.0000000 1.0000000 0.8120949 1.0000000 1.0000000 1.0000000

hsa:4173

hsa:4172

1.4 Pathway analysis and results summary

Up to this point all the pieces need for the analysis have been assembled:

• the pathway database with the experiment specific gene significance - kpg

• the experiment data - fc and ref

To perform the analysis the function pe is used (increase the parameter nboot to obtain more
accurate results):

> peRes <- pe(x = fc, graphs = kpg, ref = ref, nboot = 200, verbose = FALSE)

The result object can be summarized in a table format with the desired columns using the

function Summary:

> head(Summary(peRes))

totalAcc totalPert totalAccNorm totalPertNorm

path:hsa05010 17.90716 121.13696
path:hsa05110 22.83759
87.30055
0.00000 102.93799
path:hsa04145
path:hsa03015
54.07253
0.00000
path:hsa05152 140.10374 233.91461
4.18750 123.28851
path:hsa05016

0.4729654
5.0289486
NA
-0.7446062
7.1682525
-0.2105296

pPert
2.835765 0.014925373
5.955605 0.004975124
6.086789 0.004975124
3.428890 0.004975124
8.578864 0.004975124
3.803593 0.009950249

pAcc

pAcc.fdr
pORA
path:hsa05010 0.616915423 1.360242e-05 3.331570e-06 0.02705224 0.76563611
path:hsa05110 0.004975124 1.085083e-04 8.330837e-06 0.01387294 0.03457711
path:hsa04145
NA
path:hsa03015 0.174129353 6.821488e-04 4.613351e-05 0.01387294 0.28144163

NA 2.424942e-04 1.764759e-05 0.01387294

pPert.fdr

pComb

5

path:hsa05152 0.004975124 8.354186e-04 5.565668e-05 0.01387294 0.03457711
path:hsa05016 0.870646766 6.852905e-04 8.793420e-05 0.02121744 0.92909498

pORA.fdr

pComb.fdr
path:hsa05010 0.001999556 0.0004830776
path:hsa05110 0.007975357 0.0006039857
path:hsa04145 0.011882215 0.0008529668
path:hsa03015 0.016789618 0.0016140437
path:hsa05152 0.017204791 0.0016140437
path:hsa05016 0.016789618 0.0018495093

> head(Summary(peRes, pathNames = kpn, totalAcc = FALSE, totalPert = FALSE,
+

pAcc = FALSE, pORA = FALSE, comb.pv = NULL, order.by = "pPert"))

pPert pPert.fdr
RNA transport 0.004975124 0.01387294
path:hsa03013
mRNA surveillance pathway 0.004975124 0.01387294
path:hsa03015
path:hsa04010
MAPK signaling pathway 0.004975124 0.01387294
path:hsa04060 Cytokine-cytokine receptor interaction 0.004975124 0.01387294
path:hsa04062
Chemokine signaling pathway 0.004975124 0.01387294
path:hsa04080 Neuroactive ligand-receptor interaction 0.004975124 0.01387294

pathNames

1.5 Graphical representation of results

To visualize the summary of the Pathway-Express results use the function plot (see Fig. 1):

> plot(peRes)

> plot(peRes, c("pAcc", "pORA"), comb.pv.func = compute.normalInv, threshold = .01)

Pathway level statistics can also be displayed one at a time using the function plot (see Fig. 2):

> plot(peRes@pathways[["path:hsa05216"]], type = "two.way")

> plot(peRes@pathways[["path:hsa05216"]], type = "boot")

To visualize the propagation across the pathway, two functions - peNodeRenderInfo and peEdgeRenderInfo

- are provided to extract the required information from a pePathway object:

> p <- peRes@pathways[["path:hsa05216"]]
> g <- layoutGraph(p@map, layoutType = "dot")
> graphRenderInfo(g) <- list(fixedsize = FALSE)
> edgeRenderInfo(g) <- peEdgeRenderInfo(p)
> nodeRenderInfo(g) <- peNodeRenderInfo(p)
> renderGraph(g)

This is the Thyroid cancer signaling pathway and is shown in Fig. 3. Another example is the T

cell receptor signaling pathway and is presented in Fig. 4.

6

Figure 1: Two-way plot of Pathway-Express result

7

0123456024681012pAccpORApath:hsa05110path:hsa05152path:hsa05010path:hsa04722path:hsa04390path:hsa05100path:hsa05212path:hsa05120path:hsa04270path:hsa03015path:hsa04666path:hsa05012path:hsa05131path:hsa05200path:hsa04728path:hsa05220path:hsa05223path:hsa05142path:hsa05132path:hsa05214path:hsa04210path:hsa04062path:hsa05130path:hsa05016path:hsa05161path:hsa05166path:hsa04810path:hsa04010path:hsa04114path:hsa05030path:hsa05031path:hsa04971path:hsa04151path:hsa046700123456024681012pAccpORApath:hsa05110path:hsa05152path:hsa04390path:hsa05100path:hsa04722path:hsa05212path:hsa05120Figure 2: Pathway level statistiscs: perturbation accumulation versus the measured expression
change (above) and the bootstrap simulations of the perturbation accumulation (below).

8

−0.4−0.20.00.20.40.6−1.5−1.0−0.50.00.51.0AccLog2 FC02460.00.10.20.30.40.5AccDensityFigure 3: Perturbation propagation on the Thyroid cancer signaling pathway.

9

hsa:3265hsa:3845hsa:4893hsa:5468hsa:673hsa:5594hsa:5595hsa:5604hsa:5605hsa:7849hsa:7157hsa:6256hsa:6257hsa:6258hsa:1499hsa:4609hsa:999hsa:595hsa:5979hsa:8030hsa:8031hsa:10342hsa:4914hsa:7170hsa:7175hsa:51176hsa:6932hsa:6934hsa:83439Figure 4: Perturbation propagation on the T cell receptor signaling pathway.

10

hsa:1019hsa:7124hsa:1437hsa:3458hsa:3586hsa:3567hsa:3565hsa:3558hsa:4792hsa:4793hsa:4794hsa:4790hsa:5970hsa:3551hsa:8517hsa:1147hsa:9020hsa:1326hsa:10000hsa:207hsa:208hsa:10892hsa:8915hsa:84433hsa:5588hsa:5170hsa:2885hsa:23533hsa:5290hsa:5291hsa:5293hsa:5294hsa:5295hsa:5296hsa:8503hsa:940hsa:29851hsa:959hsa:6654hsa:6655hsa:10125hsa:3265hsa:3845hsa:4893hsa:2353hsa:3725hsa:4772hsa:4773hsa:4775hsa:5530hsa:5532hsa:5533hsa:5534hsa:5535hsa:3702hsa:7006hsa:5335hsa:27040hsa:9402hsa:10451hsa:7409hsa:7410hsa:387hsa:998hsa:10298hsa:5058hsa:5062hsa:5063hsa:56924hsa:57144hsa:4690hsa:8440hsa:3937hsa:7535hsa:916hsa:915hsa:919hsa:2534hsa:917hsa:920hsa:925hsa:926hsa:23624hsa:867hsa:868hsa:3932hsa:5788hsa:5777hsa:1493hsa:5133hsa:5604hsa:5605hsa:5894hsa:5594hsa:5595hsa:6885hsa:5609hsa:5601hsa:1739hsa:1432hsa:5600hsa:5603hsa:6300hsa:29322 Primary dis-regulation

Primary dis-regulation analysis (pDis) is a tool for the analysis of signaling pathways. This is the
original implementation of the algorithm introduced in [1]. This method takes into consideration
the primary dis-regulation of a given gene itself and the effects of signaling coming from upstream.
Similar to Pathway Express, primary dis-regulation uses two sources of data: one is the experiment
data and the other is the database of pathways.

The pathway database can be obtained from KEGG as expalined in section Pathway database.
For example, to download and parse the signaling pathways available in KEGG use:

> require(graph)
> require(ROntoTools)
> kpg <- keggPathwayGraphs("hsa", verbose = FALSE)

The above code will load the available cached data for human (i.e., KEGG id hsa). To update

the cache and download the latest KEGG pathways available use the updateCache parameter:

> kpg <- keggPathwayGraphs("hsa", updateCache = TRUE, verbose = TRUE)

This command is time consuming and depends on the available bandwith.

To retrieve the title of the pathways and not just their ids the function keggPathwayNames can

be used:

> kpn <- keggPathwayNames("hsa")
> head(kpn)

path:hsa03008
"Ribosome biogenesis in eukaryotes"
path:hsa03015
"mRNA surveillance pathway"
path:hsa03320
"PPAR signaling pathway"

path:hsa03013
"RNA transport"
path:hsa03018
"RNA degradation"
path:hsa03460
"Fanconi anemia pathway"

As an example, a publicly avaiable data is provided in the package. For more information please

refer to Experimental data section.

> load(system.file("extdata/E-GEOD-21942.topTable.RData", package = "ROntoTools"))
> head(top)

logFC

P.Value

adj.P.Val
200946_x_at -1.0175141 5.833411e-13 4.172652e-09
228697_at
210254_at
3.2807123 3.086572e-12 9.677020e-09
234726_s_at -0.9792301 7.368175e-12 1.760593e-08
215905_s_at -1.7733135 7.861797e-12 1.760593e-08
235542_at

entrez
hsa:2746
-3.6479368 7.985427e-13 4.172652e-09 hsa:135114
hsa:932
hsa:64418
hsa:9410
-0.9447467 1.617944e-11 2.536288e-08 hsa:200424

Select differentially expressed genes at 1% and save their fold change in a vector f c and their

p-values in a vector pv:

11

> fc <- top$logFC[top$adj.P.Val <= .01]
> names(fc) <- top$entrez[top$adj.P.Val <= .01]
> pv <- top$P.Value[top$adj.P.Val <= .01]
> names(pv) <- top$entrez[top$adj.P.Val <= .01]
> head(fc)

hsa:2746 hsa:135114

hsa:9410 hsa:200424
-1.0175141 -3.6479368 3.2807123 -0.9792301 -1.7733135 -0.9447467

hsa:932 hsa:64418

> head(pv)

hsa:2746

hsa:200424
5.833411e-13 7.985427e-13 3.086572e-12 7.368175e-12 7.861797e-12 1.617944e-11

hsa:135114

hsa:64418

hsa:9410

hsa:932

Alternatively, an analysis with all genes can be performed:

> fcAll <- top$logFC
> names(fcAll) <- top$entrez
> pvAll <- top$P.Value
> names(pvAll) <- top$entrez

The reference contains all the genes measured in the analysis:

> ref <- top$entrez
> head(ref)

[1] "hsa:2746"
[6] "hsa:200424"

"hsa:135114" "hsa:932"

"hsa:64418" "hsa:9410"

2.1 Pathway analysis and results summary

Here are the input needed to run a sample test:

• the pathway database with the experiment specific gene significance - kpg

• the experiment data - fc and ref

To perform the analysis the function pDis is used (increase the parameter nboot to obtain more
accurate results):

> pDisRes <- pDis(x = fc, graphs = kpg, ref = ref, nboot = 200, verbose = FALSE)

The result object can be summarized in a table format with the desired columns using the

function Summary:

> head(Summary(pDisRes))

totalpDis totalpDisNorm

path:hsa05010 38.59681
path:hsa05110 20.46240
path:hsa04390 36.64334
path:hsa04145 37.06796
path:hsa03015 23.11144

pORA

ppDis

pComb
-1.6949624 0.07960199 1.360242e-05 1.595582e-05
1.7741019 0.08955224 1.085083e-04 1.218689e-04
2.1427758 0.02985075 2.008410e-03 6.428085e-04
0.8527313 0.34825871 2.424942e-04 8.765428e-04
-1.4895259 0.13432836 6.821488e-04 9.436009e-04

12

-0.9155664 0.36318408 4.644830e-04 1.634200e-03
pORA.fdr

path:hsa04722 32.98817
ppDis.fdr

pComb.fdr
path:hsa05010 0.5265672 0.001999556 0.002345506
path:hsa05110 0.5265672 0.007975357 0.008957362
path:hsa04390 0.3989145 0.026839656 0.027741866
path:hsa04145 0.7511093 0.011882215 0.027741866
path:hsa03015 0.6205337 0.016789618 0.027741866
path:hsa04722 0.7511093 0.016789618 0.040037906

> head(Summary(pDisRes, pathNames = kpn, totalpDis = FALSE,
+

pORA = FALSE, comb.pv = NULL, order.by = "ppDis"))

ppDis ppDis.fdr
Cocaine addiction 0.009950249 0.3250415
path:hsa05030
path:hsa04976
Bile secretion 0.014925373 0.3250415
path:hsa05142 Chagas disease (American trypanosomiasis) 0.014925373 0.3250415
African trypanosomiasis 0.014925373 0.3250415
path:hsa05143
Malaria 0.014925373 0.3250415
path:hsa05144
Amoebiasis 0.014925373 0.3250415
path:hsa05146

pathNames

References

[1] S. Ansari, C. Voichiţa, M. Donato, R. Tagett, and S. Drăghici. A novel pathway analysis
approach based on the unexplained disregulation of genes. Proceedings of the IEEE, PP(99):1–
14, March 2016.

[2] V. Desai, P. Khatri, A. Done, A. Friedman, M. Tainsky, and S. Draghici. A novel bioinformatics
technique for predicting condition-specific transcription factor binding sites. In Proc. of IEEE
Symposium on Computational Intelligence in Bioinformatics and Computational Biology, San
Diego, USA, November 14-15 2005.

[3] S. Draghici, P. Khatri, A. L. Tarca, K. Amin, A. Done, C. Voichita, C. Georgescu, and
R. Romero. A systems biology approach for pathway level analysis. Genome Research,
17(10):1537–1545, 2007.

[4] S. Draghici, S. Sellamuthu, and P. Khatri. Babel’s tower revisited: a universal resource for

cross-referencing across annotation databases. Bioinformatics, 22(23):2934–2939, 2006.

[5] S. Drăghici, P. Khatri, P. Bhavsar, A. Shah, S. A. Krawetz, and M. A. Tainsky. Onto-tools, the
toolkit of the modern biologist: Onto-express, onto-compare, onto-design and onto-translate.
Nucleic Acids Research, 31(13):3775–81, July 2003.

[6] S. Drăghici, P. Khatri, R. P. Martins, G. C. Ostermeier, and S. A. Krawetz. Global functional

profiling of gene expression. Genomics, 81(2):98–104, February 2003.

[7] S. Drăghici, P. Khatri, A. Shah, and M. Tainsky. Assessing the functional bias of commer-
cial microarrays using the Onto-Compare database. BioTechniques, Microarrays and Cancer:
Research and Applications:55–61, March 2003.

13

[8] P. Khatri, P. Bhavsar, G. Bawa, and S. Drăghici. Onto-tools: an ensemble of web-accessible,
ontology-based tools for the functional design and interpretation of high-throughput gene ex-
pression experiments. Nucleic Acids Research, 32:W449–56, Jul 2004.

[9] P. Khatri, V. Desai, A. L. Tarca, S. Sellamuthu, D. E. Wildman, R. Romero, and S. Draghici.
New Onto-Tools: Promoter-Express, nsSNPCounter, and Onto-Translate. Nucleic Acids Re-
search, 34:W626–31, 2006.

[10] P. Khatri, S. Draghici, G. C. Ostermeier, and S. A. Krawetz. Profiling gene expression using

Onto-Express. Genomics, 79(2):266–270, February 2002.

[11] P. Khatri, S. Draghici, A. L. Tarca, S. S. Hassan, and R. Romero. A system biology approach
for the steady-state analysis of gene signaling networks. In 12th Iberoamerican Congress on
Pattern Recognition, Valparaiso, Chile, November 13-16 2007.

[12] P. Khatri, S. Sellamuthu, P. Malhotra, K. Amin, A. Done, and S. Drăghici. Recent additions
and improvements to the Onto-Tools. Nucleic Acids Research, 33(Web server issue), Jul 2005.

[13] P. Khatri, C. Voichita, K. Kattan, N. Ansari, A. Khatri, C. Georgescu, A. L. Tarca, and
S. Drˇaghici. Onto-Tools: New additions and improvements in 2006. Nucleic Acids Research,
37(Web Server issue), July 2007.

[14] A. L. Tarca, S. Draghici, P. Khatri, S. S. Hassan, P. Mittal, J. sun Kim, C. J. Kim, J. P.
Kusanovic, and R. Romero. A novel signaling pathway impact analysis (SPIA). Bioinformatics,
25(1):75–82, 2009.

[15] C. Voichita, M. Donato, and S. Draghici. Incorporating gene significance in the impact anal-
ysis of signaling pathways. Proceedings of the International Conference on Machine Learning
Applications (ICMLA), Dec. 2012.

14

