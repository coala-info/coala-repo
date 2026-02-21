QUBIC Tutorial

Yu Zhang, Juan Xie, and Qin Ma

Gene expression data is very important in experimental molecular biology (Brazma and Vilo 2000), especially
for cancer study (Fehrmann et al. 2015). The large-scale microarray data and RNA-seq data provide good
opportunity to do the gene co-expression analyses and identify co-expressed gene modules; and the effective
and efficient algorithms are needed to implement such analysis. Substantial efforts have been made in this
field, such as Cheng and Church (2000), Plaid (Lazzeroni, Owen, and others 2002), Bayesian Biclustering
(BCC, Gu and Liu 2008), among them Cheng and Church and Plaid has the R package implementation. It is
worth noting that our in-house biclustering algorithm, QUBIC (Li et al. 2009), is reviewed as one of the best
programs in terms of their prediction performance on benchmark datasets. Most importantly, it is reviewed
as the best one for large-scale real biological data (Eren et al. 2012).

Until now, QUBIC has been cited over 200 times (via Google Scholar) and its web server, QServer, was
developed in 2012 to facilitate the users without comprehensive computational background (Zhou et al. 2012).
In the past five years, the cost of RNA-sequencing decreased dramatically, and the amount of gene expression
data keeps increasing. Upon requests from users and collaborators, we developed this R package of QUBIC
to void submitting large data to a webserver.

The unique features of our R package (Zhang et al. 2017) include (1) updated and more stable back-end
resource code (re-written by C++), which has better memory control and is more efficient than the one
published in 2009. For an input dataset in Arabidopsis, with 25,698 genes and 208 samples, we observed more
than 40% time saving; and (2) comprehensive functions and examples, including discretize function, heatmap
drawing and network analysis.

How to cite

citation("QUBIC")

Please cite the QUBIC package in your work, whenever you use it:

Yu Zhang, Juan Xie, Jinyu Yang, Anne Fennell, Chi Zhang, Qin Ma; QUBIC: a
bioconductor package for qualitative biclustering analysis of gene co-expression
data. Bioinformatics, 2017; 33 (3): 450-452. doi: 10.1093/bioinformatics/btw635

A BibTeX entry for LaTeX users is

@Article{,

title = {{QUBIC}: a bioconductor package for qualitative biclustering analysis of gene
co-expression data},
author = {Yu Zhang and Juan Xie and Jinyu Yang and Anne Fennell and Chi Zhang and Qin Ma},
journal = {Bioinformatics},
year = {2017},
volume = {33},
number = {3},
pages = {450--452},
doi = {10.1093/bioinformatics/btw635},

}

1

Other languages

If R is not your thing, there is also a C version of QUBIC.

Help

If you are having trouble with this R package, contact the maintainer, Yu Zhang.

Install and load

Stable version from BioConductor

if (!requireNamespace("BiocManager", quietly = TRUE))

install.packages("BiocManager")

BiocManager::install("QUBIC")

Or development version from GitHub

install.packages("devtools")
devtools::install_github("zy26/QUBIC")

Load QUBIC

library("QUBIC")

Functions

There are nine functions provided by QUBIC package.

• qudiscretize()creates a discrete matrix for a given gene expression matrix;
• BCQU()performs a qualitative biclustering for real matrix;
• BCQUD()performs a qualitative biclustering for discretized matrix;
• quheatmap()can draw heatmap for singe bicluster or overlapped biclusters;
• qunetwork() can automatically create co-expression networks based on the identified biclusters by

QUBIC;

• qunet2xml()can convert the constructed co-expression networks into XGMML format for further network

analysis in Cytoscape, Biomax and JNets;

• query-based biclustering allows users to input additional biological information to guide the biclustering

progress;

• bicluster expanding expands existing biclusters under specified consistency level;
• biclusters comparison compares biclusters obtained via different algorithms or parameters.

The following examples illustrate how these functions work.

Example of a random matrix with two diferent embedded biclusters

library(QUBIC)
set.seed(1)
# Create a random matrix
test <- matrix(rnorm(10000), 100, 100)
colnames(test) <- paste("cond", 1:100, sep = "_")
rownames(test) <- paste("gene", 1:100, sep = "_")

2

# Discretization
matrix1 <- test[1:7, 1:4]
matrix1

cond_1

