DriverNet package

Ali Bashashati, Reza Haffari, Jiarui Ding, Gavin Ha, Kenneth Liu,
Jamie Rosner and Sohrab Shah

October 29, 2025

1 Overview

DriverNet is a package to predict functional important driver genes in cancer by inte-
grating genome data (mutation and copy number variation data) and transcriptome data
(gene expression data). The different kinds of data are combined by an influence graph,
which is a gene-gene interaction network deduced from pathway data. A greedy algo-
rithm is used to find the possible driver genes, which may mutated in a larger number
of patients and these mutations will push the gene expression values of the connected
genes to some extreme values.

Specifically, DriverNet formulates associations between mutations and expression
levels using bipartite graph where nodes are i) the set of mutated genes M and ii) the set
of genes exhibiting outlying gene expression G. An edge E(gi, gj) between nodes in
M and G are drawn under three conditions: gene gi ∈ M is mutated in patient p of the
population; gene gj shows outlying expression in patient p; and gi and gj are known to
interact according to an influence graph. The influence graph is constructed from the
computationally predicted pathways based on binary gene-gene interaction datasets
[1]. The genes in the same pathway are connected to each other in the influence graph.
Our approach then uses a greedy optimization approach to explain the most number of
nodes in G with the fewest number of nodes in M . The genes explaining the highest
number of outlying expression events are nominated as putative driver genes. Finally,
we apply statistical significance tests to these candidates based on null distributions
informed by stochastic resampling.

2 Datasets

The package includes the matrices deduced from part of the TCGA Glioblastoma multi-
forme (GBM) data. For both samplePatientMutationMatrix and samplePatientOutlierMatrix,
they are binary matrices and the row names are patients and the column names are
genes.

> library(DriverNet)
> data(samplePatientMutationMatrix)
> data(samplePatientOutlierMatrix)

1

> data(sampleInfluenceGraph)
> data(sampleGeneNames)
>

3 Rank genes

computeDrivers is the main function, which uses a greedy algorithm to rank each
mutated gene based on how many outliers gene the mutated gene can cover.

> # The main function to compute drivers
> driversList = computeDrivers(samplePatientMutationMatrix,
+
+
> drivers(driversList)[1:10]

samplePatientOutlierMatrix,sampleInfluenceGraph,
outputFolder=NULL, printToConsole=FALSE)

[1] "EGFR"
[6] "CDKN2A" "CYP27B1" "PIK3CA"

"MTAP"

"TP53"

"PTEN"
"PDGFRA"

"PIK3R1"
"IDH1"

4 Compute p-values

The statistical significance of the driver genes are assessed using a randomization
framework. The original datasets are permuted N times, and the algorithm is run on
randomly generated datasets N times and results on real data are assessed to see if they
are significantly different from the results on randomized datasets. This in an indirect
way of perturbing the bipartite graph corresponding to the original problem. To gen-
erate the random datasets, we keep the contents of patient-mutation, M , and patient-
outlier, G′, matrices the same but replace the gene symbols with a randomly selected
set of genes from the Ensmbl 54 protein-coding gene list. Using the same influence
graph, the algorithm is run on the new patient-mutation, M1...MN , and patient-outlier,
G′

1...G′

N , matrices.

Suppose D is the result of driver mutation discovery algorithm. D contains a
ranked list of driver genes with their corresponding node coverage in the bipartite
graph, B. The statistical significance of a gene g ∈ D with a corresponding node
coverage, COVg, is the fraction of times that we observe driver genes in our random
data runs i, with node coverage more than COVg.

> # random permute the gene labels to compute p-values
> randomDriversResult = computeRandomizedResult(
patMutMatrix=samplePatientMutationMatrix,
+
patOutMatrix=samplePatientOutlierMatrix,
+
influenceGraph=sampleInfluenceGraph,
+
geneNameList= sampleGeneNames, outputFolder=NULL,
+
printToConsole=FALSE,numberOfRandomTests=20, weight=FALSE,
+
purturbGraph=FALSE, purturbData=TRUE)
+

2

5 Summarize the results

Finlly, we provide a function to summarize the results.

> # Summarize the results
> res = resultSummary(driversList, randomDriversResult,
+
+
> res[1:2,]

samplePatientMutationMatrix,sampleInfluenceGraph,
outputFolder=NULL, printToConsole=FALSE)

rank gene

mut p-value total_events covered_events

EGFR "1" "EGFR" "50" "0"
TP53 "2" "TP53" "38" "0"

"16695"
"16695"

"791"
"659"

node_degree no.of.cases

