# Code example from 'signatureSearch' vignette. See references/ for full tutorial.

## ----global_options, include=FALSE, warning=FALSE-----------------------------
## ThG: chunk added to enable global knitr options. The below turns on 
## caching for faster vignette re-build during text editing.                                      
knitr::opts_chunk$set(cache=TRUE)                                                  

## ----setup, echo=FALSE, messages=FALSE, warning=FALSE-------------------------
suppressPackageStartupMessages({
  library(signatureSearch)
  library(ggplot2)
})

## ----install, eval=FALSE------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("signatureSearch")
# BiocManager::install("girke-lab/signatureSearch", build_vignettes=FALSE)  # Installs from github

## ----load, eval=TRUE, message=FALSE-------------------------------------------
library(signatureSearch)

## ----load_help, eval=FALSE----------------------------------------------------
# library(help="signatureSearch")  # Lists package info
# browseVignettes("signatureSearch")  # Opens vignette

## ----download_db, eval=FALSE--------------------------------------------------
# library(ExperimentHub); library(rhdf5)
# eh <- ExperimentHub()
# cmap <- eh[["EH3223"]]; cmap_expr <- eh[["EH3224"]]
# lincs <- eh[["EH3226"]]; lincs_expr <- eh[["EH3227"]]
# lincs2 <- eh[["EH7297"]]
# h5ls(lincs2)

## ----db_sig, eval=TRUE, message=FALSE-----------------------------------------
db_path <- system.file("extdata", "sample_db.h5", package = "signatureSearch")
# Load sample_db as `SummarizedExperiment` object
library(SummarizedExperiment); library(HDF5Array)
sample_db <- SummarizedExperiment(HDF5Array(db_path, name="assay"))
rownames(sample_db) <- HDF5Array(db_path, name="rownames")
colnames(sample_db) <- HDF5Array(db_path, name="colnames")
# get "vorinostat__SKB__trt_cp" signature drawn from toy database
query_mat <- as.matrix(assay(sample_db[,"vorinostat__SKB__trt_cp"]))
query <- as.numeric(query_mat); names(query) <- rownames(query_mat)
upset <- head(names(query[order(-query)]), 150)
head(upset)
downset <- tail(names(query[order(-query)]), 150)
head(downset)

## ----gess_cmap, eval=TRUE-----------------------------------------------------
qsig_cmap <- qSig(query = list(upset=upset, downset=downset), 
                  gess_method="CMAP", refdb=db_path)
cmap <- gess_cmap(qSig=qsig_cmap, chunk_size=5000, workers=1, addAnnotations = TRUE)
result(cmap)

## ----gess_lincs, eval=TRUE----------------------------------------------------
qsig_lincs <- qSig(query=list(upset=upset, downset=downset), 
                   gess_method="LINCS", refdb=db_path)
lincs <- gess_lincs(qsig_lincs, sortby="NCS", tau=FALSE, workers=1, 
                    addAnnotations = TRUE, GeneType = "reference")
result(lincs)

## ----gess_lincs2, eval=FALSE--------------------------------------------------
# data("lincs_pert_info2")
# qsig_lincs2 <- qSig(query=list(upset=upset, downset=downset),
#                    gess_method="LINCS", refdb="lincs2")
# # When the compound annotation table is not provided
# lincs2 <- gess_lincs(qsig_lincs2, tau=FALSE, sortby="NCS", workers=2)
# # When the compound annotation table is provided
# lincs2 <- gess_lincs(qsig_lincs2, tau=TRUE, sortby="NCS", workers=1,
#                      cmp_annot_tb=lincs_pert_info2, by="pert_id",
#                      cmp_name_col="pert_iname") # takes about 15 minutes
# result(lincs2) %>% print(width=Inf)

## ----gess_gcmap, eval=TRUE----------------------------------------------------
qsig_gcmap <- qSig(query = query_mat, gess_method = "gCMAP", refdb = db_path)
gcmap <- gess_gcmap(qsig_gcmap, higher=1, lower=-1, workers=1, addAnnotations = TRUE)
result(gcmap)

## ----gess_fisher, eval=TRUE, message=FALSE------------------------------------
qsig_fisher <- qSig(query = query_mat, gess_method = "Fisher", refdb = db_path)
fisher <- gess_fisher(qSig=qsig_fisher, higher=1, lower=-1, workers=1, addAnnotations = TRUE)
result(fisher)

## ----gess_fisher_set, eval=FALSE, message=FALSE-------------------------------
# qsig_fisher2 <- qSig(query = list(upset=upset, downset=downset),
#                      gess_method = "Fisher", refdb = db_path)
# fisher2 <- gess_fisher(qSig=qsig_fisher2, higher=1, lower=-1, workers=1, addAnnotations = TRUE)
# result(fisher2)