cond_2
##
## gene_1 -0.6264538 -0.62036668
## gene_2 0.1836433
0.04211587
## gene_3 -0.8356286 -0.91092165
## gene_4 1.5952808
## gene_5 0.3295078 -0.65458464 -2.2852355
2.4976616
## gene_6 -0.8204684
0.6670662
## gene_7 0.4874291

cond_4
cond_3
0.4094018
0.89367370
1.6888733 -1.04729815
1.97133739
1.5865884
0.15802877 -0.3309078 -0.38363211
1.65414530
1.51221269
0.08296573

1.76728727
0.71670748

matrix2 <- qudiscretize(matrix1)
matrix2

##
## gene_1
## gene_2
## gene_3
## gene_4
## gene_5
## gene_6
## gene_7

cond_1 cond_2 cond_3 cond_4
1
-1
1
-1
1
0
-1

0
0
-1
0
0
0
1

-1
0
0
1
0
-1
0

0
1
0
0
-1
1
0

# Fill bicluster blocks
t1 <- runif(10, 0.8, 1)
t2 <- runif(10, 0.8, 1) * (-1)
t3 <- runif(10, 0.8, 1) * sample(c(-1, 1), 10, replace = TRUE)
test[11:20, 11:20] <- t(rep(t1, 10) * rnorm(100, 3, 0.3))
test[31:40, 31:40] <- t(rep(t2, 10) * rnorm(100, 3, 0.3))
test[51:60, 51:60] <- t(rep(t3, 10) * rnorm(100, 3, 0.3))

# QUBIC
res <- biclust::biclust(test, method = BCQU())
summary(res)

biclust::biclust(x = test, method = BCQU())

40

##
## An object of class Biclust
##
## call:
##
##
## Number of Clusters found:
##
## Cluster sizes:
##
## Number of Rows:
## Number of Columns:
##
## Number of Rows:
## Number of Columns:
##
## Number of Rows:
## Number of Columns:

10
9

2
5

9
8

3
5

3
5

5
3

9
7

10
9

BC 1 BC 2 BC 3 BC 4 BC 5 BC 6 BC 7 BC 8 BC 9 BC 10 BC 11 BC 12 BC 13 BC 14
2
6

3
5
BC 15 BC 16 BC 17 BC 18 BC 19 BC 20 BC 21 BC 22 BC 23 BC 24 BC 25 BC 26 BC 27
2
5
BC 28 BC 29 BC 30 BC 31 BC 32 BC 33 BC 34 BC 35 BC 36 BC 37 BC 38 BC 39 BC 40
2
5

2
6

2
6

2
6

2
5

2
5

2
6

2
6

2
6

2
6

2
5

2
5

2
5

2
5

2
5

2
5

2
5

2
5

2
6

3
4

3
4

3
4

2
6

2
5

2
5

2
5

2
5

2
5

2
5

3

# Show heatmap
hmcols <- colorRampPalette(rev(c("#D73027", "#FC8D59", "#FEE090", "#FFFFBF",

"#E0F3F8", "#91BFDB", "#4575B4")))(100)

# Specify colors

par(mar = c(4, 5, 3, 5) + 0.1)
quheatmap(test, res, number = c(1, 3), col = hmcols, showlabel = TRUE)

Figure 1: Heatmap for two overlapped biclusters in the simulated matrix

Example of Saccharomyces cerevisiae

library(QUBIC)
data(BicatYeast)

# Discretization
matrix1 <- BicatYeast[1:7, 1:4]
matrix1

##
## 249364_at
## 253423_at
## 250327_at
## 247474_at
## 252661_at

cold_green_6h cold_green_24h cold_roots_6h cold_roots_24h
2.12442300
0.06860917
-0.15095752
-0.45295456
2.11200260

1.74476670
-0.37776557
0.33474782
0.04386528
2.05519100

-0.2759300
-0.9405282
1.6419950
0.6903505
1.7493315

-0.5108508
3.2669048
1.4484175
1.6705408
0.9260773

4

cond_51cond_52cond_54cond_55cond_56cond_57cond_58cond_59cond_60cond_12cond_13cond_14cond_15cond_16cond_18cond_19cond_20gene_20gene_19gene_18gene_17gene_15gene_14gene_13gene_12gene_11gene_60gene_59gene_58gene_57gene_56gene_55gene_54gene_53gene_52gene_51cond_51cond_52cond_54cond_55cond_56cond_57cond_58cond_59cond_60cond_12cond_13cond_14cond_15cond_16cond_18cond_19cond_20gene_20gene_19gene_18gene_17gene_15gene_14gene_13gene_12gene_11gene_60gene_59gene_58gene_57gene_56gene_55gene_54gene_53gene_52gene_51Bicluster  1 ( size  10 x 9 ) & Bicluster  3 ( size  9 x 8 )−4−2024## 258239_at
## 248910_at

