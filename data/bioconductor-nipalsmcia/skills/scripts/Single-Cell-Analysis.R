# Code example from 'Single-Cell-Analysis' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----installation-github, eval = FALSE----------------------------------------
# # devel version:
# # install.packages("devtools")
# devtools::install_github("Muunraker/nipalsMCIA", ref = "devel",
#                          force = TRUE, build_vignettes = TRUE) # devel version

## ----installation-bioconductor, eval = FALSE----------------------------------
# # release version:
# if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
# 
# BiocManager::install("nipalsMCIA")

## ----load-packages, message = FALSE-------------------------------------------
# note that the TENxPBMCData package is not included in this list as you may
# decide to pull data from another source or use our provided objects
packages <- c("BiocFileCache", "dplyr", "ggplot2", "ggpubr", "nipalsMCIA",
              "piggyback", "Seurat")

# load each package and print the version
for (n in seq_along(packages)) {
  suppressPackageStartupMessages(library(packages[n], character.only = TRUE))
  cat(paste0(packages[n], ": ", packageVersion(packages[n]), "\n"))
}

# note that as of Seurat v5, GetAssayData() uses `layer` instead of `slot`

# NIPALS starts with a random vector
set.seed(42)

## ----set-paths----------------------------------------------------------------
# if you would like to save any of the data loaded/created locally
path_data <- file.path("..", "data")

## ----cache--------------------------------------------------------------------
# as suggested in: https://bioconductor.org/packages/release/bioc/vignettes/BiocFileCache/inst/doc/BiocFileCache.html#cache-to-manage-package-data
# since we only use the cache in this vignette, we don't need wrapper functions

# initialize the cache in a temporary directory
bfc <- BiocFileCache::BiocFileCache()

# you can run cleanbfc(bfc, days = -Inf) if you want to remove everything
  
# set up or load the unique resource ids
rid <- BiocFileCache::bfcquery(bfc, query = "vignette_sc", "rname")$rid
# rid <- bfcrid(bfc) # we only have one rname, so you could also just use this

# if the data is not in the cache, download and add it
if (length(rid) == 0) {
  # specify `tag = ` to use a different release other than latest
  urls <-
    piggyback::pb_download_url(repo = "Muunraker/nipalsMCIA", tag = "latest")
  
  # you could add all of the urls to rid at once, but it would throw this error
  # when it comes to downloading them:
  # "Error in parse_url(url) : length(url) == 1 is not TRUE"
  for (url in urls) {
    # the rids are numbered in the order they are added e.g. BFC1, BFC2, ...
    message(paste("Downloading file", url))
    rid <- names(BiocFileCache::bfcadd(bfc, rname = "vignette_sc", url))
    
    # check if the cached data needs updating and download it if needed
    if (!isFALSE(BiocFileCache::bfcneedsupdate(bfc, rid))) {
      # this will overwrite existing files without asking
      BiocFileCache::bfcdownload(bfc, rid, ask = FALSE)
    }
  }
}

# return the paths to the cached files
# BiocFileCache::bfcrpath(bfc, rid = rid)

## ----cache-temp-dir-----------------------------------------------------------
# you can also run tools::R_user_dir("BiocFileCache", which = "cache")
BiocFileCache::getBFCOption("CACHE")

## ----pipelines, echo = FALSE--------------------------------------------------
# pipeline image
knitr::include_graphics(path = BiocFileCache::bfcquery(bfc, "Pipeline")$rpath)

## ----data-all-list------------------------------------------------------------
# list all of the currently available files in the latest release
piggyback::pb_list(repo = "Muunraker/nipalsMCIA", tag = "latest")

## ----data-all-download--------------------------------------------------------
# files needed for running MCIA
path_metadata_sc <-
  BiocFileCache::bfcquery(bfc, query = "metadata_sc")$rpath

# MCIA results
# path_data_blocks <- bfcquery(bfc, query = "data_blocks")$rpath
path_mcia_results <-
  BiocFileCache::bfcquery(bfc, query = "mcia_results_sc")$rpath

# marker genes for cell type annotation with Seurat
path_marker_genes <-
  BiocFileCache::bfcquery(bfc, query = "marker_genes")$rpath

# the Seurat data's metric summary file from 10x Genomics
path_metrics_summary <-
  BiocFileCache::bfcquery(bfc, query = "metrics_summary")$rpath

# Seurat objects in different stages of processing
path_obj_raw <-
  BiocFileCache::bfcquery(bfc, query = "CITEseq_raw")$rpath
path_obj_annotated <-
  BiocFileCache::bfcquery(bfc, query = "CITEseq_annotated")$rpath