## ----gess_sp, eval=TRUE-------------------------------------------------------
qsig_sp <- qSig(query=query_mat, gess_method="Cor", refdb=db_path)
sp <- gess_cor(qSig=qsig_sp, method="spearman", workers=1, addAnnotations = TRUE)
result(sp)

## ----gess_spsub, eval=TRUE----------------------------------------------------
# Subset z-scores of 150 up and down gene sets from 
# "vorinostat__SKB__trt_cp" signature.
query_mat_sub <- as.matrix(query_mat[c(upset, downset),])
qsig_spsub <- qSig(query = query_mat_sub, gess_method = "Cor", refdb = db_path)
spsub <- gess_cor(qSig=qsig_spsub, method="spearman", workers=1, addAnnotations = TRUE)
result(spsub)

## ----gess_vis, eval=FALSE-----------------------------------------------------
# vor_qsig_full <- qSig(query = list(upset=upset, downset=downset),
#                    gess_method="LINCS", refdb="lincs")
# vori_res_full <- gess_lincs(qSig=vor_qsig_full, sortby="NCS", tau=TRUE)
# vori_tb <- result(vori_res_full)
# drugs_top10 <- unique(result(lincs)$pert)[1:10]
# drugs_hdac <- c("panobinostat","mocetinostat","ISOX","scriptaid","entinostat",
#       "belinostat","HDAC3-selective","tubastatin-a","tacedinaline","depudecin")
# drugs = c(drugs_top10, drugs_hdac)
# gess_res_vis(vori_tb, drugs = drugs, col = "NCS")

## ----cellntest, eval=TRUE-----------------------------------------------------
# cellNtestPlot(refdb="lincs")
# ggsave("vignettes/images/lincs_cell_ntest.png", width=6, height=8)
knitr::include_graphics("images/lincs_cell_ntest.png")

## ----cell_info, eval=TRUE-----------------------------------------------------
data("cell_info")
library(DT)
datatable(cell_info)

## ----lapply_parallel, eval=FALSE----------------------------------------------
# library(readr)
# batch_queries <- list(q1=list(upset=c("23645", "5290"), downset=c("54957", "2767")),
#                       q2=list(upset=c("27101","65083"), downset=c("5813", "84")))
# refdb <- system.file("extdata", "sample_db.h5", package="signatureSearch")
# gess_list <- lapply(seq_along(batch_queries), function(i){
#     qsig_lincs <- qSig(query = batch_queries[[i]],
#                    gess_method="LINCS", refdb=refdb)
#     lincs <- gess_lincs(qsig_lincs, sortby="NCS", tau=TRUE)
#     if(!dir.exists("batch_res")){
#         dir.create("batch_res")
#     }
#     write_tsv(result(lincs), paste0("batch_res/lincs_res_", i, ".tsv"))
#     return(result(lincs))
# })

## ----multicore, eval=FALSE----------------------------------------------------
# library(BiocParallel)
# f_bp <- function(i){
#     qsig_lincs <- qSig(query = batch_queries[[i]],
#                    gess_method="LINCS", refdb=refdb)
#     lincs <- gess_lincs(qsig_lincs, sortby="NCS", tau=TRUE)
#     if(!dir.exists("batch_res")){
#         dir.create("batch_res")
#     }
#     write_tsv(result(lincs), paste0("batch_res/lincs_res_", i, ".tsv"))
#     return(result(lincs))
# }
# gess_list <- bplapply(seq_along(batch_queries), f_bp, BPPARAM = MulticoreParam(workers = 2))

## ----cluster1, eval=FALSE-----------------------------------------------------
# library(batchtools)
# batch_queries <- list(q1=list(upset=c("23645", "5290"), downset=c("54957", "2767")),
#                       q2=list(upset=c("27101","65083"), downset=c("5813", "84")))
# refdb <- system.file("extdata", "sample_db.h5", package="signatureSearch")
# 
# f_bt <- function(i, batch_queries, refdb){
#     library(signatureSearch)
#     library(readr)
#     qsig_lincs <- qSig(query = batch_queries[[i]],
#                    gess_method="LINCS", refdb=refdb)
#     lincs <- gess_lincs(qsig_lincs, sortby="NCS", tau=TRUE)
#     if(!dir.exists("batch_res")){
#         dir.create("batch_res")
#     }
#     write_tsv(result(lincs), paste0("batch_res/lincs_res_", i, ".tsv"))
#     return(result(lincs)) # or return()
# }