0.6110116
1.4501406

-0.6083303
-0.3107802

0.60419910
0.16640233

0.43582130
0.37186486

matrix2 <- qudiscretize(matrix1)
matrix2

##
## 249364_at
## 253423_at
## 250327_at
## 247474_at
## 252661_at
## 258239_at
## 248910_at

cold_green_6h cold_green_24h cold_roots_6h cold_roots_24h
1
0
-1
-1
1
0
0

0
-1
1
0
0
1
1

-1
1
0
1
-1
-1
-1

0
0
0
0
0
0
0

# QUBIC
x <- BicatYeast
system.time(res <- biclust::biclust(x, method = BCQU()))

##
##

user
0.101

system elapsed
0.080

0.000

summary(res)

biclust::biclust(x = x, method = BCQU())

77

72
4

##
## An object of class Biclust
##
## call:
##
##
## Number of Clusters found:
##
## Cluster sizes:
##
## Number of Rows:
## Number of Columns:
##
## Number of Rows:
## Number of Columns:
##
## Number of Rows:
## Number of Columns:
##
## Number of Rows:
## Number of Columns:
##
## Number of Rows:
## Number of Columns:
##
## Number of Rows:
## Number of Columns:

41
4

13
6

12
6

24
2

41
3

40
3

41
4

53
5

53
3

32
5

39
4

45
4

47
4

56
4

98
2

37
7

80
3

38
4

35
5

74
2

29
6

29
5

34
5

47
3

42
4

BC 1 BC 2 BC 3 BC 4 BC 5 BC 6 BC 7 BC 8 BC 9 BC 10 BC 11 BC 12 BC 13 BC 14
33
5

26
7
BC 15 BC 16 BC 17 BC 18 BC 19 BC 20 BC 21 BC 22 BC 23 BC 24 BC 25 BC 26 BC 27
33
4
BC 28 BC 29 BC 30 BC 31 BC 32 BC 33 BC 34 BC 35 BC 36 BC 37 BC 38 BC 39 BC 40
41
2
BC 41 BC 42 BC 43 BC 44 BC 45 BC 46 BC 47 BC 48 BC 49 BC 50 BC 51 BC 52 BC 53
8
9
BC 54 BC 55 BC 56 BC 57 BC 58 BC 59 BC 60 BC 61 BC 62 BC 63 BC 64 BC 65 BC 66
17
3

18
3
BC 67 BC 68 BC 69 BC 70 BC 71 BC 72 BC 73 BC 74 BC 75 BC 76 BC 77
3
5

22
6

18
3

44
2

27
5

44
2

23
6

36
2

11
5

30
3

25
3

14
4

23
4

25
3

28
2

17
2

31
3

25
3

20
3

12
3

32
3

25
3

31
2

20
2

16
6

39
2

19
4

39
2

32
2

14
3

23
3

26
3

16
4

14
3

18
4

24
2

51
2

20
5

19
6

9
8

8
9

8
3

9
4

9
5

We can draw heatmap for single bicluster.

# Draw heatmap for the second bicluster identified in Saccharomyces cerevisiae data

5

library(RColorBrewer)
paleta <- colorRampPalette(rev(brewer.pal(11, "RdYlBu")))(11)
par(mar = c(5, 4, 3, 5) + 0.1, mgp = c(0, 1, 0), cex.lab = 1.1, cex.axis = 0.5,

cex.main = 1.1)

quheatmap(x, res, number = 2, showlabel = TRUE, col = paleta)

Figure 2: Heatmap for the second bicluster identified in the Saccharomyces cerevisiae data. The bicluster
consists of 53 genes and 5 conditions

We can draw heatmap for overlapped biclusters.

# Draw for the second and third biclusters identified in Saccharomyces cerevisiae data

par(mar = c(5, 5, 5, 5), cex.lab = 1.1, cex.axis = 0.5, cex.main = 1.1)
paleta <- colorRampPalette(rev(brewer.pal(11, "RdYlBu")))(11)
quheatmap(x, res, number = c(2, 3), showlabel = TRUE, col = paleta)

We can draw network for single bicluster.

# Construct the network for the second identified bicluster in Saccharomyces cerevisiae
net <- qunetwork(x, res, number = 2, group = 2, method = "spearman")
if (requireNamespace("qgraph", quietly = TRUE))

