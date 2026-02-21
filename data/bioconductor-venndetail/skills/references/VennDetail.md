# The VennDetail package

#### Kai Guo, Brett McGregor, James Porter, and Junguk Hur

#### 2025-10-30

**VennDetail** An R package for visualizing and extracting details of multi-sets intersection

## 1. Introduction

Visualizing and extracting unique (disjoint) or overlapping subsets of multiple gene datasets are a frequently performed task for bioinformatics. Although various packages and web applications are available, no R package offering functions to extract and combine details of these subsets with user datasets in data frame is available. Moreover, graphical visualization is usually limited to six or less gene datasets and a novel method is required to properly show the subset details.We have developed **VennDetail**, an R package to generate high-quality Venn-Pie charts and to allow extraction of subset details from input datasets.

## 2. Software Usage

### 2.1 Installation

The package can be installed as

```
if (!requireNamespace("BiocManager"))
    install.packages("BiocManager")
BiocManager::install("VennDetail")
```

### 2.2 Data Input

```
library(VennDetail)
data(T2DM)
```

T2DM data include three sets of differentially expressed genes (DEGs) from the publication by *Hinder et al* [1]. The three DEG datasets were obtained in three different tissues, kidney Cortex, kidney glomerula, and sciatic nerve, by comparing db/db diabetic mice and db/db mice with pioglitazone treatment. Differential expression was determined by using Cuffdiff with a false discovery rate (FDR) < 0.05.

### 2.3 Quick Tour

```
ven <- venndetail(list(Cortex = T2DM$Cortex$Entrez, SCN = T2DM$SCN$Entrez,
                    Glom = T2DM$Glom$Entrez))
```

*VennDetail* supports three different types of Venn diagram display formats

```
##traditional venn diagram
plot(ven)
```

![](data:image/png;base64...)

```
##Venn-Pie format
plot(ven, type = "vennpie")
```

```
## Warning: `select_()` was deprecated in dplyr 0.7.0.
## ℹ Please use `select()` instead.
## ℹ The deprecated feature was likely used in the VennDetail package.
##   Please report the issue at <https://github.com/guokai8/VennDetail/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: `filter_()` was deprecated in dplyr 0.7.0.
## ℹ Please use `filter()` instead.
## ℹ See vignette('programming') for more help
## ℹ The deprecated feature was likely used in the VennDetail package.
##   Please report the issue at <https://github.com/guokai8/VennDetail/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: `aes_()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`
## ℹ The deprecated feature was likely used in the VennDetail package.
##   Please report the issue at <https://github.com/guokai8/VennDetail/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

```
##Upset format
plot(ven, type = "upset")
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the VennDetail package.
##   Please report the issue at <https://github.com/guokai8/VennDetail/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

### 2.4 Main Functions

– *venndetail* uses a list of vectors as input to construct the shared or disjoint subsets *Venn* object. *venndetail* accepts a list of vector as input and returns a *Venn* object for the following analysis. Users can also use *merge* function to merge two *Venn* objects together to save time.

– *plot* generates figures with different layouts with *type* parameter. *plot* function also provides lots of parameters for users to modify the figures.

– *getSet* function provides a way to extract subsets from the main result along with any available annotations. The parameter *subset* asks the users to give the subset names to extract. It accepts a vector of subset names. Here, we will show how the DEGs shared by all three tissues as well as those that are only included by SCN tissue can be extracted.

```
## List the subsets name
detail(ven)
```

```
##      Shared    SCN_Glom Cortex_Glom        Glom  Cortex_SCN         SCN
##           8          75          80         562          68         497
##      Cortex
##         413
```

```
head(getSet(ven, subset = c("Shared", "SCN")), 10)
```

```
##    Subset Detail
## 1  Shared 229599
## 2  Shared 243385
## 3  Shared  99899
## 4  Shared  17001
## 5  Shared  18143
## 6  Shared  64136
## 7  Shared 117591
## 8  Shared  67866
## 9     SCN  68800
## 10    SCN  69784
```

– *result* function can be used to extract and export all of the subsets for further processing. We currently support two different formats of result (long and wide formats).

```
## long format: the first column lists the subsets name, and the second column
## shows the genes included in the subsets
head(result(ven))
```

```
##   Subset Detail
## 1 Shared 229599
## 2 Shared 243385
## 3 Shared  99899
## 4 Shared  17001
## 5 Shared  18143
## 6 Shared  64136
```

```
## wide format: the first column lists all the genes, the following columns
## display the groups name (three tissues) and the last column is the total
## number of the gene shared by groups.
head(result(ven, wide = TRUE))
```

```
##     Detail Cortex SCN Glom SharedSets
## 238 229599      1   1    1          3
## 258 243385      1   1    1          3
## 307  99899      1   1    1          3
## 355  17001      1   1    1          3
## 401  18143      1   1    1          3
## 468  64136      1   1    1          3
```

