# Code example from 'signatureSearchData' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE, messages=FALSE, warnings=FALSE------------------------
suppressPackageStartupMessages({
    library(signatureSearchData)
})
# knitr::opts_knit$set(root.dir = "~/insync/project/longevityTools_eDRUG/")

## ----install, eval=FALSE------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("signatureSearchData")

## ----load, eval=FALSE---------------------------------------------------------
# library(signatureSearchData)

## ----eh_explore_ssd1, eval=TRUE, warning=FALSE, message=FALSE-----------------
library(ExperimentHub)
eh <- ExperimentHub()
ssd <- query(eh, c("signatureSearchData"))
ssd

## ----eh_explore_ssd2, eval=TRUE, warning=FALSE, message=FALSE-----------------
ssd$title

## ----eh_explore_ssd3, eval=TRUE-----------------------------------------------
as.list(ssd)[10]

## ----lincs, eval=FALSE--------------------------------------------------------
# library(ExperimentHub); library(rhdf5)
# eh <- ExperimentHub()
# query(eh, c("signatureSearchData", "lincs"))
# lincs_path <- eh[['EH3226']]
# rhdf5::h5ls(lincs_path)

## ----filter_meta42, eval=FALSE------------------------------------------------
# meta42 <- readr::read_tsv("./data/GSE92742_Broad_LINCS_sig_info.txt")
# dose <- meta42$pert_idose[7]
# ## filter rows by 'pert_type' as compound, 10uM concentration, and 24h treatment time
# meta42_filter <- sig_filter(meta42, pert_type="trt_cp", dose=dose, time="24 h") # 45956 X 14

## ----extract_modz, eval=FALSE-------------------------------------------------
# library(signatureSearch)
# gctx <- "./data/GSE92742_Broad_LINCS_Level5_COMPZ.MODZ_n473647x12328.gctx"
# gctx2h5(gctx, cid=meta42_filter$sig_id, new_cid=meta42_filter$pert_cell_factor,
#         h5file="./data/lincs.h5", by_ncol=5000, overwrite=TRUE)
# library(HDF5Array)
# se <- SummarizedExperiment(HDF5Array("./data/lincs.h5", name="assay"))
# rownames(se) <- HDF5Array("./data/lincs.h5", name="rownames")
# colnames(se) <- HDF5Array("./data/lincs.h5", name="colnames")

## ----lincs_degs, eval=FALSE---------------------------------------------------
# library(signatureSearch)
# # Get up and down 150 DEGs
# degs <- getDEGSig(cmp="vorinostat", cell="SKB", refdb="lincs", Nup=150, Ndown=150)
# 
# # Get DEGs by setting cutoffs
# degs2 <- getDEGSig(cmp="vorinostat", cell="SKB", refdb="lincs", higher=2, lower=-2)

## ----lincs_degs_db, eval=FALSE------------------------------------------------
# # gCMAP method
# gep <- getSig("vorinostat", "SKB", refdb="lincs")
# qsig_gcmap <- qSig(query = gep, gess_method = "gCMAP", refdb = "lincs")
# gcmap_res <- gess_gcmap(qsig_gcmap, higher=2, lower=-2)
# # Fisher method
# qsig_fisher <- qSig(query = degs, gess_method = "Fisher", refdb = "lincs")
# fisher_res <- gess_fisher(qSig=qsig_fisher, higher=2, lower=-2)

## ----lincs_expr, eval=FALSE---------------------------------------------------
# library(ExperimentHub)
# eh <- ExperimentHub()
# query(eh, c("signatureSearchData", "lincs_expr"))
# lincs_expr_path <- eh[['EH3227']]

## ----filter_expr, eval=FALSE--------------------------------------------------
# inst42 <- readr::read_tsv("./data/GSE92742_Broad_LINCS_inst_info.txt")
# inst42_filter <- inst_filter(inst42, pert_type="trt_cp", dose=10, dose_unit="um",
#                              time=24, time_unit="h") # 169,795 X 13

## ----extract_expr, eval=FALSE-------------------------------------------------
# # It takes some time
# library(signatureSearch)
# meanExpr2h5(gctx="./data/GSE92742_Broad_LINCS_Level3_INF_mlr12k_n1319138x12328.gctx",
#             inst=inst42_filter, h5file="./data/lincs_expr.h5") # 12328 X 38824

## ----lincs2, eval=FALSE-------------------------------------------------------
# library(ExperimentHub); library(rhdf5)
# eh <- ExperimentHub()
# query(eh, c("signatureSearchData", "lincs2"))
# lincs2_path <- eh[['EH7297']]
# rhdf5::h5ls(lincs2_path)