## ----data-bioconductor-load, eval = FALSE-------------------------------------
# # read in the data as a SingleCellExperiment object
# tenx_pbmc5k <- TENxPBMCData::TENxPBMCData(dataset = "pbmc5k-CITEseq")
# 
# # examine the data
# tenx_pbmc5k
# ## class: SingleCellExperiment
# ## dim: 33538 5247
# ## metadata(0):
# ## assays(1): counts
# ## rownames(33538): ENSG00000243485 ENSG00000237613 ... ENSG00000277475 ENSG00000268674
# ## rowData names(4): ENSEMBL_ID Symbol_TENx Type Symbol
# ## colnames: NULL
# ## colData names(11): Sample Barcode ... Individual Date_published
# ## reducedDimNames(0):
# ## mainExpName: Gene Expression
# ## altExpNames(1): Antibody Capture
# 
# counts(tenx_pbmc5k)
# ## <33538 x 5247> sparse matrix of class DelayedMatrix and type "integer":
# ##                    [, 1]    [, 2]    [, 3]    [, 4] ... [, 5244] [, 5245] [, 5246] [, 5247]
# ## ENSG00000243485       0       0       0       0   .       0       0       0       0
# ## ENSG00000237613       0       0       0       0   .       0       0       0       0
# ## ENSG00000186092       0       0       0       0   .       0       0       0       0
# ## ENSG00000238009       0       0       0       0   .       0       0       0       0
# ## ENSG00000239945       0       0       0       0   .       0       0       0       0
# ##             ...       .       .       .       .   .       .       .       .       .
# ## ENSG00000277856       0       0       0       0   .       0       0       0       0
# ## ENSG00000275063       0       0       0       0   .       0       0       0       0
# ## ENSG00000271254       0       0       0       0   .       0       0       0       0
# ## ENSG00000277475       0       0       0       0   .       0       0       0       0
# ## ENSG00000268674       0       0       0       0   .       0       0       0       0
# 
# counts(altExp(tenx_pbmc5k))
# ## <32 x 5247> sparse matrix of class DelayedMatrix and type "integer":
# ##           [, 1]    [, 2]    [, 3]    [, 4] ... [, 5244] [, 5245] [, 5246] [, 5247]
# ##    CD3      25     959     942     802   .     402     401       6    1773
# ##    CD4     164     720    1647    1666   .    1417       1      46    1903
# ##   CD8a      16       8      21       5   .       8     222       3       9
# ##  CD11b    3011      12      11      11   .      15       7    1027       9
# ##   CD14     696      12      13       9   .       9      17     382       8
# ##    ...       .       .       .       .   .       .       .       .       .
# ## HLA-DR     573      15      11      19   .       6      40     184      32
# ##  TIGIT      10       3       3       3   .       2      15       1      12
# ##   IgG1       4       4       2       4   .       1       0       2       4
# ##  IgG2a       1       3       0       6   .       4       0       4       2
# ##  IgG2b       6       2       4       8   .       0       0       2       5
# 
# # examine the metadata:
# head(colData(tenx_pbmc5k), n = 3)
# ## DataFrame with 6 rows and 11 columns
# ##           Sample            Barcode         Sequence   Library Cell_ranger_version Tissue_status Barcode_type
# ##      <character>        <character>      <character> <integer>         <character>   <character>  <character>
# ## 1 pbmc5k-CITEseq AAACCCAAGAGACAAG-1 AAACCCAAGAGACAAG         1              v3.0.2            NA     Chromium
# ## 2 pbmc5k-CITEseq AAACCCAAGGCCTAGA-1 AAACCCAAGGCCTAGA         1              v3.0.2            NA     Chromium
# ## 3 pbmc5k-CITEseq AAACCCAGTCGTGCCA-1 AAACCCAGTCGTGCCA         1              v3.0.2            NA     Chromium
# ##     Chemistry Sequence_platform   Individual Date_published
# ##   <character>       <character>  <character>    <character>
# ## 1 Chromium_v3           NovaSeq HealthyDonor     2019-05-29
# ## 2 Chromium_v3           NovaSeq HealthyDonor     2019-05-29
# ## 3 Chromium_v3           NovaSeq HealthyDonor     2019-05-29
# 
# head(rowData(tenx_pbmc5k), n = 3)
# ## DataFrame with 6 rows and 4 columns
# ##                      ENSEMBL_ID Symbol_TENx            Type       Symbol
# ##                     <character> <character>     <character>  <character>
# ## ENSG00000243485 ENSG00000243485 MIR1302-2HG Gene Expression           NA
# ## ENSG00000237613 ENSG00000237613     FAM138A Gene Expression      FAM138A
# ## ENSG00000186092 ENSG00000186092       OR4F5 Gene Expression        OR4F5
# 
# metadata(tenx_pbmc5k)
# ## list()
# 
# # change the gene names from Ensembl IDs to the 10x genes
# rownames(tenx_pbmc5k) <- rowData(tenx_pbmc5k)$Symbol_TENx

