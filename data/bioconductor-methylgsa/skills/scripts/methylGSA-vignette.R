# Code example from 'methylGSA-vignette' vignette. See references/ for full tutorial.

## ----echo = FALSE-------------------------------------------------------------
knitr::opts_chunk$set(comment = "", message=FALSE, warning = FALSE)

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("methylGSA")

## -----------------------------------------------------------------------------
library(methylGSA)

## -----------------------------------------------------------------------------
library(IlluminaHumanMethylation450kanno.ilmn12.hg19)

## ----eval = FALSE-------------------------------------------------------------
# library(IlluminaHumanMethylationEPICanno.ilm10b4.hg19)

## -----------------------------------------------------------------------------
data(cpgtoy)
head(cpg.pval, 20)

## -----------------------------------------------------------------------------
res1 = methylglm(cpg.pval = cpg.pval, minsize = 200, 
                 maxsize = 500, GS.type = "KEGG")
head(res1, 15)

## ----echo=FALSE---------------------------------------------------------------
glm_res = data.frame(
    "Column" = c("ID", 
                 "Description (N/A for user supplied gene set)",
                 "Size", "pvalue", "padj"),
    "Explanation" = c("Gene set ID", "Gene set description", 
                "Number of genes in gene set", 
                "p-value in logistic regression", "Adjusted p-value")
)
knitr::kable(glm_res)

## -----------------------------------------------------------------------------
library(org.Hs.eg.db)
genes_04080 = select(org.Hs.eg.db, "04080", "SYMBOL", keytype = "PATH")
head(genes_04080)

## ----eval=FALSE---------------------------------------------------------------
# # include all the IDs as the 2nd argument in select function
# genes_all_pathway = select(org.Hs.eg.db, as.character(res1$ID),
#                      "SYMBOL", keytype = "PATH")
# head(genes_all_pathway)

## ----eval=FALSE---------------------------------------------------------------
# res2 = methylRRA(cpg.pval = cpg.pval, method = "ORA",
#                     minsize = 200, maxsize = 210)
# head(res2, 15)

## ----echo=FALSE---------------------------------------------------------------
ora_res = data.frame(
    "Column" = c("ID", 
                 "Description (N/A for user supplied gene set)", "Count",
                 "overlap", "Size", "pvalue", "padj"),
    "Explanation" = c("Gene set ID", "Gene set description", 
                "Number of significant genes in the gene set",
                "Names of significant genes in the gene set",
                "Number of genes in gene set", 
                "p-value in ORA", "Adjusted p-value")
)
knitr::kable(ora_res)

## ----eval=FALSE---------------------------------------------------------------
# res3 = methylRRA(cpg.pval = cpg.pval, method = "GSEA",
#                     minsize = 200, maxsize = 210)
# head(res3, 10)

## ----echo=FALSE---------------------------------------------------------------
gsea_res = data.frame(
    "Column" = c("ID", 
                 "Description (N/A for user supplied gene set)", 
                 "Size", "enrichmentScore", "NES",
                 "pvalue", "padj"),
    "Explanation" = c("Gene set ID", "Gene set description", 
                "Number of genes in gene set",
                "Enrichment score (see [3] for details)", 
                "Normalized enrichment score (see [3] for details)",
                "p-value in GSEA", "Adjusted p-value")
)
knitr::kable(gsea_res)

## ----eval=FALSE---------------------------------------------------------------
# res4 = methylgometh(cpg.pval = cpg.pval, sig.cut = 0.001,
#                         minsize = 200, maxsize = 210)
# head(res4, 15)

## -----------------------------------------------------------------------------
data(GSlisttoy)
## to make the display compact, only a proportion of each gene set is shown
head(lapply(GS.list, function(x) x[1:30]), 3)   

## ----eval=FALSE---------------------------------------------------------------
# library(BiocParallel)
# res_p = methylglm(cpg.pval = cpg.pval, minsize = 200,
#                   maxsize = 500, GS.type = "KEGG", parallel = TRUE)

## -----------------------------------------------------------------------------
data(CpG2Genetoy)
head(CpG2Gene)   

## -----------------------------------------------------------------------------
FullAnnot = prepareAnnot(CpG2Gene) 

## -----------------------------------------------------------------------------
GS.list = GS.list[1:10]
res5 = methylRRA(cpg.pval = cpg.pval, FullAnnot = FullAnnot, method = "ORA", 
                    GS.list = GS.list, GS.idtype = "SYMBOL", 
                    minsize = 100, maxsize = 300)
head(res5, 10)

## ----eval=FALSE---------------------------------------------------------------
# res6 = methylglm(cpg.pval = cpg.pval, array.type = "450K",
#                     GS.type = "Reactome", minsize = 100, maxsize = 110)
# head(res6, 10)

## -----------------------------------------------------------------------------
barplot(res1, num = 8, colorby = "pvalue")

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

