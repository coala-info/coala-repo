# Code example from 'mslp' vignette. See references/ for full tutorial.

## ----echo = FALSE, message = FALSE--------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment  = "#>"
)

## ----eval = FALSE-------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("mslp")
# BiocManager::install("data.table")

## ----eval = FALSE-------------------------------------------------------------
# #- Preprocessing the data.
# #- Path to input files.
# library(mslp)
# P_mut  <- "data_mutations_extended.txt"
# P_cna  <- "data_CNA.txt"
# P_expr <- "data_RNA_Seq_v2_expression_median.txt"
# P_z    <- "data_RNA_Seq_v2_mRNA_median_Zscores.txt"
# 
# res <- pp_tcga(P_mut, P_cna, P_expr, P_z)
# 
# saveRDS(res$mut_data, "mut_data.rds")
# saveRDS(res$expr_data, "expr_data.rds")
# saveRDS(res$zscore_data, "zscore_data.rds")

## -----------------------------------------------------------------------------
require(future)
require(doFuture)
library(magrittr)
library(mslp)
library(data.table)

#- mutation from TCGA datasets to computate SLP via comp_slp
data(example_comp_mut)
#- mutation from TCGA datasets to computate SLP via corr_slp.
data(example_corr_mut)
data(example_expr)
data(example_z)

## -----------------------------------------------------------------------------
plan(multisession, workers = 2)
res_comp <- comp_slp(example_z, example_comp_mut)
saveRDS(res_comp, file = "compSLP_res.rds")
plan(sequential)

## -----------------------------------------------------------------------------
plan(multisession, workers = 2)
res_corr <- corr_slp(example_expr, example_corr_mut)
saveRDS(res_corr, "corrSLP_res.rds")

#- Filter res by importance threshold to reduce false positives.
im_thresh <- 0.0016
res_f     <- res_corr[im >= im_thresh]
plan(sequential)

## -----------------------------------------------------------------------------
plan(multisession, workers = 2)
#- Random mutations and runs
mutgene    <- sample(intersect(example_corr_mut$mut_entrez, rownames(example_expr)), 5)
nperm      <- 3
res_random <- lapply(seq_len(nperm), function(x) corr_slp(example_expr, example_corr_mut, mutgene = mutgene))
im_res     <- est_im(res_random)
res_f_2    <- res_corr[im >= mean(im_res$roc_thresh)]
plan(sequential)

## ----eval = FALSE-------------------------------------------------------------
# library(readxl)
# 
# #- nature11003-s3.xls is available in the supplementary data of CCLE publication.
# ccle <- readxl::read_excel("nature11003-s3.xls", sheet = "Table S1", skip = 2) %>%
#   as.data.frame %>%
#   set_names(gsub(" ", "_", names(.))) %>%
#   as.data.table %>%
#   .[, CCLE_name := toupper(CCLE_name)] %>%
#   unique
# 
# #- Only use the Nonsynonymous Mutations. CCLE_DepMap_18Q1_maf_20180207.txt can be downloaded from the CCLE website.
# #- Only need the columns of cell_line and mut_entrez.
# mut_type  <- c("Missense_Mutation", "Nonsense_Mutation", "Frame_Shift_Del", "Frame_Shift_Ins", "In_Frame_Del", "In_Frame_Ins", "Nonstop_Mutation")
# ccle_mut  <- fread("CCLE_DepMap_18Q1_maf_20180207.txt") %>%
#   .[Variant_Classification %in% mut_type] %>%
#   .[, Tumor_Sample_Barcode := toupper(Tumor_Sample_Barcode)] %>%
#   .[, Entrez_Gene_Id := as.character(Entrez_Gene_Id)] %>%
#   .[, .(Tumor_Sample_Barcode, Entrez_Gene_Id)] %>%
#   unique %>%
#   setnames(c("cell_line", "mut_entrez"))
# 
# #- Select brca cell lines
# brca_ccle_mut <- ccle_mut[cell_line %in% unique(ccle[CCLE_tumor_type == "breast"])]

## -----------------------------------------------------------------------------
plan(multisession, workers = 2)
#- Merge data.
#- Load previous results.
res_comp   <- readRDS("compSLP_res.rds")
res_corr   <- readRDS("corrSLP_res.rds")
merged_res <- merge_slp(res_comp, res_corr)

#- Toy hits data.
screen_1 <- merged_res[, .(slp_entrez, slp_symbol)] %>%
    unique %>%
    .[sample(nrow(.), round(.8 * nrow(.)))] %>%
    setnames(c(1, 2), c("screen_entrez", "screen_symbol")) %>%
    .[, cell_line := "cell_1"]

screen_2 <- merged_res[, .(slp_entrez, slp_symbol)] %>%
    unique %>%
    .[sample(nrow(.), round(.8 * nrow(.)))] %>%
    setnames(c(1, 2), c("screen_entrez", "screen_symbol")) %>%
    .[, cell_line := "cell_2"]

screen_hit <- rbind(screen_1, screen_2)

#- Toy mutation data.
mut_1 <- merged_res[, .(mut_entrez)] %>%
    unique %>%
    .[sample(nrow(.), round(.8 * nrow(.)))] %>%
    .[, cell_line := "cell_1"]

mut_2 <- merged_res[, .(mut_entrez)] %>%
    unique %>%
    .[sample(nrow(.), round(.8 * nrow(.)))] %>%
    .[, cell_line := "cell_2"]

mut_info <- rbind(mut_1, mut_2)

#- Hits that are identified as SLPs.
scr_res <- lapply(c("cell_1", "cell_2"), scr_slp, screen_hit, mut_info, merged_res)
scr_res[lengths(scr_res) == 0] <- NULL
scr_res <- rbindlist(scr_res)

k_res   <- cons_slp(scr_res, merged_res)
#- Filter results, e.g., by kappa_value and padj.
k_res_f <- k_res[kappa_value >= 0.6 & padj <= 0.1]

plan(sequential)

sessionInfo()

