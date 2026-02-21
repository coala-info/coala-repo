Creating heatmaps using package Heatplus

Alexander Ploner
Medical Epidemiology & Biostatistics
Karolinska Institutet, Stockholm
email: alexander.ploner@ki.se

October 30, 2025

Abstract

The package Heatplus offers several functions for producing heatmaps,

specifically annotated heatmaps that display extra information about
samples and/or features (variables) in panels beside the main plot and
the dendrograms. This documents demonstrates some basic applica-
tions to gene expression data.

1

Contents

1 Setup

2 Regular heatmaps

3 Annotated heatmaps

4 Double-annotated heatmaps

5 Roadmap

3

3

8

8

12

2

1 Setup

We use the example data from Biobase for demonstration:

> require(Biobase)
> data(sample.ExpressionSet)
> exdat = sample.ExpressionSet

We also generate a shortlist of genes that are associated with the phenotype
type:

> require(limma)
> design1 = model.matrix( ~ type, data=pData(exdat))
> lm1 = lmFit(exprs(exdat), design1)
> lm1 = eBayes(lm1)
> geneID = rownames(topTable(lm1, coef=2, num=100, adjust="none",
+
> length(geneID)

p.value=0.05))

[1] 46

(Of course, this is only for the example’s sake, as it does not account for
multiple testing.)

> exdat2 = exdat[geneID,]

2 Regular heatmaps

The function regHeatmap generates heatmaps without annotation. Apart
from some display defaults, this is very similar to standard heatmap, but
allows you to add a simple legend.

Figure 1 shows the full example data with the default settings. Figure 2
shows the gene expression for the short list, with the legend moved to the
right, for simpler breaks of the intensity scale and a different palette. Figure
3 shows how different distance- and clustering functions can be passed in.
Figure 4 shows how the lists of arguments can be used to specify different
settings for row- and column dendrograms.

3

> require(Heatplus)
> reg1 = regHeatmap(exprs(exdat))
> plot(reg1)

Figure 1: Heatmap with row- and column dendrograms and a legend for 500
genes and 26 samples.

4

31557_at31722_at31545_at31396_r_at31627_f_at31508_at31382_f_at31371_at31344_at31526_f_at31525_s_at31589_at31458_at31321_at31466_at31490_at31356_at31471_at31487_at31702_at31332_at31462_f_at31376_at31718_at31316_at31563_at31674_s_at31460_f_at31389_at31418_at31542_at31629_at31479_f_at31540_at31404_at31340_at31735_atAFFX−DapX−3_at31361_at31675_s_atAFFX−PheX−M_at31733_atAFFX−BioB−5_at31588_atAFFX−HUMRGE/M10098_3_atAFFX−LysX−M_at31560_atAFFX−HUMGAPDH/M33197_3_stAFFX−CreX−3_at31354_r_at31658_at31438_s_at31598_s_at31402_at31379_at31552_at31397_at31698_at31381_at31314_at31408_atAFFX−HUMISGF3A/M97935_3_at31667_r_at31620_atAFFX−HUMISGF3A/M97935_MA_at31709_at31685_at31362_at31590_g_at31357_at31535_i_at31727_atRCVGJUOZSMDTXQNHLIKAFWYBEP−4−2024> reg2 = regHeatmap(exprs(exdat2), legend=2, col=heat.colors, breaks=-3:3)
> plot(reg2)

Figure 2: Heatmap with row- and column dendrograms and a legend for 46
genes and 26 samples. Legend placement, color scheme and intervals have
been changed compared to the default

5

AFFX−hum_alu_at31328_at31648_at31531_g_at31552_at31631_f_at31351_at31606_atAFFX−YEL018w/_at31713_s_atAFFX−MurIL4_at31580_at31345_at31447_at31683_at31654_atAFFX−PheX−M_at31632_atAFFX−TrpnX−M_at31461_at31733_at31492_at31566_at31341_at31724_at31535_i_at31386_at31669_s_at31356_at31721_at31419_r_at31623_f_at31440_at31428_at31396_r_at31509_at31708_at31546_at31573_at31722_at31527_at31545_at31330_at31511_at31583_at31568_atRVGUOMYWJAFCZHQSKNTIBLDXEP−3−2−10123> corrdist = function(x) as.dist(1-cor(t(x)))
> hclust.avl = function(x) hclust(x, method="average")
> reg3 = regHeatmap(exprs(exdat2), legend=2, dendrogram =
+
> plot(reg3)

list(clustfun=hclust.avl, distfun=corrdist))

