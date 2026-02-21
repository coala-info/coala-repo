Executable Analysis Document Supporting:
Cell-to-cell expression variability followed by
signal reinforcement progressively segregates
early mouse lineages

Yusuke Ohnishi, Wolfgang Huber, Akiko Tsumura, Minjung Kang, Panagio-

tis Xenopoulos, Kazuki Kurimoto, Andrzej K. Ole ´s, Marcos J. Araúzo-Bravo,

Mitinori Saitou, Anna-Katerina Hadjantonakis and Takashi Hiiragi

Nature Cell Biology 16(1), 27-37 (2014)

doi:10.1038/ncb2881

Andrzej K. Oleś, Wolfgang Huber

November 4, 2025

Contents

1

2

Data import and preparations .

1.1

Grouping of samples .

.

.

.

.

.

.

.

.

.

How many genes are expressed? .

2.1

2.2

By variability .

.

.

.

.

.

.

.

.

.

.

By Affymetrix present/absent calls.

3

Cluster stability analysis .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.
.

.

.

.

.

.

.

.

.

.

.

.

.

.
.

.

.

.

.

.

.

.

.

.

.

.

.

.
.

.

.

.

.

.

.

.

.

.

.

.

.

.

.
.

.

.

.

.

.

.

.

.

.

.

.

.

.

.
.

.

.

.

.

.

.

.

.

.

.

.

.

.

.
.

.

.

.

.

.

.

.

.

.

.

.

.

.

.
.

.

.

.

.

.

.

.

.

.

.

.

.

.

.
.

.

.

.

.

.

.

.

.

.

.

.

.

.

.
.

.

.

5

6

7

7

8

10

10

11

13

15

15

16
18

18

24

3.1

3.2

3.3

4.1

4.2

E3.25 and E3.5 WT samples .

E3.5/E4.5 WT and E4.5 FGF4-KO samples .

E3.25 WT and E3.5 FGF4-KO samples .

4

Lineage Markers .

.

.

.

.

.

.

.

.

.

Clustering of E3.5 WT samples .

Differentially expressed genes in E3.5 samples .
.
.
4.2.1

Heatmaps.

.

.

.

.

.

.

.

.

.

.

.

.

.

4.3

Differentially expressed genes in E4.5 samples .

5

Differentially expressed genes from E3.25 to E3.5 .

6.1

6.2

6.3

7.1

7.2

7.3

7.4

7.5

7.6

9.1

9.2

10.1

10.2

10.3

10.4

Analysis report: Ohnishi et al., 2014

6

Principal Component Analysis .

On the WT samples .

.

.

.

WT and FGF4-KO samples .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

Heatmap of all WT and FGF4-KO samples .

7

Further analyses of FGF4-KO.

.

.

.

.

.

.

.

.

FGF4’s expression pattern in E3.25 samples .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

Are the E3.25 WT samples with low FGF4 expression more similar
to the FGF4-KO samples than those with high FGF4? .
.

.

.

.

.

.

Variability of the FGF4-KO samples compared to WT samples .

.

.

Do the FGF4-KO samples correspond to a particularly early sub-
stage within E3.25 (as indicated by the number of cells)? .
.

.

.

.

Heatmap of E3.25 WT and E3.25 FGF-KO samples .

.

.

.

.

.

.

.

.

.

.

Differentially expressed genes between FGF4-KO and WT (PE, EPI)
at E3.5 .
.
.
.
7.6.1
.
.
7.6.2
.
7.6.3

.
.
.
The probes for FGF4 .
.
Behaviour of the control probes .
.
Gene set enrichment analysis .

.
.
.
.

.
.
.
.

.
.
.
.

.
.
.
.

.
.
.
.

.
.
.
.

.
.
.
.

.
.
.
.

.
.
.
.

.
.
.
.

.
.
.
.

.
.
.
.

.
.
.
.

.
.

.
.

.
.

.

.

.

.

.

8

9

Jensen-Shannon Divergence analysis .

Classification of temporal profiles.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

Comparison of microarray data with qPCR results .

Rule-based classification .
.
Table export .
9.2.1
.
.
Comparison with manual classification .
9.2.2

.
.

.
.

.
.

.
.

.
.

.
.

.
.

.
.

.

.

10

qPCR data analysis .

.

.

.

.

.

Heatmaps for all data in xq .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

Heatmaps for the seven selected genes and selected samples .

Distribution of the data and discretisation .

Temporal order - hierarchy .
.
10.4.1 How significant is this? .

.
.

.
.

.
.

.
.

.
.

.
.

.

.
.

.

.
.

A

B

C

D

Influence of cell position on gene expression .

Correlation between Fgf ligands and Fgf receptors .

Session info .

.

.

.

.

.

.

.

.

.

.

.

.

.

The data import script readdata.R .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.
.
.

.

.

.

.

.

.
.
.

.

.

.

.

.

.
.
.

.

.

.

.

.

.
.
.

.

.

.

.

.

.
.
.

.

.

.

.

.

.
.
.

.

.

.
.
.

.

.

.
.
.

.

.

.
.
.

.

.

.

.
.

.

.

.
.

.

.

.
.

.

.

.
.

.

.

.
.

.

.

.

.

.

.
.

.

.

.

.

.

.
.

.

.

.

.

.

.
.

.

.

.

.

.

.

.

.
.
.

.

.

.

.

.
.

.

.

.

.

.

.

.

.
.
.

.

.

.

.

.
.

.

.

.

.

26

26

29

31

33

33

34

35

38

38

38
43
43
44

49

52

52

54
56
56

59

59

59

60

63
65

67

68

68

69

2

Analysis report: Ohnishi et al., 2014

List of Figures

.

15

. . . . . . . . . .
Histogram of standard deviation of each probe set’s signal
1
Present/absent calls.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2
Cluster stability analysis with E3.25 and E3.5 WT samples. . . . . . . . . . .
3
Cluster stability analysis with E3.5/E4.5 WT and E4.5 FGF4-KO samples. . .
4
Cluster stability analysis with E3.25 WT and E3.5 FGF4-KO samples.
. . . .
5
Heatmap of the E3.25 WT and E3.5 FGF4-KO samples.
. . . . . . . . . . .
6
The influence of the parameter ngenes on the clustering result. . . . . . . . .
7
.
Determination of the cutoff for independent filtering on E3.5 WT samples.
8
. . . . . . . . . . . . . . . . . . . . . . . . . . .
Heatmap of all WT arrays.
9
. . . . . . . . .
10 Heatmap of all WT arrays with duplicate features collapsed.
11 Heatmap of only the WT arrays from E3.5.
. . . . . . . . . . . . . . . . . .
12 Heatmap of only the WT arrays from E3.5 with duplicate features collapsed.
13 Determination of the cutoff for independent filtering on E4.5 WT samples.
14 Heatmap of differentially expressed genes from E3.25 to E3.5 (EPI), and from
E3.25 to E3.5 (PE). . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
Projection of sample expression profiles on the differential expression signature
from Section 4.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
PCA plot, using WT samples. . . . . . . . . . . . . . . . . . . . . . . . . . .
16
Sorted loadings (coefficients) of the first two PCA vectors.
. . . . . . . . . .
17
. . . . . . . . . . . . . . . . . . .
PCA plot for WT and FGF4-KO samples.
18
Same as Figure 18, with labels indicating the array (sample) number.
. . . .
19
Same as Figure 18, with labels indicating Total.number.of.cells. . . . . . .
20
21 Heatmap of all arrays. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
22
FGF4 expression.
FGF4 expression (microarray signal) in WT and KO samples. . . . . . . . . .
23
24 MDS plot of the E3.25 wild type and FGF4-KO samples.
. . . . . . . . . . .
Relationship between FGF4 expression and similarity of the transcription pro-
25
file to the KO. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
26 Variability of different groups of samples. . . . . . . . . . . . . . . . . . . . .
27 Distance of the E3.25 WT samples to the mean profile of FGF4-KO. . . . . .
28 Distance of the E3.25 WT samples to the mean profile of FGF4-KO. . . . . .
29 Heatmap of all E3.25 WT and E3.25 FGF-KO samples. . . . . . . . . . . . .
30 Differentially expressed genes between FGF4-KO and WT (EPI, PE) at E3.5.
31 Differentially expressed genes between FGF4-KO and WT (EPI, PE) at E3.5.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
32 The probes for FGF4.
33 Behaviour of some control probe sets.
. . . . . . . . . . . . . . . . . . . . .
34 Differentially expressed genes between FGF4-KO and WT (EPI, PE) at E3.5.
35
. . . . . . . . . . . . . . . . . . . . . . . . . .
36 Temporal change of the lineage marker expression . . . . . . . . . . . . . . .
37 Boxplots of the microarray expression data for exemplary genes.
. . . . . . .
38 Heatmap of all classes . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . .
39 Heatmap of the qPCR data set.
40 Heatmap of the qPCR data for the 7 selected genes.
. . . . . . . . . . . . .
41 Heatmap for the 7 selected genes and the E3.25/E3.5/E4.5 PE samples. . . .
42 Visualisation of the qPCR data for the seven genes. . . . . . . . . . . . . . .
43 Heatmap for the discretized values. . . . . . . . . . . . . . . . . . . . . . . .
44 Heatmaps, sorted . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
45 Distribution of bootstrap-resampled optimal costs ("disorder penalties"). . . .
. . . . . . . . . . . . . . . . . . . . . . . . .
46 Multi-dimensional scaling plot.

Jensen-Shannon divergences.

7
9
11
12
13
14
15
17
19
20
21
22
23

25

27
28
28
30
30
31
32
33
34
35

36
37
39
40
41
42
43
44
45
47
51
53
54
57
60
60
61
62
63
64
66
67

3

Analysis report: Ohnishi et al., 2014

47

Correlation between Fgf ligands and Fgf receptors. . . . . . . . . . . . . . . .

68

4

Analysis report: Ohnishi et al., 2014

1

Data import and preparations

We first load the required R package and set the random seed.

> library("Hiiragi2013")

> set.seed(2013)

The array data consist of a set of CEL files (the output from the Affymetrix scanner /
image analysis software), whose annotation is provided in an Excel table. The CEL files are
deposited at Array Express under the accession code E-MTAB-1681. The import of these
data and metadata is performed by the script readdata.R, whose code is shown on page 69
and following. This script also performs data preprocessing (“normalisation”) using the RMA
method [1] and arranges the metadata to support the analyses presented in the following.
Let us load the result of readdata.R.

> data("x")

> x

ExpressionSet (storageMode: lockedEnvironment)

assayData: 45101 features, 101 samples

element names: exprs

protocolData

sampleNames: 1 E3.25 2 E3.25 ... 101 E4.5 (FGF4-KO) (101 total)

varLabels: ScanDate

varMetadata: labelDescription

phenoData

sampleNames: 1 E3.25 2 E3.25 ... 101 E4.5 (FGF4-KO) (101 total)

varLabels: File.name Embryonic.day ... sampleColour (8 total)

varMetadata: labelDescription

featureData

featureNames: 1415670_at 1415671_at ... AFFX-TrpnX-M_at (45101 total)
fvarLabels: symbol genename ensembl

fvarMetadata: labelDescription

experimentData: use 'experimentData(object)'

Annotation: mouse4302

x is an ExpressionSet object containing the normalized data for the 101 arrays. These include
66 wild type (WT) samples

> with(subset(pData(x), genotype=="WT"),

+

addmargins(table(Embryonic.day, Total.number.of.cells), 2))

Total.number.of.cells

Embryonic.day 32 33 34 41 49 50 62 75 91 207 <NA> Sum

E3.25 11 6 5 4 4 6 0 0

E3.5

E4.5

0 0 0 0 0 0 6 8

0 0 0 0 0 0 0 0

0

8

0

0

0

8

0

0

0

36

22

8

and 35 FGF4-KO mutants

> with(subset(pData(x), genotype=="FGF4-KO"), table(Embryonic.day))

Embryonic.day

E3.25

E3.5 E4.5

5

Analysis report: Ohnishi et al., 2014

17

8

10

1.1

Grouping of samples
The preprocessed data object defines the grouping of the samples and an associated colour
map, which will be used in the plots throughout this report.

> groups = split(seq_len(ncol(x)), pData(x)$sampleGroup)
> sapply(groups, length)

E3.25 E3.25 (FGF4-KO)

E3.5 (EPI)

E3.5 (FGF4-KO)

E3.5 (PE)

36

17

11

8

11

E4.5 (EPI) E4.5 (FGF4-KO)

E4.5 (PE)

4

10

4

Each sample has assigned a colour which will be used in the subsequent plots.

> sampleColourMap = setNames(unique(pData(x)$sampleColour), unique(pData(x)$sampleGroup))

> sampleColourMap

E3.25

"#CAB2D6"

E3.5 (PE)

"#B2DF8A"

E3.5 (EPI)

"#A6CEE3"

E4.5 (PE)

"#33A02C"

E4.5 (EPI)

"#1F78B4"

E3.25 (FGF4-KO) E3.5 (FGF4-KO) E4.5 (FGF4-KO)

"#FDBF6F"

"#FF7F00"

"#E31A1C"

For some analyses, we need to specifically address the four probes mapping to FGF4.

> FGF4probes = (fData(x)$symbol == "Fgf4")

> stopifnot(sum(FGF4probes)==4)

6

Analysis report: Ohnishi et al., 2014

2

How many genes are expressed?

In this section, we aim to determine how many distinct mRNAs were detected by the arrays
over the background level in the 66 WT samples.

> selectedSamples = with(pData(x), genotype=="WT")

> xe = x[, selectedSamples]

> stopifnot(ncol(xe)==66)

Because of the presence of background signal (stray light, cross-hybridisation), the answer
to the question whether a transcript is present in a sample, based on Affymetrix GeneChip
data, is not straightforward.
In addition, the problem is complicated by the fact that the
background signal is probe-sequence dependent. We perform two approaches that are used
in the literature.

2.1

By variability
The first approach is based on the notion that the existence of variability of signal across
samples is a more specific indicator of a transcript’s presence, than the absolute signal inten-
sity [2]. Let us plot the histogram of the standard deviation of each probe set’s signal, across
the 66 samples (Figure 1).

> sdxe = rowSds(exprs(xe))

> thresh = 0.5

> hist(sdxe, 100, col = "skyblue")

> abline(v = thresh)

Figure 1: Histogram of standard deviation of each probe set’s signal across the 66 samples.

Based on the (visually) chosen threshold1 thresh, we find the following numbers of probe
sets and unique target gene identifiers.

> table(sdxe>=thresh)

FALSE

TRUE

24140 20961

> length(unique(fData(xe)$ensembl[ sdxe>=thresh ]))

1One could also come up with a more automated, “statistical” rule, but the downstream result would be
very similar.

7

Histogram of sdxesdxeFrequency0123020006000Analysis report: Ohnishi et al., 2014

[1] 11130

2.2

By Affymetrix present/absent calls

The second approach uses the Wilcoxon signed rank-based gene expression presence/absence
detection algorithm first implemented in the Affymetrix Microarray Suite version 5.

> data("a")

> stopifnot(nrow(pData(a))==ncol(x))

> mas5c = mas5calls(a[, selectedSamples])

where a is an AffyBatch object containing the unprocessed raw intensity values. Some
bookkeeping and shuffling around is needed to compute the number of genes, as defined
by unique Ensembl identifiers, for the classes present (P), marginal (M) and absent (A). If
multiple probe sets map to one gene (which happens frequently on this array type), then P
trumps M trumps A.

> myUnique = function(x) setdiff(unique(x), "")

> allEnsemblIDs = myUnique(fData(xe)$ensembl)

> callsPerGenePerArray = matrix(0, nrow = length(allEnsemblIDs), ncol = ncol(mas5c)+1,

+
> for(j in seq_len(ncol(mas5c))) {
+

for(k in 1:2) {

dimnames = list(allEnsemblIDs, NULL))

ids = myUnique(fData(xe)$ensembl[ exprs(mas5c)[, j]==c("M","P")[k] ])

callsPerGenePerArray[ids, j] = k

+

+

+

+ }

}

> fractionOfArrays = 0.1

> for(k in 1:2) {

ids = myUnique(fData(xe)$ensembl[ apply(exprs(mas5c)==c("M","P")[k], 1,

function(v) (mean(v)>fractionOfArrays)) ])

callsPerGenePerArray[ids, ncol(mas5c)+1] = k

+

+

+

+ }

> numCalls = apply(callsPerGenePerArray, 2, table)
> numCalls = numCalls[rev(seq_len(nrow(numCalls))), ]

> numCalls[, 67]

2

1

0

11038

75 6258

> gplots::barplot2(numCalls, names.arg = paste(seq_len(ncol(callsPerGenePerArray))),
+

col = c(RColorBrewer::brewer.pal(8, "Paired")[2:1], "#e8e8e8"), ylab = "number of genes")

See Figure 2.

8

Analysis report: Ohnishi et al., 2014

Figure 2: Present/absent calls. The barplot shows, for each of the 66 arrays, the number of genes targeted
by probe sets with "A" (light grey), "M" (light blue) and "P" (blue) calls. The 67-th bar at the very right
corresponds to detection in at least 10% of arrays.

9

1357911141720232629323538414447505356596265number of genes050001000015000Analysis report: Ohnishi et al., 2014

3

3.1

Cluster stability analysis

E3.25 and E3.5 WT samples
In this section, we investigate the hypothesis that the data for E3.5 fall ’naturally’ into two
clusters (associated with PE and EPI), while the data for E3.25 do not. For this, we use the
framework of the clue package [3]. Briefly, the below function clusterResampling performs
the following steps:

1. Draw a random subset of the full data (the full data are either all E3.25 or all E3.5

samples) by selecting 67% of the samples.

2. Select the top ngenes (see below) features by overall variance (in the subset).

3. Apply k-means clustering, and predict the cluster memberships of the samples that
were not in the subset with the cl_predict method, through their proximity to the
cluster centres.

4. Repeat steps 1-3 for B = 250 times.

5. Apply consensus clustering (cl_consensus).

6. For each of the B = 250 clusterings, measure the agreement with the consensus
(cl_agreement); here, good agreement is indicated by a value of 1, and less agree-
ment by smaller values. If the agreement is generally high, then the clustering into k
classes can be considered stable and reproducible; inversely, if it is low, then no stable
partition of the samples into k clusters is evident.

As a measure of between-cluster distance for the consensus clustering, the Euclidean dissim-
ilarity of the memberships is used, i. e., the square root of the minimal sum of the squared
differences of u and all column permutations of v, where u and v are the cluster membership
matrices. As agreement measure for step 6, the quantity 1 − d/m is used, where d is the
Euclidean dissimilarity, and m is an upper bound for the maximal Euclidean dissimilarity [4].

> clusterResampling = function(x, ngenes, k = 2, B = 250, prob = 0.67) {

+

+

+

+

+

+

+

+

+

+

+

+

+

mat = exprs(x)
ce = cl_ensemble(list = lapply(seq_len(B), function(b) {

selSamps = sample(ncol(mat), size = round(prob*ncol(mat)), replace = FALSE)
submat = mat[, selSamps, drop = FALSE]
selFeats = order(rowVars(submat), decreasing = TRUE)[seq_len(ngenes)]
submat = submat[selFeats,, drop = FALSE]

pamres = cluster::pam(t(submat), k = k, metric = "euclidean")
pred = cl_predict(pamres, t(mat[selFeats, ]), "memberships")
as.cl_partition(pred)

}))
cons = cl_consensus(ce)
ag = sapply(ce, cl_agreement, y = cons)
return(list(agreements = ag, consensus = cons))

+ }

> ce = list(

+

+

+

"E3.25" = clusterResampling(x[, unlist(groups[c("E3.25")])], ngenes = 20),

"E3.5" = clusterResampling(x[, unlist(groups[c("E3.5 (EPI)", "E3.5 (PE)")])],

ngenes = 20))

10

Analysis report: Ohnishi et al., 2014

The results are shown in Figure 3. They confirm the hypothesis stated at the beginning of
this section.

> par(mfrow = c(1,2))

> colours = c(sampleColourMap["E3.25"], RColorBrewer::brewer.pal(9,"Set1")[9])
> boxplot(lapply(ce, `[[`, "agreements"), ylab = "agreement probabilities", col = colours)
> mems = lapply(ce, function(x) sort(cl_membership(x$consensus)[, 1]))
> mgrp = lapply(seq(along = mems), function(i) rep(i, times = length(mems[[i]])))

> myjitter = function(x) x+seq(-.4, +.4, length.out = length(x))

> plot(unlist(lapply(mgrp, myjitter)), unlist(mems),

+

+

col = colours[unlist(mgrp)], ylab = "membership probabilities",

xlab = "consensus clustering", xaxt = "n", pch = 16)

> text(x = 1:2, y = par("usr")[3], labels = c("E3.25","E3.5"), adj = c(0.5, 1.4), xpd = NA)

Figure 3: Cluster stability analysis with E3.25 and E3.5 WT samples. Left: boxplot of the cluster agree-
ments with the consensus, for the B=250 clusterings; 1 indicates perfect agreement, and the value de-
creases with worse agreement. The statistical significance of the difference is confirmed by a Wilcoxon test
in the main text. Right: membership probabilities of the consensus clustering; colours are as in the left
panel. For E3.25, the probabilities are diffuse, indicating that the individual (resampled) clusterings disagree
a lot, whereas for E3.5, the distribution is bimodal, with only one ambiguous sample.

We can compute a p-value for the statistical significance of the two distributions shown in
the boxplot of Figure 3.

