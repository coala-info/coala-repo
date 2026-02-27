Neighbor net analysis

Sahar Ansari and Sorin Draghici
Department of Computer Science, Wayne State University, Detroit MI 48201

October 30, 2018

Abstract

This package is indented to be the R implementation of the method introduced in [1]. Neigh-
bor net analysis aims to take advantage of the prior knowledge of gene-gene interactions and
idetiﬁes the putative mechanisms at play in the given condition (e.g. a disease, a treatment,
etc.). The captured network can be useful for the prediction of mechanisms of action of drugs
or the responses of an organism to a speciﬁc impact.

1 Neighbor net analysis

Neighbor net (neighborNet) is a tool to identify the active mechanism involved in an investigated
phenotype. This method uses two sources of data: one is the experiment data and the other is the
gene-gene interactions knowledge.

1.1 Gene-gene interaction knowledge

Neighbor net can accept any gene-gene interaction information obtained from diﬀerent databases.
The data has to be converted to a list format. Each element in the list represents the neighborhood
of one gene.

We provided an example that includes the interactions exist in KEGG[2] and HPRD [3] databases.

> load(system.file("extdata/listofgenes.RData", package = "NeighborNet"))

The listofgenes is a list including the neighbors of the genes in the analysis:

> head(listofgenes)

‘

216

$
[1] "216"

‘

‘

‘

‘

‘

‘

‘

55607

$
[1] "55607" "71"

5552

$
[1] "5552" "960"

3679

$
[1] "3679" "1134" "1398" "1399" "5747" "6714" "60"

"71"

"9564"

"5575" "5504" "84687" "5499" "6198"

"5196" "56893" "6449" "3002" "213"

1

‘

$

‘

2886

[1] "2886" "2064" "3815" "2065" "2885" "7010" "5747" "9020" "1956" "3643"

[11] "5979"

‘

$

‘

5058

"2064"
"5879"
"985"

"5335"
[1] "5058"
"5829"
[9] "3984"
"998"
[17] "1459"
"1277"
[25] "58480" "6853"
"2099"
[33] "7048"
"2316"
[41] "10746" "4215"
"5609"
[49] "85366" "91807" "3985"

"5604"
"668"
"4086"
"5580"
"2308"
"6416"
"8874"

"660"
"4771"
"4087"
"58"
"834"
"2317"

"9459"
"4690"
"10095" "9181"
"4089"
"572"
"5894"
"2318"

"4638"
"1457"
"57154" "7046"
"10818" "9815"
"5605"
"9020"
"340156"
"7074"

1.2 Experiment data

As an example, we provided ﬁve pre-processed data sets from GEO (GSE4183, GSE9348, GSE21510,
GSE32323, GSEl8671).

These data study the expression change between colorectal cancer and normal patients. The
data was preprocessed using the limma package. Only probe sets with a gene associated to them
have been kept.

> load(system.file("extdata/dataColorectal4183.RData", package = "NeighborNet"))
> load(system.file("extdata/dataColorectal9348.RData", package = "NeighborNet"))
> load(system.file("extdata/dataColorectal21510.RData", package = "NeighborNet"))
> load(system.file("extdata/dataColorectal32323.RData", package = "NeighborNet"))
> load(system.file("extdata/dataColorectal8671.RData", package = "NeighborNet"))
> head(dataColorectal4183)

adj.P.Val

1 0.0005849192 2.165550
2 0.0005849192 1.993385
3 0.0005849192 1.402015
4 0.0015330474 1.887886
5 0.0015330474 2.220579
6 0.0015330474 3.536515

logFC EntrezID
27253
7450
857
25937
29767
285

The next step is to select the genes that are diﬀerentially expressed, with p-value lower than

1% and absolute fold change more than 1.5.

dataColorectal4183$adj.P.Val < pvThreshold &
abs(dataColorectal4183$logFC) > foldThreshold

> pvThreshold <- 0.01
> foldThreshold <- 1.5
> de1 <- dataColorectal4183$EntrezID [
+
+
+ ]
> de2 <- dataColorectal9348$EntrezID [
+
+
+ ]

dataColorectal9348$adj.P.Val < pvThreshold &
abs(dataColorectal9348$logFC) > foldThreshold

2

dataColorectal21510$adj.P.Val < pvThreshold &
abs(dataColorectal21510$logFC) > foldThreshold

dataColorectal32323$adj.P.Val < pvThreshold &
abs(dataColorectal32323$logFC) > foldThreshold

> de3 <- dataColorectal21510$EntrezID [
+
+
+ ]
> de4 <- dataColorectal32323$EntrezID [
+
+
+ ]
> de5 <- dataColorectal8671$EntrezID [
+
+
+ ]
>

dataColorectal8671$adj.P.Val < pvThreshold &
abs(dataColorectal8671$logFC) > foldThreshold

Later, the diﬀerentialy expressed genes from diﬀerent datasets should be combined together:

> de <- unique( c(de1,de2,de3,de4,de5))

The reference contains all the genes measured in the analysis:

dataColorectal4183$EntrezID,
dataColorectal9348$EntrezID,
dataColorectal21510$EntrezID,
dataColorectal32323$EntrezID,
dataColorectal8671$EntrezID

> ref <- unique( c(
+
+
+
+
+
+ ))
> head(ref)

[1] "27253" "7450" "857"

"25937" "29767" "285"

1.3 Neighbor net analysis and resulted network

We have all the input fot Neighbor net analysis.

(cid:136) the gene-gene knowledge in a list format -listofgenes

(cid:136) the experiment data -de and -ref

> library("NeighborNet")
> library("graph")
> sig_genes <- neighborNet(de = de, ref = ref, listofgenes=listofgenes)
> sig_genes

A graphNEL graph with undirected edges
Number of Nodes = 144
Number of Edges = 251

3

Figure 1: The active network that describes the putative mechanism involved in colorectal cancer.

1.4 Graphical representation of results

To visualize the identiﬁed network use the function plot(see Fig. 1):

> require("graph")
> attrs <- list(node= list(fontsize=40,fixedsize= FALSE),graph=list(overlap=FALSE), edge=list(lwd=0.6))
> nAttr <- list()
> nAttr$color <- c(rep("white",length(nodes(sig_genes))))
> names(nAttr$color) <- nodes(sig_genes)
> plot(sig_genes)

References

[1] S. Ansari, M. Donato, N. Saberian, and S. Draghici. An approach to infer putative disease-
speciﬁc mechanisms using neighboring gene networks. Bioinformatics, page btx097, 2017.

[2] M. Kanehisa and S. Goto. KEGG: kyoto encyclopedia of genes and genomes. Nucleic Acids

Research, 28(1):27–30, 2000.

[3] S. Peri, J. D. Navarro, R. Amanchy, T. Z. Kristiansen, C. K. Jonnalagadda, V. Surendranath,
V. Niranjan, B. Muthusamy, T. Gandhi, M. Gronborg, et al. Development of human protein
reference database as an initial platform for approaching systems biology in humans. Genome
Research, 13(10):2363–2371, 2003.

4

12151243121908521642541906190718355388595102949999901021235955000831883171026417141754172151871110078032189669343728149920335663546737254609329894431680618540783128313428633266576591431450546357635514041634669634866347635463386804633728823114414712871288631041461285128412821286127722012335542250011019417641734174259286506526546559911910287085710672276748462776277027712773277527699630891672983993558724208534728615143181278357629195340381458586374703520483749601839742263825117666138608343970451280270042593727361490700511313755597064804427782774846311282353352946932