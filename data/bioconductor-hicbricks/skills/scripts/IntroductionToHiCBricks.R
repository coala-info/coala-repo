# Code example from 'IntroductionToHiCBricks' vignette. See references/ for full tutorial.

## ----message = FALSE----------------------------------------------------------
library("HiCBricks")


## -----------------------------------------------------------------------------

Bintable_path <- system.file(file.path("extdata",
"Bintable_100kb.bins"), package = "HiCBricks")


## ----echo = FALSE, results = "asis"-------------------------------------------

library(knitr)
kable(data.frame(chr = c("chr2L", "chr2R", "chr3L", "chr3R", "chrX"),
    num_rows = c(231, 212, 246, 280, 225)), 
    caption = "Number of rows in the bintable corresponding to each chromosome")


## -----------------------------------------------------------------------------

out_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
dir.create(out_dir)
Create_many_Bricks(BinTable = Bintable_path, 
    bin_delim=" ", output_directory = out_dir, 
    file_prefix = "HiCBricks_vignette_test", remove_existing=TRUE, 
    experiment_name = "HiCBricks vignette test", resolution = 100000)


## -----------------------------------------------------------------------------

BrickContainer_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
My_BrickContainer <- load_BrickContainer(project_dir = BrickContainer_dir)
Example_dataset_dir <- system.file("extdata", package = "HiCBricks")

Chromosomes <- c("chr2L", "chr3L", "chr3R", "chrX")
for (chr in Chromosomes) {
    Matrix_file <- file.path(Example_dataset_dir,
        paste(paste("Sexton2012_yaffetanay_CisTrans_100000_corrected", 
          chr, sep = "_"), "txt.gz", sep = "."))
    Brick_load_matrix(Brick = My_BrickContainer,
        chr1 = chr,
        chr2 = chr,
        resolution = 100000,
        matrix_file = Matrix_file,
        delim = " ",
        remove_prior = TRUE)
}


## -----------------------------------------------------------------------------

Example_dataset_dir <- system.file("extdata", package = "HiCBricks")
Matrix_file <- file.path(Example_dataset_dir,
    paste(paste("Sexton2012_yaffetanay_CisTrans_100000_corrected", 
        "chr2L", sep = "_"), "txt.gz", sep = "."))
Brick_load_cis_matrix_till_distance(Brick = My_BrickContainer,
    chr = "chr2L",
    resolution = 100000,
    matrix_file = Matrix_file,
    delim = " ",
    distance = 100,
    remove_prior = TRUE)


## ----eval = FALSE-------------------------------------------------------------
# require(curl)
# ftp_location = "ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE104nnn/GSE104427/suppl"
# 
# sparse_matrix_file = file.path(ftp_location,"GSE104427_c2c12_40000_iced.matrix.gz")
# sparse_out_dir <- file.path(tempdir(), "sparse_out_dir")
# if(!dir.exists(sparse_out_dir)){
#   dir.create(sparse_out_dir)
# }
# curl_download(url = sparse_matrix_file,
#     destfile = file.path(sparse_out_dir, "GSE104427_c2c12_40000_iced.matrix.gz"))
# 
# sparse_bintable_file = file.path(ftp_location,"GSE104427_c2c12_40000_abs.bed.gz")
# curl_download(url = sparse_matrix_file,
#     destfile = file.path(sparse_out_dir, "GSE104427_c2c12_40000_abs.bed.gz"))

## ----eval = FALSE-------------------------------------------------------------
# 
# Read_file_df <- read.table(file.path(sparse_out_dir, "GSE104427_c2c12_40000_iced.matrix.gz"))
# Read_file_df <- Read_file_df[Read_file_df[,2] >= Read_file_df[,1],]
# write.table(x = Read_file_df, file = file.path(sparse_out_dir, "GSE104427_c2c12_40000_iced_uppertri.matrix"),
#   quote = FALSE, sep = " ", row.names = FALSE, col.names = FALSE)
# 