## ----data-bioconductor-formatting, eval = FALSE-------------------------------
# # set up the list
# data_blocks_sc_sce <- list()
# data_blocks_sc_sce$mrna <- data.frame(as.matrix(counts(tenx_pbmc5k)))
# data_blocks_sc_sce$adt <- data.frame(as.matrix(counts(altExp(tenx_pbmc5k))))
# 
# summary(data_blocks_sc_sce)
# ##      Length Class      Mode
# ## mrna 5247   data.frame list
# ## adt  5247   data.frame list
# 
# # convert to a Seurat object (using `as.Seurat` won't work here)
# obj_sce <- CreateSeuratObject(counts = data_blocks_sc_sce$mrna, # assay = "RNA"
#                               project = "pbmc5k_CITEseq")
# obj_sce[["ADT"]] <- CreateAssayObject(counts = data_blocks_sc_sce$adt)
# 
# # name the cells with their barcodes
# obj_sce <- RenameCells(object = obj_sce,
#                        new.names = colData(tenx_pbmc5k)$Sequence)
# 
# # add metadata from the SingleCellExperiment object
# obj_sce <- AddMetaData(object = obj_sce,
#                        metadata = as.data.frame(colData(tenx_pbmc5k),
#                                                 row.names = Cells(obj_sce)))
# 
# # this object will be slightly different than from the Seurat one down below
# # e.g. 5297 rows vs. 4193 rows (since QC wasn't done) and different metadata
# 
# head(obj_sce[[]], n = 3)
# ##                     orig.ident nCount_RNA nFeature_RNA nCount_ADT nFeature_ADT         Sample            Barcode
# ## AAACCCAAGAGACAAG SeuratProject       7375         2363       5178           31 pbmc5k-CITEseq AAACCCAAGAGACAAG-1
# ## AAACCCAAGGCCTAGA SeuratProject       3772         1259       2893           29 pbmc5k-CITEseq AAACCCAAGGCCTAGA-1
# ## AAACCCAGTCGTGCCA SeuratProject       4902         1578       3635           29 pbmc5k-CITEseq AAACCCAGTCGTGCCA-1
# ##                          Sequence Library Cell_ranger_version Tissue_status Barcode_type   Chemistry Sequence_platform
# ## AAACCCAAGAGACAAG AAACCCAAGAGACAAG       1              v3.0.2          <NA>     Chromium Chromium_v3           NovaSeq
# ## AAACCCAAGGCCTAGA AAACCCAAGGCCTAGA       1              v3.0.2          <NA>     Chromium Chromium_v3           NovaSeq
# ## AAACCCAGTCGTGCCA AAACCCAGTCGTGCCA       1              v3.0.2          <NA>     Chromium Chromium_v3           NovaSeq
# ##                    Individual Date_published
# ## AAACCCAAGAGACAAG HealthyDonor     2019-05-29
# ## AAACCCAAGGCCTAGA HealthyDonor     2019-05-29
# ## AAACCCAGTCGTGCCA HealthyDonor     2019-05-29
# 
# # save the data locally if desired
# save(data_blocks_sc_sce, obj_sce,
#      file = file.path(path_data, "data_sc_sce.Rda"))

## ----data-10x-object, eval = FALSE--------------------------------------------
# # load the data (change the file path as needed)
# data <- Seurat::Read10X(data.dir = file.path(path_data, "tenx_pbmc5k_CITEseq",
#                                              "filtered_feature_bc_matrix"),
#                         strip.suffix = TRUE) # remove the "-1"s from barcodes
# ## 10X data contains more than one type and is being returned as a list
# ## containing matrices of each type.
# 
# # set minimum cells and/or features here if you'd like
# obj <- Seurat::CreateSeuratObject(counts = data$`Gene Expression`,
#                                   project = "pbmc5k_CITEseq")
# obj[["ADT"]] <- Seurat::CreateAssayObject(counts = data$`Antibody Capture`)
# ## Warning: Feature names cannot have underscores ('_'), replacing with dashes ('-')
# 
# # check the assays
# Seurat::Assays(object = obj)
# ## "RNA" "ADT"
# 
# # list out the CITE-Seq surface protein markers
# rownames(obj[["ADT"]])
# ## [1] "CD3-TotalSeqB"            "CD4-TotalSeqB"           "CD8a-TotalSeqB"
# ## [4] "CD11b-TotalSeqB"          "CD14-TotalSeqB"          "CD15-TotalSeqB"
# ## [7] "CD16-TotalSeqB"           "CD19-TotalSeqB"          "CD20-TotalSeqB"
# ## [10] "CD25-TotalSeqB"          "CD27-TotalSeqB"          "CD28-TotalSeqB"
# ## [13] "CD34-TotalSeqB"          "CD45RA-TotalSeqB"        "CD45RO-TotalSeqB"
# ## [16] "CD56-TotalSeqB"          "CD62L-TotalSeqB"         "CD69-TotalSeqB"
# ## [19] "CD80-TotalSeqB"          "CD86-TotalSeqB"          "CD127-TotalSeqB"
# ## [22] "CD137-TotalSeqB"         "CD197-TotalSeqB"         "CD274-TotalSeqB"
# ## [25] "CD278-TotalSeqB"         "CD335-TotalSeqB"         "PD-1-TotalSeqB"
# ## [28] "HLA-DR-TotalSeqB"        "TIGIT-TotalSeqB"         "IgG1-control-TotalSeqB"
# ## [31] "IgG2a-control-TotalSeqB" "IgG2b-control-TotalSeqB"
# 
# # save the data locally if desired
# saveRDS(obj, file = file.path(path_data, "tenx_pbmc5k_CITEseq_raw.rds"))