> wilcox.test(ce$E3.25$agreements, ce$E3.5$agreements)

Wilcoxon rank sum test with continuity correction

data:

ce$E3.25$agreements and ce$E3.5$agreements

W = 266, p-value < 2.2e-16

alternative hypothesis: true location shift is not equal to 0

3.2

E3.5/E4.5 WT and E4.5 FGF4-KO samples
From the PCA plot in Figure 18, one might derive the impression that the FGF4 KO E4.5
cells cluster together with the EPI E3.5 cells. Here, we perform a cluster stability analysis
analogous to that in Section 3.1, using the FGF4-KO E4.5 cells together with

1. the WT EPI E3.5 and WT PE E3.5 cells,

2. the WT EPI E4.5 and WT PE E4.5 cells.

11

E3.25E3.50.50.60.70.80.9agreement probabilities0.00.20.40.60.81.0consensus clusteringmembership probabilitiesE3.25E3.5Analysis report: Ohnishi et al., 2014

As we will see in the following, in each of the above cases, three distinct clusters exist, and the
above mentioned impression is not substantiated; in addition, we can also clearly distinguish
the WT and KO samples at E4.5.

> sampleSets = list(

+

+

`E3.5` = unlist(groups[c("E3.5 (EPI)", "E3.5 (PE)", "E4.5 (FGF4-KO)")]),
`E4.5` = unlist(groups[c("E4.5 (EPI)", "E4.5 (PE)", "E4.5 (FGF4-KO)")]))

> k = 3

> csa = lapply(sampleSets, function(samps) list(

+

+

colours = x$sampleColour[samps],

r = clusterResampling(x[!FGF4probes, samps], ngenes = 20, k = k)))

> par(mfrow = c(2,3))

> for(i in seq(along = csa))
for(j in seq_len(k))

+

+

+

+

plot(cl_membership(csa[[i]]$r$consensus)[, j],

ylab = paste0("P(cluster ", j, ")"), xlab = "samples",

main = names(sampleSets)[i], col = csa[[i]]$colours, pch = 16, cex = 1.5)

Figure 4: Cluster stability analysis with E3.5/E4.5 WT and E4.5 FGF4-KO samples. Top row: Results of
the cluster stability analysis with the E3.5 (EPI), E3.5 (PE), E4.5 (FGF4-KO) samples. Shown on the y-
axis is the membership probability P in the three clusters. The actual group membership of the samples
(known to us but not used by the clustering algorithm) is indicated by the colours. Bottom row: Simi-
larly for E4.5 (EPI), E4.5 (PE), E4.5 (FGF4-KO). These analyses indicate that the FGF4-KO very clearly
separate from the WT samples, which between themselves tend to form the clusters already described in
Section 3.1.

The results of the above code are shown in Figure 4 and indicate that indeed FGF4-KO E4.5
cells are distinct from either of the WT groups.

12

0510152025300.00.20.40.60.81.0E3.5samplesP(cluster 1)0510152025300.00.20.40.60.8E3.5samplesP(cluster 2)0510152025300.00.20.40.60.81.0E3.5samplesP(cluster 3)510150.00.20.40.60.8E4.5samplesP(cluster 1)510150.00.20.40.60.81.0E4.5samplesP(cluster 2)510150.00.20.40.60.81.0E4.5samplesP(cluster 3)Analysis report: Ohnishi et al., 2014

3.3

E3.25 WT and E3.5 FGF4-KO samples
Although in the 2-dimensional PCA projection in Figure 18 dots representing FGF4-KO E3.5
cells appear to overlap with ones representing WT E3.25 samples, cluster stability analysis
analogous to that from the previous section indicates that they form a distinct population
(Figure 5).

> sampleSets = unlist(groups[c("E3.25", "E3.5 (FGF4-KO)")])

> selSamples = x[!FGF4probes, sampleSets]

> resampledSampleSet = clusterResampling(selSamples, ngenes = 20)

> par(mfrow = c(1,2))

>

+

+

+

for(j in seq_len(2))

plot(cl_membership(resampledSampleSet$consensus)[, j],

ylab = paste0("P(cluster ", j, ")"), xlab = "Samples",

col = x$sampleColour[sampleSets], pch = 16, cex = 1.5)

Figure 5: Cluster stability analysis with E3.25 WT and E3.5 FGF4-KO samples. Results of the cluster sta-
bility analysis with the E3.25 WT and E3.5 FGF4-KO samples. The y-axis shows the membership probabil-
ity in the two clusters. The actual group membership of the samples (known but not used by the clustering
algorithm) is indicated by the colours.

The cluster stability analysis of the two clusters reveals that the FGF4-KO samples at E3.5
form a single, tight cluster, and are consistently together throughout all of the resamplings.
The E3.25 WT cells, on the other hand, are much more diffuse and in the course of the
resampling, each cell does not necassaryly cluster together with the same cluster all the time.
Therefore, the difference is prevalently one of variability—the E3.25 WT are quite variable
and cover a large "expression space", whereas the FGF4-KO are stuck on one particular,
narrowly defined expresion profile. This is also evident from the heatmap showed in Figure 6.

> ngenes = 100
> selFeats = order(rowVars(exprs(selSamples)), decreasing = TRUE)[seq_len(ngenes)]
> myHeatmap(selSamples[selFeats, ], collapseDuplicateFeatures = TRUE, haveColDend = TRUE)

13

0102030400.00.20.40.60.81.0SamplesP(cluster 1)0102030400.00.20.40.60.81.0SamplesP(cluster 2)Analysis report: Ohnishi et al., 2014

Figure 6: Heatmap of the E3.25 WT and E3.5 FGF4-KO samples. Data of the 100 genes with the highest
variance. Even though a few individual cells from E3.25 WT do indeed seem to have similar expression
profiles as ones from E3.5 FGF4-KO, which all cluster together, the populations are not the same.

14

Magea5GsnThoc2Tspan8Ampd2GcaSmad4Tob24930550L24RikBaiap2l1Iqgap1Pkp21456661_atDusp1Dmxl2Med14Rragd1436936_s_atRock1Pofut2AdkAasdhSlc44a22410024N13RikTtll1Dvl11436944_x_atHmgb2Qrsl1Sdc1LcorAmmecr1lPnliprp2Acbd5DspCryzDynlt31448022_at1437534_atMt1Pdgfra1439255_s_atDdx3xB230354K17RikEvi5Ifi35Cd24aTktl1Tubb2a1438786_a_atPmaip11455904_atPnisrLgals6Lrrfip1Stk3Atp1b1NclTmem180Tnks2CcniEpha4TsnSucoNbeal1Rhpn2Socs3CtszLy6eAldh18a1Yipf6Acap2Casp8ap2ApelaPrdm14Acsl4Snx61418072_atDdx3yRcn1Spp1C77370PtplaPbx3Vma21Fam104aAnkrd24Slc35a2Snord104Dppa2Gm4354Cnot4Ints5Kbtbd7Chmp1bSoat1Pum1Zscan2118 E3.2522 E3.2519 E3.2520 E3.2521 E3.2533 E3.2531 E3.2534 E3.2535 E3.2532 E3.2536 E3.2513 E3.254 E3.2511 E3.2514 E3.2512 E3.2515 E3.2516 E3.2517 E3.255 E3.259 E3.257 E3.252 E3.253 E3.256 E3.258 E3.251 E3.2510 E3.2526 E3.2584 E3.5 (FGF4−KO)90 E3.5 (FGF4−KO)87 E3.5 (FGF4−KO)91 E3.5 (FGF4−KO)89 E3.5 (FGF4−KO)85 E3.5 (FGF4−KO)86 E3.5 (FGF4−KO)88 E3.5 (FGF4−KO)28 E3.2529 E3.2527 E3.2530 E3.2525 E3.2523 E3.2524 E3.25−3−2−1012Analysis report: Ohnishi et al., 2014

4

Lineage Markers

In this section, the following steps are performed:

1. Section 4.1: Cluster the arrays from E3.5 into two clusters (using k-means clustering

with k = 2 on the overall expression profiles).

2. Section 4.2: Determine the genes that are differentially expressed between these two
clusters, according to a t-test with a nominal cutoff of false discovery rate (FDR) of
10%. These genes are reported in the table differentially-expressed-features-
3.5.csv, which can be imported into Excel etc.

3. Section 4.2.1: Present a heatmap of these genes.

4. Section 4.3: Produce an analogous table differentially-expressed-features-4.5.csv

for the E4.5 samples.

4.1

Clustering of E3.5 WT samples
The function pamCluster selects the ngenes most variable genes in the data matrix x and
seeks for two clusters using the partitioning around medoids method. To assess the influence
of the parameter ngenes, we call the algorithm for multiple choices, from 10 to 10000.

> ngenes = c(10, 25, 50, 100, 250, 500, 1000, 2500, 5000, 10000)

> xForClustering = x[, x$Embryonic.day=="E3.5" & x$genotype=="WT"]

> clusters = sapply(ngenes, pamCluster, x = xForClustering)

The result is displayed in Figure 7.

> image(x = seq_len(nrow(clusters)), y = seq_len(ncol(clusters)), z = clusters,
+
col = c("#f0f0f0", "#000000"), ylab = "ngenes", xlab = "samples", yaxt = "n")
> text(x = 0, y = seq_len(ncol(clusters)), paste(ngenes), xpd = NA, adj = c(1, 0.5))

Figure 7: The influence of the parameter ngenes on the clustering result. Each of the 22 samples corre-
sponds to a column of the matrix, the rows of the matrix correspond to different choices for ngenes. Clus-
ter membership is indicated by the colour code (light gray vs black). For most samples, cluster membership
is consistent throughout the range of ngenes from 10 to 1000. ngenes = 1000 is used for subsequent analy-
ses.

15

5101520samplesngenes10255010025050010002500500010000Analysis report: Ohnishi et al., 2014

From Figure 7 we can conclude that we can proceed with the choice of

> i = which(ngenes==1000); stopifnot(length(i)==1)

> ngenes = ngenes[i]

> clusters = factor(clusters[, i])

Now we can check how the microarray-data driven clustering compares with the annotation
of the cells that was provided by Yusuke in the Excel table:

> table(clusters, pData(x)[names(clusters), "lineage"])

clusters EPI PE

1

0 11

2 11 0

As we can see, the clustering perfectly agrees with Yusuke’s labeling. Note: the lineage
annotation was used here only to assess the clustering output. It is not used as input for any
of the data analyses shown in this document.

> cbind(unlist(groups[c("E3.5 (EPI)", "E3.5 (PE)")]), ce[[2]]$consensus$.Data[, 1])

[,1] [,2]

E3.5 (EPI)1

39 1.000

E3.5 (EPI)2

40 1.000

E3.5 (EPI)3

42 1.000

E3.5 (EPI)4

44 0.996

E3.5 (EPI)5

45 0.996

E3.5 (EPI)6

46 0.996

E3.5 (EPI)7

47 0.996

E3.5 (EPI)8

48 0.996

E3.5 (EPI)9

55 0.960

E3.5 (EPI)10

56 1.000

E3.5 (EPI)11

57 1.000

E3.5 (PE)1

E3.5 (PE)2

E3.5 (PE)3

E3.5 (PE)4

E3.5 (PE)5

E3.5 (PE)6

E3.5 (PE)7

E3.5 (PE)8

E3.5 (PE)9

37 0.000

38 0.044

41 0.000

43 0.100

49 0.440

50 0.000

51 0.000

52 0.028

53 0.008

E3.5 (PE)10

54 0.088

E3.5 (PE)11

58 0.004

4.2

Differentially expressed genes in E3.5 samples

> deCluster = rowttests(xForClustering, fac = clusters)

The code below, which produces Figure 8, is used to set the parameters for the independent
filtering step [2].

16

Analysis report: Ohnishi et al., 2014

> varianceRank = rank(-rowVars(exprs(xForClustering)))

> plot(varianceRank, deCluster$p.value, pch = ".", log = "y",

+

+

main = "Parameters for the independent filtering",

xlab = "variance rank", ylab = "p-value")

> nFilt = 20000

> smallpValue = 1e-4

> abline(v = nFilt, col = "blue")

> abline(h = smallpValue, col = "orange")

Figure 8: Determination of the cutoff for independent filtering on E3.5 WT samples. Each dot corresponds
to one of the 45101 features on the array, the x-axis shows the rank of the features overall variance across
the 22 arrays in xForClustering, the y-axis the p-value from the t-test on a logarithmic scale. The hori-
zontal orange line corresponds to a p-value of 1e-04. The vertical blue line indicates the cutoff implied by
taking only the 20000 features with the highest overall variance. We can see that if we apply this cutoff,
we in fact do not miss any of the features with p-value smaller than 1e-04.

Let’s perform false discovery rate (FDR) p-value adjustment using the Benjamini-Hochberg
method [5].

> passfilter = which(varianceRank<=nFilt)
> adjp = rep(NA_real_, nrow(x))
> adjp[passfilter] = p.adjust(deCluster$p.value[passfilter], method = "BH")

> ord = order(adjp)

> numFeaturesReport = 200
> differentially = ord[seq_len(numFeaturesReport)]
> length(unique(fData(x)$symbol[differentially]))

[1] 163

The FDR of the selected set of numFeaturesReport = 200 features is 22.8%, and these
correspond to 163 unique genes. In the following code chunk, we write out the results table
into a CSV file.

> deFeat35 = cbind(deCluster[differentially,], `FDR-adjusted p-value` = adjp[differentially],
+

fData(x)[differentially,])

> write.csv(deFeat35, file = "differentially-expressed-features-3.5.csv")

17

Analysis report: Ohnishi et al., 2014

4.2.1 Heatmaps

To visualise the data, we use the helper function myHeatmap. Heatmaps produced by the
function calls below are shown in Figures 9–12.

> myHeatmap(x[differentially, x$genotype=="WT"])

> myHeatmap(x[differentially, x$genotype=="WT"], collapseDuplicateFeatures = TRUE)

> myHeatmap(xForClustering[differentially, ])

> myHeatmap(xForClustering[differentially, ], collapseDuplicateFeatures = TRUE)

4.3

Differentially expressed genes in E4.5 samples
The following code is analogous to Section 4.2.

> x45 = x[, x$Embryonic.day=="E4.5" & x$genotype=="WT"]

> de45 = rowttests(x45, fac = "lineage")

> varianceRank = rank(-rowVars(exprs(x45)))

> plot(varianceRank, de45$p.value, pch = ".", log = "y",

+

+

main = "Parameters for the independent filtering",

xlab = "variance rank", ylab = "p-value")

> abline(v = nFilt, col = "blue")

> abline(h = smallpValue, col = "orange")

See Figure 13.

> passfilter = which(varianceRank<=nFilt)
> adjp = rep(NA_real_, nrow(x))
> adjp[passfilter] = p.adjust(de45$p.value[passfilter], method = "BH")

> ord = order(adjp)
> differentially = ord[seq_len(numFeaturesReport)]
> length(unique(fData(x)$symbol[differentially]))

[1] 175

The FDR of the selected set of numFeaturesReport = 200 features is 1.04%, and these
correspond to 175 unique genes. The following code chunk writes out the results table into
a CSV file.

> deFeat45 = cbind(de45[differentially, ], `FDR-adjusted p-value` = adjp[differentially],
+

fData(x)[differentially, ])

> write.csv(deFeat45, file = "differentially-expressed-features-4.5.csv")

18

Analysis report: Ohnishi et al., 2014

Figure 9: Heatmap of all WT arrays. Data from 200 features with evidence of differential expression be-
tween the two clusters are shown. For some genes, multiple features are shown.

19

Mpc1Larp1Tfap2cPrpsap2SvipMier3Tpd52Klf2Rnf213SpicSpicNanogSfnBcl2l14Slc1a1WtapWtapTmem41bTrim43aYpel5Zfand2aPdgfaSlc28a3Il17rcCyp2s1HexbHexbAFFX−18SRNAMur/X00686_M_atSlc2a3Slc2a3Itgb7Prdm14Fgf4Fgf4Fgf4BokTceb3Hs6st1RykSaal1Pak4Dusp19Usp9x1460221_atYwhagGspt1Gspt1Ccbl1Ccbl1Ccbl1Sgk1Rhoa1415790_atPfkfb3Scamp1Rbm47Grb7Rab3il1Kif3bSlc30a2Atg16l2Bcl2l14Srxn1Cldn4Dennd1aElovl7Prps1Spint1Pttg1Tpd52Rif1Hdac1Fgd1Zp3Hsd17b14Hsd17b14Akap1Plekha7Myo10Ttc39bMalMalLiphPltpSocs2Sox2Morc1Hnrnpa0PmlAkr1c13Duox1Asns1435761_atNudt8Aldh18a1Mllt1Rnpc3MarcksFam159bAtg13Fbxl20TesMarcksSmap1AspmTbpl1Uap1Uap1Znhit1LgalslCrlf3Tmem209Tsc22d1Tsc22d1Tsc22d1Tsc22d1Golga4Golga4B3gnt7TfpiSlc46a3Ddt1424365_atIcoslDnmt3lSparcTfpiTfpi1435789_x_at1447633_x_atNdufb6B4galt6B4galt6Creb3l2Akap13Ckap4Col4a1Rhpn1Aldh18a1Aldh18a1Aldh18a1Aldh18a1Cpn1Aqp8Ckap4Ckap4Ckap4CtslSparcLamc1Col4a2Lamb1Lamb1P4ha1CubnCol4a1Pth1rCreb3l2Glipr2Gdpd5Flrt3Bmp6Dkk1Gata4Lama1Foxq1Serpinh1Serpinh1Commd7P4ha2Aaed1Fgfr2Slc7a6osPdgfraSox17Sox17Pgam2Runx1Erlin1Smad2Cpne8Slc4a71425045_at1460257_a_atRbm15bAgpat9Esyt3Havcr1Ppp2r3cArhgap42Adcyap1r1Tom1l1PdgfraShkbp1Aco1Aco1Sdc4Snx2Rab11aGata643 E3.5 (PE)49 E3.5 (PE)54 E3.5 (PE)37 E3.5 (PE)41 E3.5 (PE)50 E3.5 (PE)51 E3.5 (PE)52 E3.5 (PE)53 E3.5 (PE)38 E3.5 (PE)58 E3.5 (PE)61 E4.5 (PE)65 E4.5 (PE)59 E4.5 (PE)66 E4.5 (PE)60 E4.5 (EPI)64 E4.5 (EPI)62 E4.5 (EPI)63 E4.5 (EPI)25 E3.2533 E3.2555 E3.5 (EPI)21 E3.2532 E3.2536 E3.2527 E3.2529 E3.2523 E3.2524 E3.2535 E3.2530 E3.2518 E3.2528 E3.2534 E3.2522 E3.2531 E3.2519 E3.2520 E3.2557 E3.5 (EPI)46 E3.5 (EPI)42 E3.5 (EPI)56 E3.5 (EPI)47 E3.5 (EPI)48 E3.5 (EPI)39 E3.5 (EPI)40 E3.5 (EPI)44 E3.5 (EPI)45 E3.5 (EPI)26 E3.2511 E3.2516 E3.2517 E3.259 E3.2512 E3.252 E3.255 E3.2513 E3.2515 E3.254 E3.2510 E3.251 E3.253 E3.257 E3.258 E3.256 E3.2514 E3.25−5−4−3−2−101234Analysis report: Ohnishi et al., 2014

Figure 10: Heatmap of all WT arrays with duplicate features collapsed. Data from 200 features with
evidence of differential expression between the two clusters are shown. Duplicate features per gene were
averaged.

20

PltpLiphMalMorc1Fgd1Hdac1Hsd17b14Fgf4Zp3Akap1Plekha7Myo10Ttc39bCldn4PmlDennd1aKif3bAtg16l2Slc30a2Larp1Mpc1Prpsap2Tfap2cPrps1Pttg1Spint1Socs2Sox2Hnrnpa0Rif1Hs6st1RykPak4Saal1Dusp19Pfkfb3Usp9x1460221_atGspt1YwhagRhoaSgk11415790_atCcbl1Scamp1Rbm47Grb7Rab3il1Prdm14Bcl2l14Slc1a1NanogSfnTpd52WtapRnf213Tmem41bYpel5SpicTrim43aSrxn1Elovl7Klf2Mier3Itgb7BokTceb3Il17rcCyp2s1HexbSlc28a3AFFX−18SRNAMur/X00686_M_atSlc2a3SvipPdgfaZfand2aNdufb61435761_atAsnsSmad2B3gnt7Slc46a3B4galt6Tfpi1435789_x_at1447633_x_atGolga4CtslCkap4Lamc1SparcDdt1424365_atDnmt3lIcoslMllt1Nudt8Rhpn1Aldh18a1Gdpd5Aqp8Cpn1Glipr2Pth1rLama1Serpinh1Foxq1Flrt3Bmp6Dkk1P4ha2CubnLamb1Col4a2Col4a1Gata4Akap13Rbm15bAaed1P4ha1Creb3l2PdgfraSox17Fgfr2Slc7a6osPgam2Runx1Erlin1LgalslCommd7Tbpl1Uap1Aco1Sdc4Snx2Gata6Rab11aAspmRnpc3Znhit1Akr1c13Duox1Agpat9Esyt3Havcr1Cpne8Slc4a7Crlf3Atg13Fam159bFbxl20TesMarcksSmap11425045_at1460257_a_atShkbp1Tom1l1Adcyap1r1Arhgap42Ppp2r3cTmem209Tsc22d143 E3.5 (PE)49 E3.5 (PE)54 E3.5 (PE)52 E3.5 (PE)53 E3.5 (PE)38 E3.5 (PE)58 E3.5 (PE)37 E3.5 (PE)41 E3.5 (PE)50 E3.5 (PE)51 E3.5 (PE)61 E4.5 (PE)66 E4.5 (PE)59 E4.5 (PE)65 E4.5 (PE)60 E4.5 (EPI)64 E4.5 (EPI)62 E4.5 (EPI)63 E4.5 (EPI)26 E3.2525 E3.2523 E3.2524 E3.2535 E3.2530 E3.2536 E3.2527 E3.2529 E3.2518 E3.2528 E3.2534 E3.2522 E3.2531 E3.2520 E3.2519 E3.2521 E3.2532 E3.2557 E3.5 (EPI)46 E3.5 (EPI)56 E3.5 (EPI)39 E3.5 (EPI)40 E3.5 (EPI)42 E3.5 (EPI)44 E3.5 (EPI)48 E3.5 (EPI)45 E3.5 (EPI)47 E3.5 (EPI)33 E3.2555 E3.5 (EPI)10 E3.2511 E3.2516 E3.2517 E3.259 E3.2512 E3.252 E3.255 E3.254 E3.251 E3.253 E3.257 E3.2513 E3.2515 E3.2514 E3.256 E3.258 E3.25−5−4−3−2−101234Analysis report: Ohnishi et al., 2014