## ----eval = FALSE-------------------------------------------------------------
# 
# Read_bintable_df <- read.table(file.path(sparse_out_dir, "GSE104427_c2c12_40000_abs.bed.gz"))
# Read_bintable_df[,2] <- Read_bintable_df[,2] + 1
# write.table(x = Read_bintable_df[, c(1, 2, 3)], file = file.path(sparse_out_dir, "GSE104427_c2c12_40000_abs_discontinuous.bed"),
#   quote = FALSE, sep = " ", row.names = FALSE, col.names = FALSE)
# 

## ----eval = FALSE-------------------------------------------------------------
# 
# Bintable_path <- file.path(sparse_out_dir, "GSE104427_c2c12_40000_abs_discontinuous.bed")
# 
# My_sparse_brick_object <- Create_many_Bricks(BinTable = Bintable_path,
#     bin_delim=" ", output_directory = out_dir,
#     file_prefix = "HiCBricks_vignette_test", remove_existing=TRUE,
#     experiment_name = "HiCBricks vignette test", resolution = 40000)
# 
# Matrix_path <- file.path(sparse_out_dir, "GSE104427_c2c12_40000_iced_uppertri.matrix")
# 
# Load_all_sparse <- Brick_load_data_from_sparse(Brick = My_sparse_brick_object,
#   table_file = Matrix_path, delim = " ", resolution = 40000)
# 

## ----eval = FALSE-------------------------------------------------------------
# require(curl)
# Consortium.home = "https://data.4dnucleome.org/files-processed"
# File = file.path(Consortium.home, "4DNFI7JNCNFB",
#     "@@download","4DNFI7JNCNFB.mcool")
# mcool_out_dir <- file.path(tempdir(), "mcool_out_dir")
# dir.create(mcool_out_dir)
# curl_download(url = File,
#     destfile = file.path(mcool_out_dir, "H1-hESC-HiC-4DNFI7JNCNFB.mcool"))

## ----eval = FALSE-------------------------------------------------------------
# 
# mcool_out_dir <- file.path(tempdir(), "mcool_out_dir")
# mcool_path=file.path(mcool_out_dir, "H1-hESC-HiC-4DNFI7JNCNFB.mcool")
# Brick_list_mcool_resolutions(mcool = mcool_path)
# 

## ----eval = FALSE-------------------------------------------------------------
# 
# mcool_out_dir <- file.path(tempdir(), "mcool_out_dir")
# mcool_path=file.path(mcool_out_dir, "H1-hESC-HiC-4DNFI7JNCNFB.mcool")
# Brick_mcool_normalisation_exists(mcool = mcool_path,
#     norm_factor = "Iterative-Correction",
#     resolution = 10000)
# 

## ----eval = FALSE-------------------------------------------------------------
# 
# mcool_out_dir <- file.path(tempdir(), "mcool_out_dir")
# mcool_path=file.path(mcool_out_dir, "H1-hESC-HiC-4DNFI7JNCNFB.mcool")
# 
# out_dir <- file.path(tempdir(), "mcool_to_Brick_test")
# dir.create(out_dir)
# 
# Create_many_Bricks_from_mcool(output_directory = out_dir,
#     file_prefix = "mcool_to_Brick_test",
#     mcool = mcool_path,
#     resolution = 10000,
#     experiment_name = "Testing mcool creation",
#     remove_existing = TRUE)
# 

## ----eval = FALSE-------------------------------------------------------------
# 
# mcool_out_dir <- file.path(tempdir(), "mcool_out_dir")
# mcool_path=file.path(mcool_out_dir, "H1-hESC-HiC-4DNFI7JNCNFB.mcool")
# 
# out_dir <- file.path(tempdir(), "mcool_to_Brick_test")
# 
# Create_many_Bricks_from_mcool(output_directory = out_dir,
#     file_prefix = "mcool_to_Brick_test",
#     mcool = mcool_path,
#     resolution = 40000,
#     experiment_name = "Testing mcool creation",
#     remove_existing = TRUE)
# 