## ----cluster2, eval=FALSE-----------------------------------------------------
# file.copy(system.file("extdata", ".batchtools.conf.R", package="signatureSearch"), ".")
# file.copy(system.file("extdata", "slurm.tmpl", package="signatureSearch"), ".")

## ----cluster3, eval=FALSE-----------------------------------------------------
# reg <- makeRegistry(file.dir="reg_batch", conf.file=".batchtools.conf.R")
# # reg <- loadRegistry(file.dir="reg_batch", conf.file=".batchtools.conf.R", writeable=TRUE)
# Njobs <- 1:2
# ids <- batchMap(fun=f_bt, Njobs, more.args = list(
#           batch_queries=batch_queries, refdb=refdb))
# submitJobs(ids, reg=reg, resources=list(
#       partition="intel", walltime=120, ntasks=1, ncpus=4, memory=10240))
# getStatus()
# waitForJobs() # Wait until all jobs are completed
# res1 <- loadResult(1)
# unlink(c(".batchtools.conf.R", "slurm.tmpl"))

## ----tsea_dup_hyperG_go, eval=TRUE, message=FALSE-----------------------------
drugs <- unique(result(lincs)$pert[1:10])
dup_hyperG_res <- tsea_dup_hyperG(drugs=drugs, universe="Default", 
                                  type="GO", ont="MF", pvalueCutoff=0.05, 
                                  pAdjustMethod="BH", qvalueCutoff=0.1, 
                                  minGSSize=10, maxGSSize=500)
dup_hyperG_res

## ----tsea_dup_hyperG_go_result, eval=TRUE-------------------------------------
result(dup_hyperG_res)

## ----tsea_dup_hyperG_kegg, eval=TRUE, message=FALSE---------------------------
dup_hyperG_k_res <- tsea_dup_hyperG(drugs=drugs, universe="Default", type="KEGG",
                                    pvalueCutoff=0.5, pAdjustMethod="BH", qvalueCutoff=0.5,
                                    minGSSize=10, maxGSSize=500)
result(dup_hyperG_k_res)
## Mapping 'itemID' column in the FEA enrichment result table from Entrez ID to gene Symbol
set_readable(result(dup_hyperG_k_res))

## ----tsea_dup_hyperG_reactome, eval=TRUE, message=FALSE-----------------------
dup_rct_res <- tsea_dup_hyperG(drugs=drugs, type="Reactome",
                               pvalueCutoff=0.5, qvalueCutoff=0.5, readable=TRUE)
result(dup_rct_res)

## ----tsea_mgsea_go, eval=TRUE, message=FALSE----------------------------------
mgsea_res <- tsea_mGSEA(drugs=drugs, type="GO", ont="MF", exponent=1, 
                        nPerm=1000, pvalueCutoff=1, minGSSize=5)
result(mgsea_res)

## ----tsea_mgsea_kegg, eval=TRUE, message=FALSE--------------------------------
mgsea_k_res <- tsea_mGSEA(drugs=drugs, type="KEGG", exponent=1, 
                          nPerm=1000, pvalueCutoff=1, minGSSize=2)
result(mgsea_k_res)

## ----tsea_mgsea_rct, eval=TRUE, message=FALSE---------------------------------
mgsea_rct_res <- tsea_mGSEA(drugs=drugs, type="Reactome", pvalueCutoff=1,
                            readable=TRUE)
result(mgsea_rct_res)

## ----tsea_mabs_go, eval=TRUE, message=FALSE-----------------------------------
mabs_res <- tsea_mabs(drugs=drugs, type="GO", ont="MF", nPerm=1000, 
                      pvalueCutoff=0.05, minGSSize=5)
result(mabs_res)

## ----tsea_mabs_kegg, eval=TRUE, message=FALSE---------------------------------
mabs_k_res <- tsea_mabs(drugs=drugs, type="KEGG", nPerm=1000, 
                        pvalueCutoff=0.2, minGSSize=5)
result(mabs_k_res)

## ----tsea_mabs_rct, eval=TRUE, message=FALSE----------------------------------
mabs_rct_res <- tsea_mabs(drugs=drugs, type="Reactome", pvalueCutoff=1,
                          readable=TRUE)
result(mabs_rct_res)

## ----dsea_hyperG_go, eval=TRUE, message=FALSE---------------------------------
drugs <- unique(result(lincs)$pert[1:10])
hyperG_res <- dsea_hyperG(drugs=drugs, type="GO", ont="MF")
result(hyperG_res)

## ----dsea_hyperG_kegg, eval=TRUE, message=FALSE-------------------------------
hyperG_k_res <- dsea_hyperG(drugs = drugs, type = "KEGG", 
                            pvalueCutoff = 1, qvalueCutoff = 1, 
                            minGSSize = 10, maxGSSize = 2000)