## ----mcia-metadata------------------------------------------------------------
# read in the annotated cells
metadata_sc <- read.csv(file = path_metadata_sc[1], header = TRUE, row.names = 1)

# examples
metadata_sc %>% slice_sample(n = 5)

## ----mcia-decomp-load-data, eval = FALSE--------------------------------------
# # load the object set up for running MCIA [10x Genomics & Seurat]
# # (if you save it in the following code block or download it from a release)
# load(file = path_data_blocks)

## ----mcia-decomp-run, eval = FALSE--------------------------------------------
# # "largest_sv" results in a more balanced contribution
# # from the blocks than the default "unit_var"
# set.seed(42)
# 
# # convert data_blocks_sc to an MAE object using the SingleCellExperiment class
# data_blocks_sc_mae <-
#   MultiAssayExperiment::MultiAssayExperiment(lapply(data_blocks_sc, function(x)
#     SingleCellExperiment::SingleCellExperiment(t(as.matrix(x)))),
#     colData = metadata_sc)
# 
# mcia_results_sc <- nipals_multiblock(data_blocks = data_blocks_sc_mae,
#                                      col_preproc_method = "colprofile",
#                                      block_preproc_method = "largest_sv",
#                                      num_PCs = 10, tol = 1e-9,
#                                      deflationMethod = "global",
#                                      plots = "none")
# ## Performing column-level pre-processing...
# ## Column pre-processing completed.
# ## Performing block-level preprocessing...
# ## Block pre-processing completed.
# ## Computing order 1 scores
# ## Computing order 2 scores
# ## Computing order 3 scores
# ## Computing order 4 scores
# ## Computing order 5 scores
# ## Computing order 6 scores
# ## Computing order 7 scores
# ## Computing order 8 scores
# ## Computing order 9 scores
# ## Computing order 10 scores
# 
# # saveRDS(mcia_results_sc, file = file.path(path_data, "mcia_results_sc.Rds"))

## ----mcia-decomp-load---------------------------------------------------------
# load the results of the previous block (if already run and saved)
mcia_results_sc <- readRDS(file = path_mcia_results[1])
mcia_results_sc

## ----mcia-plots-colors--------------------------------------------------------
# for the projection plot
# technically you could just do color_pal_params = list(option = "D"), but saving
# the colors is useful for other plots like in the Seurat section
meta_colors_sc <- get_metadata_colors(mcia_results = mcia_results_sc,
                                      color_col = "CellType",
                                      color_pal = scales::viridis_pal,
                                      color_pal_params = list(option = "D"))

# for other plots
colors_omics_sc <- get_colors(mcia_results = mcia_results_sc)

## ----mcia-plots-eigenvalue-scree, fig.dim = c(5, 4)---------------------------
global_scores_eigenvalues_plot(mcia_results = mcia_results_sc)

## ----mcia-plots-projection, fig.dim = c(5, 5)---------------------------------
projection_plot(mcia_results = mcia_results_sc,
                projection = "global", orders = c(1, 2),
                color_col = "CellType", color_pal = meta_colors_sc,
                legend_loc = "bottomright")

## ----mcia-plots-heatmap-global, fig.dim = c(7, 5)-----------------------------
suppressMessages(global_scores_heatmap(mcia_results = mcia_results_sc,
                                       color_col = "CellType",
                                       color_pal = meta_colors_sc))

## ----mcia-plots-heatmap-block, fig.dim = c(4, 2.5)----------------------------
block_weights_heatmap(mcia_results = mcia_results_sc)

## ----mcia-plots-loadings, fig.dim = c(6, 4.5)---------------------------------
vis_load_plot(mcia_results = mcia_results_sc,
              axes = c(1, 4), color_pal = colors_omics_sc)

## ----mcia-plots-top-features-factor-1, fig.dim = c(10, 4)---------------------
all_pos_1_vis <- vis_load_ord(mcia_results_sc, omic = "all", factor = 1, 
                              absolute = FALSE, descending = TRUE)
mrna_pos_1_vis <- vis_load_ord(mcia_results_sc, omic = "mrna", factor = 1, 
                               absolute = FALSE, descending = TRUE)

ggpubr::ggarrange(all_pos_1_vis, mrna_pos_1_vis, widths = c(1, 1))

## ----mcia-plots-top-features-factor-1-orderings-------------------------------
all_pos_1 <- ord_loadings(mcia_results_sc, omic = "all", factor = 1, 
                              absolute = FALSE, descending = TRUE)