## ----eval = FALSE-------------------------------------------------------------
# 
# out_dir <- file.path(tempdir(), "mcool_to_Brick_test")
# My_BrickContainer <- load_BrickContainer(project_dir = out_dir)
# 
# mcool_out_dir <- file.path(tempdir(), "mcool_out_dir")
# mcool_path=file.path(mcool_out_dir, "H1-hESC-HiC-4DNFI7JNCNFB.mcool")
# 
# Brick_load_data_from_mcool(Brick = My_BrickContainer,
#     mcool = mcool_path,
#     resolution = 10000,
#     cooler_read_limit = 10000000,
#     matrix_chunk = 2000,
#     remove_prior = TRUE,
#     norm_factor = "Iterative-Correction")
# 

## ----eval = FALSE-------------------------------------------------------------
# 
# # load the Brick Container
# BrickContainer_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
# My_BrickContainer <- load_BrickContainer(project_dir = BrickContainer_dir)
# 
# # export the contact matrix to a a sparse matrix format and save it on a file
# Brick_export_to_sparse(Brick=My_BrickContainer,
#   out_file="brick_export.tsv",
#   remove_file=TRUE,
#   resolution=100000,
#   sep="\t")
# 
# # create a dataframe containing the bintable
# bintable<-Brick_get_bintable(My_BrickContainer, resolution = 100000)
# 
# require(GenomicRanges)
# 
# df1<-data.frame(seqnames=seqnames(bintable),
#   start(bintable)-1,
#   ends=end(bintable),
#   names=c(rep(".",length(bintable))),
#   scores=c(rep(".", length(bintable))),
#   strands=strand(bintable))
# 
# # save the bintable as a bed file
# write.table(df1,
#   file="bintable.bed",
#   quote=FALSE,
#   row.names=FALSE,
#   col.names=FALSE,
#   sep="\t")

## ----eval = FALSE-------------------------------------------------------------
# 
# sed -e "1d" brick_export.tsv | cut -f3-5 > exported_bins_no_header.tsv
# 

## ----eval = FALSE-------------------------------------------------------------
# 
# cooler load -f coo \
#   --count-as-float \
#   --one-based \
#   bintable.bed \
#   exported_bins_no_header.tsv \
#   test_cool_from_hicbricks.cool
# 

## ----eval = FALSE-------------------------------------------------------------
# 
# cooler zoomify -p 1 \
#   -r 200000,500000 \
#   -o 2_test_cool_from_hicbricks.mcool \
#   test_cool_from_hicbricks.cool
# 

## -----------------------------------------------------------------------------

BrickContainer_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
My_BrickContainer <- load_BrickContainer(project_dir = BrickContainer_dir)

Brick_list_rangekeys(Brick = My_BrickContainer, resolution = 100000)


## -----------------------------------------------------------------------------

BrickContainer_file <- file.path(tempdir(), 
  "HiCBricks_vignette_test", "HiCBricks_builder_config.json")
My_BrickContainer <- load_BrickContainer(config_file = BrickContainer_file)

Brick_get_bintable(My_BrickContainer, resolution = 100000)


## -----------------------------------------------------------------------------

BrickContainer_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
My_BrickContainer <- load_BrickContainer(project_dir = BrickContainer_dir)

Brick_get_ranges(Brick = My_BrickContainer,
    rangekey = "Bintable", resolution = 100000)


## -----------------------------------------------------------------------------

BrickContainer_file <- file.path(tempdir(), "HiCBricks_vignette_test",
  "HiCBricks_builder_config.json")
My_BrickContainer <- load_BrickContainer(config_file = BrickContainer_file)

Brick_get_ranges(Brick = My_BrickContainer,
    rangekey = "Bintable",
    chr = "chr3R", 
    resolution = 100000)


## -----------------------------------------------------------------------------

BrickContainer_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
My_BrickContainer <- load_BrickContainer(project_dir = BrickContainer_dir)

Brick_return_region_position(Brick = My_BrickContainer,
    region = "chr2L:5000000:10000000", resolution = 100000)



## -----------------------------------------------------------------------------

BrickContainer_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
My_BrickContainer <- load_BrickContainer(project_dir = BrickContainer_dir)

Brick_fetch_range_index(Brick = My_BrickContainer,
    chr = "chr2L",
    start = 5000000,
    end = 10000000, resolution = 100000)