result(hyperG_k_res)

## ----dsea_gsea_go, eval=TRUE--------------------------------------------------
dl <- abs(result(lincs)$NCS); names(dl) <- result(lincs)$pert
dl <- dl[dl>0]
dl <- dl[!duplicated(names(dl))]
gsea_res <- dsea_GSEA(drugList=dl, type="GO", ont="MF", exponent=1, nPerm=1000,
                      pvalueCutoff=0.2, minGSSize=5)
result(gsea_res)

## ----dsea_gsea_kegg, eval=TRUE, message=FALSE---------------------------------
gsea_k_res <- dsea_GSEA(drugList=dl, type="KEGG", exponent=1, nPerm=1000, 
                        pvalueCutoff=1, minGSSize=5)
result(gsea_k_res)

## ----cmp_enrich, eval=TRUE, fig.width=10.5, fig.height=5.5--------------------
table_list = list("dup_hyperG" = result(dup_hyperG_res), 
                  "mGSEA" = result(mgsea_res), 
                  "mabs" = result(mabs_res), 
                  "hyperG" = result(hyperG_res), 
                  "GSEA" = result(gsea_res))
comp_fea_res(table_list, rank_stat="pvalue", Nshow=20)

## ----cmp_enrich_k, eval=TRUE, fig.width=8-------------------------------------
table_list = list("dup_hyperG" = result(dup_hyperG_k_res), 
                  "mGSEA" = result(mgsea_k_res), 
                  "mabs" = result(mabs_k_res), 
                  "hyperG" = result(hyperG_k_res), 
                  "GSEA" = result(gsea_k_res))
comp_fea_res(table_list, rank_stat="pvalue", Nshow=20)

## ----dtnet_go_0032041, eval=TRUE----------------------------------------------
dtnetplot(drugs = drugs(dup_hyperG_res), set = "GO:0032041", ont = "MF", 
          desc="NAD-dependent histone deacetylase activity (H3-K14 specific)")

## ----dtnet_go_0051059, eval=TRUE----------------------------------------------
dtnetplot(drugs = drugs(dup_hyperG_res), set = "GO:0051059", ont = "MF", 
          desc="NF-kappaB binding")

## ----dtnet_kegg_05034, eval=TRUE----------------------------------------------
dtnetplot(drugs = drugs(dup_hyperG_k_res), set = "hsa05034", 
          desc="Alcoholism")

## ----dtnet_kegg_04213, eval=TRUE----------------------------------------------
dtnetplot(drugs = drugs, set = "hsa04213", 
          desc="Longevity regulating pathway - multiple species")

## ----runwf, eval=FALSE--------------------------------------------------------
# drug <- "vorinostat"; cell <- "SKB"
# refdb <- system.file("extdata", "sample_db.h5", package="signatureSearch")
# env_dir <- tempdir()
# wf_list <- runWF(drug, cell, refdb, gess_method="LINCS",
#     fea_method="dup_hyperG", N_gess_drugs=10, env_dir=env_dir, tau=FALSE)

## ----gmt_query, eval=FALSE----------------------------------------------------
# msig <- read_gmt("msigdb.v7.1.entrez.gmt") # 25,724
# db_path <- system.file("extdata", "sample_db.h5", package = "signatureSearch")

## ----gene_no_label, eval=FALSE------------------------------------------------
# gene_set <- msig[["GO_GROWTH_HORMONE_RECEPTOR_BINDING"]]
# # CMAP method
# cmap_qsig <- qSig(query=list(upset=gene_set), gess_method="CMAP", refdb=db_path)
# cmap_res <- gess_cmap(cmap_qsig, workers=1)
# # LINCS method
# lincs_qsig <- qSig(query=list(upset=gene_set), gess_method="LINCS", refdb=db_path)
# lincs_res <- gess_lincs(lincs_qsig, workers=1)
# # Fisher methods
# fisher_qsig <- qSig(query=list(upset=gene_set), gess_method="Fisher", refdb=db_path)
# fisher_res <- gess_fisher(fisher_qsig, higher=1, lower=-1, workers=1)

