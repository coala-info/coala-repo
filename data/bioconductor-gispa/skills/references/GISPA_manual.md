# GISPA: A Method for Gene Integrated Set Profile Analysis

###Bhakti Dwivedi and Jeanne Kowalski
Winship Cancer Institute, Emory University, Atlanta, 30322, USA

###Introduction
Gene Integrated Set Profile Analysis (GISPA) is a method designed to define gene sets with similar, a priori defined molecular profile (Kowalski et al., 2016). GISPA can perform a single- two-, or three-feature analysis. Here feature is defined as a specific data type (e.g., expression (EXP), methylation (MET), variant (VAR), or copy number variation (CNV)) and profile as the direction of genomic change of either increase (up) or decrease (down) within a feature. GISPA method is developed to address genome-wide comparisons of three sample classes (or groups) based on as few as a single sample per group, in terms of profile changes from multiple genomic data types; comparisons can also be done based on a single data type. Using this R package, user combine and compare several genome-wide data types from three sample classes to find the gene sets with genomic profile specific to a sample class. GISPA workflow consists of the following steps: (A) Define your samples: User specifies a reference sample (sample of interest) and the remaining two other comparison samples. (B) Select the number of data types: User can perform either a single, two or three-feature analysis. (C) Select the direction of change by data type: User inputs the data and profile of interest by data type for the analysis type selected. (D) Diagnostic plots showing gene sets that support the profile of interest in the reference sample: (E) Highest Ranked Gene Sets visuals in terms of differences among sample classes and data types for multiple-feature analysis.

###Prerequisities 1) Download and install R or RStudio (version 3.2.2. or later) from <https://cran.r-project.organd> 2) Open R and install the below required packages:

```
install.packages( c("changepoint", "data.table", "genefilter", "graphics", "HH", "knitr", "latticeExtra", "lattice", "plyr", "scatterplot3d", "stats", "Biobase", "GSEABase") )
```

###Example Dataset The package incorporates three preprocessed and normalized example datasets: RNA-seq derived gene expression, Exome-seq derived variant change, and DNA copy number change data from three multiple myeloma cell lines. The datasets are provided as a ExpressionSet object called GISPAdata in the GISPA package.

The example datasets can be loaded as follows:

```
library("GISPA")
load("data.rda")
exprset
```

```
## ExpressionSet (storageMode: lockedEnvironment)
## assayData: 1500 features, 3 samples
##   element names: exprs
## protocolData: none
## phenoData
##   sampleNames: sample1 sample2 sample3
##   varLabels: group
##   varMetadata: labelDescription
## featureData
##   featureNames: CDKN2C KIAA0125 ... LRCH1 (1500 total)
##   fvarLabels: gene
##   fvarMetadata: labelDescription
## experimentData: use 'experimentData(object)'
## Annotation:
```

```
varset
```

```
## ExpressionSet (storageMode: lockedEnvironment)
## assayData: 1101 features, 3 samples
##   element names: exprs
## protocolData: none
## phenoData
##   sampleNames: sample1 sample2 sample3
##   varLabels: group
##   varMetadata: labelDescription
## featureData
##   featureNames: chr1;10044379;10044379;A;G
##     chr1;100489996;100489996;A;G ... chr9;98224149;98224149;C;T
##     (1101 total)
##   fvarLabels: gene
##   fvarMetadata: labelDescription
## experimentData: use 'experimentData(object)'
## Annotation:
```

```
cnvset
```

```
## ExpressionSet (storageMode: lockedEnvironment)
## assayData: 534 features, 3 samples
##   element names: exprs
## protocolData: none
## phenoData
##   sampleNames: sample1 sample2 sample3
##   varLabels: group
##   varMetadata: labelDescription
## featureData
##   featureNames: 4:164613808:164622810 1:87122399:88231174 ...
##     19:11780793:11785401 (534 total)
##   fvarLabels: gene
##   fvarMetadata: labelDescription
## experimentData: use 'experimentData(object)'
## Annotation:
```

Input data set consists of rows representing genes (or other forms of gene ids) and columns representing samples. Please see example ExpressionSet for each data type (e.g., exprset, varset, cnvset) provided with the package.