## -----------------------------------------------------------------------------

BrickContainer_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
My_BrickContainer <- load_BrickContainer(project_dir = BrickContainer_dir)

Values <- Brick_get_values_by_distance(Brick = My_BrickContainer,
    chr = "chr2L",
    distance = 4, resolution = 100000)


## -----------------------------------------------------------------------------

Failsafe_median_log10 <- function(x){
    x[is.nan(x) | is.infinite(x) | is.na(x)] <- 0
    return(median(log10(x+1)))
}

BrickContainer_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
My_BrickContainer <- load_BrickContainer(project_dir = BrickContainer_dir)

Brick_get_values_by_distance(Brick = My_BrickContainer,
    chr = "chr2L",
    distance = 4, resolution = 100000,
    FUN = Failsafe_median_log10)


## -----------------------------------------------------------------------------

Failsafe_median_log10 <- function(x){
    x[is.nan(x) | is.infinite(x) | is.na(x)] <- 0
    return(median(log10(x+1)))
}

BrickContainer_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
My_BrickContainer <- load_BrickContainer(project_dir = BrickContainer_dir)

Brick_get_values_by_distance(Brick = My_BrickContainer,
    chr = "chr2L",
    distance = 4,
    constrain_region = "chr2L:1:5000000",
    resolution = 100000,
    FUN = Failsafe_median_log10)


## -----------------------------------------------------------------------------

Sub_matrix <- Brick_get_matrix_within_coords(Brick = My_BrickContainer,
    x_coords="chr2L:5000000:10000000",
    force = TRUE,
    resolution = 100000,
    y_coords = "chr2L:5000000:10000000")

dim(Sub_matrix)


## -----------------------------------------------------------------------------

x_axis <- 5000000/100000
y_axis <- 10000000/100000

Sub_matrix <- Brick_get_matrix(Brick = My_BrickContainer,
    chr1 = "chr3R", chr2 = "chr3R", resolution = 100000,
    x_coords = seq(from = x_axis, to = y_axis),
    y_coords = seq(from = x_axis, to = y_axis))

dim(Sub_matrix)


## -----------------------------------------------------------------------------

Coordinate <- c("chr3R:1:100000","chr3R:100001:200000")

BrickContainer_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
My_BrickContainer <- load_BrickContainer(project_dir = BrickContainer_dir)

Test_Run <- Brick_fetch_row_vector(Brick = My_BrickContainer,
    chr1 = "chr3R",
    chr2 = "chr3R",
    by = "ranges",
    resolution = 100000,
    vector = Coordinate)


## -----------------------------------------------------------------------------

Coordinate <- c(1,2)

BrickContainer_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
My_BrickContainer <- load_BrickContainer(project_dir = BrickContainer_dir)

Test_Run <- Brick_fetch_row_vector(Brick = My_BrickContainer,
    chr1 = "chr3R",
    chr2 = "chr3R",
    by = "position",
    resolution = 100000,
    vector = Coordinate)


## -----------------------------------------------------------------------------

Coordinate <- c(1,2)

Test_Run <- Brick_fetch_row_vector(Brick = My_BrickContainer,
    chr1 = "chr3R",
    chr2 = "chr3R",
    by = "position",
    vector = Coordinate,
    resolution = 100000,
    regions = c("chr3R:1:1000000", "chr3R:100001:2000000"))


## -----------------------------------------------------------------------------

Brick_list_matrix_mcols()


## -----------------------------------------------------------------------------

BrickContainer_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
My_BrickContainer <- load_BrickContainer(project_dir = BrickContainer_dir)

MCols.dat <- Brick_get_matrix_mcols(Brick = My_BrickContainer,
    chr1 = "chr3R",
    chr2 = "chr3R",
    resolution = 100000,
    what = "chr1_row_sums")
head(MCols.dat, 100)


## -----------------------------------------------------------------------------

BrickContainer_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
My_BrickContainer <- load_BrickContainer(project_dir = BrickContainer_dir)

Brick_matrix_isdone(Brick = My_BrickContainer,
    chr1 = "chr3R",
    chr2 = "chr3R",
    resolution = 100000)


