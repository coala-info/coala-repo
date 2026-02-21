Multiple Co-inertia Analysis of Multiple OMICS
Data using omicade4

Chen Meng and Amin Moghaddas Gholami

October 30, 2025

Contents

1

2

Introduction .

Quick Start

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

1

2

2

3

Data Overview .

2.1

2.2

Data Exploration with Multiple Co-inertia Analysis .

1

Introduction

Modern "omics" technologies enable quantitative monitoring of the abundance of
various biological molecules in a high-throughput manner, accumulating an unprece-
dented amount of quantitative information on a genomic scale. Systematic integra-
tion and comparison of multiple layers of information is required to provide deeper
insights into biological systems.

Multivariate approaches have been applied successfully in the analysis of high through-
put "omics" data. Principal component analysis (PCA) has been shown to be useful
in exploratory analysis of linear trends in biological data [1]. Culhane and colleagues
employed a two table coupling method (co-inertia analysis, CIA) to examine covariant
gene expression patterns between microarray datasets from two different platforms
[2]. Although PCA is available in several R packages, the ade4 and made4 contain
many additional multivariate statistical methods including methods for analysis of one
data table, coupling of two data tables or multi-table analysis [3, 4]. These methods
for integrating multiple datasets make these particular packages very attractive for
analysis of multi-omics data. omicade4 is developed as an extension to ade4 and
made4 to facilitate input and analysis of more than two omics datasets.

omicade4 provides functions for multiple co-inertia analysis and for graphical rep-
resentation, so that the general similarity of different datasets could be easily inter-
preted. The method could be applied when several set of variables (genes, transcripts,
proteins) are measured on the same set of individuals (cell lines, patients). This vi-
gnette provides a case study on a toy NCI-60 dataset to show the usage of this

Multiple Co-inertia Analysis of Multiple OMICS Data using omicade4

package.
In addition, the package provides methods for S3 class cia, which encap-
sulates results from the co-inertia analysis by cia function from made4 . Therefore,
functions from made4 and ade4 are also called in this vignette. For more information
please refer to [5] and several recent reviews.

2

Quick Start

The package includes example data from four different microarray platforms (i.e.,
Agilent, Affymetrix HGU 95, Affymetrix HGU 133 and Affymetrix HGU 133plus 2.0)
on the NCI-60 cell lines. The package and datasets are loaded by the commands:

> library(omicade4)
> data(NCI60_4arrays)

NCI60_4arrays is a list containing the NCI-60 microarray data with only few hundreds
of genes randomly selected in each platform to keep the size of the Bioconductor
package small. However, the full datasets are available in [6].

2.1

Data Overview

MCIA links the individuals (samples in column) in different datasets and thus the
columns will be linked between the multiple datasets. Thus we have to ensure that
the order of samples (the columns) in all datasets is the same before performing
MCIA. The number of variables (genes) does not need to be the same. We can
check the dimension of each dataset in the list by

> sapply(NCI60_4arrays, dim)

agilent hgu133 hgu133p2 hgu95

[1,]

[2,]

300

60

298

60

268

60

288

60

And check whether samples are ordered correctly

> all(apply((x <- sapply(NCI60_4arrays, colnames))[,-1], 2, function(y)
+ identical(y, x[,1])))

[1] TRUE

Before performing the MCIA, we can use hierarchical clustering to have a general
idea about similarity of cell lines, which can be done with the following command.
We will compare the clustering result with MCIA.

> layout(matrix(1:4, 1, 4))

> par(mar=c(2, 1, 0.1, 6))
> for (df in NCI60_4arrays) {
+

d <- dist(t(df))

2

Multiple Co-inertia Analysis of Multiple OMICS Data using omicade4

hcl <- hclust(d)

dend <- as.dendrogram(hcl)

plot(dend, horiz=TRUE)

+

+

+

+ }

Figure 1: The hierarchical clustering of NCI-60 cell lines

2.2

Data Exploration with Multiple Co-inertia Analysis

The main function mcia can be used to perform multiple co-inertia analysis:

> mcoin <- mcia(NCI60_4arrays, cia.nf=10)
> class(mcoin)

[1] "mcia"