## ----lincs2_hdf5, eval=FALSE--------------------------------------------------
# siginfo_beta <- fread("https://s3.amazonaws.com/macchiato.clue.io/builds/LINCS2020/siginfo_beta.txt")
# exemplar <- siginfo_beta %>% filter(pert_type=="trt_cp" & is_exemplar_sig == 1)
# new_cid <- paste(exemplar$pert_id, exemplar$cell_iname, rep("trt_cp", length(exemplar$cmap_name)), sep="__")
# gctx2h5("level5_beta_trt_cp_n720216x12328.gctx", cid=exemplar$sig_id, new_cid=new_cid,
#         h5file="lincs2.h5", by_ncol=5000, overwrite=TRUE)
# DBpath <- "lincs2.h5"
# sedb <- SummarizedExperiment(HDF5Array(DBpath, name="assay"))
# rownames(sedb) <- HDF5Array(DBpath, name="rownames")
# colnames(sedb) <- HDF5Array(DBpath, name="colnames")

## ----cmap_rank, eval=FALSE----------------------------------------------------
# library(ExperimentHub)
# eh <- ExperimentHub()
# query(eh, c("signatureSearchData", "cmap_rank"))
# cmap_rank_path <- eh[["EH3225"]]
# se <- SummarizedExperiment(HDF5Array(cmap_rank_path, name="assay"))
# rownames(se) <- HDF5Array(cmap_rank_path, name="rownames")
# colnames(se) <- HDF5Array(cmap_rank_path, name="colnames")

## ----filter_rankm, eval=FALSE-------------------------------------------------
# path <- system.file("extdata", "cmap_instances_02.txt", package="signatureSearchData")
# cmap_inst <- read.delim(path, check.names=FALSE)
# inst_id <- cmap_inst$instance_id[!duplicated(paste(cmap_inst$cmap_name, cmap_inst$cell2, sep="_"))]
# rankM <- read.delim("./data/rankMatrix.txt", check.names=FALSE, row.names=1) # 22283 X 6100
# rankM_sub <- rankM[, as.character(inst_id)]
# colnames(rankM_sub) <- unique(paste(cmap_inst$cmap_name, cmap_inst$cell2, "trt_cp", sep="__"))

## ----affyid_annot, eval=FALSE, message=FALSE----------------------------------
# library(hgu133a.db)
# myAnnot <- data.frame(ACCNUM=sapply(contents(hgu133aACCNUM), paste, collapse=", "),
#                       SYMBOL=sapply(contents(hgu133aSYMBOL), paste, collapse=", "),
#                       UNIGENE=sapply(contents(hgu133aUNIGENE), paste, collapse=", "),
#                       ENTREZID=sapply(contents(hgu133aENTREZID), paste, collapse=", "),
#                       ENSEMBL=sapply(contents(hgu133aENSEMBL), paste, collapse=", "),
#                       DESC=sapply(contents(hgu133aGENENAME), paste, collapse=", "))
# saveRDS(myAnnot, "./data/myAnnot.rds")

## ----mr_prob, eval=FALSE------------------------------------------------------
# rankM_sub_gene <- probe2gene(rankM_sub, myAnnot)

## ----cmap_rank2h5, eval=FALSE-------------------------------------------------
# matrix2h5(rankM_sub_gene, "./data/cmap_rank.h5", overwrite=TRUE) # 12403 X 3587
# rhdf5::h5ls("./data/cmap_rank.h5")
# ## Read in cmap_rank.h5 as SummarizedExperiment object
# se <- SummarizedExperiment(HDF5Array("./data/cmap_rank.h5", name="assay"))
# rownames(se) <- HDF5Array("./data/cmap_rank.h5", name="rownames")
# colnames(se) <- HDF5Array("./data/cmap_rank.h5", name="colnames")

## ----cmap_expr, eval=FALSE----------------------------------------------------
# library(ExperimentHub)
# eh <- ExperimentHub()
# query(eh, c("signatureSearchData", "cmap_expr"))
# cmap_expr_path <- eh[["EH3224"]]

## ----work_envir, eval=FALSE---------------------------------------------------
# dir.create("data"); dir.create("data/CEL"); dir.create("results")

## ----download_cmap, eval=FALSE------------------------------------------------
# getCmapCEL(rerun=FALSE)

## ----get_cel_type, eval=FALSE-------------------------------------------------
# library(affxparser)
# celfiles <- list.files("./data/CEL", pattern=".CEL$")
# chiptype <- sapply(celfiles, function(x) affxparser::readCelHeader(paste0("data/CEL/", x))$chiptype)
# saveRDS(chiptype, "./data/chiptype.rds")

