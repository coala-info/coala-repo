# DEqMS R Markdown vignettes

Yafeng Zhu1, Lukas Orre1, Yan Tran1, Georgios Mermelekas1, Henrik Johansson1, Alina Malyutina2, Simon Anders3 and Janne Lehtiö1

1Karolinska Institute, Stockholm, Sweden
2University of Helsinki, Helsinki, Finland
3Heidelberg University (ZMBH), Heidelberg, Germany

#### 2025-10-29

#### Abstract

Instructions to perform differential protein expression analysis using DEqMS

#### Package

DEqMS 1.28.0

# Contents

* [1 Overview of DEqMS](#overview-of-deqms)
* [2 Quick start](#quick-start)
  + [2.1 Differential protein expression analysis with DEqMS using a protein table](#differential-protein-expression-analysis-with-deqms-using-a-protein-table)
    - [2.1.1 Download and Read the input protein table](#download-and-read-the-input-protein-table)
    - [2.1.2 Extract quant data columns for DEqMS](#extract-quant-data-columns-for-deqms)
    - [2.1.3 Make design table.](#make-design-table.)
    - [2.1.4 Make contrasts](#make-contrasts)
    - [2.1.5 DEqMS analysis](#deqms-analysis)
    - [2.1.6 Visualize the fit curve - variance dependence on quantified PSM](#visualize-the-fit-curve---variance-dependence-on-quantified-psm)
    - [2.1.7 Extract the results as a data frame and save it](#extract-the-results-as-a-data-frame-and-save-it)
    - [2.1.8 Make volcanoplot](#make-volcanoplot)
  + [2.2 DEqMS analysis using MaxQuant outputs (label-free data)](#deqms-analysis-using-maxquant-outputs-label-free-data)
    - [2.2.1 Read protein table as input and filter it](#read-protein-table-as-input-and-filter-it)
    - [2.2.2 Make a data frame of unique peptide count per protein](#make-a-data-frame-of-unique-peptide-count-per-protein)
    - [2.2.3 DEqMS analysis on LFQ data](#deqms-analysis-on-lfq-data)
    - [2.2.4 Visualize the fit curve](#visualize-the-fit-curve)
    - [2.2.5 Extract outputs from DEqMS](#extract-outputs-from-deqms)
  + [2.3 DEqMS analysis using a PSM table (isobaric labelled data)](#deqms-analysis-using-a-psm-table-isobaric-labelled-data)
    - [2.3.1 Read PSM table input](#read-psm-table-input)
    - [2.3.2 Summarization and Normalization](#summarization-and-normalization)
    - [2.3.3 DEqMS analysis](#deqms-analysis-1)
    - [2.3.4 PSM/Peptide profile plot](#psmpeptide-profile-plot)
* [3 Comparing DEqMS to other methods](#comparing-deqms-to-other-methods)
  + [3.1 Compare the variance estimate in DEqMS and Limma](#compare-the-variance-estimate-in-deqms-and-limma)
    - [3.1.1 Prior variance comparison between DEqMS and Limma](#prior-variance-comparison-between-deqms-and-limma)
    - [3.1.2 Residual plot for DEqMS and Limma](#residual-plot-for-deqms-and-limma)
    - [3.1.3 Posterior variance comparison between DEqMS and Limma](#posterior-variance-comparison-between-deqms-and-limma)
  + [3.2 Compare p-values from DEqMS to ordinary t-test, ANOVA and Limma](#compare-p-values-from-deqms-to-ordinary-t-test-anova-and-limma)
    - [3.2.1 T-test analysis](#t-test-analysis)
    - [3.2.2 Anova analysis](#anova-analysis)
    - [3.2.3 Limma](#limma)
    - [3.2.4 Visualize the distribution of p-values by different analysis](#visualize-the-distribution-of-p-values-by-different-analysis)

# 1 Overview of DEqMS

`DEqMS` builds on top of `Limma`, a widely-used R package for microarray data
analysis (Smyth G. et al 2004), and improves it with proteomics data specific
properties, accounting for variance dependence on the number of quantified
peptides or PSMs for statistical testing of differential protein expression.

Limma assumes a common prior variance for all proteinss, the function
`spectraCounteBayes` in DEqMS package estimate prior variance
for proteins quantified by different number of PSMs.

A documentation of all R functions available in DEqMS is detailed in the PDF
reference manual on the DEqMS Bioconductor page.

#Load the package

```
library(DEqMS)
```

```
## Loading required package: ggplot2
```

```
## Loading required package: matrixStats
```

```
## Loading required package: dplyr
```

```
##
## Attaching package: 'dplyr'
```

```
## The following object is masked from 'package:matrixStats':
##
##     count
```

```
## The following objects are masked from 'package:stats':
##
##     filter, lag
```

```
## The following objects are masked from 'package:base':
##
##     intersect, setdiff, setequal, union
```

```
## Loading required package: limma
```

# 2 Quick start

## 2.1 Differential protein expression analysis with DEqMS using a protein table

As an example, we analyzed a protemoics dataset (TMT10plex labelled) in which
A431 cells (human epidermoid carcinoma cell line) were treated with three
different miRNA mimics (Zhou Y. Et al Oncogene 2017). The raw MS data was
searched with MS-GF+ (Kim et al Nat Communications 2016) and post processed
with Percolator (Kall L. et al Nat Method 2007). A tabular text output of
protein table filtered at 1% protein level FDR is used.

### 2.1.1 Download and Read the input protein table

```
options(timeout = 1000)
url <- "https://ftp.ebi.ac.uk/pride-archive/2016/06/PXD004163/Yan_miR_Protein_table.flatprottable.txt"
download.file(url, destfile = "./miR_Proteintable.txt",method = "auto")

df.prot = read.table("miR_Proteintable.txt",stringsAsFactors = FALSE,
                     header = TRUE, quote = "", comment.char = "",sep = "\t")
```

### 2.1.2 Extract quant data columns for DEqMS

```
# filter at 1% protein FDR and extract TMT quantifications
TMT_columns = seq(15,33,2)
dat = df.prot[df.prot$miR.FASP_q.value<0.01,TMT_columns]
rownames(dat) = df.prot[df.prot$miR.FASP_q.value<0.01,]$Protein.accession
# The protein dataframe is a typical protein expression matrix structure
# Samples are in columns, proteins are in rows
# use unique protein IDs for rownames
# to view the whole data frame, use the command View(dat)
```

If the protein table is relative abundance (ratios) or intensity values,
Log2 transform the data. Systematic effects and variance components are
usually assumed to be additive on log scale (Oberg AL. et al JPR 2008;
Hill EG. et al JPR 2008).

```
dat.log = log2(dat)
#remove rows with NAs
dat.log = na.omit(dat.log)
```

Use boxplot to check if the samples have medians centered.
if not, do median centering.

```
boxplot(dat.log,las=2,main="TMT10plex data PXD004163")
```

![](data:image/png;base64...)

```
# Here the data is already median centered, we skip the following step.
# dat.log = equalMedianNormalization(dat.log)
```

### 2.1.3 Make design table.

A design table is used to tell how samples are arranged in
different groups/classes.

```
# if there is only one factor, such as treatment. You can define a vector with
# the treatment group in the same order as samples in the protein table.
cond = as.factor(c("ctrl","miR191","miR372","miR519","ctrl",
"miR372","miR519","ctrl","miR191","miR372"))

# The function model.matrix is used to generate the design matrix
design = model.matrix(~0+cond) # 0 means no intercept for the linear model
colnames(design) = gsub("cond","",colnames(design))
```

### 2.1.4 Make contrasts

In addition to the design, you need to define the contrast, which tells the
model to compare the differences between specific groups.
Start with the Limma part.

```
# you can define one or multiple contrasts here
x <- c("miR372-ctrl","miR519-ctrl","miR191-ctrl",
       "miR372-miR519","miR372-miR191","miR519-miR191")
contrast =  makeContrasts(contrasts=x,levels=design)
fit1 <- lmFit(dat.log, design)
fit2 <- contrasts.fit(fit1,contrasts = contrast)
fit3 <- eBayes(fit2)
```

### 2.1.5 DEqMS analysis

The above shows Limma part, now we use the function `spectraCounteBayes`
in DEqMS to correct bias of variance estimate based on minimum number of
psms per protein used for quantification.We use the minimum number of PSMs
used for quantification within and across experiments to model the relation
between variance and PSM count.(See original paper)

```
# assign a extra variable `count` to fit3 object, telling how many PSMs are
# quantifed for each protein
library(matrixStats)
count_columns = seq(16,34,2)
psm.count.table = data.frame(count = rowMins(
  as.matrix(df.prot[,count_columns])), row.names =  df.prot$Protein.accession)
fit3$count = psm.count.table[rownames(fit3$coefficients),"count"]
fit4 = spectraCounteBayes(fit3)
```

Outputs of `spectraCounteBayes`:

### 2.1.6 Visualize the fit curve - variance dependence on quantified PSM

```
# n=30 limits the boxplot to show only proteins quantified by <= 30 PSMs.
VarianceBoxplot(fit4,n=30,main="TMT10plex dataset PXD004163",xlab="PSM count")
```

![](data:image/png;base64...)

```
VarianceScatterplot(fit4,main="TMT10plex dataset PXD004163")
```

![](data:image/png;base64...)

### 2.1.7 Extract the results as a data frame and save it

```
DEqMS.results = outputResult(fit4,coef_col = 1)
#if you are not sure which coef_col refers to the specific contrast,type
head(fit4$coefficients)
```

```
##        Contrasts
##         miR372-ctrl miR519-ctrl miR191-ctrl miR372-miR519 miR372-miR191
##   A2M   -0.49200598 -0.36004725 -0.29168559   -0.13195872 -0.2003203925
##   AAAS  -0.10579819 -0.16658093 -0.12904503    0.06078273  0.0232468358
##   AACS  -0.06426210 -0.01691172 -0.06517334   -0.04735038  0.0009112413
##   AAED1  0.28361527  0.11312650  0.11297711    0.17048876  0.1706381600
##   AAGAB  0.06942315 -0.02252727  0.18841027    0.09195042 -0.1189871230
##   AAK1   0.01017744  0.19826414 -0.03174740   -0.18808671  0.0419248388
##        Contrasts
##         miR519-miR191
##   A2M   -0.0683616685
##   AAAS  -0.0375358970
##   AACS   0.0482616247
##   AAED1  0.0001493955
##   AAGAB -0.2109375393
##   AAK1   0.2300115440
```

```
# a quick look on the DEqMS results table
head(DEqMS.results)
```

```
##              logFC    AveExpr         t      P.Value    adj.P.Val         B
## ANKRD52 -1.2510508 -0.5579726 -22.87106 1.526501e-09 1.317828e-05 11.285532
## CROT    -1.2470819 -0.4499388 -14.12934 1.237413e-07 3.560861e-04  8.042317
## PDCD4   -0.7673770 -0.2662663 -13.42734 1.954766e-07 4.218875e-04  7.652462
## ATAD2   -0.6719598 -0.4584266 -11.76618 6.328104e-07 5.129415e-04  6.614667
## RELA    -0.6208005 -0.2296114 -12.08909 4.980318e-07 5.129415e-04  6.830220
## ZKSCAN1 -0.8846205 -0.5034830 -12.41816 3.924351e-07 5.129415e-04  7.042732
##            gene count     sca.t  sca.P.Value sca.adj.pval
## ANKRD52 ANKRD52    17 -22.52489 2.604115e-11 2.248132e-07
## CROT       CROT    22 -15.37439 2.364669e-09 1.020709e-05
## PDCD4     PDCD4    40 -14.40705 5.027631e-09 1.446785e-05
## ATAD2     ATAD2    51 -12.75244 2.042809e-08 4.074288e-05
## RELA       RELA    32 -12.59211 2.359717e-08 4.074288e-05
## ZKSCAN1 ZKSCAN1    10 -12.15065 3.539633e-08 4.746132e-05
```

```
# Save it into a tabular text file
write.table(DEqMS.results,"DEqMS.results.miR372-ctrl.txt",sep = "\t",
            row.names = F,quote=F)
```

Explaination of the columns in `DEqMS.results`:
`logFC` - log2 fold change between two groups, Here it’s log2(miR372/ctrl).
`AveExpr` - the mean of the log2 ratios/intensities across all samples. Since
input matrix is log2 ratio values, it is the mean log2 ratios of all samples.
`t` - Limma output t-statistics
`P.Value`- Limma p-values
`adj.P.Val` - BH method adjusted Limma p-values
`B` - Limma B values
`count` - PSM/peptide count values you assigned
`sca.t` - DEqMS t-statistics
`sca.P.Value` - DEqMS p-values
`sca.adj.pval` - BH method adjusted DEqMS p-values

### 2.1.8 Make volcanoplot

We recommend to plot p-values on y-axis instead of adjusted pvalue or FDR.
Read about why [here](https://support.bioconductor.org/p/98442/).

```
library(ggrepel)
# Use ggplot2 allows more flexibility in plotting

DEqMS.results$log.sca.pval = -log10(DEqMS.results$sca.P.Value)
ggplot(DEqMS.results, aes(x = logFC, y =log.sca.pval )) +
    geom_point(size=0.5 )+
    theme_bw(base_size = 16) + # change theme
    xlab(expression("log2(miR372/ctrl)")) + # x-axis label
    ylab(expression(" -log10(P-value)")) + # y-axis label
    geom_vline(xintercept = c(-1,1), colour = "red") + # Add fold change cutoffs
    geom_hline(yintercept = 3, colour = "red") + # Add significance cutoffs
    geom_vline(xintercept = 0, colour = "black") + # Add 0 lines
    scale_colour_gradient(low = "black", high = "black", guide = FALSE)+
    geom_text_repel(data=subset(DEqMS.results, abs(logFC)>1&log.sca.pval > 3),
                    aes( logFC, log.sca.pval ,label=gene)) # add gene label
```

```
## Warning: The `guide` argument in `scale_*()` cannot be `FALSE`. This was deprecated in
## ggplot2 3.3.4.
## ℹ Please use "none" instead.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)
you can also use `volcanoplot` function from Limma. However, it uses `p.value`
from Limma. If you want to plot `sca.pvalue` from DEqMS, you need to modify the
`fit4` object.

```
fit4$p.value = fit4$sca.p
# volcanoplot highlight top 20 proteins ranked by p-value here
volcanoplot(fit4,coef=1, style = "p-value", highlight = 20,
            names=rownames(fit4$coefficients))
```

![](data:image/png;base64...)

## 2.2 DEqMS analysis using MaxQuant outputs (label-free data)

Here we analyze a published label-free benchmark dataset in which either
10 or 30 µg of E. coli protein extract was spiked into human protein
extracts (50 µg) in triplicates (Cox J et al MCP 2014). The data was searched
by MaxQuant software and the output file “proteinGroups.txt” was used here.

```
url2 <- "https://ftp.ebi.ac.uk/pride-archive/2014/09/PXD000279/proteomebenchmark.zip"
download.file(url2, destfile = "./PXD000279.zip",method = "auto")
unzip("PXD000279.zip")
```

### 2.2.1 Read protein table as input and filter it

```
df.prot = read.table("proteinGroups.txt",header=T,sep="\t",stringsAsFactors = F,
                        comment.char = "",quote ="")

# remove decoy matches and matches to contaminant
df.prot = df.prot[!df.prot$Reverse=="+",]
df.prot = df.prot[!df.prot$Contaminant=="+",]

# Extract columns of LFQ intensites
df.LFQ = df.prot[,89:94]
df.LFQ[df.LFQ==0] <- NA

rownames(df.LFQ) = df.prot$Majority.protein.IDs
df.LFQ$na_count_H = apply(df.LFQ,1,function(x) sum(is.na(x[1:3])))
df.LFQ$na_count_L = apply(df.LFQ,1,function(x) sum(is.na(x[4:6])))
# Filter protein table. DEqMS require minimum two values for each group.
df.LFQ.filter = df.LFQ[df.LFQ$na_count_H<2 & df.LFQ$na_count_L<2,1:6]
```

### 2.2.2 Make a data frame of unique peptide count per protein

```
library(matrixStats)
# we use minimum peptide count among six samples
# count unique+razor peptides used for quantification
pep.count.table = data.frame(count = rowMins(as.matrix(df.prot[,19:24])),
                             row.names = df.prot$Majority.protein.IDs)
# Minimum peptide count of some proteins can be 0
# add pseudocount 1 to all proteins
pep.count.table$count = pep.count.table$count+1
```

### 2.2.3 DEqMS analysis on LFQ data

```
protein.matrix = log2(as.matrix(df.LFQ.filter))

class = as.factor(c("H","H","H","L","L","L"))
design = model.matrix(~0+class) # fitting without intercept

fit1 = lmFit(protein.matrix,design = design)
cont <- makeContrasts(classH-classL, levels = design)
fit2 = contrasts.fit(fit1,contrasts = cont)
fit3 <- eBayes(fit2)

fit3$count = pep.count.table[rownames(fit3$coefficients),"count"]

#check the values in the vector fit3$count
#if min(fit3$count) return NA or 0, you should troubleshoot the error first
min(fit3$count)
```

```
## [1] 1
```

```
fit4 = spectraCounteBayes(fit3)
```

### 2.2.4 Visualize the fit curve

```
VarianceBoxplot(fit4, n=20, main = "Label-free dataset PXD000279",
                xlab="peptide count + 1")
```

![](data:image/png;base64...)

### 2.2.5 Extract outputs from DEqMS

```
DEqMS.results = outputResult(fit4,coef_col = 1)
# Add Gene names to the data frame
rownames(df.prot) = df.prot$Majority.protein.IDs
DEqMS.results$Gene.name = df.prot[DEqMS.results$gene,]$Gene.names
head(DEqMS.results)
```

```
##           logFC  AveExpr         t      P.Value    adj.P.Val        B   gene
## P0A8V2 1.290950 32.97213 11.894233 1.140801e-05 0.0005926658 4.148090 P0A8V2
## P07118 1.266198 30.78180 12.015511 1.070353e-05 0.0005926658 4.211194 P07118
## P0AFG3 1.335840 31.65885 12.668638 7.669201e-06 0.0005926658 4.538511 P0AFG3
## P09373 1.245161 35.04896 11.315078 1.559908e-05 0.0005926658 3.836067 P09373
## P27298 1.353797 31.18702 12.456539 8.530817e-06 0.0005926658 4.434473 P27298
## P0AFG8 1.065060 34.13384  9.831808 3.735319e-05 0.0006115825 2.947425 P0AFG8
##        count    sca.t  sca.P.Value sca.adj.pval Gene.name
## P0A8V2    56 26.73381 2.450270e-10 8.944812e-07      rpoB
## P07118    38 24.92869 4.752226e-10 8.944812e-07      valS
## P0AFG3    33 24.62180 5.343376e-10 8.944812e-07      sucA
## P09373    41 22.37242 1.321228e-09 1.382583e-06      pflB
## P27298    30 22.27540 1.376526e-09 1.382583e-06      prlC
## P0AFG8    47 20.96849 2.433443e-09 1.999993e-06      aceE
```

```
write.table(DEqMS.results,"H-L.DEqMS.results.txt",sep = "\t",
            row.names = F,quote=F)
```

## 2.3 DEqMS analysis using a PSM table (isobaric labelled data)

If you want to try different methods to estimate protein abundance,you can
start with a PSM table and use provided functions in DEqMS to summarize PSM
quant data into protein quant data. Four different functions are included: `medianSweeping`,`medianSummary`,`medpolishSummary`,`farmsSummary`.
Check PDF reference manual for detailed description.

### 2.3.1 Read PSM table input

```
### retrieve example PSM dataset from ExperimentHub
library(ExperimentHub)
eh = ExperimentHub()
query(eh, "DEqMS")
```

```
## ExperimentHub with 4 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: ProteomeXchange, Swedish BioMS infrastructure
## # $species: Homo sapiens, Saccharomyces cerevisiae
## # $rdataclass: data.frame
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH1663"]]'
##
##            title
##   EH1663 | microRNA treated A431 cell proteomics data
##   EH7780 | microRNA treated A431 cell TMT10plex proteomics data-ProteinTable
##   EH7781 | MaxQuant LFQ benchmark dataset
##   EH7782 | DIA quantification UPS1 spike-in dataset
```

```
dat.psm = eh[["EH1663"]]
```

```
dat.psm.log = dat.psm
dat.psm.log[,3:12] =  log2(dat.psm[,3:12])
head(dat.psm.log)
```

```
##                                           Peptide     gene tmt10plex_126
## 1         +229.163EK+229.163EDDEEEEDEDASGGDQDQEER    RAD21      16.75237
## 2      +229.163LGLGIDEDEVAAEEPNAAVPDEIPPLEGDEDASR HSP90AB1      10.83812
## 3          +229.163TEGDEEAEEEQEENLEASGDYK+229.163    XRCC6      14.50514
## 4       +229.163GDAEK+229.163PEEELEEDDDEELDETLSER   TOMM22      15.03117
## 8       +229.163APLATGEDDDDEVPDLVENFDEASK+229.163     BTF3      12.91406
## 9 +229.163LEEEDEDEEDGESGC+57.021TFLVGLIQK+229.163    CAPN2      14.98558
##   tmt10plex_127N tmt10plex_127C tmt10plex_128N tmt10plex_128C tmt10plex_129N
## 1       16.58542       17.26731       16.89528       17.01872       17.57275
## 2       10.13673       11.11384       11.07480       10.94694       10.79556
## 3       14.24282       15.23424       14.89867       14.74940       14.97737
## 4       14.91910       15.41189       15.28130       15.28605       15.41345
## 8       12.95097       13.00558       13.42184       12.63930       13.62308
## 9       14.97605       15.30197       15.27980       15.10410       15.31982
##   tmt10plex_129C tmt10plex_130N tmt10plex_130C tmt10plex_131
## 1       17.17815       16.86259       17.10233      17.75614
## 2       11.12758       11.14692       10.82071      11.21737
## 3       15.15130       15.09598       15.01059      15.46618
## 4       15.25668       15.39181       15.26238      15.79845
## 8       13.12886       12.19316       12.90018      13.52949
## 9       15.25234       15.51071       15.72660      16.06220
```

### 2.3.2 Summarization and Normalization

Here, median sweeping is used to summarize PSMs intensities to protein log2
ratios. In this procedure, we substract the spectrum log2 intensity from the
median log2 intensities of all samples. The relative abundance estimate for
each protein is calculated as the median over all PSMs belonging to this
protein.(Herbrich et al JPR 2012 and D’Angelo et al JPR 2016).
Assume the log2 intensity of PSM `i` in sample `j` is \(y\_{i,j}\), its relative
log2 intensity of PSM `i` in sample `j` is \(y'\_{i,j}\):
\[y'\_{i,j} = y\_{i,j} - median\_{j'\in ctrl}\ y\_{i,j'} \]
Relative abundance of protein `k` in sample `j` \(Y\_{k,j}\) is calculated as:
\[Y\_{k,j} = median\_{i\in protein\ k}\ y'\_{i,j} \]

Correction for differences in amounts of material loaded in the channels
is then done by subtracting the channel median from the relative abundance
(log2 ratio), centering all channels to have median log2 value of zero.

```
dat.gene.nm = medianSweeping(dat.psm.log,group_col = 2)
boxplot(dat.gene.nm,las=2,ylab="log2 ratio",main="TMT10plex dataset PXD004163")
```

![](data:image/png;base64...)

### 2.3.3 DEqMS analysis

```
gene.matrix = as.matrix(dat.gene.nm)

# make design table
cond = as.factor(c("ctrl","miR191","miR372","miR519","ctrl",
"miR372","miR519","ctrl","miR191","miR372"))
design = model.matrix(~0+cond)
colnames(design) = gsub("cond","",colnames(design))

#limma part analysis
fit1 <- lmFit(gene.matrix,design)
x <- c("miR372-ctrl","miR519-ctrl","miR191-ctrl")
contrast =  makeContrasts(contrasts=x,levels=design)
fit2 <- eBayes(contrasts.fit(fit1,contrasts = contrast))

#DEqMS part analysis
psm.count.table = as.data.frame(table(dat.psm$gene))
rownames(psm.count.table) = psm.count.table$Var1

fit2$count = psm.count.table[rownames(fit2$coefficients),2]
fit3 = spectraCounteBayes(fit2)
# extract DEqMS results
DEqMS.results = outputResult(fit3,coef_col = 1)
head(DEqMS.results)
```

```
##              logFC      AveExpr         t      P.Value    adj.P.Val        B
## ANKRD52 -1.1917809 -0.093887723 -18.26692 2.608305e-08 0.0001326236 9.113399
## CROT    -1.1997155 -0.060459201 -16.41503 6.530463e-08 0.0002000934 8.438659
## TGFBR2  -1.3474739  0.083901815 -18.05371 2.885630e-08 0.0001326236 9.041434
## PDCD4   -0.7800666  0.007360661 -13.07496 4.512500e-07 0.0008295781 6.874678
## TRPS1   -0.8122847 -0.050833888 -11.70281 1.142391e-06 0.0013126073 6.063183
## PHLPP2  -0.7969800 -0.001069459 -14.37066 2.029693e-07 0.0004664235 7.543032
##            gene count     sca.t  sca.P.Value sca.adj.pval
## ANKRD52 ANKRD52    17 -18.97949 3.769162e-10 3.147509e-06
## CROT       CROT    20 -17.59956 8.866593e-10 3.147509e-06
## TGFBR2   TGFBR2     7 -17.37181 1.027255e-09 3.147509e-06
## PDCD4     PDCD4    40 -14.25841 9.397591e-09 2.159566e-05
## TRPS1     TRPS1    30 -12.78539 3.133624e-08 4.919434e-05
## PHLPP2   PHLPP2     8 -12.75696 3.211119e-08 4.919434e-05
```

```
write.table(DEqMS.results,"DEqMS.results.miR372-ctrl.fromPSMtable.txt",
            sep = "\t",row.names = F,quote=F)
```

Generate variance ~ PMS count boxplot, check if the DEqMS correctly find the relation between prior variance and PSM count

```
VarianceBoxplot(fit3,n=20, xlab="PSM count",main="TMT10plex dataset PXD004163")
```

![](data:image/png;base64...)

### 2.3.4 PSM/Peptide profile plot

Only possible if you read a PSM or peptide table as input.
`peptideProfilePlot` function will plot log2 intensity of each PSM/peptide of
the protein in the input table.

```
peptideProfilePlot(dat=dat.psm.log,col=2,gene="TGFBR2")
```

```
## Using Peptide, gene as id variables
```

![](data:image/png;base64...)

```
# col=2 is tell in which column of dat.psm.log to look for the gene
```

# 3 Comparing DEqMS to other methods

The following steps are not required for get the results from DEqMS.
it is used to help users to understand the method better and the differences
to other methods. Here we use the TMT labelled data PXD004163 as an example.

## 3.1 Compare the variance estimate in DEqMS and Limma

### 3.1.1 Prior variance comparison between DEqMS and Limma

```
VarianceScatterplot(fit3, xlab="log2(PSM count)")
limma.prior = fit3$s2.prior
abline(h = log(limma.prior),col="green",lwd=3 )
legend("topright",legend=c("DEqMS prior variance","Limma prior variance"),
        col=c("red","green"),lwd=3)
```

![](data:image/png;base64...)

### 3.1.2 Residual plot for DEqMS and Limma

```
op <- par(mfrow=c(1,2), mar=c(4,4,4,1), oma=c(0.5,0.5,0.5,0))
Residualplot(fit3,  xlab="log2(PSM count)",main="DEqMS")
x = fit3$count
y = log(limma.prior) - log(fit3$sigma^2)
plot(log2(x),y,ylim=c(-6,2),ylab="Variance(estimated-observed)", pch=20, cex=0.5,
     xlab = "log2(PSMcount)",main="Limma")
```

![](data:image/png;base64...)

### 3.1.3 Posterior variance comparison between DEqMS and Limma

The plot here shows posterior variance of proteins “shrink” toward the
fitted value to different extent depending on PSM number.

```
library(LSD)
op <- par(mfrow=c(1,2), mar=c(4,4,4,1), oma=c(0.5,0.5,0.5,0))
x = fit3$count
y = fit3$s2.post
heatscatter(log2(x),log(y),pch=20, xlab = "log2(PSMcount)",
     ylab="log(Variance)",
     main="Posterior Variance in Limma")

y = fit3$sca.postvar
heatscatter(log2(x),log(y),pch=20, xlab = "log2(PSMcount)",
     ylab="log(Variance)",
     main="Posterior Variance in DEqMS")
```

![](data:image/png;base64...)

## 3.2 Compare p-values from DEqMS to ordinary t-test, ANOVA and Limma

We first apply t.test to detect significant protein changes between ctrl
samples and miR372 treated samples, both have three replicates.

### 3.2.1 T-test analysis

```
pval.372 = apply(dat.gene.nm, 1, function(x)
t.test(as.numeric(x[c(1,5,8)]), as.numeric(x[c(3,6,10)]))$p.value)

logFC.372 = rowMeans(dat.gene.nm[,c(3,6,10)])-rowMeans(dat.gene.nm[,c(1,5,8)])
```

Generate a data.frame of t.test results, add PSM count values and order the
table by p-value.

```
ttest.results = data.frame(gene=rownames(dat.gene.nm),
                    logFC=logFC.372,P.Value = pval.372,
                    adj.pval = p.adjust(pval.372,method = "BH"))

ttest.results$PSMcount = psm.count.table[ttest.results$gene,"count"]
ttest.results = ttest.results[with(ttest.results, order(P.Value)), ]
head(ttest.results)
```

```
##          gene      logFC      P.Value   adj.pval
## CCNE2   CCNE2  0.5386427 6.522987e-07 0.00599593
## CPSF2   CPSF2  0.1077977 7.633799e-06 0.03508494
## PPOX     PPOX -0.2464418 2.546510e-05 0.07802507
## RELA     RELA -0.5617739 5.078761e-05 0.11670992
## IFIT1   IFIT1  0.6375060 7.300925e-05 0.13422020
## MAGEA6 MAGEA6  0.4625733 1.093648e-04 0.16178031
```

### 3.2.2 Anova analysis

Anova analysis is equivalent to linear model analysis. The difference to
Limma analysis is that estimated variance is not moderated using empirical
bayesian approach as it is done in Limma.

```
ord.t = fit1$coefficients[, 1]/fit1$sigma/fit1$stdev.unscaled[, 1]
ord.p = 2*pt(abs(ord.t), fit1$df.residual, lower.tail = FALSE)
ord.q = p.adjust(ord.p,method = "BH")
anova.results = data.frame(gene=names(fit1$sigma),
                            logFC=fit1$coefficients[,1],
                            t=ord.t,
                            P.Value=ord.p,
                            adj.P.Val = ord.q)

anova.results$PSMcount = psm.count.table[anova.results$gene,"count"]
anova.results = anova.results[with(anova.results,order(P.Value)),]

head(anova.results)
```

```
##          gene      logFC         t      P.Value   adj.P.Val
## IFIT1   IFIT1 -0.8608329 -21.42050 6.753255e-07 0.003817858
## GULP1   GULP1 -0.3007482 -20.68542 8.306916e-07 0.003817858
## HMGCS1 HMGCS1 -0.2647281 -16.89451 2.748573e-06 0.007115321
## MB21D2 MB21D2 -0.2322144 -16.55622 3.096310e-06 0.007115321
## DDX58   DDX58 -0.3693960 -15.79362 4.086084e-06 0.007511856
## PHLPP2 PHLPP2  0.4988921  14.57485 6.545069e-06 0.007954545
```

### 3.2.3 Limma

Extract limma results using `topTable` function, `coef = 1` allows you to
extract the specific contrast (miR372-ctrl), option `n= Inf` output
all rows.

```
limma.results = topTable(fit2,coef = 1,n= Inf)
limma.results$gene = rownames(limma.results)
#Add PSM count values in the data frame
limma.results$PSMcount = psm.count.table[limma.results$gene,"count"]

head(limma.results)
```

```
##              logFC      AveExpr         t      P.Value    adj.P.Val        B
## ANKRD52 -1.1917809 -0.093887723 -18.26692 2.608305e-08 0.0001326236 9.113399
## TGFBR2  -1.3474739  0.083901815 -18.05371 2.885630e-08 0.0001326236 9.041434
## CROT    -1.1997155 -0.060459201 -16.41503 6.530463e-08 0.0002000934 8.438659
## PHLPP2  -0.7969800 -0.001069459 -14.37066 2.029693e-07 0.0004664235 7.543032
## PDCD4   -0.7800666  0.007360661 -13.07496 4.512500e-07 0.0008295781 6.874678
## ZKSCAN1 -0.8816149 -0.056612793 -11.95070 9.591643e-07 0.0012877234 6.218545
##            gene
## ANKRD52 ANKRD52
## TGFBR2   TGFBR2
## CROT       CROT
## PHLPP2   PHLPP2
## PDCD4     PDCD4
## ZKSCAN1 ZKSCAN1
```

### 3.2.4 Visualize the distribution of p-values by different analysis

plotting all proteins ranked by p-values.

```
plot(sort(-log10(limma.results$P.Value),decreasing = TRUE),
    type="l",lty=2,lwd=2, ylab="-log10(p-value)",ylim = c(0,10),
    xlab="Proteins ranked by p-values",
    col="purple")
lines(sort(-log10(DEqMS.results$sca.P.Value),decreasing = TRUE),
        lty=1,lwd=2,col="red")
lines(sort(-log10(anova.results$P.Value),decreasing = TRUE),
        lty=2,lwd=2,col="blue")
lines(sort(-log10(ttest.results$P.Value),decreasing = TRUE),
        lty=2,lwd=2,col="orange")
legend("topright",legend = c("Limma","DEqMS","Anova","t.test"),
        col = c("purple","red","blue","orange"),lty=c(2,1,2,2),lwd=2)
```

![](data:image/png;base64...)

plotting top 500 proteins ranked by p-values.

```
plot(sort(-log10(limma.results$P.Value),decreasing = TRUE)[1:500],
    type="l",lty=2,lwd=2, ylab="-log10(p-value)", ylim = c(2,10),
    xlab="Proteins ranked by p-values",
    col="purple")
lines(sort(-log10(DEqMS.results$sca.P.Value),decreasing = TRUE)[1:500],
        lty=1,lwd=2,col="red")
lines(sort(-log10(anova.results$P.Value),decreasing = TRUE)[1:500],
        lty=2,lwd=2,col="blue")
lines(sort(-log10(ttest.results$P.Value),decreasing = TRUE)[1:500],
        lty=2,lwd=2,col="orange")
legend("topright",legend = c("Limma","DEqMS","Anova","t.test"),
        col = c("purple","red","blue","orange"),lty=c(2,1,2,2),lwd=2)
```

![](data:image/png;base64...)