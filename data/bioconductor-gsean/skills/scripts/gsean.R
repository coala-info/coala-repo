# Code example from 'gsean' vignette. See references/ for full tutorial.

## ----fig.align='center', message=FALSE, warning=FALSE, eval=FALSE-------------
# library(gsean)
# library(TCGAbiolinks)
# library(SummarizedExperiment)
# # TCGA LUAD
# query <- GDCquery(project = "TCGA-LUAD",
#                   data.category = "Gene expression",
#                   data.type = "Gene expression quantification",
#                   platform = "Illumina HiSeq",
#                   file.type  = "normalized_results",
#                   experimental.strategy = "RNA-Seq",
#                   legacy = TRUE)
# GDCdownload(query, method = "api")
# invisible(capture.output(data <- GDCprepare(query)))
# exprs.LUAD <- assay(data)
# # remove duplicated gene names
# exprs.LUAD <- exprs.LUAD[-which(duplicated(rownames(exprs.LUAD))),]
# # list of genes
# recur.mut.gene <- c("KRAS", "TP53", "STK11", "RBM10", "SPATA31C1", "KRTAP4-11",
#                     "DCAF8L2", "AGAP6", "KEAP1", "SETD2", "ZNF679", "FSCB",
#                     "BRAF", "ZNF770", "U2AF1", "SMARCA4", "HRNR", "EGFR")
# 
# # KEGG_hsa
# load(system.file("data", "KEGG_hsa.rda", package = "gsean"))
# 
# # GSEA
# set.seed(1)
# result.GSEA <- gsean(KEGG_hsa, recur.mut.gene, exprs.LUAD, threshold = 0.7)
# invisible(capture.output(p <- GSEA.barplot(result.GSEA, category = 'pathway',
#                                            score = 'NES', pvalue = 'padj',
#                                            sort = 'padj', top = 20)))
# p <- GSEA.barplot(result.GSEA, category = 'pathway', score = 'NES',
#                   pvalue = 'padj', sort = 'padj', top = 20)
# p + theme(plot.margin = margin(10, 10, 10, 75))

## ----fig.align='center', message=FALSE, warning=FALSE, eval=TRUE--------------
library(gsean)
library(pasilla)
library(DESeq2)
# pasilla count data
pasCts <- system.file("extdata", "pasilla_gene_counts.tsv",
                      package = "pasilla", mustWork = TRUE)
cts <- as.matrix(read.csv(pasCts, sep="\t", row.names = "gene_id"))
condition <- factor(c(rep("untreated", 4), rep("treated", 3)))
dds <- DESeqDataSetFromMatrix(
  countData = cts,
  colData   = data.frame(condition),
  design    = ~ 0 + condition)
# filtering
keep <- rowSums(counts(dds)) >= 10
dds <- dds[keep,]
# differentially expressed genes
dds <- DESeq(dds)
resultsNames(dds)
res <- results(dds, contrast = list("conditiontreated", "conditionuntreated"), listValues = c(1, -1))
statistic <- res$stat
names(statistic) <- rownames(res)
exprs.pasilla <- counts(dds, normalized = TRUE)

# convert gene id
library(org.Dm.eg.db)
gene.id <- AnnotationDbi::select(org.Dm.eg.db, names(statistic), "ENTREZID", "FLYBASE")
names(statistic) <- gene.id[,2]
rownames(exprs.pasilla) <- gene.id[,2]

# GO_dme
load(system.file("data", "GO_dme.rda", package = "gsean"))

# GSEA
set.seed(1)
result.GSEA <- gsean(GO_dme, statistic, exprs.pasilla)
invisible(capture.output(p <- GSEA.barplot(result.GSEA, category = 'pathway',
                                           score = 'NES', top = 50, pvalue = 'padj',
                                           sort = 'padj', numChar = 110) + 
  theme(plot.margin = margin(10, 10, 10, 50))))
plotly::ggplotly(p)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