mrna_pos_1 <- ord_loadings(mcia_results_sc, omic = "mrna", factor = 1, 
                               absolute = FALSE, descending = TRUE)

## ----mcia-plots-top-features-factor-1-orderings-1-----------------------------
# visualize the tabular data
all_pos_1[1:3, ]

## ----mcia-plots-top-features-factor-1-orderings-2-----------------------------
mrna_pos_1[1:3, ]

## ----mcia-plots-top-features-factor-4, fig.dim = c(10, 5)---------------------
vis_load_ord(mcia_results_sc, omic = "all", factor = 4, n_feat = 60,
             absolute = FALSE, descending = TRUE)

## ----seurat-load-data, message = FALSE----------------------------------------
# load the data
obj <- readRDS(file = path_obj_raw[1])

# add useful metadata
obj[["percent.mt"]] <- PercentageFeatureSet(object = obj, pattern = "^MT-")

## ----seurat-qc-metrics-summary------------------------------------------------
# read in and display the summary table
metrics_summary <- read.csv(file = path_metrics_summary[1])
metrics_summary

## ----seurat-qc-pre-filter, fig.dim = c(8, 5)----------------------------------
VlnPlot(object = obj,
        features = c("nFeature_RNA", "nCount_RNA", "percent.mt"),
        pt.size = 0.01, ncol = 3) &
  theme(axis.text.x = element_text(angle = 0, hjust = 0.5),
        axis.title.x = element_blank())

## ----seurat-qc-post-filter, fig.dim = c(8, 5)---------------------------------
# adjust cutoffs as desired
obj <- subset(x = obj, subset = nFeature_RNA > 200 & percent.mt < 20)

VlnPlot(object = obj,
        features = c("nFeature_RNA", "nCount_RNA", "percent.mt"),
        pt.size = 0.01, ncol = 3) &
  theme(axis.text.x = element_text(angle = 0, hjust = 0.5),
        axis.title.x = element_blank())

