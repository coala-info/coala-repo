# Code example from 'fold_change' vignette. See references/ for full tutorial.

params <-
list(cache = FALSE)

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(fig.width=7, fig.height=6)

## ----load, message=FALSE, warning=FALSE---------------------------------------
library(topconfects)

library(NBPSeq)
library(edgeR)
library(limma)

library(dplyr)
library(ggplot2)

data(arab)

# Retrieve symbol for each gene
info <- 
    AnnotationDbi::select(
        org.At.tair.db::org.At.tair.db, 
        rownames(arab), "SYMBOL") %>%
    group_by(TAIR) %>% 
    summarize(
        SYMBOL=paste(unique(na.omit(SYMBOL)),collapse="/"))
arab_info <- 
    info[match(rownames(arab),info$TAIR),] %>% 
    select(-TAIR) %>%
    as.data.frame
rownames(arab_info) <- rownames(arab)

# Extract experimental design from sample names
Treat <- factor(substring(colnames(arab),1,4)) %>% relevel(ref="mock")
Time <- factor(substring(colnames(arab),5,5))

y <- DGEList(arab, genes=as.data.frame(arab_info))

# Keep genes with at least 3 samples having an RPM of more than 2
keep <- rowSums(cpm(y)>2) >= 3
y <- y[keep,,keep.lib.sizes=FALSE]
y <- calcNormFactors(y)

## ----limma--------------------------------------------------------------------
design <- model.matrix(~Time+Treat)
design[,]

fit <-
    voom(y, design) %>%
    lmFit(design)

## ----limma_confects-----------------------------------------------------------
confects <- limma_confects(fit, coef="Treathrcc", fdr=0.05)

confects

## ----fig.height=7-------------------------------------------------------------
confects_plot(confects)

## -----------------------------------------------------------------------------
confects_plot_me2(confects, breaks=c(0,1,2))

## -----------------------------------------------------------------------------
confects_plot_me(confects) + labs(title="This plot is not recommended")

## ----fig.height=7-------------------------------------------------------------
fit_eb <- eBayes(fit)
top <- topTable(fit_eb, coef="Treathrcc", n=Inf)

rank_rank_plot(confects$table$name, rownames(top), "limma_confects", "topTable")

## -----------------------------------------------------------------------------
plotMD(fit, legend="bottomleft", status=paste0(
    ifelse(rownames(fit) %in% rownames(top)[1:40], "topTable ",""),
    ifelse(rownames(fit) %in% confects$table$name[1:40], "confects ","")))

## ----edger--------------------------------------------------------------------
y <- estimateDisp(y, design, robust=TRUE)
efit <- glmQLFit(y, design, robust=TRUE)

## ----edger_confects-----------------------------------------------------------
econfects <- edger_confects(efit, coef="Treathrcc", fdr=0.05, step=0.05)

econfects

## ----fig.height=7-------------------------------------------------------------
confects_plot(econfects)
confects_plot_me2(econfects, breaks=c(0,1,2))

## -----------------------------------------------------------------------------
etop <-
    glmQLFTest(efit, coef="Treathrcc") %>%
    topTags(n=Inf)

plotMD(efit, legend="bottomleft", status=paste0(
    ifelse(rownames(efit) %in% econfects$table$name[1:40], "confects ", ""),
    ifelse(rownames(efit) %in% rownames(etop)[1:40], "topTags ","")))

## ----message=F, warning=F-----------------------------------------------------
library(DESeq2)

dds <- DESeqDataSetFromMatrix(
    countData = arab,
    colData = data.frame(Time, Treat),
    rowData = arab_info,
    design = ~Time+Treat)

dds <- DESeq(dds)

## -----------------------------------------------------------------------------
dconfects <- deseq2_confects(dds, name="Treat_hrcc_vs_mock", step=0.05)

## -----------------------------------------------------------------------------
shrunk <- lfcShrink(dds, coef="Treat_hrcc_vs_mock", type="ashr")
dconfects$table$shrunk <- shrunk$log2FoldChange[dconfects$table$index]

dconfects

## -----------------------------------------------------------------------------
table(dconfects$table$filtered)
tail(dconfects$table)

## ----fig.height=7-------------------------------------------------------------
confects_plot(dconfects) + 
    geom_point(aes(x=shrunk, size=baseMean, color="lfcShrink"), alpha=0.75)

## -----------------------------------------------------------------------------
filter(dconfects$table, !filtered) %>%
ggplot(aes(
        x=ifelse(is.na(confect),0,confect), y=shrunk, color=!is.na(confect))) +
    geom_point() + geom_abline() + coord_fixed() + theme_bw() +
    labs(color="Significantly\nnon-zero at\nFDR 0.05", 
        x="confect", y="lfcShrink using ashr")

## ----fig.height=7-------------------------------------------------------------
rank_rank_plot(confects$table$name, econfects$table$name, 
    "limma confects", "edgeR confects")
rank_rank_plot(confects$table$name, dconfects$table$name, 
    "limma confects", "DESeq2 confects")
rank_rank_plot(econfects$table$name, dconfects$table$name, 
    "edgeR confects", "DESeq2 confects")

## -----------------------------------------------------------------------------
sessionInfo()