Figure 11: Heatmap of only the WT arrays from E3.5. Data from 200 features with evidence of differen-
tial expression between the two clusters are shown. For some genes, multiple features are shown.

21

Aldh18a1Aldh18a1Aldh18a1Aldh18a1Lamb1Lamb1Aldh18a1AsnsSlc46a3TfpiSerpinh1Serpinh1Smad2P4ha2Erlin1TfpiTfpiFoxq1Shkbp1Flrt3Gdpd5Gata4Lama1Lamc1Sox17Sox17Col4a1Esyt3Col4a11460257_a_atPpp2r3cGolga4Dnmt3lRab11aTom1l1Commd7Cpne81435789_x_at1447633_x_at1425045_atAdcyap1r1Aaed1SparcAtg13Rnpc3CtslFbxl20Crlf3SparcP4ha1Fam159bPth1rCkap4Ckap4Ckap4Rhpn1Cpn1Glipr2IcoslPdgfraBmp6Dkk1Pgam2Runx1Aqp8Ckap4Duox1Nudt8Mllt1Smap1Tsc22d1Tsc22d1Tsc22d1Tsc22d1TesZnhit1DdtArhgap421435761_atCreb3l2Fgfr2Slc7a6osGolga4Havcr1Ndufb6Slc4a7Gata6Uap1Uap1Sdc4Snx2B4galt6AspmMarcksAkap13MarcksCubnTbpl1Col4a21424365_atB4galt6Rbm15bAkr1c13Creb3l2Aco1Aco1Tmem209PdgfraAgpat9B3gnt7LgalslDusp19Larp1YwhagSaal1PmlMyo10Grb7Bcl2l14Pfkfb3Hs6st1RykTtc39bItgb7Gspt1Gspt1Socs2PltpPak4Pttg1Rnf213Usp9xFgd1Hdac1Prdm14Zp3Fgf4Fgf41460221_atSrxn1Hsd17b14Hsd17b14Fgf4MalTfap2cAFFX−18SRNAMur/X00686_M_atLiphBokMalIl17rcKif3bRbm47PdgfaSlc28a3Mpc1Prpsap2Rab3il1Mier3Ypel5Trim43aScamp1Hnrnpa0WtapZfand2aRif1SvipElovl7Ccbl1Ccbl1Ccbl1Sgk1RhoaSox2SpicSpicAkap1Plekha7Slc1a1Cyp2s1Spint1SfnTpd52Klf2WtapTmem41bMorc1Prps1NanogTpd52Tceb3Slc2a3Slc2a31415790_atSlc30a2Bcl2l14HexbHexbDennd1aCldn4Atg16l243 E3.5 (PE)49 E3.5 (PE)54 E3.5 (PE)58 E3.5 (PE)52 E3.5 (PE)53 E3.5 (PE)41 E3.5 (PE)50 E3.5 (PE)51 E3.5 (PE)37 E3.5 (PE)38 E3.5 (PE)55 E3.5 (EPI)46 E3.5 (EPI)39 E3.5 (EPI)40 E3.5 (EPI)57 E3.5 (EPI)42 E3.5 (EPI)56 E3.5 (EPI)44 E3.5 (EPI)45 E3.5 (EPI)47 E3.5 (EPI)48 E3.5 (EPI)−3−2−10123Analysis report: Ohnishi et al., 2014

Figure 12: Heatmap of only the WT arrays from E3.5 with duplicate features collapsed. Data from 200
features with evidence of differential expression between the two clusters are shown. Duplicate features per
gene were averaged.

22

Akr1c13Rbm15bP4ha1SparcAaed1Atg13B3gnt7LgalslRnpc3CtslFbxl20AsnsLamb1Aldh18a1TfpiSerpinh1Slc46a3Flrt3Foxq1Shkbp1Smad2Erlin1P4ha2Aqp8Duox11460257_a_atMllt1Bmp6Dkk1IcoslNudt8TesDdtZnhit11435761_atArhgap42Ppp2r3cTmem209Crlf3Smap1Tsc22d1Commd7Tom1l1Rhpn1Cpn1Glipr2Cpne81435789_x_at1447633_x_at1425045_atAdcyap1r1Col4a2Fam159bPth1rLamc1Ckap4Col4a1Gata4Lama1Pgam2Esyt3PdgfraCubnTbpl11424365_atAco1Dnmt3lRab11aFgfr2Slc7a6osAkap13MarcksHavcr1Ndufb6Golga4B4galt6Creb3l2AspmSnx2Agpat9Sdc4Runx1Gdpd5Sox17Slc4a7Gata6Uap1RhoaCcbl1Sgk11460221_atSlc2a3Tceb3Mpc1Slc28a3Prpsap2Rab3il11415790_atIl17rcSrxn1Hsd17b14Spint1WtapKif3bAtg16l2Cldn4PdgfaRbm47Klf2Tpd52Morc1NanogPrps1Sox2SpicHexbTmem41bTfap2cGrb7MalPfkfb3Dennd1aBcl2l14Slc30a2AFFX−18SRNAMur/X00686_M_atBokLiphCyp2s1Slc1a1Akap1SfnPlekha7Ttc39bMier3Ypel5Scamp1Trim43aGspt1PltpSocs2Rif1Elovl7SvipMyo10PmlHnrnpa0Zfand2aItgb7Fgd1Usp9xPttg1Rnf213Pak4Hdac1Prdm14Fgf4Zp3Hs6st1RykDusp19Larp1Saal1Ywhag43 E3.5 (PE)49 E3.5 (PE)54 E3.5 (PE)52 E3.5 (PE)53 E3.5 (PE)58 E3.5 (PE)38 E3.5 (PE)41 E3.5 (PE)37 E3.5 (PE)50 E3.5 (PE)51 E3.5 (PE)55 E3.5 (EPI)56 E3.5 (EPI)57 E3.5 (EPI)46 E3.5 (EPI)39 E3.5 (EPI)40 E3.5 (EPI)42 E3.5 (EPI)44 E3.5 (EPI)45 E3.5 (EPI)47 E3.5 (EPI)48 E3.5 (EPI)−3−2−10123Analysis report: Ohnishi et al., 2014

Figure 13: Determination of the cutoff for independent filtering on E4.5 WT samples. Analogous to Fig-
ure 8.

23

Analysis report: Ohnishi et al., 2014

5

Differentially expressed genes from E3.25 to E3.5

To understand the transitions shown in the MDS plots in molecular terms, a look at the
genes that are differentially expressed along the transitions from E3.25 to E3.5 (EPI) and
from E3.25 to E3.5 (PE) might be instructive. To this end, we determine the differentially
expressed genes for each of the two comparisons, build the union set, and display their data
in the heatmap shown in Figure 14. It is interesting that some genes are specifying for either
EPI or PE, whereas other genes show the same trend from E3.25 to E3.5 for both lineages
(i. e. they only reflect time).

> samples = unlist(groups[c("E3.25", "E3.5 (EPI)", "E3.5 (PE)")])

> deE325toE35 = union(

+

+

getDifferentialExpressedGenes(x, groups, "E3.25", "E3.5 (EPI)"),

getDifferentialExpressedGenes(x, groups, "E3.25", "E3.5 (PE)"))

> myHeatmap(x[deE325toE35, samples], collapseDuplicateFeatures = TRUE)

24

Analysis report: Ohnishi et al., 2014

Figure 14: Heatmap of differentially expressed genes from E3.25 to E3.5 (EPI), and from E3.25 to E3.5
(PE). A standalone PDF file with this figure is also available, under the name Hiiragi2013-figdifferential
lyE325toE35.pdf.

25

Igbp19430016H08RikAcadlWwtr1Znhit11441931_x_atAtg9aIvns1abpVapaSlc25a39Ybx3CatPsmd6Rad21Cox7a2lLamtor1Klhdc4Eif3lElp3Gm6787Tomm20Psmb4Psmc4Psat1Ddx391439415_x_atOdc1HexbTpd52NanogKlf2SpicBcl2l14Nsmce4a9630033F20RikMrpl22Cyp2s1Kcnk6WhrnZfp9321429775_a_at1450882_s_atDhcr7Crip2Gpd1l1426260_a_atTrim43a1434584_a_at1438468_atPpm1bSfnActn21426414_a_atRnf7RhoaGm11545Wipi2Metap2Ranbp2RfflAtg4bRab29Sap30l1438503_x_atDnaja1MyadmTceb1YwhazBhmt2BhmtGnpnat11419987_at1420043_s_atUbcMap1lc3aGm115171436032_atRpl27aZmpste24Timd21456471_x_atPhgdhFam101bNudt4SordPramel61435782_atPemtLrr1Reep1Tfap2cEif3iSod2Sptbn21460590_s_atAlppl2Nub1Stmn3PltpSlc7a3Sf3a2LiphMalFgd1Prps1Morc1E2f5Ifitm3PygmZfp934Foxh1Ephx2Socs3Ppa1Jam2Nedd4Havcr1Esyt3Akap13Fgfr2IcoslPgam21424365_atDnmt3lFam189a2Maged1Col4a2Lamb1P4ha2Creb3l2Col4a1Sox17TfpiHpcal1Cited2Map2k5Aldh18a1Gdpd5Aqp8Cpn1Glipr2Ptpn18Slc46a3Serpinh1Gata4Lama1Flrt3Foxq1Bmp6Dkk1F2rRhpn1Ckap4GsdmdGlud1MdkAtg13Ppp1r14dAtn1Cox7a2Ndufa4AI503316Pcdh19Glg1Trim28Trim44Praf2Timp1Egr1B4galt61435789_x_at1447633_x_atCrygdGm203621439857_atPth1rLifrTcf7l1Lmo2B3gnt7SparcCox7cLamc1Itga5Tcf23Acsl5Ppt1CubnMpped213 E3.253 E3.257 E3.2510 E3.251 E3.254 E3.255 E3.2511 E3.2514 E3.2512 E3.2515 E3.258 E3.259 E3.252 E3.256 E3.2526 E3.2516 E3.2517 E3.2521 E3.2525 E3.2523 E3.2524 E3.2535 E3.2533 E3.2531 E3.2527 E3.2529 E3.2530 E3.2532 E3.2518 E3.2519 E3.2520 E3.2522 E3.2528 E3.2534 E3.2536 E3.2549 E3.5 (PE)54 E3.5 (PE)58 E3.5 (PE)43 E3.5 (PE)51 E3.5 (PE)52 E3.5 (PE)53 E3.5 (PE)50 E3.5 (PE)37 E3.5 (PE)38 E3.5 (PE)41 E3.5 (PE)55 E3.5 (EPI)47 E3.5 (EPI)56 E3.5 (EPI)57 E3.5 (EPI)46 E3.5 (EPI)48 E3.5 (EPI)42 E3.5 (EPI)44 E3.5 (EPI)45 E3.5 (EPI)39 E3.5 (EPI)40 E3.5 (EPI)−4−2024Analysis report: Ohnishi et al., 2014

6

Principal Component Analysis

As a first attempt at getting an overview over the data, see Figure 15.

> projection = deCluster$dm[differentially] %*% exprs(x)[differentially, ]

> plotProjection(projection, label = sampleNames(x),

+

col = x$sampleColour, colourMap = sampleColourMap)

6.1

On the WT samples
Select the WT samples.

> safeSelect = function(grpnames){

stopifnot(all(grpnames %in% names(groups)))

unlist(groups[grpnames])

+

+

+ }

> g = safeSelect(c("E3.25",

+

+

"E3.5 (EPI)", "E3.5 (PE)",

"E4.5 (EPI)", "E4.5 (PE)"))

Note: we do not use the data from all the 45101 features on the microarrays, since most
of these are dominated by noise. Rather, we use the top 100 features according to overall
variance across the WT samples, excluding, however, the FGF4 probes (to avoid any possible
concerns about “trivial” effects of the KOs).

> nfeatures = 100

> varianceOrder = order(rowVars(exprs(x[, g])), decreasing = TRUE)

> varianceOrder = setdiff(varianceOrder, which(FGF4probes))
> selectedFeatures = varianceOrder[seq_len(nfeatures)]
> xwt = x[selectedFeatures, g]

Before embarking on the PCA computation, construct a new data matrix with equal group
sizes.

> tab = table(xwt$sampleGroup)
> sp = split(seq_len(ncol(xwt)), xwt$sampleGroup)
> siz = max(listLen(sp))

> sp = lapply(sp, sample, size = siz, replace = (siz>length(x)))

> xwte = xwt[, unlist(sp)]

Now we are ready to do it.

> thepca = prcomp(t(exprs(xwte)), center = TRUE)
> pcatrsf = function(x) scale(t(exprs(x)), center = TRUE, scale = FALSE) %*% thepca$rotation
> stopifnot(all( abs(pcatrsf(xwte) - thepca$x) < 1e-6 ))

> myPCAplot = function(x, labels, ...) {

+

+

+

+

xy = pcatrsf(x)[, 1:2]

plot(xy, pch = 16, col = x$sampleColour, cex = 1, xlab = "PC1", ylab = "PC2", ...)

if(!missing(labels))

text(xy, labels, cex = 0.35, adj = c(0.5, 0.5))

26

Analysis report: Ohnishi et al., 2014

Figure 15: Projection of sample expression profiles on the differential expression signature from Section 4.
Expression profiles and signature are each vectors of length 200, and shown is the scalar product between
each sample’s expression profile for these 200 features and the differential expression signature.

+ }

> myPCAplot(xwt)

27

1 E3.252 E3.253 E3.254 E3.255 E3.256 E3.257 E3.258 E3.259 E3.2510 E3.2511 E3.2512 E3.2513 E3.2514 E3.2515 E3.2516 E3.2517 E3.2518 E3.2519 E3.2520 E3.2521 E3.2522 E3.2523 E3.2524 E3.2525 E3.2526 E3.2527 E3.2528 E3.2529 E3.2530 E3.2531 E3.2532 E3.2533 E3.2534 E3.2535 E3.2536 E3.2537 E3.5 (PE)38 E3.5 (PE)39 E3.5 (EPI)40 E3.5 (EPI)41 E3.5 (PE)42 E3.5 (EPI)43 E3.5 (PE)44 E3.5 (EPI)45 E3.5 (EPI)46 E3.5 (EPI)47 E3.5 (EPI)48 E3.5 (EPI)49 E3.5 (PE)50 E3.5 (PE)51 E3.5 (PE)52 E3.5 (PE)53 E3.5 (PE)54 E3.5 (PE)55 E3.5 (EPI)56 E3.5 (EPI)57 E3.5 (EPI)58 E3.5 (PE)59 E4.5 (PE)60 E4.5 (EPI)61 E4.5 (PE)62 E4.5 (EPI)63 E4.5 (EPI)64 E4.5 (EPI)65 E4.5 (PE)66 E4.5 (PE)67 E3.25 (FGF4−KO)68 E3.25 (FGF4−KO)69 E3.25 (FGF4−KO)70 E3.25 (FGF4−KO)71 E3.25 (FGF4−KO)72 E3.25 (FGF4−KO)73 E3.25 (FGF4−KO)74 E3.25 (FGF4−KO)75 E3.25 (FGF4−KO)76 E3.25 (FGF4−KO)77 E3.25 (FGF4−KO)78 E3.25 (FGF4−KO)79 E3.25 (FGF4−KO)80 E3.25 (FGF4−KO)81 E3.25 (FGF4−KO)82 E3.25 (FGF4−KO)83 E3.25 (FGF4−KO)84 E3.5 (FGF4−KO)85 E3.5 (FGF4−KO)86 E3.5 (FGF4−KO)87 E3.5 (FGF4−KO)88 E3.5 (FGF4−KO)89 E3.5 (FGF4−KO)90 E3.5 (FGF4−KO)91 E3.5 (FGF4−KO)92 E4.5 (FGF4−KO)93 E4.5 (FGF4−KO)94 E4.5 (FGF4−KO)95 E4.5 (FGF4−KO)96 E4.5 (FGF4−KO)97 E4.5 (FGF4−KO)98 E4.5 (FGF4−KO)99 E4.5 (FGF4−KO)100 E4.5 (FGF4−KO)101 E4.5 (FGF4−KO)−400−20002004006008001000E3.25E3.5 (PE)E3.5 (EPI)E4.5 (PE)E4.5 (EPI)E3.25 (FGF4−KO)E3.5 (FGF4−KO)E4.5 (FGF4−KO)Analysis report: Ohnishi et al., 2014

See Figure 16. We also provide an overview over the distributions of loadings of the PCA com-
ponents (Figure 17) and the 20 most important genes (10 with highest positive coefficients
and 10 with the highest negative coefficients) in the R output below.

Figure 16: PCA plot, using WT samples. The colour code is as in Figure 15.

Figure 17: Sorted loadings (coefficients) of the first two PCA vectors. The most important genes are
shown in the text.

> par(mfrow = c(1,2))

> for(v in c("PC1", "PC2")) {

+

+

+

+

+

loading = thepca$rotation[, v]

plot(sort(loading), main = v, ylab = "")

sel = order(loading)[c(1:10, (-9:0)+length(loading))]

print(data.frame(

symbol = fData(x)$symbol[selectedFeatures[sel]],

28

−10010203040−20−10010PC1PC2020406080100−0.2−0.10.00.10.2PC1Index020406080100−0.20.00.10.20.3PC2IndexAnalysis report: Ohnishi et al., 2014

probe = names(loading)[sel],

loading = loading[sel], stringsAsFactors = FALSE

))

+

+

+

+ }

probe

Crxos

symbol

Slc38a2

Calcoco2

0.1558477

0.1460359

0.1455867

0.1486257

0.1417741

0.1588866

1437534_at

loading
1429483_at
1429483_at -0.2242381
1434584_a_at 1434584_a_at 1434584_a_at -0.2210081
1460605_at
1460605_at -0.2181986
Pramel6 1456270_s_at -0.2044059
1456270_s_at
1456598_at -0.2019409
1456598_at
1456598_at
1450624_at
1450624_at -0.1945991
Bhmt
Spic 1449134_s_at -0.1707423
1449134_s_at
Ceacam10 1448573_a_at -0.1509967
1448573_a_at
1437534_at
1437534_at -0.1506999
1433509_s_at
Reep1 1433509_s_at -0.1447711
1454737_at
0.1311659
Dusp9
1426255_at
1439148_a_at
1437308_s_at
1450843_a_at
1420498_a_at
1448595_a_at
1426722_at
1418153_at
1419737_a_at

1454737_at
1426255_at
Nefl
Pfkl 1439148_a_at
F2r 1437308_s_at
Serpinh1 1450843_a_at
Dab2 1420498_a_at
Bex1 1448595_a_at
1426722_at
1418153_at
Lama1
Ldha 1419737_a_at
loading
symbol
probe
Morc1 1419418_a_at -0.2204497
1419418_a_at
1423754_at
1423754_at -0.1987325
Ifitm3
1436944_x_at 1436944_x_at 1436944_x_at -0.1565725
Bex1 1448595_a_at -0.1476457
1448595_a_at
Pdk1 1423747_a_at -0.1442752
1423747_a_at
1449254_at
1449254_at -0.1100474
Spp1
Mt1 1422557_s_at -0.1058178
1422557_s_at
1448830_at -0.1037331
1448830_at
1429388_at -0.1028595
1429388_at
1426255_at
1426255_at -0.1001978
Aldh18a1 1437325_x_at
1437325_x_at
0.1496692
1418153_at
1418153_at
Serpinh1 1450843_a_at
1450843_a_at
Gpr137b-ps 1439256_x_at
1439256_x_at
1436838_x_at
Cotl1 1436838_x_at
1439255_s_at 1439255_s_at 1439255_s_at
Sox17 1429177_x_at
1429177_x_at
1421917_at
1421917_at
Pdgfra
1426990_at
1426990_at
Cubn
Cubn 1452270_s_at
1452270_s_at

0.1648103

0.1660538

0.1630355

0.1850638

0.1798579

0.1521609

0.2277869

0.1654778

0.2022259

0.2685773

0.2907478

0.1530877

Lama1

Dusp1

Nanog

Nefl

6.2 WT and FGF4-KO samples

In the following we perform PCA analysis using both WT and FGF4-KO samples.