## ----seurat-pipeline-1, eval = FALSE------------------------------------------
# # standard log normalization for RNA and centered log for ADT
# obj <- NormalizeData(object = obj, normalization.method = "LogNormalize",
#                      scale.factor = 10000, assay = "RNA")
# ## Performing log-normalization
# ## 0%   10   20   30   40   50   60   70   80   90   100%
# ## [----|----|----|----|----|----|----|----|----|----|
# ## **************************************************|
# 
# obj <- NormalizeData(object = obj, normalization.method = "CLR",
#                      margin = 2, assay = "ADT") # go across cells, not features
# ## Normalizing across cells
# ##   |++++++++++++++++++++++++++++++++++++++++++++++++++| 100% elapsed=00s
# 
# # highly variable features
# obj <- FindVariableFeatures(object = obj, selection.method = "vst",
#                             nfeatures = 2000)
# ## Calculating gene variances
# ## 0%   10   20   30   40   50   60   70   80   90   100%
# ## [----|----|----|----|----|----|----|----|----|----|
# ## **************************************************|
# ## Calculating feature variances of standardized and clipped values
# ## 0%   10   20   30   40   50   60   70   80   90   100%
# ## [----|----|----|----|----|----|----|----|----|----|
# ## **************************************************|
# 
# # scaling so the average expression is 0 and the variance is 1
# obj <- ScaleData(object = obj, features = rownames(obj))
# ## Centering and scaling data matrix
# ##   |===============================================================================================| 100%
# 
# # dimensionality reduction
# obj <- RunPCA(object = obj)
# ## PC_ 1
# ## Positive:  LYZ, FCN1, CST3, MNDA, CTSS, PSAP, S100A9, FGL2, AIF1, GRN
# ##     NCF2, LST1, CD68, TYMP, SERPINA1, CYBB, CLEC12A, CSTA, SPI1, TNFAIP2
# ##     CPVL, VCAN, MPEG1, TYROBP, KLF4, FTL, S100A8, IGSF6, CD14, MS4A6A
# ## Negative:  CD3D, TRAC, LTB, TRBC2, IL32, CD3G, IL7R, CD69, CD247, TRBC1
# ##     CD2, CD7, CD27, ARL4C, ISG20, HIST1H4C, SYNE2, GZMM, ITM2A, CCR7
# ##     RORA, MAL, CXCR4, LEF1, TRAT1, CTSW, GZMA, KLRB1, TRABD2A, CCL5
# ## PC_ 2
# ## Positive:  CD79A, MS4A1, IGHM, BANK1, HLA-DQA1, CD79B, IGKC, LINC00926, RALGPS2, TNFRSF13C
# ##     VPREB3, IGHD, SPIB, CD22, FCRL1, HLA-DQB1, BLK, FAM129C, FCRLA, TCL1A
# ##     GNG7, TCF4, COBLL1, PAX5, SWAP70, CD40, BCL11A, P2RX5, TSPAN13, ADAM28
# ## Negative:  NKG7, CST7, GZMA, PRF1, KLRD1, CTSW, FGFBP2, GNLY, GZMH, CCL5
# ##     GZMM, CD247, KLRF1, HOPX, SPON2, ADGRG1, TRDC, MATK, GZMB, FCGR3A
# ##     S100A4, CCL4, CLIC3, KLRB1, IL2RB, TBX21, TTC38, ANXA1, PTGDR, PLEKHF1
# ## PC_ 3
# ## Positive:  GZMB, NKG7, GNLY, CLIC3, PRF1, KLRD1, FGFBP2, KLRF1, SPON2, CST7
# ##     GZMH, FCGR3A, ADGRG1, GZMA, HOPX, CTSW, TRDC, CCL4, HLA-DPB1, C12orf75
# ##     PLAC8, TTC38, PLEK, APOBEC3G, TBX21, PRSS23, CYBA, MATK, SYNGR1, CXXC5
# ## Negative:  IL7R, MAL, LEF1, TRABD2A, TRAC, CCR7, LTB, CD27, FOS, LRRN3
# ##     FHIT, TRAT1, RGCC, CAMK4, CD3D, RGS10, CD40LG, FOSB, AQP3, SOCS3
# ##     FLT3LG, CD3G, SLC2A3, TSHZ2, VIM, S100A12, S100A8, CD28, PLK3, VCAN
# ## PC_ 4
# ## Positive:  FCER1A, PLD4, SERPINF1, IL3RA, CLEC10A, GAS6, LILRA4, TPM2, CLEC4C, ENHO
# ##     FLT3, SMPD3, ITM2C, LGMN, CD1C, P2RY14, PPP1R14B, SCT, PROC, LAMP5
# ##     RUNX2, AC119428.2, PACSIN1, DNASE1L3, PTCRA, RGS10, UGCG, CLIC2, PPM1J, P2RY6
# ## Negative:  MS4A1, CD79A, LINC00926, BANK1, TNFRSF13C, VPREB3, CD79B, RALGPS2, IGHD, FCRL1
# ##     BLK, IGHM, CD22, PAX5, ARHGAP24, CD24, P2RX5, NCF1, S100A12, CD19
# ##     SWAP70, FCRLA, VNN2, TNFRSF13B, FCER2, IGKC, FCRL2, RBP7, CD40, S100A8
# ## PC_ 5
# ## Positive:  BATF3, C1QA, TCF7L2, CTSL, CDKN1C, HLA-DQB1, HES4, SIGLEC10, CLEC10A, ABI3
# ##     HLA-DQA1, RHOC, CSF1R, ENHO, CAMK1, MTSS1, IFITM3, CD1C, LY6E, FCGR3A
# ##     HLA-DPA1, CLIC2, HLA-DPB1, YBX1, RRAS, AC064805.1, NR4A1, GBP1, ZNF703, CXCL16
# ## Negative:  LILRA4, TPM2, CLEC4C, SMPD3, IL3RA, SERPINF1, DERL3, MZB1, SCT, JCHAIN
# ##     PACSIN1, PROC, S100A12, PTCRA, LINC00996, PADI4, ASIP, KCNK17, ITM2C, EPHB1
# ##     ALOX5AP, LAMP5, DNASE1L3, MAP1A, S100A8, APP, CYP1B1, VNN2, UGCG, ZFAT
# 
# # clustering (adjust dimensions and resolutions as desired)
# obj <- FindNeighbors(object = obj, reduction = "pca", dims = 1:20)
# ## Computing nearest neighbor graph
# ## Computing SNN
# 
# obj <- FindClusters(object = obj, resolution = 0.4)
# ## Modularity Optimizer version 1.3.0 by Ludo Waltman and Nees Jan van Eck
# ##
# ## Number of nodes: 4193
# ## Number of edges: 154360
# ##
# ## Running Louvain algorithm...
# ## 0%   10   20   30   40   50   60   70   80   90   100%
# ## [----|----|----|----|----|----|----|----|----|----|
# ## **************************************************|
# ## Maximum modularity in 10 random starts: 0.9097
# ## Number of communities: 10
# ## Elapsed time: 0 seconds
# 
# obj <- RunUMAP(object = obj, reduction = "pca", dims = 1:20)
# ## 14:44:35 UMAP embedding parameters a = 0.9922 b = 1.112
# ## 14:44:35 Read 4193 rows and found 20 numeric columns
# ## 14:44:35 Using Annoy for neighbor search, n_neighbors = 30
# ## 14:44:35 Building Annoy index with metric = cosine, n_trees = 50
# ## 0%   10   20   30   40   50   60   70   80   90   100%
# ## [----|----|----|----|----|----|----|----|----|----|
# ## **************************************************|
# ## 14:44:36 Writing NN index file to temp file /tmp/RtmpHhoQAU/filec346711dd9f93
# ## 14:44:36 Searching Annoy index using 1 thread, search_k = 3000
# ## 14:44:37 Annoy recall = 100%
# ## 14:44:38 Commencing smooth kNN distance calibration using 1 thread with target n_neighbors = 30
# ## 14:44:39 Initializing from normalized Laplacian + noise (using RSpectra)
# ## 14:44:39 Commencing optimization for 500 epochs, with 174318 positive edges
# ## Using method 'umap'
# ## 0%   10   20   30   40   50   60   70   80   90   100%
# ## [----|----|----|----|----|----|----|----|----|----|
# ## **************************************************|
# ## 14:44:44 Optimization finished

