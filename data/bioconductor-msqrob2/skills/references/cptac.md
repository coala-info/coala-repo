Code

* Show All Code
* Hide All Code

# Introduction to proteomics data analysis

Lieven Clement, Oliver M. Crook

#### 30 October 2025

# 1 Introduction

Label-Free Quantitative mass spectrometry based workflows for differential expression (DE) analysis of proteins is often challenging due to peptide-specific effects and context-sensitive missingness of peptide intensities.

* `msqrob2` provides peptide-based workflows that can assess for DE directly from peptide intensities and outperform summarisation methods which first aggregate MS1 peptide intensities to protein intensities before DE analysis.
  However, they are computationally expensive, often hard to understand for the non-specialised end-user, and they do not provide protein summaries, which are important for visualisation or downstream processing.
* `msqrob2` therefore also proposes a novel summarisation strategy, which estimates MSqRob’s model parameters in a two-stage procedure circumventing the drawbacks of peptide-based workflows.
* the summarisation based workflow in `msqrob2` maintains MSqRob’s superior performance, while providing useful protein expression summaries for plotting and downstream analysis.
  Summarising peptide to protein intensities considerably reduces the computational complexity, the memory footprint and the model complexity.
  Moreover, it renders the analysis framework to become modular, providing users the flexibility to develop workflows tailored towards specific applications.

In this vignette we will demonstrate how to perform `msqrob`’s summarisation based workflow starting from a Maxquant search on a subset of the cptac spike-in study.

