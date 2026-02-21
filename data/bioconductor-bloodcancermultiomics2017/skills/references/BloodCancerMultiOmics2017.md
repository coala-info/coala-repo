# BloodCancerMultiOmics2017 - complete analysis

#### 4 November 2025

# Contents

* [1 Introduction](#introduction)
* [2 Characteristics of drugs and patients in the study](#characteristics-of-drugs-and-patients-in-the-study)
  + [2.1 Drugs](#drugs)
  + [2.2 Patient samples](#patient-samples)
* [3 Data quality control](#data-quality-control)
  + [3.1 Comparison of ATP luminescence of DMSO controls at timepoint 0 and 48 h](#comparison-of-atp-luminescence-of-dmso-controls-at-timepoint-0-and-48-h)
  + [3.2 Reproducibility of the drug screening platform](#reproducibility-of-the-drug-screening-platform)
* [4 Drug-induced effects on cell viability](#drug-induced-effects-on-cell-viability)
* [5 Drug-drug correlation](#drug-drug-correlation)
  + [5.1 Additional processing functions and parameters](#additional-processing-functions-and-parameters)
  + [5.2 CLL/T-PLL](#cllt-pll)
    - [5.2.1 Effect of drugs with similar target](#effect-of-drugs-with-similar-target)
  + [5.3 T-PLL](#t-pll)
  + [5.4 MCL](#mcl)
* [6 Disease-specific drug response phenotypes](#disease-specific-drug-response-phenotypes)
  + [6.1 Example: dose-response curves](#example-dose-response-curves)
  + [6.2 Example: drug effects as bee swarms](#example-drug-effects-as-bee-swarms)
* [7 Target profiling of AZD7762 and PF477736](#target-profiling-of-azd7762-and-pf477736)
* [8 Global overview of the drug response landscape](#global-overview-of-the-drug-response-landscape)
  + [8.1 Setup](#setup)
    - [8.1.1 Additional functions](#additional-functions)
    - [8.1.2 Preprocess `IGHV gene usage`](#preprocess-ighv-gene-usage)
    - [8.1.3 Some drugs that we are particularly interested in](#some-drugs-that-we-are-particularly-interested-in)
    - [8.1.4 Feature weighting and score for dendrogram reordering](#feature-weighting-and-score-for-dendrogram-reordering)
  + [8.2 Define disease groups](#define-disease-groups)
  + [8.3 Code for heatmap](#code-for-heatmap)
    - [8.3.1 Matrix row / column clustering](#matrix-row-column-clustering)
    - [8.3.2 Prepare sample annotations](#prepare-sample-annotations)
    - [8.3.3 Define the annotation colors](#define-the-annotation-colors)
    - [8.3.4 Heatmap drawing function](#heatmap-drawing-function)
  + [8.4 Draw the heatmaps](#draw-the-heatmaps)
    - [8.4.1 Identify places where gaps between the rows should be](#identify-places-where-gaps-between-the-rows-should-be)
* [9 Relative drug effects - ternary diagrams](#relative-drug-effects---ternary-diagrams)
  + [9.1 Additional settings](#additional-settings)
  + [9.2 Calculating the coordinates](#calculating-the-coordinates)
  + [9.3 Plot ternaries](#plot-ternaries)
    - [9.3.1 BCR drugs](#bcr-drugs)
    - [9.3.2 BTK & MEK & MTOR](#btk-mek-mtor)
    - [9.3.3 PI3K & MEK & MTOR](#pi3k-mek-mtor)
    - [9.3.4 SYK & MEK & MTOR](#syk-mek-mtor)
* [10 Comparison of gene expression responses to drug treatments](#comparison-of-gene-expression-responses-to-drug-treatments)
  + [10.1 Differential expression using Limma](#differential-expression-using-limma)
* [11 Co-sensitivity patterns of the four response groups](#co-sensitivity-patterns-of-the-four-response-groups)
  + [11.1 Methodology of building groups](#methodology-of-building-groups)
  + [11.2 Mean of each group](#mean-of-each-group)
  + [11.3 Bee swarm plots for groups](#bee-swarm-plots-for-groups)
* [12 Kaplan-Meier plot for groups (time from sample to next treatment)](#kaplan-meier-plot-for-groups-time-from-sample-to-next-treatment)
* [13 Incidence of somatic gene mutations and CNVs in the four groups](#incidence-of-somatic-gene-mutations-and-cnvs-in-the-four-groups)
  + [13.1 Test gene mutations vs. groups](#test-gene-mutations-vs.-groups)
* [14 Differences in gene expression profiles between drug-response groups](#differences-in-gene-expression-profiles-between-drug-response-groups)
  + [14.1 Cytokine / chemokine expression in mTOR group](#cytokine-chemokine-expression-in-mtor-group)
* [15 Response to cytokines in CLL](#response-to-cytokines-in-cll)
* [16 Gene set enrichment analysis on BTK, mTOR, MEK groups](#gene-set-enrichment-analysis-on-btk-mtor-mek-groups)
  + [16.1 Preprocessing RNAseq data](#preprocessing-rnaseq-data)
  + [16.2 Differential gene expression](#differential-gene-expression)
  + [16.3 Gene set enrichment analysis](#gene-set-enrichment-analysis)
    - [16.3.1 Functions for enrichment analysis and plots](#functions-for-enrichment-analysis-and-plots)
    - [16.3.2 Geneset enrichment based on Hallmark set (H)](#geneset-enrichment-based-on-hallmark-set-h)
    - [16.3.3 Geneset enrichment based on oncogenic signature set (C6)](#geneset-enrichment-based-on-oncogenic-signature-set-c6)
  + [16.4 Everolimus response VS gene expression (within mTOR group)](#everolimus-response-vs-gene-expression-within-mtor-group)
    - [16.4.1 Correlation test](#correlation-test)
    - [16.4.2 Enrichment heatmaps for mTOR group with overlapped genes indicated](#enrichment-heatmaps-for-mtor-group-with-overlapped-genes-indicated)
  + [16.5 Ibrutinib response VS gene expression (within BTK group)](#ibrutinib-response-vs-gene-expression-within-btk-group)
    - [16.5.1 Correlation test](#correlation-test-1)
    - [16.5.2 Enrichment heatmaps for BTK group with overlapped genes indicated](#enrichment-heatmaps-for-btk-group-with-overlapped-genes-indicated)
    - [16.5.3 Selumetinib response VS gene expression (within MEK group)](#selumetinib-response-vs-gene-expression-within-mek-group)
    - [16.5.4 Correlation test](#correlation-test-2)
    - [16.5.5 Enrichment heatmaps for MEK group](#enrichment-heatmaps-for-mek-group)
* [17 Single associations of drug response with gene mutation or type of disease (IGHV included)](#single-associations-of-drug-response-with-gene-mutation-or-type-of-disease-ighv-included)
  + [17.1 Function which test associations of interest](#function-which-test-associations-of-interest)
  + [17.2 Associations of *ex vivo* drug responses with genomic features in CLL](#associations-of-ex-vivo-drug-responses-with-genomic-features-in-cll)
    - [17.2.1 Prepare objects for testing](#prepare-objects-for-testing)
    - [17.2.2 Assesment of importance of batch effect](#assesment-of-importance-of-batch-effect)
    - [17.2.3 Associations of drug response with mutations in CLL](#associations-of-drug-response-with-mutations-in-cll)
    - [17.2.4 Volcano plots: summary of the results](#volcano-plots-summary-of-the-results)
  + [17.3 Associations of drug responses with genomic features in CLL independently of IGHV status](#associations-of-drug-responses-with-genomic-features-in-cll-independently-of-ighv-status)
  + [17.4 Drug response dependance on cell origin of disease](#drug-response-dependance-on-cell-origin-of-disease)
* [18 Effect of mutation on drug response - examples](#effect-of-mutation-on-drug-response---examples)
* [19 Associations of drug responses with mutations in CLL (IGHV not included)](#associations-of-drug-responses-with-mutations-in-cll-ighv-not-included)
  + [19.1 Additional functions](#additional-functions-1)
  + [19.2 Data setup](#data-setup)
  + [19.3 Test for drug-gene associations](#test-for-drug-gene-associations)
  + [19.4 Plot results](#plot-results)
    - [19.4.1 Main Figure](#main-figure)
    - [19.4.2 Supplementary Figure (incl. pretreatment)](#supplementary-figure-incl.-pretreatment)
  + [19.5 Comparison of \(P\)-Values](#comparison-of-p-values)
* [20 Association between HSP90 inhibitor response and IGHV status](#association-between-hsp90-inhibitor-response-and-ighv-status)
* [21 Association between MEK/ERK inhibitor response and trisomy12](#association-between-mekerk-inhibitor-response-and-trisomy12)
* [22 Expression profiling analysis of trisomy 12](#expression-profiling-analysis-of-trisomy-12)
  + [22.1 Differential gene expression analysis using DESeq2](#differential-gene-expression-analysis-using-deseq2)
    - [22.1.1 Heatmap plot of differentially expressed genes](#heatmap-plot-of-differentially-expressed-genes)
  + [22.2 Gene set enrichment analysis](#gene-set-enrichment-analysis-1)
    - [22.2.1 Perform enrichment analysis](#perform-enrichment-analysis)
    - [22.2.2 Heatmap for selected gene sets](#heatmap-for-selected-gene-sets)
* [23 Drug response prediction](#drug-response-prediction)
  + [23.1 Assesment of omics capacity in explaining drug response](#assesment-of-omics-capacity-in-explaining-drug-response)
    - [23.1.1 Data pre-processing](#data-pre-processing)
    - [23.1.2 Lasso using multi-omic data](#lasso-using-multi-omic-data)
  + [23.2 Lasso for drugs in a genetic-focussed model](#lasso-for-drugs-in-a-genetic-focussed-model)
    - [23.2.1 General definitions](#general-definitions)
    - [23.2.2 Data pre-processing](#data-pre-processing-1)
    - [23.2.3 Drug response prediction](#drug-response-prediction-1)
    - [23.2.4 Effect of pre-treatment](#effect-of-pre-treatment)
* [24 Survival analysis](#survival-analysis)
  + [24.1 Univariate survival analysis](#univariate-survival-analysis)
    - [24.1.1 Define forest functions](#define-forest-functions)
    - [24.1.2 Forest plot for genetic factors](#forest-plot-for-genetic-factors)
    - [24.1.3 Forest plot for drug responses](#forest-plot-for-drug-responses)
  + [24.2 Kaplan-Meier curves](#kaplan-meier-curves)
    - [24.2.1 Genetics factors](#genetics-factors)
    - [24.2.2 Drug responses](#drug-responses)
  + [24.3 Multivariate Cox-model](#multivariate-cox-model)
    - [24.3.1 Chemotherapies](#chemotherapies)
    - [24.3.2 Targeted therapies](#targeted-therapies)
* [25 End of session](#end-of-session)

# 1 Introduction

`Biocpkg("BloodCancerMultiOmics2017")` is a multi-omic dataset comprising genome, transcriptome, DNA methylome data together with data from the *ex vivo* drug sensitivity screen of the primary blood tumor samples.

---

In this vignette we present the analysis of the Primary Blood Cancer Encyclopedia (PACE) project and source code for the paper

**Drug-perturbation-based stratification of blood cancer**

Sascha Dietrich\*, Małgorzata Oleś\*, Junyan Lu\*,
Leopold Sellner, Simon Anders, Britta Velten, Bian Wu, Jennifer Hüllein, Michelle da Silva Liberio, Tatjana Walther, Lena Wagner, Sophie Rabe, Sonja Ghidelli-Disse, Marcus Bantscheff, Andrzej K. Oleś, Mikołaj Słabicki, Andreas Mock, Christopher C. Oakes, Shihui Wang, Sina Oppermann, Marina Lukas, Vladislav Kim, Martin Sill, Axel Benner, Anna Jauch, Lesley Ann Sutton, Emma Young, Richard Rosenquist, Xiyang Liu, Alexander Jethwa, Kwang Seok Lee, Joe Lewis, Kerstin Putzker, Christoph Lutz, Davide Rossi, Andriy Mokhir, Thomas Oellerich, Katja Zirlik, Marco Herling, Florence Nguyen-Khac, Christoph Plass, Emma Andersson, Satu Mustjoki, Christof von Kalle, Anthony D. Ho, Manfred Hensel, Jan Dürig, Ingo Ringshausen, Marc Zapatka,
Wolfgang Huber and Thorsten Zenz

*J. Clin. Invest.* (2018); 128(1):427–445. doi:10.1172/JCI93801.

The presented analysis was done by Małgorzata Oleś, Sascha Dietrich, Junyan Lu, Britta Velten, Andreas Mock, Vladislav Kim and Wolfgang Huber.

*This vignette was put together by Małgorzata Oleś.*

This vignette is build from the sub-vignettes, which each can be build separately. The parts are separated by the horizontal lines. Each part finishes with removal of all the created objects.

```
library("AnnotationDbi")
library("abind")
library("beeswarm")
library("Biobase")
library("biomaRt")
library("broom")
library("colorspace")
library("cowplot")
library("dendsort")
library("DESeq2")
library("doParallel")
library("dplyr")
library("foreach")
library("forestplot")
library("genefilter")
library("ggbeeswarm")
library("ggdendro")
library("ggplot2")
#library("ggtern")
library("glmnet")
library("grid")
library("gridExtra")
library("gtable")
library("hexbin")
# library("IHW")
library("ipflasso")
library("knitr")
library("limma")
library("magrittr")
library("maxstat")
library("nat")
library("org.Hs.eg.db")
library("BloodCancerMultiOmics2017")
library("pheatmap")
library("piano")
library("readxl")
library("RColorBrewer")
library("reshape2")
library("Rtsne")
library("scales")
library("SummarizedExperiment")
library("survival")
library("tibble")
library("tidyr")
library("xtable")
```

---

```
options(stringsAsFactors=FALSE)
```

# 2 Characteristics of drugs and patients in the study

Loading the data.

```
data("drpar", "drugs", "patmeta", "mutCOM")
```

Creating vectors of patient samples and drugs within the drug screen. Within drugs, we omit the statistics for one drug combination, due to lack of possibility to assign its targets.

```
# PATIENTS
patM = colnames(drpar)

# DRUGS
drM = rownames(drpar)
drM = drM[!drM %in% "D_CHK"] # remove combintation of 2 drugs: D_CHK
```

General plotting parameters.

```
bwScale = c("0"="white","1"="black","N.A."="grey90")
lfsize = 16 # legend font size
```

## 2.1 Drugs

Categorize the drugs.

```
drugs$target_category = as.character(drugs$target_category)
drugs$group = NA
drugs$group[which(drugs$approved_042016==1)] = "FDA approved"
drugs$group[which(drugs$devel_042016==1)] = "clinical development/\ntool compound"
```

Show the characteristics.

| FDA approved| clinical development/

| tool compound |  |  |
| --- | --- | --- |
| DNA damage response | 4 | 12 |
| EGFR | 3 | 0 |
| Other | 3 | 4 |
| ALK | 1 | 1 |
| Angiogenesis | 1 | 0 |
| Apoptosis (BH3, Survivin) | 1 | 2 |
| B-cell receptor | 1 | 5 |
| BCR/ABL | 1 | 0 |
| Epigenome | 1 | 2 |
| Hedgehog signaling | 1 | 0 |
| Immune modulation | 1 | 0 |
| JAK/STAT | 1 | 2 |
| MAPK | 1 | 7 |
| PI3K/AKT | 1 | 5 |
| Proteasome | 1 | 1 |
| mTOR | 1 | 1 |
| Cell cycle control | 0 | 6 |
| Cytoskeleton | 0 | 2 |
| HSP90 | 0 | 1 |
| MET | 0 | 1 |
| Mitochondrial metabolism | 0 | 2 |
| NFkB | 0 | 2 |
| NOTCH | 0 | 1 |
| PIM | 0 | 1 |
| PKC | 0 | 3 |
| Reactive oxygen species | 0 | 3 |
| Splicing | 0 | 1 |
| TGF | 0 | 1 |
| WNT | 0 | 1 |

![](data:image/png;base64...)

![](data:image/png;base64...)

## 2.2 Patient samples

Show number of samples stratified by the diagnosis.

| Var1 | Freq |
| --- | --- |
| CLL | 184 |
| T-PLL | 25 |
| MCL | 10 |
| MZL | 6 |
| AML | 5 |
| LPL | 4 |
| B-PLL | 3 |
| HCL | 3 |
| hMNC | 3 |
| HCL-V | 2 |
| Sezary | 2 |
| FL | 1 |
| PTCL-NOS | 1 |

```
## Warning in geom_bar(data = plotDF, aes(x = Diagnosis, y = NO, fill = Origin), :
## Ignoring unknown parameters: `size`
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the BloodCancerMultiOmics2017
##   package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: The `size` argument of `element_rect()` is deprecated as of ggplot2 3.4.0.
## ℹ Please use the `linewidth` argument instead.
## ℹ The deprecated feature was likely used in the BloodCancerMultiOmics2017
##   package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

![](data:image/png;base64...)

Within CLL group, we now show mutations with occurred in at least 4 samples.

```
# select CLL samples
patM = patM[patmeta[patM,"Diagnosis"]=="CLL"]

ighv = factor(setNames(patmeta[patM,"IGHV"], nm=patM), levels=c("U","M"))

mut1 = c("del17p13", "del11q22.3", "trisomy12", "del13q14_any")
mut2 = c("TP53", "ATM", "SF3B1", "NOTCH1", "MYD88")

mc = assayData(mutCOM)$binary[patM,]

## SELECTION OF MUTATIONS
# # include mutations with at least incidence of 4
mut2plot = names(which(sort(colSums(mc, na.rm=TRUE), decreasing=TRUE)>3))

# remove chromothrypsis
mut2plot = mut2plot[-grep("Chromothripsis", mut2plot)]
# divide mutations into gene mut and cnv
mut2plotSV = mut2plot[grep("[[:lower:]]", mut2plot)]
mut2plotSP = mut2plot[grep("[[:upper:]]", mut2plot)]

# remove some other things (it is quite manual thing, so be careful)
# IF YOU WANT TO REMOVE SOME MORE MUTATIONS JUST ADD THE LINES HERE!
mut2plotSV = mut2plotSV[-grep("del13q14_mono", mut2plotSV)]
mut2plotSV = mut2plotSV[-grep("del13q14_bi", mut2plotSV)]
mut2plotSV = mut2plotSV[-grep("del14q24.3", mut2plotSV)]

# rearrange the top ones to match the order in mut1 and mut2
mut2plotSV = c(mut1, mut2plotSV[!mut2plotSV %in% mut1])
mut2plotSP = c(mut2, mut2plotSP[!mut2plotSP %in% mut2])

factors = data.frame(assayData(mutCOM)$binary[patM, c(mut2plotSV, mut2plotSP)],
                     check.names=FALSE)
# change del13q14_any to del13q14
colnames(factors)[which(colnames(factors)=="del13q14_any")] = "del13q14"
mut2plotSV = gsub("del13q14_any", "del13q14", mut2plotSV)
# change it to factors
for(i in 1:ncol(factors)) {
  factors[,i] = factor(factors[,i], levels=c(1,0))
}

ord = order(factors[,1], factors[,2], factors[,3], factors[,4], factors[,5],
            factors[,6], factors[,7], factors[,8], factors[,9], factors[,10],
            factors[,11], factors[,12], factors[,13], factors[,14],
            factors[,15], factors[,16], factors[,17], factors[,18],
            factors[,19], factors[,20], factors[,21], factors[,22],
            factors[,23], factors[,24], factors[,25], factors[,26],
            factors[,27], factors[,28], factors[,29], factors[,30],
            factors[,31], factors[,32])

factorsord = factors[ord,]
patM = patM[ord]

(c(mut2plotSV, mut2plotSP))
```

```
##  [1] "del17p13"   "del11q22.3" "trisomy12"  "del13q14"   "del8p12"
##  [6] "gain2p25.3" "gain8q24"   "del6q21"    "gain3q26"   "del9p21.3"
## [11] "del15q15.1" "del6p21.2"  "TP53"       "ATM"        "SF3B1"
## [16] "NOTCH1"     "MYD88"      "BRAF"       "KRAS"       "EGR2"
## [21] "MED12"      "PCLO"       "MGA"        "ACTN2"      "BIRC3"
## [26] "CPS1"       "FLRT2"      "KLHL6"      "NFKBIE"     "RYR2"
## [31] "XPO1"       "ZC3H18"
```

Let’s now look deeper and for each mutation. We ask how many samples have (1) or don’t have (0) a particular mutation.

```
plotDF = meltWholeDF(factorsord)
plotDF$Mut =
  ifelse(sapply(plotDF$X,
                function(x) grep(x, list(mut2plotSV, mut2plotSP)))==1,"SV","SP")
plotDF$Status = "N.A."
plotDF$Status[plotDF$Measure==1 & plotDF$Mut=="SV"] = "1a"
plotDF$Status[plotDF$Measure==1 & plotDF$Mut=="SP"] = "1b"
plotDF$Status[plotDF$Measure==0] = "0"
plotDF$Status = factor(plotDF$Status, levels=c("1a","1b","0","N.A."))

plotDF$Y = factor(plotDF$Y, levels=patM)
plotDF$X = factor(plotDF$X, levels=rev(colnames(factorsord)))

mutPL = ggplotGrob(
  ggplot(data=plotDF, aes(x=Y, y=X, fill=Status)) + geom_tile() +
    scale_fill_manual(
      values=c("0"="white","1a"="forestgreen","1b"="navy","N.A."="grey90"),
      name="Mutation", labels=c("CNV","Gene mutation","WT","NA")) +
    ylab("") + xlab("") +
    geom_vline(xintercept=seq(0.5,length(patM)+1,5), colour="grey60") +
    geom_hline(yintercept=seq(0.5,ncol(factorsord)+1,1), colour="grey60") +
    scale_y_discrete(expand=c(0,0)) + scale_x_discrete(expand=c(0,0)) +
    theme(axis.ticks=element_blank(), axis.text.x=element_blank(),
          axis.text.y=element_text(
            size=60, face=ifelse(levels(plotDF$X) %in% mut2plotSV,
                                 "plain","italic")),
          axis.text=element_text(margin=unit(0.5,"cm"), colour="black"),
          legend.key = element_rect(colour = "black"),
          legend.text=element_text(size=lfsize),
          legend.title=element_text(size=lfsize)))
```

```
## Warning: The `margin` argument should be constructed using the `margin()`
## function.
```

```
## Warning: Vectorized input to `element_text()` is not officially supported.
## ℹ Results may be unexpected or may change in future versions of ggplot2.
```

```
res = table(plotDF[,c("X","Measure")])
knitr::kable(res[order(res[,2], decreasing=TRUE),])
```

|  | 0 | 1 |
| --- | --- | --- |
| del13q14 | 69 | 106 |
| TP53 | 142 | 36 |
| del11q22.3 | 146 | 28 |
| trisomy12 | 146 | 27 |
| del17p13 | 150 | 27 |
| SF3B1 | 152 | 26 |
| NOTCH1 | 160 | 19 |
| ATM | 89 | 11 |
| BRAF | 169 | 10 |
| KRAS | 136 | 8 |
| del8p12 | 131 | 8 |
| gain8q24 | 162 | 7 |
| gain2p25.3 | 132 | 7 |
| PCLO | 94 | 6 |
| MED12 | 94 | 6 |
| EGR2 | 94 | 6 |
| del6q21 | 163 | 6 |
| MGA | 95 | 5 |
| MYD88 | 173 | 5 |
| del15q15.1 | 134 | 5 |
| del9p21.3 | 134 | 5 |
| gain3q26 | 134 | 5 |
| ZC3H18 | 96 | 4 |
| XPO1 | 96 | 4 |
| RYR2 | 96 | 4 |
| NFKBIE | 96 | 4 |
| KLHL6 | 96 | 4 |
| FLRT2 | 96 | 4 |
| CPS1 | 96 | 4 |
| BIRC3 | 96 | 4 |
| ACTN2 | 96 | 4 |
| del6p21.2 | 135 | 4 |

In the last part, we characterize samples according to metadata categories.

**Age**

```
ageDF = data.frame(Factor="Age",
                   PatientID=factor(patM, levels=patM),
                   Value=patmeta[patM,c("Age4Main")])

agePL = ggplotGrob(
  ggplot(ageDF, aes(x=PatientID, y=Factor, fill=Value)) + geom_tile() +
    scale_fill_gradient(low = "gold", high = "#3D1F00", na.value="grey92",
                        name="Age", breaks=c(40,60,80)) +
    theme(axis.ticks=element_blank(),
          axis.text=element_text(size=60, colour="black",
                                 margin=unit(0.5,"cm")),
          legend.text=element_text(size=lfsize),
          legend.title=element_text(size=lfsize)))
```

```
## Warning: The `margin` argument should be constructed using the `margin()`
## function.
```

```
hist(ageDF$Value, col="slategrey", xlab="Age", main="")
```

![](data:image/png;base64...)

**Sex**

```
sexDF = data.frame(Factor="Sex", PatientID=factor(patM, levels=patM),
                   Value=patmeta[patM, "Gender"])

sexPL = ggplotGrob(
  ggplot(sexDF, aes(x=PatientID, y=Factor, fill=Value)) + geom_tile() +
    scale_fill_manual(values=c("f"="maroon","m"="royalblue4","N.A."="grey90"),
                      name="Sex", labels=c("Female","Male","NA")) +
    theme(axis.ticks=element_blank(),
          axis.text=element_text(size=60, colour="black",
                                 margin=unit(0.5,"cm")),
          legend.key = element_rect(colour = "black"),
          legend.text=element_text(size=lfsize),
          legend.title=element_text(size=lfsize)))
```

```
## Warning: The `margin` argument should be constructed using the `margin()`
## function.
```

```
table(sexDF$Value)
```

```
##
##   f   m
##  76 108
```

**Treatment**

Number of samples treated (1) or not treated (0) before sampling.

```
treatDF = data.frame(Factor="Treated", PatientID=factor(patM, levels=patM),
                     Value=ifelse(patmeta[patM, "IC50beforeTreatment"], 0, 1))
treatDF$Value[is.na(treatDF$Value)] = "N.A."
treatDF$Value = factor(treatDF$Value, levels=c("0","1","N.A."))

treatPL = ggplotGrob(
  ggplot(treatDF, aes(x=PatientID, y=Factor, fill=Value)) +geom_tile() +
    scale_fill_manual(values=bwScale, name="Treated",
                      labels=c("0"="No","1"="Yes","N.A."="NA")) +
    theme(axis.ticks=element_blank(),
          axis.text=element_text(size=60, colour="black",
                                 margin=unit(0.5,"cm")),
          legend.key = element_rect(colour = "black"),
          legend.text=element_text(size=lfsize),
          legend.title=element_text(size=lfsize)))
```

```
## Warning: The `margin` argument should be constructed using the `margin()`
## function.
```

```
table(treatDF$Value)
```

```
##
##    0    1 N.A.
##  131   52    1
```

**IGHV status**

Number of samples with (1) and without (0) the IGHV mutation.

```
ighvDF = data.frame(Factor="IGHV", PatientID=factor(patM, levels=patM),
                    Value=patmeta[patM, "IGHV"])
ighvDF$Value = ifelse(ighvDF$Value=="M", 1, 0)
ighvDF$Value[is.na(ighvDF$Value)] = "N.A."
ighvDF$Value = factor(ighvDF$Value, levels=c("0","1","N.A."))

ighvPL = ggplotGrob(
  ggplot(ighvDF, aes(x=PatientID, y=Factor, fill=Value)) + geom_tile() +
    scale_fill_manual(values=bwScale, name="IGHV",
                      labels=c("0"="Unmutated","1"="Mutated","N.A."="NA")) +
    theme(axis.ticks=element_blank(),
          axis.text=element_text(size=60, colour="black", margin=unit(0.5,"cm")),
          legend.key=element_rect(colour = "black"),
          legend.text=element_text(size=lfsize),
          legend.title=element_text(size=lfsize)))
```

```
## Warning: The `margin` argument should be constructed using the `margin()`
## function.
```

```
table(ighvDF$Value)
```

```
##
##    0    1 N.A.
##   74   98   12
```

![](data:image/png;base64...)

![](data:image/png;base64...)

# 3 Data quality control

We performed multiple checks on the data quality. Below we show two examples.

First, we compared the values of ATP luminescence of DMSO controls at the beginning and after 48 h of incubation. Second, we assessed reproducibility of the drug screening platform.

## 3.1 Comparison of ATP luminescence of DMSO controls at timepoint 0 and 48 h

The ATP luminescence of the samples were measured on day 0. We compared this value with the ATP luminescence of negative control wells at 48 h, in order to assess the cell viability change without drug treatment during 48 h culturing.

Loading the data.

```
data("lpdAll")
```

Prepare table for plot.

```
plotTab = pData(lpdAll) %>%
  transmute(x=log10(ATPday0), y=log10(ATP48h), diff=ATP48h/ATPday0) %>%
  filter(!is.na(x))
```

Scatter plot to show the the correlation of ATP luminescence between day0 and 48h.

```
lm_eqn <- function(df){
    m <- lm(y ~ 1, df, offset = x)
    ypred <- predict(m, newdata = df)
    r2 = sum((ypred - df$y)^2)/sum((df$y - mean(df$y)) ^ 2)
    eq <- substitute(italic(y) == italic(x) + a*","~~italic(r)^2~"="~r2,
         list(a = format(coef(m)[1], digits = 2),
             r2 = format(r2, digits = 2)))
    as.character(as.expression(eq))
}

plotTab$ypred <- predict(lm(y~1,plotTab, offset = x), newdata = plotTab)
sca <- ggplot(plotTab, aes(x= x, y = y)) + geom_point(size=3) +
  geom_smooth(data = plotTab, mapping = aes(x=x, y = ypred), method = lm, se = FALSE, formula = y ~ x) +
  geom_text(x = 5.2, y = 6.2, label = lm_eqn(plotTab), parse = TRUE, size =8) +
  xlab("log10(day0 ATP luminescence)") + ylab("log10(48h ATP luminescence)") +
  theme_bw() + theme(axis.title = element_text(size = 15, face = "bold"),
                     axis.text = element_text(size=15), legend.position = "none") +
  coord_cartesian(xlim = c(4.6,6.3), ylim = c(4.6,6.3))
```

Histogram of the difference between day0 and 48h ATP level.

```
histo <- ggplot(plotTab, aes(x = diff)) + geom_histogram(col = "red", fill = "red", bins=30, alpha = 0.5) + theme_bw() +
  theme(axis.title = element_text(size = 15, face = "bold"), axis.text = element_text(size=15), legend.position = "none") +
  xlab("(48h ATP luminescence) / (day0 ATP luminescence)")
```

Combine plots together.

```
grid.arrange(sca, histo, ncol=2)
```

![](data:image/png;base64...)

## 3.2 Reproducibility of the drug screening platform

Drug screening platform tested three samples twice. Moreover, the measurements were taken in the two time points: 48 h and 72 h after drug treatment. Here we compare the reproducibility of the screening platform by calculating Pearson correlation coefficients for the each pair of replicates.

Loading the data.

```
data("day23rep")
```

Arranging the data.

```
maxXY = 125

plottingDF = do.call(rbind, lapply(c("day2","day3"), function(day) {
  tmp = merge(
    meltWholeDF(assayData(day23rep)[[paste0(day,"rep1")]]),
    meltWholeDF(assayData(day23rep)[[paste0(day,"rep2")]]),
    by=c("X","Y"))
  colnames(tmp) = c("PatientID", "DrugID", "ViabX", "ViabY")
  tmp[,c("ViabX", "ViabY")] = tmp[,c("ViabX", "ViabY")] * 100
  tmp$Day = ifelse(day=="day2", "48h", "72h")
  tmp
}))

plottingDF$Shape =
  ifelse(plottingDF$ViabX > maxXY | plottingDF$ViabY > maxXY, "B", "A")
```

Calculate the Pearson correlation coefficient.

```
annotation =
  do.call(rbind,
          tapply(1:nrow(plottingDF),
                 paste(plottingDF$PatientID,
                       plottingDF$Day, sep="_"),
                 function(idx) {
                   data.frame(X=110, Y=10,
                              Shape="A",
                              PatientID=plottingDF$PatientID[idx[1]],
                              Day=plottingDF$Day[idx[1]],
                              Cor=cor(plottingDF$ViabX[idx],
                                      plottingDF$ViabY[idx],
                                      method="pearson"))
}))
```

Plot the correlations together with coefficients (in a bottom-right corner).

```
#FIG# S31
ggplot(data=plottingDF,
       aes(x=ifelse(ViabX>maxXY,maxXY,ViabX), y=ifelse(ViabY>maxXY,maxXY,ViabY),
           shape=Shape)) +
  facet_grid(Day ~ PatientID) + theme_bw() +
  geom_hline(yintercept=100, linetype="dashed",color="darkgrey") +
  geom_vline(xintercept=100, linetype="dashed",color="darkgrey") +
  geom_abline(intercept=0, slope=1, colour="grey") +
  geom_point(size=1.5, alpha=0.6) +
  scale_x_continuous(limits=c(0,maxXY), breaks=seq(0,maxXY,25)) +
  scale_y_continuous(limits=c(0,maxXY), breaks=seq(0,maxXY,25)) +
  xlab("% viability - replicate 1") + ylab("% viability - replicate 2") +
  coord_fixed() + expand_limits(x = 0, y = 0) +
  theme(axis.title.x=element_text(size = rel(1), vjust=-1),
        axis.title.y=element_text(size = rel(1), vjust=1),
        strip.background=element_rect(fill="gainsboro")) +
  guides(shape=FALSE, size=FALSE) +
  geom_text(data=annotation,
            aes(x=X, y=Y, label=format(Cor, digits=2), size=1.2),
            colour="maroon", hjust=0.2)
```

```
## Warning: The `<scale>` argument of `guides()` cannot be `FALSE`. Use "none" instead as
## of ggplot2 3.3.4.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

The reproducibility of the measurements is high (mean 0.84).

---

```
options(stringsAsFactors=FALSE)
```

# 4 Drug-induced effects on cell viability

Loading the data.

```
data("lpdAll")
```

Here we show a relative cell viability (as compared to negative control) under treatment with 64 drugs at 5 concentrations steps each.

Prepare data.

```
#select drug screening data on patient samples
lpd <- lpdAll[fData(lpdAll)$type == "viab", pData(lpdAll)$Diagnosis != "hMNC"]
viabTab <- Biobase::exprs(lpd)
viabTab <- viabTab[,complete.cases(t(viabTab))]
viabTab <- reshape2::melt(viabTab)
viabTab$Concentration <- fData(lpd)[viabTab$Var1,"subtype"]
viabTab <- viabTab[viabTab$Concentration %in% c("1","2","3","4","5"),]
viabTab$drugName <- fData(lpd)[viabTab$Var1,"name"]
viabTab <- viabTab[order(viabTab$Concentration),]

#order drug by mean viablitity
drugOrder <- group_by(viabTab, drugName) %>%
  summarise(meanViab = mean(value)) %>%
  arrange(meanViab)
viabTab$drugName <- factor(viabTab$drugName, levels = drugOrder$drugName)
```

Scatter plot for viabilities and using colors for concentrations.
![](data:image/png;base64...)

The plot shows high variability of effects between different drugs, from mostly lethal
(left) to mostly neutral (right), concentration dependence of effects and high variability of effects of the same drug/concentration across patients.

# 5 Drug-drug correlation

We compared response patterns produced by drugs using phenotype clustering within diseases (CLL, T-PLL and MCL) using Pearson correlation analysis. The results imply that the drug assays probe tumor cells’ specific dependencies on survival pathways.

Loading the data.

```
data("drpar", "patmeta", "drugs")
```

## 5.1 Additional processing functions and parameters

Function that return the subset of samples for a given diagnosis (or all samples if diag=NA).

```
givePatientID4Diag = function(pts, diag=NA) {
  pts = if(is.na(diag)) {
    names(pts)
  } else {
    names(pts[patmeta[pts,"Diagnosis"]==diag])
  }
  pts
}
```

Function that returns the viability matrix for given screen (for a given channel) for patients with given diagnosis.

```
giveViabMatrix = function(diag, screen, chnnl) {
  data = if(screen=="main") drpar
          else print("Incorrect screen name.")
  pid = colnames(data)
  if(!is.na(diag))
    pid = pid[patmeta[pid,"Diagnosis"]==diag]

  return(assayData(data)[[chnnl]][,pid])
}
```

Color scales for the heat maps.

```
palette.cor1 = c(rev(brewer.pal(9, "Blues"))[1:8],
                 "white","white","white","white",brewer.pal(7, "Reds"))
palette.cor2 = c(rev(brewer.pal(9, "Blues"))[1:8],
                 "white","white","white","white",brewer.pal(7, "YlOrRd"))
```

## 5.2 CLL/T-PLL

Pearson correlation coefficients were calculated based on the mean drug response for the two lowest concentration steps in the main screen and across CLL and T-PLL samples separately. Square correlation matrices were plotted together, with CLL in lower triangle and T-PLL in upper triangle. The drugs in a heat map are ordered by hierarchical clustering applied to drug responses of CLL samples.

```
main.cll.tpll = BloodCancerMultiOmics2017:::makeCorrHeatmap(
  mt=giveViabMatrix(diag="CLL", screen="main", chnnl="viaraw.4_5"),
  mt2=giveViabMatrix(diag="T-PLL", screen="main", chnnl="viaraw.4_5"),
  colsc=palette.cor2, concNo="one")
```

```
## Warning: Vectorized input to `element_text()` is not officially supported.
## ℹ Results may be unexpected or may change in future versions of ggplot2.
```

![](data:image/png;base64...)

![](data:image/png;base64...)

The major clusters in CLL include: kinase inhibitors targeting the B cell receptor, including idelalisib (PI3K), ibrutinib (BTK), duvelisib (PI3K), PRT062607 (SYK); inhibitors of redox signalling / reactive oxygen species (MIS−43, SD07, SD51); and BH3-mimetics (navitoclax, venetoclax).

### 5.2.1 Effect of drugs with similar target

Here we compare the effect of drugs designed to target components of the same signalling pathway.

```
# select the data
mtcll = as.data.frame(t(giveViabMatrix(diag="CLL",
                                       screen="main",
                                       chnnl="viaraw.4_5")))
colnames(mtcll) = drugs[colnames(mtcll),"name"]

# function which plots the scatter plot
scatdr = function(drug1, drug2, coldot, mtNEW, min){

  dataNEW = mtNEW[,c(drug1, drug2)]
  colnames(dataNEW) = c("A", "B")

  p = ggplot(data=dataNEW,  aes(A,  B)) + geom_point(size=3, col=coldot, alpha=0.8) +
    labs(x = drug1, y = drug2) + ylim(c(min, 1.35)) +  xlim(c(min, 1.35)) +
    theme(panel.background = element_blank(),
          axis.text = element_text(size = 15),
          axis.title = element_text(size = rel(1.5)),
          axis.line.x = element_line(colour = "black", size = 0.5),
          axis.line.y = element_line(colour = "black", size = 0.5),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank()) +
    geom_smooth(method=lm) +
    geom_text(x=1, y=min+0.1,
              label=paste0("Pearson-R = ",
                           round(cor(dataNEW$A, dataNEW$B ), 2)),
              size = 5)

  return(p)
}
```

```
## `geom_smooth()` using formula = 'y ~ x'
```

![](data:image/png;base64...)

```
## `geom_smooth()` using formula = 'y ~ x'
```

![](data:image/png;base64...)

```
## `geom_smooth()` using formula = 'y ~ x'
```

![](data:image/png;base64...)

```
## `geom_smooth()` using formula = 'y ~ x'
```

![](data:image/png;base64...)

```
## `geom_smooth()` using formula = 'y ~ x'
```

![](data:image/png;base64...)

## 5.3 T-PLL

Pearson correlation coefficients were calculated based on the mean drug response for the two lowest concentration steps in the main screen across T-PLL samples.

```
main.tpll = BloodCancerMultiOmics2017:::makeCorrHeatmap(
  mt=giveViabMatrix(diag="T-PLL", screen="main", chnnl="viaraw.4_5"),
  colsc=palette.cor1, concNo="one")
```

```
## Warning: Vectorized input to `element_text()` is not officially supported.
## ℹ Results may be unexpected or may change in future versions of ggplot2.
```

![](data:image/png;base64...)

![](data:image/png;base64...)

Clusters of drugs with high correlation and anti-correlation are shown by red and blue squares, respectively.

Inhibitors of redox signaling / reactive oxygen species (MIS-43, SD07, SD51) are clustering together. Otherwise, in T-PLL samples correlations are not well pronounced.

## 5.4 MCL

Pearson correlation coefficients were calculated based on the mean drug response for the two lowest concentration steps in the main screen across MCL samples.

```
main.mcl = BloodCancerMultiOmics2017:::makeCorrHeatmap(
  mt=giveViabMatrix(diag="MCL", screen="main", chnnl="viaraw.4_5"),
  colsc=palette.cor1, concNo="one")
```

```
## Warning: Vectorized input to `element_text()` is not officially supported.
## ℹ Results may be unexpected or may change in future versions of ggplot2.
```

![](data:image/png;base64...)

![](data:image/png;base64...)

Clusters of drugs with high correlation and anti-correlation are shown by red and blue squares, respectively.

The major clusters include: kinase inhibitors of the B cell receptor, incl. idelalisib (PI3K), ibrutinib (BTK), duvelisib (PI3K), PRT062607 (SYK); inhibitors of redox signaling / reactive oxygen species (MIS-43, SD07, SD51) and BH3 mimetics (navitoclax, venetoclax).

# 6 Disease-specific drug response phenotypes

Loading the data.

```
data(list=c("lpdAll", "conctab", "patmeta"))
```

Preprocessing of drug screen data.

```
#Select rows contain drug response data
lpdSub <- lpdAll[fData(lpdAll)$type == "viab",]

#Only use samples with complete values
lpdSub <- lpdSub[,complete.cases(t(Biobase::exprs(lpdSub)))]

#Transformation of the values
Biobase::exprs(lpdSub) <- log(Biobase::exprs(lpdSub))
Biobase::exprs(lpdSub) <- t(scale(t(Biobase::exprs(lpdSub))))

#annotation for drug ID
anno <- sprintf("%s(%s)",fData(lpdSub)$name,fData(lpdSub)$subtype)
names(anno) <- rownames(lpdSub)
```

Function to run t-SNE.

```
tsneRun <- function(distMat,perplexity=10,theta=0,max_iter=5000, seed = 1000) {
  set.seed(seed)
  tsneRes <- Rtsne(distMat, perplexity = perplexity, theta = theta,
                   max_iter = max_iter, is_distance = TRUE, dims =2)
  tsneRes <- tsneRes$Y
  rownames(tsneRes) <- labels(distMat)
  colnames(tsneRes) <- c("x","y")
  tsneRes
}
```

Setting color scheme for the plot.

```
colDiagFill = c(`CLL` = "grey80",
    `U-CLL` = "grey80",
    `B-PLL`="grey80",
    `T-PLL`="#cc5352",
    `Sezary`="#cc5352",
    `PTCL-NOS`="#cc5352",
    `HCL`="#b29441",
    `HCL-V`="mediumaquamarine",
    `AML`="#addbaf",
    `MCL`="#8e65ca",
    `MZL`="#c95e9e",
    `FL`="darkorchid4",
    `LPL`="#6295cd",
    `hMNC`="pink")

colDiagBorder <- colDiagFill
colDiagBorder["U-CLL"] <- "black"
```

Sample annotation.

```
annoDiagNew <- function(patList, lpdObj = lpdSub) {
  Diagnosis <- pData(lpdObj)[patList,c("Diagnosis","IGHV Uppsala U/M")]
  DiagNew <- c()

  for (i in seq(1:nrow(Diagnosis))) {
   if (Diagnosis[i,1] == "CLL") {
      if (is.na(Diagnosis[i,2])) {
        DiagNew <- c(DiagNew,"CLL")
      } else if (Diagnosis[i,2] == "U") {
        DiagNew <- c(DiagNew,sprintf("%s-%s",Diagnosis[i,2],Diagnosis[i,1]))
      } else if (Diagnosis[i,2] == "M") {
        DiagNew <- c(DiagNew,"CLL")
      }
    } else DiagNew <- c(DiagNew,Diagnosis[i,1])
  }
  DiagNew
}
```

Calculate t-SNE and prepare data for plotting the result.

```
#prepare distance matrix
distLpd <- dist(t(Biobase::exprs(lpdSub)))

#run t-SNE
plotTab <- data.frame(tsneRun(distLpd,perplexity=25, max_iter=5000, seed=338))

#annotated patient sample
plotTab$Diagnosis <- pData(lpdSub[,rownames(plotTab)])$Diagnosis
plotTab$Diagnosis <- annoDiagNew(rownames(plotTab,lpdSub)) #consider IGHV status
plotTab$Diagnosis <- factor(plotTab$Diagnosis,levels = names(colDiagFill))
```

![](data:image/png;base64...)

## 6.1 Example: dose-response curves

Here we show dose-response curve for selected drugs and patients.

First, change concentration index into real concentrations according to `conctab`.

```
lpdPlot <- lpdAll[fData(lpdAll)$type == "viab",]
concList <- c()
for (drugID in rownames(fData(lpdPlot))) {
  concIndex <- as.character(fData(lpdPlot)[drugID,"subtype"])
  concSplit <- unlist(strsplit(as.character(concIndex),":"))
  ID <- substr(drugID,1,5)
  if (length(concSplit) == 1) {
    realConc <- conctab[ID,as.integer(concSplit)]
    concList <- c(concList,realConc)
  } else {
    realConc <- sprintf("%s:%s",
                        conctab[ID,as.integer(concSplit[1])],
                        conctab[ID,as.integer(concSplit[2])])
    concList <- c(concList,realConc)
  }
}

fData(lpdPlot)$concValue <- concList
lpdPlot <- lpdPlot[,complete.cases(t(Biobase::exprs(lpdPlot)))]
```

Select drugs and samples.

```
patDiag <- c("CLL","T-PLL","HCL","MCL")
drugID <- c("D_012_5","D_017_4","D_039_3","D_040_5","D_081_4","D_083_5")

lpdBee <- lpdPlot[drugID,pData(lpdPlot)$Diagnosis %in% patDiag]
```

Prepare the data for plot

```
lpdCurve <-
  lpdPlot[fData(lpdPlot)$name %in% fData(lpdBee)$name,
          pData(lpdPlot)$Diagnosis %in% patDiag]
lpdCurve <- lpdCurve[fData(lpdCurve)$subtype %in% seq(1,5),]
dataCurve <- data.frame(Biobase::exprs(lpdCurve))
dataCurve <- cbind(dataCurve,fData(lpdCurve)[,c("name","concValue")])
tabCurve <- melt(dataCurve,
                 id.vars = c("name","concValue"), variable.name = "patID")
tabCurve$Diagnosis <- factor(pData(lpdCurve[,tabCurve$patID])$Diagnosis,
                             levels = patDiag)
tabCurve$value <- tabCurve$value
tabCurve$concValue <- as.numeric(tabCurve$concValue)

# set order
tabCurve$name <- factor(tabCurve$name, levels = fData(lpdBee)$name)

#calculate the mean and mse for each drug+cencentration in different disease
tabGroup <- group_by(tabCurve,name,concValue,Diagnosis)
tabSum <- summarise(tabGroup,meanViab = mean(value))
```

```
## `summarise()` has grouped output by 'name', 'concValue'. You can override using
## the `.groups` argument.
```

Finally, plot dose-response curve for each selected drug.

```
#FIG# 2 C
tconc = expression("Concentration [" * mu * "M]")
fmt_dcimals <- function(decimals=0){
   # return a function responpsible for formatting the
   # axis labels with a given number of decimals
   function(x) as.character(round(x,decimals))
}

for (drugName in unique(tabSum$name)) {
  tabDrug <- filter(tabSum, name == drugName)
  p <- (ggplot(data=tabDrug, aes(x=concValue,y=meanViab, col=Diagnosis)) +
          geom_line() + geom_point(pch=16, size=4) +
          scale_color_manual(values = colDiagFill[patDiag])
        + theme_classic() +
          theme(panel.border=element_blank(),
                axis.line.x=element_line(size=0.5,
                                         linetype="solid", colour="black"),
                axis.line.y = element_line(size = 0.5,
                                           linetype="solid", colour="black"),
                legend.position="none",
                plot.title = element_text(hjust = 0.5, size=20),
                axis.text = element_text(size=15),
                axis.title = element_text(size=20)) +
          ylab("Viability") + xlab(tconc) + ggtitle(drugName) +
          scale_x_log10(labels=fmt_dcimals(2)) +
          scale_y_continuous(limits = c(0,1.3), breaks = seq(0,1.3,0.2)))
  plot(p)
}
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

## 6.2 Example: drug effects as bee swarms

```
#FIG# 2 D
lpdDiag <- lpdAll[,pData(lpdAll)$Diagnosis %in% c("CLL", "MCL", "HCL", "T-PLL")]
dr <- c("D_012_5", "D_083_5", "D_081_3", "D_040_4", "D_039_3")

m <- data.frame(t(Biobase::exprs(lpdDiag)[dr, ]), diag=pData(lpdDiag)$Diagnosis)
m <- melt(m)
```

```
## Using diag as id variables
```

```
m$lable <- 1
for (i in 1:nrow(m )) {
  m[i, "lable"] <- giveDrugLabel(as.character(m[i, "variable"]), conctab, drugs)
}

ggplot( m, aes(diag, value, color=factor(diag) ) ) +
  ylim(0,1.3) + ylab("Viability") +
  xlab("") +
  geom_boxplot(outlier.shape = NA) +
  geom_beeswarm(cex=1.4, size=1.4,alpha=0.5, color="grey80") +
  scale_color_manual("diagnosis", values=c(colDiagFill["CLL"], colDiagFill["MCL"],
                                           colDiagFill["HCL"], colDiagFill["T-PLL"])) +
  theme_bw() +
  theme(legend.position="right") +
  theme(
    panel.background =  element_blank(),
    panel.grid.minor.x =  element_blank(),
    axis.text = element_text(size=15),
    axis.title = element_text(size=15),
    strip.text = element_text(size=15)
  ) +
  facet_wrap(~ lable, ncol=1)
```

![](data:image/png;base64...)

---

# 7 Target profiling of AZD7762 and PF477736

Cell lysates of K562 cells were used. Binding affinity scores were determined proteome-wide using the kinobead assay (Bantscheff M, Eberhard D, Abraham Y, Bastuck S, Boesche M, Hobson S, Mathieson T, Perrin J, Raida M, Rau C, et al. Quantitative chemical proteomics reveals mechanisms of action of clinical ABL kinase inhibitors. Nat Biotechnol. 2007;25(9):1035-44.).

```
# AZD7762 binding affinity constants
azd = read_excel(system.file("extdata","TargetProfiling.xlsx",
                             package="BloodCancerMultiOmics2017"), sheet = 1)

# PF477736 binding affinity constants
pf = read_excel(system.file("extdata","TargetProfiling.xlsx",
                            package="BloodCancerMultiOmics2017"), sheet = 2)

# BCR tagets Proc Natl Acad Sci U S A. 2016 May 17;113(20):5688-93
pProt = read_excel(system.file("extdata","TargetProfiling.xlsx",
                               package="BloodCancerMultiOmics2017"),sheet = 3)
```

Join the results into one data frame.

```
p <- full_join(azd, pf )
```

```
## Joining with `by = join_by(gene)`
```

```
p <- full_join(p, pProt )
```

```
## Joining with `by = join_by(gene)`
```

```
pp <- p[p$BCR_effect=="Yes",]
pp <- data.frame(pp[-which(is.na(pp$BCR_effect)),])
```

```
#FIG# 2B
rownames(pp) <- 1:nrow(pp)
pp <- as.data.frame(pp)
pp <- melt(pp)
```

```
## Using gene, BCR_effect as id variables
```

```
colnames(pp)[3] <- "Drugs"
colnames(pp)[4] <- "Score"

ggplot(pp, aes(x= reorder(gene, Score), Score, colour=Drugs ) )+ geom_point(size=3) +

scale_colour_manual(values = c(makeTransparent("royalblue1", alpha = 0.75),
                               makeTransparent("royalblue4", alpha = 0.75),
                               makeTransparent("brown1", alpha = 0.55),
                               makeTransparent("brown3", alpha = 0.35)),

                    breaks = c("az10", "az2", "pf10", "pf2"),
                    labels = c("AZD7762 10 µM","AZD7762 2 µM","PF477736 10 µM","PF477736 2 µM") ) +

  ylab("Binding affinity") +

  theme_bw() + geom_hline(yintercept = 0.5) +

  theme(axis.text.x = element_text(angle = 90, hjust = 1),
        axis.title.x=element_blank() )
```

![](data:image/png;base64...)

Lower scores indicate stronger physical binding. Here, the data are shown for those proteins that had a score <0.5 in at least one assay, and that were previously identified as responders to B-cell receptor stimulation with IgM in B-cell lines (Corso J, Pan KT, Walter R, Doebele C, Mohr S, Bohnenberger H, Strobel P, Lenz C, Slabicki M, Hullein J, et al. Elucidation of tonic and activated B-cell receptor signaling in Burkitt’s lymphoma provides insights into regulation of cell survival. Proc Natl Acad Sci U S A. 2016;113(20):5688-93).

The table below shows complete data of targets identified in kinobead assays for AZD7762 and PF477736 at 2 and 10 \(\mu\)M. A target score of <0.5 indicates a good target specificity. The column BCR indicates if the protein was identified as a B-cell receptor responsive protein after IgM stimulation in Burkitt lymphoma cell lines (Corso *et al.* 2016).

```
j <- apply(p[,c("az10", "az2", "pf10", "pf2")], 1, function (x) { min(x, na.rm=FALSE) } )

p <-  p[which(j<0.5), ]
p <-  unique(p, by = p$gene)

knitr::kable(p)
```

| gene | az10 | az2 | pf10 | pf2 | BCR\_effect |
| --- | --- | --- | --- | --- | --- |
| AAK1 | 0.25 | 0.39 | 0.23 | 0.23 | No |
| ABL1 | 0.28 | 0.40 | 0.44 | 0.73 | Yes |
| AURKA | 0.89 | 0.92 | 0.48 | 0.65 | NA |
| AURKB | 0.50 | 0.52 | 0.43 | 0.52 | No |
| AXL | 0.45 | 0.68 | 0.50 | 0.68 | NA |
| BCR | 0.28 | 0.37 | 0.57 | 0.78 | No |
| BMP2K | 0.23 | 0.43 | 0.21 | 0.20 | No |
| BRSK2 | 0.37 | 0.52 | 0.62 | 0.90 | NA |
| CAMK2G | 0.48 | 0.79 | 0.60 | 1.00 | NA |
| CHEK1 | 0.28 | 0.26 | 0.29 | 0.26 | Yes |
| CHEK1 | 0.28 | 0.26 | 0.29 | 0.26 | No |
| CHEK2 | 0.17 | 0.19 | 0.24 | 0.43 | No |
| CIT | 0.56 | 0.80 | 0.40 | 0.44 | Yes |
| CSK | 0.19 | 0.32 | 0.66 | 0.93 | No |
| EGFR | 0.33 | 0.60 | 0.54 | 0.86 | NA |
| EPHA7 | 0.28 | 0.54 | 0.77 | 0.93 | NA |
| FER | 0.24 | 0.35 | 0.88 | 1.07 | No |
| FES | 0.46 | 0.72 | 0.94 | 1.04 | NA |
| FGFR2 | 0.87 | 1.02 | 0.44 | 0.65 | NA |
| FLT4 | 0.48 | 0.52 | 0.55 | 0.61 | NA |
| FRK | 0.39 | 0.69 | 0.82 | 0.95 | NA |
| FYN | 0.28 | 0.47 | 0.46 | 0.79 | No |
| GAK | 0.23 | 0.31 | 0.21 | 0.25 | No |
| HCK | 0.28 | 0.39 | 0.52 | 0.69 | Yes |
| IRAK4 | 0.25 | 0.40 | 0.56 | 0.88 | No |
| KIAA0999 | 0.40 | 0.48 | 0.41 | 0.45 | No |
| LIMK2 | 1.11 | 1.07 | 0.33 | 0.41 | No |
| LOC100128443 | 0.94 | 0.95 | 0.36 | 0.21 | No |
| LYN | 0.33 | 0.53 | 0.40 | 0.58 | Yes |
| MAP2K1 | 0.30 | 0.47 | 0.73 | 0.95 | Yes |
| MAP2K2 | 0.22 | 0.43 | 0.63 | 0.84 | Yes |
| MAP2K5 | 0.21 | 0.29 | 0.45 | 0.74 | No |
| MAP3K11 | 0.43 | 0.46 | 0.63 | 0.83 | No |
| MAP3K2 | 0.40 | 0.64 | 0.67 | 0.83 | NA |
| MAP3K3 | 0.46 | 0.71 | 1.13 | 0.94 | NA |
| MAP3K7 | 0.49 | 0.77 | 0.77 | 0.95 | NA |
| MAP4K3 | 0.29 | 0.45 | 0.47 | 0.73 | No |
| MAP4K4 | 0.25 | 0.29 | 0.58 | 0.87 | No |
| MAP4K5 | 0.27 | 0.32 | 0.37 | 0.71 | Yes |
| MAPK3 | 1.16 | 1.14 | 0.38 | 0.74 | NA |
| MARK1 | 0.25 | 0.33 | 0.36 | 0.54 | No |
| MARK2 | 0.23 | 0.35 | 0.39 | 0.54 | Yes |
| MARK2 | 0.23 | 0.35 | 0.39 | 0.54 | No |
| MARK3 | 0.26 | 0.30 | 0.37 | 0.53 | No |
| MARK4 | 0.34 | 0.55 | 0.17 | 0.24 | No |
| MERTK | 0.43 | 0.44 | 0.71 | 0.90 | No |
| MINK1 | 0.37 | 0.39 | 0.55 | 0.80 | No |
| PAK4 | 0.22 | 0.27 | 0.30 | 0.33 | No |
| PDPK1 | 0.20 | 0.30 | 0.38 | 0.58 | No |
| PKN2 | 0.34 | 0.52 | 0.36 | 0.61 | NA |
| PRKAA1 | 0.33 | 0.52 | 0.41 | 0.66 | NA |
| PRKAA2 | 0.42 | 0.65 | 0.58 | 0.85 | NA |
| PRKCD | 0.28 | 0.47 | 0.68 | 0.95 | Yes |
| PRKG1 | 0.37 | 0.71 | 0.68 | 0.96 | NA |
| PRKX | 0.25 | 0.25 | 0.10 | 0.32 | No |
| PTK2B | 0.40 | 0.68 | 0.96 | 1.07 | NA |
| RPS6KA4 | 0.54 | 0.70 | 0.45 | 0.69 | NA |
| SIK2 | 0.28 | 0.33 | 0.27 | 0.34 | No |
| SLK | 0.27 | 0.44 | 0.73 | 0.92 | Yes |
| SRC | 0.25 | 0.35 | 0.50 | 0.83 | No |
| STK10 | 0.27 | 0.41 | 0.78 | 0.94 | Yes |
| STK17A | 0.35 | 0.76 | 0.35 | 0.41 | No |
| STK3 | 0.28 | 0.37 | 0.65 | 0.87 | No |
| STK33 | 0.26 | 0.43 | 0.77 | 1.02 | No |
| STK4 | 0.20 | 0.21 | 0.65 | 0.94 | No |
| SYK | 0.30 | 0.46 | 0.70 | 0.92 | Yes |
| TGFBR2 | 0.36 | 0.36 | 0.62 | 0.78 | No |
| TNIK | 0.37 | 0.41 | 0.41 | 0.70 | No |
| TNK2 | 0.42 | 0.61 | 0.79 | 0.85 | NA |
| YES1 | 0.38 | 0.64 | 0.38 | 0.75 | NA |
| ACADM | 0.40 | 0.39 | 1.00 | 1.03 | No |
| FASN | 0.23 | 0.24 | 1.27 | 0.99 | Yes |
| PRDX2 | 0.44 | 0.49 | 1.25 | 1.07 | No |
| SOD2 | 0.44 | 0.53 | 1.45 | 1.13 | NA |
| CTSD | 0.45 | 0.49 | 1.26 | 0.95 | No |
| ANXA2 | 0.40 | 0.43 | 1.20 | 0.96 | Yes |
| AP2A1 | 0.28 | 0.48 | 0.43 | 0.45 | No |
| AP2A2 | 0.30 | 0.37 | 0.54 | 0.52 | No |
| AP2B1 | 0.26 | 0.43 | 0.19 | 0.21 | No |
| AP2M1 | 0.25 | 0.37 | 0.32 | 0.34 | No |
| AP2S1 | 0.32 | 0.45 | 0.50 | 0.49 | No |
| FDPS | 0.42 | 0.45 | 1.19 | 1.02 | No |
| GRB2 | 0.30 | 0.32 | 0.50 | 0.72 | Yes |
| INCENP | 0.24 | 0.35 | 0.41 | 0.47 | No |
| MOBKL1B | 1.03 | 0.98 | 0.45 | 0.71 | NA |
| PKP1 | 0.31 | 1.36 | 0.72 | 0.48 | No |
| PRKAB1 | 0.23 | 0.40 | 0.31 | 0.61 | No |
| PRKAB2 | 0.18 | 0.37 | 0.32 | 0.58 | No |
| PRKAG1 | 0.27 | 0.47 | 0.36 | 0.64 | No |
| PRKAG2 | 0.32 | 0.51 | 0.43 | 0.61 | NA |
| S100A7 | 0.28 | 0.29 | 1.56 | 1.02 | No |
| S100A8 | 0.16 | 0.24 | 5.77 | 1.04 | No |
| S100A9 | 0.24 | 0.42 | 2.20 | 0.84 | No |
| SERPINB12 | 0.69 | 2.30 | 0.62 | 0.48 | No |
| YJ005\_HUMAN | 0.36 | 0.46 | 0.48 | 0.50 | No |

---

# 8 Global overview of the drug response landscape

Load data

```
data("conctab", "lpdAll", "drugs", "patmeta")
lpdCLL <- lpdAll[, lpdAll$Diagnosis=="CLL"]
lpdAll = lpdAll[, lpdAll$Diagnosis!="hMNC"]
```

## 8.1 Setup

### 8.1.1 Additional functions

```
someMatch <- function(...) {
  rv <- match(...)
  if (all(is.na(rv)))
    stop(sprintf("`match` failed to match any of the following: %s",
                 paste(x[is.na(rv)], collapse=", ")))
  rv
}
```

### 8.1.2 Preprocess `IGHV gene usage`

Find the largest categories, which we will represent by colours,
and merge the others in a group `other`.

```
colnames(pData(lpdAll))
```

```
## [1] "Diagnosis"               "Gender"
## [3] "IGHV Uppsala gene usage" "IGHV Uppsala % SHM"
## [5] "IGHV Uppsala U/M"        "ATPday0"
## [7] "ATP48h"
```

```
gu    <- pData(lpdAll)$`IGHV Uppsala gene usage`
tabgu <- sort(table(gu), decreasing = TRUE)
biggestGroups <- names(tabgu)[1:5]
gu[ is.na(match(gu, biggestGroups)) & !is.na(gu) ] <- "other"
pData(lpdAll)$`IGHV gene usage` <- factor(gu, levels = c(biggestGroups, "other"))
```

### 8.1.3 Some drugs that we are particularly interested in

```
stopifnot(is.null(drugs$id))
drugs$id <- rownames(drugs)

targetedDrugNames <- c("ibrutinib", "idelalisib",  "PRT062607 HCl",
   "duvelisib", "spebrutinib", "selumetinib", "MK-2206",
   "everolimus", "encorafenib")
id1 <- safeMatch(targetedDrugNames, drugs$name)
targetedDrugs <- paste( rep(drugs[id1, "id"], each = 2), 4:5, sep="_" )

chemoDrugNames <- c("fludarabine", "doxorubicine",  "nutlin-3")
id2 <- safeMatch(chemoDrugNames, drugs$name)
chemoDrugs <- paste( rep(drugs[id2, "id"], each = 5), 3:5, sep="_" )

tzselDrugNames <- c("ibrutinib", "idelalisib", "duvelisib", "selumetinib",
    "AZD7762", "MK-2206", "everolimus", "venetoclax", "thapsigargin",
    "AT13387", "YM155", "encorafenib", "tamatinib", "ruxolitinib",
    "PF 477736", "fludarabine", "nutlin-3")
id3 <- safeMatch(tzselDrugNames, drugs$name)
tzselDrugs <- unlist(lapply(seq(along = tzselDrugNames), function(i)
  paste(drugs[id3[i], "id"],
      if (tzselDrugNames[i] %in% c("fludarabine", "nutlin-3")) 2:3 else 4:5,
    sep = "_" )))
```

### 8.1.4 Feature weighting and score for dendrogram reordering

The `weights` are used for weighting the similarity metric used in heatmap clustering.
`weights$hclust` affects the clustering of the patients.
`weights$score` affects the dendrogram reordering of the drugs.

```
bcrDrugs <- c("ibrutinib", "idelalisib", "PRT062607 HCl", "spebrutinib")
everolID <- drugs$id[ safeMatch("everolimus",  drugs$name)]
bcrID    <- drugs$id[ safeMatch(bcrDrugs, drugs$name)]

is_BCR  <-
  (fData(lpdAll)$id %in% bcrID)    & (fData(lpdAll)$subtype %in% paste(4:5))
is_mTOR <-
  (fData(lpdAll)$id %in% everolID) & (fData(lpdAll)$subtype %in% paste(4:5))

myin <- function(x, y) as.numeric( (x %in% y) & !is.na(x) )

weights1 <- data.frame(
  hclust = rep(1, nrow(lpdAll)) + 1.75 * is_mTOR,
  score  = as.numeric( is_BCR ),
  row.names = rownames(lpdAll))

weights2 <- data.frame(
  row.names = tzselDrugs,
  hclust = myin(drugs$target_category[id3], "B-cell receptor") * 0.3 + 0.7,
  score  = rep(1, length(tzselDrugs)))
```

Remove drugs that failed quality control: NSC 74859, bortezomib.

```
badDrugs <- c(bortezomib = "D_008", `NSC 74859` = "D_025")
stopifnot(identical(drugs[ badDrugs, "name"], names(badDrugs)))

candDrugs <- rownames(lpdAll)[
  fData(lpdAll)$type=="viab" & !(fData(lpdAll)$id %in% badDrugs) &
  fData(lpdAll)$subtype %in% paste(2:5)
]
```

Threshold parameters: drugs are accepted that for at least `effectNum` samples
have a viability effect less than or equal to `effectVal`. On the other hand, the
mean viability effect should not be below `viab`.

```
thresh <- list(effectVal = 0.7, effectNum = 4, viab = 0.6, maxval = 1.1)
overallMean  <- rowMeans(Biobase::exprs(lpdAll)[candDrugs, ])
nthStrongest <- apply(Biobase::exprs(lpdAll)[candDrugs, ], 1,
                      function(x) sort(x)[thresh$effectNum])
```

```
par(mfrow = c(1, 3))
hist(overallMean,  breaks = 30, col = "pink")
abline(v = thresh$viab,      col="blue")
hist(nthStrongest, breaks = 30, col = "pink")
abline(v = thresh$effectVal, col="blue")
plot(overallMean, nthStrongest)
abline(h = thresh$effectVal, v = thresh$viab, col = "blue")
```

![](data:image/png;base64...)

`seldrugs1` and `d1`: as in the version of
Figure 3A we had in the first submission to JCI. `d2`: two concentrations for each drug in `tzselDrugNames`.

```
seldrugs1 <- candDrugs[ overallMean >= thresh$viab &
                        nthStrongest <= thresh$effectVal ] %>%
            union(targetedDrugs) %>%
            union(chemoDrugs)

d1 <- Biobase::exprs(lpdAll[seldrugs1,, drop = FALSE ]) %>%
  deckel(lower = 0, upper = thresh$maxval)

d2 <- Biobase::exprs(lpdAll[tzselDrugs,, drop = FALSE ]) %>%
  deckel(lower = 0, upper = thresh$maxval)
```

We are going to scale the data. But was is the best measure of scale (or spread)? Let’s explore
different measures of spread. We’ll see that it does not seem to matter too much which one we use.
We’ll use median centering and scaling by mad.

```
spreads <- sapply(list(mad = mad, `Q95-Q05` = function(x)
  diff(quantile(x, probs = c(0.05, 0.95)))), function(s) apply(d1, 1, s))
plot( spreads )
```

![](data:image/png;base64...)

```
jj <- names(which( spreads[, "mad"] < 0.15 & spreads[, "Q95-Q05"] > 0.7))
jj
```

```
## [1] "D_041_2"
```

```
drugs[ stripConc(jj), "name" ]
```

```
## [1] "BAY 11-7085"
```

```
medianCenter_MadScale <- function(x) {
  s <- median(x)
  (x - s) / deckel(mad(x, center = s), lower = 0.05, upper = 0.2)
}

scaleDrugResp  <- function(x) t(apply(x, 1, medianCenter_MadScale))

scd1 <- scaleDrugResp(d1)
scd2 <- scaleDrugResp(d2)
```

## 8.2 Define disease groups

```
sort(table(lpdAll$Diagnosis), decreasing = TRUE)
```

```
##
##      CLL    T-PLL      MCL      MZL      AML      LPL    B-PLL      HCL
##      184       25       10        6        5        4        3        3
##    HCL-V   Sezary       FL PTCL-NOS
##        2        2        1        1
```

```
diseaseGroups <- list(
  `CLL` = c("CLL"),
  `MCL` = c("MCL"),
  `HCL` = c("HCL", "HCL-V"),
  `other B-cell` = c("B-PLL", "MZL", "LPL", "FL"),
  `T-cell` = c("T-PLL", "Sezary", "PTCL-NOS"),
  `myeloid` = c("AML"))
stopifnot(setequal(unlist(diseaseGroups), unique(lpdAll$Diagnosis)))

fdg <- factor(rep(NA, ncol(lpdAll)), levels = names(diseaseGroups))
for (i in names(diseaseGroups))
  fdg[ lpdAll$Diagnosis %in% diseaseGroups[[i]] ] <- i
lpdAll$`Disease Group` <- fdg
```

## 8.3 Code for heatmap

### 8.3.1 Matrix row / column clustering

The helper function `matClust` clusters a matrix `x`,
whose columns represent samples and whose rows represent drugs.
Its arguments control how the columns are clustered:

* `weights`: a `data.frame` with a weight for each row of `x`. The weights are used in the computation of distances
  between columns and thus for column sorting. The `data.frame`’s column `hclust` contains the weights
  for `hclust(dist())`. The column `score` contains the weights for computing the score used for dendrogram reordering.
  See `weights1` and `weights2` defined above.
* `colgroups`: a `factor` by which to first split the columns before clustering
* `reorderrows`: logical. `FALSE` for previous behaviour (old Fig. 3A), `TRUE` for reordering the row dendrogram, too.

```
matClust <- function(x,
                     rowweights,
                     colgroups   = factor(rep("all", ncol(x))),
                     reorderrows = FALSE) {

  stopifnot(is.data.frame(rowweights),
            c("hclust", "score") %in% colnames(rowweights),
            !is.null(rownames(rowweights)),
            !is.null(rownames(x)),
            all(rownames(x) %in% rownames(rowweights)),
            is.factor(colgroups),
            !any(is.na(colgroups)),
            length(colgroups) == ncol(x))

  wgt <- rowweights[ rownames(x), ]

  columnsClust <- function(xk) {
    score   <- -svd(xk * wgt[, "score"])$v[, 1]
    cmns    <- colSums(xk * wgt[, "score"])
    ## make sure that high score = high sensitivity
    if (cor(score, cmns) > 0) score <- (-score)

    ddraw  <- as.dendrogram(hclust(dist(t(xk * wgt[, "hclust"]),
                                        method = "euclidean"),
                                   method = "complete"))
    dd  <- reorder(ddraw, wts = -score, agglo.FUN = mean)
    ord <- order.dendrogram(dd)
    list(dd = dd, ord = ord, score = score)
  }

  sp <- split(seq(along = colgroups), colgroups)
  cc <- lapply(sp, function(k) columnsClust(x[, k, drop=FALSE]))
  cidx <- unlist(lapply(seq(along = cc), function (i)
    sp[[i]][ cc[[i]]$ord ]))
  csc  <- unlist(lapply(seq(along = cc), function (i)
    cc[[i]]$score[ cc[[i]]$ord ]))

  rddraw <- as.dendrogram(hclust(dist(x, method = "euclidean"),
                                   method = "complete"))
  ridx  <- if (reorderrows) {
    ww <- (colgroups == "CLL")
    stopifnot(!any(is.na(ww)), any(ww))
    rowscore <- svd(t(x) * ww)$v[, 1]
    dd <- reorder(rddraw, wts = rowscore, agglo.FUN = mean)
    order.dendrogram(dd)
  } else {
    rev(order.dendrogram(dendsort(rddraw)))
  }

  res <- x[ridx, cidx]

  stopifnot(identical(dim(res), dim(x)))
  attr(res, "colgap") <- cumsum(sapply(cc, function(x) length(x$score)))
  res
}
```

### 8.3.2 Prepare sample annotations

I.e. the right hand side color bar. `IGHV Uppsala U/M` is implied by
`IGHV Uppsala % SHM` (see sensi2.Rmd).
`cut(..., right=FALSE)` will use intervals that are closed on the left
and open on the right.

```
translation = list(IGHV=c(U=0, M=1),
                   Methylation_Cluster=c(`LP-CLL`=0, `IP-CLL`=1, `HP-CLL`=2))
```

```
make_pd <- function(cn, ...) {
  df <- function(...) data.frame(..., check.names = FALSE)

  x <- lpdAll[, cn]
  pd <- df(
    t(Biobase::exprs(x)[    c("del17p13", "TP53", "trisomy12"), , drop = FALSE]) %>%
      `colnames<-`(c("del 17p13", "TP53", "trisomy 12")))

  # pd <- df(pd,
  #    t(Biobase::exprs(x)[  c("SF3B1", "del11q22.3", "del13q14_any"),, drop = FALSE]) %>%
  #    `colnames<-`(c("SF3B1", "del11q22.3", "del13q14")))

  pd <- df(pd,
      cbind(as.integer(Biobase::exprs(x)["KRAS",] | Biobase::exprs(x)["NRAS",])) %>%
      `colnames<-`("KRAS | NRAS"))

  pd <- df(pd,
    # IGHV = Biobase::exprs(x)["IGHV Uppsala U/M", ],
    `IGHV (%)` = cut(x[["IGHV Uppsala % SHM"]],
                     breaks = c(0, seq(92, 100, by = 2), Inf), right = FALSE),
    `Meth. Cluster` = names(translation$Methylation_Cluster)[
          someMatch(paste(Biobase::exprs(x)["Methylation_Cluster", ]),
                    translation$Methylation_Cluster)],
    `Gene usage` = x$`IGHV gene usage`)

  if(length(unique(x$Diagnosis)) > 1)
    pd <- df(pd, Diagnosis = x$Diagnosis)

  pd <- df(pd,
    pretreated  = ifelse(patmeta[colnames(x),"IC50beforeTreatment"],"no","yes"),
    alive       = ifelse(patmeta[colnames(x),"died"]>0, "no", "yes"),
    sex         = factor(x$Gender))

  rownames(pd) <- colnames(Biobase::exprs(x))

  for (i in setdiff(colnames(pd), "BCR score")) {
    if (!is.factor(pd[[i]]))
      pd[[i]] <- factor(pd[[i]])
    if (any(is.na(pd[[i]]))) {
      levels(pd[[i]]) <- c(levels(pd[[i]]), "n.d.")
      pd[[i]][ is.na(pd[[i]]) ] <- "n.d."
    }
  }

  pd
}
```

### 8.3.3 Define the annotation colors

```
gucol <- rev(brewer.pal(nlevels(lpdAll$`IGHV gene usage`), "Set3")) %>%
             `names<-`(sort(levels(lpdAll$`IGHV gene usage`)))
gucol["IGHV3-21"] <- "#E41A1C"

make_ann_colors <- function(pd) {
  bw <- c(`TRUE` = "darkblue", `FALSE` = "#ffffff")
  res <- list(
  Btk = bw, Syk = bw, PI3K = bw, MEK = bw)

  if ("exptbatch" %in% colnames(pd))
    res$exptbatch <- brewer.pal(nlevels(pd$exptbatch), "Set2") %>%
    `names<-`(levels(pd$exptbatch))

  if ("IGHV (%)" %in% colnames(pd))
    res$`IGHV (%)` <-
       c(rev(colorRampPalette(
         brewer.pal(9, "Blues"))(nlevels(pd$`IGHV (%)`)-1)), "white") %>%
                        `names<-`(levels(pd$`IGHV (%)`))

  if ("CD38" %in% colnames(pd))
    res$CD38 <- colorRampPalette(
      c("blue", "yellow"))(nlevels(pd$CD38)) %>% `names<-`(levels(pd$CD38))

  if("Gene usage" %in% colnames(pd))
    res$`Gene usage` <- gucol

  if("Meth. Cluster" %in% colnames(pd))
    res$`Meth. Cluster` <- brewer.pal(9, "Blues")[c(1, 5, 9)] %>%
        `names<-`(names(translation$Methylation_Cluster))

  res <- c(res, BloodCancerMultiOmics2017:::sampleColors)   # from addons.R

  if("Diagnosis" %in% colnames(pd))
    res$Diagnosis <- BloodCancerMultiOmics2017:::colDiagS[
      names(BloodCancerMultiOmics2017:::colDiagS) %in% levels(pd$Diagnosis) ] %>%
         (function(x) x[order(names(x))])

  for(i in names(res)) {
    whnd <- which(names(res[[i]]) == "n.d.")
    if(length(whnd)==1)
      res[[i]][whnd] <- "#e0e0e0" else
        res[[i]] <- c(res[[i]], `n.d.` = "#e0e0e0")
    stopifnot(all(pd[[i]] %in% names(res[[i]])))
  }

  res
}
```

### 8.3.4 Heatmap drawing function

```
theatmap <- function(x, cellwidth = 7, cellheight = 11) {

  stopifnot(is.matrix(x))
  patDat <- make_pd(colnames(x))

  bpp <- brewer.pal(9, "Set1")
  breaks <- 2.3 * c(seq(-1, 1, length.out = 101)) %>% `names<-`(
      colorRampPalette(c(rev(brewer.pal(7, "YlOrRd")),
                         "white", "white", "white",
                         brewer.pal(7, "Blues")))(101))

  if (!is.null(attr(x, "colgap")))
    stopifnot(last(attr(x, "colgap")) == ncol(x))

  pheatmapwh(deckel(x, lower = first(breaks), upper = last(breaks)),
         cluster_rows = FALSE,
         cluster_cols = FALSE,
         gaps_col = attr(x, "colgap"),
         gaps_row = attr(x, "rowgap"),
         scale = "none",
         annotation_col = patDat,
         annotation_colors = make_ann_colors(patDat),
         color = names(breaks),
         breaks = breaks,
         show_rownames = TRUE,
         show_colnames = !TRUE,
         cellwidth = cellwidth, cellheight = cellheight,
         fontsize = 10, fontsize_row = 11, fontsize_col = 8,
         annotation_legend = TRUE, drop_levels = TRUE)
  }
```

## 8.4 Draw the heatmaps

Things we see in the plot:

* separation of U-CLL and M-CLL within CLL
* BCR-targeting drugs a cluster at the top
* everolimus stands out in M-CLL with a separate sensitivity pattern
* encorafenib clusters together and pops out in HCL

clscd1/2: **cl**ustered and **sc**aled **d**rug **mat**rix

```
clscd1 <- matClust(scd1, rowweights = weights1,
                  colgroups = lpdAll$`Disease Group`)
clscd2 <- matClust(scd2, rowweights = weights2,
                  colgroups = lpdAll$`Disease Group`, reorderrows = TRUE)
```

### 8.4.1 Identify places where gaps between the rows should be

```
setGapPositions <- function(x, gapAt) {
  rg <- if (missing(gapAt)) c(0) else {
    s <- strsplit(gapAt, split = "--")
    stopifnot(all(listLen(s) == 2L))
    s <- strsplit(unlist(s), split = ":")
    spname <- drugs[safeMatch(sapply(s, `[`, 1), drugs$name), "id"]
    spconc <- as.numeric(sapply(s, `[`, 2))
    spi <- mapply(function(d, cc) {
      i <- which(cc == conctab[d, ])
      stopifnot(length(i) == 1)
      i
     }, spname, spconc)
    spdrug <- paste(spname, spi, sep = "_")
    mt <- safeMatch(spdrug, rownames(x))
    igp <- seq(1, length(mt), by = 2L)
    stopifnot(all( mt[igp] - mt[igp + 1] == 1))
    #stopifnot(all( mt[igp] - mt[igp + 1] == 1))
    c(mt[igp + 1], 0)
  }
  attr(x, "rowgap") <- rg
  x
}

clscd1 %<>% setGapPositions(gapAt = c(
  "PF 477736:10--idelalisib:10",
  "spebrutinib:2.5--PF 477736:2.5",
  "PRT062607 HCl:10--selumetinib:2.5",
  "selumetinib:10--MK-2206:2.5",
  "MK-2206:0.156--tipifarnib:10",
  "AT13387:0.039--encorafenib:10",
  "encorafenib:2.5--SD07:1.111",
  "doxorubicine:0.016--encorafenib:0.625",
  "encorafenib:0.156--rotenone:2.5",
  "SCH 900776:0.625--everolimus:0.625",
  "everolimus:10--afatinib:1.667",
  "arsenic trioxide:1--thapsigargin:5",
  "thapsigargin:0.313--fludarabine:0.156"
))

clscd2 %<>% setGapPositions(gapAt = c(
  "AT13387:0.039--everolimus:0.156",
  "everolimus:0.625--nutlin-3:10",
  "fludarabine:10--thapsigargin:0.078",
  "thapsigargin:0.313--encorafenib:0.625",
  "encorafenib:0.156--ruxolitinib:0.156"
))
```

```
#FIG# S8
rownames(clscd1) <- with(fData(lpdAll)[ rownames(clscd1),, drop = FALSE],
  paste0(drugs[id, "name"], " ", conctab[cbind(id, paste0("c", subtype))], "uM"))
rownames(clscd1)
```

```
##   [1] "vorinostat 0.313uM"    "BAY 11-7085 10uM"      "fludarabine 0.156uM"
##   [4] "thapsigargin 0.313uM"  "thapsigargin 1.25uM"   "thapsigargin 5uM"
##   [7] "arsenic trioxide 1uM"  "nutlin-3 0.156uM"      "chaetoglobosin A 5uM"
##  [10] "nutlin-3 0.625uM"      "nutlin-3 2.5uM"        "vorinostat 1.25uM"
##  [13] "fludarabine 2.5uM"     "fludarabine 0.625uM"   "tofacitinib 10uM"
##  [16] "rigosertib 10uM"       "KX2-391 0.625uM"       "KX2-391 2.5uM"
##  [19] "afatinib 1.667uM"      "everolimus 10uM"       "everolimus 0.156uM"
##  [22] "everolimus 0.625uM"    "SCH 900776 0.625uM"    "SCH 900776 2.5uM"
##  [25] "silmitasertib 10uM"    "chaetocin 0.031uM"     "navitoclax 0.004uM"
##  [28] "orlistat 2.5uM"        "orlistat 10uM"         "venetoclax 0.004uM"
##  [31] "navitoclax 0.016uM"    "thapsigargin 0.078uM"  "rotenone 0.156uM"
##  [34] "rotenone 0.625uM"      "rotenone 2.5uM"        "encorafenib 0.156uM"
##  [37] "encorafenib 0.625uM"   "doxorubicine 0.016uM"  "doxorubicine 0.25uM"
##  [40] "doxorubicine 0.063uM"  "YM155 0.008uM"         "SD51 0.37uM"
##  [43] "SD51 1.111uM"          "MIS-43 0.37uM"         "MIS-43 1.111uM"
##  [46] "SD07 1.111uM"          "encorafenib 2.5uM"     "encorafenib 10uM"
##  [49] "AT13387 0.039uM"       "tipifarnib 2.5uM"      "tipifarnib 10uM"
##  [52] "MK-2206 0.156uM"       "MK-2206 0.625uM"       "MK-2206 2.5uM"
##  [55] "selumetinib 10uM"      "selumetinib 0.156uM"   "selumetinib 0.625uM"
##  [58] "selumetinib 2.5uM"     "PRT062607 HCl 10uM"    "BIX02188 10uM"
##  [61] "rabusertib 10uM"       "enzastaurin 10uM"      "VE-821 10uM"
##  [64] "sotrastaurin 2.5uM"    "sotrastaurin 10uM"     "saracatinib 2.5uM"
##  [67] "saracatinib 10uM"      "MK-2206 10uM"          "TAE684 2.5uM"
##  [70] "sunitinib 10uM"        "CCT241533 2.5uM"       "SGI-1776 2.5uM"
##  [73] "SGX-523 10uM"          "KU-60019 10uM"         "NU7441 10uM"
##  [76] "ibrutinib 10uM"        "KU-60019 2.5uM"        "NU7441 2.5uM"
##  [79] "PF 477736 0.625uM"     "PF 477736 2.5uM"       "spebrutinib 2.5uM"
##  [82] "spebrutinib 10uM"      "PRT062607 HCl 0.156uM" "spebrutinib 0.156uM"
##  [85] "spebrutinib 0.625uM"   "MK-1775 2.5uM"         "idelalisib 0.156uM"
##  [88] "idelalisib 0.625uM"    "idelalisib 2.5uM"      "ibrutinib 0.156uM"
##  [91] "ibrutinib 0.625uM"     "ibrutinib 2.5uM"       "tamatinib 2.5uM"
##  [94] "tamatinib 10uM"        "MK-1775 10uM"          "AZD7762 0.156uM"
##  [97] "AZD7762 0.625uM"       "BX912 2.5uM"           "dasatinib 0.156uM"
## [100] "PRT062607 HCl 0.625uM" "PRT062607 HCl 2.5uM"   "duvelisib 0.156uM"
## [103] "duvelisib 0.625uM"     "duvelisib 2.5uM"       "duvelisib 10uM"
## [106] "idelalisib 10uM"       "PF 477736 10uM"        "AZD7762 2.5uM"
## [109] "AZD7762 10uM"          "BX912 10uM"            "dasatinib 10uM"
## [112] "dasatinib 0.625uM"     "dasatinib 2.5uM"       "AT13387 0.156uM"
## [115] "AT13387 0.625uM"       "AT13387 2.5uM"
```

```
theatmap(clscd1)
```

![](data:image/png;base64...)

```
#FIG# 3A
rownames(clscd2) <- with(fData(lpdAll)[ rownames(clscd2),, drop = FALSE],
  paste0(drugs[id, "name"], " ", conctab[cbind(id, paste0("c", subtype))], "uM"))

rownames(clscd2)
```

```
##  [1] "venetoclax 0.016uM"   "venetoclax 0.004uM"   "YM155 0.031uM"
##  [4] "YM155 0.008uM"        "ruxolitinib 0.625uM"  "ruxolitinib 0.156uM"
##  [7] "encorafenib 0.156uM"  "encorafenib 0.625uM"  "thapsigargin 0.313uM"
## [10] "thapsigargin 0.078uM" "fludarabine 10uM"     "fludarabine 2.5uM"
## [13] "nutlin-3 2.5uM"       "nutlin-3 10uM"        "everolimus 0.625uM"
## [16] "everolimus 0.156uM"   "AT13387 0.039uM"      "AT13387 0.156uM"
## [19] "PF 477736 0.156uM"    "PF 477736 0.625uM"    "MK-2206 0.156uM"
## [22] "MK-2206 0.625uM"      "selumetinib 0.156uM"  "selumetinib 0.625uM"
## [25] "AZD7762 0.625uM"      "AZD7762 0.156uM"      "ibrutinib 0.156uM"
## [28] "ibrutinib 0.625uM"    "duvelisib 0.156uM"    "duvelisib 0.625uM"
## [31] "idelalisib 0.625uM"   "idelalisib 0.156uM"   "tamatinib 0.156uM"
## [34] "tamatinib 0.625uM"
```

```
theatmap(clscd2)
```

![](data:image/png;base64...)

---

```
options(stringsAsFactors=TRUE)
```

```
## Warning in options(stringsAsFactors = TRUE): 'options(stringsAsFactors = TRUE)'
## is deprecated and will be disabled
```

# 9 Relative drug effects - ternary diagrams

Ternary diagrams are a good visualisation tool to compare the relative drug effects of three selected drugs. Here we call the drugs by their targets (ibrutinib = BTK, idelalisib = PI3K, PRT062607 HCl = SYK, everolimus = mTOR and selumetinib = MEK). We compare the drug effects within CLL samples as well as U-CLL and M-CLL separatelly.

Load the data.

```
data("conctab", "lpdAll", "drugs", "patmeta")
```

Select CLL patients.

```
lpdCLL <- lpdAll[, lpdAll$Diagnosis=="CLL"]
```

## 9.1 Additional settings

Function that set the point transparency.

```
makeTransparent = function(..., alpha=0.18) {

  if(alpha<0 | alpha>1) stop("alpha must be between 0 and 1")

  alpha = floor(255*alpha)
  newColor = col2rgb(col=unlist(list(...)), alpha=FALSE)

  .makeTransparent = function(col, alpha) {
    rgb(red=col[1], green=col[2], blue=col[3], alpha=alpha, maxColorValue=255)
  }
  newColor = apply(newColor, 2, .makeTransparent, alpha=alpha)

  return(newColor)
}

giveColors = function(idx, alpha=1) {
  bp = brewer.pal(12, "Paired")
  makeTransparent(
    sequential_hcl(12, h = coords(as(hex2RGB(bp[idx]), "polarLUV"))[1, "H"])[1],
    alpha=alpha)
}
```

## 9.2 Calculating the coordinates

```
# calculate  (x+c)/(s+3c), (y+c)/(s+3c), (z+c)/(s+3c)
prepareTernaryData = function(lpd, targets, invDrugs) {

  # calculate values for ternary
  df = sapply(targets, function(tg) {
    dr = paste(invDrugs[tg], c(4,5), sep="_")
    tmp = 1-Biobase::exprs(lpd)[dr,]
    tmp = colMeans(tmp)
    pmax(tmp, 0)
  })
  df = data.frame(df, sum=rowSums(df), max=rowMax(df))

  tern = apply(df[,targets], 2, function(x) {
    (x+0.005) / (df$sum+3*0.005)
  })
  colnames(tern) = paste0("tern", 1:3)
  # add IGHV status
  cbind(df, tern, IGHV=patmeta[rownames(df),"IGHV"],
        treatNaive=patmeta[rownames(df),"IC50beforeTreatment"])
}
```

## 9.3 Plot ternaries

```
makeTernaryPlot = function(td=ternData, targets, invDrugs) {

  drn = setNames(drugs[invDrugs[targets],"name"], nm=targets)

  plot = ggtern(data=td, aes(x=tern1, y=tern2, z=tern3)) +
        #countours
        stat_density_tern(geom='polygon', aes(fill=..level..),
                          position = "identity", contour=TRUE, n=400,
                          weight = 1, base = 'identity', expand = c(1.5, 1.5)) +
        scale_fill_gradient(low='lightblue', high='red', guide = FALSE) +

        #points
        geom_mask() +
        geom_point(size=35*td[,"max"],
                   fill=ifelse(td[,"treatNaive"],"green","yellow"),
                   color="black", shape=21) +

        #themes
        theme_rgbw( ) +
        theme_custom(
          col.T=giveColors(2),
          col.L=giveColors(10),
          col.R=giveColors(4),
          tern.plot.background="white", base_size = 18 ) +

    labs( x = targets[1], xarrow = drn[targets[1]],
              y = targets[2], yarrow = drn[targets[2]],
              z = targets[3], zarrow = drn[targets[3]] ) +
              theme_showarrows() + theme_clockwise() +

        # lines
        geom_Tline(Tintercept=.5, colour=giveColors(2)) +
        geom_Lline(Lintercept=.5, colour=giveColors(10)) +
        geom_Rline(Rintercept=.5, colour=giveColors(4))

   plot
}
```

```
# RUN TERNARY
makeTernary = function(lpd, targets, ighv=NA) {

  # list of investigated drugs and their targets
  invDrugs = c("PI3K"="D_003", "BTK"="D_002", "SYK"="D_166",
               "MTOR"="D_063", "MEK"="D_012")

  ternData = prepareTernaryData(lpd, targets, invDrugs)
  if(!is.na(ighv)) ternData = ternData[which(ternData$IGHV==ighv),]

  print(table(ternData$treatNaive))
  ternPlot = makeTernaryPlot(ternData, targets, invDrugs)

  ternPlot
}
```

### 9.3.1 BCR drugs

```
#FIG# 3B
makeTernary(lpdCLL, c("PI3K", "BTK", "SYK"), ighv=NA)
```

```
#FIG# 3B
makeTernary(lpdCLL, c("PI3K", "BTK", "SYK"), ighv="M")
```

```
#FIG# 3B
makeTernary(lpdCLL, c("PI3K", "BTK", "SYK"), ighv="U")
```

### 9.3.2 BTK & MEK & MTOR

```
#FIG# 3BC
makeTernary(lpdCLL, c("MTOR", "BTK", "MEK"), ighv=NA)
```

```
#FIG# 3BC
makeTernary(lpdCLL, c("MTOR", "BTK", "MEK"), ighv="M")
```

```
#FIG# 3BC
makeTernary(lpdCLL, c("MTOR", "BTK", "MEK"), ighv="U")
```

### 9.3.3 PI3K & MEK & MTOR

All CLL samples included.

```
#FIG# S9 left
makeTernary(lpdCLL, c("MTOR", "PI3K", "MEK"), ighv=NA)
```

### 9.3.4 SYK & MEK & MTOR

All CLL samples included.

```
#FIG# S9 right
makeTernary(lpdCLL, c("MTOR", "SYK", "MEK"), ighv=NA)
```

# 10 Comparison of gene expression responses to drug treatments

12 CLL samples (6 M-CLL and 6 U-CLL) were treated with ibrutinb, idelalisib, selumetinib, everolimus and negative control. Gene expression profiling was performed after 12 hours of drug incubation using Illumina microarrays.

Load the data.

```
data("exprTreat", "drugs")
```

Do some cosmetics.

```
e <- exprTreat
colnames( pData(e) ) <- sub( "PatientID", "Patient", colnames( pData(e) ) )
colnames( pData(e) ) <- sub( "DrugID", "Drug", colnames( pData(e) ) )
pData(e)$Drug[ is.na(pData(e)$Drug) ] <- "none"
pData(e)$Drug <- relevel( factor( pData(e)$Drug ), "none" )
pData(e)$SampleID <- colnames(e)
colnames(e) <- paste( pData(e)$Patient, pData(e)$Drug, sep=":" )

head( pData(e) )
```

```
##            Patient  Drug   Sentrix_ID Sentrix_Position IGHV trisomy12 del13q14
## H112:none     H112  none 200128470091                A    M         0        0
## H112:D_002    H112 D_002 200128470091                B    M         0        0
## H112:D_003    H112 D_003 200128470091                C    M         0        0
## H112:D_012    H112 D_012 200128470091                D    M         0        0
## H112:D_063    H112 D_063 200128470091                E    M         0        0
## H112:D_049    H112 D_049 200128470091                F    M         0        0
##                  SampleID
## H112:none  200128470091_A
## H112:D_002 200128470091_B
## H112:D_003 200128470091_C
## H112:D_012 200128470091_D
## H112:D_063 200128470091_E
## H112:D_049 200128470091_F
```

Remove uninteresting fData columns

```
fData(e) <- fData(e)[ , c( "ProbeID", "Entrez_Gene_ID", "Symbol",
    "Cytoband", "Definition" ) ]
```

Here is a simple heat map of correlation between arrays.

```
pheatmap( cor(Biobase::exprs(e)), symm=TRUE, cluster_rows = FALSE, cluster_cols = FALSE,
   color = colorRampPalette(c("gray10","lightpink"))(100) )
```

![](data:image/png;base64...)

## 10.1 Differential expression using Limma

Construct a model matrix with a baseline expression per patient, treatment effects
for all drugs, and symmetric (+/- 1/2) effects for U-vs-M differences in drug effects.

```
mm <- model.matrix( ~ 0 + Patient + Drug, pData(e) )
colnames(mm) <- sub( "Patient", "", colnames(mm) )
colnames(mm) <- sub( "Drug", "", colnames(mm) )
head(mm)
```

```
##            H094 H108 H109 H112 H114 H167 H169 H173 H194 H233 H234 H238 D_002
## H112:none     0    0    0    1    0    0    0    0    0    0    0    0     0
## H112:D_002    0    0    0    1    0    0    0    0    0    0    0    0     1
## H112:D_003    0    0    0    1    0    0    0    0    0    0    0    0     0
## H112:D_012    0    0    0    1    0    0    0    0    0    0    0    0     0
## H112:D_063    0    0    0    1    0    0    0    0    0    0    0    0     0
## H112:D_049    0    0    0    1    0    0    0    0    0    0    0    0     0
##            D_003 D_012 D_049 D_063
## H112:none      0     0     0     0
## H112:D_002     0     0     0     0
## H112:D_003     1     0     0     0
## H112:D_012     0     1     0     0
## H112:D_063     0     0     0     1
## H112:D_049     0     0     1     0
```

Run LIMMA on this.

```
fit <- lmFit( e, mm )
fit <- eBayes( fit )
```

How many genes do we get that are significantly differentially expressed due to
a drug, at 10% FDR?

```
a <- decideTests( fit, p.value = 0.1 )
t( apply( a[ , grepl( "D_...", colnames(a) ) ], 2,
          function(x) table( factor(x,levels=c(-1,0,1)) ) ) )
```

```
##        -1     0   1
## D_002 245 47699 163
## D_003 198 47746 163
## D_012 276 47522 309
## D_049 372 47094 641
## D_063 419 47312 376
```

What is the % overlap of genes across drugs?

```
a <-
sapply( levels(pData(e)$Drug)[-1], function(dr1)
   sapply( levels(pData(e)$Drug)[-1], function(dr2)

   100*( length( intersect(
          unique( topTable( fit, coef=dr1, p.value=0.1,
                            number=Inf )$`Entrez_Gene_ID` ),
          unique( topTable( fit, coef=dr2, p.value=0.1,
                            number=Inf )$`Entrez_Gene_ID` ) ) ) /
                      length(unique( topTable( fit, coef=dr1, p.value=0.1,
                                               number=Inf )$`Entrez_Gene_ID`)))
     )
   )

rownames(a) <-drugs[ rownames(a), "name" ]
colnames(a) <-rownames(a)
a <- a[-4, -4]
a
```

```
##             ibrutinib idelalisib selumetinib everolimus
## ibrutinib    100.0000   50.75529    15.75985   11.84767
## idelalisib    46.5374  100.00000    19.13696   14.80959
## selumetinib   23.2687   30.81571   100.00000   20.87447
## everolimus    23.2687   31.72205    27.76735  100.00000
```

Correlate top 2000 genes with median largest lfc with each other:

1. For each patient and drug, compute the LFC (log fold changed) treated/untreated
2. Select the 2000 genes that have the highest across all patients and drugs (median absolute LFC)
3. Compute the average LFC for each drug across the patients, resulting in 4 vectors of length 2000 (one for each drug)
4. Compute the pairwise correlation between them

```
extractGenes = function(fit, coef) {
  tmp = topTable(fit, coef=coef, number=Inf )[, c("ProbeID", "logFC")]
  rownames(tmp) = tmp$ProbeID
  colnames(tmp)[2] = drugs[coef,"name"]
  tmp[order(rownames(tmp)),2, drop=FALSE]
}

runExtractGenes = function(fit, drs) {
  tmp = do.call(cbind, lapply(drs, function(dr) {
    extractGenes(fit, dr)
  }))
  as.matrix(tmp)
}

mt = runExtractGenes(fit, drs=c("D_002","D_003","D_012","D_063"))
```

```
mt <- cbind( mt, median=rowMedians(mt))
mt <- mt[order(mt[,"median"]), ]
mt <- mt[1:2000, ]
mt <- mt[,-5]
```

```
(mtcr = cor(mt))
```

```
##             ibrutinib idelalisib selumetinib everolimus
## ibrutinib   1.0000000  0.7007428   0.3171206  0.2265553
## idelalisib  0.7007428  1.0000000   0.5211315  0.4087302
## selumetinib 0.3171206  0.5211315   1.0000000  0.3889721
## everolimus  0.2265553  0.4087302   0.3889721  1.0000000
```

```
#FIG# 3D
pheatmap(mtcr, cluster_rows = FALSE, cluster_cols = FALSE,
         col=colorRampPalette(c("white", "lightblue","darkblue") )(100))
```

![](data:image/png;base64...)

# 11 Co-sensitivity patterns of the four response groups

Load data.

```
data("lpdAll", "drugs")
```

```
lpdCLL <- lpdAll[ , lpdAll$Diagnosis== "CLL"]
```

## 11.1 Methodology of building groups

Here we look at the distribution of viabilities for the three drugs concerned and use the mirror method to derive, first, a measure of the background variation of the values for these drugs (`ssd`) and then define a cutoff as multiple (`z_factor`) of that. The mirror method assumes that the observed values are a mixture of two components:

* a null distribution, which is symmetric about 1, and
* responder distribution, which has negligible mass above 1.

The choice of `z_factor` is, of course, a crucial step.
It determines the trade-off between falsely called responders (false positives)
versus falsely called non-responders (false negatives).
Under normality assumption, it is related to the false positive rate (FPR) by

\[
\text{FPR} = 1 - \text{pnorm}(z)
\]

An FPR of 0.05 thus corresponds to

```
z_factor <- qnorm(0.05, lower.tail = FALSE)
z_factor
```

```
## [1] 1.644854
```

Defining drugs representing BTK, mTOR and MEK inhibition.

```
drugnames <- c( "ibrutinib", "everolimus", "selumetinib")
ib  <- "D_002_4:5"
ev  <- "D_063_4:5"
se  <- "D_012_4:5"
stopifnot(identical(fData(lpdAll)[c(ib, ev, se), "name"], drugnames))
```

```
df  <- Biobase::exprs(lpdAll)[c(ib, ev, se), lpdAll$Diagnosis=="CLL"] %>%
  t %>% as_tibble %>% `colnames<-`(drugnames)
```

```
mdf <- melt(data.frame(df))
```

```
## No id variables; using all as measure variables
```

```
grid.arrange(ncol = 2,
  ggplot(df, aes(x = 1-ibrutinib,  y = 1-everolimus )) + geom_point(),
  ggplot(df, aes(x = 1-everolimus, y = 1-selumetinib)) + geom_point()
  )
```

![](data:image/png;base64...)

Determine standard deviation using mirror method.

```
pmdf <- filter(mdf, value >= 1)
ssd  <- mean( (pmdf$value - 1) ^ 2 ) ^ 0.5
ssd
```

```
## [1] 0.05990934
```

Normal density.

```
dn <- tibble(
  x = seq(min(mdf$value), max(mdf$value), length.out = 100),
  y = dnorm(x, mean = 1, sd = ssd) * 2 * nrow(pmdf) / nrow(mdf)
)
```

First, draw histogram for all three drugs pooled.

```
#FIG# S10 A
thresh   <- 1 - z_factor * ssd
thresh
```

```
## [1] 0.9014579
```

```
hh <- ggplot() +
  geom_histogram(aes(x = value, y = ..density..),
                 binwidth = 0.025, data = mdf) +
  theme_minimal() +
  geom_line(aes(x = x, y = y), col = "darkblue", data = dn) +
  geom_vline(col = "red", xintercept = thresh)
hh
```

```
## Warning: The dot-dot notation (`..density..`) was deprecated in ggplot2 3.4.0.
## ℹ Please use `after_stat(density)` instead.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

Then split by drug.

```
hh + facet_grid( ~ variable)
```

![](data:image/png;base64...)

Decision rule.

```
thresh
```

```
## [1] 0.9014579
```

```
df <- mutate(df,
  group = ifelse(ibrutinib < thresh, "BTK",
          ifelse(everolimus < thresh, "mTOR",
          ifelse(selumetinib < thresh, "MEK", "Non-responder")))
)
```

Present the decision rule in the plots.

```
#FIG# S10 B
mycol <- c(`BTK` = "Royalblue4",
           `mTOR` = "chartreuse4",
           `MEK` = "mediumorchid4",
           `Non-responder` = "grey61")

plots <- list(
  ggplot(df, aes(x = 1-ibrutinib,  y = 1-everolimus)),
  ggplot(filter(df, group != "BTK"), aes(x = 1-selumetinib, y = 1-everolimus))
)

plots <- lapply(plots, function(x)
  x + geom_point(aes(col = group), size = 1.5) + theme_minimal() +
    coord_fixed() +
    scale_color_manual(values = mycol) +
    geom_hline(yintercept = 1 - thresh) +
    geom_vline(xintercept = 1- thresh) +
    ylim(-0.15, 0.32) + xlim(-0.15, 0.32)

)

grid.arrange(ncol = 2, grobs  = plots)
```

![](data:image/png;base64...)

The above roules of stratification of patients into drug response groups is contained within `defineResponseGroups` function inside the package.

```
sel = defineResponseGroups(lpd=lpdAll)
```

```
## Using PatientID as id variables
```

## 11.2 Mean of each group

```
# colors
c1 = giveColors(2, 0.5)
c2 = giveColors(4, 0.85)
c3 = giveColors(10, 0.75)

# vectors
p <- vector(); d <- vector();
pMTOR <- vector(); pBTK <- vector(); pMEK <- vector(); pNONE <- vector()
dMTOR <- vector(); dBTK <- vector(); dMEK <- vector(); dNONE <- vector()
dMTOR_NONE <- vector(); pMTOR_NONE <- vector()

# groups
sel$grMTOR_NONE <- ifelse(sel$group=="mTOR", "mTOR", NA)
sel$grMTOR_NONE <- ifelse(sel$group=="none", "none", sel$grMTOR_NONE)

sel$grMTOR <- ifelse(sel$group=="mTOR", "mTOR", "rest")
sel$col <- ifelse(sel$group=="mTOR", c3, "grey")
sel$grBTK  <- ifelse(sel$group=="BTK",  "BTK", "rest")
sel$col <- ifelse(sel$group=="BTK",  c1, sel$col)
sel$grMEK  <- ifelse(sel$group=="MEK",  "MEK", "rest")
sel$col <- ifelse(sel$group=="MEK",  c2, sel$col)
sel$grNONE <- ifelse(sel$group=="none", "none", "rest")

for (i in 1: max(which(fData(lpdCLL)$type=="viab"))) {

  fit <- aov(Biobase::exprs(lpdCLL)[i, rownames(sel)] ~ sel$group)
  p[i] <- summary(fit)[[1]][["Pr(>F)"]][1]

  calc_p = function(clmn) {
    p.adjust(
      t.test(Biobase::exprs(lpdCLL)[i, rownames(sel)] ~ sel[,clmn],
             alternative = c("two.sided") )$p.value, "BH" )
  }

  calc_d = function(clmn) {
    diff(
      t.test(Biobase::exprs(lpdCLL)[i, rownames(sel)] ~ sel[,clmn])$estimate,
      alternative = c("two.sided") )
  }

  pMTOR_NONE[i] <- calc_p("grMTOR_NONE")
  dMTOR_NONE[i] <- calc_d("grMTOR_NONE")

  pMTOR[i] <- calc_p("grMTOR")
  dMTOR[i] <- calc_d("grMTOR")

  pBTK[i] <- calc_p("grBTK")
  dBTK[i] <- calc_d("grBTK")

  pMEK[i] <- calc_p("grMEK")
  dMEK[i] <- calc_d("grMEK")

  pNONE[i] <- calc_p("grNONE")
  dNONE[i] <- calc_d("grNONE")

  # drugnames
  d[i] <- rownames(lpdCLL)[i]
}
```

```
#FIG# 3F
#construct data frame
ps <- data.frame(drug=d, pMTOR, pBTK, pMEK, pNONE, p )
ds <- data.frame(dMTOR, dBTK, dMEK, dNONE)
rownames(ps) <- ps[,1]; rownames(ds) <- ps[,1]

# selcet only rows for singel concentrations, set non-sig to zero
ps45 <- ps[rownames(ps)[grep(rownames(ps), pattern="_4:5")],2:5 ]
for (i in 1:4) { ps45[,i] <- ifelse(ps45[,i]<0.05, ps45[,i], 0) }

ds45 <- ds[rownames(ds)[grep(rownames(ds), pattern="_4:5")],1:4 ]
for (i in 1:4) { ds45[,i] <- ifelse(ps45[,i]<0.05, ds45[,i], 0) }

# exclude non-significant rows
selDS <- rownames(ds45)[rowSums(ps45)>0]
selPS <- rownames(ps45)[rowSums(ps45)>0]
ps45 <- ps45[selPS, ]
ds45 <- ds45[selDS, ]

groupMean = function(gr) {
  rowMeans(Biobase::exprs(lpdCLL)[rownames(ps45), rownames(sel)[sel$group==gr]])
}

MBTK <- groupMean("BTK")
MMEK <- groupMean("MEK")
MmTOR <- groupMean("mTOR")
MNONE <- groupMean("none")

# create data frame, new colnames
ms <- data.frame(BTK=MBTK, MEK=MMEK, mTOR=MmTOR, NONE=MNONE)
colnames(ms) <- c("BTK", "MEK", "mTOR", "WEAK")
rownames(ms) <- drugs[substr(selPS, 1,5), "name"]

# select rows with effect sizes group vs. rest >0.05
ms <- ms[ which(rowMax(as.matrix(ds45)) > 0.05 ) ,  ]

# exclude some drugs
ms <- ms[-c(
  which(rownames(ms) %in%
          c("everolimus", "ibrutinib", "selumetinib", "bortezomib"))),]

pheatmap(ms[, c("MEK", "BTK","mTOR", "WEAK")], cluster_cols = FALSE,
         cluster_rows =TRUE, clustering_method = "centroid",
         scale = "row",
         color=colorRampPalette(
           c(rev(brewer.pal(7, "YlOrRd")), "white", "white", "white",
             brewer.pal(7, "Blues")))(101)
        )
```

![](data:image/png;base64...)

## 11.3 Bee swarm plots for groups

For selected drugs, we show differences of drug response between patient response groups.

```
#FIG# 3G
# drug label
giveDrugLabel3 <- function(drid) {
  vapply(strsplit(drid, "_"), function(x) {
    k <- paste(x[1:2], collapse="_")
    paste0(drugs[k, "name"])
  }, character(1))
}

groups = sel[,"group", drop=FALSE]
groups[which(groups=="none"), "group"] = "WEAK"

# beeswarm function
beeDrug <- function(xDrug) {

   par(bty="l", cex.axis=1.5)
   beeswarm(
     Biobase::exprs(lpdCLL)[xDrug, rownames(sel)] ~ groups$group,
     axes=FALSE, cex.lab=1.5, ylab="Viability", xlab="", pch = 16,
     pwcol=sel$col, cex=1,
     ylim=c(min( Biobase::exprs(lpdCLL)[xDrug, rownames(sel)] ) - 0.05, 1.2) )

   boxplot(Biobase::exprs(lpdCLL)[xDrug, rownames(sel)] ~ groups$group,  add = T,
           col="#0000ff22", cex.lab=2, outline = FALSE)

   mtext(side=3, outer=F, line=0,
       paste0(giveDrugLabel3(xDrug) ), cex=2)
}

beeDrug("D_001_4:5")
```

![](data:image/png;base64...)

```
beeDrug("D_081_4:5")
```

![](data:image/png;base64...)

```
beeDrug("D_013_4:5")
```

![](data:image/png;base64...)

```
beeDrug("D_003_4:5")
```

![](data:image/png;base64...)

```
beeDrug("D_020_4:5")
```

![](data:image/png;base64...)

```
beeDrug("D_165_3")
```

![](data:image/png;base64...)

# 12 Kaplan-Meier plot for groups (time from sample to next treatment)

```
#FIG# S11 A
patmeta[, "group"] <- sel[rownames(patmeta), "group"]

c1n <- giveColors(2)
c2n <- giveColors(4)
c3n <- giveColors(10)
c4n <- "lightgrey"

survplot(Surv(patmeta[ , "T5"],
              patmeta[ , "treatedAfter"] == TRUE)  ~ patmeta$group ,
  lwd=3, cex.axis = 1.2, cex.lab=1.5, col=c(c1n, c2n, c3n, c4n),
  data = patmeta,
  legend.pos = 'bottomleft', stitle = 'Drug response',
  xlab = 'Time (years)', ylab = 'Patients without treatment (%)',
)
```

![](data:image/png;base64...)

# 13 Incidence of somatic gene mutations and CNVs in the four groups

Load data.

```
data(lpdAll)
```

Select CLL patients.

```
lpdCLL <- lpdAll[ , lpdAll$Diagnosis== "CLL"]
```

Build groups.

```
sel = defineResponseGroups(lpd=lpdAll)
```

```
## Using PatientID as id variables
```

Calculate total number of mutations per patient.

```
genes <- data.frame(
  t(Biobase::exprs(lpdCLL)[fData(lpdCLL)$type %in% c("gen", "IGHV"), rownames(sel)]),
  group = factor(sel$group)
)

genes <- genes[!(is.na(rownames(genes))), ]
colnames(genes) %<>%
  sub("del13q14_any", "del13q14", .) %>%
  sub("IGHV.Uppsala.U.M", "IGHV", .)

Nmut = rowSums(genes[, colnames(genes) != "group"], na.rm = TRUE)

mf <- sapply(c("BTK", "MEK", "mTOR", "none"), function(i)
  mean(Nmut[genes$group==i])
)
```

```
barplot(mf, ylab="Total number of mutations/CNVs per patient", col="darkgreen")
```

![](data:image/png;base64...)

Test each mutation, and each group, marginally for an effect.

```
mutsUse <- setdiff( colnames(genes), "group" )
mutsUse <- mutsUse[ colSums(genes[, mutsUse], na.rm = TRUE) >= 4 ]
mutationTests <- lapply(mutsUse, function(m) {
  tibble(
    mutation = m,
    p = fisher.test(genes[, m], genes$group)$p.value)
}) %>% bind_rows  %>% mutate(pBH = p.adjust(p, "BH")) %>% arrange(p)

mutationTests <- mutationTests %>% filter(pBH < 0.1)
```

Number of mutations with the p-value meeting the threshold.

```
nrow(mutationTests)
```

```
## [1] 8
```

```
groupTests <- lapply(unique(genes$group), function(g) {
  tibble(
    group = g,
    p = fisher.test(
      colSums(genes[genes$group == g, mutsUse], na.rm=TRUE),
      colSums(genes[genes$group != g, mutsUse], na.rm=TRUE),
      simulate.p.value = TRUE, B = 10000)$p.value)
}) %>% bind_rows %>% arrange(p)

groupTests
```

```
## # A tibble: 4 × 2
##   group         p
##   <fct>     <dbl>
## 1 none  0.0001000
## 2 MEK   0.00110
## 3 mTOR  0.00360
## 4 BTK   0.00860
```

These results show that **each** of the groups has an imbalanced mutation distribution, and that each of the above-listed mutations is somehow imbalanced between the groups.

## 13.1 Test gene mutations vs. groups

Fisher.test genes vs. groups function. Below function assumes that `g` is a data.frame one of whose columns is `group`
and all other columns are numeric (i.e., 0 or 1) mutation indicators.

```
fisher.genes <- function(g, ref) {
  stopifnot(length(ref) == 1)
  ggg <- ifelse(g$group == ref, ref, "other")
  idx <- which(colnames(g) != "group")

  lapply(idx, function(i)
    if (sum(g[, i], na.rm = TRUE) > 2) {
      ft  <- fisher.test(ggg, g[, i])
      tibble(
        p    = ft$p.value,
        es   = ft$estimate,
        prop = sum((ggg == ref) & !is.na(g[, i]), na.rm = TRUE),
        mut1 = sum((ggg == ref) & (g[, i] != 0),  na.rm = TRUE),
        gene = colnames(g)[i])
    }  else {
      tibble(p = 1, es = 1, prop = 0, mut1 = 0, gene = colnames(g)[i])
    }
  ) %>% bind_rows
}
```

Calculate p values and effects using the Fisher test and group of interest vs. rest.

```
pMTOR <- fisher.genes(genes, ref="mTOR")
pBTK  <- fisher.genes(genes, ref="BTK")
pMEK  <- fisher.genes(genes, ref="MEK")
pNONE <- fisher.genes(genes, ref="none")

p    <- cbind(pBTK$p,    pMEK$p,    pMTOR$p,    pNONE$p)
es   <- cbind(pBTK$es,   pMEK$es,   pMTOR$es,   pNONE$es)
prop <- cbind(pBTK$prop, pMEK$prop, pMTOR$prop, pNONE$prop)
mut1 <- cbind(pBTK$mut1, pMEK$mut1, pMTOR$mut1, pNONE$mut1)
```

Prepare matrix for heatmap.

```
p <- ifelse(p < 0.05, 1, 0)
p <- ifelse(es <= 1, p, -p)
rownames(p) <- pMTOR$gene
colnames(p) <- c("BTK", "MEK", "mTOR", "NONE")

pM <- p[rowSums(abs(p))!=0, ]
propM <- prop[rowSums(abs(p))!=0, ]
```

Cell labels.

```
N <- cbind( paste0(mut1[,1],"/",prop[,1] ),
            paste0(mut1[,2],"/",prop[,2] ),
            paste0(mut1[,3],"/",prop[,3] ),
            paste0(mut1[,4],"/",prop[,4] )
)

rownames(N) <- rownames(p)
```

Draw the heatmap only for significant factors in mutUse.
Selection criteria for mutUse are >=4 mutations and adjusted p.value < 0.1 for 4x2 fisher test groups (mtor, mek, btk, none) vs mutation.

```
#FIG# S11 B
mutationTests <-
  mutationTests[which(!(mutationTests$mutation %in%
                          c("del13q14_bi", "del13q14_mono"))), ]
pMA <- p[mutationTests$mutation, ]
pMA
```

```
##           BTK MEK mTOR NONE
## IGHV       -1   0    1    1
## trisomy12   1   0    1   -1
## del13q14   -1   0    0    1
## KLHL6       0   0    1    0
## TP53        0   1    0    0
## MED12       0   1    0    0
```

```
pheatmap(pMA, cluster_cols = FALSE,
         cluster_rows = FALSE, legend=TRUE, annotation_legend = FALSE,
         color = c("red", "white", "lightblue"),
         display_numbers = N[ rownames(pMA), ]
        )
```

![](data:image/png;base64...)

# 14 Differences in gene expression profiles between drug-response groups

```
data("dds")

sel = defineResponseGroups(lpd=lpdAll)
```

```
## Using PatientID as id variables
```

```
sel$group = gsub("none","weak", sel$group)
```

```
# select patients with CLL in the main screen data
colnames(dds) <- colData(dds)$PatID
pat <- intersect(colnames(lpdCLL), colnames(dds))
dds_CLL <- dds[,which(colData(dds)$PatID %in% pat)]

# add group label
colData(dds_CLL)$group <- factor(sel[colnames(dds_CLL), "group"])
colData(dds_CLL)$IGHV = factor(patmeta[colnames(dds_CLL),"IGHV"])
```

Select genes with most variable expression levels.

```
vsd <- varianceStabilizingTransformation( assay(dds_CLL) )
colnames(vsd) = colData(dds_CLL)$PatID
rowVariance <- setNames(rowVars(vsd), nm=rownames(vsd))
sortedVar <- sort(rowVariance, decreasing=TRUE)
mostVariedGenes <- sortedVar[1:10000]
dds_CLL <- dds_CLL[names(mostVariedGenes), ]
```

Run DESeq2.

```
cb <- combn(unique(colData(dds_CLL)$group), 2)

gg <- list(); ggM <- list(); ggU <- list()
DE <- function(ighv) {
 for (i in 1:ncol(cb)) {
   dds_sel <- dds_CLL[,which(colData(dds_CLL)$IGHV %in% ighv)]
   dds_sel <- dds_sel[,which(colData(dds_sel)$group %in% cb[,i])]
   design(dds_sel) = ~group
   dds_sel$group <- droplevels(dds_sel$group)
   dds_sel$group <- relevel(dds_sel$group, ref=as.character(cb[2,i]) )
   dds_sel <- DESeq(dds_sel)
   res <- results(dds_sel)
   gg[[i]] <- res[order(res$padj, decreasing = FALSE), ]
   names(gg)[i] <- paste0(cb[1,i], "_", cb[2,i])
 }
return(gg)
}
```

```
ggM <- DE(ighv="M")
ggU <- DE(ighv="U")
gg <- DE(ighv=c("M", "U"))
```

The above code is not executed due to long running time. We load the output from the presaved object instead.

```
load(system.file("extdata","gexGroups.RData", package="BloodCancerMultiOmics2017"))
```

We use biomaRt package to map ensembl gene ids to hgnc gene symbols. The maping requires Internet connection and to omit this obstacle we load the presaved output. For completness, we provide the code used to generate the mapping.

```
library("biomaRt")
# extract all ensembl ids
allGenes = unique(unlist(lapply(gg, function(x) rownames(x))))
# get gene ids for ensembl ids
genSymbols = getBM(filters="ensembl_gene_id",
                   attributes=c("ensembl_gene_id", "hgnc_symbol"),
                   values=allGenes, mart=mart)
# select first id if more than one is present
genSymbols = genSymbols[!duplicated(genSymbols[,"ensembl_gene_id"]),]
# set rownames to ens id
rownames(genSymbols) = genSymbols[,"ensembl_gene_id"]
```

```
load(system.file("extdata","genSymbols.RData", package="BloodCancerMultiOmics2017"))
```

Correlation of IL-10 mRNA expression and response to everolimus within the mTOR subgroup.

```
#FIG# S14
gen="ENSG00000136634" #IL10
drug   <- "D_063_4:5"

patsel <- intersect( rownames(sel)[sel$group %in% c("mTOR")], colnames(vsd) )

c <- cor.test( Biobase::exprs(lpdCLL)[drug, patsel], vsd[gen, patsel] )

# get hgnc_symbol for gen
# mart = useDataset("hsapiens_gene_ensembl", useMart("ensembl"))
# genSym = getBM(filters="ensembl_gene_id", attributes="hgnc_symbol",
# values=gen, mart=mart)
genSym = genSymbols[gen, "hgnc_symbol"]

plot(vsd[gen, patsel], Biobase::exprs(lpdCLL)[drug, patsel],
     xlab=paste0(genSym, " expression"),
     ylab="Viability (everolimus)", pch=19, ylim=c(0.70, 0.92), col="purple",
     main = paste0("mTOR-group", "\n cor = ", round(c$estimate, 3),
                   ", p = ", signif(c$p.value,2 )),
     cex=1.2)
abline(lm(Biobase::exprs(lpdCLL)[drug, patsel] ~ vsd[gen, patsel]))
```

![](data:image/png;base64...)

Set colors.

```
c1 = giveColors(2, 0.4)
c2 = giveColors(4, 0.7)
c3 = giveColors(10, 0.6)
```

Function which extracts significant genes.

```
sigEx <- function(real) {

  ggsig = lapply(real, function(x) {
    x = data.frame(x)
    x = x[which(!(is.na(x$padj))),]
    x = x[x$padj<0.1,]
    x = x[order(x$padj, decreasing = TRUE),]
    x = data.frame(x[ ,c("padj","log2FoldChange")], ensg=rownames(x) )
    x$hgnc1 = genSymbols[rownames(x), "hgnc_symbol"]
    x$hgnc2 = ifelse(x$hgnc1=="" | x$hgnc1=="T" | is.na(x$hgnc1),
                     as.character(x$ensg), x$hgnc1)
    x[-(grep(x[,"hgnc2"], pattern="IG")),]
  })
  return(ggsig)
}
```

```
barplot1 <- function(real, tit) {

  # process real diff genes
  sigExPlus = sigEx(real)
  ng <- lapply(sigExPlus, function(x){ cbind(
    up=nrow(x[x$log2FoldChange>0, ]),
    dn=nrow(x[x$log2FoldChange<0, ]) ) } )
  ng = melt(ng)

  p <- ggplot(ng, aes(reorder(L1, -value)), ylim(-500:500)) +
    geom_bar(data = ng, aes(y =  value, fill=Var2), stat="identity",
             position=position_dodge() ) +
    scale_fill_brewer(palette="Paired", direction = -1,
                      labels = c("up", "down")) +
    ggtitle(label=tit) +

    geom_hline(yintercept = 0,colour = "grey90") +
    theme(
           panel.grid.minor = element_blank(),

           axis.title.x = element_blank(),
           axis.text.x = element_text(size=14, angle = 60, hjust = 1),
           axis.ticks.x = element_blank(),

           axis.title.y  = element_blank(),
           axis.text.y = element_text(size=14, colour="black"),
           axis.line.y = element_line(colour = "black",
                                      size = 0.5, linetype = "solid"),

           legend.key = element_rect(fill = "white"),
           legend.background = element_rect(fill = "white"),
           legend.title = element_blank(),
           legend.text = element_text(size=14, colour="black"),

           panel.background = element_rect(fill = "white", color="white")
          )

  plot(p)
}
```

```
#FIG# S11 C
barplot1(real=gg, tit="")
```

![](data:image/png;base64...)

## 14.1 Cytokine / chemokine expression in mTOR group

Here we compare expression levels of cytokines/chemokines within the mTOR group.

Set helpful functions.

```
# beeswarm funtion
beefun <- function(df, sym) {
 par(bty="l", cex.axis=1.5)
 beeswarm(df$x ~ df$y, axes=FALSE, cex.lab=1.5, col="grey", ylab=sym, xlab="",
          pch = 16, pwcol=sel[colnames(vsd),"col"], cex=1.3)

 boxplot(df$x ~ df$y, add = T, col="#0000ff22", cex.lab=1.5)
}
```

Bulid response groups.

```
sel = defineResponseGroups(lpdCLL)
```

```
## Using PatientID as id variables
```

```
sel[,1:3] = 1-sel[,1:3]
sel$IGHV = pData(lpdCLL)[rownames(sel), "IGHV Uppsala U/M"]

c1 = giveColors(2, 0.5)
c2 = giveColors(4, 0.85)
c3 = giveColors(10, 0.75)

# add colors
sel$col <- ifelse(sel$group=="mTOR", c3, "grey")
sel$col <- ifelse(sel$group=="BTK",  c1, sel$col)
sel$col <- ifelse(sel$group=="MEK",  c2, sel$col)
```

For each cytokine/chemokine we compare level of expression between the response groups.

```
cytokines <- c("CXCL2","TGFB1","CCL2","IL2","IL12B","IL4","IL6","IL10","CXCL8",
               "TNF")
cyEN =  sapply(cytokines, function(i) {
  genSymbols[which(genSymbols$hgnc_symbol==i)[1],"ensembl_gene_id"]
})

makeEmpty = function() {
  data.frame(matrix(ncol=3, nrow=length(cyEN),
                    dimnames=list(names(cyEN), c("BTK", "MEK", "mTOR"))) )
}
p = makeEmpty()
ef = makeEmpty()
```

```
for (i in 1:length(cyEN) ) {

 geneID <- cyEN[i]
 df <- data.frame(x=vsd[geneID,  ], y=sel[colnames(vsd) ,"group"])
 df$y <- as.factor(df$y)

 beefun(df, sym=names(geneID))

 df <- within(df, y <- relevel(y, ref = "none"))
 fit <- lm(x ~y, data=df)

 p[i,] <- summary(fit)$coefficients[ 2:4, "Pr(>|t|)"]

 abtk = mean(df[df$y=="BTK", "x"], na.rm=TRUE) - mean(df[df$y=="none", "x"],
                                                      na.rm=TRUE)
 amek = mean(df[df$y=="MEK", "x"], na.rm=TRUE) - mean(df[df$y=="none", "x"],
                                                      na.rm=TRUE)
 amtor= mean(df[df$y=="mTOR", "x"], na.rm=TRUE) - mean(df[df$y=="none", "x"],
                                                       na.rm=TRUE)

 ef[i,] <-  c(as.numeric(abtk), as.numeric(amek), as.numeric(amtor))

 mtext( paste(    "pBTK=", summary(fit)$coefficients[ 2, "Pr(>|t|)"],
                "\npMEK=", summary(fit)$coefficients[ 3, "Pr(>|t|)"],
               "\npMTOR=", summary(fit)$coefficients[ 4, "Pr(>|t|)"],
              side=3 ))
}
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

As a next step, we summarize the above comparisons in one plot.

```
#FIG# S11 D
# log p-values
plog <- apply(p, 2, function(x){-log(x)} )
plog_m <- melt(as.matrix(plog))
ef_m <- melt(as.matrix(ef))

# introduce effect direction
plog_m$value <- ifelse(ef_m$value>0, plog_m$value, -plog_m$value)

rownames(plog_m) <- 1:nrow(plog_m)

# fdr
fdrmin = min( p.adjust(p$mTOR, "fdr") )

### plot ####
colnames(plog_m) <- c("cytokine", "group", "p")

lev = names(sort(tapply(plog_m$p, plog_m$cytokine, function(p) min(p))))

plog_m$cytokine <- factor(plog_m$cytokine, levels=lev)

 ggplot(data=plog_m, mapping=aes(x=cytokine, y=p, color=group)) +
    scale_colour_manual(values = c(c1, c2, c3)) +
    geom_point( size=3 ) +
       theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.9),
       panel.grid.minor = element_blank(),
       panel.grid.major = element_blank(),
       panel.background = element_blank(),
       axis.line.x=element_line(),
       axis.line.y=element_line(),
       legend.position="none"
       ) +
    scale_y_continuous(name="-log(p-value)", breaks=seq(-3,7.5,2),
                       limits=c(-3,7.5)) +
    xlab("") +
    geom_hline(yintercept = 0) +
    geom_hline(yintercept = -log(0.004588897), color="purple", linetype="dashed") +
    geom_hline(yintercept = (-log(0.05)), color="grey", linetype="dashed")
```

![](data:image/png;base64...)

Within the mTOR group it is only IL-10 which have significantly increased expression. The other important cytokines/chemokines were not differentially expressed.

---

# 15 Response to cytokines in CLL

In order to find out whether the cytokines have pro-survival effect on patient cells the drug sreen was performed.
18 patient samples were exposed to 6 different cytokines. The viability of the treated cells were normalized by untreated controls.

Load the drug response dataset.

```
data("cytokineViab")
```

Plot the drug response curves.

```
cond <- c("IL-2", "IL-4", "IL-10", "IL-21", "LPS", "IgM")

for (i in cond){
  plot = ggplot(
    filter(cytokineViab, Duplicate%in%c("1"), Stimulation==i, Timepoint=="48h"),
    aes(x=as.factor(Cytokine_Concentration2), y=Normalized_DMSO, colour=mtor,
        group=interaction(Patient))) +
    ylab("viability") + xlab("c(stimulation)") + ylim(c(0.8, 1.4)) +
    geom_line() + geom_point() + ggtitle(i) + theme_bw() + guides(color="none")

    assign(paste0("p",i), plot)
}

grid.arrange(`pIL-2`,`pIL-10`,`pIL-4`,`pIL-21`,pLPS, pIgM, nrow=2)
```

![](data:image/png;base64...)

IL-10 had a pro-survival effect on the majority of samples, but not on those in the mTOR group.
IL-4 and IL-21 had pro-survival effects on most samples, including the mTOR group.

---

```
options(stringsAsFactors=FALSE)
```

# 16 Gene set enrichment analysis on BTK, mTOR, MEK groups

Based on the classification of drug response phenotypes we divided CLL samples into distinct groups driven by the increased sensitivity towards BTK, mTOR and MEK inhibition. Here we perform gene set enrichment analysis to find the causes of distinctive drug response phenotypes in the gene expression data.

Load objects.

```
data(list=c("dds", "lpdAll"))

gmts = list(H=system.file("extdata","h.all.v5.1.symbols.gmt",
                          package="BloodCancerMultiOmics2017"),
            C6=system.file("extdata","c6.all.v5.1.symbols.gmt",
                           package="BloodCancerMultiOmics2017"))
```

Divide patients into response groups.

```
patGroup = defineResponseGroups(lpd=lpdAll)
```

```
## Using PatientID as id variables
```

## 16.1 Preprocessing RNAseq data

Subsetting RNAseq data to include the CLL patients for which the drug screen was performed.

```
lpdCLL <- lpdAll[fData(lpdAll)$type=="viab",
                 pData(lpdAll)$Diagnosis %in% c("CLL")]

ddsCLL <- dds[,colData(dds)$PatID %in% colnames(lpdCLL)]
```

Read in group and add annotations to the RNAseq data set.

```
ddsCLL <- ddsCLL[,colData(ddsCLL)$PatID %in% rownames(patGroup)]

#remove genes without gene symbol annotations
ddsCLL <- ddsCLL[!is.na(rowData(ddsCLL)$symbol),]
ddsCLL <- ddsCLL[rowData(ddsCLL)$symbol != "",]

#add drug sensitivity annotations to coldata
colData(ddsCLL)$group <- factor(patGroup[colData(ddsCLL)$PatID, "group"])
```

Remove rows that contain too few counts.

```
#only keep genes that have counts higher than 10 in any sample
keep <- apply(counts(ddsCLL), 1, function(x) any(x >= 10))
ddsCLL <- ddsCLL[keep,]
dim(ddsCLL)
```

```
## [1] 20930   122
```

Remove transcripts which do not show variance across samples.

```
ddsCLL <- estimateSizeFactors(ddsCLL)
sds <- rowSds(counts(ddsCLL, normalized = TRUE))
sh <- shorth(sds)
ddsCLL <- ddsCLL[sds >= sh,]
```

Variance stabilizing transformation

```
ddsCLL.norm <- varianceStabilizingTransformation(ddsCLL)
```

## 16.2 Differential gene expression

Perform differential gene expression using DESeq2.

```
DEres <- list()
design(ddsCLL) <- ~ group

rnaRaw <- DESeq(ddsCLL, betaPrior = FALSE)
```

```
## using pre-existing size factors
```

```
## estimating dispersions
```

```
## gene-wise dispersion estimates
```

```
## mean-dispersion relationship
```

```
## final dispersion estimates
```

```
## fitting model and testing
```

```
## -- replacing outliers and refitting for 524 genes
## -- DESeq argument 'minReplicatesForReplace' = 7
## -- original counts are preserved in counts(dds)
```

```
## estimating dispersions
```

```
## fitting model and testing
```

```
#extract results for different comparisons
# responders versus weak-responders
DEres[["BTKnone"]] <- results(rnaRaw, contrast = c("group","BTK","none"))
DEres[["MEKnone"]] <- results(rnaRaw, contrast = c("group","MEK","none"))
DEres[["mTORnone"]] <- results(rnaRaw, contrast = c("group","mTOR","none"))
```

## 16.3 Gene set enrichment analysis

The gene set enrichment analysis will be performed by using the MSigDB gene set collections C6 and Hallmark (<http://software.broadinstitute.org/gsea/msigdb/> ). For each collection we will show the top five enriched gene sets and respective differentially expressed genes. Gene set enrichment analysis will be performed on the ranked gene lists using the Parametric Analysis of Gene Set Enrichment (PAGE).

### 16.3.1 Functions for enrichment analysis and plots

Define cut-off.

```
pCut = 0.05
```

Function to run GSEA or PAGE in R.

```
runGSEA <- function(inputTab, gmtFile, GSAmethod="gsea", nPerm=1000){
    inGMT <- loadGSC(gmtFile,type="gmt")
     #re-rank by score
    rankTab <- inputTab[order(inputTab[,1],decreasing = TRUE),,drop=FALSE]
    if (GSAmethod == "gsea"){
        #readin geneset database
        #GSEA analysis
        res <- runGSA(geneLevelStats = rankTab,
                      geneSetStat = GSAmethod,
                      adjMethod = "fdr", gsc=inGMT,
                      signifMethod = 'geneSampling', nPerm = nPerm)
        GSAsummaryTable(res)
    } else if (GSAmethod == "page"){
        res <- runGSA(geneLevelStats = rankTab,
                      geneSetStat = GSAmethod,
                      adjMethod = "fdr", gsc=inGMT,
                      signifMethod = 'nullDist')
        GSAsummaryTable(res)
    }
}
```

Function which run the GSE for each response group.

```
runGSE = function(gmt) {

  Res <- list()
  for (i in names(DEres)) {
    dataTab <- data.frame(DEres[[i]])
    dataTab$ID <- rownames(dataTab)
    #filter using pvalues
    dataTab <- filter(dataTab, pvalue <= pCut) %>%
                  arrange(pvalue) %>%
                  mutate(Symbol = rowData(ddsCLL[ID,])$symbol)
    dataTab <- dataTab[!duplicated(dataTab$Symbol),]
    statTab <- data.frame(row.names = dataTab$Symbol, stat = dataTab$stat)
    resTab <- runGSEA(inputTab=statTab, gmtFile=gmt, GSAmethod="page")
    Res[[i]] <- arrange(resTab,desc(`Stat (dist.dir)`))
  }
  Res
}
```

Function to get the list of genes enriched in a set.

```
getGenes <- function(inputTab, gmtFile){
  geneList <- loadGSC(gmtFile,type="gmt")$gsc
  enrichedUp <- lapply(geneList, function(x)
    intersect(rownames(inputTab[inputTab[,1] >0,,drop=FALSE]),x))
  enrichedDown <- lapply(geneList, function(x)
    intersect(rownames(inputTab[inputTab[,1] <0,,drop=FALSE]),x))
  return(list(up=enrichedUp, down=enrichedDown))
}
```

A function to plot the heat map of intersection of genes in different gene sets.

```
plotSetHeatmap <-
  function(geneTab, enrichTab, topN, gmtFile, tittle="",
           asterixList = NULL, anno=FALSE) {

    if (nrow(enrichTab) < topN) topN <- nrow(enrichTab)
    enrichTab <- enrichTab[seq(1,topN),]

    geneList <- getGenes(geneTab,gmtFile)

    geneList$up <- geneList$up[enrichTab[,1]]
    geneList$down <- geneList$down[enrichTab[,1]]

    #form a table
    allGenes <- unique(c(unlist(geneList$up),unlist(geneList$down)))
    allSets <- unique(c(names(geneList$up),names(geneList$down)))
    plotTable <- matrix(data=NA,ncol = length(allSets),
                        nrow = length(allGenes),
                        dimnames = list(allGenes,allSets))
    for (setName in names(geneList$up)) {
      plotTable[geneList$up[[setName]],setName] <- 1
    }
    for (setName in names(geneList$down)) {
      plotTable[geneList$down[[setName]],setName] <- -1
    }

    if(is.null(asterixList)) {
      #if no correlation table specified, order by the number of
      # significant gene
      geneOrder <- rev(
        rownames(plotTable[order(rowSums(plotTable, na.rm = TRUE),
                                 decreasing =FALSE),]))
    } else {
      #otherwise, order by the p value of correlation
      asterixList <- arrange(asterixList, p)
      geneOrder <- filter(
        asterixList, symbol %in% rownames(plotTable))$symbol
      geneOrder <- c(
        geneOrder, rownames(plotTable)[! rownames(plotTable) %in% geneOrder])
    }

    plotTable <- melt(plotTable)
    colnames(plotTable) <- c("gene","set","value")
    plotTable$gene <- as.character(plotTable$gene)

    if(!is.null(asterixList)) {
      #add + if gene is positivily correlated with sensitivity, else add "-"
      plotTable$ifSig <- asterixList[
        match(plotTable$gene, asterixList$symbol),]$coef
      plotTable <- mutate(plotTable, ifSig =
                            ifelse(is.na(ifSig) | is.na(value), "",
                                   ifelse(ifSig > 0, "-", "+")))
    }
    plotTable$value <- replace(plotTable$value,
                               plotTable$value %in% c(1), "Up")
    plotTable$value <- replace(plotTable$value,
                               plotTable$value %in%  c(-1), "Down")

    allSymbols <- plotTable$gene

    geneSymbol <- geneOrder

    if (anno) { #if add functional annotations in addition to gene names
      annoTab <- tibble(symbol = rowData(ddsCLL)$symbol,
                        anno = sapply(rowData(ddsCLL)$description,
                                      function(x) unlist(strsplit(x,"[[]"))[1]))
      annoTab <- annoTab[!duplicated(annoTab$symbol),]
      annoTab$combine <- sprintf("%s (%s)",annoTab$symbol, annoTab$anno)
      plotTable$gene <- annoTab[match(plotTable$gene,annoTab$symbol),]$combine
      geneOrder <- annoTab[match(geneOrder,annoTab$symbol),]$combine
      geneOrder <- rev(geneOrder)
    }

    plotTable$gene <- factor(plotTable$gene, levels =geneOrder)
    plotTable$set <- factor(plotTable$set, levels = enrichTab[,1])

    g <- ggplot(plotTable, aes(x=set, y = gene)) +
      geom_tile(aes(fill=value), color = "black") +
      scale_fill_manual(values = c("Up"="red","Down"="blue")) +
      xlab("") + ylab("") + theme_classic() +
      theme(axis.text.x=element_text(size=7, angle = 60, hjust = 0),
            axis.text.y=element_text(size=7),
            axis.ticks = element_line(color="white"),
            axis.line = element_line(color="white"),
            legend.position = "none") +
      scale_x_discrete(position = "top") +
      scale_y_discrete(position = "right")

    if(!is.null(asterixList)) {
      g <- g + geom_text(aes(label = ifSig), vjust =0.40)
    }

    # construct the gtable
    wdths = c(0.05, 0.25*length(levels(plotTable$set)), 5)
    hghts = c(2.8, 0.1*length(levels(plotTable$gene)), 0.05)
    gt = gtable(widths=unit(wdths, "in"), heights=unit(hghts, "in"))
    ## make grobs
    ggr = ggplotGrob(g)
    ## fill in the gtable
    gt = gtable_add_grob(gt, gtable_filter(ggr, "panel"), 2, 2)
    gt = gtable_add_grob(gt, ggr$grobs[[5]], 1, 2) # top axis
    gt = gtable_add_grob(gt, ggr$grobs[[9]], 2, 3) # right axis

    return(list(list(plot=gt,
                     width=sum(wdths),
                     height=sum(hghts),
                     genes=geneSymbol)))
}
```

Prepare stats per gene for plotting.

```
statTab = setNames(lapply(c("mTORnone","BTKnone","MEKnone"), function(gr) {
  dataTab <- data.frame(DEres[[gr]])
  dataTab$ID <- rownames(dataTab)
  #filter using pvalues
  dataTab <- filter(dataTab, pvalue <= pCut) %>%
    arrange(pvalue) %>%
    mutate(Symbol = rowData(ddsCLL[ID,])$symbol) %>%
    filter(log2FoldChange > 0)
  dataTab <- dataTab[!duplicated(dataTab$Symbol),]
  data.frame(row.names = dataTab$Symbol, stat = dataTab$stat)
}), nm=c("mTORnone","BTKnone","MEKnone"))
```

### 16.3.2 Geneset enrichment based on Hallmark set (H)

Perform enrichment analysis using PAGE method.

```
hallmarkRes = runGSE(gmt=gmts[["H"]])
```

```
## Checking arguments...done!
```

```
## Calculating gene set statistics...done!
## Calculating gene set significance...done!
## Adjusting for multiple testing...done!
```

```
## Checking arguments...done!
```

```
## Calculating gene set statistics...done!
## Calculating gene set significance...done!
## Adjusting for multiple testing...done!
```

```
## Checking arguments...done!
```

```
## Calculating gene set statistics...done!
## Calculating gene set significance...done!
## Adjusting for multiple testing...done!
```

### 16.3.3 Geneset enrichment based on oncogenic signature set (C6)

Perform enrichment analysis using PAGE method.

```
c6Res = runGSE(gmt=gmts[["C6"]])
```

```
## Checking arguments...done!
```

```
## Calculating gene set statistics...done!
## Calculating gene set significance...done!
## Adjusting for multiple testing...done!
```

```
## Checking arguments...done!
```

```
## Calculating gene set statistics...done!
## Calculating gene set significance...done!
## Adjusting for multiple testing...done!
```

```
## Checking arguments...done!
```

```
## Calculating gene set statistics...done!
## Calculating gene set significance...done!
## Adjusting for multiple testing...done!
```

## 16.4 Everolimus response VS gene expression (within mTOR group)

To further investiage the association between expression and drug sensitivity group at gene level, correlation test was performed to identify genes whose expressions are correlated with the sensitivity to the mTOR inhibitor (everolimus) sensitivity within the mTOR group.

### 16.4.1 Correlation test

Prepare drug sensitivity vector and gene expression matrix

```
ddsCLL.mTOR <- ddsCLL.norm[,ddsCLL.norm$group %in% "mTOR"]
viabMTOR <- Biobase::exprs(lpdCLL["D_063_4:5", ddsCLL.mTOR$PatID])[1,]
stopifnot(all(ddsCLL.mTOR$PatID == colnames(viabMTOR)))
```

Filtering and applying variance stabilizing transformation on RNAseq data

```
#only keep genes that have counts higher than 10 in any sample
keep <- apply(assay(ddsCLL.mTOR), 1, function(x) any(x >= 10))
ddsCLL.mTOR <- ddsCLL.mTOR[keep,]
dim(ddsCLL.mTOR)
```

```
## [1] 9775   15
```

Association test using Pearson correlation

```
tmp = do.call(rbind, lapply(1:nrow(ddsCLL.mTOR), function(i) {
  res = cor.test(viabMTOR, assay(ddsCLL.mTOR[i,])[1,], method = "pearson")
  data.frame(coef=unname(res$estimate), p=res$p.value)
}))

corResult <- tibble(ID = rownames(ddsCLL.mTOR),
                    symbol = rowData(ddsCLL.mTOR)$symbol,
                    coef = tmp$coef,
                    p = tmp$p)

corResult <- arrange(corResult, p) %>% mutate(p.adj = p.adjust(p, method="BH"))
```

### 16.4.2 Enrichment heatmaps for mTOR group with overlapped genes indicated

The genes that are positively correlated with everolimus sensitivity are labeled as “+” in the heatmap and the negatively correlated genes are labeled as “-”.

Plot for C6 gene sets

```
pCut = 0.05
corResult.sig <- filter(corResult, p <= pCut)
c6Plot <- plotSetHeatmap(geneTab=statTab[["mTORnone"]],
                enrichTab=c6Res[["mTORnone"]],
                topN=5, gmtFile=gmts[["C6"]],
                #add asterix in front of the overlapped genes
                asterixList = corResult.sig,
                anno=TRUE, i)
```

![](data:image/png;base64...)

Plot for Hallmark gene sets

```
hallmarkPlot <- plotSetHeatmap(geneTab=statTab[["mTORnone"]],
                enrichTab=hallmarkRes[["mTORnone"]],
                topN=5, gmtFile=gmts[["H"]],
                asterixList = corResult.sig,
                anno=TRUE, i)
```

![](data:image/png;base64...)

## 16.5 Ibrutinib response VS gene expression (within BTK group)

Correlation test was performed to identify genes whose expressions are correlated with the sensitivity to the BTK inhibitor (ibrutinib) sensitivity within the BTK group.

### 16.5.1 Correlation test

Prepare drug sensitivity vector and gene expression matrix

```
ddsCLL.BTK <- ddsCLL.norm[,ddsCLL.norm$group %in% "BTK"]
viabBTK <- Biobase::exprs(lpdCLL["D_002_4:5", ddsCLL.BTK$PatID])[1,]
stopifnot(all(ddsCLL.BTK$PatID == colnames(viabBTK)))
```

Filtering and applying variance stabilizing transformation on RNAseq data

```
#only keep genes that have counts higher than 10 in any sample
keep <- apply(assay(ddsCLL.BTK), 1, function(x) any(x >= 10))
ddsCLL.BTK <- ddsCLL.BTK[keep,]
dim(ddsCLL.BTK)
```

```
## [1] 10416    30
```

Association test using Pearson correlation

```
tmp = do.call(rbind, lapply(1:nrow(ddsCLL.BTK), function(i) {
  res = cor.test(viabBTK, assay(ddsCLL.BTK[i,])[1,], method = "pearson")
  data.frame(coef=unname(res$estimate), p=res$p.value)
}))

corResult <- tibble(ID = rownames(ddsCLL.BTK),
                    symbol = rowData(ddsCLL.BTK)$symbol,
                    coef = tmp$coef,
                    p = tmp$p)

corResult <- arrange(corResult, p) %>% mutate(p.adj = p.adjust(p, method="BH"))
```

### 16.5.2 Enrichment heatmaps for BTK group with overlapped genes indicated

Plot for C6 gene sets

```
pCut = 0.05
corResult.sig <- filter(corResult, p <= pCut)
c6Plot <- plotSetHeatmap(geneTab=statTab[["BTKnone"]],
                enrichTab=c6Res[["BTKnone"]],
                topN=5, gmtFile=gmts[["C6"]],
                #add asterix in front of the overlapped genes
                asterixList = corResult.sig,
                anno=TRUE, i)
```

![](data:image/png;base64...)

Plot for Hallmark gene sets

```
hallmarkPlot <- plotSetHeatmap(geneTab=statTab[["BTKnone"]],
                enrichTab=hallmarkRes[["BTKnone"]],
                topN=5, gmtFile=gmts[["H"]],
                asterixList = corResult.sig,
                anno=TRUE, i)
```

![](data:image/png;base64...)

### 16.5.3 Selumetinib response VS gene expression (within MEK group)

Correlation test was performed to identify genes whose expressions are correlated with the sensitivity to the MEK inhibitor (selumetinib) sensitivity within the MEK group.

### 16.5.4 Correlation test

Prepare drug sensitivity vector and gene expression matrix

```
ddsCLL.MEK <- ddsCLL.norm[,ddsCLL.norm$group %in% "MEK"]
viabMEK <- Biobase::exprs(lpdCLL["D_012_4:5", ddsCLL.MEK$PatID])[1,]
stopifnot(all(ddsCLL.MEK$PatID == colnames(viabMEK)))
```

Filtering and applying variance stabilizing transformation on RNAseq data

```
#only keep genes that have counts higher than 10 in any sample
keep <- apply(assay(ddsCLL.MEK), 1, function(x) any(x >= 10))
ddsCLL.MEK <- ddsCLL.MEK[keep,]
dim(ddsCLL.MEK)
```

```
## [1] 10174    18
```

Association test using Pearson correlation

```
tmp = do.call(rbind, lapply(1:nrow(ddsCLL.MEK), function(i) {
  res = cor.test(viabMEK, assay(ddsCLL.MEK[i,])[1,], method = "pearson")
  data.frame(coef=unname(res$estimate), p=res$p.value)
}))

corResult <- tibble(ID = rownames(ddsCLL.MEK),
                    symbol = rowData(ddsCLL.MEK)$symbol,
                    coef = tmp$coef,
                    p = tmp$p)

corResult <- arrange(corResult, p) %>% mutate(p.adj = p.adjust(p, method="BH"))
```

Within MEK group, no gene expression was correlated with Selumetinib response

### 16.5.5 Enrichment heatmaps for MEK group

Plot for C6 gene sets

```
pCut = 0.05
corResult.sig <- filter(corResult, p <= pCut)
c6Plot <- plotSetHeatmap(geneTab=statTab[["MEKnone"]],
                enrichTab=c6Res[["MEKnone"]],
                topN=5, gmtFile=gmts[["C6"]],
                anno=TRUE, i)
```

![](data:image/png;base64...)

Plot for Hallmark gene sets

```
hallmarkPlot <- plotSetHeatmap(geneTab=statTab[["MEKnone"]],
                enrichTab=hallmarkRes[["MEKnone"]],
                topN=5, gmtFile=gmts[["H"]],
                asterixList = corResult.sig,
                anno=TRUE, i)
```

![](data:image/png;base64...)

---

```
options(stringsAsFactors=FALSE)
```

# 17 Single associations of drug response with gene mutation or type of disease (IGHV included)

We univariantly tested different features (explained in detail below) for their associations with the drug response using Student t-test (two-sided, with equal variance). Each concentration was tested separately. The minimal size of the compared groups was set to 3. p-values were adjusted for multiple testing by applying the Benjamini-Hochberg procedure. Adjusted p-values were then used for setting the significance threshold.

Loading the data.

```
data(list=c("drpar", "patmeta", "drugs", "mutCOM", "conctab"))
```

## 17.1 Function which test associations of interest

Below is a general function with which all the tests for single associations were performed.

```
testFactors = function(msrmnt, factors, test="student", batch=NA) {

  # cut out the data
  tmp = colnames(factors)
  factors = data.frame(factors[rownames(msrmnt),], check.names=FALSE)
  colnames(factors) = tmp
  for(cidx in 1:ncol(factors))
    factors[,cidx] = factor(factors[,cidx], levels=c(0,1))

  # calculate the group size
  groupSizes = do.call(rbind, lapply(factors, function(tf) {
    tmp = table(tf)
    data.frame(n.0=tmp["0"], n.1=tmp["1"])
  }))

  # remove the factors with less then 2 cases per group
  factors = factors[,names(which(apply(groupSizes, 1,
                                       function(i) all(i>2)))), drop=FALSE]

  # calculate the effect
  effect = do.call(rbind, lapply(colnames(factors), function(tf) {
    tmp = aggregate(msrmnt ~ fac, data=data.frame(fac=factors[,tf]), mean)
    rownames(tmp) = paste("mean", tmp$fac, sep=".")
    tmp = t(tmp[2:ncol(tmp)])
    data.frame(TestFac=tf,
               DrugID=rownames(tmp),
               FacDr=paste(tf, rownames(tmp), sep="."),
               n.0=groupSizes[tf,"n.0"], n.1=groupSizes[tf,"n.1"],
               tmp, WM=tmp[,"mean.0"]-tmp[,"mean.1"])
  }))

  # do the test
  T = if(test=="student") {
    do.call(rbind, lapply(colnames(factors), function(tf) {
      tmp = do.call(rbind, lapply(colnames(msrmnt), function(dr) {
        res = t.test(msrmnt[,dr] ~ factors[,tf], var.equal=TRUE)
        data.frame(DrugID=dr, TestFac=tf,
                   pval=res$p.value, t=res$statistic,
                   conf1=res$conf.int[1], conf2=res$conf.int[2])
      }))
      tmp
    }))
  } else if(test=="anova") {
    do.call(rbind, lapply(colnames(factors), function(tf) {
      tmp = do.call(rbind, lapply(colnames(msrmnt), function(dr) {
        # make sure that the order in batch is the same as in msrmnt
        stopifnot(identical(rownames(msrmnt), names(batch)))
        res = anova(lm(msrmnt[,dr] ~ factors[,tf]+batch))
        data.frame(DrugID=dr, TestFac=tf, pval=res$`Pr(>F)`[1],
                   f=res$`F value`[1], meanSq1=res$`Mean Sq`[1],
                   meanSq2=res$`Mean Sq`[2])
      }))
      tmp
    }))
  } else {
    NA
  }

  enhanceObject = function(obj) {
    # give nice drug names
    obj$Drug = giveDrugLabel(obj$DrugID, conctab, drugs)
    # combine the testfac and drug id
    obj$FacDr = paste(obj$TestFac, obj$DrugID, sep=".")
    # select just the drug name
    obj$DrugID2 = substring(obj$DrugID, 1, 5)
    obj
  }

  list(effect=effect, test=enhanceObject(T))
}
```

## 17.2 Associations of *ex vivo* drug responses with genomic features in CLL

### 17.2.1 Prepare objects for testing

```
## VIABILITIES
## list of matrices; one matrix per screen/day
## each matrix contains all CLL patients
measurements=list()

### Main Screen
patM = colnames(drpar)[which(patmeta[colnames(drpar),"Diagnosis"]=="CLL")]
measurements[["main"]] =
  do.call(cbind,
          lapply(list("viaraw.1","viaraw.2","viaraw.3","viaraw.4","viaraw.5"),
                 function(viac) {
  tmp = t(assayData(drpar)[[viac]][,patM])
  colnames(tmp) = paste(colnames(tmp), conctab[colnames(tmp),
            paste0("c",substring(viac,8,8))], sep="-")
  tmp
}))

pats = sort(unique(patM))

## TESTING FACTORS
testingFactors = list()
# ighv
ighv = setNames(patmeta[pats, "IGHV"], nm=pats)
# mutations
tmp = cbind(IGHV=ifelse(ighv=="U",1,0), assayData(mutCOM)$binary[pats,])
testingFactors[["mutation"]] = tmp[,-grep("Chromothripsis", colnames(tmp))]

# BATCHES
j = which(pData(drpar)[patM, "ExpDate"] < as.Date("2014-01-01"))
k = which(pData(drpar)[patM, "ExpDate"] < as.Date("2014-08-01") &
            pData(drpar)[patM, "ExpDate"] > as.Date("2014-01-01"))
l = which(pData(drpar)[patM, "ExpDate"] > as.Date("2014-08-01"))

measurements[["main"]] = measurements[["main"]][c(patM[j], patM[k], patM[l]),]
batchvec = factor(
  setNames(c(rep(1, length(j)), rep(2, length(k)), rep(3, length(l))),
           nm=c(patM[j], patM[k], patM[l])))

# LABELS FOR GROUPING
beelabs = t(sapply(colnames(testingFactors[["mutation"]]), function(fac) {
  if(fac=="IGHV")
    c(`0`="IGHV mut", `1`="IGHV unmut")
  else if(grepl("[[:upper:]]",fac)) # if all letters are uppercase
    c(`0`=paste(fac, "wt"),`1`=paste(fac, "mt"))
  else
    c(`0`="wt",`1`=fac)
}))
```

### 17.2.2 Assesment of importance of batch effect

We first used the approach explained in the introduction section to test for associations between drug viability assay results and genomic features, which comprised: somatic mutations (aggregated at the gene level), copy number aberrations and IGHV status.

```
allresultsT = testFactors(msrmnt=measurements[["main"]],
                          factors=testingFactors[["mutation"]],
                          test="student", batch=NA)

resultsT = allresultsT$test
resultsT$adj.pval = p.adjust(resultsT$pval, method="BH")
```

However, we ware aware that the main screen was performed in three groups of batches over a time period of 1.5 years; these comprise, respectively, the samples screened in 2013, in 2014 before August and in 2014 in August and September. Therefore, to control for confounding by the different batch groups we repeated the drug-feature association tests using batch group as a blocking factor and a two-way ANOVA test.

```
allresultsA = testFactors(msrmnt=measurements[["main"]],
                          factors=testingFactors[["mutation"]],
                          test="anova", batch=batchvec)

resultsA = allresultsA$test
resultsA$adj.pval = p.adjust(resultsA$pval, method="BH")
```

We then compared the p-values from both tests.

![](data:image/png;base64...)

Only one drug, bortezomib, showed discrepant p-values, and exploration of its data suggested that it lost its activity during storage. The data for this drug and NSC 74859 were discarded from further analysis.

```
badrugs = c("D_008", "D_025")

measurements = lapply(measurements, function(drres) {
  drres[,-grep(paste(badrugs, collapse="|"), colnames(drres))]
})
```

For all remaining associations, testing with and without batch as a blocking factor yielded equivalent results. Therefore, all reported p-values for associations come from the t-tests without using blocking for batch effects.

### 17.2.3 Associations of drug response with mutations in CLL

We tested for associations between drug viability assay results and genomic features (43 features for the pilot screen and 63 for the main screen). p-values were adjusted for multiple testing by applying the Benjamini-Hochberg procedure, separately for the main screen and for each of the two incubation times of the pilot screen.

```
allresults1 = lapply(measurements, function(measurement) {
  testFactors(msrmnt=measurement, factors=testingFactors[["mutation"]],
              test="student", batch=NA)
})

effects1 = lapply(allresults1, function(res) res[["effect"]])
results1 = lapply(allresults1, function(res) res[["test"]])

results1 = lapply(results1, function(res) {
  res$adj.pval = p.adjust(res$pval, method="BH")
  res
})
```

```
measurements1 = measurements
testingFactors1 = testingFactors
beelabs1 = beelabs
```

### 17.2.4 Volcano plots: summary of the results

In this section we summarize all significant associations for a given mutation in a form of volcano plots. The pink color spectrum indicates a resistant phenotype and the blue color spectrum a sensitive phenotype in the presence of the tested mutation. FDR of 10 % was used.

IGHV.
![](data:image/png;base64...)

![](data:image/png;base64...)

Trisomy 12.
![](data:image/png;base64...)

![](data:image/png;base64...)

## 17.3 Associations of drug responses with genomic features in CLL independently of IGHV status

To assess associations between drug effects and genomic features independently of IGHV status, we performed the analyses separately within U-CLL and M-CLL samples. These analyses were only performed if 3 or more samples carried the analyzed feature within both M-CLL and U-CLL subgroups.

Find out which factors we will be testing (with threshold >2 patients in each of the four groups).

```
fac2test = lapply(measurements, function(mea) {
  tf = testingFactors[["mutation"]][rownames(mea),]
  names(which(apply(tf,2,function(i) {
    if(length(table(i,tf[,1]))!=4)
      FALSE
    else
      all(table(i,tf[,1])>2)
  })))
})
```

Construct the table with drug responses.

```
measurements2 = setNames(lapply(names(measurements), function(mea) {
  ig = testingFactors[["mutation"]][rownames(measurements[[mea]]),"IGHV"]
  patU = names(which(ig==1))
  patM = names(which(ig==0))
  list(U=measurements[[mea]][patU,], M=measurements[[mea]][patM,])
}), nm=names(measurements))
```

Testing.

```
allresults2 = setNames(lapply(names(measurements2), function(mea) {
  list(U = testFactors(msrmnt=measurements2[[mea]]$U,
                       factors=testingFactors[["mutation"]][
                         rownames(measurements2[[mea]]$U),fac2test[[mea]]]),
  M = testFactors(msrmnt=measurements2[[mea]]$M,
                  factors=testingFactors[["mutation"]][
                    rownames(measurements2[[mea]]$M),fac2test[[mea]]]))
}), nm=names(measurements2))
```

Divide results to list of effects and list of results.

```
results2 = lapply(allresults2, function(allres) {
  list(U=allres[["U"]][["test"]], M=allres[["M"]][["test"]])
})

effects2 = lapply(allresults2, function(allres) {
  list(U=allres[["U"]][["effect"]], M=allres[["M"]][["effect"]])
})
```

p-values were adjusted for multiple testing by applying the Benjamini-Hochberg procedure to joined results for M-CLL and U-CLL for each screen separately.

```
results2 = lapply(results2, function(res) {
  tmp = p.adjust(c(res$U$pval,res$M$pval), method="BH")
  l = length(tmp)
  res$U$adj.pval = tmp[1:(l/2)]
  res$M$adj.pval = tmp[(l/2+1):l]
  res
})
```

```
testingFactors2 = testingFactors
beelabs2 = beelabs
```

As an example we show the summary of the results for trisomy 12.

Trisomy 12 - IGHV unmutated.
![](data:image/png;base64...)

![](data:image/png;base64...)

Trisomy 12 - IGHV mutated.
![](data:image/png;base64...)

![](data:image/png;base64...)

## 17.4 Drug response dependance on cell origin of disease

We tested for drug sensitivity differences between different disease entities. The largest group, the CLL samples, was used as the baseline for these comparisons. Here, we compared drug sensitivities across studied diseases entities against all CLL samples Only groups with 3 or more data points were considered (T-PLL, AML, MZL, MCL, B-PLL, HCL, LPL and healthy donor cells hMNC). p-values were adjusted for multiple testing by applying the Benjamini-Hochberg procedure to results for each disease entity separately.

Here we prepare the data for testing the drug response dependence on cell origin of disease.

```
## VIABILITIES
### main
pats = colnames(drpar)
# make the big matrix with viabilities
measureTMP = do.call(cbind,
                     lapply(list("viaraw.1","viaraw.2","viaraw.3",
                                 "viaraw.4","viaraw.5"), function(viac) {
  tmp = t(assayData(drpar)[[viac]][,pats])
  colnames(tmp) = paste(colnames(tmp),
                        conctab[colnames(tmp),
                                paste0("c",substring(viac,8,8))], sep="-")
  tmp
}))

# select diagnosis to work on
pats4diag = tapply(pats, patmeta[pats,"Diagnosis"], function(i) i)

diags = names(which(table(patmeta[pats,"Diagnosis"])>2))
diags = diags[-which(diags=="CLL")]
# there will be two lists: one with CLL and the second with other diagnosis
# (first one is passed as argument to the createObjects function)
pats4diag2 = pats4diag[diags]

# function that creates testingFactors, measurements and beelabs
createObjects = function(pats4diag1, beefix="") {

  measurements=list()
  testingFactors=list()
  # make the list for testing
  for(m in names(pats4diag1)) {
    for(n in names(pats4diag2)) {
      p1 = pats4diag1[[m]]
      p2 = pats4diag2[[n]]
      measurements[[paste(m,n,sep=".")]] = measureTMP[c(p1, p2),]
      testingFactors[[paste(m,n,sep=".")]] = setNames(c(rep(0,length(p1)),
                                                        rep(1,length(p2))),
                                                      nm=c(p1,p2))
    }
  }

  # reformat testingFactors to the df
  pats=sort(unique(c(unlist(pats4diag1),unlist(pats4diag2))))
  testingFactors = as.data.frame(
    do.call(cbind, lapply(testingFactors, function(tf) {
    setNames(tf[pats], nm=pats)
  })))

  # Labels for beeswarms
  beelabs = t(sapply(colnames(testingFactors), function(fac) {
    tmp = unlist(strsplit(fac, ".", fixed=TRUE))
    c(`0`=paste0(tmp[1], beefix),`1`=tmp[2])
  }))

  return(list(msrmts=measurements, tf=testingFactors, bl=beelabs))
}

# all CLL together
res = createObjects(pats4diag1=pats4diag["CLL"])
measurements3 = res$msrmts
testingFactors3 = res$tf
beelabs3 = res$bl
```

Testing.

```
allresults3 = setNames(lapply(names(measurements3), function(mea) {
  tmp = data.frame(testingFactors3[,mea])
  colnames(tmp) = mea
  rownames(tmp) = rownames(testingFactors3)
  testFactors(msrmnt=measurements3[[mea]], factors=tmp)
}), nm=names(measurements3))
```

Divide results to list of effects and list of t-test results.

```
results3 = lapply(allresults3, function(res) res[["test"]])
effects3 = lapply(allresults3, function(res) res[["effect"]])
```

Adjust p-values.

```
results3 = lapply(results3, function(res) {
  res$adj.pval = p.adjust(res$pval, method="BH")
  res
})
```

We summarize the result as a heat map.

![](data:image/png;base64...)

![](data:image/png;base64...)

# 18 Effect of mutation on drug response - examples

```
data(drugs, lpdAll, mutCOM, conctab)
```

```
lpdCLL = lpdAll[ , lpdAll$Diagnosis %in% "CLL"]
```

Here we highlight the selection of mutation-drug response associations within the different disease subtypes.

```
#FIG# 4D
BloodCancerMultiOmics2017:::beeF(diag="CLL", "D_010_2", "TP53", cs=T, y1=0, y2=1.2, custc=T)
```

![](data:image/png;base64...)

```
BloodCancerMultiOmics2017:::beeF(diag="CLL", "D_006_3", "TP53", cs=T,y1=0, y2=1.2, custc=T)
```

![](data:image/png;base64...)

```
BloodCancerMultiOmics2017:::beeF(diag="CLL", "D_063_5", "CREBBP", cs=T, y1=0, y2=1.2, custc=T)
```

![](data:image/png;base64...)

```
BloodCancerMultiOmics2017:::beeF(diag="CLL", "D_056_5", "PRPF8", cs=T, y1=0, y2=1.2, custc=T)
```

![](data:image/png;base64...)

```
BloodCancerMultiOmics2017:::beeF(diag="CLL", "D_012_5", "trisomy12", cs=F,y1=0.6, y2=1.2, custc=T)
```

![](data:image/png;base64...)

```
#FIG# S17
par(mfrow = c(3,4), mar=c(5,4.5,5,2))

BloodCancerMultiOmics2017:::beeF(diag="CLL", drug="D_159_3", mut="TP53", cs=T, y1=0, y2=1.2, custc=T)
BloodCancerMultiOmics2017:::beeF(diag="CLL", "D_006_2", "del17p13", cs=T, y1=0, y2=1.2, custc=T)
BloodCancerMultiOmics2017:::beeF(diag="CLL", "D_159_3", "del17p13", cs=T, y1=0, y2=1.2, custc=T)
BloodCancerMultiOmics2017:::beeF(diag="CLL", "D_010_2", "del17p13", cs=T, y1=0, y2=1.2, custc=T)
BloodCancerMultiOmics2017:::beeF(diag="MCL", "D_006_2", "TP53", cs=T,  y1=0, y2=1.2, custc=T)
BloodCancerMultiOmics2017:::beeF(diag="MCL", "D_010_2", "TP53", cs=T,  y1=0, y2=1.2, custc=T)
BloodCancerMultiOmics2017:::beeF(diag=c("HCL", "HCL-V"), "D_012_3", "BRAF", cs=T, y1=0, y2=1.2,
            custc=F)
BloodCancerMultiOmics2017:::beeF(diag=c("HCL", "HCL-V"), "D_083_4", "BRAF", cs=T, y1=0, y2=1.2,
            custc=F)
BloodCancerMultiOmics2017:::beeF(diag="CLL", "D_012_5", "KRAS", cs=T, y1=0.6, y2=1.2, custc=T)
BloodCancerMultiOmics2017:::beeF(diag="CLL", "D_083_5", "KRAS", cs=T, y1=0.6, y2=1.45, custc=T)
BloodCancerMultiOmics2017:::beeF(diag="CLL", "D_081_4", "UMODL1", cs=T,  y1=0, y2=1.2, custc=T)
BloodCancerMultiOmics2017:::beeF(diag="CLL", "D_001_4", "UMODL1", cs=T,  y1=0, y2=1.2, custc=T)
```

![](data:image/png;base64...)

![](data:image/png;base64...)

Bee swarms for pretreatment.

```
#FIG# S18
par(mfrow = c(2,3), mar=c(5,4.5,2,2))

BloodCancerMultiOmics2017:::beePretreatment(lpdCLL, "D_006_1:5", y1=0.2, y2=1.3, fac="TP53",
                       val=c(0,1), name="Fludarabine")
BloodCancerMultiOmics2017:::beePretreatment(lpdCLL, "D_006_1:5", y1=0.2, y2=1.3, fac="TP53",
                       val=c(0),   name="p53 wt:  Fludarabine")
BloodCancerMultiOmics2017:::beePretreatment(lpdCLL, "D_006_1:5", y1=0.2, y2=1.3, fac="TP53",
                       val=c(1),   name="p53 mut: Fludarabine")

BloodCancerMultiOmics2017:::beePretreatment(lpdCLL, "D_002_4:5", y1=0.4, y2=1.3,
                       fac="IGHV Uppsala U/M", val=c(0,1), name="Ibrutinib")
BloodCancerMultiOmics2017:::beePretreatment(lpdCLL, "D_002_4:5", y1=0.4, y2=1.3,
                       fac="IGHV Uppsala U/M", val=c(0), name="U-CLL: Ibrutinib")
BloodCancerMultiOmics2017:::beePretreatment(lpdCLL, "D_002_4:5", y1=0.4, y2=1.3,
                       fac="IGHV Uppsala U/M", val=c(1), name="M-CLL: Ibrutinib")
```

![](data:image/png;base64...)

---

```
options(stringsAsFactors=FALSE)
```

# 19 Associations of drug responses with mutations in CLL (IGHV not included)

In this part, we use both gene mutations and chromosome aberrations to test for gene-drug response associations. In contrast to the analysis done previously, we exclude IGHV status from testing. Additionally, we use information on patient treatment status to account for its effect on drug response screening.

## 19.1 Additional functions

Accessor functions:

```
# get drug responsee data
get.drugresp <- function(lpd) {
  drugresp = t(Biobase::exprs(lpd[fData(lpd)$type == 'viab'])) %>%
    dplyr::tbl_df() %>% dplyr::select(-ends_with(":5")) %>%
    dplyr::mutate(ID = colnames(lpd)) %>%
    tidyr::gather(drugconc, viab, -ID) %>%
    dplyr::mutate(drug = drugs[substring(drugconc, 1, 5), "name"],
           conc = sub("^D_([0-9]+_)", "", drugconc)) %>%
    dplyr::mutate(conc = as.integer(gsub("D_CHK_", "", conc)))

  drugresp
}

# extract mutations and IGHV status
get.somatic <- function(lpd) {
  somatic = t(Biobase::exprs(lpd[Biobase::fData(lpd)$type == 'gen' |
                                   Biobase::fData(lpd)$type == 'IGHV']))
  ## rename IGHV Uppsala to 'IGHV' (simply)
  colnames(somatic)[grep("IGHV", colnames(somatic))] = "IGHV"

  ## at least 3 patients should have this mutation
  min.samples = which(Matrix::colSums(somatic, na.rm = T) > 2)
  somatic = dplyr::tbl_df(somatic[, min.samples]) %>%
    dplyr::select(-one_of("del13q14_bi", "del13q14_mono",
                          "Chromothripsis", "RP11-766F14.2")) %>%
    dplyr::rename(del13q14 = del13q14_any) %>%
    dplyr::mutate(ID = colnames(lpd)) %>%
    tidyr::gather(mutation, mut.value, -ID)
  somatic
}
```

Define the ggplot themes

```
t1<-theme(
  plot.background = element_blank(),
  panel.grid.major = element_line(),
  panel.grid.major.x = element_line(linetype = "dotted", colour = "grey"),
  panel.grid.minor = element_blank(),
  panel.border = element_blank(),
  panel.background = element_blank(),
  axis.line = element_line(size=.4),
  axis.line.x = element_line(),
  axis.line.y = element_line(),
  axis.text.x  = element_text(angle=90, size=12,
                              face="bold", hjust = 1, vjust = 0.4),
  axis.text.y = element_text(size = 14),
  axis.ticks.x = element_line(linetype = "dotted"),
  axis.ticks.length = unit(0.3,"cm"),
  axis.title.x = element_text(face="bold", size=16),
  axis.title.y = element_text(face="bold", size=20),
  plot.title = element_text(face="bold", size=16, hjust = 0.5)
)

## theme for the legend
t.leg <-  theme(legend.title = element_text(face='bold',
                                            hjust = 1, size=11),
                legend.position = c(0, 0.76),
                legend.key = element_blank(),
                legend.text = element_text(size=12),
                legend.background = element_rect(color = "black"))
```

Define the main color palette:

```
colors= c("#015872","#3A9C94","#99977D","#ffbf00","#5991C7","#99cc00",
          "#D5A370","#801416","#B2221C","#ff5050","#33bbff","#5c5cd6",
          "#E394BB","#0066ff","#C0C0C0")
```

Get pretreatment status:

```
get.pretreat <- function(patmeta, lpd) {
  patmeta = patmeta[rownames(patmeta) %in% colnames(lpd),]
  data.frame(ID=rownames(patmeta), pretreat=!patmeta$IC50beforeTreatment) %>%
    mutate(pretreat = as.factor(pretreat))

}
```

Merge drug response, pretreatment information and somatic mutation data sets

```
make.dr <- function(resp, features, patmeta, lpd) {
  treat = get.pretreat(patmeta, lpd)
  dr = full_join(resp, features) %>%
    inner_join(treat)
}
```

Summarize viabilities using Tukey’s medpolish

```
get.medp <- function(drugresp) {
  tab = drugresp %>% group_by(drug, conc) %>%
    do(data.frame(v = .$viab, ID = .$ID)) %>% spread(ID, v)

  med.p = foreach(n=unique(tab$drug), .combine = cbind) %dopar% {
    tb = filter(tab, drug == n) %>% ungroup() %>% dplyr::select(-(drug:conc)) %>%
      as.matrix %>% `rownames<-`(1:5)
    mdp = stats::medpolish(tb)
    df = as.data.frame(mdp$col) + mdp$overall
    colnames(df) <- n
    df
  }

  medp.viab = dplyr::tbl_df(med.p) %>% dplyr::mutate(ID = rownames(med.p)) %>%
    tidyr::gather(drug, viab, -ID)
  medp.viab
}
```

Process labels for the legend:

```
get.labels <- function(pvals) {
  lev = levels(factor(pvals$mutation))
  lev = gsub("^(gain)([0-9]+)([a-z][0-9]+)$", "\\1(\\2)(\\3)", lev)
  lev =  gsub("^(del)([0-9]+)([a-z].+)$", "\\1(\\2)(\\3)", lev)
  lev = gsub("trisomy12", "trisomy 12", lev)
  lev
}
```

Get order of mutations

```
get.mutation.order <- function(lev) {
  ord = c("trisomy 12", "TP53",
          "del(11)(q22.3)", "del(13)(q14)",
          "del(17)(p13)",
          "gain(8)(q24)",
          "BRAF", "CREBBP", "PRPF8",
          "KLHL6", "NRAS", "ABI3BP", "UMODL1")
  mut.order = c(match(ord, lev),
                grep("Other", lev), grep("Below", lev))

  mut.order
}
```

Group drugs by pathway/target

```
get.drug.order <- function(pvals, drugs) {
  ## determine drug order by column sums of log-p values
  dr.order = pvals %>%
    mutate(logp = -log10(p.value)) %>%
    group_by(drug) %>% summarise(logsum = sum(logp))

  dr.order = inner_join(dr.order, pvals %>%
                          group_by(drug) %>%
                          summarise(n = length(unique(mutation)))) %>%
    arrange(desc(n), desc(logsum))

  dr.order = inner_join(dr.order, drugs %>% rename(drug = name))

  dr.order = left_join(dr.order, dr.order %>%
                         group_by(`target_category`) ) %>%
    arrange(`target_category`, drug) %>%
    filter(! `target_category` %in% c("ALK", "Angiogenesis", "Other")) %>%
    filter(!is.na(`target_category`))

  dr.order
}
```

Add pathway annotations for selected drug classes

```
make.annot <- function(g, dr.order) {
  # make a color palette for drug pathways
  drug.class = c("#273649", "#647184", "#B1B2C8",
                 "#A7755D", "#5D2E1C", "#38201C")
  pathways = c("BH3","B-cell receptor","DNA damage",
               "MAPK", "PI3K", "Reactive oxygen species")
  names(pathways) = c("BH3", "BCR inhibitors", "DNA damage",
                      "MAPK", "PI3K", "ROS")

  for (i in 1:6) {
    prange = grep(pathways[i], dr.order$`target_category`)
    path.grob <- grobTree(rectGrob(gp=gpar(fill=drug.class[i])),
                          textGrob(names(pathways)[i],
                                   gp = gpar(cex =0.8, col = "white")))
    g = g +
      annotation_custom(path.grob,
                        xmin = min(prange) -0.25 - 0.1 * ifelse(i == 2, 1, 0),
                        xmax = max(prange) + 0.25 + 0.1 * ifelse(i == 2, 1, 0),
                        ymin = -0.52, ymax = -0.2)
  }
  g
}
```

Define a function for `glegend`

```
g_legend<-function(a.gplot){
  tmp <- ggplot_gtable(ggplot_build(a.gplot))
  leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
  legend <- tmp$grobs[[leg]]
  legend
} ## end define
```

## 19.2 Data setup

Load the data.

```
data(list=c("conctab", "drugs", "lpdAll", "patmeta"))
```

Get drug response data.

```
lpdCLL <- lpdAll[ , lpdAll$Diagnosis=="CLL"]
## extract viability data for 5 different concentrations
drugresp = get.drugresp(lpdCLL)
```

```
## Warning: `tbl_df()` was deprecated in dplyr 1.0.0.
## ℹ Please use `tibble::as_tibble()` instead.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

Get somatic mutations and structural variants.

```
## extract somatic variants
somatic = get.somatic(lpdCLL) %>%
  mutate(mut.value = as.factor(mut.value))
```

```
## Warning: `tbl_df()` was deprecated in dplyr 1.0.0.
## ℹ Please use `tibble::as_tibble()` instead.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

## 19.3 Test for drug-gene associations

Summarize drug response using median polish.

```
## compute median polish patient effects and recalculate p-values
medp.viab = get.medp(drugresp)
dr = make.dr(medp.viab, somatic, patmeta, lpdCLL)
```

```
## Joining with `by = join_by(ID)`
## Joining with `by = join_by(ID)`
```

Calculate \(p\) values and FDR (10%).

```
pvals = dr %>% group_by(drug, mutation) %>%
  do(tidy(t.test(viab ~ mut.value, data = ., var.equal = T))) %>%
  dplyr::select(drug, mutation, p.value)

# compute the FDR threshold
fd.thresh = 10
padj = p.adjust(pvals$p.value, method = "BH")
fdr = max(pvals$p.value[which(padj <= fd.thresh/100)])
```

Remove unnecessary mutations and bad drugs.

```
# selected mutations
select.mutations = c("trisomy12", "TP53",
        "del11q22.3", "del13q14",
        "del17p13",
        "gain8q24",
        "BRAF", "CREBBP", "PRPF8",
        "KLHL6", "NRAS", "ABI3BP", "UMODL1")

pvals = filter(pvals, mutation != 'IGHV')
pvals = pvals %>% ungroup() %>%
  mutate(mutation = ifelse(p.value > fdr,
                           paste0("Below ", fd.thresh,"% FDR"), mutation)) %>%
  mutate(mutation = ifelse(!(mutation %in% select.mutations) &
                             !(mutation == paste0("Below ", fd.thresh,"% FDR")),
                           "Other", mutation)) %>%
  filter(drug != "bortezomib" & drug != "NSC 74859")
```

Reshape names of genomic rearrangements.

```
## order of mutations
lev = get.labels(pvals)
folge = get.mutation.order(lev)
```

Set order of drugs.

```
drugs = drugs[,c("name", "target_category")]
# get the drug order
dr.order = get.drug.order(pvals, drugs)
```

```
## Joining with `by = join_by(drug)`
## Joining with `by = join_by(drug)`
## Joining with `by = join_by(drug, logsum, n, target_category)`
```

## 19.4 Plot results

### 19.4.1 Main Figure

Function for generating the figure.

```
plot.pvalues <- function(pvals, dr.order, folge, colors, shapes) {
  g = ggplot(data = filter(pvals, drug %in% dr.order$drug)) +
  geom_point(aes(x = factor(drug, levels = dr.order$drug), y = -log10(p.value),
                 colour = factor(mutation, levels(factor(mutation))[folge]),
                 shape  = factor(mutation, levels(factor(mutation))[folge])),
             size=5, show.legend = T)  +
  scale_color_manual(name = "Mutations",
                     values = colors,
                     labels = lev[folge]) +
  scale_shape_manual(name = "Mutations",
                     values = shapes,
                     labels = lev[folge]) + t1 +
  labs(x = "", y = expression(paste(-log[10], "p")), title = "") +
    scale_y_continuous(expression(italic(p)*"-value"),
                       breaks=seq(0,10,5),
                       labels=math_format(expr=10^.x)(-seq(0,10,5)))
  g
}
```

```
#FIG# 4A
## plot the p-values
g = plot.pvalues(pvals, dr.order, folge,
                 colors, shapes = c(rep(16,13), c(1,1)))

## add FDR threshold
g = g + geom_hline(yintercept = -log10(fdr),
                   linetype="dashed", size=0.3)

g = g +
  annotation_custom(grob = textGrob(label = paste0("FDR", fd.thresh, "%"),
                                    hjust = 1, vjust = 1,
                                    gp = gpar(cex = 0.5,
                                              fontface = "bold",
                                              fontsize = 25)),
                    ymin = -log10(fdr) - 0.2,
                    ymax = -log10(fdr) + 0.5,
                    xmin = -1.3, xmax = 1.5) +
  theme(legend.position = "none")

# generate pathway/target annotations for certain drug classes
#g = make.annot(g, dr.order)

# legend guide
leg.guides <- guides(colour = guide_legend(ncol = 1,
                                           byrow = TRUE,
                                           override.aes = list(size = 3),
                                           title = "Mutations",
                                           label.hjust = 0,
                                           keywidth = 0.4,
                                           keyheight = 0.8),
                      shape = guide_legend(ncol = 1,
                                           byrow = TRUE,
                                           title = "Mutations",
                                           label.hjust = 0,
                                           keywidth = 0.4,
                                           keyheight = 0.8))

# create a legend grob
legend = g_legend(g + t.leg +  leg.guides)

## arranget the main plot and the legend
# using grid graphics
gt <- ggplot_gtable(ggplot_build(g + theme(legend.position = 'none')))
gt$layout$clip[gt$layout$name == "panel"] <- "off"

grid.arrange(gt, legend,
             ncol=2, nrow=1, widths=c(0.92,0.08))
```

![](data:image/png;base64...)

### 19.4.2 Supplementary Figure (incl. pretreatment)

In the supplementary figure we use pretreatment status as a blocking factor, i.e. we model drug sensitivity - gene variant associations as: `lm(viability ~ mutation + pretreatment)`

```
## lm(viab ~ mutation + pretreatment.status)
pvals = dr %>% group_by(drug, mutation) %>%
  do(tidy(lm(viab ~ mut.value + pretreat, data = .))) %>%
  filter(term == 'mut.value1') %>%
  dplyr::select(drug, mutation, p.value)

# compute the FDR threshold
fd.thresh = 10
padj = p.adjust(pvals$p.value, method = "BH")
fdr = max(pvals$p.value[which(padj <= fd.thresh/100)])

pvals = filter(pvals, mutation != 'IGHV')
pvals = pvals %>% ungroup() %>%
  mutate(mutation = ifelse(p.value > fdr,
                           paste0("Below ", fd.thresh,"% FDR"),
                           mutation)) %>%
  mutate(mutation = ifelse(!(mutation %in% select.mutations) &
                             !(mutation == paste0("Below ",
                                                  fd.thresh,"% FDR")),
                           "Other", mutation)) %>%
  filter(drug != "bortezomib" & drug != "NSC 74859")

lev = get.labels(pvals)
folge = get.mutation.order(lev)

# get the drug order
dr.order = get.drug.order(pvals, drugs)
```

```
## Joining with `by = join_by(drug)`
## Joining with `by = join_by(drug)`
## Joining with `by = join_by(drug, logsum, n, target_category)`
```

```
mut.order = folge[!is.na(folge)]
```

After recomputing the \(p\)-values (using a linear model that accounts for pretreatment status), plot the figure:

```
#FIG# S19
## plot the p-values
g = plot.pvalues(pvals, dr.order, mut.order,
                 colors[which(!is.na(folge))], shapes = c(rep(16,9), c(1,1)))

## add FDR threshold
g = g + geom_hline(yintercept = -log10(fdr),
                   linetype="dashed", size=0.3)

g = g +
  annotation_custom(grob = textGrob(label = paste0("FDR", fd.thresh, "%"),
                                    hjust = 1, vjust = 1,
                                    gp = gpar(cex = 0.5,
                                              fontface = "bold",
                                              fontsize = 25)),
                    ymin = -log10(fdr) - 0.2,
                    ymax = -log10(fdr) + 0.5,
                    xmin = -1.3, xmax = 1.5) +
  theme(legend.position = "none")

# generate pathway/target annotations for certain drug classes
#g = make.annot(g, dr.order)

# legend guide
leg.guides <- guides(colour = guide_legend(ncol = 1,
                                           byrow = TRUE,
                                           override.aes = list(size = 3),
                                           title = "Mutations",
                                           label.hjust = 0,
                                           keywidth = 0.4,
                                           keyheight = 0.8),
                      shape = guide_legend(ncol = 1,
                                           byrow = TRUE,
                                           title = "Mutations",
                                           label.hjust = 0,
                                           keywidth = 0.4,
                                           keyheight = 0.8))

# create a legend grob
legend = g_legend(g + t.leg +  leg.guides)

## arranget the main plot and the legend
# using grid graphics
gt <- ggplot_gtable(ggplot_build(g + theme(legend.position = 'none')))
gt$layout$clip[gt$layout$name == "panel"] <- "off"

grid.arrange(gt, legend,
             ncol=2, nrow=1, widths=c(0.92,0.08))
```

![](data:image/png;base64...)

## 19.5 Comparison of \(P\)-Values

```
pvals.main = dr %>% group_by(drug, mutation) %>%
  do(tidy(t.test(viab ~ mut.value, data = ., var.equal = T))) %>%
  dplyr::select(drug, mutation, p.value)

p.main.adj = p.adjust(pvals.main$p.value, method = "BH")
fdr.main = max(pvals.main$p.value[which(p.main.adj <= fd.thresh/100)])

pvals.main = filter(pvals.main, mutation != "IGHV") %>%
             rename(p.main = p.value)

## lm(viab ~ mutation + pretreatment.status)
pvals.sup = dr %>% group_by(drug, mutation) %>%
  do(tidy(lm(viab ~ mut.value + pretreat, data = .))) %>%
  filter(term == 'mut.value1') %>%
  dplyr::select(drug, mutation, p.value)

p.sup.adj = p.adjust(pvals.sup$p.value, method = "BH")
fdr.sup = max(pvals.sup$p.value[which(p.sup.adj <= fd.thresh/100)])

pvals.sup = filter(pvals.sup, mutation != "IGHV") %>%
  rename(p.sup = p.value)

pvals = inner_join(pvals.main, pvals.sup)
```

```
## Joining with `by = join_by(drug, mutation)`
```

```
pvals = mutate(pvals, signif = ifelse(p.main > fdr.main,
                                      ifelse(p.sup > fdr.sup,
                                             "Below 10% FDR in both models",
                                             "Significant with pretreatment accounted"),
                                      ifelse(p.sup > fdr.sup,
                                             "Significant without pretreatment in the model",
                                             "Significant in both models")))

t2<-theme(
  plot.background = element_blank(),
  panel.grid.major = element_line(),
  panel.grid.major.x = element_line(),
  panel.grid.minor = element_blank(),
  panel.border = element_blank(),
  panel.background = element_blank(),
  axis.line = element_line(size=.4),
  axis.line.x = element_line(),
  axis.line.y = element_line(),
  axis.text.x  = element_text(size=12),
  axis.text.y = element_text(size = 12),
  axis.title.x = element_text(face="bold", size=12),
  axis.title.y = element_text(face="bold", size=12),
  legend.title = element_text(face='bold',
                                            hjust = 1, size=10),
  legend.position = c(0.78, 0.11),
  legend.key = element_blank(),
  legend.text = element_text(size=10),
  legend.background = element_rect(color = "black")
)
```

```
#FIG# S19
ggplot(pvals, aes(-log10(p.main), -log10(p.sup), colour = factor(signif))) +
  geom_point() + t2 + labs(x = expression(paste(-log[10], "p, pretreatment not considered", sep = "")),
                                   y = expression(paste(-log[10], "p, accounting for pretreatment", sep = ""))) +
  coord_fixed() +
  scale_x_continuous(breaks = seq(0,9,by = 3)) +
  scale_y_continuous(breaks = seq(0,9,by = 3)) +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed") +
  scale_color_manual(name = "Statistical Significance",
                     values = c("#F1BB7B","#669999", "#FD6467", "#5B1A18"))
```

![](data:image/png;base64...)

What are the drug-mutation pairs that are significant only in one or another model (i.e. only without pretreatment or with pretreatment included)?

```
signif.in.one = filter(pvals,
                       signif %in% c("Significant with pretreatment accounted",
                            "Significant without pretreatment in the model")) %>%
        arrange(signif)
kable(signif.in.one, digits = 4,
      align = c("l", "l", "c", "c", "c"),
      col.names = c("Drug", "Mutation", "P-value (Main)",
                    "P-value (Supplement)", "Statistical significance"),
      format.args = list(width = 14))
```

| Drug | Mutation | P-value (Main) | P-value (Supplement) | Statistical significance |
| --- | --- | --- | --- | --- |
| AT13387 | LAMA1 | 0.0198 | 0.0014 | Significant with pretreatment accounted |
| AZD7762 | trisomy12 | 0.0065 | 0.0004 | Significant with pretreatment accounted |
| MK-2206 | CREBBP | 0.0069 | 0.0021 | Significant with pretreatment accounted |
| arsenic trioxide | del17p13 | 0.0150 | 0.0019 | Significant with pretreatment accounted |
| spebrutinib | trisomy12 | 0.0096 | 0.0024 | Significant with pretreatment accounted |
| AT13387 | KLHL6 | 0.0025 | 0.0068 | Significant without pretreatment in the model |
| AT13387 | gain8q24 | 0.0009 | 0.0207 | Significant without pretreatment in the model |
| AZD7762 | del11q22.3 | 0.0005 | 0.0108 | Significant without pretreatment in the model |
| BIX02188 | KLHL6 | 0.0023 | 0.0035 | Significant without pretreatment in the model |
| BX912 | del11q22.3 | 0.0009 | 0.0069 | Significant without pretreatment in the model |
| BX912 | gain8q24 | 0.0024 | 0.0144 | Significant without pretreatment in the model |
| CCT241533 | del11q22.3 | 0.0007 | 0.0084 | Significant without pretreatment in the model |
| KX2-391 | del11q22.3 | 0.0005 | 0.0029 | Significant without pretreatment in the model |
| MIS-43 | trisomy12 | 0.0028 | 0.0058 | Significant without pretreatment in the model |
| MK-1775 | del11q22.3 | 0.0001 | 0.0032 | Significant without pretreatment in the model |
| PF 477736 | gain8q24 | 0.0012 | 0.0460 | Significant without pretreatment in the model |
| SD07 | KLHL6 | 0.0022 | 0.0040 | Significant without pretreatment in the model |
| UCN-01 | del11q22.3 | 0.0006 | 0.0030 | Significant without pretreatment in the model |
| VE-821 | del11q22.3 | 0.0013 | 0.0085 | Significant without pretreatment in the model |
| doxorubicine | TP53 | 0.0017 | 0.0050 | Significant without pretreatment in the model |
| doxorubicine | del17p13 | 0.0019 | 0.0047 | Significant without pretreatment in the model |
| encorafenib | BRAF | 0.0020 | 0.0069 | Significant without pretreatment in the model |
| ibrutinib | del11q22.3 | 0.0019 | 0.0174 | Significant without pretreatment in the model |
| navitoclax | UMODL1 | 0.0015 | 0.0029 | Significant without pretreatment in the model |
| nutlin-3 | del13q14 | 0.0016 | 0.0026 | Significant without pretreatment in the model |
| spebrutinib | del11q22.3 | 0.0007 | 0.0049 | Significant without pretreatment in the model |
| tamatinib | del11q22.3 | 0.0017 | 0.0110 | Significant without pretreatment in the model |
| tipifarnib | PRPF8 | 0.0029 | 0.0028 | Significant without pretreatment in the model |
| vorinostat | PRSS50 | 0.0022 | 0.0031 | Significant without pretreatment in the model |

Produce LaTeX output for the Supplement:

```
print(kable(signif.in.one, format = "latex", digits = 4,
       align = c("l", "l", "c", "c", "c"),
      col.names = c("Drug", "Mutation", "P-value (Main)",
                    "P-value (Supplement)", "Statistical significance")))
```

---

# 20 Association between HSP90 inhibitor response and IGHV status

We investigated additional HSP90 inhibitors (ganetespib, onalespib) in 120 patient samples from the original cohort (CLL), for whom IGHV status was available.

Load the additional drug response dataset.

```
data(list= c("validateExp","lpdAll"))
```

Preparing table for association test and plotting.

```
plotTab <- filter(validateExp, Drug %in% c("Ganetespib", "Onalespib")) %>%
  mutate(IGHV = Biobase::exprs(lpdAll)["IGHV Uppsala U/M", patientID]) %>%
  filter(!is.na(IGHV)) %>%
  mutate(IGHV = as.factor(ifelse(IGHV == 1, "M","U")),
         Concentration = as.factor(Concentration))
```

Association test using Student’s t-test.

```
pTab <- group_by(plotTab, Drug, Concentration) %>%
  do(data.frame(p = t.test(viab ~ IGHV, .)$p.value)) %>%
  mutate(p = format(p, digits =2, scientific = TRUE))
```

Bee swarm plot.

```
pList <- group_by(plotTab, Drug) %>%
  do(plots = ggplot(., aes(x=Concentration, y = viab)) +
       stat_boxplot(geom = "errorbar", width = 0.3,
                    position = position_dodge(width=0.6),
                    aes(dodge = IGHV)) +
       geom_boxplot(outlier.shape = NA, position = position_dodge(width=0.6),
                    col="black", width=0.5, aes(dodge = IGHV)) +
       geom_beeswarm(size=1,dodge.width=0.6, aes(col=IGHV)) +
       theme_classic() +
       scale_y_continuous(expand = c(0, 0),breaks=seq(0,1.2,0.20)) +
       coord_cartesian(ylim = c(0,1.30)) +
       xlab("Concentration (µM)") + ylab("Viability") +
       ggtitle(unique(.$Drug)) +
       geom_text(data=filter(pTab, Drug == unique(.$Drug)), y = 1.25,
                 aes(x=Concentration, label=sprintf("p=%s",p)),
                 size = 4.5) +
      theme(axis.line.x = element_blank(),
            axis.ticks.x = element_blank(),
             axis.text  = element_text(size=15),
            axis.title = element_text(size =15),
             legend.text = element_text(size=13),
            legend.title = element_text(size=15),
             plot.title = element_text(face="bold", hjust=0.5, size=17),
             plot.margin = unit(c(0.5,0.5,0.5,0.5), "cm")))
grid.arrange(grobs = pList$plots, ncol =2)
```

![](data:image/png;base64...)
The HSP90 inhibitors had higher activity in U-CLL, consistent with the result for AT13387. These data suggest that the finding of BCR (IGHV mutation) specific effects appears to be a compound class effect and further solidifies the results.

# 21 Association between MEK/ERK inhibitor response and trisomy12

To further investigate the association of trisomy 12 and MEK dependence, we investigated additional MEK and ERK inhibitors (cobimetinib, SCH772984 and trametinib) in 119 patients from the original cohort, for whom trisomy 12 status was available.

Preparing table for association test and plotting.

```
plotTab <- filter(validateExp, Drug %in%
                    c("Cobimetinib","SCH772984","Trametinib")) %>%
  mutate(Trisomy12 = Biobase::exprs(lpdAll)["trisomy12", patientID]) %>%
  filter(!is.na(Trisomy12)) %>%
  mutate(Trisomy12 = as.factor(ifelse(Trisomy12 == 1, "present","absent")),
         Concentration = as.factor(Concentration))
```

Association test using Student’s t-test.

```
pTab <- group_by(plotTab, Drug, Concentration) %>%
  do(data.frame(p = t.test(viab ~ Trisomy12, .)$p.value)) %>%
  mutate(p = format(p, digits =2, scientific = FALSE))
```

Bee swarm plot.

```
pList <- group_by(plotTab, Drug) %>%
  do(plots = ggplot(., aes(x=Concentration, y = viab)) +
       stat_boxplot(geom = "errorbar", width = 0.3,
                    position = position_dodge(width=0.6),
                    aes(dodge = Trisomy12)) +
       geom_boxplot(outlier.shape = NA, position = position_dodge(width=0.6),
                    col="black", width=0.5, aes(dodge = Trisomy12)) +
       geom_beeswarm(size=1,dodge.width=0.6, aes(col=Trisomy12)) +
       theme_classic() +
       scale_y_continuous(expand = c(0, 0),breaks=seq(0,1.2,0.2)) +
       coord_cartesian(ylim = c(0,1.3)) +
       xlab("Concentration (µM)") + ylab("Viability") +
       ggtitle(unique(.$Drug)) +
       geom_text(data=filter(pTab, Drug == unique(.$Drug)), y = 1.25,
                 aes(x=Concentration, label=sprintf("p=%s",p)), size = 5) +
       theme(axis.line.x = element_blank(),
             axis.ticks.x = element_blank(),
             axis.text  = element_text(size=15),
             axis.title = element_text(size =15),
             legend.text = element_text(size=13),
             legend.title = element_text(size=15),
             plot.title = element_text(face="bold", hjust=0.5, size=17),
             plot.margin = unit(c(0.5,0,0.5,0), "cm")))

grid.arrange(grobs = pList$plots, ncol =1)
```

![](data:image/png;base64...)
Consistent with the data from the screen, samples with trisomy 12 showed higher sensitivity to MEK/ERK inhibitors.

---

# 22 Expression profiling analysis of trisomy 12

Load and prepare expression data set.

```
data(list=c("dds", "patmeta", "mutCOM"))

#load genesets
gmts = list(
  H=system.file("extdata","h.all.v5.1.symbols.gmt",
                package="BloodCancerMultiOmics2017"),
  C6=system.file("extdata","c6.all.v5.1.symbols.gmt",
                 package="BloodCancerMultiOmics2017"),
  KEGG=system.file("extdata","c2.cp.kegg.v5.1.symbols.gmt",
                   package="BloodCancerMultiOmics2017"))
```

Choose CLL samples with trisomy 12 annotation from the gene expression data set.

```
#only choose CLL samples
colData(dds)$Diagnosis <- patmeta[match(dds$PatID,rownames(patmeta)),]$Diagnosis
ddsCLL <- dds[,dds$Diagnosis %in% "CLL"]

#add trisomy 12 and IGHV information
colData(ddsCLL)$trisomy12 <-
  factor(assayData(mutCOM[ddsCLL$PatID,])$binary[,"trisomy12"])
colData(ddsCLL)$IGHV <- factor(patmeta[ddsCLL$PatID,]$IGHV)

#remove samples that do not have trisomy 12 information
ddsCLL <- ddsCLL[,!is.na(ddsCLL$trisomy12)]

#how many genes and samples we have?
dim(ddsCLL)
```

```
## [1] 63677   131
```

Remove transcripts that do not have gene symbol annotations, show low counts or do not show variance across samples.

```
#remove genes without gene symbol annotations
ddsCLL <- ddsCLL[!is.na(rowData(ddsCLL)$symbol),]
ddsCLL <- ddsCLL[rowData(ddsCLL)$symbol != "",]

#only keep genes that have counts higher than 10 in any sample
keep <- apply(counts(ddsCLL), 1, function(x) any(x >= 10))
ddsCLL <- ddsCLL[keep,]

#Remove transcripts do not show variance across samples
ddsCLL <- estimateSizeFactors(ddsCLL)
sds <- rowSds(counts(ddsCLL, normalized = TRUE))
sh <- shorth(sds)
ddsCLL <- ddsCLL[sds >= sh,]

#variance stabilization
ddsCLL.norm <- varianceStabilizingTransformation(ddsCLL, blind=TRUE)

#how many genes left
dim(ddsCLL)
```

```
## [1] 13816   131
```

## 22.1 Differential gene expression analysis using DESeq2

DESeq2 was used to identify genes that are differentially expressed between wild-type CLL samples and samples with trisomy 12.

Run DESeq2

```
design(ddsCLL) <- ~ trisomy12
ddsCLL <- DESeq(ddsCLL, betaPrior = FALSE)
```

```
## using pre-existing size factors
```

```
## estimating dispersions
```

```
## gene-wise dispersion estimates
```

```
## mean-dispersion relationship
```

```
## final dispersion estimates
```

```
## fitting model and testing
```

```
## -- replacing outliers and refitting for 688 genes
## -- DESeq argument 'minReplicatesForReplace' = 7
## -- original counts are preserved in counts(dds)
```

```
## estimating dispersions
```

```
## fitting model and testing
```

```
DEres <- results(ddsCLL)
DEres.shr <- lfcShrink(ddsCLL, type="normal", contrast = c("trisomy12","1","0"),
                       res = DEres)
```

```
## using 'normal' for LFC shrinkage, the Normal prior from Love et al (2014).
##
## Note that type='apeglm' and type='ashr' have shown to have less bias than type='normal'.
## See ?lfcShrink for more details on shrinkage type, and the DESeq2 vignette.
## Reference: https://doi.org/10.1093/bioinformatics/bty895
```

Plot gene dosage effect.

```
#FIG# S23 A
plotTab <- as.data.frame(DEres)
plotTab$onChr12 <- rowData(ddsCLL)$chromosome == 12
dosePlot <- ggplot(plotTab) +
  geom_density(aes(x=log2FoldChange, col=onChr12, fill=onChr12), alpha=0.4) +
  xlim( -3, 3 )
dosePlot
```

![](data:image/png;base64...)
The distributions of the logarithmic (base 2) fold change between samples with and without trisomy 12 are shown separately for the genes on chromosome 12 (green) and on other chromosomes (red). The two distributions are shifted with respected to each by an amount that is consistent with log2(3/2) ~ 0.58 and thus with gene dosage effects.

### 22.1.1 Heatmap plot of differentially expressed genes

A heat map plot was used to show the normalized expression value (Z-score) of the differentially expressed genes in samples with and without trisomy 12.

Prepare matrix for heat map plot.

```
#filter genes
fdrCut <- 0.1
fcCut <- 1.5

allDE <- data.frame(DEres.shr) %>%
  rownames_to_column(var = "ID") %>%
  mutate(Symbol = rowData(ddsCLL[ID,])$symbol,
         Chr = rowData(ddsCLL[ID,])$chromosome) %>%
  filter(padj <= fdrCut & abs(log2FoldChange) > fcCut) %>%
  arrange(pvalue) %>% filter(!duplicated(Symbol)) %>%
  mutate(Chr12 = ifelse(Chr == 12, "yes", "no"))

#get the expression matrix
plotMat <- assay(ddsCLL.norm[allDE$ID,])
colnames(plotMat) <- ddsCLL.norm$PatID
rownames(plotMat) <- allDE$Symbol

#sort columns of plot matrix based on trisomy 12 status
plotMat <- plotMat[,order(ddsCLL.norm$trisomy12)]

#calculate z-score and scale
plotMat <- t(scale(t(plotMat)))
plotMat[plotMat >= 4] <- 4
plotMat[plotMat <= -4] <- -4
```

Plot the heat map.

```
#FIG# S23 B
#prepare colums and row annotations
annoCol <- data.frame(row.names=ddsCLL.norm$PatID, Tris12=ddsCLL.norm$trisomy12)
levels(annoCol$Tris12) <- list(wt = 0, mut =1)
annoRow <- data.frame(row.names = allDE$Symbol, Chr12 = allDE$Chr12)
annoColor <- list(Tris12 = c(wt = "grey80", mut = "black"),
                  Chr12 = c(yes="red", no = "grey80"))

pheatmap(plotMat,
         color=colorRampPalette(rev(brewer.pal(n=7, name="RdBu")))(100),
         cluster_cols = FALSE,
         annotation_row = annoRow, annotation_col = annoCol,
         show_colnames = FALSE, fontsize_row = 3,
         breaks = seq(-4,4, length.out = 101),
         annotation_colors = annoColor, border_color = NA)
```

![](data:image/png;base64...)
According to the gene expression heat map, the samples with trisomy 12 show distinct expression pattern. 84 genes are significantly up-regulated in trisomy 12 samples and 37 genes are down-regulated in trisomy 12 samples (FDR =0.1 and log2FoldChange > 1.5). Among the 84 up-regulated genes, only 12 genes are from chromosome 12, suggested the distinct expression pattern of trisomy 12 samples can not be merely explained by gene dosage effect.

## 22.2 Gene set enrichment analysis

Gene set enrichment analysis using PAGE (Parametric Analysis of Gene Set Enrichment) was used to unravel the pathway activity changes underlying trisomy 12.

### 22.2.1 Perform enrichment analysis

Function to run PAGE in R.

```
runGSEA <- function(inputTab, gmtFile, GSAmethod="gsea", nPerm=1000){
    inGMT <- loadGSC(gmtFile,type="gmt")
    #re-rank by score
    rankTab <- inputTab[order(inputTab[,1],decreasing = TRUE),,drop=FALSE]
    if (GSAmethod == "gsea"){
        #readin geneset database
        #GSEA analysis
        res <- runGSA(geneLevelStats = rankTab,
                      geneSetStat = GSAmethod,
                      adjMethod = "fdr", gsc=inGMT,
                      signifMethod = 'geneSampling', nPerm = nPerm)
        GSAsummaryTable(res)
    } else if (GSAmethod == "page"){
        res <- runGSA(geneLevelStats = rankTab,
                      geneSetStat = GSAmethod,
                      adjMethod = "fdr", gsc=inGMT,
                      signifMethod = 'nullDist')
        GSAsummaryTable(res)
    }
}
```

Function for plotting enrichment bar.

```
plotEnrichmentBar <- function(resTab, pCut=0.05, ifFDR=FALSE,
                              setName="Signatures") {
  pList <- list()
  rowNum <- c()
  for (i in names(resTab)) {
    plotTab <- resTab[[i]]
    if (ifFDR) {
      plotTab <- dplyr::filter(
        plotTab, `p adj (dist.dir.up)` <= pCut | `p adj (dist.dir.dn)` <= pCut)
    } else {
      plotTab <- dplyr::filter(
        plotTab, `p (dist.dir.up)` <= pCut | `p (dist.dir.dn)` <= pCut)
    }
    if (nrow(plotTab) == 0) {
      print("No sets passed the criteria")
      next
    } else {
      #firstly, process the result table
      plotTab <- apply(plotTab, 1, function(x) {
        statSign <- as.numeric(x[3])
        data.frame(Name = x[1],
                   p = as.numeric(ifelse(statSign >= 0, x[4], x[6])),
                   geneNum = ifelse(statSign >= 0, x[8], x[9]),
                   Direction = ifelse(statSign > 0, "Up", "Down"),
                   stringsAsFactors = FALSE)
      }) %>% do.call(rbind,.)

      plotTab$Name <- sprintf("%s (%s)",plotTab$Name,plotTab$geneNum)
      plotTab <- plotTab[with(plotTab,order(Direction, p, decreasing=TRUE)),]
      plotTab$Direction <- factor(plotTab$Direction, levels = c("Down","Up"))
      plotTab$Name <- factor(plotTab$Name, levels = plotTab$Name)
      #plot the barplot
      pList[[i]] <- ggplot(data=plotTab, aes(x=Name, y= -log10(p),
                                             fill=Direction)) +
        geom_bar(position="dodge",stat="identity", width = 0.5) +
        scale_fill_manual(values=c(Up = "blue", Down = "red")) +
        coord_fixed(ratio = 0.5) + coord_flip() + xlab(setName) +
        ggtitle(i) + theme_bw() + theme(
          plot.title = element_text(face = "bold", hjust =0.5),
          axis.title = element_text(size=15))
      rowNum <-c(rowNum,nrow(plotTab))
    }
  }

  if (length(pList) == 0) {
    print("Nothing to plot")
  } else {
    rowNum <- rowNum
    grobList <- lapply(pList, ggplotGrob)
    grobList <- do.call(rbind,c(grobList,size="max"))
    panels <- grobList$layout$t[grep("panel", grobList$layout$name)]
    grobList$heights[panels] <- unit(rowNum, "null")
  }
  return(grobList)
}
```

Prepare input table for gene set enrichment analysis. A cut-off of raw p value < 0.05 was used to select genes for the analysis.

```
pCut <- 0.05

dataTab <- data.frame(DEres)
dataTab$ID <- rownames(dataTab)

#filter using raw pvalues
dataTab <- filter(dataTab, pvalue <= pCut) %>%
  arrange(pvalue) %>%
  mutate(Symbol = rowData(ddsCLL[ID,])$symbol)
dataTab <- dataTab[!duplicated(dataTab$Symbol),]
statTab <- data.frame(row.names = dataTab$Symbol, stat = dataTab$stat)
```

Gene set enrichment analysis using Hallmarks gene set from MsigDB.

```
hallmarkRes <- list()

#run PAGE
resTab <- runGSEA(statTab, gmts$H ,GSAmethod = "page")
```

```
## Checking arguments...done!
```

```
## Calculating gene set statistics...done!
## Calculating gene set significance...done!
## Adjusting for multiple testing...done!
```

```
#remove the HALLMARK_
resTab$Name <- gsub("HALLMARK_","",resTab$Name)

hallmarkRes[["Gene set enrichment analysis"]] <-
  arrange(resTab,desc(`Stat (dist.dir)`))

hallBar <- plotEnrichmentBar(hallmarkRes, pCut = 0.01, ifFDR = TRUE,
                             setName = "Hallmark gene sets")
```

Gene set enrichment analysis using kegg gene set from MsigDB.

```
keggRes <- list()

resTab <- runGSEA(statTab,gmts$KEGG,GSAmethod = "page")
```

```
## Checking arguments...done!
```

```
## Calculating gene set statistics...done!
## Calculating gene set significance...done!
## Adjusting for multiple testing...done!
```

```
#remove the KEGG_
resTab$Name <- gsub("KEGG_","",resTab$Name)

keggRes[["Gene set enrichment analysis"]] <- resTab

keggBar <- plotEnrichmentBar(keggRes, pCut = 0.01, ifFDR = TRUE,
                             setName = "KEGG gene sets")
```

### 22.2.2 Heatmap for selected gene sets

Heatmap plots were used to show the expression values of differentially expressed genes from KEGG\_CHEMOKINE\_SIGNALING\_PATHWAY gene set

Prepare the matrix for heatmap plot.

```
#select differentially expressed genes
fdrCut <- 0.05
cytoDE <- data.frame(DEres) %>% rownames_to_column(var = "ID") %>%
  mutate(Symbol = rowData(ddsCLL[ID,])$symbol,
         Chr=rowData(ddsCLL[ID,])$chromosome) %>%
  filter(padj <= fdrCut, log2FoldChange > 0) %>%
  arrange(pvalue) %>% filter(!duplicated(Symbol)) %>%
  mutate(Chr12 = ifelse(Chr == 12, "yes", "no"))

#get the expression matrix
plotMat <- assay(ddsCLL.norm[cytoDE$ID,])
colnames(plotMat) <- ddsCLL.norm$PatID
rownames(plotMat) <- cytoDE$Symbol

#sort columns of plot matrix based on trisomy 12 status
plotMat <- plotMat[,order(ddsCLL.norm$trisomy12)]

#calculate z-score and sensor
plotMat <- t(scale(t(plotMat)))
plotMat[plotMat >= 4] <- 4
plotMat[plotMat <= -4] <- -4

annoCol <- data.frame(row.names = ddsCLL.norm$PatID,
                      Tris12 = ddsCLL.norm$trisomy12)
levels(annoCol$Tris12) <- list(wt = 0, mut =1)
annoRow <- data.frame(row.names = cytoDE$Symbol, Chr12 = cytoDE$Chr12)
```

Heatmap for genes from KEGG\_CHEMOKINE\_SIGNALING\_PATHWAY geneset.

```
gsc <- loadGSC(gmts$KEGG)
geneList <- gsc$gsc$KEGG_CHEMOKINE_SIGNALING_PATHWAY
plotMat.chemo <- plotMat[rownames(plotMat) %in% geneList,]
keggHeatmap <- pheatmap(plotMat.chemo,
                        color = colorRampPalette(
                          rev(brewer.pal(n=7, name="RdBu")))(100),
         cluster_cols = FALSE, clustering_method = "ward.D2",
         annotation_row = annoRow, annotation_col = annoCol,
         show_colnames = FALSE, fontsize_row = 8,
         breaks = seq(-4,4, length.out = 101), treeheight_row = 0,
         annotation_colors = annoColor, border_color = NA,
         main = "CHEMOKINE_SIGNALING_PATHWAY",silent = TRUE)$gtable
```

Combine enrichment plot and heatmap plot.

```
#FIG# S24 ABC
ggdraw() +
  draw_plot(hallBar, 0, 0.7, 0.5, 0.3) +
  draw_plot(keggBar, 0.5, 0.7, 0.5, 0.3) +
  draw_plot(keggHeatmap, 0.1, 0, 0.8, 0.65) +
  draw_plot_label(c("A","B","C"), c(0, 0.5, 0.1), c(1, 1, 0.7),
                  fontface = "plain", size=20)
```

![](data:image/png;base64...)
Based on the gene set enrichment analysis results, genes from PI3K\_ATK\_MTOR pathway are significantly up-regulated in the samples with trisomy 12, which partially explained the increased sensitivity of trisomy 12 samples to PI3K and MTOR inhibitors. In addition, genes that are up-regulated in trisomy 12 are enrichment in chemokine signaling pathway.

---

```
options(stringsAsFactors=FALSE)
```

# 23 Drug response prediction

Drug response heterogeneity is caused by the unique deregulations in biology of the tumor cell. Those deregulations leave trace on the different molecular levels and have a various impact on cell’s drug sensitivity profile. Here we use multivariate regression to integrate information from the multi-omic data in order to predict drug response profiles of the CLL samples.

Loading the data.

```
data(list=c("conctab", "drpar", "drugs", "patmeta", "lpdAll", "dds", "mutCOM",
"methData"))
```

## 23.1 Assesment of omics capacity in explaining drug response

### 23.1.1 Data pre-processing

Filtering steps and transformations.

```
e<-dds
colnames(e)<-colData(e)$PatID

#only consider CLL patients
CLLPatients<-rownames(patmeta)[which(patmeta$Diagnosis=="CLL")]

#Methylation Data
methData = t(assay(methData))

#RNA Data
eCLL<-e[,colnames(e) %in% CLLPatients]
###
#filter out genes without gene namce
AnnotationDF<-data.frame(EnsembleId=rownames(eCLL),stringsAsFactors=FALSE)
AnnotationDF$symbol <- mapIds(org.Hs.eg.db,
                     keys=rownames(eCLL),
                     column="SYMBOL",
                     keytype="ENSEMBL",
                     multiVals="first")
```

```
## 'select()' returned 1:many mapping between keys and columns
```

```
eCLL<-eCLL[AnnotationDF$EnsembleId[!is.na(AnnotationDF$symbol)],]

#filter out low count genes
###
minrs <- 100
rs  <- rowSums(assay(eCLL))
eCLL<-eCLL[ rs >= minrs, ]
#variance stabilize the data
#(includes normalizing for library size and dispsersion estimation)
vstCounts<-varianceStabilizingTransformation(eCLL)
vstCounts<-assay(vstCounts)
#no NAs in data
any(is.na(vstCounts))
```

```
## [1] FALSE
```

```
#filter out low variable genes
ntop<-5000
vstCountsFiltered<-vstCounts[order(apply(vstCounts, 1, var, na.rm=T),
                                   decreasing = T)[1:ntop],]
eData<-t(vstCountsFiltered)
#no NAs
any(is.na(eData))
```

```
## [1] FALSE
```

```
#genetics
#remove features with less than 5 occurences
mutCOMbinary<-channel(mutCOM, "binary")
mutCOMbinary<-mutCOMbinary[featureNames(mutCOMbinary) %in% CLLPatients,]
genData<-Biobase::exprs(mutCOMbinary)
idx <- which(colnames(genData) %in% c("del13q14_bi", "del13q14_mono"))
genData <- genData[,-idx]
colnames(genData)[which(colnames(genData)=="del13q14_any")] = "del13q14"
minObs <- 5
#remove feutes with less than 5 occurecnes
genData<-genData[,colSums(genData, na.rm=T)>=minObs]

#IGHV
translation <- c(`U` = 0, `M` = 1)
stopifnot(all(patmeta$IGHV %in% c("U","M", NA)))
IGHVData <- matrix(translation[patmeta$IGHV],
                   dimnames = list(rownames(patmeta), "IGHV"), ncol = 1)
IGHVData<-IGHVData[rownames(IGHVData) %in% CLLPatients,,drop=F]
#remove patiente with NA IGHV status
IGHVData<-IGHVData[!is.na(IGHVData), ,drop=F]
any(is.na(IGHVData))
```

```
## [1] FALSE
```

```
#demographics (age and sex)
patmeta<-subset(patmeta, Diagnosis=="CLL")
gender <- ifelse(patmeta[,"Gender"]=="m",0,1)

# impute missing values in age by mean
ImputeByMean <- function(x) {x[is.na(x)] <- mean(x, na.rm=TRUE); return(x)}
age<-ImputeByMean(patmeta[,"Age4Main"])

demogrData <- cbind(age=age,gender=gender)
rownames(demogrData) <- rownames(patmeta)

#Pretreatment
pretreated<-patmeta[,"IC50beforeTreatment", drop=FALSE]

##### drug viabilites
summaries <- c(paste("viaraw", 1:5, sep=".") %>% `names<-`(paste(1:5)),
               `4:5` = "viaraw.4_5", `1:5` = "viaraw.1_5")
a <- do.call( abind, c( along=3, lapply( summaries,
                                         function(x) assayData(drpar)[[x]])))
dimnames(a)[[3]] <- names(summaries)
names(dimnames(a)) <- c( "drug", "patient", "summary" )
viabData <- acast( melt(a), patient ~ drug + summary )
rownames(viabData)<-c(substr(rownames(viabData),1,4)[1:3],
                      substr(rownames(viabData),1,5)[4:nrow(viabData)])
```

Check overlap of data and take care of missing values present in methylation and genetic data.

```
# common patients
Xlist<-list(RNA=eData, meth=methData, gen=genData, IGHV=IGHVData,
            demographics=demogrData, drugs=viabData, pretreated=pretreated)
PatientsPerOmic<-lapply(Xlist, rownames)
sapply(PatientsPerOmic, length)
```

```
##          RNA         meth          gen         IGHV demographics        drugs
##          136          196          200          188          200          249
##   pretreated
##          200
```

```
allPatients<-Reduce(union, PatientsPerOmic)
PatientOverview<-sapply(Xlist, function(M) allPatients %in% rownames(M))
Patients <- (1:nrow(PatientOverview))
Omics <- (1:ncol(PatientOverview))
image(Patients,Omics, PatientOverview*1, axes=F, col=c("white", "black"),
      main="Sample overview across omics")
axis(2, at = 1:ncol(PatientOverview), labels=colnames(PatientOverview), tick=F)
```

![](data:image/png;base64...)

```
commonPatients<-Reduce(intersect, PatientsPerOmic)
length(commonPatients)
```

```
## [1] 112
```

```
XlistCommon<-lapply(Xlist, function(data) data[commonPatients,, drop=F])

#Take care of missing values (present in  genetic data)
ImputeByMean <- function(x) {x[is.na(x)] <- mean(x, na.rm=TRUE); return(x)}

#NAs in genetic
#remove feauters with less 90% completeness
RarlyMeasuredFeautres<-
  which(colSums(is.na(XlistCommon$gen))>0.1*nrow(XlistCommon$gen))
XlistCommon$gen<-XlistCommon$gen[,-RarlyMeasuredFeautres]
#remove patients with less than 90% of genetic feautres measured
IncompletePatients<-
  rownames(XlistCommon$gen)[
    (rowSums(is.na(XlistCommon$gen))>0.1*ncol(XlistCommon$gen))]
commonPatients<-commonPatients[!commonPatients %in% IncompletePatients]
XlistCommon<-lapply(XlistCommon, function(data) data[commonPatients,, drop=F])
#replace remaining NA by mean and round to 0 or 1
XlistCommon$gen<-round(apply(XlistCommon$gen, 2, ImputeByMean))

#NAs in methylation
#remove feauters with less 90% completeness
XlistCommon$meth<-
  XlistCommon$meth[,colSums(is.na(XlistCommon$meth))<0.1*nrow(methData)]
#impute remainin missing values by mean for each feautre across patients
XlistCommon$meth<-(apply(XlistCommon$meth, 2, ImputeByMean))

#final dimensions of the data
sapply(XlistCommon, dim)
```

```
##       RNA meth gen IGHV demographics drugs pretreated
## [1,]  102  102 102  102          102   102        102
## [2,] 5000 5000  11    1            2   448          1
```

Use top 20 PCs of methylation and expression as predictors.

```
pcaMeth<-prcomp(XlistCommon$meth, center=T, scale. = F)
XlistCommon$MethPCs<-pcaMeth$x[,1:20]
colnames(XlistCommon$MethPCs)<-
  paste("meth",colnames(XlistCommon$MethPCs), sep="")

pcaExpr<-prcomp(XlistCommon$RNA, center=T, scale. = F)
XlistCommon$RNAPCs<-pcaExpr$x[,1:20]
colnames(XlistCommon$RNAPCs)<-paste("RNA",colnames(XlistCommon$RNAPCs), sep="")
```

Choose drug viabilites of interest as response variables.

```
DOI <- c("D_006_1:5", "D_010_1:5", "D_159_1:5","D_002_4:5", "D_003_4:5",
         "D_012_4:5", "D_063_4:5", "D_166_4:5")
drugviab<-XlistCommon$drugs
drugviab<-drugviab[,DOI, drop=F]
colnames(drugviab) <- drugs[substr(colnames(drugviab),1,5),"name"]
```

Construct list of designs used and scale all predictors to mean zero and unit variance.

```
ZPCs<-list(expression=XlistCommon$RNAPCs,
        genetic=XlistCommon$gen,
        methylation= XlistCommon$MethPCs,
        demographics=XlistCommon$demographics,
        IGHV=XlistCommon$IGHV,
        pretreated = XlistCommon$pretreated)
ZPCs$all<-do.call(cbind, ZPCs)
ZPCsunscaled<-ZPCs
ZPCsscaled<-lapply(ZPCs, scale)
lapply(ZPCsscaled, colnames)
```

```
## $expression
##  [1] "RNAPC1"  "RNAPC2"  "RNAPC3"  "RNAPC4"  "RNAPC5"  "RNAPC6"  "RNAPC7"
##  [8] "RNAPC8"  "RNAPC9"  "RNAPC10" "RNAPC11" "RNAPC12" "RNAPC13" "RNAPC14"
## [15] "RNAPC15" "RNAPC16" "RNAPC17" "RNAPC18" "RNAPC19" "RNAPC20"
##
## $genetic
##  [1] "del6q21"    "gain8q24"   "del11q22.3" "trisomy12"  "del13q14"
##  [6] "del17p13"   "BRAF"       "MYD88"      "NOTCH1"     "SF3B1"
## [11] "TP53"
##
## $methylation
##  [1] "methPC1"  "methPC2"  "methPC3"  "methPC4"  "methPC5"  "methPC6"
##  [7] "methPC7"  "methPC8"  "methPC9"  "methPC10" "methPC11" "methPC12"
## [13] "methPC13" "methPC14" "methPC15" "methPC16" "methPC17" "methPC18"
## [19] "methPC19" "methPC20"
##
## $demographics
## [1] "age"    "gender"
##
## $IGHV
## [1] "IGHV"
##
## $pretreated
## [1] "IC50beforeTreatment"
##
## $all
##  [1] "expression.RNAPC1"    "expression.RNAPC2"    "expression.RNAPC3"
##  [4] "expression.RNAPC4"    "expression.RNAPC5"    "expression.RNAPC6"
##  [7] "expression.RNAPC7"    "expression.RNAPC8"    "expression.RNAPC9"
## [10] "expression.RNAPC10"   "expression.RNAPC11"   "expression.RNAPC12"
## [13] "expression.RNAPC13"   "expression.RNAPC14"   "expression.RNAPC15"
## [16] "expression.RNAPC16"   "expression.RNAPC17"   "expression.RNAPC18"
## [19] "expression.RNAPC19"   "expression.RNAPC20"   "genetic.del6q21"
## [22] "genetic.gain8q24"     "genetic.del11q22.3"   "genetic.trisomy12"
## [25] "genetic.del13q14"     "genetic.del17p13"     "genetic.BRAF"
## [28] "genetic.MYD88"        "genetic.NOTCH1"       "genetic.SF3B1"
## [31] "genetic.TP53"         "methylation.methPC1"  "methylation.methPC2"
## [34] "methylation.methPC3"  "methylation.methPC4"  "methylation.methPC5"
## [37] "methylation.methPC6"  "methylation.methPC7"  "methylation.methPC8"
## [40] "methylation.methPC9"  "methylation.methPC10" "methylation.methPC11"
## [43] "methylation.methPC12" "methylation.methPC13" "methylation.methPC14"
## [46] "methylation.methPC15" "methylation.methPC16" "methylation.methPC17"
## [49] "methylation.methPC18" "methylation.methPC19" "methylation.methPC20"
## [52] "demographics.age"     "demographics.gender"  "IGHV"
## [55] "IC50beforeTreatment"
```

Define colors.

```
set1 <- brewer.pal(9,"Set1")
colMod<-c(paste(set1[c(4,1,5,3,2,7)],"88",sep=""), "grey")
names(colMod) <-
  c("demographics", "genetic", "IGHV","expression", "methylation", "pretreated",
    "all")
```

### 23.1.2 Lasso using multi-omic data

Fit a linear model using Lasso explaining drug response by each one of the omic set separately as well as all together. As measure of explained variance use R2 from linear models for unpenalized models (IGHV)
and fraction of variance explained, i.e. 1- cross-validated mean squared error/total sum of squares for others.

To ensure fair treatment of all features they are standardized to mean 0 and unit variance.
To study robustness the cross-validation is repeated 100-times to obtain the mean and standard deviation shown in the figure.

Fit model and show resulting omic-prediction profiles.
![](data:image/png;base64...)

```
## `summarise()` has grouped output by 'omic'. You can override using the
## `.groups` argument.
```

![](data:image/png;base64...)

Optionally, the model can also be fit for all drugs in the study.

```
nfolds<-10
nrep<-100

DOI <-
  grepl("1:5",colnames(XlistCommon$drugs)) |
  grepl("4:5",colnames(XlistCommon$drugs))
drugviabAll<-XlistCommon$drugs
drugviabAll<-drugviabAll[,DOI]
colnames(drugviabAll) <-
  paste0(drugs[substr(colnames(drugviabAll),1,5),"name"],
         substr(colnames(drugviabAll),6,9))

R2ForPenReg(Zscaled, drugviabAll, nfold=nfolds, alpha=1, nrep=nrep,
            Parmfrow=c(4,4), ylimMax=0.6)
```

## 23.2 Lasso for drugs in a genetic-focussed model

We perform regression analysis by adaptive LASSO using genetic features, IGHV status (coded as 0 -1 for mutated/unmutated), pretreatment status (coded as 0 -1) and methylation cluster (coded as 0 for lowly-programmed (LP), 0.5 for intermediately-programmed (IP) and 1 for highly-programmed (HP)). For each model we select the optimal penalization parameter of the second step Lasso fit of the adaptive Lasso by repeated cross-validation to get robust results.

As output bar plots showing the coefficients of the selected predictors are produced.

### 23.2.1 General definitions

We use the following abbreviations for the different data types.

|  | data type |
| --- | --- |
| M | methylation cluster |
| G | mutations |
| V | viability |
| I | ighv |
| P | pretreatment |

Color definitions for the groups.

### 23.2.2 Data pre-processing

Subselect CLL patients.

```
lpdCLL = lpdAll[ , lpdAll$Diagnosis=="CLL"]
```

Prepare the data and limit the number of features by subselecting only those which include at least 5 recorded incidences. List the predictors.

```
lpdCLL = lpdAll[ , lpdAll$Diagnosis=="CLL"]
lpdCLL = BloodCancerMultiOmics2017:::prepareLPD(lpd=lpdCLL, minNumSamplesPerGroup=5)
(predictorList = BloodCancerMultiOmics2017:::makeListOfPredictors(lpdCLL))
```

```
## $predictorsM
## [1] "Methylation_Cluster"
##
## $predictorsG
##  [1] "del6q21"    "gain8q24"   "del11q22.3" "trisomy12"  "del13q14"
##  [6] "del17p13"   "BRAF"       "NOTCH1"     "SF3B1"      "TP53"
##
## $predictorsI
## [1] "IGHV"
##
## $predictorsP
## [1] "Pretreatment"
```

### 23.2.3 Drug response prediction

The prediction will be made for the following drugs and concentrations.

|  | drug name | conc |
| --- | --- | --- |
| D\_159 | doxorubicine | 1-5 |
| D\_006 | fludarabine | 1-5 |
| D\_010 | nutlin-3 | 1-5 |
| D\_166 | PRT062607 HCl | 4-5 |
| D\_003 | idelalisib | 4-5 |
| D\_002 | ibrutinib | 4-5 |
| D\_012 | selumetinib | 4-5 |
| D\_063 | everolimus | 4-5 |

```
drs = list("1:5"=c("D_006", "D_010", "D_159"),
           "4:5"=c("D_002", "D_003", "D_012", "D_063", "D_166"))
```

```
predvar = unlist(BloodCancerMultiOmics2017:::makePredictions(drs=drs,
                                 lpd=lpdCLL,
                                 predictorList=predictorList,
                                 lim=0.15, std=FALSE, adaLasso=TRUE,
                                 colors=coldef),
                 recursive=FALSE)
```

```
## [1] "Prediction for: D_006_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## Warning: The `guide` argument in `scale_*()` cannot be `FALSE`. This was deprecated in
## ggplot2 3.3.4.
## ℹ Please use "none" instead.
## ℹ The deprecated feature was likely used in the BloodCancerMultiOmics2017
##   package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## [1] "Prediction for: D_010_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_159_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_002_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_003_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_012_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_063_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_166_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

![](data:image/png;base64...)

![](data:image/png;base64...)

![](data:image/png;base64...)

![](data:image/png;base64...)

![](data:image/png;base64...)

![](data:image/png;base64...)

![](data:image/png;base64...)

![](data:image/png;base64...)

Plot the legends.

```
legends = BloodCancerMultiOmics2017:::makeLegends(legendFor=c("G","I","M", "P"),
                                                  coldef)
```

![](data:image/png;base64...)

Additionaly we plot the prediction for rotenone.

```
drs_rot = list("4:5"=c("D_067"))
predvar_rot = unlist(BloodCancerMultiOmics2017:::makePredictions(drs=drs_rot,
                                 lpd=lpdCLL,
                                 predictorList=predictorList,
                                 lim=0.23, std=FALSE, adaLasso=TRUE,
                                 colors=coldef),
                 recursive=FALSE)
```

```
## [1] "Prediction for: D_067_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

![](data:image/png;base64...)

In a same way the prediction for all the drugs can be made.

```
alldrs = unique(fData(lpdCLL)[fData(lpdCLL)$type=="viab","id"])
drs = list("1:5"=alldrs, "4:5"=alldrs)
```

```
predvar2 = BloodCancerMultiOmics2017:::makePredictions(drs=drs,
                                        lpd=lpdCLL,
                                        predictorList=predictorList,
                                        lim=0.23,
                                        colors=coldef)
```

```
## [1] "Prediction for: D_001_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_002_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_003_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_004_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_006_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_007_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_008_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_010_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_011_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_012_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_013_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_015_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_017_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_020_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_021_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_023_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_024_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_025_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_029_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_030_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_032_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_033_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_034_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_035_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_036_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_039_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_040_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_041_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_043_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_045_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_048_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_049_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_050_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_053_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_054_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_056_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_060_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_063_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_066_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_067_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_071_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_074_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_075_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_077_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_078_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_079_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_081_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_082_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_083_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_084_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_127_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_141_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_149_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_159_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_162_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_163_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_164_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_165_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_166_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_167_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_168_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_169_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_172_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_CHK_1:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_001_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_002_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_003_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_004_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_006_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_007_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_008_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_010_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_011_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_012_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_013_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_015_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_017_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_020_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_021_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_023_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_024_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_025_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_029_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_030_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_032_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_033_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_034_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_035_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_036_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_039_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_040_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_041_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_043_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_045_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_048_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_049_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_050_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_053_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_054_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_056_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_060_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_063_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_066_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_067_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_071_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_074_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_075_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_077_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_078_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_079_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_081_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_082_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_083_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_084_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_127_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_141_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_149_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_159_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_162_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_163_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_164_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_165_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_166_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_167_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_168_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_169_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_172_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

```
## [1] "Prediction for: D_CHK_4:5; #samples: 168; #features: 13"
```

```
## Warning in geom_bar(stat = "identity", colour = "black", position = "identity",
## : Ignoring unknown parameters: `size`
```

### 23.2.4 Effect of pre-treatment

In order to find out the effect of pre-treatment on the predictions of drug response we provide the following overview. The summary is made for all drugs, separating however, on ranges of drug concentrations (mean drug effect of: all five (1-5) and two lowest (4-5) concentrations of the drugs).

```
givePreatreatSum = function(predNum) {

  idx = sapply(predvar2[[predNum]], function(x) length(x)==1)
  predvar2[[predNum]] = predvar2[[predNum]][!idx]
  # get model coefficients and reshape
  coeffs <- do.call(cbind,lapply(predvar2[[predNum]], "[[", 'coeffs'))
  coeffs <- coeffs[-1,]
  coeffs <- as.matrix(coeffs)
  # colnames(coeffs) <- unlist(drs["1:5"])
  colnames(coeffs) = names(predvar2[[predNum]])
  colnames(coeffs) <- drugs[colnames(coeffs),"name"]
  coeffDF <- melt(as.matrix(coeffs))
  colnames(coeffDF) <- c("predictor", "drug", "beta")
  coeffDF$selected <- coeffDF$beta !=0

  #sort by times being selected
  coeffDF$predictor <- factor(coeffDF$predictor, level=)

  # number of drugs a predictor is chosen for
  gg1 <- coeffDF %>% group_by(predictor) %>%
    dplyr::summarize(selectedSum = sum(selected)) %>%
    mutate(predictor = factor(predictor,
                              levels=predictor[order(selectedSum)])) %>%
    ggplot(aes(x=predictor, y=selectedSum)) +
    geom_bar(stat="identity")+ylab("# drugs selected for") +
    coord_flip()

  # boxplots of non-zero coeffients
  orderMedian <- filter(coeffDF, selected) %>% group_by(predictor) %>%
    dplyr::summarize(medianBeta = median(abs(beta)))
  coeffDF$predictor <- factor(
    coeffDF$predictor,
    levels=orderMedian$predictor[order(orderMedian$medianBeta)] )
  gg2 <- ggplot(filter(coeffDF, selected), aes(x=predictor, y=abs(beta))) +
    geom_boxplot() +
    coord_flip() + ggtitle("Distribution of non-zero coefficients")
  gridExtra::grid.arrange(gg1,gg2, ncol=1)

  # coefficeints per drug
  ggplot(filter(coeffDF, selected),
         aes(x= drug, y=abs(beta), col= predictor=="Pretreatment")) +
    geom_point() +
    coord_flip()

  #drugs pretreatment is selected for
  as.character(filter(coeffDF, predictor=="Pretreatment" & beta!=0)$drug)
  PselDrugs <- as.character(
    filter(coeffDF, predictor=="Pretreatment" & beta!=0)$drug)
  length(PselDrugs)
  # length(drs[[1]])
}
```

**Conc. 1-5**
![](data:image/png;base64...)

```
## [1] 26
```

**Conc. 4-5**
![](data:image/png;base64...)

```
## [1] 10
```

---

```
options(stringsAsFactors=FALSE)
```

# 24 Survival analysis

Load the data.

```
data(lpdAll, patmeta, drugs)
```

Prepare survival data.

```
lpdCLL <- lpdAll[ , lpdAll$Diagnosis=="CLL"   ]

# data rearrangements
survT = patmeta[colnames(lpdCLL),]
survT[which(survT[,"IGHV"]=="U") ,"IGHV"] = 0
survT[which(survT[,"IGHV"]=="M") ,"IGHV"] = 1
survT$IGHV = as.numeric(survT$IGHV)

colnames(survT) = gsub("Age4Main", "age", colnames(survT))

survT$ibr45  <- 1-Biobase::exprs(lpdCLL)[ "D_002_4:5", rownames(survT)  ]
survT$ide45  <- 1-Biobase::exprs(lpdCLL)[ "D_003_4:5", rownames(survT)  ]
survT$prt45  <- 1-Biobase::exprs(lpdCLL)[ "D_166_4:5", rownames(survT)  ]
survT$selu45 <- 1-Biobase::exprs(lpdCLL)[ "D_012_4:5", rownames(survT)  ]
survT$ever45 <- 1-Biobase::exprs(lpdCLL)[ "D_063_4:5", rownames(survT)  ]

survT$nut15 <- 1-Biobase::exprs(lpdCLL)[ "D_010_1:5", rownames(survT)  ]
survT$dox15 <- 1-Biobase::exprs(lpdCLL)[ "D_159_1:5", rownames(survT)  ]
survT$flu15 <- 1-Biobase::exprs(lpdCLL)[ "D_006_1:5", rownames(survT)  ]

survT$SF3B1      <- Biobase::exprs(lpdCLL)[ "SF3B1",      rownames(survT)  ]
survT$NOTCH1     <- Biobase::exprs(lpdCLL)[ "NOTCH1",     rownames(survT)  ]
survT$BRAF       <- Biobase::exprs(lpdCLL)[ "BRAF",       rownames(survT)  ]
survT$TP53       <- Biobase::exprs(lpdCLL)[ "TP53",       rownames(survT)  ]
survT$del17p13   <- Biobase::exprs(lpdCLL)[ "del17p13",   rownames(survT)  ]
survT$del11q22.3 <- Biobase::exprs(lpdCLL)[ "del11q22.3", rownames(survT)  ]
survT$trisomy12 <-  Biobase::exprs(lpdCLL)[ "trisomy12", rownames(survT)  ]
survT$IGHV_cont <- patmeta[ rownames(survT) ,"IGHV Uppsala % SHM"]

# competinting risk endpoint fpr
survT$compE <- ifelse(survT$treatedAfter == TRUE, 1, 0)
survT$compE <- ifelse(survT$treatedAfter == FALSE & survT$died==TRUE,
                      2, survT$compE )
survT$T7  <- ifelse(survT$compE == 1, survT$T5, survT$T6 )
```

## 24.1 Univariate survival analysis

### 24.1.1 Define forest functions

```
forest <- function(Time, endpoint, title, sdrugs, split, sub) {
  stopifnot(is.character(Time), is.character(title), is.character(split),
            is.character(endpoint),
            all(c(Time, split, endpoint) %in% colnames(survT)),
            is.logical(survT[[endpoint]]),
            is.character(sdrugs), !is.null(names(sdrugs)))

  clrs <- fpColors(box="royalblue",line="darkblue", summary="royalblue")

  res <- lapply(sdrugs, function(g) {
    drug <- survT[, g] * 10

    suse <- if (identical(sub, "none"))
      rep(TRUE, nrow(survT))
    else
      (survT[[split]] == sub)
    stopifnot(sum(suse, na.rm = TRUE) > 1)

    surv <- coxph(Surv(survT[,Time], survT[,endpoint]) ~ drug, subset=suse)
    sumsu <- summary(surv)
    c(p      = sumsu[["coefficients"]][, "Pr(>|z|)"],
      coef   = sumsu[["coefficients"]][, "exp(coef)"],
      lower  = sumsu[["conf.int"]][, "lower .95"],
      higher = sumsu[["conf.int"]][, "upper .95"])
  })

  s <- do.call(rbind, res)
  rownames(s) <- names(sdrugs)

  tabletext <- list(c(NA, rownames(s)), append(list("p-value"),
                                               sprintf("%.4f", s[,"p"])))

  forestplot(tabletext,
           rbind(
             rep(NA, 3),
             s[, 2:4]),
           page = new,
           clip = c(0.8,20),
           xlog = TRUE, xticks = c(0.5,1, 1.5), title = title,
           col = clrs,
           txt_gp = fpTxtGp(ticks = gpar(cex=1) ),
           new_page = TRUE)
}
```

Combine OS and TTT in one plot.

```
com <- function( Time, endpoint, scaleX, sub, d, split, drug_names) {

  res <- lapply(d, function(g)  {

  drug <- survT[,g] * scaleX
  ## all=99, M-CLL=1, U-CLL=0
  if(sub==99) { surv <- coxph(Surv(survT[,paste0(Time)],
                                   survT[,paste0(endpoint)] == TRUE) ~ drug)}
  if(sub<99)  { surv <- coxph(Surv(survT[,paste0(Time)],
                                   survT[,paste0(endpoint)] == TRUE) ~ drug,
                              subset=survT[,paste0(split)]==sub)}

  c(summary(surv)[[7]][,5], summary(surv)[[7]][,2],
                summary(surv)[[8]][,3],
                summary(surv)[[8]][,4])
 })
 s <- do.call(rbind, res)
 colnames(s) <- c("p", "HR", "lower", "higher")
 rownames(s) <- drug_names
 s
}

fp <- function( sub, title, d, split, drug_names, a, b, scaleX) {
   ttt <- com(Time="T5", endpoint="treatedAfter", sub=sub, d=d,
              split=split, drug_names=drug_names, scaleX=scaleX)
   rownames(ttt) <- paste0(rownames(ttt), "_TTT")

   os <-  com(Time="T6", endpoint="died", sub=sub, d=d, split=split,
              drug_names=drug_names, scaleX=scaleX)
   rownames(os) <- paste0(rownames(os), "_OS")

   n <- c( p=NA, HR=NA, lower=NA, higher=NA )
   nn <- t( data.frame( n ) )
   for (i in 1:(nrow(ttt)-1) ) { nn <-rbind(nn, n )  }
   rownames(nn) <- drug_names

   od <- order( c(seq(nrow(nn)), seq(nrow(ttt)), seq(nrow(os)) ))

   s <- data.frame( rbind(nn, ttt, os)[od,  ] )
   s$Name <- rownames(s)
   s$x <- 1:nrow(s)
   s$col <- rep(c("white", "black", "darkgreen"), nrow(ttt) )
   s$Endpoint <- factor( c(rep("nn", nrow(nn) ), rep("TTT", nrow(ttt) ),
                           rep("OS", nrow(os) ) )[od] )
   s$features <- "";  s[ which(s$Endpoint=="OS"),"features"] <- drug_names
   s[which(s$Endpoint=="nn"), "Endpoint"] <- ""
   s <- rbind(s, rep(NA, 8))

   p <- ggplot(data=s ,aes(x=x, y=HR, ymin=lower, ymax=higher,
                           colour=Endpoint)) +  geom_pointrange() +
     theme(legend.position="top", legend.text = element_text(size = 20) ) +
     scale_x_discrete(limits=s$x, labels=s$features ) +
     expand_limits(y=c(a,b)) +
     scale_y_log10(breaks=c(0.01,0.1,0.5,1,2,5,10),
                   labels=c(0.01,0.1,0.5,1,2,5,10)) +
     theme(
           panel.grid.minor = element_blank(),
           axis.title.x = element_text(size=16),
           axis.text.x = element_text(size=16, colour="black"),
           axis.title.y  = element_blank(),
           axis.text.y = element_text(size=12, colour="black"),
           legend.key = element_rect(fill = "white"),
           legend.background = element_rect(fill = "white"),
           legend.title = element_blank(),
           panel.background = element_rect(fill = "white", color="black"),
           panel.grid.major = element_blank(),
           axis.ticks.y = element_blank()
          ) +
     coord_flip() +
     scale_color_manual(values=c("OS"="darkgreen", "TTT"="black"),
                        labels=c("OS", "TTT", "")) +
     geom_hline(aes(yintercept=1), colour="black", size=1.5,
                linetype="dashed", alpha=0.3)  +
     annotate("text", x = 1:nrow(s)+0.5, y = s$HR+0.003,
              label = ifelse( s$p<0.001, paste0("p<","0.001"),
                paste0("p=", round(s$p,3) ) ), colour=s$col)
   plot(p)
}
```

### 24.1.2 Forest plot for genetic factors

```
#FIG# S27
d <- c("SF3B1", "NOTCH1", "BRAF", "TP53", "del17p13", "del11q22.3",
       "trisomy12", "IGHV")
drug_names <- c("SF3B1", "NOTCH1", "BRAF", "TP53", "del17p13", "del11q22.3",
                "Trisomy12" ,"IGHV")

fp(sub=99, d=d, drug_names=drug_names, split="IGHV", title="", a=0, b=10,
   scaleX=1)
```

![](data:image/png;base64...)

### 24.1.3 Forest plot for drug responses

```
#FIG# 6A
d <- c("flu15", "nut15", "dox15", "ibr45", "ide45", "prt45", "selu45",
       "ever45")
drug_names <- c("Fludarabine",  "Nutlin-3", "Doxorubicine", "Ibrutinib",
                "Idelalisib", "PRT062607 HCl", "Selumetinib" ,"Everolimus")

fp(sub=99, d=d, drug_names=drug_names, split="TP53", title="", a=0, b=5,
   scaleX=10)
```

![](data:image/png;base64...)

## 24.2 Kaplan-Meier curves

### 24.2.1 Genetics factors

```
#FIG# S27 left (top+bottom)
par(mfcol=c(1,2))

for (fac in paste(c("IGHV", "TP53"))) {
survplot( Surv(survT$T5, survT$treatedAfter == TRUE)  ~ as.factor(survT[,fac]),
   snames=c("wt", "mut"),
   lwd=1.5, cex.axis = 1, cex.lab=1, col= c("darkmagenta", "dodgerblue4"),
   show.nrisk = FALSE,
   legend.pos = FALSE, stitle = "", hr.pos= "topright",
   main = paste(fac),
   xlab = 'Time (Years)', ylab = 'Time to treatment')
}
```

![](data:image/png;base64...)

```
#FIG# 6B left
#FIG# S27 right (top+bottom)
par(mfcol=c(1,2))

for (fac in paste(c("IGHV", "TP53"))) {
survplot( Surv(survT$T6, survT$died == TRUE)  ~ as.factor(survT[,fac]),
   snames=c("wt", "mut"),
   lwd=1.5, cex.axis = 1.0, cex.lab=1.0, col= c("darkmagenta", "dodgerblue4"),
   show.nrisk = FALSE,
   legend.pos = FALSE, stitle = "", hr.pos= "bottomleft",
   main = paste(fac),
   xlab = 'Time (Years)', ylab = 'Overall survival')
}
```

![](data:image/png;base64...)

### 24.2.2 Drug responses

Drug responses were dichotomized using maximally selected rank statistics. The analysis is also perforemd within subgroups: TP53 wt/ mut. and IGHV wt/ mut.

Time to next treatment (maxstat).

```
par(mfrow=c(1,3), mar=c(5,5,2,0.9))
km(drug = "D_006_1:5", split = "TP53", t="TTT",
   title=c("(TP53", "wt)", "mut)"),  hr="tr", c="maxstat")
```

```
## Fludarabine cutpoint for TTT:  0.65
```

![](data:image/png;base64...)

```
km(drug = "D_159_1:5", split = "TP53", t="TTT",
   title=c("(TP53", "wt)", "mut)"), hr="tr",  c="maxstat")
```

```
## Doxorubicine cutpoint for TTT:  0.56
```

![](data:image/png;base64...)

```
km(drug = "D_010_1:5", split = "TP53", t="TTT",
   title=c("(TP53", "wt)", "mut)"), hr="tr",  c="maxstat")
```

```
## Nutlin-3 cutpoint for TTT:  0.85
```

![](data:image/png;base64...)

```
km(drug = "D_002_4:5", split = "IGHV", t="TTT",
   title=c("(IGHV",  "wt)" , "mut)"), hr="tr", c="maxstat" )
```

```
## Ibrutinib cutpoint for TTT:     1
```

![](data:image/png;base64...)

```
km(drug = "D_003_4:5", split = "IGHV", t="TTT",
   title=c("(IGHV",  "wt)" , "mut)"), hr="tr", c="maxstat" )
```

```
## Idelalisib cutpoint for TTT:  0.99
```

![](data:image/png;base64...)

```
km(drug = "D_166_4:5", split = "IGHV", t="TTT",
   title=c("(IGHV",  "wt)" , "mut)"), hr="tr", c="maxstat" )
```

```
## PRT062607 HCl cutpoint for TTT:  0.98
```

![](data:image/png;base64...)

Overall survival (maxstat).

```
par(mfrow=c(1,3), mar=c(5,5,2,0.9))
km(drug = "D_006_1:5", split = "TP53", t="OS",
   title=c("(TP53", "wt)", "mut)"), hr="bl", c="maxstat")
```

```
## Fludarabine cutpoint for OS:   0.6
```

![](data:image/png;base64...)

```
#FIG# 6B right
#FIG# 6C
km(drug = "D_159_1:5", split = "TP53", t="OS", # doxorubicine
   title=c("(TP53", "wt)", "mut)"), hr="bl", c="maxstat" )
```

```
## Doxorubicine cutpoint for OS:  0.53
```

![](data:image/png;base64...)

```
#FIG# 6B middle
km(drug = "D_010_1:5", split = "TP53", t="OS", # nutlin-3
   title=c("(TP53", "wt)", "mut)"), hr="bl", c="maxstat" )
```

```
## Nutlin-3 cutpoint for OS:  0.89
```

![](data:image/png;base64...)

```
km(drug = "D_002_4:5", split = "IGHV", t="OS",
   title=c("(IGHV",  "wt)" , "mut)"), hr="bl", c="maxstat" )
```

```
## Ibrutinib cutpoint for OS:  0.95
```

![](data:image/png;base64...)

```
km(drug = "D_003_4:5", split = "IGHV", t="OS",
   title=c("(IGHV",  "wt)" , "mut)"), hr="bl", c="maxstat" )
```

```
## Idelalisib cutpoint for OS:   0.9
```

```
## Warning in coxph.fit(X, Y, istrat, offset, init, control, weights = weights, :
## Loglik converged before variable 1 ; coefficient may be infinite.
```

![](data:image/png;base64...)

```
km(drug = "D_166_4:5", split = "IGHV", t="OS",
   title=c("(IGHV",  "wt)" , "mut)"), hr="bl", c="maxstat" )
```

```
## PRT062607 HCl cutpoint for OS:  0.87
```

![](data:image/png;base64...)

## 24.3 Multivariate Cox-model

```
extractSome <- function(x) {
  sumsu <- summary(x)
  data.frame(
    `p-value`      =
      sprintf("%6.3g", sumsu[["coefficients"]][, "Pr(>|z|)"]),
    `HR`           =
      sprintf("%6.3g", signif( sumsu[["coefficients"]][, "exp(coef)"], 2) ),
    `lower 95% CI` =
      sprintf("%6.3g", signif( sumsu[["conf.int"]][, "lower .95"], 2) ),
    `upper 95% CI` =
      sprintf("%6.3g", signif( sumsu[["conf.int"]][, "upper .95"], 2),
              check.names = FALSE) )
}
```

Define covariates and effects.

### 24.3.1 Chemotherapies

#### 24.3.1.1 Fludarabine

```
surv1 <- coxph(
  Surv(T6, died) ~
    age +
    as.factor(IC50beforeTreatment) +
    as.factor(trisomy12) +
    as.factor(del11q22.3) +
    as.factor(del17p13) +
    as.factor(TP53) +
    IGHVwt +
    flu15,       # continuous
    #dox15 +     # continuous
    #flu15:TP53,
    #TP53:dox15,
  data = survT )
extractSome(surv1)
```

```
## Warning in sprintf("%6.3g", signif(sumsu[["conf.int"]][, "upper .95"], 2), :
## one argument not used by format '%6.3g'
```

```
##    p.value     HR lower.95..CI upper.95..CI
## 1    0.403    1.2         0.81          1.7
## 2 0.000285   0.11        0.033         0.36
## 3   0.0196    5.3          1.3           22
## 4    0.784    1.2         0.38          3.6
## 5    0.962      1          0.3          3.6
## 6     0.47   0.63         0.18          2.2
## 7   0.0516    2.8         0.99          7.8
## 8    0.085   0.77         0.57            1
```

```
cat(sprintf("%s patients considerd in the model; number of events %1g\n",
            summary(surv1)$n, summary(surv1)[6] ) )
```

```
## 156 patients considerd in the model; number of events 24
```

#### 24.3.1.2 Doxorubicine

```
surv2 <- coxph(
  Surv(T6, died) ~   #as.factor(survT$TP53) , data=survT )
    age +
    as.factor(IC50beforeTreatment) +
    as.factor(trisomy12) +
    as.factor(del11q22.3) +
    as.factor(del17p13) +
    as.factor(TP53) +
    IGHVwt +
    #flu15 +    # continuous
    dox15 ,     # continuous
    #flu15:TP53 ,
    #TP53:dox15,
  data = survT )
extractSome(surv2)
```

```
## Warning in sprintf("%6.3g", signif(sumsu[["conf.int"]][, "upper .95"], 2), :
## one argument not used by format '%6.3g'
```

```
##    p.value     HR lower.95..CI upper.95..CI
## 1    0.121    1.3         0.92            2
## 2 0.000186   0.11        0.036         0.36
## 3   0.0123    6.1          1.5           25
## 4    0.992      1         0.34            3
## 5     0.92    1.1          0.3          3.8
## 6    0.716   0.81         0.26          2.5
## 7   0.0393    2.9          1.1          8.1
## 8   0.0347   0.52         0.28         0.95
```

```
cat(sprintf("%s patients considerd in the model; number of events %1g\n",
            summary(surv2)$n, summary(surv2)[6] ) )
```

```
## 156 patients considerd in the model; number of events 24
```

### 24.3.2 Targeted therapies

#### 24.3.2.1 Ibrutinib TTT

```
surv4 <- coxph(
  Surv(T5, treatedAfter) ~
    age +
    as.factor(IC50beforeTreatment) +
    as.factor(trisomy12) +
    as.factor(del11q22.3) +
    as.factor(del17p13) +
    IGHVwt +
    ibr45 +
    IGHVwt:ibr45,
  data = survT )

extractSome(surv4)
```

```
## Warning in sprintf("%6.3g", signif(sumsu[["conf.int"]][, "upper .95"], 2), :
## one argument not used by format '%6.3g'
```

```
##    p.value     HR lower.95..CI upper.95..CI
## 1    0.284   0.91         0.76          1.1
## 2 9.61e-08   0.22         0.13         0.39
## 3    0.246    1.5         0.76            3
## 4    0.778   0.91         0.48          1.7
## 5     0.31    1.4         0.74          2.6
## 6   0.0111    2.2          1.2          3.9
## 7   0.0289    1.6          1.1          2.5
## 8   0.0417    0.6         0.37         0.98
```

```
cat(sprintf("%s patients considerd in the model; number of events %1g\n",
            summary(surv4)$n, summary(surv4)[6] ) )
```

```
## 152 patients considerd in the model; number of events 83
```

#### 24.3.2.2 Idelalisib TTT

```
surv6 <- coxph(
  Surv(T5, treatedAfter) ~
    age +
    as.factor(IC50beforeTreatment) +
    as.factor(trisomy12) +
    as.factor(del11q22.3) +
    as.factor(del17p13) +
    IGHVwt +
    ide45 +
    IGHVwt:ide45,
  data = survT )

extractSome(surv6)
```

```
## Warning in sprintf("%6.3g", signif(sumsu[["conf.int"]][, "upper .95"], 2), :
## one argument not used by format '%6.3g'
```

```
##    p.value     HR lower.95..CI upper.95..CI
## 1    0.302   0.91         0.76          1.1
## 2 3.44e-08   0.21         0.12         0.37
## 3    0.214    1.5         0.78            3
## 4    0.667   0.87         0.46          1.7
## 5    0.308    1.4         0.74          2.6
## 6  0.00789    2.4          1.3          4.7
## 7   0.0421    1.6            1          2.6
## 8    0.067    0.6         0.35            1
```

```
cat(sprintf("%s patients considerd in the model; number of events %1g\n",
            summary(surv6)$n, summary(surv6)[6] ) )
```

```
## 152 patients considerd in the model; number of events 83
```

#### 24.3.2.3 PRT062607 HCl TTT

```
surv8 <- coxph(
  Surv(T5, treatedAfter) ~
    age +
    as.factor(IC50beforeTreatment) +
    as.factor(trisomy12) +
    as.factor(del11q22.3) +
    as.factor(del17p13) +
    IGHVwt +
    prt45 +
    IGHVwt:prt45,
  data = survT )

extractSome(surv8)
```

```
## Warning in sprintf("%6.3g", signif(sumsu[["conf.int"]][, "upper .95"], 2), :
## one argument not used by format '%6.3g'
```

```
##    p.value     HR lower.95..CI upper.95..CI
## 1    0.402   0.93         0.78          1.1
## 2 2.19e-08    0.2         0.12         0.36
## 3    0.397    1.4         0.67          2.7
## 4    0.584   0.83         0.43          1.6
## 5    0.415    1.3         0.69          2.4
## 6  0.00446    2.7          1.4          5.4
## 7    0.012    1.6          1.1          2.4
## 8    0.018   0.58         0.37         0.91
```

```
cat(sprintf("%s patients considerd in the model; number of events %1g\n",
            summary(surv8)$n, summary(surv8)[6] ) )
```

```
## 152 patients considerd in the model; number of events 83
```

# 25 End of session

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
##  [1] grid      parallel  stats4    stats     graphics  grDevices utils
##  [8] datasets  methods   base
##
## other attached packages:
##  [1] xtable_1.8-4                     tidyr_1.3.1
##  [3] tibble_3.3.0                     scales_1.4.0
##  [5] Rtsne_0.17                       RColorBrewer_1.1-3
##  [7] readxl_1.4.5                     piano_2.26.0
##  [9] pheatmap_1.0.13                  org.Hs.eg.db_3.22.0
## [11] nat_1.8.25                       rgl_1.3.24
## [13] maxstat_0.7-26                   magrittr_2.0.4
## [15] limma_3.66.0                     knitr_1.50
## [17] ipflasso_1.1                     survival_3.8-3
## [19] hexbin_1.28.5                    gtable_0.3.6
## [21] gridExtra_2.3                    glmnet_4.1-10
## [23] Matrix_1.7-4                     ggdendro_0.2.0
## [25] ggbeeswarm_0.7.2                 genefilter_1.92.0
## [27] forestplot_3.1.7                 checkmate_2.3.3
## [29] doParallel_1.0.17                iterators_1.0.14
## [31] foreach_1.5.2                    dendsort_0.3.4
## [33] cowplot_1.2.0                    colorspace_2.1-2
## [35] broom_1.0.10                     biomaRt_2.66.0
## [37] beeswarm_0.4.0                   abind_1.4-8
## [39] AnnotationDbi_1.72.0             dplyr_1.1.4
## [41] ggplot2_4.0.0                    reshape2_1.4.4
## [43] DESeq2_1.50.0                    SummarizedExperiment_1.40.0
## [45] GenomicRanges_1.62.0             Seqinfo_1.0.0
## [47] IRanges_2.44.0                   S4Vectors_0.48.0
## [49] MatrixGenerics_1.22.0            matrixStats_1.5.0
## [51] Biobase_2.70.0                   BiocGenerics_0.56.0
## [53] generics_0.1.4                   BloodCancerMultiOmics2017_1.30.0
## [55] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] splines_4.5.1         later_1.4.4           bitops_1.0-9
##   [4] filelock_1.0.3        cellranger_1.1.0      XML_3.99-0.19
##   [7] lifecycle_1.0.4       httr2_1.2.1           lattice_0.22-7
##  [10] MASS_7.3-65           backports_1.5.0       sass_0.4.10
##  [13] rmarkdown_2.30        jquerylib_0.1.4       yaml_2.3.10
##  [16] remotes_2.5.0         httpuv_1.6.16         otel_0.2.0
##  [19] sessioninfo_1.2.3     pkgbuild_1.4.8        DBI_1.2.3
##  [22] pkgload_1.4.1         purrr_1.1.0           rappdirs_0.3.3
##  [25] nat.utils_0.6.1       annotate_1.88.0       codetools_0.2-20
##  [28] DelayedArray_0.36.0   DT_0.34.0             tidyselect_1.2.1
##  [31] filehash_2.4-6        shape_1.4.6.1         farver_2.1.2
##  [34] BiocFileCache_3.0.0   base64enc_0.1-3       jsonlite_2.0.0
##  [37] ellipsis_0.3.2        tools_4.5.1           progress_1.2.3
##  [40] Rcpp_1.1.0            glue_1.8.0            Rttf2pt1_1.3.14
##  [43] SparseArray_1.10.1    mgcv_1.9-3            xfun_0.54
##  [46] usethis_3.2.1         shinydashboard_0.7.3  withr_3.0.2
##  [49] BiocManager_1.30.26   fastmap_1.2.0         shinyjs_2.1.0
##  [52] relations_0.6-15      caTools_1.18.3        digest_0.6.37
##  [55] mime_0.13             R6_2.6.1              nabor_0.5.0
##  [58] gtools_3.9.5          dichromat_2.0-0.1     RSQLite_2.4.3
##  [61] utf8_1.2.6            data.table_1.17.8     prettyunits_1.2.0
##  [64] httr_1.4.7            htmlwidgets_1.6.4     S4Arrays_1.10.0
##  [67] sets_1.0-25           pkgconfig_2.0.3       blob_1.2.4
##  [70] S7_0.2.0              XVector_0.50.0        htmltools_0.5.8.1
##  [73] fgsea_1.36.0          bookdown_0.45         png_0.1-8
##  [76] nlme_3.1-168          visNetwork_2.1.4      curl_7.0.0
##  [79] cachem_1.1.0          stringr_1.5.2         KernSmooth_2.23-26
##  [82] vipor_0.4.7           extrafont_0.20        pillar_1.11.1
##  [85] vctrs_0.6.5           gplots_3.2.0          slam_0.1-55
##  [88] promises_1.5.0        dbplyr_2.5.1          cluster_2.1.8.1
##  [91] extrafontdb_1.1       evaluate_1.0.5        tinytex_0.57
##  [94] magick_2.9.0          mvtnorm_1.3-3         cli_3.6.5
##  [97] locfit_1.5-9.12       compiler_4.5.1        rlang_1.1.6
## [100] crayon_1.5.3          labeling_0.4.3        marray_1.88.0
## [103] plyr_1.8.9            fs_1.6.6              stringi_1.8.7
## [106] BiocParallel_1.44.0   Biostrings_2.78.0     devtools_2.4.6
## [109] hms_1.1.4             bit64_4.6.0-1         KEGGREST_1.50.0
## [112] statmod_1.5.1         shiny_1.11.1          exactRankTests_0.8-35
## [115] igraph_2.2.1          memoise_2.0.1         bslib_0.9.0
## [118] fastmatch_1.1-6       bit_4.6.0
```