qgraph::qgraph(net[[1]], groups = net[[2]], layout = "spring", minimum = 0.6,
1), "gray"), edge.label = FALSE)

color = cbind(rainbow(length(net[[2]]) -

## Warning in qgraph::qgraph(net[[1]], groups = net[[2]], layout = "spring", : The following
## arguments are not documented and likely not arguments of qgraph and thus ignored: edge.label

We can also draw network for overlapped biclusters.

6

Bicluster  2  (size  53 x 5 )osmotic_green_24hosmotic_root_6hosmotic_root_24hsalt_root_24hABA_3h250485_at267024_s_at247477_at259813_at252183_at259842_at254833_s_at264147_at245748_at255795_at245463_at259616_at253638_at262128_at261428_at260097_at254767_s_at262148_at251899_at248581_at264019_at260410_at259516_at246481_s_at256114_at255265_at252415_at−4−20246Figure 3: Heatmap for the second and third biclusters identified in the Saccharomyces cerevisiae data.
Bicluster #2 (topleft) consists of 53 genes and 5 conditions, and bicluster #3 (bottom right) consists of 37
genes and 7 conditions.

7

osmotic_green_24hosmotic_root_6hosmotic_root_24hsalt_root_24hABA_3hcell_cycle_aph_6hcell_cycle_aph_8hcell_cycle_aph_10hcell_cycle_aph_12hcell_cycle_aph_14hcell_cycle_aph_16hcell_cycle_aph_19h258436_at260227_at256522_at267178_at248934_at264846_at261567_at248057_at258629_at252183_at254580_at255795_at251668_at261428_at254975_at248581_at252102_at256114_atosmotic_green_24hosmotic_root_6hosmotic_root_24hsalt_root_24hABA_3hcell_cycle_aph_6hcell_cycle_aph_8hcell_cycle_aph_10hcell_cycle_aph_12hcell_cycle_aph_14hcell_cycle_aph_16hcell_cycle_aph_19h258436_at267028_at261405_at246018_at257226_at267178_at251342_at258879_at260408_at252746_at261567_at258377_at252148_at267024_s_at266222_at252183_at249867_at264147_at245982_at245463_at251668_at262128_at252638_at254767_s_at260753_at248581_at256221_at259516_at248337_at255265_atBicluster  2 ( size  53 x 5 ) & Bicluster  3 ( size  37 x 7 )−6−4−20246Figure 4: Network for the second bicluster identified in the Saccharomyces cerevisiae data.

net <- qunetwork(x, res, number = c(2, 3), group = c(2, 3), method = "spearman")
if (requireNamespace("qgraph", quietly = TRUE))

qgraph::qgraph(net[[1]], groups = net[[2]], layout = "spring", minimum = 0.6,

legend.cex = 0.5, color = c("red", "blue", "gold", "gray"), edge.label = FALSE)

## Warning in qgraph::qgraph(net[[1]], groups = net[[2]], layout = "spring", : The following
## arguments are not documented and likely not arguments of qgraph and thus ignored: edge.label

# Output overlapping heatmap XML, could be used in other software such
# as Cytoscape, Biomax or JNets
sink('tempnetworkresult.gr')
qunet2xml(net, minimum = 0.6, color = cbind(rainbow(length(net[[2]]) - 1), "gray"))
sink()
# We can use Cytoscape, Biomax or JNets open file named 'tempnetworkresult.gr'

Example of Escherichia coli data

The Escherichia coli data consists of 4,297 genes and 466 conditions.

library(QUBIC)
library(QUBICdata)
data("ecoli", package = "QUBICdata")

# Discretization
matrix1 <- ecoli[1:7, 1:4]
matrix1

8

252425382552259925612483246265425952521026042562264026703248526325182607262142549254725052600252632612580262122477225362516259625332454247712557245924572651264125458254824925984252602521825455259812662247425862670226692504Bicluster2Bicluster2Figure 5: Network for the second and third biclusters identified in the Saccharomyces cerevisiae data.

##
## b4634
## b3241
## b3240
## b3243
## b3242
## b2836
## b0885

dinI_U_N0025 dinP_U_N0025 lexA_U_N0025 lon_U_N0025
9.114353
7.124200
7.188263
7.943650
6.889897
9.189480
9.002663

9.225537
7.195453
7.336610
7.963167
6.843213
9.133303
8.918723

9.077693
7.122300
7.184417
7.902090
6.801900
9.114207
9.057120

9.138900
7.051193
7.283377
7.847747
6.795007
9.167487
8.985483

matrix2 <- qudiscretize(matrix1)
matrix2

##
## b4634
## b3241
## b3240
## b3243
## b3242
## b2836
## b0885

dinI_U_N0025 dinP_U_N0025 lexA_U_N0025 lon_U_N0025
0
1
0
1
0
1
0
1
1
0
1
0
0
-1

0
-1
0
-1
-1
0
0

-1
0
-1
0
0
-1
1

# QUBIC
res <- biclust::biclust(ecoli, method = BCQU(), r = 1, q = 0.06, c = 0.95, o = 100,

f = 0.25, k = max(ncol(ecoli)%/%20, 2))

system.time(res <- biclust::biclust(ecoli, method = BCQU(), r = 1, q = 0.06, c = 0.95,

o = 100, f = 0.25, k = max(ncol(ecoli)%/%20, 2)))

##
##

user
20.460

system elapsed
12.829

0.081

9

2524253812552259925612483246426542595252102604125622640267032485263251826072621425492547250526002526326142258026212247722536325162596125332454247712557245924572651226412545825482498259842526025218254552598126622474258626702426692504825214248026029258324972538726152452226082527250462648260402536626422588248926192513257024992671246072643257224527256524601257925968261402602224722670282476265182584Bicluster2 & Bicluster3Bicluster2Bicluster3OthersBicluster2 & Bicluster3Bicluster2Bicluster3Otherssummary(res)

##
## An object of class Biclust
##
## call:
##
##
##
## Number of Clusters found:
##
## Cluster sizes:
##
## Number of Rows:
## Number of Columns:
##
## Number of Rows:
## Number of Columns:

14
26

20

biclust::biclust(x = ecoli, method = BCQU(), r = 1, q = 0.06, c = 0.95, o = 100,

f = 0.25, k = max(ncol(ecoli)%/%20, 2))

BC 1 BC 2 BC 3 BC 4 BC 5 BC 6 BC 7 BC 8 BC 9 BC 10 BC 11 BC 12 BC 13 BC 14
18
21

103
38

121
45

26
33

27
31

20
27

25
19

23
20

17
23

51
94

437
29

108
44
BC 15 BC 16 BC 17 BC 18 BC 19 BC 20
6
23

65
38

41
31

5
32

13
22

11
25

15
20

# Draw heatmap for the 5th bicluster identified in Escherichia coli data

library(RColorBrewer)
paleta <- colorRampPalette(rev(brewer.pal(11, "RdYlBu")))(11)
par(mar = c(5, 4, 3, 5) + 0.1, mgp = c(0, 1, 0), cex.lab = 1.1, cex.axis = 0.5,

cex.main = 1.1)

quheatmap(ecoli, res, number = 5, showlabel = TRUE, col = paleta)

library(RColorBrewer)
paleta <- colorRampPalette(rev(brewer.pal(11, "RdYlBu")))(11)
par(mar = c(5, 4, 3, 5), cex.lab = 1.1, cex.axis = 0.5, cex.main = 1.1)
quheatmap(ecoli, res, number = c(4, 8), showlabel = TRUE, col = paleta)

# construct the network for the 5th identified bicluster in Escherichia coli data
net <- qunetwork(ecoli, res, number = 5, group = 5, method = "spearman")
if (requireNamespace("qgraph", quietly = TRUE))

qgraph::qgraph(net[[1]], groups = net[[2]], layout = "spring", minimum = 0.6,
color = cbind(rainbow(length(net[[2]]) - 1), "gray"), edge.label = FALSE)

## Warning in qgraph::qgraph(net[[1]], groups = net[[2]], layout = "spring", : The following
## arguments are not documented and likely not arguments of qgraph and thus ignored: edge.label

# construct the network for the 4th and 8th identified bicluster in Escherichia coli data
net <- qunetwork(ecoli, res, number = c(4, 8), group = c(4, 8), method = "spearman")
if (requireNamespace("qgraph", quietly = TRUE))

qgraph::qgraph(net[[1]], groups = net[[2]], legend.cex = 0.5, layout = "spring",
minimum = 0.6, color = c("red", "blue", "gold", "gray"), edge.label = FALSE)

## Warning in qgraph::qgraph(net[[1]], groups = net[[2]], legend.cex = 0.5, : The following
## arguments are not documented and likely not arguments of qgraph and thus ignored: edge.label

Query-based biclustering

We can conduct a query-based biclustering by adding the weight parameter. In this example, the instance
file “511145.protein.links.v10.txt” (Szklarczyk et al. 2014) was downloaded from string (http://string-

10

Figure 6: Heatmap for the fifth bicluster identified in the Escherichia coli data. The bicluster consists of 103
genes and 38 conditions

db.org/download/protein.links.v10/511145.protein.links.v10.txt.gz) and decompressed and saved in working
directory.

# Here is an example to download and extract the weight
library(igraph)
url <- "http://string-db.org/download/protein.links.v10/511145.protein.links.v10.txt.gz"
tmp <- tempfile()
download.file(url, tmp)
graph = read.graph(gzfile(tmp), format = "ncol")
unlink(tmp)
ecoli.weight <- get.adjacency(graph, attr = "weight")

library(QUBIC)
library(QUBICdata)
data("ecoli", package = "QUBICdata")
data("ecoli.weight", package = "QUBICdata")
res0 <- biclust(ecoli, method = BCQU(), verbose = FALSE)
res0

##
## An object of class Biclust
##
## call:
##
##
## Number of Clusters found:
##

biclust(x = ecoli, method = BCQU(), verbose = FALSE)

100

11

Bicluster  5  (size  103 x 38 )b2618_U_N0075bcp_U_N0075cpxR_U_N0075crcB_U_N0075crp_U_N0075cspF_U_N0075dam_U_N0075dnaA_U_N0075dnaN_U_N0075dnaT_U_N0075era_U_N0075fis_U_N0075fklB_U_N0075folA_U_N0075galF_U_N0075gcvR_U_N0075gyrA_U_N0075gyrI_U_N0075hlpA_U_N0075holD_U_N0075hscA_U_N0075IHF_U_N0075ldrA_U_N0075mcrB_U_N0075mcrC_U_N0075menB_U_N0075minD_U_N0075minE_U_N0075murI_U_N0075nrdA_U_N0075nrdB_U_N0075nupC_U_N0075pyrC_U_N0075rimI_U_N0075rstB_U_N0075ruvC_U_N0075sbcB_U_N0075uspA_U_N0075b4046b1332b1148b4575b3547b3238b2840b1791b1624b1464b1341b0447b0232b4058b4618b2703b2702b3832b3652b2678b0060b1109b4043b3774b0758b4452b3924b1061b0231b0990b1270b0396b0061b1640b133768101214Figure 7: Heatmap for the fourth and eighth biclusters identified in the Escherichia coli data. Bicluster #4
(topleft) consists of 108 genes and 44 conditions, and bicluster #8 (bottom right) consists of 26 genes and 33
conditions

12

M9_K_appYM9_K_arcAfnrM9_K_oxyRM9_WTM9_K_arcA_anaerobicM9_K_fnr_anaerobicM9_K_soxS_anaerobicWT_MOPS_glucoseWT_MOPS_lateLogWT_MOPS_ciproMOPS_K_crpMOPS_K_dpscarbonSourceForagingast_pBADsup2fnr_K_fnrAerobiccybr_N_logstr_ctrl_M9str_ctrl_K_relA_0mstr_ctrl_U_relA_20m_K_rpoSrb_wt_exponentialbform_biofilm_colonyFp_MG1655_expccdB_K12_t30ccdB_K12_t90lacZ_K12_t60lacZ_MG1063_t30lacZ_MG1063_t90ccdB_MG1063_t60ccdB_W1872_t30ccdB_W1872_t90norfloxacin_MG1063_t30norfloxacin_MG1063_t120norfloxacin_BW25113_t60BW25113recA_uninduced_t30MG1655_t180_anaerobicMG1655_t270_anaerobicMG1655_t86400_cecumHU_hupA_LB_transb3573b4021b2730b2997b4154b2957b1729b1263b0003b3991b0907b4245b2312b3661b3829b3456b3454b0074b2026b3212b3894b2751b2762b0336b0778b0908b3359M9_K_appYM9_K_arcAfnrM9_K_oxyRM9_WTM9_K_arcA_anaerobicM9_K_fnr_anaerobicM9_K_soxS_anaerobicWT_MOPS_glucoseWT_MOPS_lateLogWT_MOPS_ciproMOPS_K_crpMOPS_K_dpscarbonSourceForagingast_pBADsup2fnr_K_fnrAerobiccybr_N_logstr_ctrl_M9str_ctrl_K_relA_0mstr_ctrl_U_relA_20m_K_rpoSrb_wt_exponentialbform_biofilm_colonyFp_MG1655_expccdB_K12_t30ccdB_K12_t90lacZ_K12_t60lacZ_MG1063_t30lacZ_MG1063_t90ccdB_MG1063_t60ccdB_W1872_t30ccdB_W1872_t90norfloxacin_MG1063_t30norfloxacin_MG1063_t120norfloxacin_BW25113_t60BW25113recA_uninduced_t30MG1655_t180_anaerobicMG1655_t270_anaerobicMG1655_t86400_cecumHU_hupA_LB_transb3573b2579b3479b2728b4122b4154b4123b2013b1287b1262b0003b3990b3994b4244b1849b2312b1602b0197b4013b3458b3454b0073b0078b0831b1761b3894b2425b2764b2750b0337b0778b0754b3172b3959Bicluster  4 ( size  108 x 44 ) & Bicluster  8 ( size  26 x 33 )246810121416Figure 8: Network for the fifth bicluster identified in the Escherichia coli data.

Figure 9: Network for the fourth and eighth biclusters identified in the Escherichia coli data.

13

b1337b1339b411b164b0062b0063b0061b2841b19b039b260b038b12b4131b4132b099b42b1343b0231b364b4044b10b4613b1334b39b3517b3516b445b0759b294b0758b2706b3511b37b1140b442b4043b1653b23b110b1335b139b0060b2972b2677b2678b2679b2699b365b261b2698b383b462b15b2702b2704b2705b2703b095b43b4618b118b1333b405b381b1141b0232b0233b0234b04b132b1340b1341b1342b136b146b147b149b162b1655b169b17b1847b1848b2840b2971b446b32b447b350b354b4130b416b45b1144b1147b1148b1149b1146b1332b141b31b4046Bicluster5Bicluster5b281b3959b3958b335b02b317b396b425b0908b0754b011b086b0775b0778b0032b0033b198b0337b0336b2313b2422b2750b2752b2762b2763b2764b241b2421b2751b2425b2424b2423b2209b3894b3893b192b444b176b3212b3213b0830b0831b2025b2026b37b0078b0077b3617b0074b0073b0072b0071b0075b3454b3455b3457b346b3458b3456b283b4024b401b30b382b394b019b0750b2574b366b160b0751b085b247b2312b05b255b249b18b4245b10b094b4244b291b0907b3616b3994b3993b3992b3991b3990b21b440b0002b0003b0004b1260b1261b1262b1263b1264b1265b128b168b172b2012b2013b352b365b295b4123b06b0894b0895b4154b4153b4152b4151b4122b299b2726b2727b2728b2729b273b2202b347b336b125b4021b2579b315b438b437b357Bicluster4 & Bicluster8Bicluster4Bicluster8OthersBicluster4 & Bicluster8Bicluster4Bicluster8OthersCluster sizes:

5

## First
##
## Number of Rows:
## Number of Columns:

BC 1 BC 2 BC 3 BC 4 BC 5
169
178
53
52

180
50

437
29

519
22

res4 <- biclust(ecoli, method = BCQU(), weight = ecoli.weight, verbose = FALSE)
res4

biclust(x = ecoli, method = BCQU(), weight = ecoli.weight, verbose = FALSE)

##
## An object of class Biclust
##
## call:
##
##
## Number of Clusters found:
##
## First
##
## Number of Rows:
## Number of Columns:

Cluster sizes:

437
29

5

100

BC 1 BC 2 BC 3 BC 4 BC 5
169
178
53
52

180
50

519
22

Bicluster-expanding

we can expand existing biclustering results to recruite more genes according to certain consistency level:

res5 <- biclust(x = ecoli, method = BCQU(), seedbicluster = res, f = 0.25, verbose = FALSE)
summary(res5)

biclust(x = ecoli, method = BCQU(), seedbicluster = res, f = 0.25, verbose = FALSE)

##
## An object of class Biclust
##
## call:
##
##
## Number of Clusters found:
##
## Cluster sizes:
##
## Number of Rows:
## Number of Columns:
##
## Number of Rows:
## Number of Columns:

14
26

20

BC 1 BC 2 BC 3 BC 4 BC 5 BC 6 BC 7 BC 8 BC 9 BC 10 BC 11 BC 12 BC 13 BC 14
19
21

117
38

593
29

151
45

30
20

36
19

43
31

20
27

17
23

27
33

51
94

110
44
BC 15 BC 16 BC 17 BC 18 BC 19 BC 20
6
23

84
31

68
38

16
20

16
22

5
32

11
25

Biclusters comparison

We can compare the biclustering results obtained from different algorithms, or from a same algorithm with
different combinations of parameter.

test <- ecoli[1:50,]
res6 <- biclust(test, method = BCQU(), verbose = FALSE)
res7 <- biclust (test, method = BCCC())
res8 <- biclust(test, method = BCBimax())
showinfo (test, c(res6, res7, res8))

14

## 1: Call and Parameter
## 2: number of detected biclusters
## 3: nrow of the first bicluster
## 4: ncol of the first bicluster
## 5: area of the first bicluster
## 6: ratio (nrow / ncol) of the first bicluster
## 7: ratio (nrow / ncol) of the matrix
## 8: max nrow and corresponding bicluster
## 9: max ncol and corresponding bicluster
## 10: max area and corresponding bicluster
## 11: union of rows, (# and %)
## 12: union of columns, (# and %)
## 13: overlap of first two biclusters (row, col, area)
##
##
## 1
13
## biclust(x = test, method = BCQU(), verbose = FALSE)

10

11

12

5

4

3

2

6

7

8

9

59

11

25

275 0.44

0.1072961

11 1

42 12

275 1

49 98

## biclust(x = test, method = BCCC())

23300 1 50 100

1 100

## biclust(x = test, method = BCBimax())
23300 1 50 100

466 100

466 1

283 60.72961
1

1 0 0

50

466 23300

0.1072961

0.1072961

50 1

466 1

1

50

466 23300

0.1072961

0.1072961

50 1

References

Brazma, Alvis, and Jaak Vilo. 2000. “Gene Expression Data Analysis.” FEBS Letters 480 (1): 17–24.

Cheng, Yizong, and George M Church. 2000. “Biclustering of Expression Data.” In Proceedings of the Eighth
International Conference on Intelligent Systems for Molecular Biology, edited by Philip Bourne, Michael
Gribskov, Russ Altman, Nancy Jensen, Debra Hope, Thomas Lengauer, Julie Mitchell, et al., 8:93–103. AAAI
Press, Menlo Park, CA.

Eren, Kemal, Mehmet Deveci, Onur Küçüktunç, and Ümit V. Çatalyürek. 2012. “A Comparative Analysis of
Biclustering Algorithms for Gene Expression Data.” Briefings in Bioinformatics. https://doi.org/10.1093/bi
b/bbs032.

Fehrmann, Rudolf SN, Juha M Karjalainen, Małgorzata Krajewska, Harm-Jan Westra, David Maloney, Anton
Simeonov, Tune H Pers, et al. 2015. “Gene Expression Analysis Identifies Global Gene Dosage Sensitivity in
Cancer.” Nature Genetics 47 (2): 115–25.

Gu, Jiajun, and Jun S Liu. 2008. “Bayesian Biclustering of Gene Expression Data.” BMC Genomics 9 (Suppl
1): S4.

Lazzeroni, Laura, Art Owen, and others. 2002. “Plaid Models for Gene Expression Data.” Statistica Sinica
12 (1): 61–86.

Li, Guojun, Qin Ma, Haibao Tang, Andrew H Paterson, and Ying Xu. 2009. “QUBIC: A Qualitative
Biclustering Algorithm for Analyses of Gene Expression Data.” Nucleic Acids Research 37 (15): e101.

Szklarczyk, Damian, Andrea Franceschini, Stefan Wyder, Kristoffer Forslund, Davide Heller, Jaime Huerta-
Cepas, Milan Simonovic, et al. 2014. “STRING V10: Protein–Protein Interaction Networks, Integrated over
the Tree of Life.” Nucleic Acids Research 43: D447–D452. https://doi.org/10.1093/nar/gku1003.

Zhang, Yu, Juan Xie, Jinyu Yang, Anne Fennell, Chi Zhang, and Qin Ma. 2017. “QUBIC: A Bioconductor
Package for Qualitative Biclustering Analysis of Gene Co- Expression Data.” Bioinformatics 33 (3): 450–52.
https://doi.org/10.1093/bioinformatics/btw635.

15

Zhou, Fengfeng, Qin Ma, Guojun Li, and Ying Xu. 2012. “QServer: A Biclustering Server for Prediction and
Assessment of Co-Expressed Gene Clusters.” PLoS ONE 7 (3): e32660. https://doi.org/10.1371/journal.pone
.0032660.

16