29

Analysis report: Ohnishi et al., 2014

> myPCAplot(x[selectedFeatures, ])

See Figure 18.

Figure 18: PCA plot for WT and FGF4-KO samples. The colour code is as in Figure 15.

> myPCAplot(x[selectedFeatures, ], labels = paste(seq_len(ncol(x))))

See Figure 19.

Figure 19: Same as Figure 18, with labels indicating the array (sample) number. This may be useful to
detect outlier arrays.

30

−10010203040−20−10010PC1PC2−10010203040−20−10010PC1PC2123456789101112131415161718192021222324252627282930313233343536373839404142434445464748495051525354555657585960616263646566676869707172737475767778798081828384858687888990919293949596979899100101Analysis report: Ohnishi et al., 2014

> myPCAplot(x[selectedFeatures, ], labels = paste(x$Total.number.of.cells))

See Figure 20.

Figure 20: Same as Figure 18, with labels indicating Total.number.of.cells. This may be useful to detect
“batch effects”.

6.3

Heatmap of all WT and FGF4-KO samples

> mat = exprs(x[selectedFeatures, ])

> rownames(mat) = fData(x)[selectedFeatures, "symbol"]

> gplots::heatmap.2(mat, trace = "none", dendrogram = "none", scale = "row",

+

+

col = gplots::bluered(100), keysize = 0.9,

ColSideColors = x$sampleColour, margins = c(7,5))

See Figure 21.

31

−10010203040−20−10010PC1PC2323232323232323232323233333333333334343434344141414149494949505050505050626262626262757575757575757591919191919191912072072072072072072072073232323232323232NANANANANANANANANANANANANANANANANANANANANANANANANANANAAnalysis report: Ohnishi et al., 2014

Figure 21: Heatmap of all arrays. Data from the 100 with the highest variance across the WT samples,
excluding the FGF4 probes. The colour code of the bar at the top is as in Figure 15.

32

64 E4.5 (EPI)62 E4.5 (EPI)63 E4.5 (EPI)60 E4.5 (EPI)59 E4.5 (PE)61 E4.5 (PE)66 E4.5 (PE)65 E4.5 (PE)58 E3.5 (PE)51 E3.5 (PE)53 E3.5 (PE)52 E3.5 (PE)50 E3.5 (PE)43 E3.5 (PE)38 E3.5 (PE)41 E3.5 (PE)37 E3.5 (PE)78 E3.25 (FGF4−KO)79 E3.25 (FGF4−KO)83 E3.25 (FGF4−KO)80 E3.25 (FGF4−KO)76 E3.25 (FGF4−KO)68 E3.25 (FGF4−KO)77 E3.25 (FGF4−KO)81 E3.25 (FGF4−KO)71 E3.25 (FGF4−KO)75 E3.25 (FGF4−KO)82 E3.25 (FGF4−KO)55 E3.5 (EPI)54 E3.5 (PE)57 E3.5 (EPI)56 E3.5 (EPI)42 E3.5 (EPI)40 E3.5 (EPI)39 E3.5 (EPI)98 E4.5 (FGF4−KO)93 E4.5 (FGF4−KO)94 E4.5 (FGF4−KO)92 E4.5 (FGF4−KO)95 E4.5 (FGF4−KO)99 E4.5 (FGF4−KO)97 E4.5 (FGF4−KO)96 E4.5 (FGF4−KO)100 E4.5 (FGF4−KO)101 E4.5 (FGF4−KO)49 E3.5 (PE)47 E3.5 (EPI)45 E3.5 (EPI)46 E3.5 (EPI)48 E3.5 (EPI)44 E3.5 (EPI)26 E3.2525 E3.2524 E3.2523 E3.2535 E3.2532 E3.2531 E3.2536 E3.2534 E3.2510 E3.2511 E3.254 E3.253 E3.251 E3.255 E3.252 E3.259 E3.2533 E3.2572 E3.25 (FGF4−KO)67 E3.25 (FGF4−KO)70 E3.25 (FGF4−KO)74 E3.25 (FGF4−KO)69 E3.25 (FGF4−KO)73 E3.25 (FGF4−KO)13 E3.2519 E3.2518 E3.2527 E3.2522 E3.2517 E3.2514 E3.2515 E3.2512 E3.2530 E3.2528 E3.2529 E3.2520 E3.2521 E3.256 E3.258 E3.257 E3.2516 E3.2589 E3.5 (FGF4−KO)86 E3.5 (FGF4−KO)84 E3.5 (FGF4−KO)85 E3.5 (FGF4−KO)88 E3.5 (FGF4−KO)87 E3.5 (FGF4−KO)91 E3.5 (FGF4−KO)90 E3.5 (FGF4−KO)Dvl1Ints51434584_a_at1456598_atLy6aReep1Tfap2cMt1Dppa2Pramel6BhmtCrxosCalcoco2Spp1Ubxn2aNanogAA467197SpicCeacam101456661_atSnx6Sorbs1Socs3Prdm14Rhpn2Rhpn2Atp1b1LdhaPfklAmpd2Ly6eCtszDab2Basp1DspDspBhmt21439255_s_atGpr137b−psRnf115Vnn1Vnn1Tmem191cTmem191cDusp1Ifitm3Morc1Pmaip1Tktl1Ifi351437534_atTtll1Fam104aAnkrd24EnpepGsnDmxl2Rapgef2Magea5Cotl1Exoc6Qrsl1Pfn2Timm8a2AdkPdk1Bex1Slc38a2NeflF2rDusp9Pbx3Zscan211436944_x_atTob2Tspan8Kbtbd71418072_atC773704930550L24RikSnord104Aasdh1455904_atDdx3yLpgat1Smad4LcorChmp1bSoat1PdgfraSox17Aldh18a1CubnCubnDcaf12l1Lama1Serpinh1TfpiEgr1Trim44−202Row Z−Score0100200300400Color Keyand HistogramCountAnalysis report: Ohnishi et al., 2014

7

7.1

Further analyses of FGF4-KO

FGF4’s expression pattern in E3.25 samples
In Figure 22, produced by the code below, we visualise the expression pattern of FGF4 in the
E3.25 samples. The striking result is that there is a lot of natural variation in FGF4 expression
even in the WT samples, and some of the lowest levels in the WT samples approach the
background signal level seen for the KOs.

> x325 = x[, with(pData(x), Embryonic.day=="E3.25")]

> rv325 = rowVars(exprs(x325))

> featureColours = RColorBrewer::brewer.pal(sum(FGF4probes), "Dark2")

> py = t(exprs(x325)[FGF4probes, ])

> matplot(py, type = "p", pch = 15, col = featureColours,

+

+

xlab = "arrays", ylab = expression(log[2] ~ signal),

ylim = range(py) + c(-0.7, 0))

> legend("topright", legend = rownames(fData(x325))[FGF4probes], fill = featureColours)
> points(seq_len(nrow(py)), rep(par("usr")[3]+0.2, nrow(py)),
+

pch = 16, col = x325$sampleColour)

Figure 22: FGF4 expression. The plot shows data from the 4 features on the microarray annotated to
FGF4. From these data, we conclude that 1420085_at and 1420086_x_at essentially report the same, and are
likely to be good reporters for the FGF4 isoform that we are interested in, whereas the other two features
measure something else. The circle symbols at the bottom of the plot indicate the samples’ genotypes.

For presentation, we also produce another visualisation, this time only showing one value per
array, which we obtain by averaging over the two "good" features (Figure 23).

> fgf4Expression = colMeans(exprs(x325)[c("1420085_at", "1420086_x_at"), ])
> fgf4Genotype = factor(x325$genotype,

+

levels = sort(unique(x325$genotype),decreasing = TRUE))

> plot(x = jitter(as.integer(fgf4Genotype)),

+

+

+

+

y = fgf4Expression,

col = x325$sampleColour, xlim = c(0.5, 2.5), pch = 16,

ylab = expression(FGF4~expression~(log[2]~units)),

xlab = "genotype", xaxt = "n")

33

01020304050246810arrayslog2 signal1420085_at1420086_x_at1449729_at1450282_atAnalysis report: Ohnishi et al., 2014

> cm = sampleColourMap[sampleColourMap %in% x325$sampleColour]

> legend("topright", legend = names(cm), fill = cm)

Figure 23: FGF4 expression (microarray signal) in WT and KO samples.

7.2

Are the E3.25 WT samples with low FGF4 expression more
similar to the FGF4-KO samples than those with high FGF4?
This question is addressed by the code below, whose result is shown in Figure 24.

> zero2one = function(x) (x-min(x))/diff(range(x))

> rgb2col = function(x) {x = x/255; rgb(x[, 1], x[, 2], x[, 3])}

> colours = x325$sampleColour

> wt325 = x325$genotype=="WT"

> colourBar = function(x) rgb2col(colorRamp(c("yellow", "blue"))(zero2one(x)))

> colours[wt325] = colourBar(fgf4Expression)[wt325]
> selMDS = order(rv325, decreasing = TRUE)[seq_len(100)]

> MDSplot(x325[selMDS, ], col = colours)

> atColour = seq(min(fgf4Expression), max(fgf4Expression), length = 20)

> image(z = rbind(seq(along = atColour)), col = colourBar(atColour),

+

xaxt = "n", y = atColour, ylab = "")

Figure 24 indicates that

1. there is a relationship between FGF4 expression and overall global expression patterns

in the WT samples;

2. WT samples with low FGF4 are more similar to the FGF4 KOs than than WT samples

with high FGF4.

To more formally explore statement 2, we compute the Euclidean distance between each WT
sample and the mean of the KOs, plot this against the FGF4 expression level (Figure 25) and
test for correlation:

34

46810genotypeFGF4 expression (log2 units)E3.25E3.25 (FGF4−KO)Analysis report: Ohnishi et al., 2014

Figure 24: MDS plot of the E3.25 wild type (yellow–blue) and FGF4-KO (orange) samples. The
yellow–blue colour scale represents the FGF4 expression level, as indicated in the colour bar.

> KOmean = rowMeans(exprs(x325)[selMDS, x325$genotype=="FGF4-KO"])

> dists = colSums((exprs(x325)[selMDS, wt325] - KOmean)^2)^0.5

> ct = cor.test(fgf4Expression[wt325], dists, method = "spearman")

> ct

Spearman's rank correlation rho

data:

fgf4Expression[wt325] and dists

S = 4190, p-value = 0.005093

alternative hypothesis: true rho is not equal to 0

sample estimates:

rho

0.4607465

> plot(fgf4Expression[wt325], dists, pch = 16, main = "E3.25 WT samples",

+

xlab = "FGF4 expression", ylab = "Distance to FGF4-KO", col = colours)

There is a significant correlation between FGF4 expression in WT and similarity of the overall
expression profile with that of the FGF4 KOs.

7.3

Variability of the FGF4-KO samples compared to WT sam-
ples
To address this question, let us take some precaution against possible batch effects. Therefore,
we split the samples first by the sampleGroup classification defined above, but then also into
groups according to the value of Total.number.of.cells, assuming that the samples within
each such group have been processed together. See below.

> varGroups = split(seq_len(ncol(x)), f = list(x$sampleGroup,x$Total.number.of.cells),
+

sep = ":", drop = TRUE)

35

46810Analysis report: Ohnishi et al., 2014

Figure 25: Relationship between FGF4 expression and similarity of the transcription profile to the KO.
FGF4 expression of each sample is shown along the x-axis, the y-axis corresponds to the distance to the
mean FGF4-KO expression profile computed over the 100 most variable features as selected in selMDS.

We can see how many samples are in each of these groups, and what the value of ScanDate
is.

> data.frame(

`number arrays` = listLen(varGroups),
`ScanDates` = sapply(varGroups, function(v)

paste(as.character(unique(x$ScanDate[v])), collapse = ", ")),

+

+

+

+

stringsAsFactors = FALSE)

number.arrays

E3.25:32

E3.25 (FGF4-KO):32

E3.25:33

E3.25:34

E3.25:41

E3.25:49

E3.25:50

E3.5 (EPI):62

E3.5 (PE):62

E3.5 (EPI):75

E3.5 (PE):75

E3.5 (EPI):91

E3.5 (PE):91

E4.5 (EPI):207

E4.5 (PE):207

11

8

6

5

4

4

6

ScanDates

2011-03-16

2012-03-16

2011-03-15

2010-07-02

2010-07-02

2010-07-02

2010-07-02

3 2010-06-30, 2010-07-01

3 2010-06-30, 2010-07-01

5

3

3

5

4

2010-07-01

2010-07-01

2010-09-16

2010-09-16

2010-07-01

4 2010-07-01, 2010-07-02

E3.25 (FGF4-KO):NA

E3.5 (FGF4-KO):NA

E4.5 (FGF4-KO):NA

9

8

10

2012-08-16

2013-03-05

2013-03-05

Again select the top 100 genes according to varianceOrder.

36

46810323436384042E3.25 WT samplesFGF4 expressionDistance to FGF4−KOAnalysis report: Ohnishi et al., 2014

> sel

= varianceOrder[seq_len(nfeatures)]
> myfun = function(x) median(apply(exprs(x), 1, mad))

> sds = lapply(varGroups, function(j) myfun(x[sel, j]))

> names(sds) = sprintf("%s (n=%d)", names(sds), listLen(varGroups))
> varGroupX = factor(sapply(strsplit(names(varGroups), split = ":"),`[`, 1))

> op = par(mai = c(2,0.7,0.1,0.1))

> plot(jitter(as.integer(varGroupX)), sds, xaxt = "n", xlab = "", ylab = "")

> axis(1, las = 2, tick = FALSE, at = unique(varGroupX), labels = unique(varGroupX))

> par(op)

Figure 26: Variability of different groups of samples. The groups were defined by sampleGroup and ScanDate
(see definition of varGroups above). Variability was measured by the median (across the 100 top variable
genes) of the median absolute deviation across samples.

See Figure 26. Due to the small numbers of samples, it is difficult to decide whether or not
batch effects play an important role for estimating variability. This view is corroborated by
the diagnostic plots in the quality assessment report from the arrayQualityMetrics package.

So let us set aside the batch effect worries, and just compute and compare distributions of
standard deviations2.

> gps = split(seq_len(ncol(x)), f = x$sampleGroup)[c("E3.25", "E3.25 (FGF4-KO)")]
> sds = sapply(gps, function(j) apply(exprs(x)[sel, j], 1, mad))

> summary(sds)

E3.25

E3.25 (FGF4-KO)

Min.

:0.1210

Min.

:0.0894

1st Qu.:0.7199

1st Qu.:0.4290

Median :1.4571

Median :1.1348

Mean

:1.6861

Mean

:1.5002

3rd Qu.:2.5774

3rd Qu.:2.5293

2Since these standard deviations are computed on the logarithmic scale, they correspond to coefficient of
variation on the not-log-transformed scale.

37

0.60.81.01.2E3.25E3.25 (FGF4−KO)E3.5 (EPI)E3.5 (FGF4−KO)E3.5 (PE)E4.5 (EPI)E4.5 (FGF4−KO)E4.5 (PE)Analysis report: Ohnishi et al., 2014

Max.

:4.4275

Max.

:4.1889

> apply(sds, 2, function(x) c(`mean` = mean(x), `sd` = sd(x)))

E3.25 E3.25 (FGF4-KO)

mean 1.686081

sd

1.141133

1.500179

1.177443

7.4

Do the FGF4-KO samples correspond to a particularly early
substage within E3.25 (as indicated by the number of cells)?
See Figures 27 and 28, which are produced by the code below.

> for(n in c(100, 1000)) {

sel = order(rv325, decreasing = TRUE)[seq_len(n)]
KOmean = rowMeans(exprs(x325)[sel, x325$genotype=="FGF4-KO"])

dists = colSums((exprs(x325)[sel, wt325] - KOmean)^2)^0.5

pdf(file = sprintf("Hiiragi2013-figNumberOfCells-%d.pdf", n), width = 5, height = 10)

par(mfrow = c(2,1))

plot(x325$Total.number.of.cells[wt325], dists, pch = 16, main = "",

xlab = "Total number of cells", ylab = "Distance to FGF4-KO")

MDSplot(x325[sel, ], pointlabel = ifelse(x325$genotype=="WT",

paste(x325$Total.number.of.cells), "KO"), cex = 1)

dev.off()

+

+

+

+

+

+

+

+

+

+

+

+ }

7.5

Heatmap of E3.25 WT and E3.25 FGF-KO samples

For data visualisation, we produce a heatmap (Figure 29) that shows the data from the
following groups

> selectedGroups = c("E3.25", "E3.25 (FGF4-KO)")

> xKO = x[, safeSelect(selectedGroups)]
> selectedFeatures = order(rowVars(exprs(xKO)), decreasing = TRUE)[seq_len(100)]

> myHeatmap(xKO[selectedFeatures, ], collapseDuplicateFeatures = TRUE, haveColDend = TRUE)

7.6

Differentially expressed genes between FGF4-KO and WT
(PE, EPI) at E3.5
Let us compute the differentially expressed genes between WT and FGF4-KO,

> x35 = x[, safeSelect(c("E3.5 (FGF4-KO)", "E3.5 (EPI)", "E3.5 (PE)"))]

> f1 = f2 = x35$sampleGroup

> f1[f1=="E3.5 (PE)" ] = NA

> f2[f2=="E3.5 (EPI)"] = NA

> x35$EPI = factor(f1, levels = c("E3.5 (FGF4-KO)", "E3.5 (EPI)"))

> x35$PE = factor(f2, levels = c("E3.5 (FGF4-KO)", "E3.5 (PE)"))

38

Analysis report: Ohnishi et al., 2014

Figure 27: Distance of the E3.25 WT samples to the mean profile of FGF4-KO. The 100 features with
highest overall variance were used.

> de = list(`EPI` = rowttests(x35, "EPI"),
`PE` = rowttests(x35, "PE"))
+

> for(i in seq(along = de))

+

de[[i]]$p.adj = p.adjust(de[[i]]$p.value, method = "BH")

> par(mfcol = c(3,2))

> rkv = rank(-rowVars(exprs(x35)))

> fdrthresh = 0.05

> fcthresh = 1

39

3234496291323436384042Total number of cellsDistance to FGF4−KO323232323232323232323233333333333334343434344141414149494949505050505050KOKOKOKOKOKOKOKOKOKOKOKOKOKOKOKOKOAnalysis report: Ohnishi et al., 2014

Figure 28: Distance of the E3.25 WT samples to the mean profile of FGF4-KO. The 1000 features with
highest overall variance were used.

> for(i in seq(along = de)) {

hist(de[[i]]$p.value, breaks = 100, col = "lightblue", main = names(de)[i], xlab = "p")

plot(rkv, -log10(de[[i]]$p.value), pch = 16, cex = .25, main = "",

xlab = "rank of overall variance", ylab = expression(-log[10]~p))

plot(de[[i]]$dm, -log10(de[[i]]$p.value), pch = 16, cex = .25, main = "",

xlab = "average log fold change", ylab = expression(-log[10]~p))

abline(v = c(-1,1)*fcthresh[i], col = "red")

+

+

+

+

+

+

+ }

40

323449629180859095100Total number of cellsDistance to FGF4−KO323232323232323232323233333333333334343434344141414149494949505050505050KOKOKOKOKOKOKOKOKOKOKOKOKOKOKOKOKOAnalysis report: Ohnishi et al., 2014

Figure 29: Heatmap of all E3.25 WT and E3.25 FGF-KO samples. The 100 features with highest overall
variance were used. One of them shows Fgf4.

The plots are shown in Figure 30.
In contrast to Figure 8, this plot indicates no obvious
choice of threshold from overall-variance (i. e., independent) filtering. In fact, there seem to
be many probes with apparently significant changes but very low average fold changes. These
could be caused by “batch effects”, and we will apply the fold change threshold fcthresh to
remove these.

> isSig = ((pmin(de$PE$p.adj, de$EPI$p.adj) < fdrthresh) &

+

(pmax(abs(de$PE$dm), abs(de$EPI$dm)) > fcthresh))

> table(isSig)

41

Smad4Tob2Qrsl1Zscan21GsnLy6e1455904_atClasp1Lgals6Tmem180Chmp1bTspan8Basp1PtplaDmxl2Bex1Pbx3Sdc1Dvl1Slc35a2Ampd2Ddx3yDspEpas1Dab2CryabId2Krt18Lrp2Frmd4bLrrfip1RragdAtp1b1AdkSlc44a2Cldn9CtszPkp2Neo1Slc9a3r11439255_s_atDdx3x1456014_s_atCnot4Dppa2Fam104aAnkrd24Vma21Lcor1418189_s_at1448022_at1456661_atFam204aPrdm14Fgf4Spp1Pfn2Rhpn2Diap2Phtf2Btaf1Ttll1Acbd5Soat1Timm8a2Exoc6Impa1Epha4Hmgn5AA467197Sox2Tet14930550L24RikRapgef2Snx6AasdhCasp8ap2Dynlt3Plk4B230354K17RikCotl11438786_a_atAlg13SpicTdgf11437534_atBtg1Ifi35Tktl1Magea5Slc39a10Ubxn2aD15Ertd621eDusp1LgalslPdgfraCdc42ep3Kbtbd733 E3.2522 E3.2570 E3.25 (FGF4−KO)79 E3.25 (FGF4−KO)83 E3.25 (FGF4−KO)82 E3.25 (FGF4−KO)75 E3.25 (FGF4−KO)81 E3.25 (FGF4−KO)77 E3.25 (FGF4−KO)69 E3.25 (FGF4−KO)73 E3.25 (FGF4−KO)67 E3.25 (FGF4−KO)68 E3.25 (FGF4−KO)74 E3.25 (FGF4−KO)78 E3.25 (FGF4−KO)76 E3.25 (FGF4−KO)80 E3.25 (FGF4−KO)26 E3.2523 E3.2524 E3.2571 E3.25 (FGF4−KO)72 E3.25 (FGF4−KO)18 E3.2519 E3.2520 E3.2521 E3.256 E3.2527 E3.258 E3.2514 E3.2517 E3.257 E3.2516 E3.2510 E3.2513 E3.2512 E3.2515 E3.251 E3.253 E3.254 E3.2511 E3.252 E3.255 E3.259 E3.2535 E3.2532 E3.2531 E3.2534 E3.2528 E3.2530 E3.2525 E3.2529 E3.2536 E3.25−2−10123Analysis report: Ohnishi et al., 2014