## ----seurat-load-processed-object---------------------------------------------
obj <- readRDS(file = path_obj_annotated[1])

# reset to baseline
Idents(object = obj) <- "seurat_clusters"
obj$annotated_clusters <- c()

## ----seurat-elbow, fig.dim = c(6, 3)------------------------------------------
ElbowPlot(object = obj, ndims = 30)

## ----seurat-top-features------------------------------------------------------
head(VariableFeatures(object = obj), 20)

## ----seurat-top-features-plot, fig.dim = c(6, 6), warning = FALSE, eval = FALSE----
# # these can be plotted if desired
# LabelPoints(plot = VariableFeaturePlot(object = obj),
#             points = head(VariableFeatures(object = obj), 20),
#             repel = TRUE, xnudge = 0, ynudge = 0) +
#   labs(title = "Top Twenty Variable Features") +
#   theme(legend.position = "bottom")

## ----seurat-umap-initial, fig.dim = c(6, 6), message = FALSE------------------
# you can also use the LabelClusters function to help label individual clusters
plot_seurat_clusters <-
  UMAPPlot(object = obj, label = TRUE, label.size = 4, label.box = TRUE) +
  labs(title = "Initial Clusters") +
  scale_fill_manual(values = rep("white", n_distinct(obj$seurat_clusters))) +
  theme(plot.title = element_text(hjust = 0.5),
        axis.text = element_blank(), axis.ticks = element_blank())

plot_seurat_clusters

## ----seurat-markers-load------------------------------------------------------
# sort by Cell_Type and Marker if not already sorted
markers_all <- read.csv(file = path_marker_genes[1])
markers_all %>% slice_sample(n = 10) # example markers

## ----seurat-markers-dot-gex, fig.dim = c(16, 6), warning = FALSE--------------
select_cell_types <- c("B", "Macrophages", "mDC", "NK", "T")

# do features = unique(markers_all$Marker) to use all possible features
p <- DotPlot(object = obj,
             features = markers_all %>%
                          dplyr::filter(Cell_Type %in% select_cell_types) %>%
                          distinct(Marker) %>% pull(),
             cols = "RdBu", col.min = -1, dot.scale = 3, cluster.idents = TRUE)

# add in the cell type information
# if desired, you could rename the "Cell_Type"s in the original database to be
# more informative e.g. Natural_Killers instead of NK
p$data <- left_join(p$data,
                    markers_all %>%
                      dplyr::filter(Cell_Type %in% select_cell_types) %>%
                      dplyr::rename(features.plot = "Marker"),
                    by = "features.plot", multiple = "all")
# depending on your version of dplyr, you can set `relationship = "many-to-many"`
# to surpress the warning

# plot
p +
  facet_grid(cols = vars(Cell_Type), scales = "free_x", space = "free") +
  theme(strip.text.x = element_text(size = 10)) + RotatedAxis()

## ----seurat-markers-dot-adt, fig.dim = c(16, 6)-------------------------------
# you have to change the default assay for the dot plot
DefaultAssay(object = obj) <- "ADT"

DotPlot(object = obj,
        features =
          rownames(GetAssayData(object = obj, layer = "counts", assay = "ADT")),
        cols = "RdBu", col.min = -1, dot.scale = 3, cluster.idents = TRUE) +
  RotatedAxis()

# reset the default
DefaultAssay(object = obj) <- "RNA"

## ----seurat-markers-feature, fig.dim = c(12, 8)-------------------------------
FeaturePlot(object = obj,
            features = c("MS4A1", "CD14", # MS4A1 is another name for CD20
                         "NKG7", "IL3RA", "CD3D", "IL7R"),
            min.cutoff = 0, label = TRUE, label.size = 4,
            ncol = 3, raster = FALSE)

## ----seurat-markers-violin-adt, fig.dim = c(8, 8)-----------------------------
VlnPlot(object = obj,
        features = c("CD3-TotalSeqB", "CD14-TotalSeqB", "CD20-TotalSeqB",
                     "CD335-TotalSeqB"),
        pt.size = 0, assay = "ADT", ncol = 2) &
  theme(plot.title = element_text(size = 10),
        axis.text.x = element_text(angle = 0, hjust = 0.5),
        axis.title.x = element_blank())