Figure 3: Heatmap with row- and column dendrograms and a legend for
46 genes and 26 samples. Distance measure (correlation distance instead of
Euclidean) and clustering method (average instead of complete linkage) for
the dendrogram are changed compared to the default.

6

31351_at31606_at31447_at31531_g_at31724_at31632_at31683_at31654_atAFFX−MurIL4_at31356_at31328_at31535_i_at31721_at31440_at31386_at31713_s_atAFFX−YEL018w/_at31669_s_atAFFX−TrpnX−M_at31580_at31345_atAFFX−PheX−M_at31461_at31733_at31648_at31428_at31566_at31552_at31419_r_at31396_r_atAFFX−hum_alu_at31341_at31631_f_at31623_f_at31722_at31492_at31509_at31573_at31511_at31546_at31583_at31330_at31527_at31708_at31568_at31545_atZRVGUOJAFCHQNLTIKMDSEXBPYW−3−2−10123> reg4 = regHeatmap(exprs(exdat2), legend=3,
+
> plot(reg4)

dendrogram=list(Col=list(status="hide")))

Figure 4: Heatmap with a row dendrogram and a legend, for 46 genes and
26 samples. The column dendrogram is not shown, though the samples are
still arranged as in Figure 2, i.e.
sorted according to the hidden column
dendrogram.

7

AFFX−hum_alu_at31328_at31648_at31531_g_at31552_at31631_f_at31351_at31606_atAFFX−YEL018w/_at31713_s_atAFFX−MurIL4_at31580_at31345_at31447_at31683_at31654_atAFFX−PheX−M_at31632_atAFFX−TrpnX−M_at31461_at31733_at31492_at31566_at31341_at31724_at31535_i_at31386_at31669_s_at31356_at31721_at31419_r_at31623_f_at31440_at31428_at31396_r_at31509_at31708_at31546_at31573_at31722_at31527_at31545_at31330_at31511_at31583_at31568_atRVGUOMYWJAFCZHQSKNTIBLDXEP−3−2−101233 Annotated heatmaps

Figure 5 shows the default annotated heatmap for the full data set. Fig-
ure 6 shows the default annotated heatmap for the smaller data set, with the
column dendrogram cut at distance 5000.

Figure 7 shows a similar plot as Figure 6, but cut at a distance of 7500
(resulting in two instead of three clusters) and with costumised cluster labels.

4 Double-annotated heatmaps

We can also add annotation information about the features. These can be of
all kinds: quality information, relationship with sample annotation, or mem-
bership in different pathways. Let’s start with the median of the standard
errors as a quality control measure:

> SE = apply(get("se.exprs", assayData(exdat2)), 1, median)

Then we look at the correlation of the features with the variable score in
the phenotype data, plus t-statistic and p-value:

> CO = cor(t(exprs(exdat2)), pData(exdat2)$score)
> df = nrow(exdat2)-2
> TT = sqrt(df) * CO/sqrt(1-CO^2)
> PV = 2*pt(-abs(TT), df=df)

Finally, we want to see which of the features are associated with the Ge-
neOntology category translational elongation:

> require(hgu95av2.db)
> allGO = as.list(mget(featureNames(exdat2), hgu95av2GO))
> isTransElong = sapply(allGO, function(x) "GO:0006414" %in% names(x))

Let’s put this into an annotation data frame:

> annFeatures = data.frame(standard.errors=SE, sigCorScore=PV<0.05,
+ isTransElong)

8

> ann1 = annHeatmap(exprs(exdat), ann=pData(exdat))
> plot(ann1)

Figure 5: Annotated heatmap with column dendrogram and a legend, for
500 genes and 26 samples.

9

31557_atAFFX−HUMGAPDH/M33197_M_at31511_at31509_at31719_at31679_at31541_at31344_at31684_at31671_at31550_atAFFX−CreX−5_stAFFX−BioB−3_at31626_i_at31356_at31443_at31512_at31706_at31539_r_at31343_at31630_at31316_at31401_r_at31323_r_at31653_at31612_at31435_at31676_at31479_f_at31549_atAFFX−BioB−M_st31578_at31307_at31501_at31731_atAFFX−PheX−M_at31461_at31392_r_at31483_g_atAFFX−BioC−3_at31644_at31654_atAFFX−CreX−3_at31325_at31565_at31472_s_at31515_at31602_at31531_g_at31397_at31711_at31533_s_at31556_at31693_f_at31468_f_at31710_atAFFX−HUMISGF3A/M97935_MA_at31353_f_at31341_at31634_at31436_s_at31691_g_at31724_atRCVGJUOZSMDTXQNHLIKAFWYBEPsex=Femalesex=Maletype=Casetype=Control00.20.40.60.81score−4−2024> ann2 = annHeatmap(exprs(exdat2), ann=pData(exdat2),
+
> plot(ann2)

cluster=list(cuth=5000))