Figure 30: Differentially expressed genes between FGF4-KO and WT (EPI, PE) at E3.5. The upper panels
show the histograms of p-values, middle panels the scatter plots of rank of overall variance (rkv) versus
− log10 p, lower panels log2 fold-change versus − log10 p (“volcano plots”). The red lines indicate possibly
useful fold change thresholds.

isSig

FALSE

TRUE

43686

1415

> plot(de$PE$dm, de$EPI$dm, pch = 16, asp = 1,

+

+

+

xlab = expression(log[2]~FGF4-KO / PE),

ylab = expression(log[2]~FGF4-KO / EPI),

cex = ifelse(isSig, 0.6, 0.1), col = ifelse(isSig, "red", "grey"))

See Figure 31.

42

Analysis report: Ohnishi et al., 2014

Figure 31: Differentially expressed genes between FGF4-KO and WT (EPI, PE) at E3.5. Shown is a scat-
terplot of the average fold changes for both comparisons. Large values along the x-axis indicate a relatively
higher level of expression in E3.5 (FGF4-KO) compared to E3.5 (PE), small (i. e. negative) values indicate
higher expression in E3.5 (PE); analogously for the y-axis.

> df = cbind(fData(x35)[isSig, ], `log2FC KO/PE` = de$PE$dm[isSig],
+
> write.csv(df, file = "differentially_expressed_E3.5_vs_FGF4-KO.csv")
> ctrls = grep("^AFFX", rownames(df), value = TRUE)

`log2FC KO/EPI` = de$EPI$dm[isSig])

7.6.1

The probes for FGF4

Let us look at the data for the four probes annotated to FGF4.

> par(mfrow = c(2,2))

> for(p in which(FGF4probes))

+

+

plot(exprs(x35)[p, ], type = "p", pch = 16, col = x35$sampleColour,

main = rownames(fData(x325))[p], ylab = expression(log[2]~expression))

> stopifnot(sum(FGF4probes)==4)

See Figure 32.

7.6.2 Behaviour of the control probes

A notable problem (probably associated with the "batch effects" discussed above) is that
length(ctrls)=31 control probes appear as significant in this analysis. Let us plot the first
8 of them (see Figure 33).

> par(mfcol = c(4, 2))

> for(p in ctrls[1:8])

+

+

plot(exprs(x35)[p, ], type = "p", pch = 16, col = x35$sampleColour,

main = p, ylab = expression(log[2]~expression))

43

Analysis report: Ohnishi et al., 2014

Figure 32: The probes for FGF4. As expected, the signal from these probes in the KO samples is consis-
tent with background.

7.6.3 Gene set enrichment analysis

Kolmogorov-Smirnov tests against KEGG pathways.

> keggpw = as.list(mouse4302PATH2PROBE)

> dat

= de$PE$dm+de$EPI$dm

> fts = lapply(keggpw, function(ps) {

inpw = rownames(fData(x35)) %in% ps

ft

= ks.test( dat[inpw], dat[!inpw] )

list(p.value = ft$p.value, statistic = ft$statistic, n = sum(inpw))

+

+

+

+ })

First, let us select some prominent signalling pathways.

> pws = c("04010", "04070", "04150", "04310", "04330", "04340", "04350", "04370", "04630")

In addition, let us add those pathways with the strongest enrichment signal:

> pws = unique( c(pws, names(fts)[ sapply(fts, function(x)

+

with(x, (n<=100) && (p.value<0.01))) ] ) )

Make an online query at the KEGG database.

44

05101520253046810121420085_atIndexlog2 expression05101520253046810121420086_x_atIndexlog2 expression0510152025302.02.53.03.54.04.51449729_atIndexlog2 expression0510152025305.56.57.51450282_atIndexlog2 expressionAnalysis report: Ohnishi et al., 2014

Figure 33: Behaviour of some control probe sets.

> query = paste0("mmu", pws)

> query = split(query, seq(along = query) %/% 10)

> pwInfo = unlist(lapply(query, keggGet), recursive = FALSE)

> df = data.frame(

+

+

+

+

+

+

= pws,

`id`
`name` = sub(" - Mus musculus (mouse)", "", sapply(pwInfo, `[[`, "NAME"), fixed = TRUE),
`n`
`p`
2)),
`statistic` = as.character(signif(sapply(pws, function(x) fts[[x]]$statistic), 2)),
stringsAsFactors = FALSE, check.names = FALSE)