###Input Data Requirements 1) Maximum file size limit of up to 500 MB. 2) GISPA under two- or threee-feature analysis requires overlap between multiple data types by gene names. 3) A minimum of at least 10 genes and three sample classes are required. 4) No duplicated sample (column) names or duplicated gene (row) names are allowed and analysis will be stopped. 5) Gene with zero variance across all samples will be excluded from the analysis.

###GISPA Analysis User selects the analysis type (single-feature, two-feature or three-feature), provides the data file, defines the reference sample (sample of interest), selects the profile of interest, and data type for each feature to define the gene sets. The input data can be genome-wide or based on prior knowledge derived from either biological processes, pathways, biomarkers discovery, or genomic analysis. User can select a profile either increase (“up”) or decrease (“down”) within each specific feature or data type. Some example data types to select include expression (“EXP”), somatic mutation or variant (“VAR”), copy number change (“CNV)”), and methylation (“MET”) but it can be any combination of numeric data type. User defines sample classes (or groups) by specifying the sample column index in the input data file corresponding to ‘Reference’ (sample of interest) and two other relative samples to compare against the reference sample. The column index of reference and two other relative samples should be consistent among the data files across multiple data types.

GISPA generates the following outputs: (1) Data table of gene set profiles by identified change points. (2) Scatter plot representing genes sorted from the smallest (least desirable) to largest (most desirable) profile scores grouped by change points according to those that satisfy the profile the most (change point 1; above horizontal orange dotted line), next most (change point 2 or greater; above grey dotted lines) and so forth. User can specify/modify change point detection method (Killick R, et al., 2016) to find the optimal break points within the estimated profile sample score (Kowalski, et al., 2016). The changes can be found in mean and/or variance using the change point method (“AMOC”, “BinSeg”, “PELT”, or “SeqNeigh”) given the allotted maximum number of change points. (3) Slope plot in the selection of the change points that represent the best gene set profile. Within each gene, changes in a data type, for example, expression and variant are summarized for the reference versus the two other samples by the calculation of a slope. The slopes are then summarized over all gene sets within a change point by taking their average. The slope average by change points for a data type is plotted such that a dot represent the level of support across the ranked gene sets for each change point, where topmost “best” profile (change point 1) is indicated with orange-filled dot color. (4) Stacked bar plots using HH R package (Heiberger 2016) of the ranked gene sets profiles to depict their distribution based on observed input data in the reference relative to other two samples to access the sample and data type driving the profile. This enables users to visualize the level-wise breakdown of each data type, whether or not output gene set satisfy the profile of interest, and if not, is there a particular feature that appears to be prominent for a particular gene. The stacked bar plots highlight the between-feature differences, i.e., the percent contribution from each input data type to the gene profile displayed, and between-sample differences, i.e., the percent contribution from each sample to the summed total of each feature. The stacked barplots are only generated for two- and three- feature analysis.

Here we illustrate GISPA with an example of two-feature analysis using genome-wide expression and copy number change data set on the three multiple myeloma cell lines to obtain gene sets with increased expression and increased copy number (expressed genes with copy gain) profile specific to KMS-11 cell line.

```
results <- GISPA(feature=2, f.sets=c(exprset,cnvset), g.set=NULL,
ref.samp.idx=1, comp.samp.idx=c(2,3),
f.profiles=c("up", "up"),
cpt.data="var", cpt.method="BinSeg", cpt.max=5)
```

![](data:image/png;base64...)

The function also generates scatter plot of ranked gene sets by change points within the data sorted from the smallest (least desirable) to largest (most desirable) between gene profile statistics

Changepoint scatter plot representing average slope computed over each change point for each data type for the reference sample relative to the other two comparison samples can be obtained as below:

```
cptSlopeplot(gispa.output=results,feature=2,type=c("EXP","VAR"))
```

![](data:image/png;base64...)

```
## NULL
```

Stacked barplot representing between-sample differences for the gene sets in the selected change point using expression and variant change data values. Sample group of interest (reference) is shown in red, while the two relative samples are shown in blue and green, respectively.

```
stackedBarplot(gispa.output=results,feature=2,cpt=1,type=c("EXP","CNV"),
input.cex=1.5,input.cex.lab=1.5,input.gap=0.5,
samp.col=c("red", "green", "blue"),
strip.col=c("yellow", "bisque"))
```

