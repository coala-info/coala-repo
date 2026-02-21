# Using rcellminer

#### 30 October 2025

# Contents

* [1 Overview](#overview)
* [2 Basics](#basics)
  + [2.1 Installation](#installation)
  + [2.2 Getting Started](#getting-started)
  + [2.3 Searching for Compounds](#searching-for-compounds)
  + [2.4 Profile Visualization](#profile-visualization)
  + [2.5 Structure Visualization](#structure-visualization)
* [3 Working with Additional Drug Information](#working-with-additional-drug-information)
  + [3.1 Mechanism of action (MOA)](#mechanism-of-action-moa)
  + [3.2 Drug Activity](#drug-activity)
* [4 Use Cases](#use-cases)
  + [4.1 Pattern Comparison](#pattern-comparison)
  + [4.2 Correlating DNA Copy Number Alteration and Gene Expression](#correlating-dna-copy-number-alteration-and-gene-expression)
  + [4.3 Assessing Correlative Evidence for a Drug MOA Hypothesis](#assessing-correlative-evidence-for-a-drug-moa-hypothesis)
  + [4.4 Relating Gene Alteration Patterns to Drug Responses](#relating-gene-alteration-patterns-to-drug-responses)
* [5 Session Information](#session-information)
* [6 References](#references)
* **Appendix**

# 1 Overview

The NCI-60 cancer cell line panel has been used over the course of several decades as an anti-cancer drug screen. This panel was developed as part of the Developmental Therapeutics Program (DTP, <http://dtp.nci.nih.gov/>) of the U.S. National Cancer Institute (NCI). Thousands of compounds have been tested on the NCI-60, which have been extensively characterized by many platforms for gene and protein expression, copy number, mutation, and others (Reinhold, et al., 2012). The purpose of the CellMiner project (<http://discover.nci.nih.gov/cellminer>) has been to integrate data from multiple platforms used to analyze the NCI-60, and to provide a powerful suite of tools for exploration of NCI-60 data. While CellMiner is an unmatched resource for online exploration of the NCI-60 data, consideration of more specialized scientific questions often requires custom programming. The **rcellminer** R package complements the functionality of CellMiner, providing programmatic data access, together with functions for data visualization and analysis. These functions are approachable for even beginning R users, as illustrated by the initial examples below. The subsequent case studies, inspired by CellMiner-related publications, show how modest amounts of code can script specialized analyses, integrating multiple types of data to yield new scientific insights. **rcellminer** functions also provide robust building blocks for more extensive tools, as exemplifed by the package’s interactive Shiny applications.

# 2 Basics

## 2.1 Installation

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("rcellminer")
BiocManager::install("rcellminerData")
```

## 2.2 Getting Started

Load **rcellminer** and **rcellminerData** packages:

```
library(rcellminer)
library(rcellminerData)
```

A list of all accessible vignettes and methods is available with the following command.

```
help.search("rcellminer")
```

## 2.3 Searching for Compounds

The NSC number is a numeric identifier for substances submitted to the National Cancer Institute (NCI) for testing and evaluation. It is a registration number for the Developmental Therapeutics Program (DTP) repository, and it is used as the unique identifier for compounds in the CellMiner database. NSC stands for National Service Center.

rcellminer allows users to quickly search for NSC IDs by compound name or partial name. For example, many kinase inhibitors end with the suffix “nib”. Users can quickly search NSCs for compound names with this suffix; queries are case insensitive and are treated as regular expressions.

```
searchForNscs("nib$")
```

```
##  Fostamatinib     Semaxanib     Gefitinib     Erlotinib     Lapatinib
##        365798        696819        715055        718781        727989
##     Dasatinib     Pazopanib   Selumetinib      Imatinib     Lapatinib
##        732517        737754        741078        743414        745750
##     Nilotinib     Sunitinib      Afatinib     Pazopanib    Amuvatinib
##        747599        750690        750691        752782        754349
##     Bosutinib     Masitinib     Cediranib     Foretinib    Lenvatinib
##        755389        755400        755606        755775        755980
##    Crizotinib   Quizartinib    Linsitinib     Intedanib  Cabozantinib
##        756645        756647        756652        756659        757436
##     Neratinib      Axitinib     Intedanib     Sapitinib     Tivozanib
##        757439        757441        757442        758005        758007
##    Tivantinib     tepotinib    Trametinib     Ponatinib   Saracatinib
##        758242        758244        758246        758487        758872
##     Dovitinib     Gefitinib     Dasatinib    Tipifarnib    Vandetanib
##        759661        759856        759877        760444        760766
##    Tandutinib     Motesanib  Cabozantinib    brigatinib   Vemurafenib
##        760841        760843        761068        761191        761431
##     Ibrutinib   Ruxolitinib    Crenolanib     Alectinib    Dabrafenib
##        761910        763371        763526        764040        764134
##      Brivanib    Gandotinib     Alectinib    Varlitinib     Bosutinib
##        764481        764820        764821        764823        765694
##   Refametinib   Dacomitinib   Momelotinib    Fedratinib  Lestaurtinib
##        765866        765888        767598        767600        772196
##     Vatalanib      Apatinib  Fostamatinib     Bafetinib    Rebastinib
##        772499        772886        772992        773263        774831
##     Telatinib   Encorafenib    Defactinib   osimertinib   spebrutinib
##        776017        778304        778364        779217        780020
##     volitinib    Defactinib    poziotinib   altiratinib    brigatinib
##        782121        782549        783296        784590        787457
##  gilteritinib     Bafetinib  sitravatinib acalabrutinib     olmutinib
##        787846        788186        788203        791164        792848
##    ensartinib   ulixertinib    Sulfatinib  zanubrutinib      Afatinib
##        793150        797771        797937        799318        799327
##      Axitinib    Crizotinib     Dasatinib     Gefitinib     Lapatinib
##        799341        800080        800087        800105        800780
##     Nilotinib     Pazopanib     Pelitinib   Selumetinib     Sunitinib
##        800804        800839        800841        800882        800937
##    Vandetanib   Vemurafenib   futibutinib
##        800961        800964        813488
```

## 2.4 Profile Visualization

Often, it is useful for researchers to plot multiple data profiles next to each other in order to visually identify patterns. Below are examples for the visualization of various profiles: single drugs and multiple drugs, as well as molecular profiles and combinations of drug and molecular profiles.

```
# Get Cellminer data
drugAct <- exprs(getAct(rcellminerData::drugData))
molData <- getMolDataMatrices()

# One drug
nsc <- "94600"
plots <- c("drug")
plotCellMiner(drugAct, molData, plots, nsc, NULL)
```

![](data:image/png;base64...)

```
# One expression
gene <- "TP53"
plots <- c("exp")
plotCellMiner(drugAct, molData, plots, NULL, gene)
```

![](data:image/png;base64...)

```
# Two drugs: Irinotecan and topotecan
nsc <- c("616348", "609699")
plots <- c("drug", "drug")
plotCellMiner(drugAct, molData, plots, nsc, NULL)
```

![](data:image/png;base64...)

```
# Two genes
# NOTE: subscript out of bounds Errors likely mean the gene is not present for that data type
gene <- c("TP53", "MDM2")
plots <- c("exp", "mut", "exp")
plotCellMiner(drugAct, molData, plots, NULL, gene)
```

![](data:image/png;base64...)

```
# Gene and drug to plot
nsc <- "609699"
gene <- "SLFN11"
plots <- c("exp", "cop", "drug")
plotCellMiner(drugAct, molData, plots, nsc, gene)
```

![](data:image/png;base64...)

### 2.4.1 Visualizing Drug Sets

For related drugs, it is often useful to visualize a summary of drug activity. **rcellminer** allows you to easily plot a drug set’s average activity z-score pattern over the NCI-60, together with 1 standard deviation error bars to gauge variation in response behavior.

```
# Get CellMiner data
drugAct <- exprs(getAct(rcellminerData::drugData))

drugs <- as.character(searchForNscs("camptothecin"))
drugAct <- drugAct[drugs,]
mainLabel <- paste("Drug Set: Camptothecin Derivatives, Drugs:", length(drugs), sep=" ")

plotDrugSets(drugAct, drugs, mainLabel)
```

![](data:image/png;base64...)

## 2.5 Structure Visualization

Drug compound structures are provided as annotations for drug compounds. The structures of CellMiner compounds can be visualized and compared using the **rcdk** package.

```
drugAnnot <- getFeatureAnnot(rcellminerData::drugData)[["drug"]]
drugAnnot[1:5, "SMILES"]
```

```
## [1] "CC1=CC(=O)C=CC1=O"
## [2] "CCCCCCCCCCCCCCCc1cc(O)ccc1N"
## [3] "CN(C)CCC(=O)c1ccccc1"
## [4] "C[C@H]1C[C@H](C)C(=O)[C@@H](C1)[C@H](O)CC2CC(=O)NC(=O)C2"
## [5] "OC(=O)CCCc1ccccc1"
```

# 3 Working with Additional Drug Information

## 3.1 Mechanism of action (MOA)

**rcellminer** provides the mechanism of action (MOA) category for compounds for which this information is available. The MOA specifies the biochemical targets or processes that a compound affects. MOAs are indicated by CellMiner abbreviations, though more detailed descriptions can be obtained as indicated below.

### 3.1.1 Get MOA information

Find known MOA drugs and organize their essential information in a table.

```
# getFeatureAnnot() returns a named list of data frames with annotation data
# for drugs ("drug") and drug activity repeat experiments ("drugRepeat").
drugAnnot <- getFeatureAnnot(rcellminerData::drugData)[["drug"]]

# Get the names and MOA for compounds with MOA entries
knownMoaDrugs <- unique(c(getMoaToCompounds(), recursive = TRUE))
knownMoaDrugInfo <- data.frame(NSC=knownMoaDrugs, stringsAsFactors = FALSE)
knownMoaDrugInfo$Name <- drugAnnot[knownMoaDrugInfo$NSC, "NAME"]

# Process all NSCs
knownMoaDrugInfo$MOA <- sapply(knownMoaDrugInfo$NSC, getMoaStr)

# Order drugs by mechanism of action.
knownMoaDrugInfo <- knownMoaDrugInfo[order(knownMoaDrugInfo$MOA), ]

# Drug_MOA_Key data frame provides further details on MOA abbrevations.
Drug_MOA_Key[c("A2", "A7"), ]
```

## 3.2 Drug Activity

Additionally, **rcellminer** provides GI50 (50% growth inhibition) values for the compounds in the database. GI50 values are similar to IC50 values, which are the concentrations that cause 50% growth inhibition, but have been renamed to emphasize the correction for the cell count at time zero. Further details on the assay used are available on the [DTP website](http://dtp.nci.nih.gov/docs/compare/compare_methodology.html).

### 3.2.1 Get GI50 values

Compute GI50 data matrix for known MOA drugs.

```
negLogGI50Data <- getDrugActivityData(nscSet = knownMoaDrugInfo$NSC)

gi50Data <- 10^(-negLogGI50Data)
```

Construct integrated data table (drug information and NCI-60 GI50 activity).

```
knownMoaDrugAct <- as.data.frame(cbind(knownMoaDrugInfo, gi50Data), stringsAsFactors = FALSE)

# This table can be written out to a file
#write.table(knownMoaDrugAct, file="knownMoaDrugAct.txt", quote=FALSE, sep="\t", row.names=FALSE, col.names=TRUE, na="NA")
```

# 4 Use Cases

## 4.1 Pattern Comparison

In this example, we construct and visualize a composite gene inactivation pattern for the
widely studied PTEN tumor suppressor gene, integrating gene expression, copy, and mutation data.
The composite pattern is then used to identify compounds with correlated activity patterns.

```
# Gene of interest
gene <- "PTEN"

# Get Data
drugAct <- exprs(getAct(rcellminerData::drugData))
molData <- getMolDataMatrices()

# Get the cell lines names for cell lines meeting particular thresholds
copKnockdown <- names(which(molData[["cop"]][paste0("cop", gene), ] < -1))
expKnockdown <- names(which(molData[["exp"]][paste0("exp", gene), ] < -1.5))
mutKnockdown <- names(which(molData[["mut"]][paste0("mut", gene), ] == 1))

# Make composite pattern
pattern <- rep(0, length(molData[["cop"]][paste0("cop", gene), ]))
names(pattern) <- names(molData[["cop"]][paste0("cop", gene), ])
tmp <- Reduce(union, list(copKnockdown, expKnockdown, mutKnockdown))
pattern[tmp] <- 1

# Composite plot data
extraPlot <- list()
extraPlot[["title"]] <- "Composite Pattern"
extraPlot[["label"]] <- "Knockdown Composite (Binary)"
extraPlot[["values"]] <- pattern

# Plot data
plotCellMiner(molData=molData, plots=c("cop", "exp", "mut"), gene=gene, extraPlot=extraPlot)
```

![](data:image/png;base64...)

```
# Significant drug correlations to FDA-approved/Clinical trial drugs
# getFeatureAnnot() returns a named list of data frames with annotation data
# for drugs ("drug") and drug activity repeat experiments ("drugRepeat").
drugAnnot <- getFeatureAnnot(rcellminerData::drugData)[["drug"]]
tmpDA <- drugAnnot[drugAnnot$FDA_STATUS != "-", c("NSC", "FDA_STATUS")]

tmpDrugAct <- drugAct[rownames(drugAct) %in% tmpDA$NSC,]

results <- patternComparison(pattern, tmpDrugAct)
sigResults <- results[results$PVAL < 0.01, ]

# Get names of drugs that are FDA approved or in clinical trials
getDrugName(rownames(sigResults))
```

```
##                                                                                                                                                                                                                                                                                                    623753
##                                                                                                                                                                                                                                                                                               "STK021220"
##                                                                                                                                                                                                                                                                                                    695605
##                                                                                                                                                                                                       "3-[3,4-Dihydroxy-5-(hydroxymethyl)tetrahydrofuran-2-yl]-4-(dimethylamino)cyclobut-3-ene-1,2-dione"
##                                                                                                                                                                                                                                                                                                    671332
##                                                                                                                                                                                                                                                   "N',2-Bis(2-bromo-4-methylphenyl)diazenecarbohydrazide"
##                                                                                                                                                                                                                                                                                                    671352
##                                                                                                                                                                                                                              "3-(4-(Dimethylamino)phenyl)-4,5-bis(phenylimino)-1,3-thiazolidine-2-thione"
##                                                                                                                                                                                                                                                                                                    698983
##                                                                                                                                                                                                                          "1-[[2-(9-Bromoindolo[3,2-b]quinoxalin-6-yl)acetyl]amino]-3-cyclohexyl-thiourea"
##                                                                                                                                                                                                                                                                                                    641238
##                                                                                                                                                                                                        "N-(4-Chloro-2-methylphenyl)-4-naphthalen-2-yl-2,4-dioxo-3-(3-oxo-1H-2-benzofuran-1-yl)butanamide"
##                                                                                                                                                                                                                                                                                                    625612
##                                                                                                                                                               "6-(2-((5-((2-((5-Cyanopentyl)oxy)ethoxy)methyl)-2,2-bis(7-(3,5-di-tert-butylphenyl)heptyl)-1,3-dioxolan-4-yl)methoxy)ethoxy)hexanenitrile"
##                                                                                                                                                                                                                                                                                                    633321
##                                                                                                                                                                                                             "7-Methoxy-5-oxo-2,3,10,10a-tetrahydro-5H-[1,3]oxazolo[3,2-b]isoquinoline-10-carboxylic acid"
##                                                                                                                                                                                                                                                                                                    736356
##                                                                                                                                                                                                   "(2E)-2-cyano-2-(6-oxo-2,5-dihydro-[1,2,4]triazolo[3,4-a]phthalazin-3-ylidene)-N-phenylethanethioamide"
##                                                                                                                                                                                                                                                                                                    679046
##                                                                                                                                                                                                                       "(3-Iodo-2,2,4,4-tetraoxido-1,5,2,4-dioxadithiepan-3-yl)(naphthalen-2-yl)methanone"
##                                                                                                                                                                                                                                                                                                    679047
##                                                                                                                                                                                                                                "Naphthalen-1-yl(2,2,4,4-tetraoxido-1,5,2,4-dioxadithiepan-3-yl)methanone"
##                                                                                                                                                                                                                                                                                                    719416
##                                                                                                                                                                                                                                    "2-Hydroxy-5-(4-methoxyphenyl)-5,11-dihydro-6h-benzo[b]carbazol-6-one"
##                                                                                                                                                                                                                                                                                                    655077
##                                                                                                                                                                                                                                    "(4R)-4-[(1S)-3,3-diethoxy-1-hydroxy-propyl]-1,3-oxathiolane-2-thione"
##                                                                                                                                                                                                                                                                                                     19987
##                                                                                                                                                                                                                                                                                      "Methylprednisolone"
##                                                                                                                                                                                                                                                                                                    636114
##                                                                                                                                                                                                                                                    "1,3,5-triazine-2,4-dithiol, 6-(3,4-dichlorophenoxy)-"
##                                                                                                                                                                                                                                                                                                    689136
##                                                                                                                                                                                 "4-(4-Methoxyphenyl)-9-propan-2-yl-4,20-diazapentacyclo[11.7.0.02,6.07,12.014,19]icosa-1(13),14,16,18-tetraene-3,5-dione"
##                                                                                                                                                                                                                                                                                                    690690
##                                                                                                                                                                                                                                                       "Ethyl 3-(5-amino-4-cyano-1,3-oxazol-2-yl)acrylate"
##                                                                                                                                                                                                                                                                                                    707021
##                                                                                                                                                                                                                               "2,5-Bis[(2,4,6-trimethylphenyl)sulfonyl]-1,6-dioxa-2,5-diazacycloundecane"
##                                                                                                                                                                                                                                                                                                    703306
##                                                                                                                                                                                                                      "4-[bis(2-cyanoethyl)amino]-N'-(4-fluorophenyl)-N-phenyliminobenzenecarboximidamide"
##                                                                                                                                                                                                                                                                                                    700642
##                                                                                                                                                                                                    "1,3-Bis[5-[1-(chloromethyl)-5-nitro-1,2-dihydrobenzo[e]indole-3-carbonyl]-2-methyl-pyrazol-3-yl]urea"
##                                                                                                                                                                                                                                                                                                    649148
##                                                                                                                                                                                                                                                    "N~2~-(3,4,5-Trimethoxyphenyl)-2,7-quinoxalinediamine"
##                                                                                                                                                                                                                                                                                                    335995
##                                                                                                                                                                    "(7,12,13,14-Tetraacetyloxy-3,10-dioxo-2,9-dioxatetracyclo[6.6.2.04,16.011,15]hexadeca-1(14),4,6,8(16),11(15),12-hexaen-6-yl) acetate"
##                                                                                                                                                                                                                                                                                                    734133
##                                                                                                                                                                                                                                             "6-(2',5'-dichloro-phenyl)-4(4'-flouro-phenyl) - 1h -pyra..."
##                                                                                                                                                                                                                                                                                                    704128
##                                                                                                                                                                                                                                                                              "Ikesweoghpmerw-wsokhjqssa-"
##                                                                                                                                                                                                                                                                                                    641149
##                                                                                                                                                                                                                                                                         "1-Chloro-7-methyl-phenothiazone"
##                                                                                                                                                                                                                                                                                                    129925
##                                                                                                                                                                                                                                              "2-[(2-Hydroxynaphthalen-1-yl)amino]-4-methylpentanoic acid"
##                                                                                                                                                                                                                                                                                                    722177
##                                                                                                                                                                                                                                             "2-[3,5-(dimethoxy)anilino]-3-phenyl-5,7-diammino quinoxa..."
##                                                                                                                                                                                                                                                                                                    699400
##                                                                                                                                                                                                  "1'-(2-Trimethylsilylethoxymethyl)-1-[tri(propan-2-yl)silylmethyl]spiro[cyclohexene-6,3'-indole]-2'-one"
##                                                                                                                                                                                                                                                                                                    653010
##                                                                                                                                                                                                                    "2-{[2-Chloro-4-(3-nitrophenyl)-3-oxoazetidin-1-yl]amino}-6-methylpyrimidin-4(1H)-one"
##                                                                                                                                                                                                                                                                                                    632244
##                                                                                                                                                                                                                                                                                               "STK074931"
##                                                                                                                                                                                                                                                                                                    671372
##                                                                                                                                                                                                                                                                                         "AN-689/41741230"
##                                                                                                                                                                                                                                                                                                    653015
##                                                                                                                                                                                                           "2-Chloro-1-((4-hydroxy-6-methyl-2-pyrimidinyl)amino)-4-(3,4,5-trimethoxyphenyl)-3-azetidinone"
##                                                                                                                                                                                                                                                                                                    669634
##                                                                                                                                                                                                                                        "benzyl N-[1-dimethoxyphosphoryl-2-(1H-indol-3-yl)ethyl]carbamate"
##                                                                                                                                                                                                                                                                                                    727450
##                                                                                                                                                                                                                                         "1-[4-[[2-(Benzotriazol-1-yl)quinolin-4-yl]amino]phenyl]ethanone"
##                                                                                                                                                                                                                                                                                                    629122
##                                                                                                                                                                                                                                                                              "acetyl(diphenyl)[?]tetrone"
##                                                                                                                                                                                                                                                                                                    668024
##                                                                                                                                                                                                                                "Dibenzyl 2,2-bis((1,3-dioxo-1,3-dihydro-2H-isoindol-2-yl)methyl)malonate"
##                                                                                                                                                                                                                                                                                                    667456
##                                                                                                                                                                                                                                                                  "2-phenyl-4H-1,4-benzothiazine-3-thione"
##                                                                                                                                                                                                                                                                                                    704083
##                                                                                                                                                                                                                "N-[(2-methoxyphenyl)methyl]-1,1-dioxo-2-phenyl-4H-pyrido[4,3-e][1,2,4]thiadiazin-3-imine"
##                                                                                                                                                                                                                                                                                                    689139
##                                                                                                                                                                   "4-(4-Methoxyphenyl)-16-methyl-9-propan-2-yl-4,20-diazapentacyclo[11.7.0.02,6.07,12.014,19]icosa-1(13),14(19),15,17-tetraene-3,5-dione"
##                                                                                                                                                                                                                                                                                                    689957
##                                                                                                                                                                                                                                                               "2-(3-Chlorobenzylidene)cycloheptane-1-one"
##                                                                                                                                                                                                                                                                                                    681538
##                                                                                                                                                                                                                                  "3-benzyl-4-[(E)-(2-chlorophenyl)methyleneamino]-1H-1,2,4-triazol-5-one"
##                                                                                                                                                                                                                                                                                                    667468
##                                                                                                                                                                                                                                                    "3,5-dihydro-2H-benzo[i][1,5]benzothiazepine-4-thione"
##                                                                                                                                                                                                                                                                                                    740124
##                                                                                                                                                                                                                                         "5-(4-chlorophenyl)-3-(3,4,5-trimethoxyphenyl)-1H-imidazol-2-one"
##                                                                                                                                                                                                                                                                                                    705874
##                                                                                                                                                                                                                                             "1,1-Diphenyl-3-[4-[(4-sulfamoylphenyl)sulfamoyl]phenyl]urea"
##                                                                                                                                                                                                                                                                                                    682816
##                                                                                                                                                                "10,18-Dioxa-2,26,32-triazapentacyclo[25.2.2.112,16.04,9.019,24]dotriaconta-1(30),2,4,6,8,12(32),13,15,19,21,23,25,27(31),28-tetradecaene"
##                                                                                                                                                                                                                                                                                                    737618
##                                                                                                                                                                                                                                  "N-([1]benzofuro[2,3-b]quinolin-11-yl)-N',N'-dimethylethane-1,2-diamine"
##                                                                                                                                                                                                                                                                                                    105444
##                                                                                                                                                                                                                   "1-((4'-((1-Cyanocyclopentyl)amino)[1,1'-biphenyl]-4-yl)amino)cyclopentanecarbonitrile"
##                                                                                                                                                                                                                                                                                                    643476
##                                                                                                                                                                                                                                            "[3-(Ethoxymethyl)-2,6-dihydro-1,3,5-oxadiazin-4-yl]cyanamide"
##                                                                                                                                                                                                                                                                                                    740115
##                                                                                                                                                                                                                                             "ethyl 3-methyl-7-trifluoromethylquinoxaline-4-oxide 2-ca..."
##                                                                                                                                                                                                                                                                                                    715589
##                                                                                                                                                                             "2-[[4-[2-[bis(4-fluorophenyl)methoxy]ethyl]piperazin-1-yl]methyl]-1,2,3,4-tetrahydronaphthalen-1-ol;(Z)-but-2-enedioic acid"
##                                                                                                                                                                                                                                                                                                    723427
##                                                                                                                                                                                                                                             "2-(para-hydroxyphenyl)-1-[(6,7-dimethoxy-2-(2-thienyl)-4..."
##                                                                                                                                                                                                                                                                                                    705847
##                                                                                                                                                                                                                                              "(1,3-Dimethyl-2,3-dihydro-1,5-benzodiazepin-4-yl)hydrazine"
##                                                                                                                                                                                                                                                                                                    645569
##                                                                                                                                                                                                                                                             "Trimethylstannyl 2-acetoxy-2-phenyl-acetate"
##                                                                                                                                                                                                                                                                                                    702422
##                                                                                                                                                                                                                                                        "1,3-bis[(E)-dimethylsulfamoyliminomethyl]benzene"
##                                                                                                                                                                                                                                                                                                    655765
##                                                                                                                                                             "(4bR,12aS)-2-[2-(diethylamino)ethyl]-8-methoxy-12a-methyl-4,4a,4b,5,6,10b,11,12-octahydronaphtho[2,1-f]isoquinoline-1,3-dione;hydrochloride"
##                                                                                                                                                                                                                                                                                                    704376
##                                                                                                                                                                                               "(5Z)-5-[[4-[(2R)-4-aminobutan-2-yl]-3,5-dimethyl-1H-pyrrol-2-yl]methylidene]-4-ethyl-3-methylpyrrol-2-one"
##                                                                                                                                                                                                                                                                                                    647338
##                                                                                                                                                                                                                                           "5-Chloro-5-methoxy-2-(4-methoxyphenyl)cyclohexanecarbaldehyde"
##                                                                                                                                                                                                                                                                                                    718800
##                                                                                                                                                                      "(2S)-N-[(2S)-1-[2-(5-methoxy-1H-indol-3-yl)ethylamino]-1-oxo-3-phenylpropan-2-yl]-3-methyl-2-(2,2,2-trifluoroethylamino)butanamide"
##                                                                                                                                                                                                                                                                                                    717561
##                                                                                                                                                                                                                                                                                            "C28H28BrN3O3"
##                                                                                                                                                                                                                                                                                                     66380
##                                                                                                                                                                                                            "[2-Amino-9-[3,4-dihydroxy-5-(hydroxymethyl)oxolan-2-yl]purin-6-yl]-trimethylazanium;chloride"
##                                                                                                                                                                                                                                                                                                    676748
##                                                                                                                                                                                                                                                             "2-diethoxyphosphoryl-N-methyl-butan-2-amine"
##                                                                                                                                                                                                                                                                                                    671348
##                                                                                                                                                                                                                                                            "N',2-Bis(4-bromophenyl)diazenecarbohydrazide"
##                                                                                                                                                                                                                                                                                                    690395
##                                                                                                                                                                                                                                                          "2-Benzyl-1-oxo-isothiazolo[5,4-b]pyridin-3-one"
##                                                                                                                                                                                                                                                                                                    727676
##                                                                                                                                                                                                                                                                                            "dl-thiorphan"
##                                                                                                                                                                                                                                                                                                    702652
##                                                                                                                                                                                                                                               "2-[2-(Benzoyloxymethyl)-1,3-benzothiazol-6-yl]acetic acid"
##                                                                                                                                                                                                                                                                                                    743065
##                                                                                                                                                                                                                "2-[[3-(Dimethylamino)propyl-propan-2-ylamino]methyl]-4-iodo-6-methylphenol;hydrochloride"
##                                                                                                                                                                                                                                                                                                    660850
##                                                                                                                                                                                                                     "2-(Methoxyimino)-N-(1,3-thiazol-5-yl)-2-(2-(tritylamino)-1,3-thiazol-4-yl)acetamide"
##                                                                                                                                                                                                                                                                                                    645455
##                                                                                                                                                                                                                                  "4-Methyl-1,2-bis(trifluoromethyl)-1,2,3,6-tetrahydro-1,2-diphosphinine"
##                                                                                                                                                                                                                                                                                                    645468
##                                                                                                                                                                                                                                                       "[1,3]Benzoxathiepino[5,4-d]pyrimidine 5,5-dioxide"
##                                                                                                                                                                                                                                                                                                     13316
##                                                                                                                                                                                                                                               "(2-(4-chlorophenyl)quinolin-4-yl)(piperidin-2-yl)methanol"
##                                                                                                                                                                                                                                                                                                    651703
##                                                                                                                                                                                                          "4-(5-(4-Chlorophenyl)-1,3,4-oxadiazol-2-yl)-1,5-dimethyl-2-phenyl-1,2-dihydro-3H-pyrazol-3-one"
##                                                                                                                                                                                                                                                                                                    655458
##                                                                                                                                                                                                                                                        "3-Methyl-1,5-dioxido-1,5-naphthyridine-1,5-diium"
##                                                                                                                                                                                                                                                                                                    617369
##                                                                                                                                                                                                                                              "[(E)-3-trimethylsilylpent-3-enyl] 4-methylbenzenesulfonate"
##                                                                                                                                                                                                                                                                                                    649577
##                                                                                                                                                                                                               "2-(2,2-Dimethyl-4-oxo-3,10-dihydro-1H-phenothiazin-3-yl)-N-(3-nitrophenyl)-2-oxoacetamide"
##                                                                                                                                                                                                                                                                                                    694095
##                                                                                                                                                                                                                                                                 "1-(Bis(acetyloxy)amino)-4-methylbenzene"
##                                                                                                                                                                                                                                                                                                    645877
##                                                                                                                                                                                                           "N-(2-Chloro-5-methylphenyl)-2,4-dioxo-3-(3-oxo-1H-2-benzofuran-1-yl)-4-pyridin-4-ylbutanamide"
##                                                                                                                                                                                                                                                                                                    285682
##                                                                                                                                                                                                                                             "phosphonamidic acid, p-1-aziridinyl-n,n-bis(2-chloroethy..."
##                                                                                                                                                                                                                                                                                                    643498
##                                                                                                                                                                                                                                                    "N-methyl-N'-(methylsulfamoyl)benzenesulfonohydrazide"
##                                                                                                                                                                                                                                                                                                    671394
##                                                                                                                                                                                                                                             "1-p-anisyl-3-(n,n-dimethyl-p-aminophenyl)-4,5-bis(p-anis..."
##                                                                                                                                                                                                                                                                                                    707463
##                                                                                                                                                                                                "2-(3,4-dichlorophenyl)-N-methyl-N-[(1S,2S)-2-(1-methylpyrrolidin-1-ium-1-yl)cyclohexyl]acetamide;bromide"
##                                                                                                                                                                                                                                                                                                    741087
##                                                                                                                                                                                                                                             "6-(o-ethyl-2?-morpholino)-7-(p-methoxycinnamoyl)-3-methy..."
##                                                                                                                                                                                                                                                                                                    669992
##                                                                                                                                                                                                                                                          "4-Benzyl-2-(2-thienyl)-4,5-dihydro-1,3-oxazole"
##                                                                                                                                                                                                                                                                                                    137633
##                                                                                                                                                                                                                                        "2-bromo-N-[(2-imino-4-methyl-1,3-thiazol-5-ylidene)amino]aniline"
##                                                                                                                                                                                                                                                                                                    654289
##                                                                                                                                                                                                                                                                                               "C23H25NO2"
##                                                                                                                                                                                                                                                                                                    653009
##                                                                                                                                                                                                                    "2-{[2-Chloro-4-(4-nitrophenyl)-3-oxoazetidin-1-yl]amino}-6-methylpyrimidin-4(1H)-one"
##                                                                                                                                                                                                                                                                                                    617576
##                                                                                                                                                                                                                        "2,4-dichloro-6-[(E)-[(2-hydroxybenzoyl)hydrazinylidene]methyl]phenolate;iron(2+)"
##                                                                                                                                                                                                                                                                                                    709906
##                                                                                                                                                                                                                 "(3s,6r)-1,4-Bis(4-methoxybenzyl)-3-(1-methylethyl)-6-prop-2-yn-1-ylpiperazine-2,5-dione"
##                                                                                                                                                                                                                                                                                                    706476
##                                                                                                                                                                                                                                                                                           "Remangilone C"
##                                                                                                                                                                                                                                                                                                    727287
##                                                                                                                                                                                                                          "3-methylsulfanyl-5-[(1R,2R)-2-(3,4,5-trimethoxyphenyl)cyclopropyl]-1H-pyrazole"
##                                                                                                                                                                                                                                                                                                    699431
##                                                                                                                                                                                                                                        "3,5-Bis[5-(4-tert-butylphenyl)-1,3,4-oxadiazol-2-yl]benzonitrile"
##                                                                                                                                                                                                                                                                                                    710006
##                                                                                                                                                                                                                       "[5-methyl-4-(phenylcarbamothioyl)-2-propan-2-ylphenyl] N-naphthalen-1-ylcarbamate"
##                                                                                                                                                                                                                                                                                                    115497
##                                                                                                                                                                                                                                                                                                "toxifren"
##                                                                                                                                                                                                                                                                                                    705023
##                                                                                                                                                                             "[(2S,4R,10R,12S)-3,11-dioxahexacyclo[7.7.2.02,4.05,18.010,12.013,17]octadeca-1(16),5,7,9(18),13(17),14-hexaen-6-yl] acetate"
##                                                                                                                                                                                                                                                                                                    652128
##                                                                                                                                                                                                                                      "3-Diisopropoxyphosphoryl-1-(4-nitrophenyl)-5-phenyl-1,2,4-triazole"
##                                                                                                                                                                                                                                                                                                    403801
##                                                                                                                                                                                                                                                               "1-Bis(4-chlorophenoxy)phosphorylaziridine"
##                                                                                                                                                                                                                                                                                                    693718
##                                                                                                                                                                                                                                                 "1-Benzyl 2-methyl 5-thioxo-1,2-pyrrolidinedicarboxylate"
##                                                                                                                                                                                                                                                                                                    653037
##                                                                                                                                                                                                                     "N-[3-Chloro-2-(4-hydroxy-3-methoxy-phenyl)-4-oxo-azetidin-1-yl]-2-hydroxy-benzamide"
##                                                                                                                                                                                                                                                                                                    707482
##                                                                                                                                                                                                                                                                                                  "SNC-67"
##                                                                                                                                                                                                                                                                                                    204667
##                                                                                                                                                                                                                                                  "4-(((2-Fluoroanilino)carbonyl)amino)benzenesulfonamide"
##                                                                                                                                                                                                                                                                                                    700221
##                                                                                                                                                                                                                                                  "1-(4-Methoxyphenyl)-5-phenyl-2,3-bis(2-thienyl)pyrrole"
##                                                                                                                                                                                                                                                                                                    627677
##                                                                                                                                                                                                                                                 "4-Benzyl-2-phenyl-pyrazolo[4,3-c]isoquinolin-4-ium-3-ol"
##                                                                                                                                                                                                                                                                                                    356903
##                                                                                                                                                                                                                  "3-[(2E)-3-(2H-1,3-Benzodioxol-5-yl)prop-2-enoyl]-2-hydroxycyclohepta-2,4,6-trien-1-one"
##                                                                                                                                                                                                                                                                                                    641225
##                                                                                                                                                                                                 "N-(6-Methyl-1,3-benzothiazol-2-yl)-4-naphthalen-2-yl-2,4-dioxo-3-(3-oxo-1H-2-benzofuran-1-yl)butanamide"
##                                                                                                                                                                                                                                                                                                     94783
##                                                                                                                                                                                                               "4-[15-(4-Hydroxy-3-methoxy-phenyl)-1,3,14,16-tetrathiacyclohexacos-2-yl]-2-methoxy-phenol"
##                                                                                                                                                                                                                                                                                                    704873
##                                                                                                                                                                                                                          "(4Z)-4-[(2-hydroxyphenyl)methylidene]-2-(2-phenylhydrazinyl)-1H-imidazol-5-one"
##                                                                                                                                                                                                                                                                                                    723330
##                                                                                                                                                                                                                                             "(9r,11r,15r)-4,5-dibromo-1h-pyrrole-2-carboxylic acid (6..."
##                                                                                                                                                                                                                                                                                                    736156
##                                                                                                                                                                                                                 "3-(3-Chloro-4-fluorophenyl)-6-(4-fluorophenyl)-[1,2,4]triazolo[3,4-b][1,3,4]thiadiazole"
##                                                                                                                                                                                                                                                                                                    665774
##                                                                                                                                                                                                               "8-(3-(2-(4-Fluorophenyl)-1,3-dioxolan-2-yl)propyl)-3-phenyl-8-azabicyclo[3.2.1]octan-3-ol"
##                                                                                                                                                                                                                                                                                                    658098
##                                                                                                                                                                           "[4-[1,2-bis(propan-2-ylcarbamoyloxymethyl)-6,7-dihydro-5H-pyrrolizin-3-yl]pyridin-1-ium-1-yl]methyl 2-methylpropanoate;iodide"
##                                                                                                                                                                                                                                                                                                    642904
##                                                                                                                                                                                                                                                                         "7-methyl-coumarin-4-acetic acid"
##                                                                                                                                                                                                                                                                                                    628199
##                                                                                                                                                                                                                                                                                             "EN300-79332"
##                                                                                                                                                                                                                                                                                                    724322
##                                                                                                                                                                                                                                                                                               "Pyrazol-F"
##                                                                                                                                                                                                                                                                                                    671969
##                                                                                                                                                                                                                          "N-(2-Methylphenyl)-N'-(2,2,2-trifluoro-1-methoxy-1-(trifluoromethyl)ethyl)urea"
##                                                                                                                                                                                                                                                                                                    732191
##                                                                                                                                                                                                    "(3E)-3-[[6-(4-chlorophenyl)-2-methylimidazo[2,1-b][1,3,4]thiadiazol-5-yl]methylidene]-1H-indol-2-one"
##                                                                                                                                                                                                                                                                                                    662566
##                                                                                                                                                                                                                                                                             "LPOQYIAWZPQUSJ-UHFFFAOYSA-N"
##                                                                                                                                                                                                                                                                                                    710906
##                                                                                                                                                                                              "4,6-dinitro-5-[(2E)-2-[(E)-3-(5-nitrofuran-2-yl)prop-2-enylidene]hydrazinyl]-1,3-dihydrobenzimidazol-2-one"
##                                                                                                                                                                                                                                                                                                    730231
##                                                                                                                                                                                                                                             "(2z,6e,10e)-3-allyl-7,11,15-trimethylhexadeca-2,6,10,14-..."
##                                                                                                                                                                                                                                                                                                    726272
##                                                                                                                                                                                                       "3-[(4-Chlorophenoxy)methyl]-6-(4-fluoro-3-phenoxyphenyl)-[1,2,4]triazolo[3,4-b][1,3,4]thiadiazole"
##                                                                                                                                                                                                                                                                                                    729115
##                                                                                                                                                                                                                                             "2-[4-amino-6-(5-ethyl-4-methyl-4,5-dihydro-1h-pyrazol-1-..."
##                                                                                                                                                                                                                                                                                                    361668
##                                                                                                                                                                                                                    "N-[6-(3,5-Bis-trifluoromethyl-benzenesulfonylamino)-2-oxo-2H-chromen-3-yl]-acetamide"
##                                                                                                                                                                                                                                                                                                    701303
##                                                                                                                                                                                                                                                                                             "Rubrolide A"
##                                                                                                                                                                                                                                                                                                    706180
##                                                                                                                                                                                                             "2-[2-(benzotriazol-2-ylmethyl)-5-(trifluoromethyl)benzimidazol-1-yl]-N,N-dimethylethanamine"
##                                                                                                                                                                                                                                                                                                    603976
##                                                                                                                                                                                                                   "2-[4-(9-Fluoro-3-nitro-5,6-dihydrobenzo[b][1]benzothiepin-5-yl)piperazin-1-yl]ethanol"
##                                                                                                                                                                                                                                                                                                    671368
##                                                                                                                                                                                                                     "N-Phenyl-2-(3-phenyl-4,5-bis(phenylimino)-1,3-thiazolidin-2-ylidene)ethanethioamide"
##                                                                                                                                                                                                                                                                                                    727472
##                                                                                                                                                                                                                                            "1-[4-[(6-Methoxy-2-phenylquinolin-4-yl)amino]phenyl]ethanone"
##                                                                                                                                                                                                                                                                                                    652807
##                                                                                                                                                                                                                             "(3R,3As)-3-phenyl-3a,4-dihydrothiochromeno[4,3-c]pyrazole-2(3H)-carboxamide"
##                                                                                                                                                                                                                                                                                                    706415
##                                                                                                                                                                                                                                                "4-(Benzhydrylideneamino)-5-methyl-2h-1,2,4-triazol-3-one"
##                                                                                                                                                                                                                                                                                                    735441
##                                                                                                                                                                                                                                                      "4-[2-[2-(6-Hydroxyhex-1-ynyl)phenyl]ethynyl]phenol"
##                                                                                                                                                                                                                                                                                                    360494
##                                                                                                                                                                                                                          "1-(4-chlorophenyl)-4,9-dioxo-4,9-dihydro-1H-benzo[f]indazole-3-carboxylic acid"
##                                                                                                                                                                                                                                                                                                    668890
##                                                                                                                                                                                                                             "Methyl 2-((4-(((benzyloxy)carbonyl)amino)butanoyl)amino)-3-phenylpropanoate"
##                                                                                                                                                                                                                                                                                                    703850
##                                                                                                                                                                                                                                                                                               "STK092790"
##                                                                                                                                                                                                                                                                                                    707467
##                                                                                                                                                                                                            "(E)-but-2-enedioic acid;tert-butyl N-methyl-N-[(1S,2R)-2-pyrrolidin-1-ylcyclohexyl]carbamate"
##                                                                                                                                                                                                                                                                                                    741428
##                                                                                                                                                                                                                                             "furan-2-yl-(1-oxy-3,7-bis-trifluoromethyl-quinoxalin-2-y..."
##                                                                                                                                                                                                                                                                                                    720486
##                                                                                                                                                                                                        "N-[2-(dimethylamino)ethyl]-2-hydroxy-6,11-dioxo-5-(2-phenylethyl)benzo[b]carbazole-1-carboxamide"
##                                                                                                                                                                                                                                                                                                    706993
##                                                                                                                    "2-[[(8R,9S,10R,13S,14S,17R)-17-ethynyl-17-hydroxy-13-methyl-1,2,6,7,8,9,10,11,12,14,15,16-dodecahydrocyclopenta[a]phenanthren-3-ylidene]amino]ethyl 9-oxo-10H-acridine-4-carboxylate"
##                                                                                                                                                                                                                                                                                                    743186
##                                                                                                                                                                                                                                                                      "5,5'-difluoro-3,3'-dithiobisindole"
##                                                                                                                                                                                                                                                                                                    727740
##                                                                                                                                                                                                                                             "3-chloro-1-(2-chlorophenyl)-4-(3-hydroxyanilino)-2,5-dih..."
##                                                                                                                                                                                                                                                                                                    704881
##                                                                                                                                                                                                        "1-[4-Azido-5-(hydroxymethyl)tetrahydrofuran-2-yl]-3-(4-bromobutyl)-5-methyl-pyrimidine-2,4-dione"
##                                                                                                                                                                                                                                                                                                    664017
##                                                                                                                                                                                                                                        "1'-Acetyl-2-methylspiro[3H-pyrrole-5,4'-3H-quinoline]-2',4-dione"
##                                                                                                                                                                                                                                                                                                    743271
##                                                                                                                                                                                                                                                                                              "Z223639772"
##                                                                                                                                                                                                                                                                                                    657195
##                                                                                                                                                                                                                                                                                          "CBMicro_029986"
##                                                                                                                                                                                                                                                                                                    628946
##                                                                                                                                                                                                                             "5,6-Dimethoxy-9-(methylthio)furo[3',4':4,5]cyclopenta[1,2,3-ij]isoquinoline"
##                                                                                                                                                                                                                                                                                                    699785
##                                                                                                                                                                                                                                                      "O1-ethyl O4-[(E)-2-nitrovinyl] (E)-but-2-enedioate"
##                                                                                                                                                                                                                                                                                                    735779
##                                                                                                                                                                                                                                             "n-(4'-hydroxy-3'-methoxy-cinnamoyl)-3-o-methyl-17alpha(a..."
##                                                                                                                                                                                                                                                                                                    666532
##                                                                                                                                                                                                                                               "(3-(Cyclopropylidenemethoxy)-1-propynyl)(trimethyl)silane"
##                                                                                                                                                                                                                                                                                                    725664
##                                                                                                                                                                                                                                                "N(p-Chlorophenyl),N'{2-(4-phenylene)benzoxazole}thiourea"
##                                                                                                                                                                                                                                                                                                    694687
##                                                                                                                                                                                            "3-(2,2-Dimethoxyethyl)-1-(2-trimethylsilylethoxymethyl)-3-[(E)-2-tri(propan-2-yl)silyloxyethenyl]indol-2-one"
##                                                                                                                                                                                                                                                                                                    685457
##                                                                                                                                                                                                                                            "5-Methyl-3-(palmitoyloxy)-5-phenyl-2,4-imidazolidinedithione"
##                                                                                                                                                                                                                                                                                                    716539
##                                                                                                                                                                                                                           "5-Chloropyridin-3-yl 2-oxo-6-[(propanoyloxy)methyl]-2h-chromene-3-carboxylate"
##                                                                                                                                                                                                                                                                                                    705850
##                                                                                                                                                                                                                                                                                               "STK533980"
##                                                                                                                                                                                                                                                                                                    645570
##                                                                                                                                                                                                                                                     "Triethylgermyl 2-phenyl-2-triethylgermyloxy-acetate"
##                                                                                                                                                                                                                                                                                                    668411
##                                                                                                                                                                                                                                                             "4-Methyl-2-nitro-6-(1,3-thiazol-4-yl)phenol"
##                                                                                                                                                                                                                                                                                                    715693
##                                                                                                                                                                                                                    "6-[5-(2,4-Dichlorophenyl)furan-2-yl]-3-ethyl[1,2,4]triazolo[3,4-b][1,3,4]thiadiazole"
##                                                                                                                                                                                                                                                                                                    633404
##                                                                                                                                                                                                                                                                                               "LS-133633"
##                                                                                                                                                                                                                                                                                                    740014
##                                                                                                                                                                                                                                             "ethyl 6-chloro-3-[n-(4-methoxyphenyl)-4-chlorobenzenesul..."
##                                                                                                                                                                                                                                                                                                    378978
##                                                                                                                                                                                                                                                                                           "Sipholenone-A"
##                                                                                                                                                                                                                                                                                                    741745
##                                                                                                                                                                                                                                             "1,7-bis-(2,6,6-trimethylcyclohex-1-en-1-yl)-1(e)-heptadi..."
##                                                                                                                                                                                                                                                                                                    649587
##                                                                                                                                                                                        "2-[5-[(1,3-Dioxoinden-2-yl)methyl]-2,2-dimethyl-4,6-dioxocyclohexyl]-N-(7-hydroxynaphthalen-1-yl)-2-oxoacetamide"
##                                                                                                                                                                                                                                                                                                    626577
##                                                                                                                                                                                                                                                                                         "(-)-Roemeridine"
##                                                                                                                                                                                                                                                                                                     80396
##                                                                                                                                                                                                                                                  "1,3-butanedione, 1-benzo[b]thien-3-yl-4,4,4-trifluoro-"
##                                                                                                                                                                                                                                                                                                    672014
##                                                                                                                                                                                                                                                                                         "ChemDiv2_000249"
##                                                                                                                                                                                                                                                                                                    646151
##                                                                                                                                                                                                                                                                                    "3-trityloxy-propanol"
##                                                                                                                                                                                                                                                                                                    691567
##                                                                                                                                                                                                                            "(4Z)-4-benzylidene-7-methyl-1,1-dioxo-2,3-dihydro-1$l^{6}-benzothiepin-5-one"
##                                                                                                                                                                                                                                                                                                    135734
##                                                                                                                                                                                                                                          "Butyrophenone,4-(diphenylphosphinyl)-2-methoxy-2-phenyl- (8CI)"
##                                                                                                                                                                                                                                                                                                      5620
##                                                                                                                                                                                                                                     "2,2'-(2-Oxo-3,4-dihydro-2h-1,4-benzothiazine-3,3-diyl)diacetic acid"
##                                                                                                                                                                                                                                                                                                    672002
##                                                                                                                                                                                                                                        "N-(1-Ethoxy-2,2,2-trifluoro-1-(trifluoromethyl)ethyl)propanamide"
##                                                                                                                                                                                                                                                                                                    684789
##                                                                                                                                                                                       "5-Amino-2-(4,4,11,11-tetramethyl-3,5,7,10,12-pentaoxatricyclo[6.4.0.02,6]dodecan-6-yl)-1,3-oxazole-4-carbonitrile"
##                                                                                                                                                                                                                                                                                                    708809
##                                                                                                                                                                                                                                                 "5,11-Dimethyl-1,5,8,11-tetrazabicyclo[6.5.2]pentadecane"
##                                                                                                                                                                                                                                                                                                    742798
##                                                                                                                                                                                                                                                             "1-(1H-indazol-3-yl)-3-(4-methoxyphenyl)urea"
##                                                                                                                                                                                                                                                                                                     54393
##                                                                                                                                                                                                                                                                                             "ALBB-024126"
##                                                                                                                                                                                                                                                                                                     75747
##                                                                                                                                                                                                                                                              "5-(6-mercapto-9H-purin-9-yl)pentanoic acid"
##                                                                                                                                                                                                                                                                                                      8552
##                                                                                                                                                                                                                                                                                    "9-Chlorophenanthrene"
##                                                                                                                                                                                                                                                                                                    670869
##                                                                                                                                                                                                                     "2-[(1S)-1-benzyl-2-[2-(hydroxymethyl)pyrrol-1-yl]-2-oxo-ethyl]isoindoline-1,3-dione"
##                                                                                                                                                                                                                                                                                                    691814
##                                                                                                                                                                                  "2-[[1-[[3-Hydroxy-5-(5-methyl-2,4-dioxopyrimidin-1-yl)oxolan-2-yl]methyl]triazol-4-yl]methyl]-1,2,4-triazine-3,5-dione"
##                                                                                                                                                                                                                                                                                                     93355
##                                                                                                                                             "17-(2-Amino-1,3-thiazol-4-yl)-11-hydroxy-10,13-dimethyl-1,2,6,7,8,9,11,12,14,15,16,17-dodecahydrocyclopenta[a]phenanthren-3-one;4-bromobenzenesulfonic acid"
##                                                                                                                                                                                                                                                                                                    670864
##                                                                                                                                                                                                                                                                                                "DA-34354"
##                                                                                                                                                                                                                                                                                                    742350
##                                                                                                                                                                                                                                                                                             "Peptide PTD"
##                                                                                                                                                                                                                                                                                                    688315
##                                                                                                                                                                                                                                            "2-Methoxy-N-[(octahydro-2H-quinolizin-1-yl)methyl]-benzamide"
##                                                                                                                                                                                                                                                                                                     48874
##                                                                                                                                                                                                                                                                                          "Probes1_000359"
##                                                                                                                                                                                                                                                                                                    359701
##                                                                                                                                                                                                                                                                                       "Maybridge3_000341"
##                                                                                                                                                                                                                                                                                                    708807
##                                                                                                                                                                                                                                                               "1,4,8,11-Tetraazabicyclo[6.6.2]hexadecane"
##                                                                                                                                                                                                                                                                                                    740119
##                                                                                                                                                                                                              "N-(4,5-dimethyl-1,3-oxazol-2-yl)-4-[(1,3-dioxoisoindol-2-yl)methylamino]benzenesulfonamide"
##                                                                                                                                                                                                                                                                                                    142269
##                                                                                                                                                                                                                                                  "N-(4-Methyl-2-pyridinyl)-N'-(4-(methylthio)phenyl)urea"
##                                                                                                                                                                                                                                                                                                    657971
##                                                                                                                                                                                                                                             "4h-pyrazolo[3,4-d][1,3]thiazin-6-amine, 1-(4-chlorobenzo..."
##                                                                                                                                                                                                                                                                                                    697583
##                                                                                                                                                                                                                       "[[(Z)-(3-ethyl-4-phenyl-thiazol-2-ylidene)amino]-phosphono-methyl]phosphonic acid"
##                                                                                                                                                                                                                                                                                                    699418
##                                                                                                                                                                                                                                              "5-Ethyl-5,6-dihydroxyhexahydro-2H-cyclopenta[b]furan-2-one"
##                                                                                                                                                                                                                                                                                                    720946
##                                                                                                                                                   "[3,4,5-Trihydroxy-6-[[3,4,5-trihydroxy-6-[[3,4,5-trihydroxy-6-(hydroxymethyl)oxan-2-yl]oxymethyl]oxan-2-yl]oxymethyl]oxan-2-yl] 4,4-dimethylnonanoate"
##                                                                                                                                                                                                                                                                                                    736048
##                                                                                                                                                                                                                                             "n-[2-(4-chlorophenyl)-4-oxo-1,3-thiazolidin-3-yl]-n'-(2-..."
##                                                                                                                                                                                                                                                                                                    737736
##                                                                                                                                                                                                                                             "n'-(4-isopropyl-1,1-dioxdido-4h-1,2,4-benzothiadiazin-3-..."
##                                                                                                                                                                                                                                                                                                    719480
##                                                                                                                                                                                                                                "(3Z)-3-[(2-chlorophenyl)methylidene]-1-phenylimidazo[1,5-a]benzimidazole"
##                                                                                                                                                                                                                                                                                                    641239
##                                                                                                                                                                                             "N-[2-Chloro-5-(trifluoromethyl)phenyl]-4-naphthalen-2-yl-2,4-dioxo-3-(3-oxo-1H-2-benzofuran-1-yl)butanamide"
##                                                                                                                                                                                                                                                                                                    666531
##                                                                                                                                                                                                                                                             "Diethyl 2-cyclopropyl-2-oxoethylphosphonate"
##                                                                                                                                                                                                                                                                                                    666534
##                                                                                                                                                                                                                                                                     "3,3,6,6-Tetramethyl-2,7-octanedione"
##                                                                                                                                                                                                                                                                                                    767229
##                                                                                                                                                                                                                                                                                                        ""
##                                                                                                                                                                                                                                                                                                    696642
##                                                                                                                                                                                                                            "6',7'-dimethylspiro[3,5,6,7-tetrahydro-s-indacene-2,2'-3H-indene]-1,1'-dione"
##                                                                                                                                                                                                                                                                                                    727571
##                                                                                                                                                                                                                                      "ethyl (Z)-3-(benzylamino)-2-(3,4-dioxonaphthalen-1-yl)but-2-enoate"
##                                                                                                                                                                                                                                                                                                    631359
##                                                                                                                                                                                                                                                              "4-[2-(3,4,5-trimethoxyphenyl)ethyl]aniline"
##                                                                                                                                                                                                                                                                                                    666540
##                                                                                                                                                                                                                                                                                               "STK095497"
##                                                                                                                                                                                                                                                                                                    693050
##                                                                                                                                                                                                                                    "(4Z)-2-Phenyl-4-pyrrolidin-2-ylidene-5-(1H-pyrrol-2-yl)pyrazol-3-one"
##                                                                                                                                                                                                                                                                                                    702691
##                                                                                                                                                                                                                                                      "4-Thioureido-5,6-dichlorobenzene-1,3-disulfonamide"
##                                                                                                                                                                                                                                                                                                    691826
##                                                                                                                                                                                           "4-[5-[[3-[[3-(4-Acetyloxybutyl)triazol-4-yl]methyl]-2,4-dioxopyrimidin-1-yl]methyl]triazol-1-yl]butyl acetate"
##                                                                                                                                                                                                                                                                                                    734755
##                                                                                                                                                                                                                                             "benzoic acid 10-hydroxy-11-oxo-5,11-dihydro-benzo[4,5]im..."
##                                                                                                                                                                                                                                                                                                    732491
##                                                                                                                                                                                                                             "4-(furo[3,2-c]quinolin-4-ylamino)-N-[2-(2-hydroxyethylamino)ethyl]benzamide"
##                                                                                                                                                                                                                                                                                                    684872
##                                                                                                                                                                                                                               "Acetamide, N-[(2-methoxy-5-oxo-1-pyrrolidinyl)methyl]-N-(4-methylphenyl)-"
##                                                                                                                                                                                                                                                                                                    697250
## "(1S,4aR,8aR)-7-[2-[5-[[3-[2-[(1S,4aR,8aR)-1-methyl-3,6-dioxo-1,4,4a,5,8,8a-hexahydropyrano[3,4-c]pyridin-7-yl]ethyl]-1-(trifluoromethylsulfonyl)-2,3-dihydroindol-5-yl]methyl]-1-(trifluoromethylsulfonyl)-2,3-dihydroindol-3-yl]ethyl]-1-methyl-1,4,4a,5,8,8a-hexahydropyrano[3,4-c]pyridine-3,6-dione"
##                                                                                                                                                                                                                                                                                                    700718
##                                                                                                                                                                                                                                                                                               "LS-158852"
##                                                                                                                                                                                                                                                                                                    726198
##                                                                                                                                                                                                                                             "(3as,4s,5ar,6as,10as,10cs)-4-methoxy-7,7,10a,10c-tetrame..."
##                                                                                                                                                                                                                                                                                                    700201
##                                                                                                                                                                                                                                               "2-Butyl-5-(4-(5-butyl-2-thienyl)-1,3-butadiynyl)thiophene"
##                                                                                                                                                                                                                                                                                                    652920
##                                                                                                                                                                                                                                                 "1-(1,2-Benzothiazole-3-carbonylamino)-3-phenyl-thiourea"
##                                                                                                                                                                                                                                                                                                    678514
##                                                                                                                                                                                                                                                                                                    "fiau"
##                                                                                                                                                                                                                                                                                                    685096
##                                                                                                                                                                                                                                                                                                    "noac"
##                                                                                                                                                                                                                                                                                                    678369
##                                                                                                                                                                                                                             "methyl 2-[(E)-(5,6-dimethyl-1-oxo-indan-2-ylidene)methyl]-5-methyl-benzoate"
##                                                                                                                                                                                                                                                                                                    627638
##                                                                                                                                                                                                                                                  "Diethyl 7-oxo-1,3,5-cycloheptatriene-1,3-dicarboxylate"
##                                                                                                                                                                                                                                                                                                    696057
##                                                                                                                                                                                                                                                          "4,5-Dimethyl-3-(phenylsulfonyl)-2-thienylamine"
##                                                                                                                                                                                                                                                                                                    667078
##                                                                                                                                                                                                                      "5-Phenyl-2-((2-phenylethyl)thio)-6,7,8,9-tetrahydropyrimido[4,5-b]quinolin-4-amine"
##                                                                                                                                                                                                                                                                                                    632608
##                                                                                                                                                                                                                                             "diammine-1,7,10,16-tetraoxa-4,13-diazacyclooctadecane- p..."
##                                                                                                                                                                                                                                                                                                    691816
##                                                                                                                                                                          "6-Bromo-2-[[1-[[3-hydroxy-5-(5-methyl-2,4-dioxopyrimidin-1-yl)oxolan-2-yl]methyl]triazol-4-yl]methyl]-1,2,4-triazine-3,5-dione"
##                                                                                                                                                                                                                                                                                                    678533
##                                                                                                                                                                                                                                                                                "2'-azido-2'-deoxyuridine"
##                                                                                                                                                                                                                                                                                                    617584
##                                                                                                                                                                                                                         "2,4-dibromo-6-[(E)-[(2-hydroxybenzoyl)hydrazinylidene]methyl]phenolate;iron(2+)"
##                                                                                                                                                                                                                                                                                                    627605
##                                                                                                                                                                                                                                                             "2,3,5-Triphenyl-1,3-selenazol-3-ium-4-olate"
##                                                                                                                                                                                                                                                                                                    725021
##                                                                                                                                                                "N-(1-Amino-3-methyl-1-oxopentan-2-yl)-1-[2-(2-aminopropanoylamino)-3-methylbutanoyl]pyrrolidine-2-carboxamide;2,2,2-trifluoroacetic acid"
##                                                                                                                                                                                                                                                                                                    681083
##                                                                                                                                                                                                                                                              "1,7-Ditosyl-1,4,7,10-tetraazacyclododecane"
##                                                                                                                                                                                                                                                                                                    742856
##                                                                               "4-[[2-[[6-(2,2-Dimethyl-1,3-dioxolan-4-yl)-2,2-dimethyl-3a,4,6,6a-tetrahydrofuro[3,4-d][1,3]dioxol-4-yl]oxy]-1-(6-dodecoxy-2,2-dimethyl-3a,5,6,6a-tetrahydrofuro[2,3-d][1,3]dioxol-5-yl)ethyl]carbamoylamino]benzoic acid"
##                                                                                                                                                                                                                                                                                                    712202
##                                                                                                                                                                               "N-[4-[15-(4-acetamidophenyl)-10,20-bis(1-methylquinolin-1-ium-3-yl)-21,23-dihydroporphyrin-5-yl]phenyl]acetamide;chloride"
##                                                                                                                                                                                                                                                                                                    683908
##                                                                                                                                                                                                                                   "3-Methyl-2-thiophenecarbaldehyde (4,8-dimethyl-2-quinolinyl)hydrazone"
##                                                                                                                                                                                                                                                                                                    716147
##                                                                                                                                                                                                            "4-acetamido-N-[3-chloro-2-(4-hydroxy-3-methoxyphenyl)-4-oxoazetidin-1-yl]-2-methoxybenzamide"
##                                                                                                                                                                                                                                                                                                    211332
##                                                                                                                                                                                                                                                           "2,4-Diaminohexahydropyrimidine-5-carbonitrile"
##                                                                                                                                                                                                                                                                                                    667869
##                                                                                                                                                                                                                                         "Borinic acid, diphenyl-, 2-(dimethylamino)-1-phenylpropyl ester"
##                                                                                                                                                                                                                                                                                                    737747
##                                                                                                                                                                                                                                            "(E)-2-(1,3-benzoxazol-2-yl)-3-thiophen-3-ylprop-2-enenitrile"
##                                                                                                                                                                                                                                                                                                    662382
##                                                                                                                                                                                                                              "6-Chloro-7-{4-[2-(2-hydroxyethoxy)ethyl]piperazin-1-yl}quinoline-5,8-dione"
##                                                                                                                                                                                                                                                                                                    627508
##                                                                                                                                                                                                                                                                   "4-hydroxymethyl-2-phenyl-tellurophene"
##                                                                                                                                                                                                                                                                                                    638069
##                                                                                                                                                                                                                                                                                                 "A-64718"
##                                                                                                                                                                                                                                                                                                    654629
##                                                                                                                                                                                                                      "N-(2,6-Dichlorophenyl)-2-methyl-2-((4-oxo-2-phenyl-4H-chromen-7-yl)oxy)propanamide"
##                                                                                                                                                                                                                                                                                                    708433
##                                                                                                                                                                                                          "2-(4,6-Ditert-butyl-2,3-dihydroxy-phenyl)sulfanyl-6-(hydroxymethyl)tetrahydropyran-3,4,5-triol"
##                                                                                                                                                                                                                                                                                                    708237
##                                                                                                                                                       "1-[(4aS,6R,7S,8S,8aS)-8-hydroxy-3-methyl-7-phenylmethoxy-6-(phenylmethoxymethyl)-6,7,8,8a-tetrahydro-4aH-pyrano[2,3-b][1,4]oxathiin-2-yl]ethanone"
##                                                                                                                                                                                                                                                                                                    723428
##                                                                                                                                                                                                                                             "2-(para-methoxyphenyl)-1-[(6-bromo-2-(2-thienyl)-4- quin..."
##                                                                                                                                                                                                                                                                                                    633370
##                                                                                                                                                                                                                      "3-(5-(4-Methylphenyl)-1,3,4-oxadiazol-2-yl)-1-phenyl-1H-pyrazolo[3,4-b]quinoxaline"
##                                                                                                                                                                                                                                                                                                    668454
##                                                                                                                                                                                                                                           "(1-Tert-Butoxycarbonylamino-ethyl)-carbamic acid benzyl ester"
##                                                                                                                                                                                                                                                                                                    718901
##                                                                                                                                                       "4-[[4-[[4-[[6-[[4-[[4-[(4-Aminophenyl)methyl]phenyl]iminomethyl]phenoxy]methyl]pyridin-2-yl]methoxy]phenyl]methylideneamino]phenyl]methyl]aniline"
##                                                                                                                                                                                                                                                                                                    702114
##                                                                                                                                                                                                                          "N-benzyl-4-[[[(E)-3-(4-phenylmethoxyphenyl)prop-2-enoyl]amino]methyl]benzamide"
##                                                                                                                                                                                                                                                                                                    658417
##                                                                                                                                                                                                            "(2,4,6-trichlorophenyl) N-[2-(benzimidazol-1-yl)-2-oxoethyl]-2-(N-phenylanilino)ethanimidate"
##                                                                                                                                                                                                                                                                                                    681730
##                                                                                                                                                                                                                                             "2,2'-(1,3-phenylenebis(methylene))bis(azanediyl)bis(2-ph..."
##                                                                                                                                                                                                                                                                                                    700443
##                                                                                                                                                                                                                                             "7h-1,2,4-triazolo[3,4-b][1,3,4]thiadiazine, 3,3'-(1,8-oc..."
##                                                                                                                                                                                                                                                                                                    727456
##                                                                                                                                                                                                                 "(NZ)-N-[1-[3-[[2-(benzotriazol-1-yl)quinolin-4-yl]amino]phenyl]ethylidene]hydroxylamine"
##                                                                                                                                                                                                                                                                                                    735805
##                                                                                                                                                                                                                                           "N-(4-fluorophenyl)-2-(2-oxo-3-phenylquinoxalin-1-yl)acetamide"
##                                                                                                                                                                                                                                                                                                      3094
##                                                                                                                                                                                                                                                                                                    "pdmt"
##                                                                                                                                                                                                                                                                                                     13397
##                                                                                                                                                                                                                                                                                           "Triamcinolone"
##                                                                                                                                                                                                                                                                                                    319467
##                                                                                                                                                                                                                                                                                       "Maybridge3_004599"
##                                                                                                                                                                                                                                                                                                    696640
##                                                                                                                                                                                                                           "4',5'-dimethylspiro[1,6,7,8-tetrahydro-as-indacene-2,2'-3H-indene]-1',3-dione"
##                                                                                                                                                                                                                                                                                                    672866
##                                                                                                                                                                                                                                 "(E)-2-diethoxyphosphoryl-3-(2-phenyl-1H-imidazol-5-yl)prop-2-enenitrile"
##                                                                                                                                                                                                                                                                                                    723423
##                                                                                                                                                                                                                                             "6,7-bromo-4-[(3-methoxyphenyl)amino]-2-(2-thienyl) quina..."
##                                                                                                                                                                                                                                                                                                    378734
##                                                                                                                                                                                                                                                                           "from cephalodiscus gilchristi"
##                                                                                                                                                                                                                                                                                                    299878
##                                                                                                                                                                                                                                                   "4-(2-Bromoethylsulfanylmethyl)-7-methoxychromen-2-one"
##                                                                                                                                                                                                                                                                                                    672006
##                                                                                                                                                                                                                    "N-(2,2,2-Trifluoro-1-(3-fluoro-2-methylanilino)-1-(trifluoromethyl)ethyl)propanamide"
##                                                                                                                                                                                                                                                                                                    737345
##                                                                                                                                                                                                                                             "9-(benzyloxycarbonyloxymethyl)-6-(3-bromopropyl)-5,6-dih..."
##                                                                                                                                                                                                                                                                                                    654828
##                                                                                                                                                                                                                                                                                    "Cambridge id 5133154"
##                                                                                                                                                                                                                                                                                                    619874
##                                                                                                                                                                                                                                                                  "2,4-Dimethoxy-3-phenylmethoxybenzamide"
##                                                                                                                                                                                                                                                                                                    345081
##                                                                                                                                                                                                                                                                                          "NCIMech_000338"
##                                                                                                                                                                                                                                                                                                    669020
##                                                                                                                                                          "N-[(E)-(2-methoxyphenyl)methylideneamino]-3,4,6,12-tetrazatetracyclo[12.4.0.02,7.08,13]octadeca-1(18),2(7),3,5,8(13),9,11,14,16-nonaen-5-amine"
##                                                                                                                                                                                                                                                                                                    603977
##                                                                                                                                                                                                                                                                         "7H-Thieno[2,3-c]thiopyran-4-one"
##                                                                                                                                                                                                                                                                                                    656929
##                                                                                                                                                                       "(1R,10S,14R,17S)-7-(4-fluorophenyl)-10,14-dimethyl-6,7,9-triazapentacyclo[11.8.0.02,10.04,8.014,19]henicosa-4(8),5,19-trien-17-ol"
##                                                                                                                                                                                                                                                                                                    767327
##                                                                                                                                                                                                                                                                                                        ""
##                                                                                                                                                                                                                                                                                                    712410
##                                                                                                                                                                                      "tetramethyl (1R,5R,6R,7R,9R)-7-(3,4-dimethoxyphenyl)-3,5-dihydroxybicyclo[3.3.1]non-2-ene-2,4,6,9-tetracarboxylate"
##                                                                                                                                                                                                                                                                                                    657196
##                                                                                                                                                                                                                      "Di-tert-butyl 2,6-dimethyl-4-(4-nitrophenyl)-1,4-dihydropyridine-3,5-dicarboxylate"
##                                                                                                                                                                                                                                                                                                    657455
##                                                                                                                                                                                                                      "(3Z)-6-methyl-3-[(5-methyl-2-thioxo-3H-benzimidazol-1-yl)methylene]pyran-2,4-dione"
##                                                                                                                                                                                                                                                                                                     33001
##                                                                                                                                                                                                                                                                                         "Fluorometholone"
##                                                                                                                                                                                                                                                                                                    684869
##                                                                                                                                                                                                                                   "N-Methyl-1-[(acetylphenylamino)methyl]-5-oxopyrrolidine-2-carboxamide"
##                                                                                                                                                                                                                                                                                                    742947
##                                                                                                                                                                                                                                             "5-hydroxy-3-(7-methoxy-2-oxo-2h-chromen-3-yl)pyrano[3,2-..."
##                                                                                                                                                                                                                                                                                                    742790
##                                                                                                                                                                                                                                             "3,5-dimethyl-6-phenyl-8-(trifluoromethyl)-5,6-dihydropyr..."
##                                                                                                                                                                                                                                                                                                    744609
##                                                                                                                                                                                        "2-(4-chloro-2-methylanilino)-N-[(E)-(3-hydroxyphenyl)methylideneamino]-6-(trifluoromethyl)pyridine-3-carboxamide"
##                                                                                                                                                                                                                                                                                                    740012
##                                                                                                                                                                                                                                             "ethyl 6-chloro-3-[n-(4-fluorophenyl)-5-methoxybenzenesul..."
##                                                                                                                                                                                                                                                                                                    728506
##                                                                                                                                                                                                                                             "2-benzylthio-4-chloro-2-(4-chlorophenylcarbamoyl)-n-(5,6..."
##                                                                                                                                                                                                                                                                                                    704964
##                        "[(2S)-1-[(2S)-2-benzyl-3-methoxy-5-oxo-2H-pyrrol-1-yl]-3-methyl-1-oxobutan-2-yl] (2S)-1-[(2S)-1-[(2S)-4-methyl-2-[methyl-[(2S)-3-methyl-2-[[(2S)-3-methyl-2-(phenylmethoxycarbonylamino)butanoyl]amino]butanoyl]amino]pentanoyl]pyrrolidine-2-carbonyl]pyrrolidine-2-carboxylate"
##                                                                                                                                                                                                                                                                                                    743066
##                                                                                                                                                                                                                      "2-[[2-(Dimethylamino)ethyl-methylamino]methyl]-4-iodo-6-methylphenol;hydrochloride"
##                                                                                                                                                                                                                                                                                                    698132
##                                                                                                                                                                                                                            "Ethyl (2-(aminosulfonyl)-5-bromoimidazo[2,1-b][1,3,4]thiadiazol-6-yl)acetate"
##                                                                                                                                                                                                                                                                                                     48160
##                                                                                                                                                                                                                                                 "4-Tert-butyl-2-((cyclohexylamino)methyl)-6-methylphenol"
##                                                                                                                                                                                                                                                                                                    666535
##                                                                                                                                                                                                                                                            "Triethyl 2-phenyl-1,3,3-butanetricarboxylate"
##                                                                                                                                                                                                                                                                                                    711628
##                                                                                                                                                                                                                "(1R,5S,7R)-5-methoxy-2,2-dimethyl-4-phenyl-6-thia-4-azatricyclo[5.4.0.01,5]undecan-3-one"
##                                                                                                                                                                                                                                                                                                    696641
##                                                                                                                                                                                                                            "5',6'-dimethylspiro[3,5,6,7-tetrahydro-s-indacene-2,2'-3H-indene]-1,1'-dione"
##                                                                                                                                                                                                                                                                                                    668457
##                                                                                                                                                                                                                                                  "Prolinamide, N-[(1,1-dimethylethoxy)carbonyl]histidyl-"
##                                                                                                                                                                                                                                                                                                    704127
##                                                                                                                                                                                                                                             "1,3-dichloro-5,6-dihydro-4H-cyclopenta[c]thiophene-4,6-diol"
##                                                                                                                                                                                                                                                                                                    672000
##                                                                                                                                                                                                                                "Methyl 2,2,2-trifluoro-1-(4-toluidino)-1-(trifluoromethyl)ethylcarbamate"
##                                                                                                                                                                                                                                                                                                     48162
##                                                                                                                                                                                                                                  "1-[[(2-Hydroxynaphthalen-1-yl)methylamino]methylidene]naphthalen-2-one"
##                                                                                                                                                                                                                                                                                                    641241
##                                                                                                                                                                                                                                             "2-naphthalenebutanamide, alpha-,gamma-dioxo-beta-(3-oxo ..."
##                                                                                                                                                                                                                                                                                                    734046
##                                                                                                                                                                                                                                             "2-[4-chloro-5-(4-chlorophenylcarbamoyl)-2-mercaptobenzen..."
##                                                                                                                                                                                                                                                                                                    734039
##                                                                                                                                                                                                                                             "ethyl 2-(5-bromothien-2-ylsulfonyl)-6-chloro-1,1-dioxo-3..."
##                                                                                                                                                                                                                                                                                                    700420
##                                                                                                                                                                                                                                                "2-(5,5-Dimethyl-1,4-dihydroimidazol-2-yl)naphthalen-1-ol"
##                                                                                                                                                                                                                                                                                                    734603
##                                                                                                                                                                                                                                                                   "1,5-bis(4-methoxyphenyl)-1H-imidazole"
##                                                                                                                                                                                                                                                                                                    736283
##                                                                                                                                                                                                                                             "4-carbethoxymethyl-2-[2-[(1-pyrolidinyl)thiocarbamoylthi..."
##                                                                                                                                                                                                                                                                                                    717224
##                                                                                                                                                                                                                                                                 "Isostrychnopentamine A trihydrochloride"
##                                                                                                                                                                                                                                                                                                    704799
##                                                                                                                                                                                                       "2-(2-methylphenoxy)-N-[3-(4-methylphenyl)-4,6-dioxo-2-sulfanylidene-1,3-diazinan-1-yl]propanamide"
##                                                                                                                                                                                                                                                                                                    763931
##                                                                                                                                                                                                                                                                                             "PF-04217903"
##                                                                                                                                                                                                                                                                                                    736391
##                                                                                                                                                                                                                                             "2-[2-[(n,n-diethylamino)thiocarbamoylthio]hexanoylamino]..."
##                                                                                                                                                                                                                                                                                                    118516
##                                                                                                                                                                                                                                                                        "Copper;1,2-dicarboxyethylazanide"
##                                                                                                                                                                                                                                                                                                    614049
##                                                                                                                                                                                                                                             "1-phenazinol, 7,8-bis[(4-morpholinyl)methyl]-, 5,10- dio..."
##                                                                                                                                                                                                                                                                                                    751277
##                                                                                                                                                                                                                  "2-(3-chlorophenyl)-5-methyl-4-[(E)-(3-oxonaphthalen-2-ylidene)methyl]-1H-pyrazol-3-one"
##                                                                                                                                                                                                                                                                                                    700244
##                                                                                                                                                                                                                                                                                             "J3.529.118K"
##                                                                                                                                                                                                                                                                                                    619156
##                                                                                                                                                                                                                                                  "3-Methyl-1-phenyl-5-sulfanylpyrazol-4-yl phenyl ketone"
##                                                                                                                                                                                                                                                                                                     21588
##                                                                                                                                                                                                                                                                                                 "A805455"
##                                                                                                                                                                                                                                                                                                    734102
##                                                                                                                                                                                                                                                  "1,5-bis(4-amidinophenoxy)-3-oxapentane dihydrochloride"
##                                                                                                                                                                                                                                                                                                    622606
##                                                                                                                                                                                             "(3Z)-3-[(5Z)-5-(Benzenesulfonylimino)-4-(dimethylamino)-1,2,4-dithiazolidin-3-ylidene]-1,1-dimethylthiourea"
##                                                                                                                                                                                                                                                                                                    705638
##                                                                                                                                                                            "[(8R,9S,13S,14S,17S)-17-acridin-9-yloxy-13-methyl-6,7,8,9,11,12,14,15,16,17-decahydrocyclopenta[a]phenanthren-3-yl] benzoate"
##                                                                                                                                                                                                                                                                                                     81403
##                                                                                                                                                                                                                                             "ketone, 7-(p-fluorophenyl)-1,2,3,3a,3b,7,10,10a,10b,11,1..."
##                                                                                                                                                                                                                                                                                                    710351
##                                                                                                                                                                                                                                                                                             "Achilleol A"
##                                                                                                                                                                                                                                                                                                    732507
##                                                                                                                                                                                                                              "6-[(3-Methoxyphenyl)iminomethyl]-[1,3]benzoxazolo[3,2-b]isoquinolin-11-one"
##                                                                                                                                                                                                                                                                                                    740108
##                                                                                                                                                                                                                                                            "3,3?-thiene-2,5-diylbis(5-methoxy-1h-indole)"
##                                                                                                                                                                                                                                                                                                    764659
##                                                                                                                                                                                                                                                                                              "SCH-900776"
##                                                                                                                                                                                                                                                                                                    710373
##                                                                                                                                                                                                                                      "1-N,4-N-bis(5-methyl-4-phenyl-1,3-thiazol-2-yl)benzene-1,4-diamine"
##                                                                                                                                                                                                                                                                                                    633369
##                                                                                                                                                                                                                                "1-Phenyl-3-(5-phenyl-1,3,4-oxadiazol-2-yl)-1H-pyrazolo[3,4-b]quinoxaline"
##                                                                                                                                                                                                                                                                                                    735033
##                                                                                                                                                                                                                 "[1-[(1,3-Dimethyl-2,6-dioxopyrimidin-4-yl)amino]-3-pyrrolidin-1-ylpropan-2-yl] benzoate"
##                                                                                                                                                                                                                                                                                                    767898
##                                                                                                                                                                                                                                                                                             "ipatasertib"
##                                                                                                                                                                                                                                                                                                    686340
##                                                                                                                                                                                                                                                             "3-Pyrrolizino-5-(p-anisyl)-1,2,4-oxadiazole"
##                                                                                                                                                                                                                                                                                                    728195
##                                                                                                                                                                                                                                             "1-(2-chloro,6-fluorobenzyl)-2-(2-chloro,6-fluorophenyl)-..."
##                                                                                                                                                                                                                                                                                                    723553
##                                                                                                                                                                                 "2-[(E)-[6-(2,4-dichloro-5-methylphenyl)-2-ethylimidazo[2,1-b][1,3]thiazol-5-yl]methylideneamino]guanidine;hydrochloride"
##                                                                                                                                                                                                                                                                                                    729141
##                                                                                                                                                                                                                                            "3-[(2E)-2-hydroxyimino-2-phenylethoxy]-2-phenylchromen-4-one"
##                                                                                                                                                                                                                                                                                                    756654
##                                                                                                                                                                                                                                                                                               "ZM-336372"
##                                                                                                                                                                                                                                                                                                    758250
##                                                                                                                                                                                                                                                                                                 "SNS-314"
##                                                                                                                                                                                                                                                                                                    699735
##                                                                                                                                                                                                                                 "1-[2-[(2,5-Dimethylphenyl)methoxy]ethoxymethyl]-4-imino-pyrimidin-2-one"
##                                                                                                                                                                                                                                                                                                    689448
##                                                                                                                                                                                                                                              "6,6'-(pyridine-2,6-diyldiethyne-2,1-diyl)dipyridin-2-amine"
##                                                                                                                                                                                                                                                                                                    728502
##                                                                                                                                                                                                                                             "2-carbamoylmethylthio-4-chloro-5-methyl-n-(5,6-diphenyl-..."
##                                                                                                                                                                                                                                                                                                    712401
##                                                                                                                                                                                                                                                                                            "Sodagnitin C"
##                                                                                                                                                                                                                                                                                                    666167
##                                                                                                                                                                                                        "3-(4-bromophenyl)spiro[6,9-dihydro-4H-[1,2,4]triazino[4,3-b][1,2,4]triazine-7,9'-fluorene]-8-one"
##                                                                                                                                                                                                                                                                                                    740117
##                                                                                                                                                                                                                                                  "2-Furoyl-7-chloro-3-trifluoromethylquinoxaline-4-oxide"
##                                                                                                                                                                                                                                                                                                    684409
##                                                                                                                                                                                                                                             "18-norestr-4-en-3-one, 17-ethynyl-13-ethyl- 17.beta.-hyd..."
##                                                                                                                                                                                                                                                                                                    709953
##                                                                                                                                                                      "[(1R,2S,9S,12S,13R,16S)-7,9,13-trimethyl-5-phenyl-5,6-diazapentacyclo[10.8.0.02,9.04,8.013,18]icosa-4(8),6,18-trien-16-yl] acetate"
##                                                                                                                                                                                                                                                                                                    693144
##                                                                                                                                                                                                                                           "2,3-Dimethoxy-5,6-dihydroisoquinolino[3,2-a]isoquinolin-8-one"
##                                                                                                                                                                                                                                                                                                    734950
##                                                                                                                                                                                                                                                                                             "Cyclopamine"
##                                                                                                                                                                                                                                                                                                    773230
##                                                                                                                                                                                                                                                                                                "AZD-2461"
##                                                                                                                                                                                                                                                                                                    696051
##                                                                                                                                                                                                                                          "Acetamide, N-[5-bromo-3-[(4-chlorophenyl)sulfonyl]-2-thienyl]-"
##                                                                                                                                                                                                                                                                                                    732329
##                                                                                                                                                                                                                                             "[6-(4-bromofenil)imidazo[2,1-b]tiyazol-3-il]asetik asid ..."
##                                                                                                                                                                                                                                                                                                    319995
##                                                                                                                                                                                                                                                   "1-(4-Chloro-7-methoxy-2-quinolyl)-3-phenyl-2-thiourea"
##                                                                                                                                                                                                                                                                                                    651605
##                                                                                                                                                                                                                                                "N-(1-Adamantyl)-2-(5-bromo-1H-indol-3-yl)-2-oxoacetamide"
##                                                                                                                                                                                                                                                                                                    667460
##                                                                                                                                                                                                                                           "7-chloro-2-phenyl-3,5-dihydro-2H-1,5-benzothiazepine-4-thione"
##                                                                                                                                                                                                                                                                                                    718383
##                                                                                                                                                                                      "3-[2-Chloro-4-(4-chlorophenoxy)phenyl]-2-[[4-(2,4-dichlorophenoxy)phenoxy]methyl]-4-oxoquinazoline-6-sulfonic acid"
##                                                                                                                                                                                                                                                                                                    671965
##                                                                                                                                                                                                         "Methyl 2,2,2-trifluoro-1-(2-oxido-1,3,2-dioxaphosphinan-2-yl)-1-(trifluoromethyl)ethylcarbamate"
##                                                                                                                                                                                                                                                                                                    684391
##                                                                                                                                                                                                                           "(2Z)-5-amino-2-benzylidene-6-morpholino-8H-imidazo[1,2-a]pyrimidine-3,7-dione"
##                                                                                                                                                                                                                                                                                                    715638
##                                                                                                                                                                                                                                                                                     "Presqualene alcohol"
##                                                                                                                                                                                                                                                                                                     12181
##                                                                                                                                                                                                                                           "3-(6-hydroxy-3-oxo-3H-xanthen-9-yl)-1-phenyl-2-naphthoic acid"
##                                                                                                                                                                                                                                                                                                    711589
##                                                                                                                                                                                                                                                                             "HLKANFKOOWUNDF-UHFFFAOYSA-N"
##                                                                                                                                                                                                                                                                                                    105900
##                                                                                                                                                                                                                                                             "4-dibenzo[b,d]thien-2-yl-4-oxobutanoic acid"
##                                                                                                                                                                                                                                                                                                    668834
##                                                                                                                                                                                                                                                                  "4-[tert-butyl(dioxo)[?]yl]benzonitrile"
##                                                                                                                                                                                                                                                                                                    720442
##                                                                                                                                                                                                                                 "3-[2-(2,4-Dimethylphenyl)-2-oxoethylidene]-4H-benzo[e]1,4-thiazin-2-one"
##                                                                                                                                                                                                                                                                                                    731015
##                                                                                                                                                                                  "methyl (4S,5R,9R,12S,13R)-10-hydroxy-5,9,12-trimethyl-16-oxatetracyclo[11.3.1.01,10.04,9]heptadec-14-ene-5-carboxylate"
##                                                                                                                                                                                                                                                                                                    634605
##                                                                                                                                                                                                                                                                          "Tris(tropolonato)lanthane(III)"
##                                                                                                                                                                                                                                                                                                    691094
##                                                                                                                                                                                             "[3,4,5-Triacetyloxy-6-[3-(4-oxo-3-phenylquinazolin-2-yl)sulfanylpropanethioylamino]oxan-2-yl]methyl acetate"
##                                                                                                                                                                                                                                                                                                    653001
##                                                                                                                                                                                                                                                               "Tricyanoethoxymethyl trimethylol melamine"
##                                                                                                                                                                                                                                                                                                    633253
##                                                                                                                                                                                                                                             "4,8-ethenobenzo[1,2-c:4,5-c']dipyrrole-1,3,5,7(2h,6h)- t..."
##                                                                                                                                                                                                                                                                                                    736213
##                                                                                                                                                                                                                                             "2-(2-chloro-benzenesulfonylimino)-imidazolidine-1-carbod..."
##                                                                                                                                                                                                                                                                                                    671107
##                                                                                                                                                                                                        "S-(6-Oxo-1,3,5-triphenyl-2-thioxo-1,2,3,6-tetrahydro-4-pyrimidinyl) 4-methoxybenzenecarbothioate"
##                                                                                                                                                                                                                                                                                                    704578
##                                                                                                                                                            "tert-butyl N-[4-[(8S)-2-cyclohexyl-4,7-dioxo-3,6,17-triazatetracyclo[8.7.0.03,8.011,16]heptadeca-1(10),11,13,15-tetraen-5-yl]butyl]carbamate"
##                                                                                                                                                                                                                                                                                                    736401
##                                                                                                                                                                                                                        "N'-[2-(1,3-benzoxazol-2-ylamino)-6-methylpyrimidin-4-yl]-2-hydroxybenzohydrazide"
##                                                                                                                                                                                                                                                                                                    671402
##                                                                                                                                                                                                                         "1-Cyclohexyl-2-(cyclohexylimino)-3-phenyl-5-(phenylimino)-4-imidazolidinethione"
##                                                                                                                                                                                                                                                                                                    742380
##                                                                                                                                                                                                                                                                        "cyclo(-(R)-b2hPhe-D-Pro-Lys-Phe)"
##                                                                                                                                                                                                                                                                                                    717560
##                                                                                                                                                                                                                                                                                            "TCMDC-124122"
##                                                                                                                                                                                                                                                                                                    734286
##                                                                                                                                                                                                                                             "methyl 6,11-dihydro-2,3-dimethoxy-5,11-dioxo-6-methyl-5h..."
##                                                                                                                                                                                                                                                                                                     21545
##                                                                                                                                                                                                                                                         "methanesulfonothioic acid, s-methyl ester (9ci)"
##                                                                                                                                                                                                                                                                                                    671138
##                                                                                                                                                                                                            "6-Acetyl-4-oxo-1,3-diphenyl-2-thioxo-1,2,3,4-tetrahydrothieno[2,3-d]pyrimidin-5-yl 2-furoate"
##                                                                                                                                                                                                                                                                                                    640335
##                                                                                                                                                                                                                                             "2-propen-1-one, 1-[2-[(3,4-dichlorophenyl)amino]- 4-meth..."
##                                                                                                                                                                                                                                                                                                    743927
##                                                                                                                                                                                                                                                                                                  "GP0210"
##                                                                                                                                                                                                                                                                                                    685022
##                                                                                                                                                                                                                                            "3-(Benzylamino)-4-(2-methoxybenzoyl)cyclobut-3-ene-1,2-dione"
##                                                                                                                                                                                                                                                                                                    711889
##                                                                                                                                    "(5Z)-3-[4-benzoyl-2-[(4Z)-4-[(4-methylsulfanylphenyl)methylidene]-5-oxo-2-phenylimidazol-1-yl]phenyl]-5-[(4-methylsulfanylphenyl)methylidene]-2-phenylimidazol-4-one"
##                                                                                                                                                                                                                                                                                                    716982
##                                                                                                                                                                                                               "7-Benzyl-3,4,10,11-tetrathia-7-azatricyclo[6.3.0.02,6]undeca-1(8),2(6)-diene-5,9-dithione"
##                                                                                                                                                                                                                                                                                                    645674
##                                                                                                                                                                                                                              "3-(4-(Bis(2-cyanoethyl)amino)-2-methylphenyl)-2-(cinnamoylamino)acrylamide"
##                                                                                                                                                                                                                                                                                                    331269
##                                                                                                                                                                                                                                                 "oxirane, 2,2'-[2,3-naphthalendiylbis(oxymethylene)]bis-"
##                                                                                                                                                                                                                                                                                                    666294
##                                                                                                                                                                                                                                                                "1,7-Di(2-furyl)-1,6-heptadiene-3,5-dione"
##                                                                                                                                                                                                                                                                                                    381864
##                                                                                                                                                                                                                                                                      "piceatannol, 4,3',5'-trimethyl,1s0"
##                                                                                                                                                                                                                                                                                                    766991
##                                                                                                                                                                                                                                                                                              "GSK-690693"
##                                                                                                                                                                                                                                                                                                    683614
##                                                                                                                                                                                                                                                 "3-[Methyl-(4-nitrophenyl)azo-amino]-1-phenyl-butan-2-ol"
##                                                                                                                                                                                                                                                                                                    782121
##                                                                                                                                                                                                                                                                                               "volitinib"
##                                                                                                                                                                                                                                                                                                    682293
##                                                                                                                                                                                                                                         "N-(2-(3-(Benzyloxy)phenyl)ethyl)-3-(4-hydroxyphenyl)propanamide"
##                                                                                                                                                                                                                                                                                                    360335
##                                                                                                                                                                                                                                             "2,4-hexanedione, 3-[(3,4-dichlorophenyl)methylene]-6-(di..."
##                                                                                                                                                                                                                                                                                                    772886
##                                                                                                                                                                                                                                                                                                "Apatinib"
##                                                                                                                                                                                                                                                                                                    270718
##                                                                                                                                                                                                                                                                                          "Probes1_000079"
##                                                                                                                                                                                                                                                                                                     79606
##                                                                                                                                                                                          "3-(5,6a-dimethyl-3-oxo-7-propanoyloxy-2,4a,6,7,8,9,9a,9b-octahydro-1H-cyclopenta[f]chromen-5-yl)propanoic acid"
##                                                                                                                                                                                                                                                                                                    733301
##                                                                                                                                                                                                                       "(NZ)-N-[1-[4-[(4-imidazol-1-ylquinolin-2-yl)amino]phenyl]ethylidene]hydroxylamine"
##                                                                                                                                                                                                                                                                                                    716293
##                                                                                                                                                                                                            "N-[4-[2-[(Z)-benzylideneamino]-1,3-thiazol-4-yl]phenyl]-4-chloro-3-methoxybenzenesulfonamide"
##                                                                                                                                                                                                                                                                                                    117949
##                                                                                                                                                                                                                "4-[(4,5-Dihydroxy-8-nitro-9,10-dioxoanthracen-1-yl)amino]-N,N-dimethylbenzenesulfonamide"
##                                                                                                                                                                                                                                                                                                     82274
##                                                                                                                                                                                                                                      "Ethyl 4-[bis(2-{[(4-methylphenyl)sulfonyl]oxy}ethyl)amino]benzoate"
##                                                                                                                                                                                                                                                                                                    753187
##                                                                                                                                                                                                                                             "4-chloro-n-(4-(3-(4-chloro-3-methoxyphenyl)-4-(pyridin-4..."
##                                                                                                                                                                                                                                                                                                    601098
##                                                                                                                                                                                                                        "7,8-Dihydro-8-(4-methoxyphenyl)-6-methyl-6H-1,3-dioxolo(4,5-g)(1)benzopyran-6-ol"
##                                                                                                                                                                                                                                                                                                    723134
##                                                                                                                                                                                                                                             "8-chloro-3-(3,5-dimethylphenylamino)-7-methyl-1,2,4-tria..."
##                                                                                                                                                                                                                                                                                                    676002
##                                                                                                                                                                                                                                                                                             "Herveline O"
##                                                                                                                                                                                                                                                                                                    661153
##                                                                                                                                                                                                                                             "pyrrolo[3,4-c]carbazole-1,3(2h,6h)-dione, 6-[3-(methylam..."
##                                                                                                                                                                                                                                                                                                    717851
##                                                                                                                                                                                                                                             "7-pteridinamine, 6-methyl-n-(phenylmethyl)-2-(1-piperazi..."
##                                                                                                                                                                                                                                                                                                    707019
##                                                                                                                                                                                           "N-(5-aminooxypentyl)-N-(3-aminopropoxy)-2,2,5,7,8-pentamethyl-3,4-dihydrochromene-6-sulfonamide;hydrochloride"
##                                                                                                                                                                                                                                                                                                    746134
##                                                                                                                                                                                                          "(E,2Z)-2-[[4-(4-chlorophenyl)-1,3-thiazol-2-yl]hydrazinylidene]-4-(furan-2-yl)but-3-enoic acid"
##                                                                                                                                                                                                                                                                                                    755809
##                                                                                                                                                                                                                                                                                              "Vismodegib"
##                                                                                                                                                                                                                                                                                                    698581
##                                                                                                                                                                                                                                              "6-Chloro-1-methyl-3,4-diphenyl-1H-pyrazolo[3,4-b]quinoline"
##                                                                                                                                                                                                                                                                                                    736804
##                                                                                                                                                                                                                                        "(3Z)-1-phenyl-3-[(3,4,5-trimethoxyphenyl)methylidene]indol-2-one"
##                                                                                                                                                                                                                                                                                                    638075
##                                                                                                                                                                                                                                                       "(E)-2-cyano-3-(2,3-dihydroxyphenyl)prop-2-enamide"
##                                                                                                                                                                                                                                                                                                    647044
##                                                                                                                                                                                                                                               "acetatobis(1,3-diphenylpropane-1,3-dionato)neodymium(iii)"
##                                                                                                                                                                                                                                                                                                     23418
##                                                                                                                                                                                                                                              "3-(Benzylamino)-1-naphthalen-2-ylpropan-1-ol;hydrochloride"
##                                                                                                                                                                                                                                                                                                    708804
##                                                                                                                                                                                                                                                              "1,4,7,10-Tetraazabicyclo[5.5.2]tetradecane"
##                                                                                                                                                                                                                                                                                                    697884
##                                                                                                                                                                                                                         "3,5-Bis(4-imino-4,5-dihydro-1,2,5-oxadiazol-3-yl)-1,2,4lambda~5~-oxadiazol-4-ol"
##                                                                                                                                                                                                                                                                                                    717535
##                                                                                                                                                                                                                                                                                         "ChemDiv1_017832"
##                                                                                                                                                                                                                                                                                                    302584
##                                                                                                                                                                                                                                                                "Pyrimidine, 2-((2,4-dinitrophenyl)thio)-"
##                                                                                                                                                                                                                                                                                                    693852
##                                                                                                                                                                                                                                                                    "11-chloro-10H-indolo[3,2-b]quinoline"
##                                                                                                                                                                                                                                                                                                    143147
##                                                                                                                                                                                                                                             "urea, 1,1'-(methylenedi-4,1-cyclohexylene)bis[3-(2-chlor..."
##                                                                                                                                                                                                                                                                                                    727759
##                                                                                                                                                                                                                                             "1-benzyl-3-chloro-4-(3-chloroanilino)-2,5-dihydro-1h-2,5..."
##                                                                                                                                                                                                                                                                                                    699801
##                                                                                                                                                                                                                "(3z)-3-{[3,5-Bis(trifluoromethyl)phenyl]imino}-1,7,7-trimethylbicyclo[2.2.1]heptan-2-one"
##                                                                                                                                                                                                                                                                                                     37627
##                                                                                                                                                                                                                                                                              "1,5-diphenoxyanthraquinone"
##                                                                                                                                                                                                                                                                                                    608068
##                                                                                                                                                                                                                                                                                          "CBMicro_024229"
##                                                                                                                                                                                                                                                                                                    709982
##                                                                                                                                                                                                       "[1-[[5-(4-Chlorophenyl)-1,3,4-oxadiazol-2-yl]amino]-1-oxopropan-2-yl] morpholine-4-carbodithioate"
##                                                                                                                                                                                                                                                                                                    645328
##                                                                                                                                                                                                                                         "7-Methoxy-2,5-diphenylpyrrolo[3,4-a]carbazole-1,3(2H,10H)-dione"
##                                                                                                                                                                                                                                                                                                    709993
##                                                                                                                                                                                                                                         "5-Benzylsulfanyl-1-phenyl-6-thia-4-azaspiro[2.4]hept-4-en-7-one"
##                                                                                                                                                                                                                                                                                                    716268
##                                                                                                                                                                                                                        "2-methyl-5-nitro-N-[4-[(E)-3-thiophen-2-ylprop-2-enoyl]phenyl]benzenesulfonamide"
##                                                                                                                                                                                                                                                                                                    374551
##                                                                                                                                                                                                                                                                                             "Fenretinide"
##                                                                                                                                                                                                                                                                                                    672176
##                                                                                                                                                                                                                                              "1h-purin-6-amine, n-(3-methyl-2-butenyl)-9-(2-cyanoethyl)-"
##                                                                                                                                                                                                                                                                                                    642276
##                                                                                                                                                                  "[(5S,8aR,9R)-9-(4-hydroxy-3,5-dimethoxyphenyl)-8-oxo-5a,6,8a,9-tetrahydro-5H-[2]benzofuro[5,6-f][1,3]benzodioxol-5-yl] 3-aminobenzoate"
##                                                                                                                                                                                                                                                                                                    687773
##                                                                                                                                                                                                      "3-(((4-Chlorophenyl)sulfonyl)amino)-N-(2-methoxyphenyl)-4-oxo-3,4-dihydro-6-quinazolinesulfonamide"
##                                                                                                                                                                                                                                                                                                    760419
##                                                                                                                                                                                                                                                                                             "Fenretinide"
##                                                                                                                                                                                                                                                                                                    735780
##                                                                                                                                                                                                                                             "3-(e)-ethoxycarbonylethenyl-4-(thien-2'-yl)-1,2-dihydron..."
##                                                                                                                                                                                                                                                                                                    682761
##                                                                                                                                                                                                                                             "spiro[4h-1-benzazepine-4,1'-cyclohexane]-2,5(1h,3h)-dion..."
##                                                                                                                                                                                                                                                                                                    725067
##                                                                                                                                                                                                                                             "s-methyl s'-(3-oxo-3-phenyl-prop-1-en-1-yl) cyan-imidodi..."
##                                                                                                                                                                                                                                                                                                    737732
##                                                                                                                                                                                                                                                    "Dimethyl 1-(Diphenylmethylamino)piperonylphosphonate"
##                                                                                                                                                                                                                                                                                                    666377
##                                                                                                                                                                                                                              "6-{[2-(3,5-Dibromo-4-hydroxyphenyl)ethyl]amino}-1H-benzimidazole-4,7-dione"
##                                                                                                                                                                                                                                                                                                    210739
##                                                                                                                                                                                                                                                               "(2,5-Dioxo-imidazolidin-4-ylmethoxy)-urea"
##                                                                                                                                                                                                                                                                                                    720183
##                                                                                                                                                                                                                                                  "Benzo[c][2,7]naphthyridin-4-yl(thiophen-2-yl)methanone"
##                                                                                                                                                                                                                                                                                                    703785
##                                                                                                                                                                                                                                                           "6-Benzothiazolol, 2-(4-amino-3-methylphenyl)-"
##                                                                                                                                                                                                                                                                                                    764039
##                                                                                                                                                                                                                                                                                                "AZD-5363"
##                                                                                                                                                                                                                                                                                                    748382
##                                                                                                                                                                                                                      "5-Amino-1-[1-(4-chlorophenyl)-4-hydroxypyrazole-3-carbonyl]pyrazole-4-carbonitrile"
##                                                                                                                                                                                                                                                                                                    623637
##                                                                                                                                                                                                                                             "benzoic acid, [(6-methyl-2-oxo-2h-benzopyran- 4-yl)metho..."
##                                                                                                                                                                                                                                                                                                      2186
##                                                                                                                                                                                                                                                                                          "thymophthalein"
##                                                                                                                                                                                                                                                                                                    724968
##                                                                                                                                                                                      "1-Methyl-24-oxahexacyclo[18.3.1.02,19.04,17.05,14.08,13]tetracosa-4(17),5(14),6,8,10,12,15-heptaene-3,18,21-trione"
##                                                                                                                                                                                                                                                                                                    737076
##                                                                                                                                                                                       "(1R,2R,3R,5S,6R,8R,12S)-1,5-dimethyl-11-methylidene-8-propan-2-yl-15-oxatricyclo[10.2.1.02,6]pentadecane-3,5-diol"
##                                                                                                                                                                                                                                                                                                     35450
##                                                                                                                                                                                                                                             "1-[2-(biphenyl-4-yl)-2-oxoethyl]-3,5,7-triaza-1-azoniatr..."
##                                                                                                                                                                                                                                                                                                    720204
##                                                                                                                                                                                                                "N-(2-hydroxy-3-phenoxypropyl)-4-methyl-N-(2,3,4,5,6-pentafluorophenyl)benzenesulfonamide"
##                                                                                                                                                                                                                                                                                                    697222
##                                                                                                                                                                                                                                   "2-[Benzhydryl-[2-(1-cyclohexenyl)ethyl]amino]-3-phenyl-propanenitrile"
##                                                                                                                                                                                                                                                                                                    713053
##                                                                                                                                                                                        "(Z)-2-[4-amino-6-(3,5,5-trimethyl-4H-pyrazol-1-yl)-1,3,5-triazin-2-yl]-3-(5-nitrothiophen-3-yl)prop-2-enenitrile"
##                                                                                                                                                                                                                                                                                                    737225
##                                                                                                                                                                                                 "(E)-1-[4-[[4,6-bis(4-fluoroanilino)-1,3,5-triazin-2-yl]amino]phenyl]-3-(2-methoxyphenyl)prop-2-en-1-one"
##                                                                                                                                                                                                                                                                                                    706449
##                                                                                                                                                                                                                                       "1-Amino-2-(1-benzofuran-2-ylsulfonyl)-3-(4-chlorophenyl)guanidine"
##                                                                                                                                                                                                                                                                                                    710917
##                                                                                                                                                                                                                                   "N,N'-bis[(Z)-[(E)-3-(5-nitrofuran-2-yl)prop-2-enylidene]amino]oxamide"
##                                                                                                                                                                                                                                                                                                    290555
##                                                                                                                                                                                                                                             "benzoic acid, 3,3'-methylenebis(6-hydroxy-, compd. with ..."
##                                                                                                                                                                                                                                                                                                    741088
##                                                                                                                                                                                                                                             "6-(o-propyl-3?-piperidino)-7-(p-methoxycinnamoyl)-3-meth..."
##                                                                                                                                                                                                                                                                                                    727955
##                                                                                                                                                                                                                                                  "[3-(4-Chloro-phenyl)-3-oxo-propenylamino]-acetonitrile"
##                                                                                                                                                                                                                                                                                                    735006
##                                                                                                                                                                                                                                                                           "5, 7, 4' trimethoxy flavanone"
##                                                                                                                                                                                                                                                                                                    698954
##                                                                                                                                                                                                                                           "N~2~,N~4~-Di(1-adamantyl)-6-chloro-1,3,5-triazine-2,4-diamine"
##                                                                                                                                                                                                                                                                                                    668569
##                                                                                                                                                                                            "1-[1-(2,5-Dihydro-1H-pyrrole-2-carbonyl)-2,5-dihydropyrrole-2-carbonyl]-2,5-dihydropyrrole-2-carboxylic acid"
##                                                                                                                                                                                                                                                                                                    713705
##                                                                                                                                                                                                                    "(5Z)-3-(1,3-benzothiazol-2-yl)-5-[(2-nitrophenyl)methylidene]-2-phenylimidazol-4-one"
##                                                                                                                                                                                                                                                                                                    710439
##                                                                                                                                                                                    "2-[[4,5-bis(4-methoxyphenyl)-1H-imidazol-2-yl]sulfanyl]-N-[(E)-(4-hydroxy-3-methoxyphenyl)methylideneamino]acetamide"
##                                                                                                                                                                                                                                                                                                    670823
##                                                                                                                                                                                                                                          "1H-Pyrazole, 4-chloro-1-(5-chloro-2-nitrophenyl)-3,5-dimethyl-"
##                                                                                                                                                                                                                                                                                                    715744
##                                                                                                                                                                                                             "3-benzyl-6-iodo-2-[(2-sulfanylidene-3H-1,3,4-oxadiazol-5-yl)methylsulfanyl]quinazolin-4-one"
##                                                                                                                                                                                                                                                                                                    699882
##                                                                                                                                                                                              "11,13-Dioxa-4,8-diazatetracyclo[7.6.1.05,16.010,14]hexadeca-1(15),2,5(16),6,8,10(14)-hexaene;hydrochloride"
##                                                                                                                                                                                                                                                                                                    726431
##                                                                                                                                                                                                                                                                                                  "Pyrane"
##                                                                                                                                                                                                                                                                                                    710746
##                                                                                                                                                                                                                                                          "1-Hydroxy-2-methoxyanthracene-4-propanoic acid"
##                                                                                                                                                                                                                                                                                                    717557
##                                                                                                                                                                                                                                                                                               "STK231324"
##                                                                                                                                                                                                                                                                                                    711727
##                                                                                                                                                                                                                          "7-(trifluoromethyl)-N-(3,4,5-trimethoxyphenyl)pyrrolo[1,2-a]quinoxalin-4-amine"
##                                                                                                                                                                                                                                                                                                    711852
##                                                                                                                                                                                                    "(5Z)-3-(4,6-dichloro-1,3-benzothiazol-2-yl)-2-phenyl-5-[(2-sulfanylphenyl)methylidene]imidazol-4-one"
##                                                                                                                                                                                                                                                                                                    670328
##                                                                                                                                                                                                          "Ethyl 2-(2,3-dihydro-1H-inden-5-ylmethyl)-1-oxo-1,2,3,5,6,7-hexahydro-s-indacene-2-carboxylate"
##                                                                                                                                                                                                                                                                                                    704795
##                                                                                                                                                                                                       "2-(2-chlorophenoxy)-N-[3-(4-chlorophenyl)-4,6-dioxo-2-sulfanylidene-1,3-diazinan-1-yl]propanamide"
##                                                                                                                                                                                                                                                                                                    731388
##                                                                                                                                                                                                                                             "2-benzylthio-4-chloro-5-cyano-n-(5,6-diphenyl-1,2,4-tria..."
##                                                                                                                                                                                                                                                                                                    723118
##                                                                                                                                                                                                                                                      "6-Benzylthio-4-morpholinopyrazolo[3,4-d]pyrimidine"
##                                                                                                                                                                                                                                                                                                     19781
##                                                                                                                                                                                                                                                                       "Phenol, 4,4'-(1,6-hexanediyl)bis-"
##                                                                                                                                                                                                                                                                                                    740844
##                                                                                                                                                                                                       "4,6a-Dihydroxy-7-(4-methoxyphenyl)-8-methyl-1,3-dioxo-2-phenylpyrrolo[3,4-d]indole-9-carbonitrile"
##                                                                                                                                                                                                                                                                                                    740617
##                                                                                                                                                                                                                                                                                   "imidazole-5-one deri."
##                                                                                                                                                                                                                                                                                                    699777
##                                                                                                                                                                                                                                                 "5-(methoxymethyl)-6-[(E)-2-nitrovinyl]-1,3-benzodioxole"
##                                                                                                                                                                                                                                                                                                    111118
##                                                                                                                                                                                                                                                                   "Bis(4-chlorophenyl) carbonotrithioate"
##                                                                                                                                                                                                                                                                                                    672234
##                                                                                                                                                                                                                                                                                        "10-bromopaullone"
##                                                                                                                                                                                                                                                                                                    712411
##                                                                                                                                                                                            "tetramethyl (1R,5R,6S,7R,9S)-3-benzoyloxy-5-hydroxy-7-phenylbicyclo[3.3.1]non-2-ene-2,4,6,9-tetracarboxylate"
##                                                                                                                                                                                                                                                                                                    737453
##                                                                                                                                                                                                                                             "1-(2-deoxy-.beta.-d-ribofuranosyl)-5-carbomethoxy-2-pyri..."
##                                                                                                                                                                                                                                                                                                    793726
##                                                                                                                                                                                                                                                                                              "CCT-245737"
##                                                                                                                                                                                                                                                                                                    807626
##                                                                                                                                                                                                                                                                                             "JNJ-3887618"
##                                                                                                                                                                                                                                                                                                    720413
##                                                                                                                                                                                                                         "6-Ethoxy-2-(3-oxo-5-phenyl-2,3-dihydrofuran-2-yl)-2h-1,4-benzothiazin-3(4h)-one"
##                                                                                                                                                                                                                                                                                                    682365
##                                                                                                                                                                                                                                                      "Methyl 4-[3-(2-thienyl)quinoxalin-2-yl]oxybenzoate"
##                                                                                                                                                                                                                                                                                                    659192
##                                                                                                                                                                                                                                                                                               "LS-158387"
##                                                                                                                                                                                                                                                                                                    706978
##                                                                                                                                                                                                                         "4-[[1-(4-Methoxyphenyl)-[1,3]thiazolo[3,2-a]benzimidazol-2-yl]methyl]morpholine"
##                                                                                                                                                                                                                                                                                                    762153
##                                                                                                                                                                                                                                                                                                 "ST-3595"
##                                                                                                                                                                                                                                                                                                    617846
##                                                                                                                                                                                                           "4,13-Dimethyl-7,10-diazoniatricyclo[8.4.0.02,7]tetradeca-1(10),2(7),3,5,11,13-hexaene;bromide"
##                                                                                                                                                                                                                                                                                                    767222
##                                                                                                                                                                                                                                                                                                        ""
##                                                                                                                                                                                                                                                                                                    710402
##                                                                                                                                                                                                                                                    "2-(2-Pyridylsulfanyl)-6-(trifluoromethyl)quinoxaline"
##                                                                                                                                                                                                                                                                                                    709958
##                                                                                                                                                                                                      "tert-butyl N-[5-[6-[(2-methylpropan-2-yl)oxycarbonylamino]hexan-2-ylcarbamoylamino]hexyl]carbamate"
##                                                                                                                                                                                                                                                                                                    703018
##                                                                                                                                                                                                                                                                                    "3-allylthiohydantoin"
##                                                                                                                                                                                                                                                                                                    736065
##                                                                                                                                                                                                                                             "2-(4-trifluoromethoxy-benzenesulfonylimino)-imidazolidin..."
##                                                                                                                                                                                                                                                                                                    744166
##                                                                                                                                                                                                                              "N-[2-[(Z)-6-(2-methylsulfanylphenyl)hex-3-en-1,5-diynyl]phenyl]propanamide"
##                                                                                                                                                                                                                                                                                                    707060
##                                                                                                                                                                                                                                                                                               "STK761344"
##                                                                                                                                                                                                                                                                                                    109248
##                                                                                                                                                                                                                                           "1-(3-((Dicyclohexylamino)methyl)-2,4-dihydroxyphenyl)ethanone"
##                                                                                                                                                                                                                                                                                                    733795
##                                                                                                                                                                                                                                             "3-o-methyl-16-formyl-17-(2'-furyl)estra-1,3,5(10),16-tet..."
##                                                                                                                                                                                                                                                                                                    708447
##                                                     "[2-[[[5-(4-Amino-2-oxopyrimidin-1-yl)-3,4-dihydroxyoxolan-2-yl]methoxy-hydroxyphosphoryl]oxymethyl]-5-(5-fluoro-2,4-dioxopyrimidin-1-yl)oxolan-3-yl] [3,4-dihydroxy-5-[4-(octadecylamino)-2-oxopyrimidin-1-yl]oxolan-2-yl]methyl hydrogen phosphate"
##                                                                                                                                                                                                                                                                                                    671139
##                                                                                                                                                                                                              "(6-Acetyl-4-oxo-1,3-diphenyl-2-thioxo-thieno[2,3-d]pyrimidin-5-yl) thiophene-2-carboxylate"
##                                                                                                                                                                                                                                                                                                    683784
##                                                                                                                            "[(E)-[(8R,9S,13S,14S,17R)-13-ethyl-17-ethynyl-17-hydroxy-1,2,6,7,8,9,10,11,12,14,15,16-dodecahydrocyclopenta[a]phenanthren-3-ylidene]amino] 9-oxo-10H-acridine-4-carboxylate"
##                                                                                                                                                                                                                                                                                                      7233
##                                                                                                                              "9,24-Dibromononacyclo[18.10.2.22,5.03,16.04,13.06,11.017,31.022,27.028,32]tetratriaconta-1(31),2,4,6(11),7,9,13,15,17,19,22(27),23,25,28(32),29,33-hexadecaene-12,21-dione"
##                                                                                                                                                                                                                                                                                                    699167
##                                                                                                                                                                                                                                 "3,4-Diacetoxycinnamic acid 2-[(3,4-diacetoxycinnamoyl)amino]ethyl ester"
##                                                                                                                                                                                                                                                                                                    732859
##                                                                                                                                                                                                                                             "2-chloro-1-(benzenesulfonyl)piperidine-4-carboxilic acid..."
##                                                                                                                                                                                                                                                                                                    667934
##                                                                                                                                                                                                                   "2-(6-Anilino-7-methyl-7,8-dihydro-6H-[1,3]dioxolo[4,5-g]chromen-8-yl)-6-methoxyphenol"
##                                                                                                                                                                                                                                                                                                    699449
##                                                                                                                                                                                                                                           "4-[4-(2-Dimethylaminoethyloxy)phenyl]-3-phenoxy-chromen-2-one"
##                                                                                                                                                                                                                                                                                                    711880
##                                                                                                                            "(5Z)-5-[[4-(dimethylamino)phenyl]methylidene]-3-[7-[(4Z)-4-[[4-(dimethylamino)phenyl]methylidene]-5-oxo-2-phenylimidazol-1-yl]-10H-phenothiazin-3-yl]-2-phenylimidazol-4-one"
##                                                                                                                                                                                                                                                                                                    674093
##                                                                                                                                                                                                                        "2-phenyl-N-[8-[(2-phenylquinoline-4-carbonyl)amino]octyl]quinoline-4-carboxamide"
##                                                                                                                                                                                                                                                                                                    767228
##                                                                                                                                                                                                                                                                                                        ""
##                                                                                                                                                                                                                                                                                                    109509
##                                                                                                                                                                                    "17-[1-[2-(Dimethylamino)ethylamino]ethyl]-13-methyl-6,7,8,9,11,12,14,15,16,17-decahydrocyclopenta[a]phenanthren-3-ol"
##                                                                                                                                                                                                                                                                                                    755985
##                                                                                                                                                                                                                                                                                              "Nelarabine"
##                                                                                                                                                                                                                                                                                                    720935
##                                                                                                                                                                                                                                                 "2-[4-(Methoxy)phenoxy]-3-phenyl-5,7-diamminoquinoxaline"
##                                                                                                                                                                                                                                                                                                    755400
##                                                                                                                                                                                                                                                                                               "Masitinib"
##                                                                                                                                                                                                                                                                                                    663979
##                                                                                                                                                                                                                                                                                                "LS-87642"
##                                                                                                                                                                                                                                                                                                    746311
##                                                                                                                                                                                                                              "4-[N-(5-chloro-2,4-dinitroanilino)-C-(4-hydroxyphenyl)carbonimidoyl]phenol"
##                                                                                                                                                                                                                                                                                                    742096
##                                                                                                                                                                                                                                                                                     "hydroxy pyrazolines"
##                                                                                                                                                                                                                                                                                                    720065
##                                                                                                                                                                                                                                                                                              "Vedelianin"
##                                                                                                                                                                                                                                                                                                    665764
##                                                                                                                                                                                                                                                                                                "LS-97508"
##                                                                                                                                                                                                                                                                                                    718157
##                                                                                                                                                                                                                                   "4-[(Z)-hydroxyiminomethyl]-2-[(E)-hydroxyiminomethyl]-6-methoxyphenol"
##                                                                                                                                                                                                                                                                                                    698453
##                                                                                                                                                                                      "N-[(Z)-1-(4-Methylphenyl)ethylideneamino]-2-[2-[[(E)-1-(4-methylphenyl)ethylideneamino]carbamoyl]anilino]benzamide"
##                                                                                                                                                                                                                                                                                                    105550
##                                                                                                                                                                                                                                            "4-Nitro-2-(1H-1,2,4-triazol-5-yl)-1H-isoindole-1,3(2H)-dione"
##                                                                                                                                                                                                                                                                                                    671134
##                                                                                                                                                                                                             "6-Acetyl-4-oxo-1,3-diphenyl-2-thioxo-1,2,3,4-tetrahydrothieno[2,3-d]pyrimidin-5-yl benzoate"
##                                                                                                                                                                                                                                                                                                    792847
##                                                                                                                                                                                                                                                                                             "INCB-047775"
##                                                                                                                                                                                                                                                                                                    757148
##                                                                                                                                                                                                                                                                                                "AZD-7762"
##                                                                                                                                                                                                                                                                                                    693767
##                                                                                                                                                                                                                    "Diethyl 2-((4-((3-chloro-2-phenyl-6-quinoxalinyl)methoxy)benzoyl)amino)pentanedioate"
##                                                                                                                                                                                                                                                                                                    652048
##                                                                                                                                                                                                                                   "2-[(Z)-1-(1H-benzimidazol-2-yl)-2-(4-chlorophenyl)vinyl]thiazol-4-one"
##                                                                                                                                                                                                                                                                                                     95678
##                                                                                                                                                                                                                                                                                                    "3-HP"
##                                                                                                                                                                                                                                                                                                    655035
##                                                                                                                                                                                                                                      "N-[4-[(5-acetamido-1,3,4-thiadiazol-2-yl)sulfonyl]phenyl]acetamide"
##                                                                                                                                                                                                                                                                                                        NA
##                                                                                                                                                                                                                                                                                                        NA
##                                                                                                                                                                                                                                                                                                    676790
##                                                                                                                                                                                                                                             "olean-12-en-28-oic acid, 3-.beta.-(6-methyl-.beta.-d-glu..."
##                                                                                                                                                                                                                                                                                                    676794
##                                                                                                                                                                                                                                             "olean-12-en-28-oic acid, 3-.beta.-(6-methyl-.beta.-d-glu..."
##                                                                                                                                                                                                                                                                                                    682435
##                                                                                                                                                                                                                                          "(4Z)-2-methyl-4-pyridin-2-yliminobenzo[f][1,3]benzoxazol-9-one"
##                                                                                                                                                                                                                                                                                                    781761
##                                                                                                                                                                                                                                                                                              "LY-3009120"
##                                                                                                                                                                                                                                                                                                    671421
##                                                                                                                                                                                                                                                                                         "AN-689/41741358"
```

## 4.2 Correlating DNA Copy Number Alteration and Gene Expression

We can assess the extent to which a gene’s expression may be regulated by copy gain or loss
by computing the correlation between its NCI-60 transcript expression and DNA copy number
alteration pattern. The overall distribution of such correlations can guide consideration of
their significance. In this setting, it is insightful to consider the extent to which particular
classes of genes may be regulated by copy alteration. This example illustrates the computation and visualization of the gene copy number vs. expression correlation distribution, while situating
the median correlation for a set of oncogenes within the observed distribution.

```
molData <- getMolDataMatrices()

# Get Data
copGenes <- removeMolDataType(rownames(molData[["cop"]]))
expGenes <- removeMolDataType(rownames(molData[["exp"]]))
genes <- intersect(copGenes, expGenes)

# Generate the appropriate rownames
expGeneLabels <- paste0("exp", genes)
copGeneLabels <- paste0("cop", genes)

a <- molData[["exp"]][expGeneLabels,]
b <- molData[["cop"]][copGeneLabels,]
allGenes <- rowCors(a, b)

#selectedOncogenes <- c("FZD1", "JAK2", "ALK", "PIK3CG", "RET", "CDC25A", "PDGFB", "PIK3CB", "WNT3")
selectedOncogenes <- c("ABL1", "ALK", "BRAF", "CCND1", "CCND3", "CCNE1", "CCNE2",
                                             "CDC25A", "EGFR", "ERBB2", "EZH2", "FOS", "FOXL2", "HRAS",
                                             "IDH1", "IDH2", "JAK2", "KIT", "KRAS", "MET", "MOS", "MYC",
                                             "NRAS", "PDGFB", "PDGFRA", "PIK3CA", "PIK3CB", "PIK3CD",
                                             "PIK3CG", "PIM1", "PML", "RAF1", "REL", "RET", "SRC", "STK11",
                                             "TP63", "WNT10B", "WNT4", "WNT2B", "WNT9A", "WNT3", "WNT5A",
                                             "WNT5B", "WNT10A", "WNT11", "WNT2", "WNT1", "WNT7B", "WISP1",
                                             "WNT8B", "WNT7A", "WNT16", "WISP2", "WISP3", "FZD5", "FZD1")
selectedOncogenes <- intersect(selectedOncogenes, genes)

# Generate the appropriate rownames
expGeneLabels <- paste0("exp", selectedOncogenes)
copGeneLabels <- paste0("cop", selectedOncogenes)

a <- molData[["exp"]][expGeneLabels,]
b <- molData[["cop"]][copGeneLabels,]
selectedOncogenesCor <- rowCors(a, b)

hist(allGenes$cor, main="", xlab="Pearson correlation between expression and copy number", breaks=200, col="lightgray", border="lightgray")

segments(x0=median(allGenes$cor), y0=0, x1=median(allGenes$cor), y1=175, lty=2, lwd=2)
text(median(allGenes$cor)+0.02, y=175, adj=0, labels="Median Correlation\nAll Genes", cex=0.75)

segments(x0=median(selectedOncogenesCor$cor), y0=0, x1=median(selectedOncogenesCor$cor), y1=140, lty=2, lwd=2, col="red")
text(median(selectedOncogenesCor$cor)+0.02, y=140, adj=0, labels="Median Correlation\nOncogenes", cex=0.75)

rug(selectedOncogenesCor$cor, col="red")
```

![](data:image/png;base64...)

## 4.3 Assessing Correlative Evidence for a Drug MOA Hypothesis

**rcellminer** makes it easy to consider whether the available pharmacogenomic data support
a hypothesis relating to drug mechanism of action. For example, higher expression of anti-apoptotic
genes could plausibly promote cell survival in the face of DNA damage induced by topoisomerase
inhibitors, thereby contributing to drug resistance. To explore this further, we can check
if the expression of known anti-apoptotic genes is significantly negatively correlated with
the activity of the topoisomerase 1 inhibitor camptothecin.

```
# Get normalized (Z-score) NCI-60 gene expression and drug activity data.
nci60DrugActZ <- exprs(getAct(rcellminerData::drugData))
nci60GeneExpZ <- getAllFeatureData(rcellminerData::molData)[["exp"]]

antiApoptosisGenes <- c("BAG1", "BAG3", "BAG4", "BCL10", "BCL2",
                                                "BCL2A1", "BCL2L1", "BCL2L10", "BCL2L2",
                                                "BFAR", "BIRC3", "BIRC6", "BNIP1", "BNIP2",
                                                "BNIP3", "BNIP3L", "BRAF", "CASP3", "CD27",
                                                "CD40LG", "CFLAR", "CIDEA", "DAPK1", "DFFA",
                                                "FAS", "IGF1R", "MCL1", "NOL3", "TMBIM1",
                                                "TP53", "TP73", "XIAP")
camptothecinNsc <- "94600"

# Compute table of correlations between camptothecin activity and anti-apoptosis gene expression.
pcResults <- patternComparison(nci60DrugActZ[camptothecinNsc, ], nci60GeneExpZ[antiApoptosisGenes, ])

# Adjust p-values for multiple comparisons, sort with respect to q-values.
pcResults$QVAL <- p.adjust(pcResults$PVAL, method = "fdr")
pcResults <- pcResults[order(pcResults$QVAL), ]

# Identify genes with significant negative correlations (FDR < 0.1)
pcResults[((pcResults$COR < 0) & (pcResults$QVAL < 0.10)), ]
```

```
##              COR        PVAL       QVAL
## BCL2L2 -0.392356 0.001931274 0.06180075
```

Two genes, the BAX-antagonists TMBIM1 and BCL2L2, have NCI-60 expression patterns that are
significantly negatively correlated with camptothecin activity. Plots illustrating these
relationships are constructed below.

```
colorTab <- loadNciColorSet(returnDf = TRUE)
tissueColorTab <- unique(colorTab[, c("tissues", "colors")])

plotData <- as.data.frame(t(rbind(nci60DrugActZ[camptothecinNsc, , drop=FALSE],
                                                                    nci60GeneExpZ[c("TMBIM1", "BCL2L2"), ])))
colnames(plotData) <- c("Camptothecin", "TMBIM1", "BCL2L2")

plot(x=plotData$TMBIM1, y=plotData$Camptothecin, col=colorTab$colors, pch=16,
         xlab="TMBIM1 mRNA exp (Z-score)", ylab="Camptothecin Activity (Z-score)",
         main=paste0("Camptothecin Activity vs. TMBIM Expression (r = ",
                                round(pcResults["TMBIM1", "COR"], 2), ")"))
abline(lm(formula("Camptothecin ~ TMBIM1"), plotData), col="red")
legend("bottomleft", legend=tissueColorTab$tissues, col=tissueColorTab$colors,
             cex=0.7, pch = 16)
```

![](data:image/png;base64...)

```
plot(x=plotData$BCL2L2, y=plotData$Camptothecin, col=colorTab$colors, pch=16,
         xlab="BCL2L2 mRNA exp (Z-score)", ylab="Camptothecin Activity (Z-score)",
         main=paste0("Camptothecin Activity vs. BCL2L2 Expression (r = ",
                                round(pcResults["BCL2L2", "COR"], 2), ")"))
abline(lm(formula("Camptothecin ~ BCL2L2"), plotData), col="red")
legend("bottomleft", legend=tissueColorTab$tissues, col=tissueColorTab$colors,
             cex=0.7, pch = 16)
```

![](data:image/png;base64...)

## 4.4 Relating Gene Alteration Patterns to Drug Responses

Alterations of selected DNA repair genes may have predictive value for anticancer
drug activity. Using **rcellminer**, we can flexibly script analyses to explore
such gene-drug associations. The analyses below follow elements of the approach
presented in Sousa et al., though the detailed results may differ somewhat due
to simplifications made for illustrative purposes. Our aim is to catalogue
impaired DNA repair gene function in the NCI-60, due either to deleterious mutation
or lack of expression. These alteration patterns can then be related to drug response
behavior by considering differences in drug activity between altered and non-altered
cell lines.

We start by obtaining NCI-60 drug activity data (-logGI50) for 158 FDA-approved drugs,
together with corresponding gene expression data (log2 intensity), and binary muation data
(where a value of one indicates the presence of a deleterious mution, in either
the heterozygous or homozygous state).

```
# Get Cellminer data
# getFeatureAnnot() returns a named list of data frames with annotation data
# for drugs ("drug") and drug activity repeat experiments ("drugRepeat").
drugAnnot <- getFeatureAnnot(rcellminerData::drugData)[["drug"]]
fdaDrugAnnot <- drugAnnot[which(drugAnnot$FDA_STATUS == "FDA approved"), ]

nci60FdaDrugAct <- getDrugActivityData(nscSet = fdaDrugAnnot$NSC)
nci60GeneExp <- getAllFeatureData(rcellminerData::molData)[["xai"]]
nci60GeneMut <- getAllFeatureData(rcellminerData::molData)[["mut"]]
```

We then visualize the NCI-60 mutation patterns for a subset of DNA repair
genes.

```
dnarGeneSet <- c("APC", "APLF", "ATM", "CLSPN", "ERCC6", "FANCI",
                 "FANCM", "GEN1", "HLTF", "MLH1", "POLD1", "POLE", "POLG",
                 "POLQ", "RAD54L", "REV3L", "RMI1", "SLX4", "SMARCA4", "SMC2",
                 "TP53", "WRN")
dnarGeneSet <- intersect(dnarGeneSet, rownames(nci60GeneMut))

dnarGeneMut <- nci60GeneMut[dnarGeneSet, ]

# Identify most frequently mutated genes.
numMutLines <- apply(dnarGeneMut, MARGIN = 1, FUN = sum)
sort(numMutLines, decreasing = TRUE)
```

```
##    TP53   FANCM SMARCA4     APC    MLH1    RMI1     WRN    POLQ   ERCC6   REV3L
##    2454     672     531     449     416     368     355     350     292     268
##     ATM    POLE    SLX4    APLF   FANCI    HLTF   POLD1    POLG    SMC2    GEN1
##     262     209     189     181     174     144     127     120     107      71
##  RAD54L   CLSPN
##      65      38
```

```
dnarGeneMutPlotData <- dnarGeneMut[order(numMutLines), ]
heatmap(dnarGeneMutPlotData, scale="none", Rowv = NA, Colv = NA, col = c("grey", "red"),
                main="Deleterious mutations")
```

![](data:image/png;base64...)

A similar plot can be developed to indicate DNA repair genes with little or no
expression in particular NCI-60 cell lines.

```
dnarGeneExp <- nci60GeneExp[dnarGeneSet, ]

hist(dnarGeneExp, xlab="mRNA expression (log2 intensity)",
         main="Distribution of DNA repair gene expression values")
```

![](data:image/png;base64...)

```
# Set low expression threshold to 1st percentile of expression values.
lowExpThreshold <- quantile(dnarGeneExp, na.rm = TRUE, probs = c(0.01))
lowExpThreshold
```

```
##      1%
## 4.36597
```

```
# Construct binary (potential) expression knockout matrix.
dnarGeneExpKo <- matrix(0, nrow=nrow(dnarGeneExp), ncol=ncol(dnarGeneExp))
rownames(dnarGeneExpKo) <- rownames(dnarGeneExp)
colnames(dnarGeneExpKo) <- colnames(dnarGeneExp)
dnarGeneExpKo[which(dnarGeneExp < lowExpThreshold)] <- 1

# Restrict to wild type expression knockouts.
dnarGeneExpKo[which(dnarGeneMut == 1)] <- 0

# Identify genes with most frequent loss of expression.
numExpKoLines <- apply(dnarGeneExpKo, MARGIN = 1, FUN = sum)
sort(numExpKoLines, decreasing = TRUE)
```

```
##    APLF    HLTF    MLH1     APC     ATM   CLSPN   ERCC6   FANCI   FANCM    GEN1
##       8       3       2       0       0       0       0       0       0       0
##   POLD1    POLE    POLG    POLQ  RAD54L   REV3L    RMI1    SLX4 SMARCA4    SMC2
##       0       0       0       0       0       0       0       0       0       0
##    TP53     WRN
##       0       0
```

```
dnarGeneExpKoPlotData <- dnarGeneExpKo[order(numExpKoLines), ]
heatmap(dnarGeneExpKoPlotData, scale="none", Rowv = NA, Colv = NA,
                col = c("grey", "blue"), main="Potential expression knockouts")
```

![](data:image/png;base64...)

Finally, we merge the data from the above plots to show DNA repair gene alterations
by mutation or lack of expression.

```
dnarGeneAlt <- matrix(0, nrow=nrow(dnarGeneExp), ncol=ncol(dnarGeneExp))
rownames(dnarGeneAlt) <- rownames(dnarGeneExp)
colnames(dnarGeneAlt) <- colnames(dnarGeneExp)
dnarGeneAlt[which(dnarGeneMut == 1)] <- 1
dnarGeneAlt[which(dnarGeneExpKo == 1)] <- 2

# Identify genes with most frequent alterations (by mutation or lack of expression).
numAltLines <- apply(dnarGeneAlt, MARGIN = 1, FUN = sum)
sort(numAltLines, decreasing = TRUE)
```

```
##    APLF    HLTF    MLH1     APC     ATM   CLSPN   ERCC6   FANCI   FANCM    GEN1
##      16       6       4       0       0       0       0       0       0       0
##   POLD1    POLE    POLG    POLQ  RAD54L   REV3L    RMI1    SLX4 SMARCA4    SMC2
##       0       0       0       0       0       0       0       0       0       0
##    TP53     WRN
##       0       0
```

```
dnarGeneAltPlotData <- dnarGeneAlt[order(numAltLines), ]
heatmap(dnarGeneAltPlotData, scale="none", Rowv = NA, Colv = NA,
                col = c("grey", "red", "blue"),
                main="Altered genes by mutation (red) or low expression (blue)")
```

![](data:image/png;base64...)

For any altered gene, we can identify drugs with significantly different
activity between altered and non-altered cell lines.

```
geneName <- "APLF"
altLineIndices <- which(dnarGeneAlt[geneName, ] != 0)
nonAltLineIndices <- which(dnarGeneAlt[geneName, ] == 0)

drugAssocTab <- data.frame(GENE=geneName, DRUG_NAME=fdaDrugAnnot$NAME,
                                                     DRUG_NSC=fdaDrugAnnot$NSC, TTEST_PVAL=NA,
                                                     ADJ_PVAL=NA, MEAN_ACT_DIFF=NA,
                                                     stringsAsFactors = FALSE)
rownames(drugAssocTab) <- as.character(drugAssocTab$DRUG_NSC)
for (drugNsc in as.character(drugAssocTab$DRUG_NSC)){
    ttestResult <- t.test(x=nci60FdaDrugAct[drugNsc, altLineIndices],
                                                y=nci60FdaDrugAct[drugNsc, nonAltLineIndices])
    drugAssocTab[drugNsc, "TTEST_PVAL"] <- ttestResult$p.value
    drugAssocTab[drugNsc, "MEAN_ACT_DIFF"] <-
        ttestResult$estimate[1] - ttestResult$estimate[2]
}

drugAssocTab$ADJ_PVAL <- p.adjust(drugAssocTab$TTEST_PVAL, method = "bonferroni")
drugAssocTab <- drugAssocTab[order(drugAssocTab$ADJ_PVAL), ]

drugAssocTab[drugAssocTab$ADJ_PVAL < 0.05,
                         c("GENE", "DRUG_NAME", "DRUG_NSC", "ADJ_PVAL", "MEAN_ACT_DIFF")]
```

```
##        GENE   DRUG_NAME DRUG_NSC   ADJ_PVAL MEAN_ACT_DIFF
## 757838 APLF Mebendazole   757838 0.01060401     0.3239990
## 628503 APLF   Docetaxel   628503 0.03267957     0.5948321
```

```
meanActDiff <- drugAssocTab$MEAN_ACT_DIFF
negLog10Pval <- -log10(drugAssocTab$TTEST_PVAL)
plot(x=meanActDiff, y=negLog10Pval, xlim = c((min(meanActDiff)-1), (max(meanActDiff)+1)),
         xlab="Difference between -logGI50 means (altered vs. non-altered lines)",
         ylab="-log10(p-value)", main=(paste0(geneName, " Drug Response Associations")))

ptLabels <- character(length(drugAssocTab$DRUG_NAME))
numLabeledPts <- 7 # label the k most significant drug associations
ptLabels[1:numLabeledPts] <- drugAssocTab$DRUG_NAME[1:numLabeledPts]
text(x=meanActDiff, negLog10Pval, ptLabels, cex=0.9, pos=4, col="red")
```

![](data:image/png;base64...)

# 5 Session Information

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] rcellminer_2.32.0     rcellminerData_2.31.0 Biobase_2.70.0
## [4] BiocGenerics_0.56.0   generics_0.1.4        knitr_1.50
## [7] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6        jsonlite_2.0.0      dplyr_1.1.4
##  [4] compiler_4.5.1      BiocManager_1.30.26 gtools_3.9.5
##  [7] Rcpp_1.1.0          tinytex_0.57        tidyselect_1.2.1
## [10] stringr_1.5.2       magick_2.9.0        bitops_1.0-9
## [13] dichromat_2.0-0.1   jquerylib_0.1.4     scales_1.4.0
## [16] yaml_2.3.10         fastmap_1.2.0       ggplot2_4.0.0
## [19] R6_2.6.1            tibble_3.3.0        bookdown_0.45
## [22] bslib_0.9.0         pillar_1.11.1       RColorBrewer_1.1-3
## [25] rlang_1.1.6         stringi_1.8.7       cachem_1.1.0
## [28] xfun_0.53           caTools_1.18.3      sass_0.4.10
## [31] S7_0.2.0            cli_3.6.5           magrittr_2.0.4
## [34] digest_0.6.37       grid_4.5.1          lifecycle_1.0.4
## [37] vctrs_0.6.5         KernSmooth_2.23-26  evaluate_1.0.5
## [40] glue_1.8.0          farver_2.1.2        rmarkdown_2.30
## [43] tools_4.5.1         pkgconfig_2.0.3     htmltools_0.5.8.1
## [46] gplots_3.2.0
```

# 6 References

# Appendix

* Reinhold, W.C., et al. (2012) CellMiner: a web-based suite of genomic and pharmacologic tools to explore transcript and drug patterns in the NCI-60 cell line set. Cancer Research, 72, 3499-3511.
* Sousa, F.G., et al. (2015) Alterations of DNA repair genes in the NCi-60 cell lines and their predictive value for anticancer drug activity. DNA Repair 28 (2015) 107-115.
* Varma, S., et al. (2014) High Resolution Copy Number Variation Data in the NCI-60 Cancer Cell Lines from Whole Genome Microarrays Accessible through CellMiner. PLoS ONE 9(3): e92047.