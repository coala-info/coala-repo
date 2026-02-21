# Code example from 'SpectralTAD' vignette. See references/ for full tutorial.

## ----set-options, echo=FALSE, cache=FALSE---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
options(width = 400)

## ----eval = FALSE, message=FALSE------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# # if (!requireNamespace("BiocManager", quietly=TRUE))
# #     install.packages("BiocManager")
# # BiocManager::install("SpectralTAD")
# devtools::install_github("dozmorovlab/SpectralTAD")
# library(SpectralTAD)

## ----echo=FALSE, message=FALSE, warning=FALSE-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
library(SpectralTAD)

## ----echo = FALSE, warning = FALSE, message = FALSE-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
data("rao_chr20_25_rep")
rao_chr20_25_rep = HiCcompare::sparse2full(rao_chr20_25_rep)
row.names(rao_chr20_25_rep) = colnames(rao_chr20_25_rep) = format(as.numeric(row.names(rao_chr20_25_rep)), scientific = FALSE)
rao_chr20_25_rep[1:5, 1:5]

## ----echo = FALSE, warning = FALSE----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
row.names(rao_chr20_25_rep) = NULL
sub_mat = cbind.data.frame("chr19", as.numeric(colnames(rao_chr20_25_rep)), as.numeric(colnames(rao_chr20_25_rep))+25000, rao_chr20_25_rep)[1:10, 1:10]
colnames(sub_mat) = NULL

sub_mat

## ----echo = FALSE, warning = FALSE----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
head(HiCcompare::full2sparse(rao_chr20_25_rep), 5)

## ----eval = FALSE---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# #Read in data
# cool_mat = read.table("Rao.GM12878.50kb.txt")
# #Convert to sparse 3-column matrix using cooler2sparse from HiCcompare
# sparse_mats = HiCcompare::cooler2sparse(cool_mat)
# #Remove empty matrices if necessary
# #sparse_mats = sparse_mats$cis[sapply(sparse_mats, nrow) != 0]
# #Run SpectralTAD
# spec_tads = lapply(names(sparse_mats), function(x) {
#   SpectralTAD(sparse_mats[[x]], chr = x)
# })
# 

## ----eval = FALSE---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# #Read in both files
# mat = read.table("amyg_100000.matrix")
# bed = read.table("amyg_100000_abs.bed")
# #Convert to modified bed format
# sparse_mats = HiCcompare::hicpro2bedpe(mat,bed)
# #Remove empty matrices if necessary
# #sparse_mats$cis = sparse_mats$cis[sapply(sparse_mats, nrow) != 0]
# #Go through all matrices
# sparse_tads = lapply(sparse_mats$cis, function(x) {
#   #Pull out chromosome
#   chr = x[,1][1]
#   #Subset to make three column matrix
#   x = x[,c(2,5,7)]
#   #Run SpectralTAD
#   SpectralTAD(x, chr=chr)
# })

## ----message = FALSE, warning = FALSE-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Get the rao contact matrix built into the package
data("rao_chr20_25_rep")
head(rao_chr20_25_rep)
#We see that this is a sparse 3-column contact matrix
#Running the algorithm with resolution specified
results = SpectralTAD(rao_chr20_25_rep, chr = "chr20", resolution = 25000, qual_filter = FALSE, z_clust = FALSE)
#Printing the top 5 TADs
head(results$Level_1, 5)
#Repeating without specifying resolution
no_res = SpectralTAD(rao_chr20_25_rep, chr = "chr20", qual_filter = FALSE, z_clust = FALSE)
#We can see below that resolution can be estimated automatically if necessary
identical(results, no_res)

## ----message = FALSE------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Running SpectralTAD with silhouette score filtering
qual_filt = SpectralTAD(rao_chr20_25_rep, chr = "chr20", qual_filter = TRUE, z_clust = FALSE, resolution = 25000)
#Showing quality filtered results
head(qual_filt$Level_1,5)
#Quality filtering generally has different dimensions
dim(qual_filt$Level_1)
dim(results$Level_1)