Examples on our peptide-based workflows and on the analysis of more complex designs can be found on our companion website [msqrob2Examples](https://statomics.github.io/msqrob2Examples).

Technical details on our methods can be found in (Goeminne, Gevaert, and Clement [2016](#ref-goeminne2016)), (Goeminne et al. [2020](#ref-goeminne2020)) and (Sticker et al. [2020](#ref-sticker2020)).

# 2 Background

This case-study is a subset of the data of the 6th study of the Clinical
Proteomic Technology Assessment for Cancer (CPTAC).
In this experiment, the authors spiked the Sigma Universal Protein Standard
mixture 1 (UPS1) containing 48 different human proteins in a protein background
of 60 ng/\(\mu\)L Saccharomyces cerevisiae strain BY4741.
Two different spike-in concentrations were used:
6A (0.25 fmol UPS1 proteins/\(\mu\)L) and 6B (0.74 fmol UPS1 proteins/\(\mu\)L) [5].
We limited ourselves to the data of LTQ-Orbitrap W at site 56.
The data were searched with MaxQuant version 1.5.2.8, and
detailed search settings were described in Goeminne et al. (2016) [1].
Three replicates are available for each concentration.

# 3 Data

We first import the data from peptideRaws.txt file. This is the file containing
your peptideRaw-level intensities. For a MaxQuant search [6],
this peptideRaws.txt file can be found by default in the
“path\_to\_raw\_files/combined/txt/” folder from the MaxQuant output,
with “path\_to\_raw\_files” the folder where the raw files were saved.
In this vignette, we use a MaxQuant peptideRaws file which is a subset
of the cptac study. This data is available in the `MsDataHub` package.
To import the data we use the `QFeatures` package.

We generate the object peptideRawFile with the path to the peptideRaws.txt file.
We find the columns that contain the expression
data of the peptideRaws in the peptideRaws.txt file using the `grep` function and we search for the pattern `Intensity\\.`, which will return the position of the columns that include `Intensity.` in their column name, which is the convention by MaxQuant.

```
library(tidyverse)
library(limma)
library(QFeatures)
library(msqrob2)
library(plotly)
library(gridExtra)

peptides <- read.delim(MsDataHub::cptac_a_b_peptides.txt())
ecols <- grep("Intensity\\.", colnames(peptides))
pe <- readQFeatures(
    assayData = peptides, fnames = "Sequence", quantCols = ecols,
    name = "peptideRaw", sep = "\t"
)
```

In the following code chunk, we can extract the spikein condition from the raw file name.

```
cond <- which(strsplit(colnames(pe)[[1]][1], split = "")[[1]] == "A") # find where condition is stored
colData(pe)$condition <- substr(colnames(pe), cond, cond) %>%
    unlist() %>%
    as.factor()
```

We calculate how many non zero intensities we have per peptide and this
will be useful for filtering.

```
rowData(pe[["peptideRaw"]])$nNonZero <- rowSums(assay(pe[["peptideRaw"]]) > 0)
```

Peptides with zero intensities are missing peptides and should be represent
with a `NA` value rather than `0`.

```
pe <- zeroIsNA(pe, "peptideRaw") # convert 0 to NA
```

## 3.1 Data exploration

We can inspect the missingness in our data with the `plotNA()` function
provided with `MSnbase`.
45% of all peptide
intensities are missing and for some peptides we do not even measure a signal
in any sample. The missingness is similar across samples.

```
MSnbase::plotNA(assay(pe[["peptideRaw"]])) +
    xlab("Peptide index (ordered by data completeness)")
```

```
## Warning: The `size` argument of `element_rect()` is deprecated as of ggplot2 3.4.0.
## ℹ Please use the `linewidth` argument instead.
## ℹ The deprecated feature was likely used in the MSnbase package.
##   Please report the issue at <https://github.com/lgatto/MSnbase/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)![](data:image/png;base64...)

# 4 Preprocessing

This section preforms standard preprocessing for the peptide data. This
include log transformation, filtering and summarisation of the data.

## 4.1 Log transform the data

```
pe <- logTransform(pe, base = 2, i = "peptideRaw", name = "peptideLog")
limma::plotDensities(assay(pe[["peptideLog"]]))
```

![](data:image/png;base64...)

## 4.2 Filtering

### 4.2.1 Handling overlapping protein groups

In our approach a peptide can map to multiple proteins, as long as there is
none of these proteins present in a smaller subgroup.

```
Protein_filter <- rowData(pe[["peptideLog"]])$Proteins %in% smallestUniqueGroups(rowData(pe[["peptideLog"]])$Proteins)
pe <- pe[Protein_filter,,]
```

### 4.2.2 Remove reverse sequences (decoys) and contaminants

We now remove the contaminants, peptides that map to decoy sequences, and proteins
which were only identified by peptides with modifications.

```
pe <- filterFeatures(pe, ~ Reverse != "+")
```

```
## 'Reverse' found in 2 out of 2 assay(s).
```

```
pe <- filterFeatures(pe, ~ Potential.contaminant != "+")
```

```
## 'Potential.contaminant' found in 2 out of 2 assay(s).
```

### 4.2.3 Remove peptides of proteins that were only identified with modified peptides

I will skip this step for the moment. Large protein groups file needed for this.

### 4.2.4 Drop peptides that were only identified in one sample

We keep peptides that were observed at last twice.

```
pe <- filterFeatures(pe, ~ nNonZero >= 2)
```

```
## 'nNonZero' found in 2 out of 2 assay(s).
```

```
nrow(pe[["peptideLog"]])
```

```
## [1] 7011
```

We keep 7011 peptides after filtering.

## 4.3 Normalize the data by median centering

```
pe <- normalize(pe,
    i = "peptideLog",
    name = "peptideNorm",
    method = "center.median"
)
```

## 4.4 Explore normalized data

After normalisation the density curves for all samples are registered.

```
limma::plotDensities(assay(pe[["peptideNorm"]]))
```

![](data:image/png;base64...)

This is even more clear in a boxplot.

```
boxplot(assay(pe[["peptideNorm"]]),
    col = palette()[-1],
    main = "Peptide distribtutions after normalisation", ylab = "intensity"
)
```

![](data:image/png;base64...)

We can visualize our data using a Multi Dimensional Scaling plot,
eg. as provided by the `limma` package.

```
limma::plotMDS(assay(pe[["peptideNorm"]]), col = as.numeric(colData(pe)$condition))
```

![](data:image/png;base64...)

The first axis in the plot is showing the leading log fold changes
(differences on the log scale) between the samples.
We notice that the leading differences (log FC)
in the peptideRaw data seems to be driven by technical variability.
Indeed, the samples do not seem to be clearly separated according
to the spike-in condition.

## 4.5 Summarization to protein level

We use the standard sumarisation in aggregateFeatures, which is a
robust summarisation method.

```
pe <- aggregateFeatures(pe,
    i = "peptideNorm", fcol = "Proteins", na.rm = TRUE,
    name = "protein"
)
```

```
## Your quantitative and row data contain missing values. Please read the
## relevant section(s) in the aggregateFeatures manual page regarding the
## effects of missing values on data aggregation.
```

```
##
Aggregated: 1/1
```

We notice that the leading differences (log FC) in the protein data are still
according to technical variation. On the second dimension; however, we also observe
a clear separation according to the spike-in condition. Hence, the summarization
that accounts for peptide specific effects makes the effects due
to the spike-in condition more prominent!

```
plotMDS(assay(pe[["protein"]]), col = as.numeric(colData(pe)$condition))
```

![](data:image/png;base64...)

# 5 Data Analysis

## 5.1 Estimation

We model the protein level expression values using `msqrob`.
By default `msqrob2` estimates the model parameters using robust regression.

```
pe <- msqrob(object = pe, i = "protein", formula = ~condition)
```

## 5.2 Inference

First, we extract the parameter names of the model.

```
getCoef(rowData(pe[["protein"]])$msqrobModels[[1]])
```

```
## (Intercept)  conditionB
##   -2.672396    1.513682
```

Spike-in condition a is the reference class. So the mean log2 expression
for samples from condition a is ‘(Intercept).
The mean log2 expression for samples from condition B is’(Intercept)+conditionB’.
Hence, the average log2 fold change between condition b and
condition a is modelled using the parameter ‘conditionB’.
Thus, we assess the contrast ‘conditionB=0’ with our statistical test.

```
L <- makeContrast("conditionB=0", parameterNames = c("conditionB"))
pe <- hypothesisTest(object = pe, i = "protein", contrast = L)
```

## 5.3 Plots

### 5.3.1 Volcano-plot

```
volcano <- ggplot(
    rowData(pe[["protein"]])$conditionB,
    aes(x = logFC, y = -log10(pval), color = adjPval < 0.05)
) +
    geom_point(cex = 2.5) +
    scale_color_manual(values = alpha(c("black", "red"), 0.5)) +
    theme_minimal() +
    ggtitle("Default workflow")
volcano
```

![](data:image/png;base64...)

### 5.3.2 Heatmap

We first select the names of the proteins that were declared signficant.

```
sigNames <- rowData(pe[["protein"]])$conditionB %>%
    rownames_to_column("protein") %>%
    filter(adjPval < 0.05) %>%
    pull(protein)
heatmap(assay(pe[["protein"]])[sigNames, ])
```

![](data:image/png;base64...)

# 6 Detail plots

We first extract the normalized peptideRaw expression values for a particular protein.
With respect to the vignette file size, we only make detail plots for the top 5 DE proteins.

```
topN <- 5
if (length(sigNames) > topN) {
    for (protName in sigNames[1:topN])
    {
        pePlot <- pe[protName, , c("peptideNorm", "protein")]
        pePlotDf <- data.frame(longForm(pePlot))
        pePlotDf$assay <- factor(pePlotDf$assay,
            levels = c("peptideNorm", "protein")
        )
        pePlotDf$condition <- as.factor(colData(pePlot)[pePlotDf$colname, "condition"])

        # plotting
        p1 <- ggplot(
            data = pePlotDf,
            aes(x = colname, y = value, group = rowname)
        ) +
            geom_line() +
            geom_point() +
            theme_minimal() +
            facet_grid(~assay) +
            ggtitle(protName)
        print(p1)

        # plotting 2
        p2 <- ggplot(pePlotDf, aes(x = colname, y = value, fill = condition)) +
            geom_boxplot(outlier.shape = NA) +
            geom_point(
                position = position_jitter(width = .1),
                aes(shape = rowname)
            ) +
            scale_shape_manual(values = 1:nrow(pePlotDf)) +
            labs(title = protName, x = "sample", y = "peptide intensity (log2)") +
            theme_minimal()
        facet_grid(~assay)
        print(p2)
    }
}
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

# 7 Comparison with other workflows

## 7.1 Median summarisation

```
pe <- aggregateFeatures(pe,
    i = "peptideNorm", fcol = "Proteins", na.rm = TRUE,
    name = "proteinMedian", fun = matrixStats::colMedians
)
```

```
## Your quantitative and row data contain missing values. Please read the
## relevant section(s) in the aggregateFeatures manual page regarding the
## effects of missing values on data aggregation.
```

```
##
Aggregated: 1/1
```

```
pe <- msqrob(object = pe, i = "proteinMedian", formula = ~condition)
pe <- hypothesisTest(object = pe, i = "proteinMedian", contrast = L)
```

### 7.1.1 MDS plot

```
limma::plotMDS(assay(pe[["proteinMedian"]]),
    col = as.numeric(colData(pe)$condition)
)
```

![](data:image/png;base64...)

Note, that upon median summarisation the separation between
the samples according to the spike-in condition is much less clear
than when using robust summarisation. This is because median summarisation
does not account for a differences in observed peptides per protein.
Indeed, for DE proteins more peptides will go missing in the low spike-in
condition a.

### 7.1.2 Volcano-plots

```
volcanoMed <- rowData(pe[["proteinMedian"]])[[colnames(L)]] %>%
    ggplot(aes(x = logFC, y = -log10(pval), color = adjPval < 0.01)) +
    geom_point(cex = 2.5) +
    scale_color_manual(values = alpha(c("black", "red"), 0.5)) +
    theme_minimal() +
    geom_vline(xintercept = log2(0.74 / .25), col = "red") +
    ggtitle("median summarisation")
```

## 7.2 Robust summarisation followed by robust ridge regression

msqrob2 can also be used to adopt parameter estimation using robust ridge regression by setting the argument ‘ridge=TRUE’.
The performance of ridge regression generally improves for more complex designs with multiple conditions.

Note, that the parameter names for ridge regression always start with the string “ridge”.

```
try(pe <- msqrob(
    object = pe, i = "protein", formula = ~condition,
    modelColumnName = "ridge", ridge = TRUE
)) # note: intentional error
```

```
## Warning: 'experiments' dropped; see 'drops()'
```

```
## Error : BiocParallel errors
##   4 remote errors, element index: 1, 349, 697, 1045
##   1385 unevaluated and other errors
##   first remote error:
## Error in FUN(...): The mean model must have more than two parameters for ridge regression.
##               if you really want to adopt ridge regression when your factor has only two levels
##               rerun the function with a formula where you drop the intercept. e.g. ~-1+condition
##
```

Note, that by default ridge regression does not work for two group comparisons
because it typically performs better the more parameters there are in the mean model
(more complex designs). However, we can force ridge regression in a two
group comparison using a formula without intercept.

```
pe <- msqrob(
    object = pe, i = "protein", formula = ~ -1 + condition,
    modelColumnName = "ridge", ridge = TRUE
)
Lridge <- makeContrast(
    "ridgeconditionB - ridgeconditionA = 0",
    c("ridgeconditionB", "ridgeconditionA")
)
pe <- hypothesisTest(
    object = pe, i = "protein", contrast = Lridge,
    modelColumn = "ridge"
)
```

### 7.2.1 Volcano-plot

```
volcanoRidge <- rowData(pe[["protein"]])[[colnames(Lridge)]] %>%
    ggplot(aes(
        x = logFC, y = -log10(pval),
        color = adjPval < 0.01
    )) +
    geom_point(cex = 2.5) +
    scale_color_manual(values = alpha(c("black", "red"), 0.5)) +
    theme_minimal() +
    geom_vline(xintercept = log2(0.74 / 0.25), col = "red") +
    ggtitle(paste("robust ridge"))
```

# 8 Comparison of performance

Because we are analysing a spike-in study we know the ground truth,
i.e. we know that only the spike-in proteins (UPS proteins) are differentially expressed.

We first add the ground truth data to the rowData of the object.

```
rowData(pe[["protein"]])$ups <- grepl("UPS", rownames(pe[["protein"]]))
rowData(pe[["proteinMedian"]])$ups <- grepl("UPS", rownames(pe[["proteinMedian"]]))
```

## 8.1 Volcano plots

```
grid.arrange(grobs = list(volcano, volcanoMed, volcanoRidge), ncol = 1)
```

```
## Warning: Removed 167 rows containing missing values or values outside the scale range
## (`geom_point()`).
```

```
## Warning: Removed 166 rows containing missing values or values outside the scale range
## (`geom_point()`).
```

```
## Warning: Removed 111 rows containing missing values or values outside the scale range
## (`geom_point()`).
```

![](data:image/png;base64...)

* Less proteins are found to be DE upon median summarisation. It is indeed important that the summarisation accounts for properties of the different peptides of a protein that are present in the different samples.
* The volcano plot opens up and that the dots are more tight.
  The DE proteins are also around the real fold change of the spiked proteins.

## 8.2 log2 Fold Change Estimation

```
logFC <- data.frame(
    default = rowData(pe[["protein"]])[[colnames(L)]][, 1],
    median = rowData(pe[["proteinMedian"]])[[colnames(L)]][, 1],
    ridge = rowData(pe[["protein"]])[[colnames(Lridge)]][, 1],
    ups = rowData(pe[["protein"]])$ups
)

logFC <- logFC %>% gather(method, log2FC, c("default", "median", "ridge"))
logFC$ups <- as.factor(logFC$ups)
logFC %>% ggplot(aes(x = method, y = log2FC, fill = ups)) +
    geom_boxplot() +
    geom_hline(yintercept = log2(0.74 / .25), color = "red")
```

```
## Warning: Removed 444 rows containing non-finite outside the scale range
## (`stat_boxplot()`).
```

![](data:image/png;base64...)

Note, that methods based on robust summarisation (default and ridge) have
unbiased fold change estimates for both the ecoli (real log2 FC = 0)
and spiked UPS proteins
(real log2 FC = 1.57 red horizontal line).
Ridge regression provides a strong shrinkage of the fold change
estimates of the non-DE (ecoli) proteins towards zero.

Median summarisation returns biased fold changes for the spiked UPS proteins.
This is because peptides of the ups proteins that do not fly well through
the mass spec are typically missing in the low spike-in condition.
Hence, the protein estimates for condition a are typically overestimated
and for condition b underestimated leading to an underestimation
of the fold change. The default robust summarisation uses a peptide
based model to summarise the data, which estimates the protein expression
value while correcting for the peptide.

## 8.3 Sensitivity FDP Plots

Because we are analysing a spike-in study we know the ground truth,
i.e. we know that only the spike-in proteins (UPS proteins)
are differentially expressed. We can therefore evaluate the performance
of the method, i.e. we will assess - the sensitivity or true positive rate (TPR),
the proportion of actual positives that are correctly identified, in the
protein list that we return \[TPR=\frac{TP}{\text{#actual positives}},\]
here TP are the true positives in the list.
The TPR is thus the fraction of ups proteins that we can recall.

* false discovery proportion (FPD): fraction of false positives in the
  protein list that we return: \[FPD=\frac{FP}{FP+TP},\]
  with FP the false positives. In our case the yeast proteins that are in our list.

Instead, of only calculating that for the protein list that is returned
for the chosen FDR level, we can do this for all possible FDR cutoffs
so that we get an overview of the quality of the ranking of the proteins
in the protein list.

Function to calculate TPR and FDP

```
tprFdp <- function(pval, tp, adjPval) {
    ord <- order(pval)
    return(data.frame(
        pval = pval[ord],
        adjPval = adjPval[ord],
        tpr = cumsum(tp[ord]) / sum(tp),
        fdp = cumsum(!tp[ord]) / 1:length(tp)
    ))
}
```

```
tprFdpDefault <- tprFdp(
    rowData(pe[["protein"]])[[colnames(L)]]$pval,
    rowData(pe[["protein"]])$ups,
    rowData(pe[["protein"]])[[colnames(L)]]$adjPval
)
tprFdpMedian <- tprFdp(
    rowData(pe[["proteinMedian"]])[[colnames(L)]]$pval,
    rowData(pe[["proteinMedian"]])$ups,
    rowData(pe[["proteinMedian"]])[[colnames(L)]]$adjPval
)

tprFdpRidge <- tprFdp(
    rowData(pe[["protein"]])[[colnames(Lridge)]]$pval,
    rowData(pe[["protein"]])$ups,
    rowData(pe[["protein"]])[[colnames(Lridge)]]$adjPval
)

hlp <- rbind(
    cbind(tprFdpDefault, method = "default"),
    cbind(tprFdpMedian, method = "median"),
    cbind(tprFdpRidge, method = "ridge")
)
tprFdpPlot <- hlp %>%
    ggplot(aes(x = fdp, y = tpr, color = method)) +
    geom_path()
tprFdpPlot
```

![](data:image/png;base64...)

Ridge regression does not seem to improve the performance in two-group
comparisons. By default the ridge regression workflow returns an error message
if the model only has two fixed effect parameters, e.g. “(intercept)” and parameter “conditionB”.
In the vignette of a large spike-in study with multiple spike-in conditions
we illustrate the benefit of ridge regression when dealing with more complex experiments.

# 9 Additional Examples

On our companion website [msqrob2Examples](https://statomics.github.io/msqrob2Examples)
you can find:

* Examples with all msqrob2 workflows
* Examples with more complex designs
* Code to assess proteins with fit-errors due to missing values
* …

Details to the methods and workflows in `msqrob2` can be found in
(Goeminne, Gevaert, and Clement [2016](#ref-goeminne2016)), (Goeminne et al. [2020](#ref-goeminne2020)) and (Sticker et al. [2020](#ref-sticker2020)).

Please refer to these papers when you use our tools.

# References

Goeminne, L. J. E., A. Sticker, L. Martens, K. Gevaert, and L. Clement. 2020. “MSqRob Takes the Missing Hurdle: Uniting Intensity- and Count-Based Proteomics.” *Anal Chem* 92 (9): 6278–87.

Goeminne, L. J., K. Gevaert, and L. Clement. 2016. “Peptide-level Robust Ridge Regression Improves Estimation, Sensitivity, and Specificity in Data-dependent Quantitative Label-free Shotgun Proteomics.” *Mol Cell Proteomics* 15 (2): 657–68.

Sticker, A., L. Goeminne, L. Martens, and L. Clement. 2020. “Robust Summarization and Inference in Proteome-wide Label-free Quantification.” *Mol Cell Proteomics* 19 (7): 1209–19.