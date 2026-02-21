# Integrative analysis pipeline for pooled CRISPR functional genetic screens - MAGeCKFlute

#### *WubingZhang, Binbin Wang*

#### *21 Feb, 2019*

Abstract

CRISPR (clustered regularly interspaced short palindrome repeats) coupled with nuclease Cas9 (CRISPR/Cas9) screens represent a promising technology to systematically evaluate gene functions. Data analysis for CRISPR/Cas9 screens is a critical process that includes identifying screen hits and exploring biological functions for these hits in downstream analysis. We have previously developed two algorithms, MAGeCK and MAGeCK-VISPR, to analyze CRISPR/Cas9 screen data in various scenarios. These two algorithms allow users to perform quality control, read count generation and normalization, and calculate beta score to evaluate gene selection performance. In downstream analysis, the biological functional analysis is required for understanding biological functions of these identified genes with different screening purposes. Here, We developed MAGeCKFlute for supporting downstream analysis. MAGeCKFlute provides several strategies to remove potential biases within sgRNA-level read counts and gene-level beta scores. The downstream analysis with the package includes identifying essential, non-essential, and target-associated genes, and performing biological functional category analysis, pathway enrichment analysis and protein complex enrichment analysis of these genes. The package also visualizes genes in multiple ways to benefit users exploring screening data. Collectively, MAGeCKFlute enables accurate identification of essential, non-essential, and targeted genes, as well as their related biological functions. This vignette explains the use of the package and demonstrates typical workflows. MAGeCKFlute package version: 1.2.3