Figure 6: Annotated heatmap with column dendrogram and a legend, for 46
genes and 26 samples. The column dendrogram is cut at h = 5000

10

AFFX−hum_alu_at31328_at31648_at31531_g_at31552_at31631_f_at31351_at31606_atAFFX−YEL018w/_at31713_s_atAFFX−MurIL4_at31580_at31345_at31447_at31683_at31654_atAFFX−PheX−M_at31632_atAFFX−TrpnX−M_at31461_at31733_at31492_at31566_at31341_at31724_at31535_i_at31386_at31669_s_at31356_at31721_at31419_r_at31623_f_at31440_at31428_at31396_r_at31509_at31708_at31546_at31573_at31722_at31527_at31545_at31330_at31511_at31583_at31568_atRVGUOMYWJAFCZHQSKNTIBLDXEPsex=Femalesex=Maletype=Casetype=Control00.20.40.60.81score−3−2−10123> ann3 = annHeatmap(exprs(exdat2), ann=pData(exdat2),
+
> plot(ann3)

cluster=list(cuth=7500, label=c("Control-like", "Case-like")))

Figure 7: Annotated heatmap with column dendrogram and a legend, for 46
genes and 26 samples. The column dendrogram is cut at h = 7500, and we
add cluster names, based on the annotation.

11

AFFX−hum_alu_at31328_at31648_at31531_g_at31552_at31631_f_at31351_at31606_atAFFX−YEL018w/_at31713_s_atAFFX−MurIL4_at31580_at31345_at31447_at31683_at31654_atAFFX−PheX−M_at31632_atAFFX−TrpnX−M_at31461_at31733_at31492_at31566_at31341_at31724_at31535_i_at31386_at31669_s_at31356_at31721_at31419_r_at31623_f_at31440_at31428_at31396_r_at31509_at31708_at31546_at31573_at31722_at31527_at31545_at31330_at31511_at31583_at31568_atRVGUOMYWJAFCZHQSKNTIBLDXEPsex=Femalesex=Maletype=Casetype=Control00.20.40.60.81scoreControl−likeCase−like−3−2−10123Figure 8 shows the smaller data set with default settings. Figure 9 changes
the space alloted for the feature- and sample labels. Figure 10 addition-
ally slims the annotation data frames by excluding the reference levels for
the factor variables; it also shows how the plot method allows changing the
proportions of the heatmap in display. Figure 11 shows how to construct
an annotation data frame beforehand using convAnnData and passing it in
unchanged using the asIs switch in the annotation argument.

5 Roadmap

The following improvements are planned for the next release:

• Improved precision for coloring the cutting height in dendrograms

• Specification of common clustering algorithms and distance measures
via character codes (instead of costum wrapper functions for hclust
and dist)

The medium term goal is of course to add more specific methods for common
Bioconductor classes and relevant objects, as well as providing convenience
functions for including biological annotation data more easily, but there is
no detailed road map for this yet.

12

> ann4 = annHeatmap2(exprs(exdat2),
+
> plot(ann4)

ann=list(Col=list(data=pData(exdat2)), Row=list(data=annFeatures)))

Figure 8: Double annotated heatmap with row- and column dendrograms
and annotation, plus a legend, for 46 genes and 26 samples.

13

AFFX−hum_alu_at31328_at31648_at31531_g_at31552_at31631_f_at31351_at31606_atAFFX−YEL018w/_at31713_s_atAFFX−MurIL4_at31580_at31345_at31447_at31683_at31654_atAFFX−PheX−M_at31632_atAFFX−TrpnX−M_at31461_at31733_at31492_at31566_at31341_at31724_at31535_i_at31386_at31669_s_at31356_at31721_at31419_r_at31623_f_at31440_at31428_at31396_r_at31509_at31708_at31546_at31573_at31722_at31527_at31545_at31330_at31511_at31583_at31568_atRVGUOMYWJAFCZHQSKNTIBLDXEPsex=Femalesex=Maletype=Casetype=Control00.20.40.60.81score1.522.533.5standard.errorssigCorScore=0sigCorScore=1isTransElong=0> ann4a = annHeatmap2(exprs(exdat2),
+
+
> plot(ann4a)

ann=list(Col=list(data=pData(exdat2)), Row=list(data=annFeatures)),
labels=list(Row=list(nrow=7), Col=list(nrow=2)))