![](data:image/png;base64...)

Stacked barplot representing between-feature differences for the gene sets in the selected change point. The percent contributions can be used to identify the driving feature(s) among the gene set, e.g., the displayed gene set is driven majorly by copy change (light grey) than expression (dark grey).

```
propBarplot(gispa.output=results,feature=2,cpt=1,input.cex=0.5,input.cex.lab=0.5,ft.col=c("grey0", "grey60"),strip.col="yellow")
```

![](data:image/png;base64...)

Likewise, user can run GISPA using a single-feature such as expression data to define gene sets with increased expression profile and three-feature analysis to define gene sets with increased expression, variant, and copy change profile in KMS-11

```
results <- GISPA(feature=1, f.sets=c(exprset), g.set=NULL,
ref.samp.idx=1, comp.samp.idx=c(2,3),
f.profiles=c("up"),
cpt.data="var", cpt.method="BinSeg", cpt.max=5)
```

![](data:image/png;base64...)

```
head(results)
```

```
##          sample1 sample2 sample3          ps1        BGFPS -log10(BGFPS)
## CDKN2C        NA      NA      NA 0.0006666667 0.0006666667      3.176091
## KIAA0125      NA      NA      NA 0.0013333333 0.0013333333      2.875061
## TSPYL5        NA      NA      NA 0.0020000000 0.0020000000      2.698970
## EN2           NA      NA      NA 0.0026666667 0.0026666667      2.574031
## RERG          NA      NA      NA 0.0033333333 0.0033333333      2.477121
## TBX18         NA      NA      NA 0.0040000000 0.0040000000      2.397940
##          succ.diff. changepoints
## CDKN2C   0.30103000            1
## KIAA0125 0.17609126            1
## TSPYL5   0.12493874            1
## EN2      0.09691001            1
## RERG     0.07918125            1
## TBX18    0.06694679            1
```

```
results <- GISPA(feature=3, f.sets=c(exprset,cnvset,varset), g.set=NULL,
ref.samp.idx=1, comp.samp.idx=c(2,3),
f.profiles=c("down", "down", "down"),
cpt.data="var", cpt.method="BinSeg", cpt.max=5)
head(results)
```

###Funding This work is funded by the Leukemia and Lymphoma Society Translational Research Program Award (to Jeanne Kowalski); Georgia Research Alliance Scientist Award (Jeanne Kowalski); a Team Science Seed Funding from the Winship Cancer Institute of Emory University (Lawrence H. Boise, Sagar Lonial, Michael R. Rossi); Biostatistics and Bioinformatics Shared Resource of Winship Cancer Institute of Emory University and NIH/NCI [Award number P30CA138292, in part]. The content is solely the responsibility of the authors and does not necessarily represent the official views of the NIH.

###Citation Please cite the GISPA method as: Kowalski J, Dwivedi B, Newman S, Switchenko JM, Pauly R, Gutman DA, Arora J, Gandhi K, Ainslie K, Doho G, Qin Z, Moreno CS, Rossi MR, Vertino PM, Lonial S, Bernal-Mizrachi L, Boise LH. Gene integrated set profile analysis: a context-based approach for inferring biological endpoints. Nucleic Acids Res. 2016 Apr 20;44(7):e69. doi: 10.1093/nar/gkv1503. Epub 2016 Jan 29. PubMed PMID: 26826710; PubMed Central PMCID: PMC4838358.

###References 1. Kowalski J, Dwivedi B, Newman S, Switchenko JM, Pauly R, Gutman DA, Arora J, Gandhi K, Ainslie K, Doho G, Qin Z, Moreno CS, Rossi MR, Vertino PM, Lonial S, Bernal-Mizrachi L, Boise LH. (2016). Gene Integrated Set Profile Analysis: A Context-Based Approach for Inferring Biological Endpoints. Nucleic Acids Research doi:10.1093/nar/gkv1503. 2. Killick R, Haynes K and IA, E. changepoint: An R package for changepoint analysis. R package version 2.2.1 2016. 3. Heiberger, R.M. HH: Statistical Analysis and Data Display: Heiberger and Holland. R package version 3.1-32 2016.