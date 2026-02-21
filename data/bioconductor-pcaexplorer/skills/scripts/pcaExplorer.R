# Code example from 'pcaExplorer' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown()

## ----setup, echo=FALSE, warning=FALSE-----------------------------------------
library("knitr")
set.seed(42)
opts_chunk$set(comment = "#>",
               fig.align = "center",
               warning = FALSE)
stopifnot(requireNamespace("htmltools"))
htmltools::tagList(rmarkdown::html_dependency_font_awesome())

## ----out.width="50%", echo=FALSE----------------------------------------------
knitr::include_graphics(system.file("www", "pcaExplorer.png", package = "pcaExplorer"))

## ----installation, eval=FALSE-------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("pcaExplorer")

## ----installfull, eval=FALSE--------------------------------------------------
# BiocManager::install("pcaExplorer", dependencies = TRUE)

## ----installation-github, eval=FALSE------------------------------------------
# library("devtools")
# install_github("federicomarini/pcaExplorer")

## ----loadlibrary, message=FALSE-----------------------------------------------
library("pcaExplorer")

## -----------------------------------------------------------------------------
citation("pcaExplorer")

## ----eval=FALSE---------------------------------------------------------------
# BiocManager::install("org.At.tair.db")
# library("org.At.tair.db")
# # skipping the steps where you normally would generate your dds_at object...
# dds_at
# vst_at <- DESeq2::vst(dds_at)
# anno_at <- get_annotation_orgdb(dds_at,"org.At.tair.db", idtype = "TAIR")
# # subset the background to include only the expressed genes
# bg_ids <- rownames(dds_at)[rowSums(counts(dds_at)) > 0]
# library(topGO)
# pca2go_at <- pca2go(vst_at,
#                     annotation = anno_at,
#                     annopkg = "org.At.tair.db",
#                     ensToGeneSymbol = TRUE,
#                     background_genes = bg_ids)
# # and finally, with all the objects prepared...
# pcaExplorer(dds = dds_at, dst = vst_at, annotation = anno_at, pca2go = pca2go_at)

## ----installairway, eval=FALSE------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("airway")

## ----loadairway, message=FALSE------------------------------------------------
library("airway")
library("DESeq2")

data("airway", package = "airway")

dds_airway <- DESeqDataSet(airway,design= ~ cell + dex)
dds_airway
rld_airway <- rlogTransformation(dds_airway)
rld_airway

## ----launchairway, eval=FALSE-------------------------------------------------
# pcaExplorer(dds = dds_airway,
#             dst = rld_airway)

## ----annoairway, message = FALSE----------------------------------------------
library(org.Hs.eg.db)
genenames_airway <- mapIds(org.Hs.eg.db,keys = rownames(dds_airway),column = "SYMBOL",keytype="ENSEMBL")
annotation_airway <- data.frame(gene_name = genenames_airway,
                                row.names = rownames(dds_airway),
                                stringsAsFactors = FALSE)
head(annotation_airway)                                

## ----annofuncs, eval=FALSE----------------------------------------------------
# anno_df_orgdb <- get_annotation_orgdb(dds = dds_airway,
#                                       orgdb_species = "org.Hs.eg.db",
#                                       idtype = "ENSEMBL")
# 
# anno_df_biomart <- get_annotation(dds = dds_airway,
#                                   biomart_dataset = "hsapiens_gene_ensembl",
#                                   idtype = "ensembl_gene_id")

## ----echo=FALSE---------------------------------------------------------------
anno_df_orgdb <- get_annotation_orgdb(dds = dds_airway,
                                      orgdb_species = "org.Hs.eg.db",
                                      idtype = "ENSEMBL")

## -----------------------------------------------------------------------------
head(anno_df_orgdb)

## ----launchairwayanno, eval=FALSE---------------------------------------------
# pcaExplorer(dds = dds_airway,
#             dst = rld_airway,
#             annotation = annotation_airway) # or anno_df_orgdb, or anno_df_biomart

## ----ddsmultifac--------------------------------------------------------------
dds_multifac <- makeExampleDESeqDataSet_multifac(betaSD_condition = 3,betaSD_tissue = 1)

## ----prepsimul----------------------------------------------------------------
dds_multifac <- makeExampleDESeqDataSet_multifac(betaSD_condition = 1,betaSD_tissue = 3)
dds_multifac
rld_multifac <- rlogTransformation(dds_multifac)
rld_multifac
## checking how the samples cluster on the PCA plot
pcaplot(rld_multifac,intgroup = c("condition","tissue"))

## ----launchsimul, eval=FALSE--------------------------------------------------
# pcaExplorer(dds = dds_multifac,
#             dst = rld_multifac)

## ----func-pcaplot-------------------------------------------------------------
pcaplot(rld_airway,intgroup = c("cell","dex"),ntop = 1000,
        pcX = 1, pcY = 2, title = "airway dataset PCA on samples - PC1 vs PC2")

# on a different set of principal components...
pcaplot(rld_airway,intgroup = c("dex"),ntop = 1000,
        pcX = 1, pcY = 4, title = "airway dataset PCA on samples - PC1 vs PC4",
        ellipse = TRUE)

## ----func-pcaplot3d, eval=FALSE-----------------------------------------------
# pcaplot3d(rld_airway,intgroup = c("cell","dex"),ntop = 1000,
#         pcX = 1, pcY = 2, pcZ = 3)
# # will open up in the viewer

## ----func-pcascree------------------------------------------------------------
pcaobj_airway <- prcomp(t(assay(rld_airway)))
pcascree(pcaobj_airway,type="pev",
         title="Proportion of explained proportion of variance - airway dataset")

## ----func-correlatepcs--------------------------------------------------------
res_pcairway <- correlatePCs(pcaobj_airway,colData(dds_airway))