It returns an object of class mcia. There are several methods that could be applied
on this class. To visualize the result, one can use plot directly. However, because
there are nine cancer types, we want to distinguish the cell lines by their original
cancer type. This can be done by defining a phenotype factor in plot. The following
commands create a vector to indicate the cell line groups.

> cancer_type <- colnames(NCI60_4arrays$agilent)
> cancer_type <- sapply(strsplit(cancer_type, split="\\."), function(x) x[1])
> cancer_type

[1] "BR" "BR"

"BR"

"BR"

"BR"

"CNS" "CNS" "CNS" "CNS" "CNS" "CNS" "CO"

[13] "CO" "CO"

"CO"

"CO"

"CO"

"CO"

"LE"

"LE"

"LE"

"LE"

"LE"

"LE"

[25] "ME" "ME"

"ME"

"ME"

"ME"

"ME"

"ME"

"ME"

"ME"

"ME"

"LC"

"LC"

[37] "LC" "LC"

"LC"

"LC"

"LC"

"LC"

"LC"

"OV"

"OV"

"OV"

"OV"

"OV"

3

50200ME.SK_MEL_5ME.UACC_257ME.M14ME.MDA_MB_435ME.MDA_NME.SK_MEL_28ME.UACC_62ME.MALME_3MME.SK_MEL_2ME.LOXIMVILC.HOP_92PR.PC_3RE.TK_10RE.ACHNRE.CAKI_1RE.UO_31RE.RXF_393RE.786_0RE.A498OV.SK_OV_3BR.MDA_MB_231RE.SN12CLC.HOP_62LC.NCI_H226BR.BT_549CNS.SNB_75CNS.SF_268BR.HS578TCNS.SF_539CNS.SF_295CNS.SNB_19CNS.U251LC.NCI_H522BR.MCF7BR.T47DLC.NCI_H322MLC.NCI_H23LC.NCI_H460LC.A549LC.EKVXOV.OVCAR_3OV.OVCAR_4OV.IGROV1PR.DU_145OV.OVCAR_8OV.NCI_ADR_RESCO.SW_620OV.OVCAR_5CO.COLO205CO.KM12CO.HCT_15CO.HT29CO.HCC_2998CO.HCT_116LE.K_562LE.RPMI_8226LE.SRLE.HL_60LE.CCRF_CEMLE.MOLT_450200LE.SRLE.K_562LE.RPMI_8226LE.HL_60LE.CCRF_CEMLE.MOLT_4PR.PC_3CO.COLO205CO.SW_620CO.HCT_116CO.KM12CO.HT29CO.HCC_2998CO.HCT_15LC.NCI_H322MOV.OVCAR_5OV.OVCAR_3OV.OVCAR_4OV.IGROV1OV.SK_OV_3LC.NCI_H522BR.MCF7BR.T47DME.MALME_3MME.UACC_257ME.M14ME.SK_MEL_28ME.SK_MEL_5ME.UACC_62ME.SK_MEL_2ME.MDA_MB_435ME.MDA_NCNS.SF_295CNS.SNB_19CNS.U251CNS.SF_539CNS.SNB_75BR.HS578TBR.BT_549CNS.SF_268RE.A498RE.786_0RE.RXF_393RE.CAKI_1RE.TK_10RE.ACHNRE.UO_31ME.LOXIMVIBR.MDA_MB_231LC.HOP_92LC.EKVXLC.NCI_H460LC.A549LC.NCI_H23LC.HOP_62LC.NCI_H226RE.SN12CPR.DU_145OV.OVCAR_8OV.NCI_ADR_RES50200LE.HL_60LE.CCRF_CEMLE.MOLT_4LE.K_562LE.RPMI_8226LE.SRCO.HCT_15CO.HCC_2998CO.KM12CO.COLO205CO.HT29BR.MCF7BR.T47DPR.PC_3CO.HCT_116CO.SW_620LC.A549LC.EKVXLC.NCI_H23LC.NCI_H460LC.NCI_H322MPR.DU_145OV.IGROV1OV.OVCAR_3OV.OVCAR_4OV.SK_OV_3OV.OVCAR_8OV.NCI_ADR_RESBR.MDA_MB_231OV.OVCAR_5ME.MDA_MB_435ME.M14ME.MDA_NME.SK_MEL_2ME.SK_MEL_5ME.UACC_62ME.MALME_3MME.SK_MEL_28ME.UACC_257ME.LOXIMVILC.NCI_H522RE.CAKI_1RE.ACHNRE.UO_31RE.A498RE.TK_10RE.786_0RE.RXF_393RE.SN12CLC.HOP_62LC.NCI_H226CNS.SNB_19CNS.U251CNS.SF_295LC.HOP_92BR.BT_549CNS.SF_268BR.HS578TCNS.SF_539CNS.SNB_7540200ME.SK_MEL_5ME.SK_MEL_28ME.UACC_257ME.UACC_62ME.SK_MEL_2ME.MDA_MB_435ME.MDA_NME.MALME_3MME.M14CNS.SNB_19CNS.U251CNS.SNB_75CNS.SF_295CNS.SF_268BR.HS578TCNS.SF_539BR.BT_549LC.NCI_H23LC.NCI_H522ME.LOXIMVIPR.PC_3LC.NCI_H460LC.EKVXRE.SN12COV.IGROV1OV.OVCAR_3OV.OVCAR_4LC.NCI_H322MBR.MCF7BR.T47DOV.SK_OV_3RE.TK_10RE.RXF_393RE.786_0RE.A498RE.CAKI_1RE.ACHNRE.UO_31LC.NCI_H226BR.MDA_MB_231LC.HOP_62LC.HOP_92OV.OVCAR_8OV.NCI_ADR_RESOV.OVCAR_5LC.A549PR.DU_145CO.HCT_116CO.HT29CO.KM12CO.HCC_2998CO.HCT_15CO.COLO205CO.SW_620LE.HL_60LE.CCRF_CEMLE.MOLT_4LE.K_562LE.RPMI_8226LE.SRMultiple Co-inertia Analysis of Multiple OMICS Data using omicade4