## ----normalize_chips, eval=FALSE----------------------------------------------
# chiptype <- readRDS("./data/chiptype.rds")
# chiptype_list <- split(names(chiptype), as.character(chiptype))
# normalizeCel(chiptype_list, batchsize=200, rerun=FALSE)

## ----comb_chip_type_data, eval=FALSE------------------------------------------
# chiptype_dir <- unique(chiptype)
# combineResults(chiptype_dir, rerun=FALSE)
# mas5df <- combineNormRes(chiptype_dir, norm_method="MAS5")

## ----prof2gene, eval=FALSE----------------------------------------------------
# myAnnot <- readRDS("./data/myAnnot.rds")
# mas5df <- probe2gene(mas5df, myAnnot)
# saveRDS(mas5df,"./data/mas5df.rds")

## ----rma2cmap_expr, eval=FALSE------------------------------------------------
# mas5df <- readRDS("./data/mas5df.rds") # dim: 12403 x 7056
# path <- system.file("extdata", "cmap_instances_02.txt", package="signatureSearchData")
# cmap_inst <- read.delim(path, check.names=FALSE)
# cmap_drug_cell_expr <- meanExpr(mas5df, cmap_inst) # dim: 12403 X 3587
# saveRDS(cmap_drug_cell_expr, "./data/cmap_drug_cell_expr.rds")

## ----gen_cmap_expr, eval=FALSE------------------------------------------------
# cmap_drug_cell_expr <- readRDS("./data/cmap_drug_cell_expr.rds")
# ## match colnames to '(drug)__(cell)__(factor)' format
# colnames(cmap_drug_cell_expr) <- gsub("(^.*)_(.*$)", "\\1__\\2__trt_cp",
#                                       colnames(cmap_drug_cell_expr))
# matrix2h5(cmap_drug_cell_expr, "./data/cmap_expr.h5", overwrite=TRUE)
# h5ls("./data/cmap_expr.h5")

## ----cmap, eval=FALSE---------------------------------------------------------
# library(ExperimentHub)
# eh <- ExperimentHub()
# query(eh, c("signatureSearchData", "cmap"))
# cmap_path <- eh[["EH3223"]]

## ----cel_file_list, eval=FALSE------------------------------------------------
# path <- system.file("extdata", "cmap_instances_02.txt", package="signatureSearchData")
# cmap_inst <- read.delim(path, check.names=FALSE)
# comp_list <- sampleList(cmap_inst, myby="CMP_CELL")

## ----deg_limma, eval=FALSE----------------------------------------------------
# mas5df <- readRDS("./data/mas5df.rds")
# degList <- runLimma(df=log2(mas5df), comp_list, fdr=0.10, foldchange=1, verbose=TRUE)
# saveRDS(degList, "./results/degList.rds") # saves entire degList

## ----se, eval=FALSE-----------------------------------------------------------
# degList <- readRDS("./results/degList.rds")
# logMA <- degList$logFC
# ## match colnames of logMA to '(drug)__(cell)__(factor)' format
# colnames(logMA) <- gsub("(^.*)_(.*$)", "\\1__\\2__trt_cp", colnames(logMA))
# fdr <- degList$FDR
# colnames(fdr) <- gsub("(^.*)_(.*$)", "\\1__\\2__trt_cp", colnames(fdr))
# matrix2h5(logMA, "./data/cmap.h5", name="assay", overwrite=TRUE) # 12403 X 3478
# matrix2h5(fdr, "./data/cmap.h5", name="padj", overwrite=FALSE)
# rhdf5::h5ls("./data/cmap.h5")

## ----cmap_degs, eval=FALSE----------------------------------------------------
# library(signatureSearch)
# # Get up and down 150 DEGs
# degs <- getDEGSig(cmp="vorinostat", cell="PC3", refdb="cmap", Nup=150, Ndown=150)
# 
# # Get DEGs by setting cutoffs
# degs2 <- getDEGSig(cmp="vorinostat", cell="PC3", refdb="cmap",
#                  higher=1, lower=-1, padj=0.05)

## ----cmap_degs_db, eval=FALSE-------------------------------------------------
# # gCMAP method
# gep <- getSig("vorinostat", "PC3", refdb="cmap")
# qsig_gcmap <- qSig(query = gep, gess_method = "gCMAP", refdb = "cmap")
# gcmap_res <- gess_gcmap(qsig_gcmap, higher=1, lower=-1, padj=0.05)
# # Fisher method
# qsig_fisher <- qSig(query = degs, gess_method = "Fisher", refdb = "cmap")
# fisher_res <- gess_fisher(qSig=qsig_fisher, higher=1, lower=-1, padj=0.05)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