## -----------------------------------------------------------------------------

Brick_matrix_issparse(Brick = My_BrickContainer,
    chr1 = "chr2L",
    chr2 = "chr2L",
    resolution = 100000)


## -----------------------------------------------------------------------------

Brick_matrix_maxdist(Brick = My_BrickContainer,
    chr1 = "chr2L",
    chr2 = "chr2L",
    resolution = 100000)


## -----------------------------------------------------------------------------

Brick_matrix_exists(Brick = My_BrickContainer,
    chr1 = "chr2L",
    chr2 = "chr2L",
    resolution = 100000)


## -----------------------------------------------------------------------------

Brick_matrix_minmax(Brick = My_BrickContainer,
    chr1 = "chr2L",
    chr2 = "chr2L",
    resolution = 100000)


## -----------------------------------------------------------------------------

Brick_matrix_dimensions(Brick = My_BrickContainer,
    chr1 = "chr2L",
    chr2 = "chr2L",
    resolution = 100000)


## -----------------------------------------------------------------------------

Brick_matrix_filename(Brick = My_BrickContainer,
    chr1 = "chr2L",
    chr2 = "chr2L",
    resolution = 100000)


## -----------------------------------------------------------------------------

BrickContainer_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
My_BrickContainer <- load_BrickContainer(project_dir = BrickContainer_dir)

Chromosome <- c("chr2L", "chr3L", "chr3R", "chrX")
di_window <- 10
lookup_window <- 30
TAD_ranges <- Brick_local_score_differentiator(Brick = My_BrickContainer,
    chrs = Chromosome,
    resolution = 100000,
    di_window = di_window,
    lookup_window = lookup_window,
    strict = TRUE,
    fill_gaps = TRUE,
    chunk_size = 500)


## -----------------------------------------------------------------------------

Name <- paste("LSD",
    di_window,
    lookup_window, sep = "_")
Brick_add_ranges(Brick = My_BrickContainer,
    ranges = TAD_ranges,
    rangekey = Name,
    resolution = 100000)


## -----------------------------------------------------------------------------

Brick_list_rangekeys(Brick = My_BrickContainer, resolution = 100000)
TAD_ranges <- Brick_get_ranges(Brick = My_BrickContainer, rangekey = Name,
    resolution = 100000)


## ----plot, fig.cap = "A normal heatmap without any transformations", fig.small = TRUE----

BrickContainer_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
My_BrickContainer <- load_BrickContainer(project_dir = BrickContainer_dir)

Brick_vizart_plot_heatmap(File = file.path(tempdir(), 
  "chr3R-1-10MB-normal.pdf"),
    Bricks = list(My_BrickContainer),
    x_coords = "chr3R:1:10000000",
    y_coords = "chr3R:1:10000000",
    resolution = 100000,
    palette = "Reds",
    width = 10,
    height = 11,
    return_object=TRUE)


## ----plot2, fig.cap = "A normal heatmap with colours computed in log10 scale", fig.small = TRUE----

BrickContainer_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
My_BrickContainer <- load_BrickContainer(project_dir = BrickContainer_dir)

Failsafe_log10 <- function(x){
    x[is.na(x) | is.nan(x) | is.infinite(x)] <- 0
    return(log10(x+1))
}

Brick_vizart_plot_heatmap(File = file.path(tempdir(), 
  "chr3R-1-10MB-normal-colours-log10.pdf"),
    Bricks = list(My_BrickContainer),
    x_coords = "chr3R:1:10000000",
    y_coords = "chr3R:1:10000000",
    resolution = 100000,
    FUN = Failsafe_log10,
    legend_title = "Log10 Hi-C signal",
    palette = "Reds",
    width = 10,
    height = 11,
    return_object=TRUE)


## ----plot3, fig.cap = "A normal heatmap with colours computed in log10 scale after capping values to the 99th percentile", fig.small = TRUE----