[49] "OV"

"OV"

"PR"

"PR"

"RE"

"RE"

"RE"

"RE"

"RE"

"RE"

"RE"

"RE"

Next, we plot the result for the first two principal components

> plot(mcoin, axes=1:2, phenovec=cancer_type, sample.lab=FALSE, df.color=1:4)

Figure 2: The MCIA plot of NCI-60 data

This command produces a 4-panel figure as shown in figure 2. The top left panel
is the sample space, where each cell line is projected. Shapes represent samples
in different platforms. Same cell lines are linked by edges. The shorter the edge,
the better the correlation of samples in different platforms.
In our sample plot, a
relatively high correlation of all microarray datasets is depicted by the short edges.
Furthermore, in most cancer types except lung cancer and breast cancer, cell lines
having the same origin are closely projected, which indicates high homogeneity of
these cancer types. This agrees with the hierarchical clustering (figure 1).

The next interesting question is which genes are responsible for defining the coordi-
nates of samples. The top right panel is the variable (gene) space, e.g., genes from
different platforms, which are distinguished by colors and shapes, are projected on
this space.
In this panel, a gene that is particularly highly expressed in a certain
cell line will be located on the direction of this cell line. The farther away towards
the outer margin, the stronger the association is. Equally, genes projected on the
opposite direction from the origin indicate that they are lost or down regulated in
those cell lines. From this sense, since the melanoma cell lines are highly weighted on
the positive side of the horizontal axis in the first panel, the corresponding melanoma
highly expressed genes are on the same direction. The following command could be
used to select melanoma associated genes according to the coordinate of genes in
that space

4

 d = 1  sample space agilenthgu133hgu133p2hgu95BRCNSCOLCLEMEOVPRRE d = 1  variable space  variable space 147101418Eigen Value0.00.20.40.6Eigen Vector0.050.100.150.200.25Percentageagilenthgu133hgu133p2hgu950.150.170.190.210.150.160.170.180.19pseudoeig 1pseudoeig 2Multiple Co-inertia Analysis of Multiple OMICS Data using omicade4

> melan_gene <- selectVar(mcoin, a1.lim=c(2, Inf), a2.lim=c(-Inf, Inf))
> melan_gene