## ----gene_label, eval=FALSE---------------------------------------------------
# gene_set_up <- msig[["GSE17721_0.5H_VS_24H_POLYIC_BMDC_UP"]]
# gene_set_down <- msig[["GSE17721_0.5H_VS_24H_POLYIC_BMDC_DN"]]
# # CMAP method
# cmap_qsig <- qSig(query=list(upset=gene_set_up, downset=gene_set_down),
#                   gess_method="CMAP", refdb=db_path)
# cmap_res <- gess_cmap(cmap_qsig, workers=1)
# # LINCS method
# lincs_qsig <- qSig(query=list(upset=gene_set_up, downset=gene_set_down),
#                    gess_method="LINCS", refdb=db_path)
# lincs_res <- gess_lincs(lincs_qsig, workers=1)
# # Fisher methods
# fisher_qsig <- qSig(query=list(upset=gene_set_up, downset=gene_set_down),
#                     gess_method="Fisher", refdb=db_path)
# fisher_res <- gess_fisher(fisher_qsig, higher=1, lower=-1, workers=1)

## ----gn_ref, eval=FALSE-------------------------------------------------------
# gmt2h5(gmtfile="./msigdb.v7.1.entrez.gmt", dest_h5="./msigdb.h5", by_nset=1000,
#        overwrite=TRUE)
# 
# # gCMAP method
# query_mat <- getSig(cmp="vorinostat", cell="SKB", refdb=db_path)
# gcmap_qsig2 <- qSig(query=query_mat, gess_method="gCMAP", refdb="./msigdb.h5")
# gcmap_res2 <- gess_gcmap(gcmap_qsig2, higher=1, workers=1, chunk_size=2000)
# 
# # Fisher method
# msig <- read_gmt("msigdb.v7.1.entrez.gmt")
# gene_set <- msig[["GO_GROWTH_HORMONE_RECEPTOR_BINDING"]]
# fisher_qsig2 <- qSig(query=list(upset=gene_set), gess_method="Fisher",
#                     refdb="./msigdb.h5")
# fisher_res2 <- gess_fisher(fisher_qsig2, higher=1, workers=1, chunk_size=2000)

## ----gn_ref_mouse, eval=FALSE-------------------------------------------------
# gmt2h5(gmtfile="./mGSKB_Entrez.gmt", dest_h5="./mGSKB.h5", by_nset=1000,
#        overwrite=TRUE)
# 
# # gCMAP method
# ## Construct a toy query (here matrix)
# gskb <- read_gmt("mGSKB_Entrez.gmt") # 41,546
# mgenes <- unique(unlist(gskb))
# ranks <- rev(seq_along(mgenes))
# mquery <- matrix(ranks, ncol=1)
# rownames(mquery) <- mgenes; colnames(mquery) <- "MAKE_UP"
# gcmap_qsig3 <- qSig(query=mquery, gess_method="gCMAP",
#                     refdb="./mGSKB.h5")
# gcmap_res3 <- gess_gcmap(gcmap_qsig3, higher=1, workers=1, chunk_size=2000)
# 
# # Fisher method
# gene_set <- gskb[["LIT_MM_HOFFMANN_PRE-BI_VS_LARGE-PRE-BII-CELL_DIFF_Entrez"]]
# fisher_qsig3 <- qSig(query=list(upset=gene_set), gess_method="Fisher",
#                     refdb="./mGSKB.h5")
# fisher_res3 <- gess_fisher(fisher_qsig3, higher=1, workers=1, chunk_size=2000)

## ----gen_toy_db, eval=FALSE---------------------------------------------------
# library(rhdf5)
# eh <- ExperimentHub::ExperimentHub()
# lincs <- eh[["EH3226"]]
# hdacs <- c("vorinostat","trichostatin-a","pyroxamide","HC-toxin","rhamnetin")
# hdacs_trts <- paste(hdacs, "SKB", "trt_cp", sep="__")
# all_trts <- drop(h5read(lincs, "colnames"))
# # Select treatments in SKB cell and not BRD compounds
# all_trts2 <- all_trts[!grepl("BRD-", all_trts) & grepl("__SKB__", all_trts)]
# set.seed(11)
# rand_trts <- sample(setdiff(all_trts2, hdacs_trts), 95)
# toy_trts <- c(hdacs_trts, rand_trts)
# library(SummarizedExperiment); library(HDF5Array)
# toy_db <- SummarizedExperiment(HDF5Array(lincs, name="assay"))
# rownames(toy_db) <- HDF5Array(db_path, name="rownames")
# colnames(toy_db) <- HDF5Array(db_path, name="colnames")
# toy_db <- round(as.matrix(assay(toy_db)[,toy_trts]),2)
# set.seed(11)
# gene_idx <- sample.int(nrow(toy_db),5000)
# toy_db2 <- toy_db[gene_idx,]
# # The sample_db is stored in the current directory of user's R session
# getwd()
# createEmptyH5("sample_db.h5", level=9, delete_existing=TRUE)
# append2H5(toy_db2, "sample_db.h5")
# h5ls("sample_db.h5")

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