Brick_vizart_plot_heatmap(File = file.path(tempdir(),
  "chr3R-1-10MB-normal-colours-log10-valuecap-99.pdf"),
    Bricks = list(My_BrickContainer),
    x_coords = "chr3R:1:10000000",
    y_coords = "chr3R:1:10000000",
    resolution = 100000,
    FUN = Failsafe_log10,
    value_cap = 0.99,
    legend_title = "Log10 Hi-C signal",
    palette = "Reds",
    width = 10,
    height = 11,
    return_object = TRUE)


## ----plot4, fig.cap = "Same heatmap as before with colours computed in log10 scale after capping values to the 99th percentile with 45 degree rotation", fig.small = TRUE----

Brick_vizart_plot_heatmap(File = file.path(tempdir(),
  "chr3R-1-10MB-normal-colours-log10-rotate.pdf"),
    Bricks = list(My_BrickContainer),
    x_coords = "chr3R:1:10000000",
    y_coords = "chr3R:1:10000000",
    resolution = 100000,
    FUN = Failsafe_log10,
    value_cap = 0.99,
    distance = 60,
    legend_title = "Log10 Hi-C signal",
    palette = "Reds",
    width = 10,
    height = 11,
    rotate = TRUE,
    return_object = TRUE)


## ----plot5, fig.cap = "Same heatmap as previous, but now the heatmaps are wider than they are taller", fig.wide = TRUE----

Brick_vizart_plot_heatmap(File = file.path(tempdir(),
  "chr3R-1-10MB-normal-colours-log10-rotate-2.pdf"),
    Bricks = list(My_BrickContainer),
    x_coords = "chr3R:1:10000000",
    y_coords = "chr3R:1:10000000",
    resolution = 100000,
    FUN = Failsafe_log10,
    value_cap = 0.99,
    distance = 60,
    legend_title = "Log10 Hi-C signal",
    palette = "Reds",
    width = 15,
    height = 5,
    rotate = TRUE,
    return_object = TRUE)


## ----plot6, fig.cap = "Normal rectangular heatmap with colours computed in the log scale after capping values to the 99th percentile with TAD calls", fig.small = TRUE----

Brick_vizart_plot_heatmap(File = file.path(tempdir(),
  "chr3R-1-10MB-normal-colours-log10-rotate-2-tads.pdf"),
    Bricks = list(My_BrickContainer),
    tad_ranges = TAD_ranges,
    x_coords = "chr3R:1:10000000",
    y_coords = "chr3R:1:10000000",
    resolution = 100000,
    colours = "#230C0F",
    FUN = Failsafe_log10,
    value_cap = 0.99,
    legend_title = "Log10 Hi-C signal",
    palette = "Reds",
    width = 10,
    height = 11,
    return_object = TRUE)


## ----plot7, fig.cap = "Normal rotated heatmap with colours computed in the log scale after capping values to the 99th percentile with TAD calls", fig.wide = TRUE----

Brick_vizart_plot_heatmap(File = file.path(tempdir(),
  "chr3R-1-10MB-normal-colours-log10-rotate-3-tads.pdf"),
    Bricks = list(My_BrickContainer),
    tad_ranges = TAD_ranges,
    x_coords = "chr3R:1:10000000",
    y_coords = "chr3R:1:10000000",
    resolution = 100000,
    colours = "#230C0F",
    FUN = Failsafe_log10,
    value_cap = 0.99,
    distance = 60,
    legend_title = "Log10 Hi-C signal",
    palette = "Reds",
    width = 15,
    height = 5,
    line_width = 0.8,
    cut_corners = TRUE,
    rotate = TRUE,
    return_object=TRUE)


## ----plot8, fig.cap = "A normal two sample heatmap with colours computed in log10 scale after capping values to the 99th percentile", fig.small = TRUE----

Brick_vizart_plot_heatmap(File = file.path(tempdir(),
  "chr3R-1-10MB-bipartite-colours-log10-valuecap-99.pdf"),
    Bricks = list(My_BrickContainer, My_BrickContainer),
    x_coords = "chr3R:1:10000000",
    y_coords = "chr3R:1:10000000",
    resolution = 100000,
    FUN = Failsafe_log10,
    value_cap = 0.99,
    legend_title = "Log10 Hi-C signal",
    palette = "YlGnBu",
    width = 10,
    height = 11,
    return_object = TRUE)


