# Code example from 'zitools_tutorial' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    fig.width = 6,
    fig.height = 4.5
)

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("zitools")

## ----message = FALSE----------------------------------------------------------
library(zitools)

## ----message = FALSE----------------------------------------------------------
library(phyloseq)
library(DESeq2)
library(tidyverse)
library(microbiome)

## ----Dataset------------------------------------------------------------------
data("peerj32")
phyloseq <- peerj32[["phyloseq"]]
sample_data(phyloseq)$time <- factor(sample_data(phyloseq)$time)

## ----echo = FALSE-------------------------------------------------------------
str(phyloseq, max.level = 3)

## ----ziMain-------------------------------------------------------------------
Zi <- ziMain(phyloseq)
print(Zi)

## -----------------------------------------------------------------------------
mean(Zi)
sd(Zi)
var(Zi)

median(Zi)
quantile(Zi)

## ----boxplot, echo=TRUE-------------------------------------------------------
boxplot(log2p(Zi), xlab = "samples", ylab = "log2(count+1)", 
        main = "ZI considered")
boxplot(log2p(inputcounts(Zi)), xlab = "samples", ylab = "log2(count+1)", 
        main = "ZI not considered")


## ----repeat plot--------------------------------------------------------------
i <- 1
repeat {
    Zi <- resample_deinflatedcounts(Zi)
    boxplot(log2p(Zi), xlab = "samples", ylab = "log2(count+1)", 
        main = paste("Iteration", i))
    i = i+1
    if(i==6){
    break
    }
} 


## ----DDS----------------------------------------------------------------------
DDS <- zi2deseq2(Zi, ~time)
DDS$Subject <- relevel(DDS$time, ref = "1")
DDS <-  DESeq(DDS, test = "Wald", fitType = "local", sfType = "poscounts")


## ----echo=TRUE----------------------------------------------------------------
(result <- results(DDS, cooksCutoff = FALSE))
result <- as.data.frame(result)


## ----df, echo=FALSE, eval=TRUE, warning = FALSE-------------------------------
result_df<- cbind(as(result, "data.frame"), 
    as(tax_table(phyloseq)[rownames(result), ], "matrix"))
result_df <- result_df %>%
    rownames_to_column(var = "OTU") %>%
    arrange(padj)
#drop the rows with NA
result_df <- result_df[complete.cases(result_df), ]

result_df$diffexpressed[result_df$log2FoldChange > 1 & 
    result_df$pvalue < 0.05] <- result_df$Genus
result_df$diffexpressed[result_df$log2FoldChange < -1 & 
    result_df$pvalue < 0.05] <- result_df$Genus

result_df <- data.frame("OTU" = result_df$OTU, 
    "log2FoldChange" = result_df$log2FoldChange, 
    "pvalue" = result_df$pvalue, 
    "Genus" = result_df$diffexpressed)


## ----echo = TRUE, warning = FALSE, fig.width=10-------------------------------
print(ggplot(data=result_df, aes(x=log2FoldChange, 
    y=-log10(pvalue), 
    color = Genus)) +
    geom_point()+
    theme_minimal()+
    xlim(-6,6)+
    ylim(-0.5,4)+
    ylab("-log10(pvalue)\n")+
    xlab("\nLog2FoldChange")+
    geom_vline(xintercept=c(-1, 1), col="black") +
    geom_hline(yintercept=-log10(0.05), col="black")+
    theme(text = element_text(size = 20))+
    theme(panel.spacing.x = unit(2, "lines")))

## ----eval = TRUE, echo = FALSE------------------------------------------------
Zi2 <- Zi
mat <- deinflatedcounts(Zi2)
mat[mat > 500] <- 500
deinflatedcounts(Zi2) <- mat

## ----heatmap------------------------------------------------------------------
MissingValueHeatmap(Zi2, xlab = "Sample")

## ----results='hide'-----------------------------------------------------------
PCA <- princomp(covmat = cor(t(Zi)), cor = FALSE)
centered_data <- (inputcounts(t(Zi))-colMeans2(t(Zi)))/sqrt(colVars(t(Zi)))
loadings <- PCA$loadings
scores <- centered_data %*% loadings
PCA$scores <- scores

df_PCA <- data.frame("PC1" = PCA[["scores"]][,1], "PC2" = PCA[["scores"]][,2], 
    "group" = sample_data(Zi)$group)

## ----plot PCA, echo=FALSE-----------------------------------------------------
print(ggplot(df_PCA, aes(x = PC1, y = PC2, color = group))+
    geom_point()+
    xlim(-200,100)+
    ylim(-250,260)+
    xlab("PC1 14.6%")+
    ylab("PC2 9.9%"))

## -----------------------------------------------------------------------------
new_phyloseq <- zi2phyloseq(Zi)

## -----------------------------------------------------------------------------
str(otu_table(new_phyloseq), max.level = 3)

## ----warning=FALSE------------------------------------------------------------
subset <- subset_taxa(new_phyloseq, Phylum=="Firmicutes")
subset <- prune_taxa(names(sort(taxa_sums(subset),TRUE)[1:300]), subset)
(plot_heatmap(subset, ))

## -----------------------------------------------------------------------------
plot_richness(new_phyloseq, measures = c("Chao1"), 
    color = sample_data(new_phyloseq)$group)+
    theme(axis.text.x = element_blank())

## -----------------------------------------------------------------------------
sessionInfo()