res_pcairway

plotPCcorrs(res_pcairway)

## ----func-hiloadings----------------------------------------------------------
# extract the table of the genes with high loadings
hi_loadings(pcaobj_airway,topN = 10,exprTable=counts(dds_airway))
# or alternatively plot the values
hi_loadings(pcaobj_airway,topN = 10,annotation = annotation_airway)

## ----func-genespca------------------------------------------------------------
groups_airway <- colData(dds_airway)$dex
cols_airway <- scales::hue_pal()(2)[groups_airway]
# with many genes, do not plot the labels of the genes
genespca(rld_airway,ntop=5000,
         choices = c(1,2),
         arrowColors=cols_airway,groupNames=groups_airway,
         alpha = 0.2,
         useRownamesAsLabels=FALSE,
         varname.size = 5
        )
# with a smaller number of genes, plot gene names included in the annotation
genespca(rld_airway,ntop=100,
         choices = c(1,2),
         arrowColors=cols_airway,groupNames=groups_airway,
         alpha = 0.7,
         varname.size = 5,
         annotation = annotation_airway
        )

## ----func-topGOtable, eval=FALSE----------------------------------------------
# # example not run due to quite long runtime
# dds_airway <- DESeq(dds_airway)
# res_airway <- results(dds_airway)
# res_airway$symbol <- mapIds(org.Hs.eg.db,
#                             keys=row.names(res_airway),
#                             column="SYMBOL",
#                             keytype="ENSEMBL",
#                             multiVals="first")
# res_airway$entrez <- mapIds(org.Hs.eg.db,
#                             keys=row.names(res_airway),
#                             column="ENTREZID",
#                             keytype="ENSEMBL",
#                             multiVals="first")
# resOrdered <- as.data.frame(res_airway[order(res_airway$padj),])
# head(resOrdered)
# # extract DE genes
# de_df <- resOrdered[resOrdered$padj < .05 & !is.na(resOrdered$padj),]
# de_symbols <- de_df$symbol
# # extract background genes
# bg_ids <- rownames(dds_airway)[rowSums(counts(dds_airway)) > 0]
# bg_symbols <- mapIds(org.Hs.eg.db,
#                      keys=bg_ids,
#                      column="SYMBOL",
#                      keytype="ENSEMBL",
#                      multiVals="first")
# # run the function
# topgoDE_airway <- topGOtable(de_symbols, bg_symbols,
#                              ontology = "BP",
#                              mapping = "org.Hs.eg.db",
#                              geneID = "symbol")

## ----func-pca2go, eval=FALSE--------------------------------------------------
# pca2go_airway <- pca2go(rld_airway,
#                         annotation = annotation_airway,
#                         organism = "Hs",
#                         ensToGeneSymbol = TRUE,
#                         background_genes = bg_ids)
# # for a smooth interactive exploration, use DT::datatable
# datatable(pca2go_airway$PC1$posLoad)
# # display it in the normal R session...
# head(pca2go_airway$PC1$posLoad)
# # ... or use it for running the app and display in the dedicated tab
# pcaExplorer(dds_airway,rld_airway,
#             pca2go = pca2go_airway,
#             annotation = annotation_airway)

## ----func, message = FALSE, eval = FALSE--------------------------------------
# goquick_airway <- limmaquickpca2go(rld_airway,
#                                    pca_ngenes = 10000,
#                                    inputType = "ENSEMBL",
#                                    organism = "Hs")
# # display it in the normal R session...
# head(goquick_airway$PC1$posLoad)
# # ... or use it for running the app and display in the dedicated tab
# pcaExplorer(dds_airway,rld_airway,
#             pca2go = goquick_airway,
#             annotation = annotation_airway)

## ----func-makedataset---------------------------------------------------------

dds_simu <- makeExampleDESeqDataSet_multifac(betaSD_condition = 3,betaSD_tissue = 0.5)
dds_simu
dds2_simu <- makeExampleDESeqDataSet_multifac(betaSD_condition = 0.5,betaSD_tissue = 2)
dds2_simu

rld_simu <- rlogTransformation(dds_simu)
rld2_simu <- rlogTransformation(dds2_simu)
pcaplot(rld_simu,intgroup = c("condition","tissue")) + 
  ggplot2::ggtitle("Simulated data - Big condition effect, small tissue effect")
pcaplot(rld2_simu,intgroup = c("condition","tissue")) + 
  ggplot2::ggtitle("Simulated data - Small condition effect, bigger tissue effect")

## ----eval=FALSE---------------------------------------------------------------
# distro_expr(rld_airway,plot_type = "density")
# distro_expr(rld_airway,plot_type = "violin")

## -----------------------------------------------------------------------------
distro_expr(rld_airway,plot_type = "boxplot")

## -----------------------------------------------------------------------------
dds <- makeExampleDESeqDataSet_multifac(betaSD_condition = 3,betaSD_tissue = 1)
dst <- DESeq2::rlogTransformation(dds)
set.seed(42)
geneprofiler(dst,paste0("gene",sample(1:1000,20)), plotZ = FALSE)

## ----eval=FALSE---------------------------------------------------------------
# anno_df_biomart <- get_annotation(dds = dds_airway,
#                                   biomart_dataset = "hsapiens_gene_ensembl",
#                                   idtype = "ensembl_gene_id")

## -----------------------------------------------------------------------------
anno_df_orgdb <- get_annotation_orgdb(dds = dds_airway,
                                      orgdb_species = "org.Hs.eg.db",
                                      idtype = "ENSEMBL")

head(anno_df_orgdb)

## -----------------------------------------------------------------------------
# use a subset of the counts to reduce plotting time, it can be time consuming with many samples
pair_corr(counts(dds_airway)[1:100,])

## -----------------------------------------------------------------------------
sessionInfo()