## ----seurat-annotations-------------------------------------------------------
# mDC = myeloid dendritic cells
# pDC = plasmacytoid dendritic cells
obj_annotations <- rbind(c("0", "Macrophages/mDCs"), # difficult to separate
                         c("1", "T Cells"),
                         c("2", "T Cells"),
                         c("3", "T Cells"),
                         c("4", "Natural Killers"),
                         c("5", "B Cells"),
                         c("6", "Macrophages/mDCs"), # difficult to separate
                         c("7", "Macrophages/mDCs"), # difficult to separate
                         c("8", "T Cells"), # faint signal
                         c("9", "pDCs"))
colnames(obj_annotations) <- c("Cluster", "CellType")
obj_annotations <- data.frame(obj_annotations)

# save the annotations as a csv if you'd like
# write.csv(obj_annotations, file = file.path(path_data, "obj_annotations.csv"))

# prepare the annotation information
annotations <- setNames(obj_annotations$CellType, obj_annotations$Cluster)

# relabel the Seurat clusters
# Idents(obj) <- "seurat_clusters"
obj <- RenameIdents(object = obj, annotations)

# alphabetize the cell types
Idents(obj) <- factor(Idents(object = obj), levels = sort(levels(obj)))

# useful metadata (e.g. if you want to have multiple annotation sets)
obj[["annotated_clusters"]] <- Idents(object = obj)

# save the processed and annotated Seurat object
# saveRDS(obj, file = file.path(path_data, "tenx_pbmc5k_CITEseq_annotated.rds"))

# info about the clusters
obj_annotations %>%
  group_by(CellType) %>%
  transmute(Clusters = paste0(Cluster, collapse = ", ")) %>%
  distinct() %>%
  arrange(CellType)

# metadata file for MCIA
meta <- data.frame("CellType" = Idents(object = obj))

# save the metadata file for MCIA
# write.csv(meta, file = file.path(path_data, "metadata_sc.csv"))

## ----seurat-umap-both, fig.dim = c(16, 8), message = FALSE--------------------
# change colors and themes as desired
plot_annotated_clusters <-
  UMAPPlot(object = obj, cols = meta_colors_sc, label = TRUE, label.size = 4,
           label.box = TRUE) +
  labs(title = "Annotated Clusters") +
  scale_fill_manual(values = rep("white", length(meta_colors_sc))) +
  theme(plot.title = element_text(hjust = 0.5),
        axis.text = element_blank(), axis.ticks = element_blank()) +
  NoLegend() # a legend is not needed here

ggpubr::ggarrange(plot_seurat_clusters + NoLegend(), plot_annotated_clusters,
                  heights = c(1, 1), widths = c(1, 1))

## ----seurat-umap-adt, fig.dim = c(6, 6)---------------------------------------
# plot ADT information on top as an example
FeaturePlot(object = obj, features = "adt_CD19-TotalSeqB",
            label = TRUE, label.size = 4, ncol = 1, raster = FALSE)

## ----seurat-check-annotations-violin, fig.dim = c(8, 8)-----------------------
VlnPlot(object = obj,
        features = c("CD3D", "CD4", "IL7R", "TRAC"),
        cols = meta_colors_sc, pt.size = 0.01, ncol = 2) &
  theme(plot.title = element_text(size = 10),
        axis.title.x = element_blank())

## ----seurat-check-annotations-bar, fig.dim = c(8, 6)--------------------------
# examine the total counts
ggplot(obj[[]], aes(x = annotated_clusters, fill = annotated_clusters)) +
  geom_bar(color = "black", linewidth = 0.2) +
  labs(title = "pbmc5k-CITEseq Cell Type Counts",
       x = "Cell Type", y = "Count") +
  scale_fill_manual(values = meta_colors_sc) +
  theme_bw() +
  theme(plot.title = element_text(size = 14, hjust = 0.5),
        axis.text.x = element_text(angle = 45, hjust = 1),
        panel.grid.major.x = element_blank(), legend.position = "none")

## ----seurat-save-mcia, eval = FALSE-------------------------------------------
# # mrna
# data_rna <- GetAssayData(object = obj, layer = "data",
#                          assay = "RNA")[VariableFeatures(object = obj), ]
# data_rna <- as.matrix(data_rna)
# data_rna <- t(data_rna) # switch the rows
# # colnames(data_rna) <- paste(colnames(data_rna), "mrna", sep = "_")
# 
# # adt
# data_adt <- GetAssayData(object = obj, layer = "data", assay = "ADT")
# data_adt <- as.matrix(data_adt)
# data_adt <- t(data_adt) # switch the rows
# # colnames(data_adt) <- paste(colnames(data_adt), "adt", sep = "_")
# 
# # combined
# data_blocks_sc <- list(mrna = data_rna, adt = data_adt)
# 
# # examine the contents
# data.frame(data_blocks_sc$mrna[1:5, 1:5])
# data.frame(data_blocks_sc$adt[1:5, 1:5])
# 
# # save(data_blocks_sc, file = file.path(path_data, "data_blocks_sc.Rda"))

## ----session-info-------------------------------------------------------------
sessionInfo()