## ----plot9, fig.cap = "A normal two sample heatmap with colours computed in log10 scale on values until the 30th diagonal and capping these values to the 99th percentile.", fig.small = TRUE----

Brick_vizart_plot_heatmap(File = file.path(tempdir(),
  "chr3R-1-10MB-bipartite-colours-log10-valuecap-99-2.pdf"),
    Bricks = list(My_BrickContainer, My_BrickContainer),
    x_coords = "chr3R:1:10000000",
    y_coords = "chr3R:1:10000000",
    resolution = 100000,
    FUN = Failsafe_log10,
    value_cap = 0.99,
    legend_title = "Log10 Hi-C signal",
    palette = "RdGy",
    distance = 30,
    width = 10,
    height = 11,
    return_object = TRUE)


## ----plot10, fig.cap = "A rotated two sample heatmap with colours computed in log10 scale and capping these values to the 99th percentile.", fig.wide = TRUE----

Brick_vizart_plot_heatmap(File = file.path(tempdir(),
  "chr3R-1-10MB-bipartite-colours-log10-valuecap-99-rotate.pdf"),
    Bricks = list(My_BrickContainer, My_BrickContainer),
    x_coords = "chr3R:1:10000000",
    y_coords = "chr3R:1:10000000",
    resolution = 100000,
    FUN = Failsafe_log10,
    value_cap = 0.99,
    legend_title = "Log10 Hi-C signal",
    palette = "YlGnBu",
    distance = 30,
    width = 15,
    height = 4,
    rotate = TRUE,
    return_object = TRUE)


## -----------------------------------------------------------------------------

BrickContainer_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
My_BrickContainer <- load_BrickContainer(project_dir = BrickContainer_dir)

Chromosome <- "chr3R"
di_windows <- c(5,10)
lookup_windows <- c(10, 20)
for (i in seq_along(di_windows)) {

    di_window <- di_windows[i]
    lookup_window <- lookup_windows[i]
    
    TAD_ranges <- Brick_local_score_differentiator(Brick = My_BrickContainer,
        chrs = Chromosome,
        resolution = 100000,
        di_window = di_window,
        lookup_window = lookup_window,
        strict = TRUE,
        fill_gaps=TRUE,
        chunk_size = 500)
    
    Name <- paste("LSD",
        di_window,
        lookup_window,
        Chromosome,sep = "_")
    
    Brick_add_ranges(Brick = My_BrickContainer, ranges = TAD_ranges, 
      resolution = 100000, rangekey = Name)
}


## -----------------------------------------------------------------------------

Chromosome <- "chr3R"
di_windows <- c(5,10)
lookup_windows <- c(10, 20)
TADs_list <- list()
for (i in seq_along(di_windows)) {

    di_window <- di_windows[i]
    lookup_window <- lookup_windows[i]

    Name <- paste("LSD",
        di_window,
        lookup_window,
        Chromosome,sep = "_")

    TAD_ranges <- Brick_get_ranges(Brick = My_BrickContainer, 
        resolution = 100000, rangekey = Name)
    # Map TADs to their Hi-C maps
    TAD_ranges$group <- i
    # Map TADs to a specific categorical value for the colours
    TAD_ranges$colour_group <- paste("LSD", di_window, lookup_window, 
        sep = "_")
    TADs_list[[Name]] <- TAD_ranges
}

TADs_ranges <- do.call(c, unlist(TADs_list, use.names = FALSE))


## ----plot11, fig.cap = "A normal two sample heatmap with colours computed in log10 scale and capping these values to the 97th percentile, with TAD borders", fig.small = TRUE----

BrickContainer_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
My_BrickContainer <- load_BrickContainer(project_dir = BrickContainer_dir)

Colours <- c("#B4436C", "#F78154")
Colour_names <- unique(TADs_ranges$colour_group)