## ----message = FALSE------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
z_filt = SpectralTAD(rao_chr20_25_rep, chr = "chr20", qual_filter = FALSE, z_clust = TRUE, resolution = 25000)
head(z_filt$Level_1, 5)
dim(z_filt$Level_1)

## ----message = FALSE------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Running SpectralTAD with 3 levels and no quality filtering
spec_hier = SpectralTAD(rao_chr20_25_rep, chr = "chr20", resolution = 25000, qual_filter = FALSE, levels = 3)
#Level 1 remains unchanged
head(spec_hier$Level_1,5)
#Level 2 contains the sub-TADs for level 1
head(spec_hier$Level_2,5)
#Level 3 contains even finer sub-TADs for level 1 and level 2
head(spec_hier$Level_3,5)


## ----eval = FALSE---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# #Creating replicates of our HiC data for demonstration
# cont_list = replicate(3,rao_chr20_25_rep, simplify = FALSE)
# #Creating a vector of chromosomes
# chr_over = c("chr20", "chr20", "chr20")
# #Creating a list of labels
# labels = c("Replicate 1", "Replicate 2", "Replicate 3")
# SpectralTAD_Par(cont_list = cont_list, chr_over = chr_over, labels = labels, cores = 3)
# 

## ----message = FALSE------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
library(microbenchmark)
#Converting to nxn
n_n = HiCcompare::sparse2full(rao_chr20_25_rep)
#Converting to nxn+3
n_n_3 = cbind.data.frame("chr20", as.numeric(colnames(n_n)), as.numeric(colnames(n_n))+25000, n_n)
#Defining each function
sparse = SpectralTAD(cont_mat = rao_chr20_25_rep, chr = "chr20", qual_filter = FALSE)
n_by_n = SpectralTAD(cont_mat = n_n, chr = "chr20", qual_filter = FALSE)
n_by_n_3 =SpectralTAD(cont_mat = n_n_3, chr = "chr20", qual_filter = FALSE)

#Benchmarking different parameters
microbenchmark(sparse = SpectralTAD(cont_mat = rao_chr20_25_rep, chr = "chr20", qual_filter = FALSE),
n_by_n = SpectralTAD(cont_mat = n_n, chr = "chr20", qual_filter = FALSE),
n_by_n_3 =SpectralTAD(cont_mat = n_n_3, chr = "chr20", qual_filter = FALSE), unit = "s", times = 3)

## ----message = FALSE------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
microbenchmark(quality_filter = SpectralTAD(cont_mat = n_n, chr = "chr20", qual_filter = TRUE, z_clust = FALSE), no_filter = SpectralTAD(cont_mat = n_n, chr = "chr20", qual_filter = FALSE, z_clust = FALSE), z_clust = SpectralTAD(cont_mat = n_n, chr = "chr20", qual_filter = FALSE, z_clust = TRUE), times = 3, unit = "s")

## ----eval = FALSE---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# #Get contact matrix
# data("rao_chr20_25_rep")
# head(rao_chr20_25_rep)
# #Run spectral TAD with output format "hicexplorer" or "bed" and specify the path
# spec_hier = SpectralTAD(rao_chr20_25_rep, chr = "chr20", resolution = 25000, qual_filter = FALSE, levels = 3, out_format = "hicexplorer", out_path = "chr20.bed")
# 

## ----eval = FALSE---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# #Get contact matrix
# data("rao_chr20_25_rep")
# head(rao_chr20_25_rep)
# #Run spectral TAD with output format "hicexplorer" or "bed" and specify the path
# spec_hier = SpectralTAD(rao_chr20_25_rep, chr = "chr20", resolution = 25000, qual_filter = FALSE, levels = 3, out_format = "juicebox", out_path = "chr20.bedpe")