= as.character(signif(sapply(pws, function(x) fts[[x]]$p.value),

sapply(pws, function(x) fts[[x]]$n),

=

45

0510152025305.06.07.08.0AFFX−18SRNAMur/X00686_5_atIndexlog2 expression05101520253056789AFFX−18SRNAMur/X00686_M_atIndexlog2 expression0510152025307891011AFFX−BioB−3_atIndexlog2 expression0510152025307891011AFFX−BioB−5_atIndexlog2 expression05101520253089101112AFFX−BioB−M_atIndexlog2 expression0510152025309101112AFFX−BioC−3_atIndexlog2 expression05101520253089101112AFFX−BioC−5_atIndexlog2 expression05101520253011.012.013.0AFFX−BioDn−3_atIndexlog2 expressionAnalysis report: Ohnishi et al., 2014

> print(xtable(df,

+

+

+

+

+

caption = paste("Gene set enrichment analysis of selected KEGG pathways, for the",

"differentially expressed genes between E3.5 FGF-4 KO and WT samples.",

"n: number of microarray features annotated to genes in the pathway."),

label = "tab_KEGG", align = c("l", "l","p{4cm}","r","r","r")),
type = "latex", file = "tab_KEGG.tex")

Table 1 shows

1. first, the data for the manually selected signalling pathways,

2. then, the pathways with the most prominent changes.

We visualize their data in Figure 34, see code below.

> par(mfrow = c(7,4)); stopifnot(length(pws)<=42)

> for(i in seq(along = pws)) {

inpw = factor(ifelse(rownames(fData(x35)) %in% keggpw[[pws[i]]],"in pathway","outside"))

ord = order(inpw)

enr = paste0("p=", df$p[i], if(as.numeric(df$p[i])<0.05)

multiecdf( (de$PE$dm+de$EPI$dm) ~ inpw, xlim = c(-1,1)*3,

main = paste(df$name[i], enr, sep = "\n"),

xlab = "mean difference between FGF4-KO and wildtype samples" )

paste(" D=", df$statistic[i]) else "")

+

+

+

+

+

+

+

+ }

46

Analysis report: Ohnishi et al., 2014

Figure 34: Differentially expressed genes between FGF4-KO and WT (EPI, PE) at E3.5.

47

Analysis report: Ohnishi et al., 2014

01

02

03

name

id
04010 MAPK signaling pathway
- Mus musculus
(house
mouse)

04070 Phosphatidylinositol signal-
ing system - Mus musculus
(house mouse)

04150 mTOR signaling pathway
- Mus musculus
(house
mouse)

n
628

p
0.77

statistic
0.027

186

0.41

0.065

139

0.042

0.12

04

04310 Wnt

signaling

- Mus musculus
mouse)

pathway
(house

377

0.077

0.066

05

06

07

08

09

11

12

13

14

04330 Notch signaling pathway
(house
- Mus musculus
mouse)

04340 Hedgehog signaling path-
way - Mus musculus (house
mouse)

04350 TGF-beta signaling path-
way - Mus musculus (house
mouse)

04370 VEGF signaling pathway
- Mus musculus
(house
mouse)
JAK-STAT signaling path-
way - Mus musculus (house
mouse)

04630

01040 Biosynthesis of unsaturated
fatty acids - Mus musculus
(house mouse)

00830 Retinol metabolism - Mus

musculus (house mouse)

00980 Metabolism of xenobiotics
by cytochrome P450 - Mus
musculus (house mouse)

00982 Drug metabolism -

cy-
tochrome P450 - Mus mus-
culus (house mouse)
Sphingolipid metabolism
- Mus musculus
(house
mouse)

15

00600

16

17

18

19

110

00620 Pyruvate metabolism - Mus

00500

musculus (house mouse)
Starch
sucrose
and
metabolism - Mus muscu-
lus (house mouse)
04140 Autophagy - animal - Mus

musculus (house mouse)

03420 Nucleotide excision repair
- Mus musculus
(house
mouse)

00130 Ubiquinone

and

other
terpenoid-quinone biosyn-
thesis
- Mus musculus
(house mouse)

21

00510 N-Glycan

biosynthesis
(house

metabolism
(house

- Mus musculus
mouse)

- Mus musculus
mouse)

22

00480 Glutathione

89

0.12

0.13

117

0.11

0.11

169

0.35

0.072

176

0.28

0.075

288

0.031

0.085

44

1e-04

0.33

64

79

0.0034

0.0066

0.22

0.19

91

0.00013

0.23

87

0.00034

0.22

93

61

52

91

0.0081

0.0079

0.001

0.0058

0.17

0.21

0.27

0.18

9

0.0024

0.61

84

0.0058

0.19

84

0.0011

0.21

48

23

00900 Terpenoid

backbone

31

0.00057

0.36

24

25

03060 Protein export - Mus mus-

53

0.00096

culus (house mouse)

03022 Basal transcription factors

55

0.0044

0.27

0.24

26

00970 Aminoacyl-tRNA

biosyn-

82

0.0011

0.21

27

03050 Proteasome - Mus muscu-

90

5.1e-09

0.33

biosynthesis - Mus muscu-

lus (house mouse)

- Mus musculus

(house

mouse)

thesis

- Mus musculus

(house mouse)

lus (house mouse)

Table 1: Gene set enrichment analysis of selected KEGG pathways, for the differentially expressed genes

between E3.5 FGF-4 KO and WT samples. n: number of microarray features annotated to genes in the

pathway.

Analysis report: Ohnishi et al., 2014

8

Jensen-Shannon Divergence analysis

In the following, we will explore whether and how we can detect changes in the degree of
"lack of correlation" ("heterogeneity") between cells.
[6] considered a measure of Jensen-
Shannon Divergence (Figures 2C, D in their paper) with a similar idea in mind. From their
Supplement:

JSD was calculated to assess within-group similarity of gene expression within
each cell line according to Lin (1991). Expression values of genes were trans-
formed so that they sum up to 1 in each cell. Each cell i is thus represented as a
vector of probabilities Pi. Cells from the same line were grouped together and for
each group, the JSD was calculated from the probability vectors (P1, P2, . . . , Pn)
of cells in each group.

JSD(P1, . . . , Pn) = H

(cid:32)

1
n

n
(cid:88)

i=1

(cid:33)

Pi

−

1
n

n
(cid:88)

i=1

H(Pi)

where H(P ) is the Shannon entropy given by

H(P ) = −

k
(cid:88)

i=1

P (xi) log2 P (xi).

1

2

Confidence intervals (CIs) were estimated by bootstrapping (sampling with re-
placement). The 95% CIs were shown as error bars.

Let’s define R functions for this.

> H = function(p) -sum(p*log2(p))
> JSD = function(m, normalize = TRUE) {

stopifnot(is.matrix(m), all(dim(m)>1))

if(normalize)

m = m/rowSums(m)

H(colMeans(m)) - mean(apply(m, 2, H))

+

+

+

+

+ }

For comparison, we consider below also the ordinary within-group standard deviation:

> SDV = function(m) sqrt(mean(rowVars(m)))

This measure of divergence computes for each gene (feature on the array) the variance across
arrays, then computes the average of these and takes the square root.

Since the majority of the 45101 features on the array are dominated “noise” and/or potential
technical drifts, we want to use only the most highly variable (i. e. most informative) features,

> numberFeatures = c(50, 200, 1000, 4000)

as selected by overall variance. In the following, we will use the function computeDivergences
to compute a measure of divergence, such as JSD, for each of the groups defined by strata
and for the different choices of numberFeatures.

> computeDivergences = function(y, indices, fun) {

+

+

y = y[indices, ]

exprVals = y[, -1]

49

Analysis report: Ohnishi et al., 2014

strata = y[, 1]

numStrata = max(strata)
stopifnot(setequal(strata, seq_len(numStrata)))

orderedFeatures = order(rowVars(t(exprVals)), decreasing = TRUE)

sapply(numberFeatures, function(n) {

selFeat = orderedFeatures[seq_len(n)]
sapply(seq_len(numStrata), function(s)

fun(exprVals[strata==s, selFeat, drop = FALSE]))

})

+

+

+

+

+

+

+

+

+

+

+ }

> x$sampleGroup = factor(x$sampleGroup)

> x$strata = as.numeric(x$sampleGroup)

Now we are ready to go, we use the bootstrap to assess variability in our divergene estimates:

> bootJSD = boot(data = cbind(x$strata, t(exprs(x))),

+

+

statistic = function(...) computeDivergences(..., fun = JSD),

R = 100, strata = x$strata)

> dim(bootJSD$t) = c(dim(bootJSD$t)[1], dim(bootJSD$t0))

> bootSDV = boot(data = cbind(x$strata, t(exprs(x))),

+

+

statistic = function(...) computeDivergences(..., fun = SDV),

R = 100, strata = x$strata)

> dim(bootSDV$t) = c(dim(bootSDV$t)[1], dim(bootSDV$t0))

The resulting values (mean and distribution indicated by boxplot) are shown in Figure 35.

> par(mfrow = c(length(numberFeatures),2))

> colores = sampleColourMap[levels(x$sampleGroup)]

> for(i in seq(along = numberFeatures)) {

for(what in c("JSD", "SDV")){

obj = get(paste("boot", what, sep = ""))

boxplot(obj$t[, , i], main = sprintf("numberFeatures=%d", numberFeatures[i]),

col = colores, border = colores, ylab = what, xaxtb = "n")

px = seq_len(ncol(obj$t))
text(x = px, y = par("usr")[3], labels = levels(x$sampleGroup),

xpd = NA, srt = 45, adj = c(1,0.5), col = colores)

points(px, obj$t0[, i], pch = 16)

}

+

+

+

+

+

+

+

+

+

+ }

50

Analysis report: Ohnishi et al., 2014

Figure 35: Jensen-Shannon divergences. JSD is shown on the left; on the right, for comparison we per-
formed the same analysis with within-group standard deviation as another measure of group spread.

51

123456781.52.02.53.03.54.04.55.0numberFeatures=50JSDE3.25E3.25 (FGF4−KO)E3.5 (EPI)E3.5 (FGF4−KO)E3.5 (PE)E4.5 (EPI)E4.5 (FGF4−KO)E4.5 (PE)123456783.03.23.43.63.84.04.2numberFeatures=50SDVE3.25E3.25 (FGF4−KO)E3.5 (EPI)E3.5 (FGF4−KO)E3.5 (PE)E4.5 (EPI)E4.5 (FGF4−KO)E4.5 (PE)123456786.26.46.66.87.07.2numberFeatures=200JSDE3.25E3.25 (FGF4−KO)E3.5 (EPI)E3.5 (FGF4−KO)E3.5 (PE)E4.5 (EPI)E4.5 (FGF4−KO)E4.5 (PE)123456782.83.03.23.43.6numberFeatures=200SDVE3.25E3.25 (FGF4−KO)E3.5 (EPI)E3.5 (FGF4−KO)E3.5 (PE)E4.5 (EPI)E4.5 (FGF4−KO)E4.5 (PE)123456789.559.609.659.709.759.80numberFeatures=1000JSDE3.25E3.25 (FGF4−KO)E3.5 (EPI)E3.5 (FGF4−KO)E3.5 (PE)E4.5 (EPI)E4.5 (FGF4−KO)E4.5 (PE)123456782.42.62.83.0numberFeatures=1000SDVE3.25E3.25 (FGF4−KO)E3.5 (EPI)E3.5 (FGF4−KO)E3.5 (PE)E4.5 (EPI)E4.5 (FGF4−KO)E4.5 (PE)1234567811.8011.8211.8411.8611.88numberFeatures=4000JSDE3.25E3.25 (FGF4−KO)E3.5 (EPI)E3.5 (FGF4−KO)E3.5 (PE)E4.5 (EPI)E4.5 (FGF4−KO)E4.5 (PE)123456782.32.42.52.62.72.8numberFeatures=4000SDVE3.25E3.25 (FGF4−KO)E3.5 (EPI)E3.5 (FGF4−KO)E3.5 (PE)E4.5 (EPI)E4.5 (FGF4−KO)E4.5 (PE)Analysis report: Ohnishi et al., 2014

9

9.1

Classification of temporal profiles

Comparison of microarray data with qPCR results
First, let us plot the microarray data for all probesets annotated to the genes shown in
Figure 36. We write the output into an extra PDF file, exemplaryGenes.pdf.

> xs = x[, pData(x)$sampleGroup %in%

+

c("E3.25", "E3.5 (PE)", "E4.5 (PE)", "E3.5 (EPI)", "E4.5 (EPI)")]

> xs$sampleGroup = factor(xs$sampleGroup)

> myBoxplot = function(ps) {

fac = factor(pData(xs)$sampleGroup)

boxplot(exprs(xs)[ps, ] ~ fac, col = sampleColourMap[levels(fac)], lim = c(2,14),

main = sprintf("%s (%s)", fData(x)[ps, "symbol"], ps), show.names = FALSE)

text(seq(along = levels(fac)), par("usr")[3] - diff(par("usr")[3:4])*0.02,

levels(fac), xpd = NA, srt = 90, adj = c(1,0.5), cex = 0.8)

+

+

+

+

+

+ }

> exemplaryGenes = read.table(header = TRUE, stringsAsFactors = FALSE, text = "

+ Sox2

+ P4ha2

+ Sox17

+ Gata6

+ Pdgfra

+ Tom1l1

+ symbol

thclass probeset
C-1 1425464_at
C-1 1439337_at
C-1 1416967_at
PE-2 1438946_at
PE-2 1429177_x_at
PE-2 1417149_at
PE-3 1418863_at
+ Gata4
+ Aldh18a1 PE-3 1415836_at
PE-3 1452035_at
+ Col4a1
PE-3 1424051_at
PE-3 1426990_at
PE-3 1424113_at
PE-4 1423805_at
PE-4 1427133_s_at
PE-4 1417920_at
EPI-2 1420085_at
EPI-2 1429388_at
EPI-2 1450989_at
EPI-4 1418283_at
EPI-4 1436799_at")

+ Col4a2

+ Lamb1

+ Nanog

+ Enox1

+ Cldn4

+ Tdgf1

+ Fgf4

+ Lrp2

+ Cubn

+ Dab2

+ Amn

> pdf(file = "exemplaryGenes.pdf", width = 8, height = 11)

> par(mfrow = c(5,3))
> for(i in seq_len(nrow(exemplaryGenes))) {
+

wh = featureNames(x)[fData(x)[, "symbol"]==exemplaryGenes[i, "symbol"]]

stopifnot(length(wh)>=1)

sapply(wh, myBoxplot)

+

+

+ }

> dev.off()

52

Analysis report: Ohnishi et al., 2014

Figure 36: Temporal change of the lineage marker expression Example figure provided by Takashi in
Email of 9 Oct 2012. Red genes are known lineage markers.

Based on these plots, we assigned one “trustworthy” probeset to each gene, indicated in the
above table.

> layout(rbind(c(1, 4,

7, 13),

+

+

+

+

+

> xs = x

c(2, 5,

8, 14),

c(21, 6,

9, 15),

c(3, 16, 10, 19),

c(22, 17, 11, 20),

c(23, 18, 12, 24)))

> xs$sampleGroup = factor(xs$sampleGroup)

> xs$sampleGroup = relevel(xs$sampleGroup, "E4.5 (PE)")

> xs$sampleGroup = relevel(xs$sampleGroup, "E4.5 (EPI)")

> xs$sampleGroup = relevel(xs$sampleGroup, "E3.5 (PE)")

> xs$sampleGroup = relevel(xs$sampleGroup, "E3.5 (EPI)")

> xs$sampleGroup = relevel(xs$sampleGroup, "E3.25")
> for(i in seq_len(nrow(exemplaryGenes)))
+

myBoxplot(exemplaryGenes[i, "probeset"])

The output is shown in Figure 37, which we can compare to Figure 36.

53

Sequential molecular program underlying EPI and PE lineage differentiation. Y-axis represents estimated copy numbers. PE and EPI samples in E3.5 and E4.5 are shown in a green and blue color, respectively, and samples in E3.25 are a grey color. We tentatively classify the genes into 4 categories, Class1: genes that are highly activated in E3.25, Class2: genes that are highly activated in E3.5, Class3: genes that are gradually activated, Class4: genes that are activated only in E4.5. Representative markers are marked in a red. Spearman test was performed to evaluate the gene expression correlation with Fgf4. * p<0.01, ** p<0.05Temporal change of the lineage marker expressionClass 4Amn101001000*Lrp2101001000*Dab2101001000*Class 3Gata4101001000**Aldh18a1101001000**Col4a1101001000**Col4a2101001000**Cubn101001000****Lamab1101001000E3.25E3.5E4.5Class 2E3.25E3.5E4.5Enox1Cldn4101001000*101001000**Fgf4Nanog101001000Tdgf1101001000**101001000**E3.25E3.5E4.5Class 1Gata6Tom1l1101001000**101001000***Sox2101001000**E3.25E3.5E4.5Sox17101001000**Pdgfra101001000**P4ha2101001000**EPIPEAnalysis report: Ohnishi et al., 2014

Figure 37: Boxplots of the microarray expression data for exemplary genes. Compare this to Figure 36.
The agreement is satisfactory.

9.2

Rule-based classification
For EPI and PE separately, we define 4 classes as indicated in Figure 36:

• class 1: highest in E3.25

• class 2: highest in E3.5 and off in the other lineage (at E3.5, E4.5)

• class 3: E3.25 < E3.5 < E4.5 and off in the other lineage (at E4.5)

54

4681012Gata6 (1425464_at)facexprs(xs)[ps, ]E3.25E3.5 (EPI)E3.5 (PE)E4.5 (EPI)E4.5 (PE)E3.25 (FGF4−KO)E3.5 (FGF4−KO)E4.5 (FGF4−KO)2.53.03.54.0Tom1l1 (1439337_at)facexprs(xs)[ps, ]E3.25E3.5 (EPI)E3.5 (PE)E4.5 (EPI)E4.5 (PE)E3.25 (FGF4−KO)E3.5 (FGF4−KO)E4.5 (FGF4−KO)24681012Sox2 (1416967_at)facexprs(xs)[ps, ]E3.25E3.5 (EPI)E3.5 (PE)E4.5 (EPI)E4.5 (PE)E3.25 (FGF4−KO)E3.5 (FGF4−KO)E4.5 (FGF4−KO)345678Pdgfra (1438946_at)facexprs(xs)[ps, ]E3.25E3.5 (EPI)E3.5 (PE)E4.5 (EPI)E4.5 (PE)E3.25 (FGF4−KO)E3.5 (FGF4−KO)E4.5 (FGF4−KO)24681012Sox17 (1429177_x_at)facexprs(xs)[ps, ]E3.25E3.5 (EPI)E3.5 (PE)E4.5 (EPI)E4.5 (PE)E3.25 (FGF4−KO)E3.5 (FGF4−KO)E4.5 (FGF4−KO)46810P4ha2 (1417149_at)facexprs(xs)[ps, ]E3.25E3.5 (EPI)E3.5 (PE)E4.5 (EPI)E4.5 (PE)E3.25 (FGF4−KO)E3.5 (FGF4−KO)E4.5 (FGF4−KO)45678910Gata4 (1418863_at)facexprs(xs)[ps, ]E3.25E3.5 (EPI)E3.5 (PE)E4.5 (EPI)E4.5 (PE)E3.25 (FGF4−KO)E3.5 (FGF4−KO)E4.5 (FGF4−KO)345678Aldh18a1 (1415836_at)facexprs(xs)[ps, ]E3.25E3.5 (EPI)E3.5 (PE)E4.5 (EPI)E4.5 (PE)E3.25 (FGF4−KO)E3.5 (FGF4−KO)E4.5 (FGF4−KO)4681012Col4a1 (1452035_at)facexprs(xs)[ps, ]E3.25E3.5 (EPI)E3.5 (PE)E4.5 (EPI)E4.5 (PE)E3.25 (FGF4−KO)E3.5 (FGF4−KO)E4.5 (FGF4−KO)4681012Col4a2 (1424051_at)facexprs(xs)[ps, ]E3.25E3.5 (EPI)E3.5 (PE)E4.5 (EPI)E4.5 (PE)E3.25 (FGF4−KO)E3.5 (FGF4−KO)E4.5 (FGF4−KO)2468101214Cubn (1426990_at)facexprs(xs)[ps, ]E3.25E3.5 (EPI)E3.5 (PE)E4.5 (EPI)E4.5 (PE)E3.25 (FGF4−KO)E3.5 (FGF4−KO)E4.5 (FGF4−KO)4681012Lamb1 (1424113_at)facexprs(xs)[ps, ]E3.25E3.5 (EPI)E3.5 (PE)E4.5 (EPI)E4.5 (PE)E3.25 (FGF4−KO)E3.5 (FGF4−KO)E4.5 (FGF4−KO)246810Dab2 (1423805_at)facexprs(xs)[ps, ]E3.25E3.5 (EPI)E3.5 (PE)E4.5 (EPI)E4.5 (PE)E3.25 (FGF4−KO)E3.5 (FGF4−KO)E4.5 (FGF4−KO)246810Lrp2 (1427133_s_at)facexprs(xs)[ps, ]E3.25E3.5 (EPI)E3.5 (PE)E4.5 (EPI)E4.5 (PE)E3.25 (FGF4−KO)E3.5 (FGF4−KO)E4.5 (FGF4−KO)4681012Amn (1417920_at)facexprs(xs)[ps, ]E3.25E3.5 (EPI)E3.5 (PE)E4.5 (EPI)E4.5 (PE)E3.25 (FGF4−KO)E3.5 (FGF4−KO)E4.5 (FGF4−KO)4681012Fgf4 (1420085_at)facexprs(xs)[ps, ]E3.25E3.5 (EPI)E3.5 (PE)E4.5 (EPI)E4.5 (PE)E3.25 (FGF4−KO)E3.5 (FGF4−KO)E4.5 (FGF4−KO)4681012Nanog (1429388_at)facexprs(xs)[ps, ]E3.25E3.5 (EPI)E3.5 (PE)E4.5 (EPI)E4.5 (PE)E3.25 (FGF4−KO)E3.5 (FGF4−KO)E4.5 (FGF4−KO)4681012Tdgf1 (1450989_at)facexprs(xs)[ps, ]E3.25E3.5 (EPI)E3.5 (PE)E4.5 (EPI)E4.5 (PE)E3.25 (FGF4−KO)E3.5 (FGF4−KO)E4.5 (FGF4−KO)681012Cldn4 (1418283_at)facexprs(xs)[ps, ]E3.25E3.5 (EPI)E3.5 (PE)E4.5 (EPI)E4.5 (PE)E3.25 (FGF4−KO)E3.5 (FGF4−KO)E4.5 (FGF4−KO)2468Enox1 (1436799_at)facexprs(xs)[ps, ]E3.25E3.5 (EPI)E3.5 (PE)E4.5 (EPI)E4.5 (PE)E3.25 (FGF4−KO)E3.5 (FGF4−KO)E4.5 (FGF4−KO)Analysis report: Ohnishi et al., 2014

• class 4: off in E3.25 and E3.5, on in E4.5, and off in the other lineage (at E4.5)

To implement these rules, let us define the helper function greater, which determines if a
gene has an average log fold change larger than thresh between each of the conditions in
cond1 versus each of the conditions in cond2.

> greater = function(cond1, cond2, thresh = 2) {

stopifnot(all(cond1 %in% names(groups)), all(cond2 %in% names(groups)))

rm1 = lapply(groups[cond1], function(j) rowMeans(exprs(x)[, j]))

rm2 = lapply(groups[cond2], function(j) rowMeans(exprs(x)[, j]))

res = rep(TRUE, nrow(x))

for(v1 in rm1) for(v2 in rm2)

res = res & ((v1-v2) > thresh)

return(res)

+

+

+

+

+

+

+

+ }

Next, we compute xsc, a version of the data matrix x that has been scaled to the range [0, 1],
such that for each gene, the lowest value across arrays corresponds to 0, and the highest value
to 1. (In the code below, we actually use 0.025% and 97.5% quantiles instead of lowest and
highest values, that is just to ensure some statistical robustness.)

> xquantiles = apply(exprs(x), 1, quantile, probs = c(0.025, 0.975))

> minLevel = xquantiles[1, ]

> maxLevel = xquantiles[2, ]

> trsf2Zero2One = function(x) {

+

+

+

+

x = (x-minLevel)/(maxLevel-minLevel)

x[x<0] = 0

x[x>1] = 1

return(x)

+ }

> xsc = x

> exprs(xsc) = trsf2Zero2One(exprs(x))

We will use xsc for the heatmap (Figure 38). The function isOff determines whether a gene
is off by checking whether more than 90% of the arrays in the condition(s) specified by cond
have values below minLevel + thresh.

> isOff = function(cond, thresh = 2) {

stopifnot(all(cond %in% names(groups)))

samps = unlist(groups[cond])
rowSums(exprs(x)[, samps] > minLevel+thresh) <= ceiling(length(samps) * 0.1)

+

+

+

+ }

Now we can do the classification.

`C-1` = greater("E3.25", c("E3.5 (EPI)", "E4.5 (EPI)", "E3.5 (PE)", "E4.5 (PE)"))

>
> `EPI-2` = greater("E3.5 (EPI)", c("E3.25")) &
+

greater("E3.5 (EPI)", "E4.5 (EPI)", thresh = 0.5) &

isOff("E3.5 (PE)") & isOff("E4.5 (PE)" )

+
> `PE-2` = greater("E3.5 (PE)", c("E3.25")) &
+

greater("E3.5 (PE)", "E4.5 (PE)", thresh = 0.5)

+
> `EPI-4` = (greater("E4.5 (EPI)", c("E3.25", "E3.5 (EPI)")) &

isOff("E3.5 (EPI)") & isOff("E4.5 (EPI)")

&

55

Analysis report: Ohnishi et al., 2014

+

isOff(c("E3.25", "E3.5 (EPI)")) &

isOff("E4.5 (PE)" ))

+
> `PE-4` = (greater("E4.5 (PE)", c("E3.25", "E3.5 (PE)")) &
isOff(c("E3.25", "E3.5 (PE)")) &
+

isOff("E4.5 (EPI)"))

+
> `EPI-3` = (greater("E3.5 (EPI)", "E3.25", thresh = 0.5) &
+

greater("E4.5 (EPI)", "E3.5 (EPI)", thresh = 0.5) &

+

greater("E4.5 (EPI)", "E3.25", thresh = 3)
isOff("E4.5 (PE)") & !`EPI-4`)

+
> `PE-3` = (greater("E3.5 (PE)", "E3.25", thresh = 0.5) &
greater("E4.5 (PE)", "E3.5 (PE)",
+

&

thresh = 0.5) &

+

greater("E4.5 (PE)", "E3.25", thresh = 3) &
isOff("E4.5 (EPI)") & !`PE-4`)

+
> thclasses = cbind(`C-1`, `EPI-2`, `EPI-3`, `EPI-4`, `PE-2`, `PE-3`, `PE-4`)

We want each feature to be in exactly one group:

> multiclass = thclasses[rowSums(thclasses)>1,, drop = FALSE]

> stopifnot(nrow(multiclass)==0)

The group sizes:

> colSums(thclasses)

C-1 EPI-2 EPI-3 EPI-4 PE-2 PE-3 PE-4

18

10

51

186

9

68

201

> agr = groups[c("E3.25", "E3.5 (EPI)", "E4.5 (EPI)", "E3.5 (PE)", "E4.5 (PE)")]

> fgr = apply(thclasses, 2, which)

> xsub = xsc[unlist(fgr), unlist(agr)]

> mat = exprs(xsub)

> rownames(mat) = fData(xsub)[, "symbol"]

> myHeatmap2(mat, keeprownames = TRUE,

+

+

rowGroups = factor(rep(seq(along = fgr), listLen(fgr))),

colGroups = factor(rep(seq(along = agr), listLen(agr))))

The heatmap is shown in Figure 38.

9.2.1

Table export

> out = do.call(rbind, lapply(seq(along = fgr), function(i)

+

cbind(`class` = names(fgr)[i], fData(xsc)[fgr[[i]], ])))

> write.csv(out, file = "featureclassification.csv")

9.2.2 Comparison with manual classification

Figure 2b in the paper shows qPCR data for these seven genes:

> fig2bGenes = c("Aldh18a1", "Col4a1", "Cubn", "Foxq1", "Gata4", "Lamb1", "Serpinh1")

The genes classified as PE-3 in the above microarray data rule-based classification are

56

Analysis report: Ohnishi et al., 2014

Figure 38: Heatmap of all classes of the [0,1]-scaled data matrix xsc. From left to right, the 5 blocks
correspond to the conditions E3.25, E3.5 (EPI), E4.5 (EPI), E3.5 (PE), E4.5 (PE). From bottom to top,
the 7 blocks correspond to the feature (gene) classes C-1, EPI-2, EPI-3, EPI-4, PE-2, PE-3, PE-4. Within
classes, genes are sorted by dendrogram clustering.

57

Perp1459989_atBhmt2Bhmt2Ly6aC130026I21RikPpp1r14aMboat1WhrnWhrnLgals8Gpd1lAtg9aAlppl2SordTfap2cPpm1aFam132aPrdm14Frmd4bSlc6a14Gsta2Abca13Trps1MalLiph1455310_atD13Ertd787eMcf2Zp3Fgf4Fgf4Rps6ka6Pvrl3Sdc11445368_atNfkbiaCoro2bAbhd14aEpb4.1l4aGprasp1PmlErasSlc7a3Enox1FlnaRif1Rps6ka2Otx2Ccnt2Fundc2CapslFam169aLasp1Nptx2Rcc2AI846148VegfcVegfcVegfcMorc1Mtm1Pla2g10NkrfBmp41700007K13RikCdylHdac61419540_atRif1Pias2Ifitm3Plekha7Phc1Zfp428NfrkbZfp5321434280_atPcyt1bCntnap2Gng3Lpar4Gm9564Ttc29Adamts1Commd7Kank3StarRab23Otud51458984_atJag1VasnSox4BtdGjc1Efcab11Suv39h2Ankdd1bZfp266Tra2b1440896_atGalnt10Sepp1Pcmtd2Zfp462Tmem40Tmem40Tmem40Sall2Sox11Epn2Ripk3Pcgf6AFFX−r2−Bs−phe−5_atBtbd11Btbd11Arhgef25Ddx58G730007D18RikMid1ip1Rmdn2McmbpDazlCldn9A630072M18RikPrrc2cBtbd3E330020D12RikSpred1Cnpy1Armcx1Nav2Cers4NfibPrdm5AirePipoxPla2g1bTdrd12Crisp11421063_s_atCcl20VrtnSmim31425546_a_atAassSlc35d3Ppp1r9aCass4Mb21d2Ina1443104_at2810002D19RikGbx2Ankrd62700081O15RikFut11Bnc29130230N09RikFam49aGgnbp2Bnc2Gpa33Pvrl3Rbp1NodalCamk1dPpp1r1a1428699_atRims2Crybg3Nr0b1HopxTrib1Lphn2Ldoc1Spata13Dusp6Proser14930444M15RikAtrxTle4LplAI225934Lemd1Galnt12Meis2Dab1TxnipEif3aShisa2Shisa2Tbrg4Meis2Gli2Ptk2bMapkapk3SlbpGli21430135_atGrik3Ahdc1Tor3aMgea5Slc16a3Col18a1Slc38a2Rwdd2aIkzf5InaRasa4Pitpnc1Rarg1190005I06RikPim2Rcor2Slc17a9Lphn2Proser1Soga31440760_atRobo4Ntn1Trim8Pitpnc1Dhrs7Ddx58Trp53Ramp3Igsf8Ak1Ccnd1Ccnd1Plcb4Tubb3Igsf9Lrmp1422607_at1450684_atTmem88DgkeosLef1Etv4Stmn2Mtss1Rasgrp2Rasgrp2Zbtb32NotumExoc3lLef1TrhCol18a1Pdzd4Igfbp2InaZfp652Six4Ppm1jSnx30EsamJade2Nab2Amz1Serf1Pgam2Sox17Fgfr2Gjb4Dcaf12l1Srpk2Stxbp1GsdmdRhpn2Serpine2Synj1Elovl1Elovl1Hpcal1Tmem150aReep5Lamb1MogsPlod3Lrpap1Plod2Prrc2cSlc26a2Pcyox1Pip4k2aApomHerpud1Prss35Pdcd6ipTmem98SrgnPga5Rcn1Tcf19Pcdh19F2rAqp8Foxq1Flrt3Dkk1Bmp6Aldh18a1Aldh18a1CubnCubnGlipr2Pth1rGdpd5Creb3l2Col4a1Gata4Serpinh1Fam213aPdzd3Lrrc16aHs3st1Clcn5Neo1Ada4930506M07RikFam46aPde4dipIkbkbDnajc22AsphFam198bBend5Soat1Gstm2B4galnt1Smim14Smim14GygGygB3galnt1EnpepRor1Slc23a1Col27a1Mmp15Sel1lMum1l1Hyou1Ldoc1lEdaPcbd1S100gMtmr1G6pc3Erp441442905_atH2−DMaAcer3Ergic1Cmtr2Cmtr2Rbm39H1f0Asap1Gng12Stxbp5Rrbp1Myo18aRgl1Cnksr11446410_atAoc3Map3k2Pbrm1Hsd17b6Zfp319Rsl11459237_atPhka11438466_atPhldb21455465_atNedd9Nedd9Znrf31458309_atMettl4Efr3bIft81Notch2Fam73aStard4Capn2Dab2CryabCryabMex3dTimp2ClmnIfnar2Il33Dnajc3Psma8Rps6ka3Magea6Ndc1Pofut2Tmem248Susd2Stard4Zfp667F2rFlrt3Cdh4Akt1Clic51436029_atLamb1Mob3b1439496_atTspan13Adora2bLamb1Smcr8MtapSp8Nrg1Tnfaip3Adora1Fam198bPtpn141417992_a_atSvs3aPdzk1Tspan6Glipr1Nedd9Igf1MpripPitx2Tgfbr3Ddah1Slc40a1CtdsplSoat2Nol4lAfap1CtsbAtp2b1Tnfrsf21Dnajc3Skiv2lTnfrsf12aFhdc11446240_atCasp8Ldlrad3MmePja1Kcng1H192810459M11RikMvb12bTimp3Meg31442257_atAnkrd12Efna3Morc4Efna4EgflamTspan13Dnajc3Klf15Rdh11Cotl1Cotl1Ggta1MttpLoxl2Pla2g12bBmperFam134bFhl1Rcn3Iqgap2Hnf1bHnf1bPlatSpns2Clic5Rhox6Chst15Galnt10Sel1lLeprel1Ptpn14Stard8IhhFoxa2Spink3Dkk1NostrinBag2Ptpn14Lrrc1Lrp2Nxf7Sox7Dab2Dab2AA986860TfecSlc39a8CemipCand2Ccnd2Galnt10Arhgef17Jam3Ninj1Ninj1Gcnt1Rgs12Lgals2Gna12Tc2nWdsub1Stard4Neo1Pknox1TtrTtrTtrAgpat3TtrPlac1Mgst3Fgfr3Gna12Efna3Dusp933 E3.2532 E3.2531 E3.2534 E3.2518 E3.2522 E3.2521 E3.2524 E3.2520 E3.2536 E3.2513 E3.2516 E3.257 E3.258 E3.256 E3.2515 E3.2512 E3.2514 E3.2510 E3.253 E3.255 E3.251 E3.2511 E3.254 E3.2517 E3.252 E3.259 E3.2530 E3.2526 E3.2528 E3.2519 E3.2535 E3.2527 E3.2529 E3.2523 E3.2525 E3.2555 E3.5 (EPI)42 E3.5 (EPI)46 E3.5 (EPI)48 E3.5 (EPI)57 E3.5 (EPI)47 E3.5 (EPI)56 E3.5 (EPI)40 E3.5 (EPI)45 E3.5 (EPI)39 E3.5 (EPI)44 E3.5 (EPI)62 E4.5 (EPI)64 E4.5 (EPI)60 E4.5 (EPI)63 E4.5 (EPI)43 E3.5 (PE)50 E3.5 (PE)51 E3.5 (PE)52 E3.5 (PE)53 E3.5 (PE)54 E3.5 (PE)58 E3.5 (PE)49 E3.5 (PE)38 E3.5 (PE)37 E3.5 (PE)41 E3.5 (PE)61 E4.5 (PE)66 E4.5 (PE)59 E4.5 (PE)65 E4.5 (PE)0.00.20.40.60.81.0Analysis report: Ohnishi et al., 2014

> rbGenes = sort(unique(fData(x)$symbol[thclasses[, "PE-3"]]))

> rbGenes

[1] "4930506M07Rik" "Ada"

[5] "Aqp8"

[9] "Bend5"

[13] "Creb3l2"

[17] "Elovl1"

[21] "Fam213a"

[25] "Gata4"

[29] "Gyg"

[33] "Ikbkb"

[37] "Mogs"

"Asph"

"Bmp6"

"Cubn"

"Enpep"

"Fam46a"

"Gdpd5"

"Herpud1"

"Lamb1"

"Neo1"

[41] "Pdcd6ip"

"Pde4dip"

"Plod2"

"Pth1r"

[45] "Pip4k2a"

[49] "Prss35"

[53] "Rhpn2"

[57] "Smim14"

[61] "Tcf19"

Difference:

"Aldh18a1"

"B3galnt1"

"Clcn5"

"Dkk1"

"F2r"

"Flrt3"

"Glipr2"

"Hpcal1"

"Lrpap1"

"Pcdh19"

"Pdzd3"

"Plod3"

"Rcn1"

"Apom"

"B4galnt1"

"Col4a1"

"Dnajc22"

"Fam198b"

"Foxq1"

"Gstm2"

"Hs3st1"

"Lrrc16a"

"Pcyox1"

"Pga5"

"Prrc2c"

"Reep5"

"Serpine2"

"Serpinh1"

"Slc26a2"

"Soat1"

"Srgn"

"Synj1"

"Tmem150a"

"Tmem98"

> setdiff(fig2bGenes, rbGenes)

character(0)

58

Analysis report: Ohnishi et al., 2014

10

qPCR data analysis

10.1 Heatmaps for all data in xq

We first load the data

> data("xq")

> xq$sampleColours = sampleColourMap[sub("[[:digit:]]+ ", "", sampleNames(xq))]

> stopifnot(!any(is.na(xq$sampleColours)))

Next, we define a function myHeatmap3 to create heatmaps

> myHeatmap3 = function(x, log = TRUE,

col = colorRampPalette(RColorBrewer::brewer.pal(9, "Blues"))(ncol), ncol = 100, ...) {

mat = exprs(x)

if(log){

mat[mat<1] = 1

mat = log10(mat)

}

rownames(mat) = fData(x)[, "symbol"]

gplots::heatmap.2(mat, trace = "none", dendrogram = "none", scale = "none", col = col,

keysize = 0.9, ColSideColors = x$sampleColour, margins = c(5,7), ...)

+

+

+

+

+

+

+

+

+

+ }

and use it to visualize data in xq.

> myHeatmap3(xq)

See Figure 39.

10.2 Heatmaps for the seven selected genes and selected sam-

ples

> selectedGenes = c("Col4a1", "Lamab1", "Cubn", "Gata4", "Serpinh1", "Foxq1", "Aldh18a1")

> myHeatmap3(xq[selectedGenes, ])

See Figure 40.

> selectedSamples = (xq$Cell.type %in% c("ICM", "PE"))

> table(xq$sampleGroup[selectedSamples])

E3.25 E3.5 (PE) E4.5 (PE)

33

22

31

> sxq = xq[selectedGenes, selectedSamples]

> groups = c("E3.25", "E3.5 (PE)", "E4.5 (PE)")

> sxq$fsampleGroup = factor(sxq$sampleGroup, levels = groups)

> stopifnot(!any(is.na(sxq$fsampleGroup)))

> myHeatmap3(sxq)

59

Analysis report: Ohnishi et al., 2014

Figure 39: Heatmap of the qPCR data set. The data are shown on the logarithmic (base 10) scale. Be-
fore transformation, values < 1 were set to 1. The colour code of the bar at the top is as in Figure 15.

Figure 40: Heatmap of the qPCR data for the 7 selected genes.

See Figure 41.

10.3 Distribution of the data and discretisation

The qPCR expression levels in sxq are compared, separately for each gene, against the mid-
point of the means of successive groups (E3.25, E3.5 (PE), E4.5 (PE)). This is illustrated in
Figure 42.

> groupmedians = t(apply(exprs(sxq), 1, function(v) tapply(v, sxq$sampleGroup, median)))

> stopifnot(identical(colnames(groupmedians), groups), length(groups)==3)

60

12 E3.2575 E3.5 (PE)11 E3.2563 E3.5 (PE)66 E3.5 (PE)65 E3.5 (PE)44 E3.5 (PE)76 E3.5 (PE)68 E3.5 (PE)62 E3.5 (PE)55 E3.5 (PE)45 E3.5 (PE)64 E3.5 (PE)72 E3.5 (PE)37 E3.5 (PE)36 E3.5 (PE)42 E3.5 (PE)58 E3.5 (PE)70 E3.5 (PE)49 E3.5 (PE)46 E3.5 (PE)40 E3.5 (PE)38 E3.5 (PE)96 E4.5 (PE)88 E4.5 (PE)90 E4.5 (PE)83 E4.5 (PE)85 E4.5 (PE)84 E4.5 (PE)92 E4.5 (PE)118 E4.5 (PE)135 E4.5 (PE)120 E4.5 (PE)119 E4.5 (PE)97 E4.5 (PE)116 E4.5 (PE)113 E4.5 (PE)112 E4.5 (PE)114 E4.5 (PE)103 E4.5 (PE)117 E4.5 (PE)115 E4.5 (PE)110 E4.5 (PE)104 E4.5 (PE)111 E4.5 (PE)121 E4.5 (PE)99 E4.5 (PE)100 E4.5 (PE)95 E4.5 (PE)87 E4.5 (PE)93 E4.5 (PE)86 E4.5 (PE)91 E4.5 (PE)94 E4.5 (PE)78 E4.5 (EPI)71 E3.5 (EPI)34 E3.5 (EPI)1 E3.2518 E3.2523 E3.2528 E3.2530 E3.2521 E3.2522 E3.2520 E3.2516 E3.2519 E3.256 E3.257 E3.253 E3.2517 E3.2531 E3.2526 E3.2524 E3.2532 E3.2527 E3.2513 E3.2514 E3.2556 E3.5 (EPI)51 E3.5 (EPI)59 E3.5 (EPI)74 E3.5 (EPI)54 E3.5 (EPI)89 E4.5 (EPI)48 E3.5 (EPI)47 E3.5 (EPI)57 E3.5 (EPI)77 E4.5 (EPI)109 E4.5 (EPI)105 E4.5 (EPI)81 E4.5 (EPI)82 E4.5 (EPI)79 E4.5 (EPI)108 E4.5 (EPI)102 E4.5 (EPI)126 E4.5 (EPI)124 E4.5 (EPI)132 E4.5 (EPI)123 E4.5 (EPI)125 E4.5 (EPI)127 E4.5 (EPI)122 E4.5 (EPI)129 E4.5 (EPI)131 E4.5 (EPI)134 E4.5 (EPI)136 E4.5 (EPI)128 E4.5 (EPI)130 E4.5 (EPI)137 E4.5 (EPI)133 E4.5 (EPI)98 E4.5 (EPI)60 E3.5 (EPI)61 E3.5 (PE)101 E4.5 (EPI)107 E4.5 (EPI)106 E4.5 (EPI)80 E4.5 (EPI)53 E3.5 (EPI)2 E3.255 E3.2510 E3.258 E3.259 E3.2533 E3.2515 E3.2529 E3.2569 E3.5 (EPI)67 E3.5 (EPI)25 E3.254 E3.2535 E3.5 (EPI)39 E3.5 (EPI)41 E3.5 (EPI)43 E3.5 (EPI)52 E3.5 (EPI)50 E3.5 (EPI)73 E3.5 (EPI)GapdhNanogFgf4Sox2Spp1Tdgf1Prdm14PapolaEnox1Morc1Erk2Hes1Bmp4Cldn4Gata6Lamab1Serpinh1Gata4CubnCol4a1Col4a2Sox17Hpcal1Foxq1Dab2Lrp2Zp3AmnSdc4Tbpl1Esyt3Tom1l1Lrpap1Mogs1Aldh18a1P4ha2PdgfraSerpine20123Value06001400Color Keyand HistogramCount31 E3.2524 E3.2521 E3.2517 E3.2541 E3.5 (EPI)46 E3.5 (PE)72 E3.5 (PE)12 E3.2532 E3.2574 E3.5 (EPI)28 E3.2530 E3.2514 E3.25105 E4.5 (EPI)123 E4.5 (EPI)109 E4.5 (EPI)77 E4.5 (EPI)8 E3.2513 E3.2580 E4.5 (EPI)53 E3.5 (EPI)18 E3.2547 E3.5 (EPI)34 E3.5 (EPI)9 E3.2510 E3.2550 E3.5 (EPI)52 E3.5 (EPI)16 E3.2519 E3.2526 E3.2559 E3.5 (EPI)43 E3.5 (EPI)15 E3.2573 E3.5 (EPI)51 E3.5 (EPI)20 E3.2571 E3.5 (EPI)56 E3.5 (EPI)22 E3.2554 E3.5 (EPI)29 E3.2548 E3.5 (EPI)126 E4.5 (EPI)57 E3.5 (EPI)33 E3.251 E3.25108 E4.5 (EPI)131 E4.5 (EPI)78 E4.5 (EPI)23 E3.2527 E3.2525 E3.252 E3.2589 E4.5 (EPI)81 E4.5 (EPI)82 E4.5 (EPI)106 E4.5 (EPI)107 E4.5 (EPI)3 E3.2567 E3.5 (EPI)7 E3.256 E3.25127 E4.5 (EPI)4 E3.25129 E4.5 (EPI)5 E3.2569 E3.5 (EPI)124 E4.5 (EPI)35 E3.5 (EPI)122 E4.5 (EPI)125 E4.5 (EPI)60 E3.5 (EPI)39 E3.5 (EPI)128 E4.5 (EPI)79 E4.5 (EPI)134 E4.5 (EPI)136 E4.5 (EPI)102 E4.5 (EPI)137 E4.5 (EPI)101 E4.5 (EPI)133 E4.5 (EPI)132 E4.5 (EPI)130 E4.5 (EPI)38 E3.5 (PE)75 E3.5 (PE)96 E4.5 (PE)64 E3.5 (PE)61 E3.5 (PE)11 E3.2544 E3.5 (PE)98 E4.5 (EPI)55 E3.5 (PE)42 E3.5 (PE)45 E3.5 (PE)58 E3.5 (PE)68 E3.5 (PE)37 E3.5 (PE)62 E3.5 (PE)70 E3.5 (PE)76 E3.5 (PE)40 E3.5 (PE)49 E3.5 (PE)36 E3.5 (PE)86 E4.5 (PE)111 E4.5 (PE)104 E4.5 (PE)99 E4.5 (PE)115 E4.5 (PE)100 E4.5 (PE)97 E4.5 (PE)113 E4.5 (PE)110 E4.5 (PE)103 E4.5 (PE)117 E4.5 (PE)112 E4.5 (PE)116 E4.5 (PE)114 E4.5 (PE)85 E4.5 (PE)120 E4.5 (PE)118 E4.5 (PE)119 E4.5 (PE)121 E4.5 (PE)87 E4.5 (PE)90 E4.5 (PE)135 E4.5 (PE)83 E4.5 (PE)93 E4.5 (PE)92 E4.5 (PE)91 E4.5 (PE)94 E4.5 (PE)66 E3.5 (PE)63 E3.5 (PE)84 E4.5 (PE)88 E4.5 (PE)65 E3.5 (PE)95 E4.5 (PE)Serpinh1Lamab1Foxq1Aldh18a1CubnCol4a1Gata40123Value0Color Keyand HistogramCountAnalysis report: Ohnishi et al., 2014

Figure 41: Heatmap for the 7 selected genes and the E3.25/E3.5/E4.5 PE samples. Rows and columns are
ordered by clustering dendrogram.

> discrthreshs = (groupmedians[, 2:3] + groupmedians[, 1:2]) / 2

> stst = sapply(split(seq(along = sxq$sampleGroup), sxq$sampleGroup),

+

function(v) {i1 = head(v,1); i2 = tail(v,1); stopifnot(identical(v, i1:i2)); c(i1,i2)})

> groupmedians

E3.25 E3.5 (PE) E4.5 (PE)

Col4a1

3.927113e+00 59.74835 496.3785

Lamab1

1.357524e+02 600.90534 1798.2736

Cubn

Gata4

3.998510e-01 30.70686 1193.0876

1.000891e+00 368.04084 696.1946

Serpinh1 5.538977e-03 327.21530 3899.7357

Foxq1

2.356829e-01 42.22368 150.9035

Aldh18a1 6.025723e+00 87.25491 142.3794

> discrthreshs

E3.5 (PE) E4.5 (PE)

Col4a1

31.83773 278.06342

Lamab1

368.32889 1199.58945

Cubn

Gata4

15.55335 611.89724

184.52087 532.11771

Serpinh1 163.61042 2113.47551

Foxq1

21.22968

96.56359

Aldh18a1 46.64032 114.81716

> op = par(mfrow = c(nrow(sxq), 1), mai = c(0.1, 0.7, 0.01, 0.01))
> for(j in seq_len(nrow(sxq))) {
+

plot(exprs(sxq)[j, ], type = "n", xaxt = "n", ylab = fData(sxq)$symbol[j])

segments(x0 = stst[1, ], x1 = stst[2, ], y0 = groupmedians[j, ], col = "#808080", lty=3)

segments(x0 = stst[1,1:2], x1 = stst[2,2:3], y0 = discrthreshs[j, ], col = "#404040")

points(exprs(sxq)[j, ], pch = 16, col = sxq$sampleColour)

+

+

+

+ }

> par(op)

61

31 E3.2524 E3.2521 E3.2517 E3.253 E3.257 E3.2572 E3.5 (PE)12 E3.2532 E3.2528 E3.2530 E3.252 E3.2514 E3.258 E3.2513 E3.2520 E3.2515 E3.2526 E3.2516 E3.2519 E3.2518 E3.2523 E3.2527 E3.2525 E3.2533 E3.2522 E3.2529 E3.255 E3.251 E3.256 E3.254 E3.2575 E3.5 (PE)96 E4.5 (PE)64 E3.5 (PE)61 E3.5 (PE)11 E3.2538 E3.5 (PE)46 E3.5 (PE)9 E3.2510 E3.2544 E3.5 (PE)55 E3.5 (PE)42 E3.5 (PE)45 E3.5 (PE)58 E3.5 (PE)68 E3.5 (PE)37 E3.5 (PE)62 E3.5 (PE)70 E3.5 (PE)76 E3.5 (PE)40 E3.5 (PE)49 E3.5 (PE)36 E3.5 (PE)86 E4.5 (PE)111 E4.5 (PE)104 E4.5 (PE)99 E4.5 (PE)115 E4.5 (PE)100 E4.5 (PE)97 E4.5 (PE)113 E4.5 (PE)110 E4.5 (PE)103 E4.5 (PE)117 E4.5 (PE)112 E4.5 (PE)116 E4.5 (PE)114 E4.5 (PE)85 E4.5 (PE)120 E4.5 (PE)118 E4.5 (PE)119 E4.5 (PE)121 E4.5 (PE)87 E4.5 (PE)90 E4.5 (PE)135 E4.5 (PE)83 E4.5 (PE)93 E4.5 (PE)92 E4.5 (PE)91 E4.5 (PE)94 E4.5 (PE)66 E3.5 (PE)63 E3.5 (PE)84 E4.5 (PE)88 E4.5 (PE)65 E3.5 (PE)95 E4.5 (PE)Foxq1Aldh18a1Lamab1CubnSerpinh1Col4a1Gata40123Value0Color Keyand HistogramCountAnalysis report: Ohnishi et al., 2014

Figure 42: Visualisation of the qPCR data for the seven genes. Shown are also the within-group means
(horizontal dotted light grey lines) and the discretisation thresholds (horizontal solid dark grey lines).

In this way, the data are assigned to three discrete levels:

1. less than the midpoint of the means of E3.25 and E3.5 (PE),

2. in between 1. and 3.,

3. higher than the midpoint of the means of E3.5 (PE) and E4.5 (PE),

The result of this is shown in Figure 43, where these three levels are represented by white,
light blue, dark blue.

> discretize = function(x) {

+

+

+

+

exprs(x) = t(sapply(seq_len(nrow(exprs(x))), function(r) {

as.integer(cut(exprs(x)[r, ], breaks = c(-Inf, discrthreshs[r, ],+Inf)))

}))

return(x)

62

05001500IndexCol4a1020005000IndexLamab1040008000IndexCubn010002000IndexGata40400010000IndexSerpinh10400800IndexFoxq10200500IndexAldh18a1Analysis report: Ohnishi et al., 2014

+ }

> sxqd = discretize(sxq)

> myHeatmap3(sxqd, log = FALSE, Colv = FALSE, Rowv = FALSE, key = FALSE, ncol = 3)

Figure 43: Heatmap for the discretized values. Rows and colums are in the original order.

10.4 Temporal order - hierarchy

Now we look for a (putatively: temporal) ordering of genes, so that the number of cases
(samples × genes) in which a lower level follows a higher one is minimised. More specifically,
the function costfun1 below adds a penalty of 1 for every instance that in a sample, white
follows after blue in an E3.5 sample (for the E3.25→E3.5 transition), and costfun2 adds a
penalty of 1 when white/light blue follow after dark blue in an E4.5 sample (for E3.5→E4.5)
.

> stopifnot(all(exprs(sxqd)%in%(1:3)))

> costfun1 = function(x, sg) {

k = (sg=="E3.5 (PE)")

mean( (x[-1,k]==1) & (x[-nrow(x),k]>1 ) )

+

+

+ }

> costfun2 = function(x, sg) {

k = (sg=="E4.5 (PE)")

mean( (x[-1,k]<3 ) & (x[-nrow(x),k]==3) )

+

+

+ }

> perms = permutations(nrow(sxq), nrow(sxq))

> bruteForceOptimisation = function(fun, samps) {

if (missing(samps)) samps = rep(TRUE, ncol(sxqd))

apply(perms, 1, function(i) fun(exprs(sxqd)[i, samps], sxq$sampleGroup[samps]))

+

+

+ }

> costs = list(
+ `E3.25 -> E3.5` = bruteForceOptimisation(costfun1),
`E3.5 -> E4.5` = bruteForceOptimisation(costfun2))
+
> whopt = lapply(costs, function(v) which(v==min(v)))

63

1 E3.252 E3.253 E3.254 E3.255 E3.256 E3.257 E3.258 E3.259 E3.2510 E3.2511 E3.2512 E3.2513 E3.2514 E3.2515 E3.2516 E3.2517 E3.2518 E3.2519 E3.2520 E3.2521 E3.2522 E3.2523 E3.2524 E3.2525 E3.2526 E3.2527 E3.2528 E3.2529 E3.2530 E3.2531 E3.2532 E3.2533 E3.2536 E3.5 (PE)37 E3.5 (PE)38 E3.5 (PE)40 E3.5 (PE)42 E3.5 (PE)44 E3.5 (PE)45 E3.5 (PE)46 E3.5 (PE)49 E3.5 (PE)55 E3.5 (PE)58 E3.5 (PE)61 E3.5 (PE)62 E3.5 (PE)63 E3.5 (PE)64 E3.5 (PE)65 E3.5 (PE)66 E3.5 (PE)68 E3.5 (PE)70 E3.5 (PE)72 E3.5 (PE)75 E3.5 (PE)76 E3.5 (PE)83 E4.5 (PE)84 E4.5 (PE)85 E4.5 (PE)86 E4.5 (PE)87 E4.5 (PE)88 E4.5 (PE)90 E4.5 (PE)91 E4.5 (PE)92 E4.5 (PE)93 E4.5 (PE)94 E4.5 (PE)95 E4.5 (PE)96 E4.5 (PE)97 E4.5 (PE)99 E4.5 (PE)100 E4.5 (PE)103 E4.5 (PE)104 E4.5 (PE)110 E4.5 (PE)111 E4.5 (PE)112 E4.5 (PE)113 E4.5 (PE)114 E4.5 (PE)115 E4.5 (PE)116 E4.5 (PE)117 E4.5 (PE)118 E4.5 (PE)119 E4.5 (PE)120 E4.5 (PE)121 E4.5 (PE)135 E4.5 (PE)Aldh18a1Foxq1Serpinh1Gata4CubnLamab1Col4a1Analysis report: Ohnishi et al., 2014

Figure 44: Heatmaps, ordered to show potential hierarchy of successive activation. This was done sepa-
rately for the E3.25 – E3.5 (PE) and the E3.5 (PE) – E4.5 (PE) comparisons (as indicated by the horizon-
tal colour bar). Note: if multiple equally optimally solutions were found, all are displayed.

> outf = file("fighmd.tex", open="w")

> for(i in seq(along = costs)) {

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

sxqdsub = switch(i,

{

rv = sxqd[, sxqd$sampleGroup %in% groups[2] ]

exprs(rv)[ exprs(rv)>2 ] = 2

rv

}, {

rv = sxqd[, sxqd$sampleGroup %in% groups[3] ]

exprs(rv)[ exprs(rv)<2 ] = 2

exprs(rv) = exprs(rv)-1

rv

})

columnOrder = order(sxqdsub$sampleGroup, colSums(exprs(sxqdsub)))

for(w in whopt[[i]]) {

fn = sprintf("fighmd-%d-%d.pdf", i, w)

pdf(fn, width = 7, height = 3)

myHeatmap3(sxqdsub[perms[w, ], columnOrder], log = FALSE, Colv = FALSE, Rowv = FALSE,

key = FALSE, ncol = 2, breaks = seq(0.5, 2.5, by = 1))

dev.off()

cat("\\includegraphics[width=0.49\\textwidth]{", fn, "}\n", file = outf, sep = "")

64

46 E3.5 (PE)58 E3.5 (PE)38 E3.5 (PE)40 E3.5 (PE)72 E3.5 (PE)36 E3.5 (PE)49 E3.5 (PE)64 E3.5 (PE)70 E3.5 (PE)37 E3.5 (PE)42 E3.5 (PE)44 E3.5 (PE)55 E3.5 (PE)61 E3.5 (PE)68 E3.5 (PE)75 E3.5 (PE)76 E3.5 (PE)45 E3.5 (PE)62 E3.5 (PE)63 E3.5 (PE)65 E3.5 (PE)66 E3.5 (PE)Gata4Serpinh1Aldh18a1Col4a1Lamab1CubnFoxq146 E3.5 (PE)58 E3.5 (PE)38 E3.5 (PE)40 E3.5 (PE)72 E3.5 (PE)36 E3.5 (PE)49 E3.5 (PE)64 E3.5 (PE)70 E3.5 (PE)37 E3.5 (PE)42 E3.5 (PE)44 E3.5 (PE)55 E3.5 (PE)61 E3.5 (PE)68 E3.5 (PE)75 E3.5 (PE)76 E3.5 (PE)45 E3.5 (PE)62 E3.5 (PE)63 E3.5 (PE)65 E3.5 (PE)66 E3.5 (PE)Serpinh1Aldh18a1Col4a1Lamab1CubnGata4Foxq146 E3.5 (PE)58 E3.5 (PE)38 E3.5 (PE)40 E3.5 (PE)72 E3.5 (PE)36 E3.5 (PE)49 E3.5 (PE)64 E3.5 (PE)70 E3.5 (PE)37 E3.5 (PE)42 E3.5 (PE)44 E3.5 (PE)55 E3.5 (PE)61 E3.5 (PE)68 E3.5 (PE)75 E3.5 (PE)76 E3.5 (PE)45 E3.5 (PE)62 E3.5 (PE)63 E3.5 (PE)65 E3.5 (PE)66 E3.5 (PE)CubnLamab1Col4a1Aldh18a1Serpinh1Gata4Foxq146 E3.5 (PE)58 E3.5 (PE)38 E3.5 (PE)40 E3.5 (PE)72 E3.5 (PE)36 E3.5 (PE)49 E3.5 (PE)64 E3.5 (PE)70 E3.5 (PE)37 E3.5 (PE)42 E3.5 (PE)44 E3.5 (PE)55 E3.5 (PE)61 E3.5 (PE)68 E3.5 (PE)75 E3.5 (PE)76 E3.5 (PE)45 E3.5 (PE)62 E3.5 (PE)63 E3.5 (PE)65 E3.5 (PE)66 E3.5 (PE)Serpinh1Gata4CubnLamab1Col4a1Aldh18a1Foxq146 E3.5 (PE)58 E3.5 (PE)38 E3.5 (PE)40 E3.5 (PE)72 E3.5 (PE)36 E3.5 (PE)49 E3.5 (PE)64 E3.5 (PE)70 E3.5 (PE)37 E3.5 (PE)42 E3.5 (PE)44 E3.5 (PE)55 E3.5 (PE)61 E3.5 (PE)68 E3.5 (PE)75 E3.5 (PE)76 E3.5 (PE)45 E3.5 (PE)62 E3.5 (PE)63 E3.5 (PE)65 E3.5 (PE)66 E3.5 (PE)Gata4Serpinh1CubnLamab1Col4a1Aldh18a1Foxq146 E3.5 (PE)58 E3.5 (PE)38 E3.5 (PE)40 E3.5 (PE)72 E3.5 (PE)36 E3.5 (PE)49 E3.5 (PE)64 E3.5 (PE)70 E3.5 (PE)37 E3.5 (PE)42 E3.5 (PE)44 E3.5 (PE)55 E3.5 (PE)61 E3.5 (PE)68 E3.5 (PE)75 E3.5 (PE)76 E3.5 (PE)45 E3.5 (PE)62 E3.5 (PE)63 E3.5 (PE)65 E3.5 (PE)66 E3.5 (PE)Gata4CubnLamab1Col4a1Serpinh1Aldh18a1Foxq146 E3.5 (PE)58 E3.5 (PE)38 E3.5 (PE)40 E3.5 (PE)72 E3.5 (PE)36 E3.5 (PE)49 E3.5 (PE)64 E3.5 (PE)70 E3.5 (PE)37 E3.5 (PE)42 E3.5 (PE)44 E3.5 (PE)55 E3.5 (PE)61 E3.5 (PE)68 E3.5 (PE)75 E3.5 (PE)76 E3.5 (PE)45 E3.5 (PE)62 E3.5 (PE)63 E3.5 (PE)65 E3.5 (PE)66 E3.5 (PE)Col4a1Lamab1CubnGata4Serpinh1Aldh18a1Foxq184 E4.5 (PE)90 E4.5 (PE)135 E4.5 (PE)87 E4.5 (PE)88 E4.5 (PE)96 E4.5 (PE)120 E4.5 (PE)83 E4.5 (PE)93 E4.5 (PE)118 E4.5 (PE)119 E4.5 (PE)85 E4.5 (PE)91 E4.5 (PE)92 E4.5 (PE)94 E4.5 (PE)95 E4.5 (PE)121 E4.5 (PE)99 E4.5 (PE)104 E4.5 (PE)86 E4.5 (PE)97 E4.5 (PE)100 E4.5 (PE)103 E4.5 (PE)110 E4.5 (PE)111 E4.5 (PE)112 E4.5 (PE)113 E4.5 (PE)114 E4.5 (PE)115 E4.5 (PE)116 E4.5 (PE)117 E4.5 (PE)Lamab1Serpinh1Col4a1CubnAldh18a1Foxq1Gata4Analysis report: Ohnishi et al., 2014

+

}

+ }

> close(outf)

> for(i in seq(along = costs)) {

k = unique(costs[[i]][whopt[[i]]])

stopifnot(length(k)==1)

cat(sprintf("%14s: cost %g\n", names(costs)[[i]], k))

+

+

+

+ }

E3.25 -> E3.5: cost 0.106061

E3.5 -> E4.5: cost 0.0591398

See Figure 44.

10.4.1 How significant is this?

Repeat the above with bootstrapping.

> bopt = lapply(list(costfun1, costfun2), function(fun) {

boot(data = seq_len(ncol(sxqd)),

statistic = function(dummy, idx) min(bruteForceOptimisation(fun, idx)),

R = 250)

+

+

+

+ })

> names(bopt) = names(costs)
> lapply(bopt, `[[`, "t0")

$`E3.25 -> E3.5`
[1] 0.1060606

$`E3.5 -> E4.5`
[1] 0.05913978

> multiecdf(lapply(bopt, `[[`, "t"))
> t.test(x = bopt[[1]]$t, y = bopt[[2]]$t)

Welch Two Sample t-test

data:

bopt[[1]]$t and bopt[[2]]$t

t = 21.15, df = 472.55, p-value < 2.2e-16

alternative hypothesis: true difference in means is not equal to 0

95 percent confidence interval:

0.02833504 0.03413928

sample estimates:

mean of x mean of y

0.08496477 0.05372761

See Figure 45.

65

Analysis report: Ohnishi et al., 2014

Figure 45: Distribution of bootstrap-resampled optimal costs ("disorder penalties"). Shown are the empiri-
cal distribution function of the bootstrap-sampled cost functions for the two situations. The values for E3.5
-> E4.5 are significantly smaller (see also t-test result in the main text).

66

0.020.040.060.080.100.120.00.20.40.60.81.0ecdflapply(bopt, ‘[[‘, "t")Fn(x)E3.25 −> E3.5E3.5 −> E4.5Analysis report: Ohnishi et al., 2014

A

Influence of cell position on gene expression

To examine how cell position within the embryo influences its gene expression, cells lying on
the surface of the ICM facing the blastocyst cavity were fluorescently labelled and expression
profiled versus those located deeper within the ICM. We then used multi-dimensional scaling
to compare the labelled and non-labelled cells at E3.5 and E4.5, based on the expression of
10 highly variable genes, as identified from the E3.5 and 4.5 microarray data, and quantified
by single-cell qPCR measurements. The result of this analysis is show in Figure 46.

> data("xql")

> labeledSampleColourMap = c(RColorBrewer::brewer.pal(5, "RdGy")[c(1,2)], RColorBrewer::brewer.pal(5, "BrBG")[c(4,5)])
> names(labeledSampleColourMap) = c("E4.5_high", "E3.5_high", "E3.5_low",
> labeledGroups = with(pData(xql), list(

"E4.5_low")

+

+

+

`E3.5_high` = which(Label=="High" & Embryonic.day=="E3.5"),
`E3.5_low` = which(Label=="Low"
& Embryonic.day=="E3.5"),
`E4.5_high`
`E4.5_low` = which(Label=="Low"

& Embryonic.day=="E4.5")))

= which(Label=="High" & Embryonic.day=="E4.5"),

+
> labeledSampleColours = rep(NA_character_, ncol(xql))
> for(i in seq(along = labeledGroups))

+

labeledSampleColours[labeledGroups[[i]]] = labeledSampleColourMap[names(labeledGroups)[i]]

> xql$sampleColours = labeledSampleColours

> md = MASS::isoMDS(dist(t(log(exprs(xql),2))))$points

> plot(md, col = xql$sampleColours, pch = 16, asp = 1, xlab = "",ylab = "")

Figure 46: Multi-dimensional scaling plot. Light red and light green dots represent E3.5 labeled and unla-
beled cells, while red and green ones represent E4.5 labeled and unlabeled cells, respectively.

67

−20−1001020−20−1001020Analysis report: Ohnishi et al., 2014

B

Correlation between Fgf ligands and Fgf receptors

Several Fgf ligands (Fgf3, 4 and 13) and all Fgf receptors (Fgfr1-4) were found to be differ-
entially expressed within the ICM, thus possibly contributing to the EPI versus PrE lineage
segregation. We have found that a statistically significant correlation (positive or negative)
in gene expression levels is discernible at single cell level for Fgf4 against Fgfr2, Fgf4 against
Fgfr3, Fgf3 with Fgfr3, and Fgf3 with Fgfr4 at E3.5 and E4.5 (Figure 47).

> xs = x[, (x$genotype %in% "WT") & (x$Embryonic.day %in% c("E3.25","E3.5","E4.5"))]
> Fgf3 = c("1441914_x_at")
> Fgf4 = c("1420086_x_at")
> Fgfr2 = c("1433489_s_at")
> Fgfr3 = c("1421841_at")
> Fgfr4 = c("1418596_at")
> correlationPlot = function(ID){

xsl = xs[ID, ]

mat = exprs(xsl)

rownames(mat) = fData(xsl)[, "symbol"]

plot(t(mat), pch = 16, asp = 1, cex = 1.25, cex.lab = 1.2, col = xs$sampleColour,

xlim = c(2,12), ylim = c(3,11))

+

+

+

+

+

+ }

> par(mfrow = c(1,4))

> correlationPlot(c(Fgf4,Fgfr2))

> correlationPlot(c(Fgf4,Fgfr3))

> correlationPlot(c(Fgf3,Fgfr3))

> correlationPlot(c(Fgf3,Fgfr4))

Figure 47: Correlation between Fgf ligands and Fgf receptors. Scatter plots with each dot representing the
mRNA expression levels of specific Fgf ligand and receptor pairs in one blastomere. The colour code is as
in Figure 15, with pink representing E3.25 cells, light blue and light green E3.5 EPI and PrE cells, and blue
and green E4.5 EPI and PrE cells, respectively.

C

Session info

Below, the output is shown of sessionInfo on the system on which this document was
compiled.

> toLatex(sessionInfo())

• R version 4.5.1 Patched (2025-08-23 r88802), x86_64-pc-linux-gnu

68

2468101224681012Fgf4Fgfr22468101224681012Fgf4Fgfr32468101224681012Fgf3Fgfr32468101224681012Fgf3Fgfr4Analysis report: Ohnishi et al., 2014

• Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_GB, LC_COLLATE=C,
LC_MONETARY=en_US.UTF-8, LC_MESSAGES=en_US.UTF-8, LC_PAPER=en_US.UTF-8,
LC_NAME=C, LC_ADDRESS=C, LC_TELEPHONE=C, LC_MEASUREMENT=en_US.UTF-8,
LC_IDENTIFICATION=C

• Time zone: America/New_York

• TZcode source: system (glibc)

• Running under: Ubuntu 24.04.3 LTS

• Matrix products: default

• BLAS: /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

• LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

• Base packages: base, datasets, grDevices, graphics, methods, stats, stats4, utils

• Other packages: AnnotationDbi 1.72.0, Biobase 2.70.0, BiocGenerics 0.56.0,
Hiiragi2013 1.46.0, IRanges 2.44.0, KEGGREST 1.50.0, S4Vectors 0.48.0,
XML 3.99-0.19, affy 1.88.0, annotate 1.88.0, boot 1.3-32, clue 0.3-66,
genefilter 1.92.0, geneplotter 1.88.0, generics 0.1.4, gtools 3.9.5, lattice 0.22-7,
mouse4302.db 3.13.0, mouse4302cdf 2.18.0, org.Mm.eg.db 3.22.0, xtable 1.8-4

• Loaded via a namespace (and not attached): BiocManager 1.30.26,

BiocStyle 2.38.0, Biostrings 2.78.0, DBI 1.2.3, KernSmooth 2.23-26, MASS 7.3-65,
Matrix 1.7-4, MatrixGenerics 1.22.0, R6 2.6.1, RColorBrewer 1.1-3, RSQLite 2.4.3,
Rcpp 1.1.0, Seqinfo 1.0.0, XVector 0.50.0, affyio 1.80.0, bit 4.6.0, bit64 4.6.0-1,
bitops 1.0-9, blob 1.2.4, caTools 1.18.3, cachem 1.1.0, cli 3.6.5, cluster 2.1.8.1,
compiler 4.5.1, crayon 1.5.3, curl 7.0.0, deldir 2.0-4, digest 0.6.37, evaluate 1.0.5,
fastmap 1.2.0, gplots 3.2.0, grid 4.5.1, htmltools 0.5.8.1, httr 1.4.7, interp 1.1-6,
jpeg 0.1-11, knitr 1.50, latticeExtra 0.6-31, matrixStats 1.5.0, memoise 2.0.1,
pkgconfig 2.0.3, png 0.1-8, preprocessCore 1.72.0, rlang 1.1.6, rmarkdown 2.30,
splines 4.5.1, survival 3.8-3, tools 4.5.1, vctrs 0.6.5, xfun 0.54, yaml 2.3.10

D

The data import script readdata.R

Listing 1: The script readdata.R

library("affy")
library("ArrayExpress")
library("arrayQualityMetrics")
library("mouse4302.db")
library("RColorBrewer")

CELdir
CELfiles = getAE("E-MTAB-1681", path = CELdir, type = "raw")$rawFiles

= tempdir()

## -------------------------------------------------------------------------------------
## Read array metadata table and fill empty cells in the columns Embryonic.day
## and Total.number.of.cells by the values implied ## by the non-empty cells above
## -------------------------------------------------------------------------------------

fillColumn = function(x, empty){

wh = which(!empty(x))
len = length(wh)

69

Analysis report: Ohnishi et al., 2014

wh = c(wh, length(x)+1)
for(i in seq_len(len))

x[ wh[i]:(wh[i+1]-1) ] = x[wh[i]]

return(x)

}

readCSVtable = function(name) {

x = read.csv(name, stringsAsFactors = FALSE, colClasses = "character")
x$Embryonic.day = factor(fillColumn(x$Embryonic.day, empty = function(x) x==""))

wh = which(colnames(x)=="Total.number.of.cells")
if(length(wh)==1) {

x[[wh]] = fillColumn(x$Total.number.of.cells, empty = function(x) x=="" & !is.na(x))
x[[wh]] = as.integer(x[[wh]])

} else {

x$"Total.number.of.cells" = rep(NA, nrow(x))

}
x$Total.number.of.cells = addNA(as.factor(x$Total.number.of.cells))

wh = which(colnames(x) %in% c("X.EPI...PE.", "Type"))
if(length(wh)==1) {

colnames(x)[wh] = "lineage"

} else {

x$lineage = rep(NA, nrow(x))

}

row.names(x) = paste(x$File.name, "CEL", sep = ".")
return(x)

}

## -------------------------------- Script starts here ---------------------------------

pdata = readCSVtable(system.file("scripts", "annotation.csv", package = "Hiiragi2013"))

pdata$genotype = as.factor(ifelse(grepl("_KO$", pdata$File.name), "FGF4-KO", "WT"))

## -------------------------------------------------------------------------------------
## Read the CEL files
## -------------------------------------------------------------------------------------

fileNames = row.names(pdata)
fileExists = (fileNames %in% CELfiles)
stopifnot(all(fileExists))

a = ReadAffy(filenames = fileNames, celfile.path = CELdir, phenoData = pdata,

verbose = TRUE)

pData(a)$ScanDate = factor(as.Date(sub( "10/16/09", "2010-09-16",

sapply(strsplit( protocolData(a)$ScanDate, split = "[T ]" ), ‘[‘, 1) )))

save(a, file="a.rda", compress="xz")

## -------------------------------------------------------------------------------------
## Normalize with RMA
## -------------------------------------------------------------------------------------

x = rma(a)

## Create columns
## fData(x)$symbol:
## fData(x)$genename: a more verbose gene description

gene symbols where available, Affy feature ID otherwise

annotateGene = function(db, what, missing) {

tab = toTable(db[ featureNames(x) ])
mt = match( featureNames(x), tab$probe_id)

70

Analysis report: Ohnishi et al., 2014

ifelse(is.na(mt), missing, tab[[what]][mt])

}
fData(x)$symbol
fData(x)$genename = annotateGene(mouse4302GENENAME, "gene_name", missing = "")
fData(x)$ensembl = annotateGene(mouse4302ENSEMBL, "ensembl_id", missing = "")

= annotateGene(mouse4302SYMBOL,

"symbol", missing = featureNames(x))

## -------------------------------------------------------------------------------------
## Grouping of samples
## -------------------------------------------------------------------------------------

## We define a grouping of the samples and an associated colour map, which will
## be used in the plots throughout this report.

groups = with(pData(x), list(

= which(genotype=="WT" & Embryonic.day=="E3.25"),
= which(genotype=="WT" & Embryonic.day=="E3.5" & lineage=="EPI"),
= which(genotype=="WT" & Embryonic.day=="E4.5" & lineage=="EPI"),
= which(genotype=="WT" & Embryonic.day=="E3.5" & lineage=="PE"),
= which(genotype=="WT" & Embryonic.day=="E4.5" & lineage=="PE"),

‘E3.25‘
‘E3.5 (EPI)‘
‘E4.5 (EPI)‘
‘E3.5 (PE)‘
‘E4.5 (PE)‘
‘E3.25 (FGF4-KO)‘ = which(genotype=="FGF4-KO" & Embryonic.day=="E3.25"),
‘E3.5 (FGF4-KO)‘ = which(genotype=="FGF4-KO" & Embryonic.day=="E3.5"),
‘E4.5 (FGF4-KO)‘ = which(genotype=="FGF4-KO" & Embryonic.day=="E4.5")))

sampleColourMap = character(length(groups))
names(sampleColourMap) = names(groups)
sampleColourMap[c("E3.5 (EPI)", "E4.5 (EPI)")]
sampleColourMap[c("E3.5 (PE)", "E4.5 (PE)")]
sampleColourMap[c("E3.25 (FGF4-KO)")]
sampleColourMap[c("E3.5 (FGF4-KO)", "E4.5 (FGF4-KO)")] = brewer.pal(10, "Paired")[c(8,6)]
sampleColourMap[c("E3.25")]
stopifnot(!any(sampleColourMap==""))

= brewer.pal(10, "Paired")[1:2]
= brewer.pal(10, "Paired")[3:4]
= brewer.pal(10, "Paired")[c(7)]

= brewer.pal(12, "Paired")[c(9)]

## The following assertions aim to make sure that each sample was assigned to
## exactly one group.
stopifnot(!any(duplicated(unlist(groups))),

setequal(unlist(groups), seq_len(ncol(x))),
setequal(names(sampleColourMap), names(groups)))

## Next, assign a colour and a name to each sample, which will be used in the
## subsequent plots. For sample names, use the group name and the array numeric
## index.

sampleNames = sampleGroup = rep(NA_character_, ncol(x))
for(i in seq(along = groups)) {

idx = groups[[i]]
sampleGroup[idx] = names(groups)[i]
sampleNames[idx] = paste(idx, names(groups)[i])

}
pData(x)$sampleGroup = sampleGroup
pData(x)$sampleColour = sampleColourMap[sampleGroup]
sampleNames(x) = sampleNames

save(x, file="x.rda", compress="xz")

References

[1] R. A. Irizarry, B. Hobbs, F. Collin, Y. D. Beazer-Barclay, K. J. Antonellis, U. Scherf, and
T. P. Speed. Exploration, normalization, and summaries of high density oligonucleotide
array probe level data. Biostatistics, 4(2):249–264, 2003.

71

Analysis report: Ohnishi et al., 2014

[2] Richard Bourgon, Robert Gentleman, and Wolfgang Huber.

Independent filtering in-
creases detection power for high-throughput experiments. PNAS, 107(21):9546–9551,
2010.

[3] Kurt Hornik. A CLUE for CLUster Ensembles. Journal of Statistical Software, 14(12),

2005.

[4] E. Dimitriadou, A. Weingessel, and K. Hornik. A combination scheme for fuzzy clustering.
International Journal of Pattern Recognition and Artificial Intelligence, 16:901–912, 2002.

[5] Y. Benjamini and Y. Hochberg. Controlling the false discovery rate: a practical and
powerful approach to multiple testing. Journal of the Royal Statistical Society Series B,
57:289–300, 1995.

[6] Y. Buganim, D. A. Faddah, A. W. Cheng, E. Itskovich, S. Markoulaki, K. Ganz, S. L.
Klemm, A. van Oudenaarden, and R. Jaenisch. Single-Cell Expression Analyses during
Cellular Reprogramming Reveal an Early Stochastic and a Late Hierarchic Phase. Cell,
150:1209–1222, 2012.

72

