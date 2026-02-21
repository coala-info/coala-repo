# Code example from 'Input_Data' vignette. See references/ for full tutorial.

## ----set-options, echo=FALSE, cache=FALSE-------------------------------------
options(stringsAsFactors = FALSE, warning = FALSE, message = FALSE)

## ----eval = FALSE-------------------------------------------------------------
# BiocManager::install("TADCompare")

## -----------------------------------------------------------------------------
library(dplyr)
library(SpectralTAD)
library(TADCompare)

## ----echo = FALSE-------------------------------------------------------------
data("rao_chr22_prim")
row.names(rao_chr22_prim) <- colnames(rao_chr22_prim) <- format(as.numeric(row.names(rao_chr22_prim)), scientific = FALSE)
coords <- 200:275
pheatmap::pheatmap(log10(rao_chr22_prim[coords, coords]), cluster_rows = FALSE, cluster_cols = FALSE)

## ----echo = FALSE-------------------------------------------------------------
coords  <- 50:53
sub_mat <- data.frame(chr = "chr22", start = as.numeric(colnames(rao_chr22_prim[coords, coords])), end   = as.numeric(colnames(rao_chr22_prim[coords, coords])) + 50000, rao_chr22_prim[coords, coords]) 
row.names(sub_mat) = NULL
sub_mat

## ----echo = FALSE-------------------------------------------------------------
data("rao_chr22_prim") 
head(HiCcompare::full2sparse(rao_chr22_prim))

## ----eval=FALSE---------------------------------------------------------------
# #Read in data
# primary = read.table('primary.chr22.50kb.txt', header = FALSE)
# replicate = read.table('replicate.chr22.50kb.txt', header = FALSE)
# #Run TADCompare
# tad_diff=TADCompare(primary, replicate, resolution=50000)

## ----eval = FALSE-------------------------------------------------------------
# # Read in data
# cool_mat1 <- read.table("Zuin.HEK293.50kb.Control.txt")
# cool_mat2 <- read.table("Zuin.HEK293.50kb.Depleted.txt")
# 
# # Convert to sparse 3-column matrix using cooler2sparse from HiCcompare
# sparse_mat1 <- HiCcompare::cooler2sparse(cool_mat1)
# sparse_mat2 <- HiCcompare::cooler2sparse(cool_mat2)
# 
# # Run TADCompare
# diff_tads = lapply(names(sparse_mat1), function(x) {
#   TADCompare(sparse_mat1[[x]], sparse_mat2[[x]], resolution = 50000)
# })

## ----eval = FALSE-------------------------------------------------------------
# # Read in both files
# mat1 <- read.table("sample1_100000.matrix")
# bed1 <- read.table("sample1_100000_abs.bed")
# 
# # Matrix 2
# 
# mat2 <- read.table("sample2_100000.matrix")
# bed2 <- read.table("sample2_100000_abs.bed")
# 
# # Convert to modified bed format
# sparse_mats1 <- HiCcompare::hicpro2bedpe(mat1,bed1)
# sparse_mats2 <- HiCcompare::hicpro2bedpe(mat2,bed2)
# 
# # Remove empty matrices if necessary
# # sparse_mats$cis = sparse_mats$cis[sapply(sparse_mats, nrow) != 0]
# 
# 
# # Go through all pairwise chromosomes and run TADCompare
# sparse_tads = lapply(1:length(sparse_mats1$cis), function(z) {
#   x <- sparse_mats1$cis[[z]]
#   y <- sparse_mats2$cis[[z]]
# 
#   #Pull out chromosome
#   chr <- x[, 1][1]
#   #Subset to make three column matrix
#   x <- x[, c(2, 5, 7)]
#   y <- y[, c(2, 5, 7)]
#   #Run SpectralTAD
#   comp <- TADCompare(x, y, resolution = 100000)
#   return(list(comp, chr))
# })
# 
# # Pull out differential TAD results
# diff_res <- lapply(sparse_tads, function(x) x$comp)
# # Pull out chromosomes
# chr      <- lapply(sparse_tads, function(x) x$chr)
# # Name list by corresponding chr
# names(diff_res) <- chr

## ----message=FALSE------------------------------------------------------------
library(microbenchmark)
# Reading in the second matrix
data("rao_chr22_rep")
# Converting to sparse
prim_sparse <- HiCcompare::full2sparse(rao_chr22_prim)
rep_sparse  <- HiCcompare::full2sparse(rao_chr22_rep)
# Converting to nxn+3
# Primary
prim_n_n_3 <- data.frame(chr = "chr22",
                         start = as.numeric(colnames(rao_chr22_prim)),
                         end = as.numeric(colnames(rao_chr22_prim))+50000, 
                         rao_chr22_prim)

# Replicate
rep_n_n_3 <- data.frame(chr = "chr22", 
                        start = as.numeric(colnames(rao_chr22_rep)),
                        end = as.numeric(colnames(rao_chr22_rep))+50000,
                        rao_chr22_rep)
# Defining each function
# Sparse
sparse <- TADCompare(cont_mat1 = prim_sparse, cont_mat2 = rep_sparse, resolution = 50000)
# NxN
n_by_n <- TADCompare(cont_mat1 = prim_sparse, cont_mat2 = rep_sparse, resolution = 50000)
# Nx(N+3)
n_by_n_3 <- TADCompare(cont_mat1 = prim_n_n_3, cont_mat2 = rep_n_n_3, resolution = 50000)

# Benchmarking different parameters
bench <- microbenchmark(
# Sparse
sparse <- TADCompare(cont_mat1 = prim_sparse, cont_mat2 = rep_sparse, resolution = 50000),
# NxN
n_by_n <- TADCompare(cont_mat1 = rao_chr22_prim, cont_mat2 = rao_chr22_rep, resolution = 50000),
# Nx(N+3)
n_by_n_3 <- TADCompare(cont_mat1 = prim_n_n_3, cont_mat2 = rep_n_n_3, resolution = 50000), times = 5, unit = "s"
) 

summary_bench <- summary(bench) %>% dplyr::select(mean, median)
rownames(summary_bench) <- c("sparse", "n_by_n", "n_by_n_3")
summary_bench

## -----------------------------------------------------------------------------
sessionInfo()