– *vennpie* creates a Venn-pie diagram with unique or common subsets in multiple ways such as highlighting unique or shared subsets. The following example illustrates how to show the unique subsets on the venn-pie plots.

```
vennpie(ven, any = 1, revcolor = "lightgrey")
```

![](data:image/png;base64...) The parameters *any* and *group* provide two different ways to highlight the subsets. *any* determines the subsets to show up in the number of groups (1: those included in just one group; 2: those shared by any two groups). *group* asks users to specify the subsets to be highlighted. Users may check the sets name by using *detail* function. Since the example datasets used in this vignette include only a small number of shared genes all across three sets (n=8), it may be a little hard to see the shared subset (grey), particularly in the Cortex group (the inner-most circle). .

```
vennpie(ven, log = TRUE)
```

![](data:image/png;base64...) When we have five datasets, we can use vennpie to show the sets include elements from at least four datasets. Below show the reults with five datasets as input.

```
set.seed(123)
A <- sample(1:1000, 400, replace = FALSE)
B <- sample(1:1000, 600, replace = FALSE)
C <- sample(1:1000, 350, replace = FALSE)
D <- sample(1:1000, 550, replace = FALSE)
E <- sample(1:1000, 450, replace = FALSE)
venn <- venndetail(list(A = A, B = B, C= C, D = D, E = E))
vennpie(venn, min = 4)
```

![](data:image/png;base64...) – *getFeature* allows users to combine the details of any or all subsets from the main result with users’ other datasets, containing a list of data frames, and to export the combined data as a data frame. In the following example, we will demonstrate how to add other available annotation in the input data (T2DM) such as log2FC and FDR values for the shared genes among these three tissues.

```
head(getFeature(ven, subset = "Shared", rlist = T2DM))
```

```
##   Subset Detail Cortex_Entrez Cortex_Symbol
## 1 Shared 229599        229599         Gm129
## 2 Shared 243385        243385        Gprin3
## 3 Shared  99899         99899         Ifi44
## 4 Shared  17001         17001         Ltc4s
## 5 Shared  18143         18143         Npas2
## 6 Shared  64136         64136        Sdf2l1
##                      Cortex_Annotation Cortex_log2FC Cortex_FDR SCN_Entrez
## 1                   predicted gene 129      4.851041 0.00156529     229599
## 2                GPRIN family member 3      2.588754 0.00156529     243385
## 3        interferon-induced protein 44     -2.186102 0.00156529      99899
## 4              leukotriene C4 synthase      3.916510 0.00156529      17001
## 5        neuronal PAS domain protein 2     -3.527904 0.00156529      18143
## 6 stromal cell-derived factor 2-like 1     -2.723979 0.00156529      64136
##   SCN_Symbol                       SCN_Annotation SCN_log2FC     SCN_FDR
## 1      Gm129                   predicted gene 129   3.638130 0.000772111
## 2     Gprin3                GPRIN family member 3   2.942612 0.002032400
## 3      Ifi44        interferon-induced protein 44  -2.042164 0.012997000
## 4      Ltc4s              leukotriene C4 synthase   2.852832 0.000772111
## 5      Npas2        neuronal PAS domain protein 2  -2.219165 0.015590600
## 6     Sdf2l1 stromal cell-derived factor 2-like 1  -2.092271 0.000772111
##   Glom_Entrez Glom_Symbol                      Glom_Annotation Glom_log2FC
## 1      229599       Gm129                   predicted gene 129    2.223499
## 2      243385      Gprin3                GPRIN family member 3   -2.186954
## 3       99899       Ifi44        interferon-induced protein 44   -2.146200
## 4       17001       Ltc4s              leukotriene C4 synthase    2.471602
## 5       18143       Npas2        neuronal PAS domain protein 2  -11.845227
## 6       64136      Sdf2l1 stromal cell-derived factor 2-like 1   -2.875391
##      Glom_FDR
## 1 0.025568700
## 2 0.000962798
## 3 0.000962798
## 4 0.011659400
## 5 0.000962798
## 6 0.000962798
```

– *dplot* shows the details of these subsets with bar-plot.

```
dplot(ven, order = TRUE, textsize = 4)
```

![](data:image/png;base64...)

### 2.5 Shiny web app

A shiny web application is here: [VennDetail](http://hurlab.med.und.edu/VennDetail/) Note: Only support five input datasets now ## 3 Contact information

For any questions please contact guokai8@gmail.com

## 4 Reference

[1] Hinder LM, Park M, Rumora AE, Hur J, Eichinger F, Pennathur S, Kretzler M, Brosius FC 3rd, Feldman EL.Comparative RNA-Seq transcriptome analyses reveal distinct metabolic pathways in diabetic nerve and kidney disease. *J Cell Mol Med.* 2017 Sep;21(9):2140-2152. doi: 10.1111/jcmm.13136. Epub 2017 Mar 8.