# Analyzing Regulatory Impact Factors and Partial Correlation and Information Theory

#### Carlos Alberto Oliveira de Biagi Junior, Ricardo Perecin Nociti, Breno Osvaldo Funicheli, João Paulo Bianchi Ximenez, Patrícia de Cássia Ruy, Marcelo Gomes de Paula, Rafael dos Santos Bezerra and Wilson Araújo da Silva Junior

#### 10/29/2025

* [Introduction](#introduction)
  + [Regulatory Information Factors (RIF)](#regulatory-information-factors-rif)
  + [Partial Correlation with Information Theory (PCIT)](#partial-correlation-with-information-theory-pcit)
* [Installation](#installation)
* [Workflow](#workflow)
  + [PCIT](#pcit)
  + [Histogram of connectivity distribution](#histogram-of-connectivity-distribution)
  + [Density Plot of raw correlation and significant PCIT](#density-plot-of-raw-correlation-and-significant-pcit)
  + [RIF](#rif)
  + [Whole analysis of Regulatory Impact Factors (RIF) and Partial Correlation and Information Theory analysis (PCIT)](#whole-analysis-of-regulatory-impact-factors-rif-and-partial-correlation-and-information-theory-analysis-pcit)
  + [Getting some graphical outputs](#getting-some-graphical-outputs)
  + [Using accessors to access results](#using-accessors-to-access-results)
* [Additional Features](#additional-features)
  + [Network diffusion analysis](#network-diffusion-analysis)
  + [Circos plot](#circos-plot)
  + [RIF relationships plots](#rif-relationships-plots)
  + [Enrichment plots](#enrichment-plots)
    - [Heatmap-like functional classification](#heatmap-like-functional-classification)
    - [Circle Barplot](#circle-barplot)
    - [Barplot](#barplot)
    - [Dotplot](#dotplot)
* [Session info](#session-info)
* [References](#references)

# Introduction

This vignette provides the necessary instructions for performing the Partial Correlation coefficient with Information Theory (PCIT) (Reverter and Chan 2008) and Regulatory Impact Factors (RIF) (Reverter et al. 2010) algorithm.

The PCIT algorithm identifies meaningful correlations to define edges in a weighted network and can be applied to any correlation-based network including but not limited to gene co-expression networks, while the RIF algorithm identify critical transcript factors (TF) from gene expression data.

These two algorithms when combined provide a very relevant layer of information for gene expression studies (Microarray, RNA-seq and single-cell RNA-seq data).

## Regulatory Information Factors (RIF)

A gene expression data from microarray, RNA-seq or single-cell RNA-seq spanning two biological conditions of interest (e.g. normal/tumor, healthy/disease, malignant/nonmalignant) is subjected to standard normalization techniques and significance analysis to identify the target genes whose expression is differentially expressed (DE) between the two conditions. Then, the regulators (e.g. Transcript Factors genes) are identified in the data. The TF genes can be obtained from the literature (Wang and Nishida 2015)(Vaquerizas et al. 2009). Next, the co-expression correlation between each TF and the DE genes is computed for each of the two conditions. This allows for the computation of the differential wiring (DW) from the difference in co-expression correlation existing between a TF and a DE genes in the two conditions. As a result, RIF analysis assigns an extreme score to those TF that are consistently most differentially co-expressed with the highly abundant and highly DE genes (case of RIF1 score), and to those TF with the most altered ability to act as predictors of the abundance of DE genes (case of RIF2 score). A given TF may not show a change in expression profile between the two conditions to score highly by RIF as long as it shows a big change in co-expression with the DE genes. To this particular, the profile of the TF gene (triangle, solid line) is identical in both conditions (slightly downwards). Instead, the DE gene (circle, dashed line) is clearly over-expressed in condition B. Importantly, the expression of the TF and the DE gene shows a strong positive correlation in condition A, and a strong negative correlation in condition B.

![A schematic diagram of the RIF analysis. (A) Gene expression data is normalized and statistically assessed to identify differentially expressed (DE) genes and differentially PIF genes (represented by circles) which together are deemed as the Target genes; Simultaneously, (B) transcription factors (TF, represented by triangles) included in the microarray are collected and (C) their co-expression correlation with the target genes computed for each of the two conditions of interest; Finally, (D) the way in which TF and target genes are differentially co-expressed between the two conditions is used to compute the relevance of each TF according to RIF1 and RIF2 (Reverter et al. 2010).](data:image/jpeg;base64... "fig:")

## Partial Correlation with Information Theory (PCIT)

The proposed PCIT algorithm contains two distinct steps as follows:

#### **Step 1 - Partial correlations**

For every trio of genes in x, y and z, the three first-order partial correlation coefficients are computed by:

\[r\_{xy.z} = \frac{r\_{xy} - r\_{xz} r\_{yz}}{\sqrt{(1-r^{2}\_{xz})(1-r^{2}\_{yz})}}\], and similarly for \(r\_{xz.y}\) and \(r\_{yz.x}\).

The partial correlation coefficient between *x* and *y* given *z* (here denoted by \(r\_{xy.z}\)) indicates the strength of the linear relationship between *x* and *y* that is independent of (uncorrelated with) *z*. Calculating the ordinary (or unconditional or zero-order) correlation coefficient and comparing it with the partial correlation, we might see that the association between the two variables has been sharply reduced after eliminating the effect of the third variable.

#### **Step 2 - Information theory**

We invoke the Data Processing Inequality (DPI) theorem of Information Theory which states that ‘no clever manipulation of the data can improve the inference that can be made from the data’ (Cover and Thomas 2012). For every trio of genes, and in order to obtain the tolerance level (\(\varepsilon\)) to be used as the local threshold for capturing significant associations, the average ratio of partial to direct correlation is computed as follows:

\[\varepsilon = (\frac{r\_{xy.z}}{r\_{xy}} + \frac{r\_{xz.y}}{r\_{xz}} + \frac{r\_{yz.x}}{r\_{yz}})\] In the context of our network reconstruction, a connection between genes *x* and *y* is discarded if:

\[|r\_{xy}| \le |\varepsilon r\_{xz}| and |r\_{xy}| \le |\varepsilon r\_{yz}|\] Otherwise, the association is defined as significant, and a connection between the pair of genes is established in the reconstruction of the GCN. To ascertain the significance of the association between genes *x* and *y*, the above mentioned Steps 1 and 2 are repeated for each of the remaining *n−2* genes (denoted here by *z*).

# Installation

To install, just type:

```
BiocManager::install("cbiagii/CeTF")
```

for Linux users is necessary to install **libcurl4-openssl-dev**, **libxml2-dev** and **libssl-dev** dependencies.

# Workflow

There are many ways to perform the analysis. The following sections will be splited by steps, and finishing with the complete analysis with visualization. We will use the **airway** (Himes et al. 2014) dataset in the following sections. This dataset provides a RNA-seq count data from four human ASM cell lines that were treated with dexamenthasone - a potent synthetic glucocorticoid. Briefly, this dataset has 4 samples untreated and other 4 samples with the treatment.

## PCIT

The first option is to perform the PCIT analysis. The output will be a list with 3 elements. The first one contains a dataframe with the pairwise correlation between genes (corr1) and the significant pairwise correlation (corr2 \(\neq\) 0). The second element of the list stores the adjacency matrix with all correlation. And the last element contains the adjacency matrix with only the significant values:

```
# Loading packages
library(CeTF)
library(airway)
library(kableExtra)
library(knitr)

# Loading airway data
data("airway")

# Creating a variable with annotation data
anno <- as.data.frame(colData(airway))
anno <- anno[order(anno$dex, decreasing = TRUE), ]
anno <- data.frame(cond = anno$dex,
                   row.names = rownames(anno))

# Creating a variable with count data
counts <- assay(airway)

# Sorting count data samples by conditions (untrt and trt)
counts <- counts[, rownames(anno)]
colnames(counts) <- paste0(colnames(counts), c(rep("_untrt", 4), rep("_trt", 4)))

# Differential Expression analysis to use only informative genes
DEGenes <- expDiff(exp = counts,
                   anno = anno,
                   conditions = c('untrt', 'trt'),
                   lfc = 4.5,
                   padj = 0.05,
                   diffMethod = "Reverter")

# Selecting only DE genes from counts data
counts <- counts[rownames(DEGenes$DE_unique), ]

# Converting count data to TPM
tpm <- apply(counts, 2, function(x) {
            (1e+06 * x)/sum(x)
        })

# Count normalization
PCIT_input <- normExp(tpm)

# PCIT input for untrt
PCIT_input_untrt <- PCIT_input[,grep("_untrt", colnames(PCIT_input))]

# PCIT input for trt
PCIT_input_trt <- PCIT_input[,grep("_trt", colnames(PCIT_input))]

# Performing PCIT analysis for untrt condition
PCIT_out_untrt <- PCIT(PCIT_input_untrt, tolType = "mean")

# Performing PCIT analysis for trt condition
PCIT_out_trt <- PCIT(PCIT_input_trt, tolType = "mean")

# Printing first 10 rows for untrt condition
kable(PCIT_out_untrt$tab[1:10, ]) %>%
  kable_styling(bootstrap_options = "striped", full_width = FALSE)
```

| gene1 | gene2 | corr1 | corr2 |
| --- | --- | --- | --- |
| ENSG00000011465 | ENSG00000026025 | 0.01160 | 0.00000 |
| ENSG00000011465 | ENSG00000035403 | 0.61286 | 0.00000 |
| ENSG00000011465 | ENSG00000049323 | -0.71685 | 0.00000 |
| ENSG00000011465 | ENSG00000067225 | -0.99935 | -0.99935 |
| ENSG00000011465 | ENSG00000071127 | -0.56817 | 0.00000 |
| ENSG00000011465 | ENSG00000071242 | -0.89063 | 0.00000 |
| ENSG00000011465 | ENSG00000075624 | 0.09820 | 0.00000 |
| ENSG00000011465 | ENSG00000077942 | -0.80938 | 0.00000 |
| ENSG00000011465 | ENSG00000080824 | -0.72639 | 0.00000 |
| ENSG00000011465 | ENSG00000087086 | -0.91357 | 0.00000 |

```
# Printing first 10 rows for trt condition
kable(PCIT_out_trt$tab[1:10, ]) %>%
  kable_styling(bootstrap_options = "striped", full_width = FALSE)
```

| gene1 | gene2 | corr1 | corr2 |
| --- | --- | --- | --- |
| ENSG00000011465 | ENSG00000026025 | 0.63800 | 0.00000 |
| ENSG00000011465 | ENSG00000035403 | 0.96857 | 0.96857 |
| ENSG00000011465 | ENSG00000049323 | 0.14794 | 0.00000 |
| ENSG00000011465 | ENSG00000067225 | -0.99687 | -0.99687 |
| ENSG00000011465 | ENSG00000071127 | -0.92734 | -0.92734 |
| ENSG00000011465 | ENSG00000071242 | -0.75914 | 0.00000 |
| ENSG00000011465 | ENSG00000075624 | -0.70489 | 0.00000 |
| ENSG00000011465 | ENSG00000077942 | -0.29712 | 0.00000 |
| ENSG00000011465 | ENSG00000080824 | -0.93148 | 0.00000 |
| ENSG00000011465 | ENSG00000087086 | -0.94620 | 0.00000 |

```
# Adjacency matrix: PCIT_out_untrt$adj_raw or PCIT_out_trt$adj_raw
# Adjacency matrix only with the significant values: PCIT_out_untrt$adj_sig or PCIT_out_trt$adj_sig
```

## Histogram of connectivity distribution

After performing the PCIT analysis, it is possible to verify the histogram distribution of the clustering coefficient of the adjacency matrix with the significant values:

```
# Example for trt condition
histPlot(PCIT_out_trt$adj_sig)
```

```
## Warning: The `size` argument of `element_line()` is deprecated as of ggplot2 3.4.0.
## ℹ Please use the `linewidth` argument instead.
## ℹ The deprecated feature was likely used in the CeTF package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the CeTF package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

## Density Plot of raw correlation and significant PCIT

It’s possible to generate the density plot with the significance values of correlation. We’ll use the raw adjacency matrix and the adjacency matrix with significant values. It is necessary to define a cutoff of the correlation module (values between -1 and 1) that will be considered as significant:

```
# Example for trt condition
densityPlot(mat1 = PCIT_out_trt$adj_raw,
           mat2 = PCIT_out_trt$adj_sig,
           threshold = 0.5)
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the CeTF package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

## RIF

To perform the RIF analysis we will need the count data, an annotation table and a list with the Transcript Factors of specific organism (*Homo sapiens* in this case) and follow the following steps in order to get the output (dataframe with the average expression, RIF1 and RIF2 metrics for each TF):

```
# Loading packages
library(CeTF)
library(airway)
library(kableExtra)
library(knitr)

# Loading airway data
data("airway")

# Creating a variable with annotation data
anno <- as.data.frame(colData(airway))
anno <- anno[order(anno$dex, decreasing = TRUE), ]
anno <- data.frame(cond = anno$dex,
                   row.names = rownames(anno))

# Creating a variable with count data
counts <- assay(airway)

# Sorting count data samples by conditions (untrt and trt)
counts <- counts[, rownames(anno)]
colnames(counts) <- paste0(colnames(counts), c(rep("_untrt", 4), rep("_trt", 4)))

# Differential Expression analysis to use only informative genes
DEGenes <- expDiff(exp = counts,
                   anno = anno,
                   conditions = c('untrt', 'trt'),
                   lfc = 2,
                   padj = 0.05,
                   diffMethod = "Reverter")

# Selecting only DE genes from counts data
counts <- counts[rownames(DEGenes$DE_unique), ]

# Converting count data to TPM
tpm <- apply(counts, 2, function(x) {
            (1e+06 * x)/sum(x)
        })

# Count normalization
Clean_Dat <- normExp(tpm)

# Loading the Transcript Factors (TFs) character
data("TFs")

# Verifying which TFs are in the subsetted normalized data
TFs <- rownames(Clean_Dat)[rownames(Clean_Dat) %in% TFs]

# Selecting the Target genes
Target <- setdiff(rownames(Clean_Dat), TFs)

# Ordering rows of normalized count data
RIF_input <- Clean_Dat[c(Target, TFs), ]

# Performing RIF analysis
RIF_out <- RIF(input = RIF_input,
               nta = length(Target),
               ntf = length(TFs),
               nSamples1 = 4,
               nSamples2 = 4)

# Printing first 10 rows
kable(RIF_out[1:10, ]) %>%
  kable_styling(bootstrap_options = "striped", full_width = FALSE)
```

| TF | avgexpr | RIF1 | RIF2 |
| --- | --- | --- | --- |
| ENSG00000008441 | 10.381697 | -0.1528773 | -0.6769198 |
| ENSG00000102804 | 9.265949 | -0.0004763 | 0.1980176 |
| ENSG00000103888 | 13.592705 | 0.0877683 | -0.3434817 |
| ENSG00000103994 | 10.386200 | -1.2749114 | 0.8224675 |
| ENSG00000112837 | 8.144279 | -0.1825080 | -1.7860290 |
| ENSG00000116016 | 11.377135 | -1.2236196 | 0.0188771 |
| ENSG00000116132 | 9.389114 | 1.4025115 | 0.8876227 |
| ENSG00000118689 | 9.190363 | 0.9718881 | 0.3826641 |
| ENSG00000123562 | 9.208115 | 0.4050667 | 0.4663411 |
| ENSG00000157514 | 7.216761 | -1.5719588 | -0.3117244 |

## Whole analysis of Regulatory Impact Factors (RIF) and Partial Correlation and Information Theory analysis (PCIT)

Finally, it is possible to run the entire analysis all at once. The output will be a CeTF object with all results generated between the different steps. To access the CeTF object is recommended to use the accessors from **CeTF** class:

```
# Loading packages
library(airway)
library(CeTF)

# Loading airway data
data("airway")

# Creating a variable with annotation data
anno <- as.data.frame(colData(airway))

# Creating a variable with count data
counts <- assay(airway)

# Sorting count data samples by conditions (untrt and trt)
counts <- counts[, order(anno$dex, decreasing = TRUE)]

# Loading the Transcript Factors (TFs) character
data("TFs")

# Performing the complete analysis
out <- runAnalysis(mat = counts,
                   conditions=c("untrt", "trt"),
                   lfc = 5,
                   padj = 0.05,
                   TFs = TFs,
                   nSamples1 = 4,
                   nSamples2= 4,
                   tolType = "mean",
                   diffMethod = "Reverter",
                   data.type = "counts")
```

## Getting some graphical outputs

Based on CeTF class object resulted from **runAnalysis** function is possible to get a plot for Differentially Expressed (DE) genes that shows the relationship between log(baseMean) and Difference of Expression or log2FoldChange, enabling the visualization of the distribution of DE genes and TF in both conditions. These two first plot provides a initial graphical visualization of results:

```
# Using the runAnalysis output (CeTF class object)
SmearPlot(object = out,
          diffMethod = 'Reverter',
          lfc = 1.5,
          conditions = c('untrt', 'trt'),
          type = "DE")
```

![](data:image/png;base64...)

Then is possible to generate the same previous plot but now for a single TF. So, if you have a specific TF that you want to visualize, this is the recommended plot:

```
# Using the runAnalysis output (CeTF class object)
SmearPlot(object = out,
          diffMethod = 'Reverter',
          lfc = 1.5,
          conditions = c('untrt', 'trt'),
          TF = 'ENSG00000185917',
          label = TRUE,
          type = "TF")
```

```
## Warning: ggrepel: 1 unlabeled data points (too many overlaps). Consider
## increasing max.overlaps
```

![](data:image/png;base64...)

The next output is a network for both conditions resulted from :

```
# Using the runAnalysis output (CeTF class object)
netConditionsPlot(out)
```

```
## Warning: The `<scale>` argument of `guides()` cannot be `FALSE`. Use "none" instead as
## of ggplot2 3.3.4.
## ℹ The deprecated feature was likely used in the CeTF package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

Then we will associate the genes in both conditions with Gene Ontology (GO) and other databases. *getGroupGO* function will be performed where a set of genes are counted within all possible ontologies, without statistical power. This function is capable of perform groupGO for any organism as long as it’s annotation package exists (i.e. org.Hs.eg.db, org.Bt.eg.db, org.Rn.eg.db, etc). In this example we will perform only for first condition:

```
# Loading Homo sapiens annotation package
library(org.Hs.eg.db)

# Accessing the network for condition 1
genes <- unique(c(as.character(NetworkData(out, "network1")[, "gene1"]),
                  as.character(NetworkData(out, "network1")[, "gene2"])))

# Performing getGroupGO analysis
cond1 <- getGroupGO(genes = genes,
                    ont = "BP",
                    keyType = "ENSEMBL",
                    annoPkg = org.Hs.eg.db,
                    level = 3)
```

Alternatively, it is possible to perform the enrichment analysis with a statistical power. In this case, there are many databases options to perform this analysis (i.e. GO, KEGG, REACTOME, etc). The *getEnrich* function will perform the enrichment analysis and returns which pathways are enriched in a given set of genes. This analysis requires a reference list of genes with all genes that will be considered to enrich. In this package there is a function, *refGenes* that has these references genes for ENSEMBL and SYMBOL nomenclatures for 5 organisms: Human (**Homo sapiens**), Mouse (**Mus musculus**), Zebrafish (**Danio rerio**), Cow (**Bos taurus**) and Rat (**Rattus norvegicus**). If the user wants to use a different reference set, simply inputs a character vector with the genes.

```
# Accessing the network for condition 1
genes <- unique(c(as.character(NetworkData(out, "network1")[, "gene1"]),
                  as.character(NetworkData(out, "network1")[, "gene2"])))

# Performing getEnrich analysis
enrich <- getEnrich(genes = genes, organismDB = org.Hs.eg.db,
                    keyType = 'ENSEMBL', ont = 'BP', fdrMethod = "BH",
                    fdrThr = 0.05, minGSSize = 5, maxGSSize = 500)
```

In the next steps we will use the *getGroupGO* results, but it is worth mentioning that you can use the results of the *getEnrich* function. To run the following steps with the *getEnrich* results is recommended to change the *lfc* parameter in aboce *runAnalysis* function by 3. That way there will be more pathways to enrich. Remembering that this will require more processing time.

After the association of GOs and genes, we are able to plot the network of previously results. It’s possible to choose which variables (“pathways”, “TFs” or “genes”) we want to group. All these variables are inputted by the user, i.e.  the user can choose the pathways, TFs or genes returned from analysis from the runAnalysis function and CeTF class object, or can also choose by specific pathways, TFs or genes of interest. The table used to plot the networks are stored in a list resulted from netGOTFPlot function. To get access is needed to use the *object$tab*. The list will be splitted by groupBy argument choice:

```
library(dplyr)

# Subsetting only the first 12 Ontologies with more counts
t1 <- head(cond1$results, 12)

# Subsetting the network for the conditions to make available only the 12 nodes subsetted
t2 <- subset(cond1$netGO, cond1$netGO$gene1 %in% as.character(t1[, "ID"]))

# generating the GO plot grouping by pathways
pt <- netGOTFPlot(netCond = NetworkData(out, "network1") %>%
                    mutate(across(everything(), as.character)),
                  resultsGO = t1,
                  netGO = t2,
                  anno = NetworkData(out, "annotation"),
                  groupBy = 'pathways',
                  type = 'GO')
pt$plot
```

![](data:image/png;base64...)

```
head(pt$tab$`GO:0006807`)
```

```
## NULL
```

```
# generating the GO plot grouping by TFs
TFs <- NetworkData(out, "keytfs")$TF[1:4]
pt <- netGOTFPlot(netCond = NetworkData(out, "network1"),
                  resultsGO = t1,
                  netGO = t2,
                  anno = NetworkData(out, "annotation"),
                  groupBy = 'TFs',
                  TFs = TFs,
                  type = 'GO')
pt$plot
```

![](data:image/png;base64...)

```
head(pt$tab$ENSG00000011465)
```

```
## NULL
```

```
# generating the GO plot grouping by specifics genes
genes <- c('ENSG00000011465', 'ENSG00000026025', 'ENSG00000075624', 'ENSG00000077942')
pt <- netGOTFPlot(netCond = NetworkData(out, "network1"),
                  resultsGO = t1,
                  netGO = t2,
                  anno = NetworkData(out, "annotation"),
                  groupBy = 'genes',
                  genes = genes,
                  type = 'GO')
pt$plot
```

![](data:image/png;base64...)

```
head(pt$tab$ENSG00000011465)
```

```
##              gene1           genes gene2 class
## 1  ENSG00000004799 ENSG00000011465  <NA>  gene
## 5  ENSG00000013293 ENSG00000011465  <NA>  gene
## 9  ENSG00000030419 ENSG00000011465  <NA>    TF
## 13 ENSG00000053254 ENSG00000011465  <NA>    TF
## 17 ENSG00000064961 ENSG00000011465  <NA>    TF
## 21 ENSG00000067082 ENSG00000011465  <NA>    TF
```

Finally, we will merge the results from the network of condition 1 (Gene-Gene and TF-Gene interaction) with groupGO results (GO-Gene or GO-TF interaction). The final results has the objective to integrate all these data in order to results in a complete view of the data:

```
pt <- netGOTFPlot(netCond = NetworkData(out, "network1") %>%
                   mutate(across(everything(), as.character)),
                  netGO = t2,
                  keyTFs = NetworkData(out, "keytfs"),
                  type = 'Integrated')

pt$plot
```

![](data:image/png;base64...)

```
head(pt$tab)
```

```
##              gene1           gene2
## 22 ENSG00000004799 ENSG00000113761
## 24 ENSG00000004799 ENSG00000114861
## 26 ENSG00000004799 ENSG00000119138
## 27 ENSG00000004799 ENSG00000120093
## 47 ENSG00000004799 ENSG00000143127
## 77 ENSG00000004799 ENSG00000184271
```

## Using accessors to access results

Is possible to use the accessors from CeTF class object to access the outputs generated by the *runAnalysis* function. These outputs can be used as input in **Cytoscape** (Shannon et al. 2003). The accessors are:

* **getData**: returns the raw, tpm and normalized data;
* **getDE**: returns the DE genes and TFs;
* **InputData** returns the input matrices used to perform RIF and PCIT in *runAnalysis* function;
* **OutputData** returns the output matrices and lists that output from RIF and PCIT in *runAnalysis* function;
* **NetworkData** returns the network of interactions between gene and key TFs for both conditions, the keyTFs and the annotation for each gene and TF.

All accessors can be further explored by looking in more detail at the documentation.

# Additional Features

This package has some additional features to plot the results. Let’s use the gene set from *airway* data previously used. The features are:

## Network diffusion analysis

Network propagation is an important and widely used algorithm in systems biology, with applications in protein function prediction, disease gene prioritization, and patient stratification. Propagation provides a robust estimate of network distance between sets of nodes. Network propagation uses the network of interactions to find new genes that are most relevant to a set of well understood genes. To perform this analysis is necessary to install the latest Cytoscape software version and know the path that will be installed the software. After running the diffusion analysis is possible to perform the enrichment for the subnetwork resulted. Finally, ih this vignette we’ll not perform the diffusion analysis because this requires Cytoscape to be installed.

```
result <- diffusion(object = out,
                    cond = "network1",
                    genes = c("ENSG00000185591", "ENSG00000179094"),
                    cyPath = "C:/Program Files/Cytoscape_v3.7.2/Cytoscape.exe",
                    name = "top_diffusion",
                    label = T)
```

## Circos plot

This plot makes it possible to visualize the targets of specific TFs or genes. The main idea is to identify which chromosomes are linked to the targets of a given gene or TF to infer whether there are cis (same chromosome) or trans (different chromosomes) links between them. The black links are between different chromosomes while the red links are between the same chromosome.

```
# Loading the CeTF object class demo
data("CeTFdemo")

CircosTargets(object = CeTFdemo,
              file = "/path/to/gtf/file/specie.gtf",
              nomenclature = "ENSEMBL",
              selection = "ENSG00000185591",
              cond = "condition1")
```

![](data:image/png;base64...)

## RIF relationships plots

To visualize the relationship between RIF results (RIF1 and RIF2) is possible to generate the following plot:

```
RIFPlot(object = out,
        color  = "darkblue",
        type   = "RIF")
```

![](data:image/png;base64...)

Then to get the relationship between RIF1/RIF2 and differential expressed genes:

```
RIFPlot(object = out,
        color  = "darkblue",
        type   = "DE")
```

![](data:image/png;base64...)

## Enrichment plots

We provide some option to plot the results from **getEnrich** function. First of all we need to perform the enrichment analysis for a set of genes:

```
# Selecting the genes related to the network for condition 1
genes <- unique(c(as.character(NetworkData(out, "network1")[, "gene1"]),
                  as.character(NetworkData(out, "network1")[, "gene2"])))

# Performing enrichment analysis
cond1 <- getEnrich(genes = genes, organismDB = org.Hs.eg.db,
                  keyType = 'ENSEMBL', ont = 'BP', fdrMethod = "BH",
                  fdrThr = 0.05, minGSSize = 5, maxGSSize = 500)
```

After performing the enrichment analysis we have 4 options for viewing this data:

### Heatmap-like functional classification

```
heatPlot(res = cond1$results,
         diff = getDE(out, "all"))
```

![](data:image/png;base64...)

### Circle Barplot

```
enrichPlot(res = cond1$results,
           type = "circle")
```

```
## Warning in fortify(data, ...): Arguments in `...` must be used.
## ✖ Problematic argument:
## • colour = enrichmentRatio
## ℹ Did you misspell an argument name?
```

![](data:image/png;base64...)

### Barplot

```
enrichPlot(res = cond1$results,
           type = "bar")
```

![](data:image/png;base64...)

### Dotplot

```
enrichPlot(res = cond1$results,
           type = "dot")
```

![](data:image/png;base64...)

# Session info

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] dplyr_1.1.4                 org.Hs.eg.db_3.22.0
##  [3] AnnotationDbi_1.72.0        knitr_1.50
##  [5] kableExtra_1.4.0            airway_1.29.0
##  [7] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [9] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [11] IRanges_2.44.0              S4Vectors_0.48.0
## [13] BiocGenerics_0.56.0         generics_0.1.4
## [15] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [17] CeTF_1.22.0
##
## loaded via a namespace (and not attached):
##   [1] splines_4.5.1                    pbdZMQ_0.3-14
##   [3] bitops_1.0-9                     ggplotify_0.1.3
##   [5] tibble_3.3.0                     R.oo_1.27.1
##   [7] RCy3_2.30.0                      ggnetwork_0.5.14
##   [9] graph_1.88.0                     XML_3.99-0.19
##  [11] lifecycle_1.0.4                  rstatix_0.7.3
##  [13] doParallel_1.0.17                lattice_0.22-7
##  [15] backports_1.5.0                  magrittr_2.0.4
##  [17] sass_0.4.10                      rmarkdown_2.30
##  [19] jquerylib_0.1.4                  yaml_2.3.10
##  [21] ggtangle_0.0.7                   cowplot_1.2.0
##  [23] DBI_1.2.3                        RColorBrewer_1.1-3
##  [25] abind_1.4-8                      purrr_1.1.0
##  [27] R.utils_2.13.0                   RCurl_1.98-1.17
##  [29] yulab.utils_0.2.1                rappdirs_0.3.3
##  [31] gdtools_0.4.4                    circlize_0.4.16
##  [33] enrichplot_1.30.0                ggrepel_0.9.6
##  [35] tidytree_0.4.6                   svglite_2.2.2
##  [37] codetools_0.2-20                 DelayedArray_0.36.0
##  [39] xml2_1.4.1                       DOSE_4.4.0
##  [41] tidyselect_1.2.1                 shape_1.4.6.1
##  [43] aplot_0.2.9                      farver_2.1.2
##  [45] base64enc_0.1-3                  jsonlite_2.0.0
##  [47] GetoptLong_1.0.5                 Formula_1.2-5
##  [49] survival_3.8-3                   iterators_1.0.14
##  [51] systemfonts_1.3.1                foreach_1.5.2
##  [53] tools_4.5.1                      treeio_1.34.0
##  [55] sna_2.8                          Rcpp_1.1.0
##  [57] glue_1.8.0                       gridExtra_2.3
##  [59] SparseArray_1.10.0               xfun_0.53
##  [61] DESeq2_1.50.0                    qvalue_2.42.0
##  [63] IRdisplay_1.1                    withr_3.0.2
##  [65] fastmap_1.2.0                    GGally_2.4.0
##  [67] caTools_1.18.3                   digest_0.6.37
##  [69] R6_2.6.1                         gridGraphics_0.5-1
##  [71] textshaping_1.0.4                colorspace_2.1-2
##  [73] Cairo_1.7-0                      GO.db_3.22.0
##  [75] gtools_3.9.5                     dichromat_2.0-0.1
##  [77] RSQLite_2.4.3                    R.methodsS3_1.8.2
##  [79] tidyr_1.3.1                      fontLiberation_0.1.0
##  [81] data.table_1.17.8                httr_1.4.7
##  [83] htmlwidgets_1.6.4                S4Arrays_1.10.0
##  [85] ggstats_0.11.0                   RJSONIO_2.0.0
##  [87] pkgconfig_2.0.3                  gtable_0.3.6
##  [89] blob_1.2.4                       ComplexHeatmap_2.26.0
##  [91] S7_0.2.0                         XVector_0.50.0
##  [93] clusterProfiler_4.18.0           htmltools_0.5.8.1
##  [95] carData_3.0-5                    fontBitstreamVera_0.1.1
##  [97] fgsea_1.36.0                     base64url_1.4
##  [99] clue_0.3-66                      scales_1.4.0
## [101] png_0.1-8                        ggfun_0.2.0
## [103] rstudioapi_0.17.1                reshape2_1.4.4
## [105] rjson_0.2.23                     uuid_1.2-1
## [107] coda_0.19-4.1                    statnet.common_4.12.0
## [109] nlme_3.1-168                     repr_1.1.7
## [111] cachem_1.1.0                     GlobalOptions_0.1.2
## [113] stringr_1.5.2                    KernSmooth_2.23-26
## [115] parallel_4.5.1                   pillar_1.11.1
## [117] grid_4.5.1                       vctrs_0.6.5
## [119] gplots_3.2.0                     ggpubr_0.6.2
## [121] car_3.1-3                        cluster_2.1.8.1
## [123] evaluate_1.0.5                   magick_2.9.0
## [125] cli_3.6.5                        locfit_1.5-9.12
## [127] compiler_4.5.1                   rlang_1.1.6
## [129] crayon_1.5.3                     ggsignif_0.6.4
## [131] labeling_0.4.3                   plyr_1.8.9
## [133] fs_1.6.6                         ggiraph_0.9.2
## [135] stringi_1.8.7                    viridisLite_0.4.2
## [137] network_1.19.0                   BiocParallel_1.44.0
## [139] Biostrings_2.78.0                lazyeval_0.2.2
## [141] GOSemSim_2.36.0                  fontquiver_0.2.1
## [143] Matrix_1.7-4                     IRkernel_1.3.2
## [145] patchwork_1.3.2                  bit64_4.6.0-1
## [147] ggplot2_4.0.0                    GenomicTools.fileHandler_0.1.5.9
## [149] KEGGREST_1.50.0                  broom_1.0.10
## [151] igraph_2.2.1                     memoise_2.0.1
## [153] snpStats_1.60.0                  bslib_0.9.0
## [155] ggtree_4.0.0                     fastmatch_1.1-6
## [157] bit_4.6.0                        ape_5.8-1
## [159] gson_0.1.0
```

# References

Cover, Thomas M, and Joy A Thomas. 2012. *Elements of Information Theory*. John Wiley & Sons.

Himes, Blanca E, Xiaofeng Jiang, Peter Wagner, Ruoxi Hu, Qiyu Wang, Barbara Klanderman, Reid M Whitaker, et al. 2014. “RNA-Seq Transcriptome Profiling Identifies Crispld2 as a Glucocorticoid Responsive Gene That Modulates Cytokine Function in Airway Smooth Muscle Cells.” *PloS One* 9 (6): e99625.

Reverter, Antonio, and Eva KF Chan. 2008. “Combining Partial Correlation and an Information Theory Approach to the Reversed Engineering of Gene Co-Expression Networks.” *Bioinformatics* 24 (21): 2491–7.

Reverter, Antonio, Nicholas J Hudson, Shivashankar H Nagaraj, Miguel Pérez-Enciso, and Brian P Dalrymple. 2010. “Regulatory Impact Factors: Unraveling the Transcriptional Regulation of Complex Traits from Expression Data.” *Bioinformatics* 26 (7): 896–904.

Shannon, Paul, Andrew Markiel, Owen Ozier, Nitin S Baliga, Jonathan T Wang, Daniel Ramage, Nada Amin, Benno Schwikowski, and Trey Ideker. 2003. “Cytoscape: A Software Environment for Integrated Models of Biomolecular Interaction Networks.” *Genome Research* 13 (11): 2498–2504.

Vaquerizas, Juan M, Sarah K Kummerfeld, Sarah A Teichmann, and Nicholas M Luscombe. 2009. “A Census of Human Transcription Factors: Function, Expression and Evolution.” *Nature Reviews Genetics* 10 (4): 252.

Wang, Kai, and Hiroki Nishida. 2015. “REGULATOR: A Database of Metazoan Transcription Factors and Maternal Factors for Developmental Studies.” *BMC Bioinformatics* 16 (1): 114.