Figure 9: Double annotated heatmap with row- and column dendrograms
and annotation, plus a legend, for 46 genes and 26 samples, with modified
space for column/row labels.

14

AFFX−hum_alu_at31328_at31648_at31531_g_at31552_at31631_f_at31351_at31606_atAFFX−YEL018w/_at31713_s_atAFFX−MurIL4_at31580_at31345_at31447_at31683_at31654_atAFFX−PheX−M_at31632_atAFFX−TrpnX−M_at31461_at31733_at31492_at31566_at31341_at31724_at31535_i_at31386_at31669_s_at31356_at31721_at31419_r_at31623_f_at31440_at31428_at31396_r_at31509_at31708_at31546_at31573_at31722_at31527_at31545_at31330_at31511_at31583_at31568_atRVGUOMYWJAFCZHQSKNTIBLDXEPsex=Femalesex=Maletype=Casetype=Control00.20.40.60.81score1.522.533.5standard.errorssigCorScore=0sigCorScore=1isTransElong=0ann=list( inclRef=FALSE,

> ann4b = annHeatmap2(exprs(exdat2),
+
+
+
+
> plot(ann4b, widths=c(2,5,1), heights=c(2,5,1))

Col=list(data=pData(exdat2)),
Row=list(data=annFeatures)

),

labels=list(Row=list(nrow=7), Col=list(nrow=2)))

Figure 10: Double annotated heatmap with row- and column dendrograms
and annotation, plus a legend, for 46 genes and 26 samples. Extra space for
labels, no reference levels for annotation data, and changed proportions of
the plot.

15

AFFX−hum_alu_at31328_at31648_at31531_g_at31552_at31631_f_at31351_at31606_atAFFX−YEL018w/_at31713_s_atAFFX−MurIL4_at31580_at31345_at31447_at31683_at31654_atAFFX−PheX−M_at31632_atAFFX−TrpnX−M_at31461_at31733_at31492_at31566_at31341_at31724_at31535_i_at31386_at31669_s_at31356_at31721_at31419_r_at31623_f_at31440_at31428_at31396_r_at31509_at31708_at31546_at31573_at31722_at31527_at31545_at31330_at31511_at31583_at31568_atRVGUOMYWJAFCZHQSKNTIBLDXEPsex=Maletype=Control00.40.8score1.522.533.5standard.errorssigCorScore=1isTransElong=0> ann1 = convAnnData(pData(exdat2), inclRef=FALSE)[, 3:1]
> colnames(ann1) = c("Score", "isControl", "isMale")
> ann2 = convAnnData(annFeatures, inclRef=FALSE)[, 3:1]
> colnames(ann2) = c("isTranslationalElongation", "isCorrelated", "SE")
> ann4c = annHeatmap2(exprs(exdat2),
+
+
> plot(ann4c)

ann=list(asIs=TRUE, Col=list(data=ann1), Row=list(data=ann2)),
labels=list(Row=list(nrow=7), Col=list(nrow=2)))

Figure 11: Double annotated heatmap with row- and column dendrograms
and annotation, plus a legend, for 46 genes and 26 samples, with refined
annotation data frames passed in and used unchanged.

16

AFFX−hum_alu_at31328_at31648_at31531_g_at31552_at31631_f_at31351_at31606_atAFFX−YEL018w/_at31713_s_atAFFX−MurIL4_at31580_at31345_at31447_at31683_at31654_atAFFX−PheX−M_at31632_atAFFX−TrpnX−M_at31461_at31733_at31492_at31566_at31341_at31724_at31535_i_at31386_at31669_s_at31356_at31721_at31419_r_at31623_f_at31440_at31428_at31396_r_at31509_at31708_at31546_at31573_at31722_at31527_at31545_at31330_at31511_at31583_at31568_atRVGUOMYWJAFCZHQSKNTIBLDXEP0.20.40.60.81ScoreisControlisMaleisTranslationalElongationisCorrelated1.522.53SE