# Code example from 'vignette' vignette. See references/ for full tutorial.

## ----message=FALSE, warning=FALSE---------------------------------------------
set.seed(123)
library(DepInfeR)
library(tibble)
library(tidyr)
library(ggplot2)
library(BiocParallel)
library(dplyr)

## ----installation, eval = FALSE-----------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#   install.packages("BiocManager")
# }
# BiocManager::install("DepInfeR")

## -----------------------------------------------------------------------------
data(targetsGDSC, drug_response_GDSC)

## -----------------------------------------------------------------------------
head(targetsGDSC)

## -----------------------------------------------------------------------------
head(drug_response_GDSC)

## -----------------------------------------------------------------------------
targetsGDSC <- mutate(targetsGDSC,
  targetName = ifelse(targetName %in% "BCR", "BCR/ABL", targetName)
)

## -----------------------------------------------------------------------------
targetMatrix <- filter(
  targetsGDSC,
  targetClassification == "High confidence"
) %>%
  select(drugID, targetName, Kd) %>%
  pivot_wider(names_from = "targetName", values_from = "Kd") %>%
  remove_rownames() %>%
  column_to_rownames("drugID") %>%
  as.matrix()

## -----------------------------------------------------------------------------
ProcessTargetResults <- processTarget(targetMatrix,
  KdAsInput = TRUE,
  removeCorrelated = TRUE
)

## -----------------------------------------------------------------------------
responseMatrix <- filter(drug_response_GDSC, `Drug Id` %in% targetsGDSC$drugID) %>%
  select(`Drug Id`, `Cell line name`, AUC) %>%
  pivot_wider(names_from = `Cell line name`, values_from = AUC) %>%
  remove_rownames() %>%
  column_to_rownames("Drug Id") %>%
  as.matrix()

## ----fig.cap="This figure shows the number of cell lines included in the analysis as a function of the percentage of missing values allowed per cell line."----

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

## -----------------------------------------------------------------------------
responseMatrix <- responseMatrix[, colSums(is.na(responseMatrix)) <= 24]

## -----------------------------------------------------------------------------
library(missForest)

impRes <- missForest(t(responseMatrix))
imp_missforest <- impRes$ximp

responseMatrix_imputed <- t(imp_missforest)

## -----------------------------------------------------------------------------
responseMatrix_scaled <- t(scale(t(responseMatrix_imputed)))

## -----------------------------------------------------------------------------
targetInput <- ProcessTargetResults$targetMatrix

overlappedDrugs <- intersect(
  rownames(responseMatrix_scaled),
  rownames(targetInput)
)

targetInput <- targetInput[overlappedDrugs, ]
responseInput <- responseMatrix_scaled[overlappedDrugs, ]

## -----------------------------------------------------------------------------
#set up BiocParallel back-end
param <- MulticoreParam(workers = 2, RNGseed = 333)

result <- runLASSORegression(
  TargetMatrix = targetInput,
  ResponseMatrix = responseInput, repeats = 3,
  BPPARAM = param
)

## -----------------------------------------------------------------------------
useTar <- rowSums(result$coefMat != 0) > 0
result$coefMat <- result$coefMat[useTar, ]

## -----------------------------------------------------------------------------
nrow(result$coefMat)

## ----fig.cap="Heatmap visualization of the protein dependence values for selected kinases, inferred from the GDSC drug screen dataset. Red indicates a high dependence value and blue indicates a low dependence value. In the column annotations, cell lines with certain genomic variations are colored black. Columns are ordered by hierarchical clustering based on euclidean distance.", fig.height=13, fig.width=9----

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

## ----gdsc genomic-------------------------------------------------------------
cell_anno_final <- mutation_GDSC %>%
  select(-missing_value_perc) %>%
  rename(cancer_type = TCGA.classification) %>%
  filter(rownames(mutation_GDSC) %in% colnames(importanceTab))
colnames(cell_anno_final) <- gsub("_mut", "", colnames(cell_anno_final))
colnames(cell_anno_final) <- gsub("_trans", "_translocation",
                                  colnames(cell_anno_final))

## -----------------------------------------------------------------------------
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

## ----gdsc t-test--------------------------------------------------------------
testRes <- diffImportance(importanceTab, cell_anno_final)

## -----------------------------------------------------------------------------
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

## ----fig.height=4, fig.width=10, fig.cap="Distributions of the protein dependence coefficients for kinases with significant association with the cancer types. Within each panel, each point corresponds to a cell line. The coefficients were centered and scaled to obtain a per-protein z-score, and the points are grouped and colored by cancer type (ALL, red; AML, orange; DLBC, green, BRCAHer-, blue; BRCAHer+, purple). Only the associations past the criteria of BH adjusted p-value < 0.05, Fold Change > 0.1 from ANOVA tests are shown."----

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

## -----------------------------------------------------------------------------
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

## ----fig.height=6, fig.width=10, fig.cap = "Overview of the significant protein dependence versus gene mutation associations. This figure shows the -log10(adjusted P values) for each protein-mutation association. The color indicates the direction of association. Red indicates a higher dependence in the mutated samples and blue indicated a lower dependence in mutated samples. P values are from Student's t-test. The dashed line indicates 10% FDR."----

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

## -----------------------------------------------------------------------------
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

## ----fig.height=4.5, fig.width=5, fig.cap="The beeswarm plot shows the protein dependence coefficient of MAP2K2 protein in NRAS mutated and wildtype cell lines. P-value was from Student's t-test."----
pList <- plotDiffBox(testRes, importanceTab, cell_anno_final, 0.05)
pList$MAP2K2_NRAS

## -----------------------------------------------------------------------------
sessionInfo()