var agilent hgu133 hgu133p2 hgu95 stat

1 ST8SIA1

TRUE

FALSE

FALSE FALSE

2

S100A1

TRUE

TRUE

FALSE

TRUE

3 C10orf90

TRUE

FALSE

FALSE FALSE

4

5

S100B

GPNMB

TRUE

FALSE

TRUE

TRUE

FALSE FALSE

FALSE FALSE

6 C6orf218

FALSE

FALSE

TRUE FALSE

7

8

9

ACP5

PLP1

FALSE

FALSE

FALSE

TRUE

FALSE

FALSE

FALSE

TRUE

SOX10

FALSE

FALSE

FALSE

TRUE

1

3

1

2

1

1

1

1

1

The first column represents gene names, the subsequent columns indicate which
genes are identified in which platforms, and the last column is a statistic of the total
number of platforms identifying the corresponding gene in the selected region.

The bottom left panel in figure 2 shows the eigenvalue for each eigenvector. The
barplot represents the absolute eigenvalues. The dots linked by lines indicate the
proportion of variance for the eigenvectors. Cyan bars indicate the eigenvectors kept
in the analysis. In this case, we kept 10 eigenvectors, and the top three axes have a
relative large eigenvalue according to the scree plot. Therefore, not only the top two
axes, but also the third one could lead to some interesting findings. Different axes
could be explored by changing the axes argument in plot, such as:

> plot(mcoin, axes=c(1, 3), phenovec=cancer_type, sample.lab=FALSE, df.color=1:4)
> plot(mcoin, axes=c(2, 3), phenovec=cancer_type, sample.lab=FALSE, df.color=1:4)

Finally, the bottom right panel in figure 2 shows the pseudo-eigenvalues space of all
datasets, which indicates how much variance of an eigenvalue is contributed by each
dataset. In this example, the HGU 95 is highly weighted on the first axis. Therefore,
this dataset contributes the most variance on this axis among four datasets. However,
the HGU 133 plus 2.0 data highly contribute to the second axis. Note that we selected
some melanoma related genes by limiting the first axis using selectVar function,
where we identified four genes in Agilent and HGU 95 platforms comparing to only
one gene in the HGU 133 plus 2.0 platform, which is in agreement with the result
suggested by this plot.

In addition, the function plotVar could be used to visualize the gene space, given a
list of genes of interest. Let’s get back to the melanoma genes again, we know that
S100B and S100A1 are detected in more than one dataset. Now, we want to know
where these genes are projected on the gene space. This could be visualized by

5

Multiple Co-inertia Analysis of Multiple OMICS Data using omicade4

> geneStat <- plotVar(mcoin, var=c("S100B", "S100A1"), var.lab=TRUE)

Figure 3: visualization of genes of interest in CIA

The output plot is shown in figure 3.

References

[1] Raychaudhuri S, Stuart JM, and Altman RB. Principal components analysis to
summarize microarray experiments: application to sporulation time series.
Pacific Symposium on Biocomputing, pages 455–466, 2000.

[2] Culhane AC, Perriere G, and Higgins DG. Cross-platform comparison and
visualisation of gene expression data using co-inertia analysis. BMC
Bioinformatics, 21(4):59, 2003.

[3] Dray S and Dufour AB. The ade4 package: implementing the duality diagram

for ecologists. Journal of Statistical Software, 22(4):1–20, 2007.

[4] Dray S, Dufour AB, and Chessel D. The ade4 package-ii: Two-table and k-table

methods. R News, 7(2):47–52, 2007.

[5] Meng C, Kuster B, Culhane A, and Gholami AM. A multivariate approach to
the integration of multi-omics datasets. BMC Bioinformatics, 15, 2014.

[6] Reinhold WC, Sunshine M, Liu H, Varma S, Kohn KW, Morris J, Doroshow J,
and Pommier Y. Cellminer: A web-based suite of genomic and pharmacologic
tools to explore transcript and drug patterns in the nci-60 cell line set. Cancer
Research, 72(14):3499–511, 2012.

6

 d = 1 S100A1S100Bagilent d = 1 S100BS100A1hgu133 d = 1 hgu133p2 d = 1 S100A1hgu95