EGFR "396"
TP53 "416"

"50"
"38"

connected.drivers

EGFR "1,2,4,5,6,8,9,13,14,15,16,17,18,19,20,21,23,26,27,28,31,32,33,34,36,38,39,40,44,45,47,48,50,52,55,56,59,60,61,62,63,64,65,67,68,70,72,73,84,86,87,88,89,90,93,95,98,102,103,109,110,121,124,127,130,133,137,138,139,140,141,142,144,146,148,150,153,156,158,164,166,167,169,170,173,175,181,186,189,191,192,193,196,199,201,202,205,206,208,209,212,213,214,216,217,222,224,230,231,233"
TP53 "1,2,4,5,6,8,9,12,13,14,17,18,19,20,21,23,26,27,28,30,33,34,36,38,39,40,42,43,44,45,47,48,50,51,52,55,56,59,60,63,64,65,67,68,70,72,73,74,86,87,88,89,90,91,95,96,102,105,107,112,121,127,129,130,131,132,135,137,138,139,140,141,142,146,150,153,156,157,158,164,166,167,171,172,173,175,177,181,185,191,193,196,199,201,202,205,206,208,211,212,213,214,215,216,217,222,225,226,231,233"

case

EGFR "TCGA-02-0083-01,TCGA-02-0064-01,TCGA-06-0209-01,TCGA-06-0169-01,TCGA-02-0043-01,TCGA-06-0219-01,TCGA-06-0185-01,TCGA-08-0353-01,TCGA-08-0390-01,TCGA-02-0021-01,TCGA-08-0246-01,TCGA-02-0007-01,TCGA-02-0089-01,TCGA-06-0148-01,TCGA-06-0157-01,TCGA-06-0127-01,TCGA-08-0349-01,TCGA-08-0380-01,TCGA-02-0116-01,TCGA-02-0046-01,TCGA-06-0125-01,TCGA-12-0616-01,TCGA-02-0003-01,TCGA-08-0356-01,TCGA-02-0023-01,TCGA-02-0048-01,TCGA-02-0009-01,TCGA-06-0150-01,TCGA-06-0646-01,TCGA-08-0375-01,TCGA-06-0143-01,TCGA-02-0016-01,TCGA-06-0208-01,TCGA-06-0138-01,TCGA-06-0187-01,TCGA-02-0004-01,TCGA-06-0126-01,TCGA-06-0173-01,TCGA-02-0054-01,TCGA-12-0619-01,TCGA-06-0124-01,TCGA-06-0211-01,TCGA-08-0355-01,TCGA-02-0068-01,TCGA-02-0071-01,TCGA-06-0122-01,TCGA-02-0102-01,TCGA-06-0645-01,TCGA-08-0244-01,TCGA-06-0216-01"
TP53 "TCGA-02-0083-01,TCGA-02-0037-01,TCGA-02-0025-01,TCGA-02-0114-01,TCGA-06-0184-01,TCGA-02-0075-01,TCGA-02-0084-01,TCGA-02-0055-01,TCGA-08-0353-01,TCGA-02-0026-01,TCGA-02-0089-01,TCGA-02-0046-01,TCGA-02-0003-01,TCGA-08-0389-01,TCGA-06-0190-01,TCGA-12-0618-01,TCGA-08-0245-01,TCGA-02-0048-01,TCGA-06-0150-01,TCGA-02-0080-01,TCGA-08-0359-01,TCGA-06-0195-01,TCGA-02-0004-01,TCGA-06-0206-01,TCGA-06-0188-01,TCGA-02-0024-01,TCGA-02-0058-01,TCGA-02-0074-01,TCGA-08-0351-01,TCGA-06-0159-01,TCGA-02-0054-01,TCGA-02-0011-01,TCGA-12-0619-01,TCGA-02-0033-01,TCGA-02-0001-01,TCGA-02-0034-01,TCGA-06-0130-01,TCGA-06-0221-01"

6 The influence of subtypes

From the current analysis, it seems that the DriverNet algorithm can find the drivers
in different subtypes, although cancer is a heterogeneous diease. For example, EGFR,
NF1, PDGFRA and IDH1 are the defining features of different subtypes. All these
genes are predicted to be drivers. In different subtypes, some genes are up-regulated or
down-regulated. The Gaussian distributions can capture the information and thus help
to predict the drivers. Finally, the current approach is robust to the gene expression
values.

References

[1] G. Wu, X. Feng, and L. Stein. A human functional protein interaction network and

its application to cancer data analysis. Genome biology, 11(5):R53, 2010.

3