* [How to get help for MAGeCKFlute](#how-to-get-help-for-mageckflute)
* [Input data](#input-data)
  + [MAGeCK results](#mageck-results)
  + [Customized matrix input](#customized-matrix-input)
* [Quick start](#quick-start)
* [Section I: Quality control](#section-i-quality-control)
* [Section II: Downstream analysis of MAGeCK RRA](#section-ii-downstream-analysis-of-mageck-rra)
  + [Negative selection and positive selection](#negative-selection-and-positive-selection)
* [Section III: Downstream analysis of MAGeCK MLE](#section-iii-downstream-analysis-of-mageck-mle)
  + [Batch effect removal](#batch-effect-removal)
  + [Normalization of beta scores](#normalization-of-beta-scores)
  + [Estimate cell cycle time by linear fitting](#estimate-cell-cycle-time-by-linear-fitting)
  + [Positive selection and negative selection](#positive-selection-and-negative-selection)
  + [Functional analysis of selected genes](#functional-analysis-of-selected-genes)
  + [Identify treatment-associated genes using 9-square model](#identify-treatment-associated-genes-using-9-square-model)
  + [Functional analysis for treatment-associated genes](#functional-analysis-for-treatment-associated-genes)
* [Session info](#session-info)
* [References](#references)

**Note:** if you use MAGeCKFlute in published research, please cite: Binbin Wang, Mei Wang, Wubing Zhang. “Integrative analysis of pooled CRISPR genetic screens using MAGeCKFlute.” Nature Protocols (2019), doi: [10.1038/s41596-018-0113-7](https://www.nature.com/articles/s41596-018-0113-7).

## How to get help for MAGeCKFlute

Any and all MAGeCKFlute questions should be posted to the **Bioconductor support site**, which serves as a searchable knowledge base of questions and answers:

<https://support.bioconductor.org>

Posting a question and tagging with “MAGeCKFlute” will automatically send an alert to the package authors to respond on the support site. See the first question in the list of [Frequently Asked Questions](#FAQ) (FAQ) for information about how to construct an informative post.

You can also email your question to the package authors.

## Input data

### MAGeCK results

MAGeCK (Wei Li and Liu. 2014) and MAGeCK-VISPR (Wei Li and Liu. 2015) are developed by our lab previously, to analyze CRISPR/Cas9 screen data in different scenarios(Tim Wang 2014, Hiroko Koike-Yusa (2014), Ophir Shalem1 (2014), Luke A.Gilbert (2014), Silvana Konermann (2015)). Both algorithms use negative binomial models to model the variances of sgRNAs, and use Robust Rank Aggregation (for MAGeCK) or maximum likelihood framework (for MAGeCK-VISPR) for a robust identification of selected genes.

The command `mageck mle` computes beta scores and the associated statistics for all genes in multiple conditions. The **beta score** describes how the gene is selected: a positive beta score indicates a positive selection, and a negative beta score indicates a negative selection.

The command `mageck test` uses Robust Rank Aggregation (RRA) for robust identification of CRISPR-screen hits, and outputs the summary results at both sgRNA and gene level.

### Customized matrix input

FluteMLE: A matrix contains columns of ‘Gene’, .beta and .beta which corresponding to the parameter and . FluteRRA: A matrix contains columns of “id”, “neg.goodsgrna”, “neg.lfc”, “neg.fdr”, “pos.goodsgrna”, and “pos.fdr”.

## Quick start

Here we show the most basic steps for integrative analysis pipeline. MAGeCKFlute package provides several example data, including `countsummary`, `rra.gene_summary`, `rra.sgrna_summary`, and `mle.gene_summary`, which are generated by running MAGeCK. We will work with them in this document.

```
library(MAGeCKFlute)
```

**Downstream analysis pipeline for MAGeCK RRA**

```
##Load gene summary data in MAGeCK RRA results
data("rra.gene_summary")
data("rra.sgrna_summary")
##Run the downstream analysis pipeline for MAGeCK RRA
FluteRRA(rra.gene_summary, rra.sgrna_summary, prefix="RRA", organism="hsa")
```

All pipeline results are written into local directory “./RRA\_Flute\_Results/”, and all figures are integrated into file “RRA\_Flute.rra\_summary.pdf”.

**Downstream analysis pipeline for MAGeCK MLE**

```
## Load gene summary data in MAGeCK MLE results
data("mle.gene_summary")
## Run the downstream analysis pipeline for MAGeCK MLE
FluteMLE(mle.gene_summary, ctrlname="dmso", treatname="plx", prefix="MLE", organism="hsa")
```

All pipeline results are written into local directory “./MLE\_Flute\_Results/”, and all figures are integrated into file “MLE\_Flute.mle\_summary.pdf”.

## Section I: Quality control

\*\* Count summary \*\* `MAGeCK Count` in MAGeCK/MAGeCK-VISPR generates a count summary file, which summarizes some basic QC scores at raw count level, including map ratio, Gini index, and NegSelQC. Use function ‘data’ to load the dataset, and have a look at the file with a text editor to see how it is formatted.

```
data("countsummary")
head(countsummary)
```

```
##                                   File    Label    Reads   Mapped
## 1 ../data/GSC_0131_Day23_Rep1.fastq.gz day23_r1 62818064 39992777
## 2  ../data/GSC_0131_Day0_Rep2.fastq.gz  day0_r2 47289074 31709075
## 3  ../data/GSC_0131_Day0_Rep1.fastq.gz  day0_r1 51190401 34729858
## 4 ../data/GSC_0131_Day23_Rep2.fastq.gz day23_r2 58686580 37836392
##   Percentage TotalsgRNAs Zerocounts GiniIndex NegSelQC NegSelQCPval
## 1     0.6366       64076         57   0.08510        0            1
## 2     0.6705       64076         17   0.07496        0            1
## 3     0.6784       64076         14   0.07335        0            1
## 4     0.6447       64076         51   0.08587        0            1
##   NegSelQCPvalPermutation NegSelQCPvalPermutationFDR NegSelQCGene
## 1                       1                          1            0
## 2                       1                          1            0
## 3                       1                          1            0
## 4                       1                          1            0
```

```
MapRatesView(countsummary)
```

![](data:image/png;base64...)

```
IdentBarView(countsummary, x = "Label", y = "GiniIndex",
ylab = "Gini index", main = "Evenness of sgRNA reads")
```

![](data:image/png;base64...)

```
countsummary$Missed = log10(countsummary$Zerocounts)
IdentBarView(countsummary, x = "Label", y = "Missed", fill = "#394E80",
ylab = "Log10 missed gRNAs", main = "Missed sgRNAs")
```

![](data:image/png;base64...)

## Section II: Downstream analysis of MAGeCK RRA

For experiments with two experimental conditions, we recommend using MAGeCK-RRA to identify essential genes from CRISPR/Cas9 knockout screens and tests the statistical significance of each observed change between two states. Gene summary file in MAGeCK-RRA results summarizes the statistical significance of positive selection and negative selection. Use function ‘data’ to load the dataset, and have a look at the file with a text editor to see how it is formatted.

```
library(MAGeCKFlute)
data("rra.gene_summary")
head(rra.gene_summary)
```

```
##       id num  neg.score neg.p.value  neg.fdr neg.rank neg.goodsgrna
## 1    NF2   4 4.1770e-12  2.9738e-07 0.000275        1             4
## 2 SRSF10   4 4.4530e-11  2.9738e-07 0.000275        2             4
## 3 EIF2B4   8 2.8994e-10  2.9738e-07 0.000275        3             8
## 4  LAS1L   6 1.4561e-09  2.9738e-07 0.000275        4             6
## 5   RPL3  15 2.3072e-09  2.9738e-07 0.000275        5            12
## 6 ATP6V0   7 3.8195e-09  2.9738e-07 0.000275        6             7
##   neg.lfc pos.score pos.p.value pos.fdr pos.rank pos.goodsgrna pos.lfc
## 1 -1.3580   1.00000     1.00000       1    16645             0 -1.3580
## 2 -1.8544   1.00000     1.00000       1    16647             0 -1.8544
## 3 -1.5325   1.00000     1.00000       1    16646             0 -1.5325
## 4 -2.2402   0.99999     0.99999       1    16570             0 -2.2402
## 5 -1.0663   0.95519     0.99205       1    15359             2 -1.0663
## 6 -1.6380   1.00000     1.00000       1    16644             0 -1.6380
```

### Negative selection and positive selection

Then, extract “neg.fdr” and “pos.fdr” from the gene summary table.

```
dd.rra = ReadRRA(rra.gene_summary, organism = "hsa")
head(dd.rra)
```

```
##       Official EntrezID     LFC      FDR
## 4771       NF2     4771 -1.3580 0.000275
## 10772   SRSF10    10772 -1.8544 0.000275
## 8890    EIF2B4     8890 -1.5325 0.000275
## 81887    LAS1L    81887 -2.2402 0.000275
## 6122      RPL3     6122 -1.0663 0.000275
## 7536       SF1     7536 -1.8365 0.000275
```

```
dd.sgrna = ReadsgRRA(rra.sgrna_summary)
```

We provide a function `VolcanoView` to visualize top negative and positive selected genes.

```
p1 = VolcanoView(dd.rra, x = "LFC", y = "FDR", Label = "Official")
print(p1)
```

![](data:image/png;base64...)

We provide a function `RankView` to visualize top negative and positive selected genes.

```
geneList= dd.rra$LFC
names(geneList) = dd.rra$Official
p2 = RankView(geneList, top = 10, bottom = 10)
print(p2)
```

![](data:image/png;base64...)

We also provide a function `sgRankView` to visualize the rank of sgRNA targeting top negative and positive selected genes.

```
p2 = sgRankView(dd.sgrna, top = 0, bottom = 0, gene = levels(p1$data$Label))
print(p2)
```

![](data:image/png;base64...)

Select negative selection and positive selection genes and perform enrichment analysis.

#### Enrichment analysis

```
universe = dd.rra$EntrezID
geneList= dd.rra$LFC
names(geneList) = universe

enrich = enrich.GSE(geneList = geneList, type = "CORUM")
```

```
## Warning in fgsea(pathways = geneSets, stats = geneList, nperm = nPerm, minSize = minGSSize, : There are ties in the preranked stats (4.36% of the list).
## The order of those tied genes will be arbitrary, which may produce unexpected results.
```

Visualize the top enriched genes and pathways/GO terms using `EnrichedGeneView`, `EnrichedView` and `EnrichedGSEView`.

```
EnrichedGeneView(slot(enrich, "result"), geneList, keytype = "Entrez")
```

![](data:image/png;base64...)

```
EnrichedGSEView(slot(enrich, "result"))
```

![](data:image/png;base64...)

```
EnrichedView(slot(enrich, "result"))
```

![](data:image/png;base64...)

## Section III: Downstream analysis of MAGeCK MLE

\*\* Gene summary \*\* The gene summary file in MAGeCK-MLE results includes beta scores of all genes in multiple condition samples.

```
library(MAGeCKFlute)
data("mle.gene_summary")
head(mle.gene_summary)
```

```
##     Gene sgRNA dmso.beta   dmso.z dmso.p.value dmso.fdr dmso.wald.p.value
## 1   FEZ1     6 -0.045088 -0.66798      0.79649  0.97939        5.0415e-01
## 2    TNN     6  0.094325  1.36120      0.34176  0.89452        1.7344e-01
## 3  NAT8L     3  0.026362  0.24661      0.54185  0.94568        8.0521e-01
## 4   OAS2     8 -0.271210 -4.76860      0.46995  0.93572        1.8555e-06
## 5 OR10H3     2 -0.098324 -0.86408      0.99473  0.99872        3.8754e-01
## 6  CCL16     3 -0.309750 -3.43910      0.38495  0.90896        5.8372e-04
##   dmso.wald.fdr  plx.beta    plx.z plx.p.value plx.fdr plx.wald.p.value
## 1    6.3060e-01 -0.036721 -0.54346     0.81604 0.98345       5.8681e-01
## 2    2.8578e-01  0.065533  0.94344     0.47309 0.93207       3.4546e-01
## 3    8.7248e-01  0.044979  0.42072     0.53600 0.94583       6.7396e-01
## 4    1.4126e-05 -0.289010 -5.07170     0.40411 0.90933       3.9431e-07
## 5    5.2094e-01 -0.365730 -3.16890     0.26493 0.85892       1.5300e-03
## 6    2.4781e-03 -0.148830 -1.66090     0.78757 0.98229       9.6739e-02
##   plx.wald.fdr
## 1   6.9940e-01
## 2   4.7400e-01
## 3   7.7008e-01
## 4   3.5296e-06
## 5   5.4996e-03
## 6   1.7459e-01
```

Then, extract beta scores of control and treatment samples from the gene summary table(can be a file path of ‘gene\_summary’ or data frame).

```
data("mle.gene_summary")
ctrlname = c("dmso")
treatname = c("plx")
#Read beta scores from gene summary table in MAGeCK MLE results
dd=ReadBeta(mle.gene_summary, organism="hsa")
head(dd)
```

```
##          Gene EntrezID      dmso       plx
## 9638     FEZ1     9638 -0.045088 -0.036721
## 63923     TNN    63923  0.094325  0.065533
## 339983  NAT8L   339983  0.026362  0.044979
## 4939     OAS2     4939 -0.271210 -0.289010
## 26532  OR10H3    26532 -0.098324 -0.365730
## 6360    CCL16     6360 -0.309750 -0.148830
```

### Batch effect removal

Is there batch effects? This is a commonly asked question before perform later analysis. In our package, we provide `HeatmapView` to ensure whether the batch effect exists in data and use `BatchRemove` to remove easily if same batch samples cluster together.

```
##Before batch removal
data(bladderdata, package = "bladderbatch")
dat <- bladderEset[, 1:10]
pheno = pData(dat)
edata = exprs(dat)
HeatmapView(cor(edata))
```

![](data:image/png;base64...)

```
## After batch removal
batchMat = pheno[, c("sample", "batch", "cancer")]
batchMat$sample = rownames(batchMat)
edata1 = BatchRemove(edata, batchMat)
```

```
## Standardizing Data across genes
```

```
HeatmapView(cor(edata1$data))
```

![](data:image/png;base64...)

### Normalization of beta scores

It is difficult to control all samples with a consistent cell cycle in a CRISPR screen experiment with multi conditions. Besides, beta score among different states with an inconsistent cell cycle is incomparable. So it is necessary to do the normalization when comparing the beta scores in different conditions. Essential genes are those genes that are indispensable for its survival. The effect generated by knocking out these genes in different cell types is consistent. Based on this, we developed the cell cycle normalization method to shorten the gap of the cell cycle in different conditions. Besides, a previous normalization method called loess normalization is available in this package.(Laurent Gautier 2004)

```
dd_essential = NormalizeBeta(dd, samples=c(ctrlname, treatname), method="cell_cycle")
head(dd_essential)
```

```
##          Gene EntrezID        dmso         plx
## 9638     FEZ1     9638 -0.05174381 -0.04904438
## 63923     TNN    63923  0.10824908  0.08752554
## 339983  NAT8L   339983  0.03025351  0.06007372
## 4939     OAS2     4939 -0.31124551 -0.38600029
## 26532  OR10H3    26532 -0.11283840 -0.48846714
## 6360    CCL16     6360 -0.35547471 -0.19877660
```

```
#OR
dd_loess = NormalizeBeta(dd, samples=c(ctrlname, treatname), method="loess")
head(dd_loess)
```

```
##          Gene EntrezID        dmso         plx
## 9638     FEZ1     9638 -0.04327385 -0.03853515
## 63923     TNN    63923  0.10139861  0.05845939
## 339983  NAT8L   339983  0.03130002  0.04004098
## 4939     OAS2     4939 -0.27052367 -0.28969633
## 26532  OR10H3    26532 -0.09799013 -0.36606387
## 6360    CCL16     6360 -0.30943104 -0.14914896
```

#### Distribution of all gene beta scores

After normalization, the distribution of beta scores in different conditions should be similar. We can evaluate the distribution of beta scores using the function ‘ViolinView’, ‘DensityView’, and ‘DensityDiffView’.

```
ViolinView(dd_essential, samples=c(ctrlname, treatname))
```

![](data:image/png;base64...)

```
DensityView(dd_essential, samples=c(ctrlname, treatname))
```

![](data:image/png;base64...)

```
DensityDiffView(dd_essential, ctrlname, treatname)
```

![](data:image/png;base64...)

```
#we can also use the function 'MAView' to evaluate the data quality of normalized
#beta score profile.
MAView(dd_essential, ctrlname, treatname)
```

![](data:image/png;base64...)

### Estimate cell cycle time by linear fitting

After normalization, the cell cycle time in different condition should be almost consistent. Here we use a linear fitting to estimate the cell cycle time, and use function `CellCycleView` to view the cell cycle time of all samples.

```
##Fitting beta score of all genes
CellCycleView(dd_essential, ctrlname, treatname)
```

![](data:image/png;base64...)

### Positive selection and negative selection

The function `ScatterView` can group all genes into three groups, positive selection genes (GroupA), negative selection genes (GroupB), and others, and visualize these three grouped genes in scatter plot. We can also use function `RankView` to rank the beta score deviation between control and treatment and mark top selected genes in the figure.

```
p1 = ScatterView(dd_essential, ctrlname, treatname)
print(p1)
```

![](data:image/png;base64...)

```
## Add column of 'diff'
dd_essential$Control = rowMeans(dd_essential[,ctrlname, drop = FALSE])
dd_essential$Treatment = rowMeans(dd_essential[,treatname, drop = FALSE])

rankdata = dd_essential$Treatment - dd_essential$Control
names(rankdata) = dd_essential$Gene
p2 = RankView(rankdata)
print(p2)
```

![](data:image/png;base64...)

### Functional analysis of selected genes

For gene set enrichment analysis, we provide three methods in this package, including “ORT”(Over-Representing Test (Guangchuang Yu and He. 2012)), “GSEA”(Gene Set Enrichment Analysis (Aravind Subramanian and Mesirov. 2005)), and “HGT”(hypergeometric test), which can be performed on annotations of Gene ontology(GO) terms (Consortium. 2014), Kyoto encyclopedia of genes and genomes (KEGG) pathways (Minoru Kanehisa 2014), MsigDB gene sets, or custom gene sets. The enrichment analysis can be done easily using function `enrichment_analysis`, which return a list containing `gridPlot` (ggplot object) and `enrichRes` (enrichResult instance). Alternatively, you can do enrichment analysis using the function `enrich.ORT` for “ORT”, `enrich.GSE` for GSEA, and `enrich.HGT` for “HGT”, which return an enrichResult instance. Function `EnrichedView` and `EnrichedGSEView` (for `enrich.GSE`) can be used to generate `gridPlot` from `enrichRes` easily, as shown below.

```
## Get information of positive and negative selection genes
groupAB = p1$data
## select positive selection genes
idx1=groupAB$group=="up"
genes=rownames(groupAB)[idx1]
geneList=groupAB$diff[idx1]
names(geneList)=genes
geneList = sort(geneList, decreasing = TRUE)
universe=rownames(groupAB)
## Do enrichment analysis using HGT method
hgtA = enrich.HGT(geneList[1:100], organism = "hsa", universe = universe)
hgtA_grid = EnrichedGSEView(slot(hgtA, "result"))

## look at the results
head(slot(hgtA, "result"))
```

```
##                  ID
## CORUM_230 CORUM_230
## CORUM_232 CORUM_232
## CORUM_287 CORUM_287
## CORUM_288 CORUM_288
## CORUM_324 CORUM_324
## CORUM_445 CORUM_445
##                                                                  Description
## CORUM_230                                                   Mediator complex
## CORUM_232                                                        Arc complex
## CORUM_287                                                      Arc-l complex
## CORUM_288                                                        Arc complex
## CORUM_324                               39s ribosomal subunit, mitochondrial
## CORUM_445 Tftc complex (tata-binding protein-free taf-ii-containing complex)
##                NES       pvalue     p.adjust GeneRatio BgRatio
## CORUM_230 2.392871 3.335135e-05 3.531320e-05      3/32   32/32
## CORUM_232 2.392871 1.365178e-06 2.329931e-06      3/15   15/15
## CORUM_287 2.392871 1.005589e-06 2.262575e-06      3/14   14/14
## CORUM_288 2.392871 1.365178e-06 2.329931e-06      3/15   15/15
## CORUM_324 1.257049 1.422503e-04 1.422503e-04      3/46   46/48
## CORUM_445 1.927449 1.812169e-06 2.329931e-06      3/16   16/16
##                       geneID             geneName Count
## CORUM_230    51586/9439/9968    MED15/MED23/MED12     3
## CORUM_232    51586/9439/9968    MED15/MED23/MED12     3
## CORUM_287    51586/9439/9968    MED15/MED23/MED12     3
## CORUM_288    51586/9439/9968    MED15/MED23/MED12     3
## CORUM_324 63875/64979/116540 MRPL17/MRPL36/MRPL53     3
## CORUM_445  10629/10474/27097    TAF6L/TADA3/TAF5L     3
```

```
print(hgtA_grid)
```

![](data:image/png;base64...)

```
## Do enrichment analysis using GSEA method
gseA = enrich.GSE(geneList, type = "KEGG", organism = "hsa", pvalueCutoff = 1)
gseA_grid = EnrichedGSEView(slot(gseA, "result"))

#should same as
head(slot(gseA, "result"))
```

```
##                          ID                    Description       NES
## KEGG_hsa00590 KEGG_hsa00590    Arachidonic acid metabolism -2.177581
## KEGG_hsa04922 KEGG_hsa04922     Glucagon signaling pathway  1.639915
## KEGG_hsa04140 KEGG_hsa04140             Autophagy - animal -1.852072
## KEGG_hsa01230 KEGG_hsa01230    Biosynthesis of amino acids  1.664319
## KEGG_hsa04120 KEGG_hsa04120 Ubiquitin mediated proteolysis  1.673440
## KEGG_hsa00480 KEGG_hsa00480         Glutathione metabolism  1.560426
##                    pvalue  p.adjust
## KEGG_hsa00590 0.002985075 0.4447761
## KEGG_hsa04922 0.014539580 0.6133982
## KEGG_hsa04140 0.015625000 0.6133982
## KEGG_hsa01230 0.016467066 0.6133982
## KEGG_hsa04120 0.021791768 0.6493947
## KEGG_hsa00480 0.035928144 0.7908274
##                                                geneID
## KEGG_hsa00590                        11145/240/257202
## KEGG_hsa04922                          5531/1387/5315
## KEGG_hsa04140                              1508/64798
## KEGG_hsa01230                       226/445/5315/7167
## KEGG_hsa04120 8452/9040/9039/6923/9616/8065/9817/7332
## KEGG_hsa00480                               5226/6723
##                                                  geneName Count
## KEGG_hsa00590                          PLA2G16/ALOX5/GPX6     3
## KEGG_hsa04922                            PPP4C/CREBBP/PKM     3
## KEGG_hsa04140                                 CTSB/DEPTOR     2
## KEGG_hsa01230                         ALDOA/ASS1/PKM/TPI1     4
## KEGG_hsa04120 CUL3/UBE2M/UBA3/ELOB/RNF7/CUL5/KEAP1/UBE2L3     8
## KEGG_hsa00480                                     PGD/SRM     2
```

```
print(gseA_grid)
```

![](data:image/png;base64...)

For enriched pathways, we can use function `KeggPathwayView` to visualize the beta score level in control and treatment on pathway map.(Weijun Luo 2013)

```
genedata = dd_essential[,c("Control","Treatment")]
keggID = gsub("KEGG_", "", slot(gseA, "result")$ID[1])
arrangePathview(genedata, pathways = keggID, organism = "hsa", sub = NULL)
```

![](data:image/png;base64...)

### Identify treatment-associated genes using 9-square model

We developed a 9-square model, which group all genes into several subgroups by considering the selection status of genes in control and treatment. Each subgroup genes correspond to specific functions.

```
p3 = SquareView(dd_essential, label = "Gene")
print(p3)
```

![](data:image/png;base64...)

### Functional analysis for treatment-associated genes

Same as the section above. We can do enrichment analysis for treatment-associated genes.

```
#Get information of treatment-associated genes
Square9 = p3$data
# Select group1 genes in 9-Square
idx=Square9$group=="Group1"
geneList = (Square9$Treatment - Square9$Control)[idx]
names(geneList) = rownames(Square9)[idx]
universe=rownames(Square9)
# KEGG_enrichment
kegg1 = enrich.HGT(geneList = geneList, universe = universe, type = "KEGG")
# View the results
head(slot(kegg1, "result"))
```

```
##                          ID                 Description       NES
## KEGG_hsa00030 KEGG_hsa00030   Pentose phosphate pathway 1.1449001
## KEGG_hsa00480 KEGG_hsa00480      Glutathione metabolism 1.3294453
## KEGG_hsa00970 KEGG_hsa00970 Aminoacyl-trna biosynthesis 0.9790629
## KEGG_hsa03022 KEGG_hsa03022 Basal transcription factors 0.7510368
## KEGG_hsa03060 KEGG_hsa03060              Protein export 0.6248644
##                     pvalue     p.adjust GeneRatio BgRatio
## KEGG_hsa00030 1.602956e-06 8.014780e-06      5/28   28/30
## KEGG_hsa00480 5.379564e-04 6.724455e-04      4/50   50/56
## KEGG_hsa00970 2.579574e-03 2.579574e-03      3/43   43/66
## KEGG_hsa03022 1.908063e-05 4.770157e-05      5/42   42/45
## KEGG_hsa03060 1.575381e-04 2.625636e-04      3/21   21/23
##                                   geneID                       geneName
## KEGG_hsa00030    2821/6120/5226/226/2539         GPI/RPE/PGD/ALDOA/G6PD
## KEGG_hsa00480        2879/6723/5226/2539              GPX4/SRM/PGD/G6PD
## KEGG_hsa00970          51067/57176/92935              YARS2/VARS2/MARS2
## KEGG_hsa03022 2957/2068/2958/129685/6883 GTF2A1/ERCC2/GTF2A2/TAF8/TAF12
## KEGG_hsa03060            5018/3309/23480             OXA1L/HSPA5/SEC61G
##               Count
## KEGG_hsa00030     5
## KEGG_hsa00480     4
## KEGG_hsa00970     3
## KEGG_hsa03022     5
## KEGG_hsa03060     3
```

```
EnrichedGSEView(slot(kegg1, "result"))
```

![](data:image/png;base64...)

Also, pathway visualization can be done using function `KeggPathwayView`, the same as the section above.

```
genedata = dd_essential[, c("Control","Treatment")]
keggID = gsub("KEGG_", "", slot(kegg1, "result")$ID[1])
arrangePathview(genedata, pathways = keggID, organism = "hsa", sub = NULL)
```

# Session info

```
sessionInfo()
```

```
## R version 3.5.2 (2018-12-20)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 16.04.5 LTS
##
## Matrix products: default
## BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] parallel  stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] MAGeCKFlute_1.2.3    gridExtra_2.3        pathview_1.22.3
##  [4] org.Hs.eg.db_3.7.0   AnnotationDbi_1.44.0 IRanges_2.16.0
##  [7] S4Vectors_0.20.1     Biobase_2.42.0       BiocGenerics_0.28.0
## [10] ggplot2_3.1.0
##
## loaded via a namespace (and not attached):
##   [1] fgsea_1.8.0            colorspace_1.4-0       ggridges_0.5.1
##   [4] qvalue_2.14.1          XVector_0.22.0         farver_1.1.0
##   [7] urltools_1.7.2         ggrepel_0.8.0          bit64_0.9-7
##  [10] xml2_1.2.0             codetools_0.2-16       splines_3.5.2
##  [13] GOSemSim_2.8.0         knitr_1.21             jsonlite_1.6
##  [16] annotate_1.60.0        GO.db_3.7.0            png_0.1-7
##  [19] pheatmap_1.0.12        graph_1.60.0           ggforce_0.1.3
##  [22] shiny_1.2.0            compiler_3.5.2         httr_1.4.0
##  [25] rvcheck_0.1.3          assertthat_0.2.0       Matrix_1.2-15
##  [28] lazyeval_0.2.1         limma_3.38.3           later_0.8.0
##  [31] tweenr_1.0.1           htmltools_0.3.6        prettyunits_1.0.2
##  [34] tools_3.5.2            igraph_1.2.4           gtable_0.2.0
##  [37] glue_1.3.0             reshape2_1.4.3         DO.db_2.9
##  [40] dplyr_0.8.0.1          fastmatch_1.1-0        Rcpp_1.0.0
##  [43] enrichplot_1.2.0       Biostrings_2.50.2      nlme_3.1-137
##  [46] ggraph_1.0.2           xfun_0.5               stringr_1.4.0
##  [49] mime_0.6               miniUI_0.1.1.1         clusterProfiler_3.10.1
##  [52] XML_3.98-1.17          DOSE_3.8.2             europepmc_0.3
##  [55] zlibbioc_1.28.0        MASS_7.3-51.1          scales_1.0.0
##  [58] hms_0.4.2              promises_1.0.1         KEGGgraph_1.42.0
##  [61] RColorBrewer_1.1-2     yaml_2.2.0             memoise_1.1.0
##  [64] UpSetR_1.3.3           biomaRt_2.38.0         triebeard_0.3.0
##  [67] ggExtra_0.8            stringi_1.3.1          RSQLite_2.1.1
##  [70] genefilter_1.64.0      BiocParallel_1.16.6    matrixStats_0.54.0
##  [73] rlang_0.3.1            pkgconfig_2.0.2        bitops_1.0-6
##  [76] evaluate_0.13          lattice_0.20-38        purrr_0.3.0
##  [79] labeling_0.3           cowplot_0.9.4          bit_1.1-14
##  [82] tidyselect_0.2.5       ggsci_2.9              plyr_1.8.4
##  [85] magrittr_1.5           R6_2.4.0               DBI_1.0.0
##  [88] mgcv_1.8-27            pillar_1.3.1           withr_2.1.2
##  [91] units_0.6-2            survival_2.43-3        KEGGREST_1.22.0
##  [94] RCurl_1.95-4.11        tibble_2.0.1           crayon_1.3.4
##  [97] rmarkdown_1.11         viridis_0.5.1          progress_1.2.0
## [100] grid_3.5.2             sva_3.30.1             data.table_1.12.0
## [103] blob_1.1.1             Rgraphviz_2.26.0       digest_0.6.18
## [106] xtable_1.8-3           tidyr_0.8.2            httpuv_1.4.5.1
## [109] gridGraphics_0.3-0     munsell_0.5.0          bladderbatch_1.20.0
## [112] viridisLite_0.3.0      ggplotify_0.0.3
```

# References

Subramanian, A. et al. Gene set enrichment analysis: a knowledge-based approach for interpreting genome-wide expression profiles. Proc. Natl. Acad. Sci. USA 102, [15545–15550](https://www.pnas.org/content/102/43/15545) (2005).

Yu, G., Lg, W., H., Y. & Qy., H. clusterProfiler: an R package for comparing biological themes among gene clusters. OMICS 16, [284–287](https://www.liebertpub.com/doi/10.1089/omi.2011.0118) (2012).

Luo, W. & Brouwer, C. Pathview: an R/Bioconductor package for pathway-based data integration and visualization. Bioinformatics 29, [1830–1831](https://academic.oup.com/bioinformatics/article-abstract/29/14/1830/232698) (2013).

Aravind Subramanian, Vamsi K. Moothaa, Pablo Tamayo, and Jill P. Mesirov. 2005. “Gene set enrichment analysis: A knowledge-based approach for interpreting genome-wide expression profiles.” <http://www.pnas.org/content/102/43/15545.full>.

Consortium., The Gene Ontology. 2014. “Gene Ontology Consortium: going forward.” <https://academic.oup.com/nar/article/43/D1/D1049/2439067>.

Guangchuang Yu, Yanyan Han, Li-Gen Wang, and Qing-Yu He. 2012. “clusterProfiler: an R Package for Comparing Biological Themes Among Gene Clusters.” <http://online.liebertpub.com/doi/abs/10.1089/omi.2011.0118>.

Hiroko Koike-Yusa, E-Pien Tan, Yilong Li. 2014. “Genome-wide recessive genetic screening in mammalian cells with a lentiviral CRISPR-guide RNA library.” <http://science.sciencemag.org/content/343/6166/80.long>.

Laurent Gautier, Benjamin M. Bolstad, Leslie Cope. 2004. “affy—analysis of Affymetrix GeneChip data at the probe level.” <https://academic.oup.com/bioinformatics/article/20/3/307/185980>.

Luke A.Gilbert, BrittAdamson, Max A.Horlbeck. 2014. “Genome-Scale CRISPR-Mediated Control of Gene Repression and Activation.” [https://linkinghub.elsevier.com/retrieve/pii/S0092-8674(14)01178-7](https://linkinghub.elsevier.com/retrieve/pii/S0092-8674%2814%2901178-7).

Minoru Kanehisa, Yoko Sato, Susumu Goto. 2014. “Data, information, knowledge and principle: back to metabolism in KEGG.” <https://academic.oup.com/nar/article-lookup/doi/10.1093/nar/gkt1076>.

Ophir Shalem1, \*, 2. 2014. “Genome-scale CRISPR-Cas9 knockout screening in human cells.” <http://science.sciencemag.org/content/343/6166/84.long>.

Silvana Konermann, Alexandro E. Trevino, Mark D. Brigham. 2015. “Genome-scale transcriptional activation by an engineered CRISPR-Cas9 complex.” <https://www.nature.com/nature/journal/vnfv/ncurrent/full/nature14136.html>.

Tim Wang, David M. Sabatini, Jenny J. Wei1. 2014. “Genetic Screens in Human Cells Using the CRISPR-Cas9 System.” <http://science.sciencemag.org/content/343/6166/80.long>.

Wei Li, Han Xu, Johannes Köster, and X. Shirley Liu. 2015. “Quality control, modeling, and visualization of CRISPR screens with MAGeCK-VISPR.” <https://genomebiology.biomedcentral.com/articles/10.1186/s13059-015-0843-6>.

Wei Li, Tengfei Xiao, Han Xu, and X Shirley Liu. 2014. “MAGeCK enables robust identification of essential genes from genome-scale CRISPR/Cas9 knockout screens.” <https://genomebiology.biomedcentral.com/articles/10.1186/s13059-014-0554-4>.

Weijun Luo, Cory Brouwer. 2013. “Pathview: an R/Bioconductor package for pathway-based data integration and visualization.” <https://academic.oup.com/bioinformatics/article-lookup/doi/10.1093/bioinformatics/btt285>.