Brick_vizart_plot_heatmap(File = file.path(tempdir(),
  "chr3R-1-10MB-bipartite-colours-log10-valuecap-99-tads.pdf"),
    Bricks = list(My_BrickContainer, My_BrickContainer),
    x_coords = "chr3R:1:10000000",
    y_coords = "chr3R:1:10000000",
    resolution = 100000,
    FUN = Failsafe_log10,
    value_cap = 0.97,
    legend_title = "Log10 Hi-C signal",
    palette = "YlGnBu",
    tad_ranges = TADs_ranges,
    group_col = "group",
    tad_colour_col = "colour_group",
    colours = Colours,
    colours_names = Colour_names,
    distance = 30,
    width = 9,
    height = 11,
    return_object=TRUE)


## ----plot12, fig.cap = "A rotated two sample heatmap with colours computed in log10 scale and capping these values to the 97th percentile, with non-truncated TAD borders", fig.wide = TRUE----

BrickContainer_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
My_BrickContainer <- load_BrickContainer(project_dir = BrickContainer_dir)

Colours <- c("#B4436C", "#F78154")
Colour_names <- unique(TADs_ranges$colour_group)

Brick_vizart_plot_heatmap(File = file.path(tempdir(),
  "chr3R-1-10MB-bipartite-colours-log10-valuecap-99-rotate-tads.pdf"),
    Bricks = list(My_BrickContainer, My_BrickContainer),
    x_coords = "chr3R:1:10000000",
    y_coords = "chr3R:1:10000000",
    resolution = 100000,
    FUN = Failsafe_log10,
    value_cap = 0.97,
    legend_title = "Log10 Hi-C signal",
    palette = "YlGnBu",
    tad_ranges = TADs_ranges,
    group_col = "group",
    tad_colour_col = "colour_group",
    colours = Colours,
    colours_names = Colour_names,
    distance = 30,
    width = 15,
    height = 4,
    rotate = TRUE,
    return_object=TRUE)


## ----plot13, fig.cap = "A rotated two sample heatmap with colours computed in log10 scale and capping these values to the 97th percentile, with truncated TAD borders", fig.wide = TRUE----

BrickContainer_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
My_BrickContainer <- load_BrickContainer(project_dir = BrickContainer_dir)

Colours <- c("#B4436C", "#F78154")
Colour.names <- unique(TADs_ranges$colour_group)

Brick_vizart_plot_heatmap(File = file.path(tempdir(),
  "chr3R-1-10MB-bipartite-colours-log10-valuecap-99-rotate-tads-2.pdf"),
    Bricks = list(My_BrickContainer, My_BrickContainer),
    x_coords = "chr3R:1:10000000",
    y_coords = "chr3R:1:10000000",
    resolution = 100000,
    FUN = Failsafe_log10,
    value_cap = 0.97,
    legend_title = "Log10 Hi-C signal",
    palette = "YlGnBu",
    tad_ranges = TADs_ranges,
    group_col = "group",
    tad_colour_col = "colour_group",
    colours = Colours,
    colours_names = Colour_names,
    distance = 30,
    width = 15,
    height = 4,
    cut_corners = TRUE,
    rotate = TRUE,
    return_object=TRUE)


## ----plot14, fig.cap = "A rotated two sample heatmap with colours computed in log10 scale and capping these values to the 99th percentile.", fig.wide = TRUE----

Brick_vizart_plot_heatmap(File = file.path(tempdir(),
  "chr3R-1-10MB-bipartite-final.pdf"),
    Bricks = list(My_BrickContainer, My_BrickContainer),
    x_coords = "chr3R:1:10000000",
    y_coords = "chr3R:1:10000000",
    resolution = 100000,
    FUN = Failsafe_log10,
    value_cap = 0.99,
    legend_title = "Log10 Hi-C signal",
    palette = "YlGnBu",
    tad_ranges = TADs_ranges,
    group_col = "group",
    tad_colour_col = "colour_group",
    colours = Colours,
    colours_names = Colour.names,
    distance = 30,
    width = 15,
    height = 4,
    legend_key_width = unit(10, "mm"), 
    legend_key_height = unit(5, "mm"),
    line_width = 1.2,
    cut_corners = TRUE,
    rotate = TRUE,
    return_object=TRUE)


