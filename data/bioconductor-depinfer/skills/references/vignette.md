# Use DepInfeR package to infer sample-specific protein dependencies from drug-protein profiling and ex-vivo drug response data

Alina Batzilla, Junyan Lu

#### 29 October 2025

#### Package

DepInfeR 1.14.0

# Contents

* [1 Installation](#installation)
* [2 Introduction](#introduction)
* [3 Data input](#data-input)
* [4 Pre-processing the drug-protein dataset](#pre-processing-the-drug-protein-dataset)
* [5 Preparation of the drug response matrix](#preparation-of-the-drug-response-matrix)
  + [5.1 Prepare drug response matrix using z-scores](#prepare-drug-response-matrix-using-z-scores)
  + [5.2 Assessment of missing values](#assessment-of-missing-values)
  + [5.3 Subset for cell lines with less than 24 missing values (based on assessment above)](#subset-for-cell-lines-with-less-than-24-missing-values-based-on-assessment-above)
  + [5.4 MissForest imputation](#missforest-imputation)
  + [5.5 Calculate column-wise z-score](#calculate-column-wise-z-score)
* [6 Combine the feature and response matrix for the regression model](#combine-the-feature-and-response-matrix-for-the-regression-model)
* [7 Multivariate model for protein dependence prediction](#multivariate-model-for-protein-dependence-prediction)
  + [7.1 Multi-target LASSO model](#multi-target-lasso-model)
* [8 Examples of how to interpret and perform downstream analyses on the inferred protein dependence matrix](#examples-of-how-to-interpret-and-perform-downstream-analyses-on-the-inferred-protein-dependence-matrix)
  + [8.1 Heatmap of protein dependence coefficients](#heatmap-of-protein-dependence-coefficients)
  + [8.2 Differential dependence on proteins associated with cancer types and genotypes](#differential-dependence-on-proteins-associated-with-cancer-types-and-genotypes)
  + [8.3 Visualize protein associations with cancer type](#visualize-protein-associations-with-cancer-type)
  + [8.4 Visualize P-values of significant associations between protein dependence and mutational background](#visualize-p-values-of-significant-associations-between-protein-dependence-and-mutational-background)
  + [8.5 Boxplot visualization for the difference of target importance values](#boxplot-visualization-for-the-difference-of-target-importance-values)
* [9 Session info](#session-info)

```
set.seed(123)
library(DepInfeR)
library(tibble)
library(tidyr)
library(ggplot2)
library(BiocParallel)
library(dplyr)
```

---

# 1 Installation

The DepInfeR package is available at bioconductor.org and can be downloaded via Bioc Manager:

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}
BiocManager::install("DepInfeR")
```

# 2 Introduction

DepInfeR is an R package for a computational method that integrates two experimentally accessible input data matrices: the drug sensitivity profiles of cancer cell lines or primary tumors *ex-vivo* (X), and the drug affinities of a set of proteins (Y), to infer a matrix of molecular protein dependencies of the cancers (ß). DepInfeR deconvolutes the protein inhibition effect on the viability phenotype by using regularized multivariate linear regression. It assigns a “dependence coefficient” to each protein and each sample, and therefore could be used to gain a causal and accurate understanding of functional consequences of genomic aberrations in a heterogeneous disease, as well as to guide the choice of pharmacological intervention for a specific cancer type, sub-type, or an individual patient.

This document provides a walk-through of using the **DepInfeR** package to infer sample-specific protein dependencies from drug-protein affinity profiling and *ex-vivo* drug response data.

For more information, please read out preprint on bioRxiv: <https://doi.org/10.1101/2022.01.11.475864>.

# 3 Data input

As inputs, DepInfeR requires two types of data:
1) a drug-protein affinity profiling dataset containing affinity values between a set of drugs and a set of proteins, and
2) a drug response dataset containing phenotypic data (e.g. viability measurements) of samples in response to a set of drugs.

In this exemplary walk-through analysis we use
1) drug-protein affinity data from Klaeger et al. 2017, which can be found in the supplementary file of the paper (Table\_S1 & Table\_S2):
<https://science.sciencemag.org/content/358/6367/eaan4368/tab-figures-data>, and
2) drug response data from the Genomics of Drug Sensitivity in Cancer (GDSC) cancer cell line screening dataset: <https://www.cancerrxgene.org/>.

A subset of leukemia and breast cancer cell lines was chosen for this analysis. The analyzed cancer types were.

* Diffuse Large B-Cell Lymphoma (DLBC)
* Acute lymphocytic leukemia (ALL)
* Acute myeloid leukemia (AML)
* Breast carcinoma (BRCAHer+ / BRCAHer-)

The Her2 status of the breast cancer cell lines was annotated manually.

Genetic background of the cancer cell lines was annotated with their mutational background.
The mutational background of the cell lines was retrieved from <https://www.cancerrxgene.org/downloads/genetic_features>.

This analysis starts with the two data tables that contain the common drugs in both drug-target affinity and drug sensitivity datasets.

```
data(targetsGDSC, drug_response_GDSC)
```

A glance at the drug-target affinity table

```
head(targetsGDSC)
```

```
## # A tibble: 6 × 6
##   drugName drugID targetClassification    EC50      Kd targetName
##   <chr>     <dbl> <chr>                  <dbl>   <dbl> <chr>
## 1 afatinib   1032 High confidence      3493.   3493.   ADK
## 2 afatinib   1032 High confidence         3.01    2.39 EGFR
## 3 afatinib   1032 High confidence      3154.   1771.   GAK
## 4 afatinib   1032 High confidence      3828.   2388.   GRB2
## 5 afatinib   1032 High confidence      3884.   2811.   MAPK11
## 6 afatinib   1032 High confidence      2044.   1047.   MAPK14
```

A glance at the drug sensitivity table

```
head(drug_response_GDSC)
```

```
## # A tibble: 6 × 14
##   Drug      `Drug Id` `Cell line name` `Cosmic sample Id` `TCGA classification`
##   <chr>         <dbl> <chr>                         <dbl> <chr>
## 1 erlotinib         1 CCRF-CEM                     905952 ALL
## 2 erlotinib         1 MOLT-4                       905958 ALL
## 3 erlotinib         1 BE-13                        906763 ALL
## 4 erlotinib         1 GR-ST                        906877 ALL
## 5 erlotinib         1 KARPAS-45                    907272 ALL
## 6 erlotinib         1 KE-37                        907277 ALL
## # ℹ 9 more variables: Tissue <chr>, `Tissue sub-type` <chr>, IC50 <dbl>,
## #   AUC <dbl>, `Max conc` <dbl>, RMSE <dbl>, `Z score` <dbl>,
## #   `Dataset version` <chr>, synonyms <chr>
```

---

# 4 Pre-processing the drug-protein dataset

We first need to do some pre-processing of both datasets, to turn them into numeric matrices that can be used as inputs for DepInfeR.

Rename BCR to BCR/ABL to avoid confusion with B-cell receptor (BCR)

```
targetsGDSC <- mutate(targetsGDSC,
  targetName = ifelse(targetName %in% "BCR", "BCR/ABL", targetName)
)
```

Turn target table into drug-protein affinity matrix

```
targetMatrix <- filter(
  targetsGDSC,
  targetClassification == "High confidence"
) %>%
  select(drugID, targetName, Kd) %>%
  pivot_wider(names_from = "targetName", values_from = "Kd") %>%
  remove_rownames() %>%
  column_to_rownames("drugID") %>%
  as.matrix()
```

We provide a function, *ProcessTargetResults*, for the pre-processing of the drug-protein affinity matrix with Kd values (or optionally other affinity measurement values at roughly normal distribution). This function can perform the following steps:

* log-transform Kd values (KdAsInput = TRUE)
* arctan-transform log(Kd) values (KdAsInput = TRUE)
* check target similarity and remove highly correlated targets (removeCorrelated = TRUE)

All steps within this function are optional depending on input data. The transformation steps should be performed if the affinity matrix consists of Kd values. If there are highly correlated features within the affinity matrix, they can be removed using the provided function. The users can also use their own method to preprocess the input drug-target affinity matrix, as long as the distribution of the affinity values is roughly normal and do not have too many highly correlated features.

```
ProcessTargetResults <- processTarget(targetMatrix,
  KdAsInput = TRUE,
  removeCorrelated = TRUE
)
```

# 5 Preparation of the drug response matrix

## 5.1 Prepare drug response matrix using z-scores

The z-score was chosen as a suitable measurement value for our drug screening response matrix as it acts as normalization for each drug over all cell lines. When working with AUC or IC50 values, a suitable normalization of the values is recommended.
In this analysis we used the z-score of the AUC values as the drug response input for DepInfeR.

```
responseMatrix <- filter(drug_response_GDSC, `Drug Id` %in% targetsGDSC$drugID) %>%
  select(`Drug Id`, `Cell line name`, AUC) %>%
  pivot_wider(names_from = `Cell line name`, values_from = AUC) %>%
  remove_rownames() %>%
  column_to_rownames("Drug Id") %>%
  as.matrix()
```

## 5.2 Assessment of missing values

Currently, DepInfeR does not support input data with missing values. Therefore, the missing values in the input datasets need to be properly handled. The entries with missing values can either be removed or imputed.

We firstly check the distribution of our missing values across all cell lines. Below is the plot of remaining cell lines depending on cutoff for the maximum number of missing values per column (cell line).

```
missTab <- data.frame(
  NA_cutoff = 0,
  remain_celllines = 0, stringsAsFactors = FALSE
)

for (i in 0:138) {
  a <- dim(responseMatrix[, colSums(is.na(responseMatrix)) <= i])[2]
  missTab[i, ] <- c(i, a)
}

ggplot(missTab, aes(x=NA_cutoff, y=remain_celllines)) +
    geom_line() + theme_bw() +
    xlab("Allowed NA values") +
    ylab("Number of remaining cell lines") +
    geom_vline(xintercept = 24, color = "red", linetype = "dashed")
```

![This figure shows the number of cell lines included in the analysis as a function of the percentage of missing values allowed per cell line.](data:image/png;base64...)

Figure 1: This figure shows the number of cell lines included in the analysis as a function of the percentage of missing values allowed per cell line

In order to keep as many cell lines as possible while reducing the missing data points, we chose one of the elbow points (x=24, shown as the red dashed line) in the plot above as the cut-off for allowed missing values. We will impute the remaining missing values by using the MissForest imputation method.

## 5.3 Subset for cell lines with less than 24 missing values (based on assessment above)

```
responseMatrix <- responseMatrix[, colSums(is.na(responseMatrix)) <= 24]
```

## 5.4 MissForest imputation

```
library(missForest)

impRes <- missForest(t(responseMatrix))
imp_missforest <- impRes$ximp

responseMatrix_imputed <- t(imp_missforest)
```

## 5.5 Calculate column-wise z-score

```
responseMatrix_scaled <- t(scale(t(responseMatrix_imputed)))
```

# 6 Combine the feature and response matrix for the regression model

In this step, we will also subset the drug-target affinity matrix and the drug response matrix to only keep the drugs present in both matrices.

```
targetInput <- ProcessTargetResults$targetMatrix

overlappedDrugs <- intersect(
  rownames(responseMatrix_scaled),
  rownames(targetInput)
)

targetInput <- targetInput[overlappedDrugs, ]
responseInput <- responseMatrix_scaled[overlappedDrugs, ]
```

---

# 7 Multivariate model for protein dependence prediction

## 7.1 Multi-target LASSO model

Perform multivariate LASSO regression based on a drug-protein affinity matrix and a drug response matrix.

```
#set up BiocParallel back-end
param <- MulticoreParam(workers = 2, RNGseed = 333)

result <- runLASSORegression(
  TargetMatrix = targetInput,
  ResponseMatrix = responseInput, repeats = 3,
  BPPARAM = param
)
```

Remove targets that were never selected

```
useTar <- rowSums(result$coefMat != 0) > 0
result$coefMat <- result$coefMat[useTar, ]
```

Number of selected targets

```
nrow(result$coefMat)
```

```
## [1] 22
```

# 8 Examples of how to interpret and perform downstream analyses on the inferred protein dependence matrix

## 8.1 Heatmap of protein dependence coefficients

The protein dependence matrix can be visualized in a heatmap. High positive coefficients imply strong reliance of a certain sample on this protein for survival. Proteins with coefficients close to zero are less essential for the survival of cells. Negative coefficients indicate that the viability phenotype benefits from inhibition of the protein.

```
library(RColorBrewer)
library(pheatmap)

# firstly, we need to load the processed mutation annotation of the cell lines
data("mutation_GDSC")

#setup column annotation and color scheme
annoColor <- list(
  H2O2 = c(`-1` = "red", `0` = "black", `1` = "green"),
  IL.1 = c(`-1` = "red", `0` = "black", `1` = "green"),
  JAK.STAT = c(`-1` = "red", `0` = "black", `1` = "green"),
  MAPK.only = c(`-1` = "red", `0` = "black", `1` = "green"),
  MAPK.PI3K = c(`-1` = "red", `0` = "black"),
  TLR = c(`-1` = "red", `0` = "black", `1` = "green"),
  Wnt = c(`-1` = "red", `0` = "black", `1` = "green"),
  VEGF = c(`-1` = "red", `0` = "black", `1` = "green"),
  PI3K.only = c(`-1` = "red", `0` = "black", `1` = "green"),
  TCGA.classification =
    c(
      ALL = "#BC3C29FF", AML = "#E18727FF",
      DLBC = "#20854EFF", "BRCAHer-" = "#0072B5FF",
      "BRCAHer+" = "#7876B1FF"
    ),
  ARID1A_mut = c(`1` = "black", `0` = "grey80"),
  EP300_mut = c(`1` = "black", `0` = "grey80"),
  PTEN_mut = c(`1` = "black", `0` = "grey80"),
  TP53_mut = c(`1` = "black", `0` = "grey80"),
  PIK3CA_mut = c(`1` = "black", `0` = "grey80"),
  BRCA2_mut = c(`1` = "black", `0` = "grey80"),
  BRCA1_mut = c(`1` = "black", `0` = "grey80"),
  CDH1_mut = c(`1` = "black", `0` = "grey80"),
  FBXW7_mut = c(`1` = "black", `0` = "grey80"),
  NRAS_mut = c(`1` = "black", `0` = "grey80"),
  ASXL1_mut = c(`1` = "black", `0` = "grey80"),
  MLL2_mut = c(`1` = "black", `0` = "grey80"),
  ABL1_trans = c(`1` = "black", `0` = "grey80"),
  missing_value_perc = c(`0` = "white", `25` = "red")
)
importanceTab <- result$coefMat
#change "-" to "." in the column name to match cell line annotation
colnames(importanceTab) <- gsub("-",".", colnames(importanceTab),)
plotTab <- importanceTab
# Row normalization while keeping sign
plotTab_scaled <- scale(t(plotTab), center = FALSE, scale = TRUE)
plotTab <- plotTab_scaled
mutation_GDSC$TCGA.classification[mutation_GDSC$TCGA.classification == "BRCA"] <- "BRCAHer-"
mutation_GDSC$TCGA.classification <-
  factor(mutation_GDSC$TCGA.classification,
    levels = c("ALL", "AML", "DLBC", "BRCAHer-", "BRCAHer+")
  )
pheatmap(plotTab,
  color = colorRampPalette(rev(brewer.pal(n = 7, name = "RdBu")),
    bias = 1.8
  )(100),
  annotation_row = mutation_GDSC,
  annotation_colors = annoColor,
  clustering_method = "ward.D2", scale = "none",
  main = "", fontsize = 9,
  fontsize_row = 7, fontsize_col = 10
)
```

![Heatmap visualization of the protein dependence values for selected kinases, inferred from the GDSC drug screen dataset. Red indicates a high dependence value and blue indicates a low dependence value. In the column annotations, cell lines with certain genomic variations are colored black. Columns are ordered by hierarchical clustering based on euclidean distance.](data:image/png;base64...)

Figure 2: Heatmap visualization of the protein dependence values for selected kinases, inferred from the GDSC drug screen dataset
Red indicates a high dependence value and blue indicates a low dependence value. In the column annotations, cell lines with certain genomic variations are colored black. Columns are ordered by hierarchical clustering based on euclidean distance.

## 8.2 Differential dependence on proteins associated with cancer types and genotypes

In this part, we will test whether the sample-specific protein dependence is associated with cancer types or certain genotypes of those samples.

Prepare genomic background table

```
cell_anno_final <- mutation_GDSC %>%
  select(-missing_value_perc) %>%
  rename(cancer_type = TCGA.classification) %>%
  filter(rownames(mutation_GDSC) %in% colnames(importanceTab))
colnames(cell_anno_final) <- gsub("_mut", "", colnames(cell_anno_final))
colnames(cell_anno_final) <- gsub("_trans", "_translocation",
                                  colnames(cell_anno_final))
```

A function to perform association test between target importance and cancer type or genomic features. If a feature has only two levels, Student’s t-test will be use. If a feature has more than two levels, ANOVA test will be used.

```
diffImportance <- function(coefMat, Annotation) {
  # process genetic background table
  geneBack <- Annotation
  geneBack <- geneBack[colnames(coefMat), ]
  keepCols <- apply(geneBack, 2, function(x) {
    length(unique(na.omit(x))) >= 2 & all(table(x) > 6)
  })
  geneBack <- geneBack[, keepCols]

  pTab <- lapply(rownames(coefMat), function(targetName) {
    lapply(colnames(geneBack), function(mutName) {
      impVec <- coefMat[targetName, ]
      genoVec <- geneBack[, mutName]
      resTab <- data.frame(
        targetName = targetName, mutName = mutName,
        stringsAsFactors = FALSE
      )
      if (length(unique(na.omit(genoVec))) == 2) {
        res <- t.test(impVec ~ genoVec, var.equal = TRUE, na.action = na.omit)
        resTab$p <- res$p.value
        resTab$FC <- (res$estimate[[2]] - res$estimate[[1]]) / abs(res$estimate[[1]])
      } else if (length(unique(na.omit(genoVec))) >= 3) {
        res <- anova(lm(impVec ~ genoVec, na.action = na.omit))
        diffTab <- data.frame(val = impVec, gr = genoVec) %>%
          filter(!is.na(gr)) %>%
          group_by(gr) %>%
          summarise(meanVal = mean(val))
        resTab$p <- res$`Pr(>F)`[1]
        resTab$FC <- max(diffTab$meanVal) - min(diffTab$meanVal)
      }
      resTab
    }) %>% bind_rows()
  }) %>%
    bind_rows() %>%
    arrange(p) %>%
    mutate(p.adj = p.adjust(p, method = "BH"))
  pTab
}
```

Perform association test between protein dependence and cancer type or mutation.

```
testRes <- diffImportance(importanceTab, cell_anno_final)
```

## 8.3 Visualize protein associations with cancer type

Prepare data for beeswarm plot visualization.

```
CancerType <- testRes %>%
  filter(mutName == "cancer_type") %>%
  filter(p.adj < 0.05, FC > 0.1)

plotTab <- t(scale(t(importanceTab))) %>%
  data.frame() %>%
  rownames_to_column("target") %>%
  gather(key = "CellLine", value = "coef", -target) %>%
  mutate(Cancer_Type = mutation_GDSC[CellLine, ]$TCGA.classification) %>%
  group_by(target, Cancer_Type) %>%
  mutate(meanCoef = mean(coef)) %>%
  arrange(meanCoef) %>%
  ungroup() %>%
  mutate(target = factor(target, levels = unique(target)))

plotTab <- plotTab %>% filter(target %in% CancerType$targetName)

plotTab$Cancer_Type <- factor(plotTab$Cancer_Type,
  levels = c(
    "ALL", "AML", "DLBC",
    "BRCAHer-", "BRCAHer+"
  )
)
```

Create beeswarm plot for visualizing target importance versus cancer type associations

```
ggplot(plotTab, aes(x = target, y = coef, group = Cancer_Type)) +
  geom_jitter(aes(color = Cancer_Type),
    position = position_jitterdodge(
      jitter.width = 0.2,
      dodge.width = 0.8
    ),
    size = 1.2
  ) +
  stat_summary(
    fun = mean, fun.min = mean, fun.max = mean, colour = "grey25",
    geom = "crossbar", size = 0.8,
    position = position_dodge(0.8)
  ) +
  scale_color_manual(
    values = c(
      "#BC3C29FF", "#E18727FF",
      "#20854EFF", "#0072B5FF", "#7876B1FF"
    ),
    guide = guide_legend(override.aes = list(size = 3))
  ) +
  ggtitle("Protein dependence associated with cancer type") +
  ylab("Protein dependence coefficient") +
  xlab("Protein") +
  theme_bw() +
  geom_vline(xintercept = seq(from = 1.5, to = 8.5, by = 1), color = "darkgrey") +
  labs(color = "Cancer Type")
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![Distributions of the protein dependence coefficients for kinases with significant association with the cancer types. Within each panel, each point corresponds to a cell line. The coefficients were centered and scaled to obtain a per-protein z-score, and the points are grouped and colored by cancer type (ALL, red; AML, orange; DLBC, green, BRCAHer-, blue; BRCAHer+, purple). Only the associations past the criteria of BH adjusted p-value < 0.05, Fold Change > 0.1 from ANOVA tests are shown.](data:image/png;base64...)

Figure 3: Distributions of the protein dependence coefficients for kinases with significant association with the cancer types
Within each panel, each point corresponds to a cell line. The coefficients were centered and scaled to obtain a per-protein z-score, and the points are grouped and colored by cancer type (ALL, red; AML, orange; DLBC, green, BRCAHer-, blue; BRCAHer+, purple). Only the associations past the criteria of BH adjusted p-value < 0.05, Fold Change > 0.1 from ANOVA tests are shown.

## 8.4 Visualize P-values of significant associations between protein dependence and mutational background

Prepare tables and color scheme for visualization

```
colList2 <- c(
  `not significant` = "grey80", mutated = "#BC3C29FF",
  unmutated = "#0072B5FF"
)
pos <- position_jitter(width = 0.15, seed = 10)
plotTab <- testRes %>%
  filter(mutName != "cancer_type") %>%
  mutate(type = ifelse(p.adj > 0.1, "not significant",
    ifelse(FC > 0, "mutated", "unmutated")
  )) %>%
  mutate(varName = ifelse(type == "not significant", "", targetName)) %>%
  mutate(p.adj = ifelse(p.adj < 1e-5, 1e-5, p.adj))

# subset for mutation with at least one significant association
plotMut <- unique(filter(testRes, p.adj <= 0.1)$mutName)
plotTab <- plotTab %>% filter(mutName %in% plotMut)
plotTab$type <- factor(plotTab$type,
  levels = c("mutated", "unmutated", "not significant")
)
```

Create dot plot visualization for the significant associations between mutational background and protein dependence of GDSC cancer cell lines.

```
library(ggrepel)
p <- ggplot(data = plotTab, aes(
  x = mutName, y = -log10(p.adj),
  col = type, label = varName
)) +
  geom_text_repel(position = pos, color = "black", size = 6, force = 3) +
  geom_hline(yintercept = -log10(0.1), linetype = "dotted", color = "grey20") +
  geom_point(size = 3, position = pos) +
  ylab(expression(-log[10] * "(" * adjusted ~ italic("P") ~ value * ")")) +
  xlab("Mutation") +
  scale_color_manual(values = colList2) +
  scale_y_continuous(trans = "exp", limits = c(0, 2.5), breaks = c(0, 1, 1.5, 2)) +
  coord_flip() +
  labs(col = "Higher dependence in") +
  theme_bw() +
  theme(
    legend.position = c(0.80, 0.6),
    legend.background = element_rect(fill = NA),
    legend.text = element_text(size = 14),
    legend.title = element_text(size = 16),
    axis.title = element_text(size = 18),
    axis.text = element_text(size = 18)
  )
plot(p)
```

```
## Warning: Removed 1 row containing missing values or values outside the scale range
## (`geom_text_repel()`).
```

```
## Warning: Removed 1 row containing missing values or values outside the scale range
## (`geom_point()`).
```

![Overview of the significant protein dependence versus gene mutation associations. This figure shows the -log10(adjusted P values) for each protein-mutation association. The color indicates the direction of association. Red indicates a higher dependence in the mutated samples and blue indicated a lower dependence in mutated samples. P values are from Student's t-test. The dashed line indicates 10% FDR.](data:image/png;base64...)

Figure 4: Overview of the significant protein dependence versus gene mutation associations
This figure shows the -log10(adjusted P values) for each protein-mutation association. The color indicates the direction of association. Red indicates a higher dependence in the mutated samples and blue indicated a lower dependence in mutated samples. P values are from Student’s t-test. The dashed line indicates 10% FDR.

## 8.5 Boxplot visualization for the difference of target importance values

Function for boxplot, given a t-test result table, coef/frequency matrix and cell line annotation object

```
library(ggbeeswarm)

# Function to format floats
formatNum <- function(i, limit = 0.01, digits = 1, format = "e") {
  r <- sapply(i, function(n) {
    if (n < limit) {
      formatC(n, digits = digits, format = format)
    } else {
      format(n, digits = digits)
    }
  })
  return(r)
}

#function for plot boxplot
plotDiffBox <- function(pTab, coefMat, cellAnno, fdrCut = 0.05) {
  pTab.sig <- filter(pTab, p.adj <= fdrCut)
  geneBack <- cellAnno
  geneBack <- geneBack[colnames(coefMat), ]
  pList <- lapply(seq(nrow(pTab.sig)), function(i) {
    geno <- pTab.sig[i, ]$mutName
    target <- pTab.sig[i, ]$targetName
    pval <- pTab.sig[i, ]$p
    plotTab <- tibble(
      id = colnames(coefMat),
      mut = geneBack[, geno], val = coefMat[target, ]
    ) %>% filter(!is.na(mut))

    plotTab <- mutate(plotTab, mut = ifelse(mut %in% c("M", "1", 1),
        "Mutated", "Unmutated"
      )) %>% mutate(mut = factor(mut, levels = c("Unmutated", "Mutated")))

    numTab <- group_by(plotTab, mut) %>% summarise(n = length(id))
    plotTab <- left_join(plotTab, numTab, by = "mut") %>%
      mutate(mutNum = sprintf("%s\n(n=%s)", mut, n)) %>%
      arrange(mut) %>%
      mutate(mutNum = factor(mutNum, levels = unique(mutNum)))
    titleText <- sprintf("%s ~ %s %s", target, geno, "mutations")
    pval <- formatNum(pval, digits = 1, format = "e")
    titleText <- bquote(atop(.(titleText), "(" ~ italic("P") ~ "=" ~ .(pval) ~ ")"))
    ggplot(plotTab, aes(x = mutNum, y = val)) +
      stat_boxplot(geom = "errorbar", width = 0.3) +
      geom_boxplot(outlier.shape = NA, col = "black", width = 0.4) +
      geom_beeswarm(cex = 2, size = 2, aes(col = mutNum)) +
      theme_classic() +
      xlab("") +
      ylab("Protein dependence") +
      ggtitle(titleText) +
      xlab("") +
      scale_color_manual(values = c("#0072B5FF", "#BC3C29FF")) +
      theme(
        axis.line.x = element_blank(), axis.ticks.x = element_blank(),
        axis.title = element_text(size = 18), axis.text = element_text(size = 18),
        plot.title = element_text(size = 20, face = "bold", hjust = 0.5),
        legend.position = "none"
      )
  })
  names(pList) <- paste0(pTab.sig$targetName, "_", pTab.sig$mutName)
  return(pList)
}
```

Visualization of exemplary association between NRAS mutation status and MAP2K2 dependence using a beeswarm plot.

```
pList <- plotDiffBox(testRes, importanceTab, cell_anno_final, 0.05)
pList$MAP2K2_NRAS
```

![The beeswarm plot shows the protein dependence coefficient of MAP2K2 protein in NRAS mutated and wildtype cell lines. P-value was from Student's t-test.](data:image/png;base64...)

Figure 5: The beeswarm plot shows the protein dependence coefficient of MAP2K2 protein in NRAS mutated and wildtype cell lines
P-value was from Student’s t-test.

# 9 Session info

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
##  [1] ggbeeswarm_0.7.2    ggrepel_0.9.6       pheatmap_1.0.13
##  [4] RColorBrewer_1.1-3  missForest_1.6.1    dplyr_1.1.4
##  [7] BiocParallel_1.44.0 ggplot2_4.0.0       tidyr_1.3.1
## [10] tibble_3.3.0        DepInfeR_1.14.0     BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] utf8_1.2.6           sass_0.4.10          generics_0.1.4
##  [4] shape_1.4.6.1        lattice_0.22-7       digest_0.6.37
##  [7] magrittr_2.0.4       evaluate_1.0.5       grid_4.5.1
## [10] bookdown_0.45        iterators_1.0.14     fastmap_1.2.0
## [13] foreach_1.5.2        jsonlite_2.0.0       glmnet_4.1-10
## [16] Matrix_1.7-4         tinytex_0.57         survival_3.8-3
## [19] BiocManager_1.30.26  doRNG_1.8.6.2        purrr_1.1.0
## [22] itertools_0.1-3      scales_1.4.0         codetools_0.2-20
## [25] jquerylib_0.1.4      Rdpack_2.6.4         cli_3.6.5
## [28] crayon_1.5.3         rlang_1.1.6          rbibutils_2.3
## [31] splines_4.5.1        withr_3.0.2          cachem_1.1.0
## [34] yaml_2.3.10          tools_4.5.1          parallel_4.5.1
## [37] rngtools_1.5.2       ranger_0.17.0        vctrs_0.6.5
## [40] R6_2.6.1             magick_2.9.0         matrixStats_1.5.0
## [43] lifecycle_1.0.4      randomForest_4.7-1.2 vipor_0.4.7
## [46] beeswarm_0.4.0       pkgconfig_2.0.3      pillar_1.11.1
## [49] bslib_0.9.0          gtable_0.3.6         glue_1.8.0
## [52] Rcpp_1.1.0           xfun_0.53            tidyselect_1.2.1
## [55] knitr_1.50           dichromat_2.0-0.1    farver_2.1.2
## [58] htmltools_0.5.8.1    labeling_0.4.3       rmarkdown_2.30
## [61] compiler_4.5.1       S7_0.2.0
```