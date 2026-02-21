# Code example from 'HCATonsilData' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = TRUE
)

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("HCATonsilData")

## ----message=FALSE------------------------------------------------------------
library("HCATonsilData")
library("SingleCellExperiment")
library("ExperimentHub")
library("scater")
library("ggplot2")
library("knitr")
library("kableExtra")
library("htmltools")

## -----------------------------------------------------------------------------
data("donor_metadata")

kable(
  donor_metadata,
  format = "markdown",
  caption = "Donor Metadata",
  align = "c"
) |> kable_styling(full_width = FALSE)

## ----echo=FALSE, out.width = "100%"-------------------------------------------
knitr::include_graphics("tonsil_atlas_cohort.png")

## ----echo=FALSE, out.width = "100%"-------------------------------------------
knitr::include_graphics("tonsil_atlas_n_detected_genes.png")

## ----echo=FALSE, out.width = "100%"-------------------------------------------
knitr::include_graphics("tonsil_atlas_umap_9_compartments.png")

## ----echo=FALSE, out.width = "100%"-------------------------------------------
knitr::include_graphics("tonsil_atlas_umaps.png")

## ----echo=FALSE, out.width = "100%"-------------------------------------------
knitr::include_graphics("tonsil_atlas_umap_discovery_validation_cohort.png")

## ----echo=FALSE, out.width = "100%"-------------------------------------------
knitr::include_graphics("tonsil_atlas_umap_discovery_validation_cohort_CD4.png")

## ----eval=FALSE---------------------------------------------------------------
# (sce <- HCATonsilData(assayType = "RNA", cellType = "All"))
# table(sce$assay)

## -----------------------------------------------------------------------------
listCellTypes(assayType = "RNA")
(epithelial <- HCATonsilData(assayType = "RNA", cellType = "epithelial"))
data("colors_20230508")
scater::plotUMAP(epithelial, colour_by = "annotation_20230508") +
  ggplot2::scale_color_manual(values = colors_20230508$epithelial) +
  ggplot2::theme(legend.title = ggplot2::element_blank())

## -----------------------------------------------------------------------------
data("annotations_dictionary")
annotations_dictionary[["dict_20220619_to_20230508"]]

# load also a predefined palette of colors, to match the ones used in the manuscript 
data("colors_20230508")

(epithelial_discovery <- HCATonsilData("RNA", "epithelial", version = "1.0"))
scater::plotUMAP(epithelial, colour_by = "annotation_20230508") +
  ggplot2::scale_color_manual(values = colors_20230508$epithelial) +
  ggplot2::theme(legend.title = ggplot2::element_blank())

## ----eval=FALSE---------------------------------------------------------------
# library("Seurat")
# library("Signac")
# 
# download_dir = tempdir()
# 
# options(timeout = 10000000)
# atac_url <- "https://zenodo.org/record/8373756/files/TonsilAtlasSeuratATAC.tar.gz"
# download.file(
#   url = atac_url,
#   destfile = file.path(download_dir, "TonsilAtlasSeuratATAC.tar.gz")
# )
# # Advice: check that the md5sum is the same as the one in Zenodo
# untar(
#   tarfile = file.path(download_dir, "TonsilAtlasSeuratATAC.tar.gz"),
#   exdir = download_dir
# )
# atac_seurat <- readRDS(
#   file.path(download_dir, "scATAC-seq/20230911_tonsil_atlas_atac_seurat_obj.rds")
# )
# atac_seurat

## ----eval=FALSE---------------------------------------------------------------
# library("Seurat")
# library("Signac")
# 
# download_dir = tempdir()
# 
# options(timeout = 10000000)
# multiome_url <- "https://zenodo.org/record/8373756/files/TonsilAtlasSeuratMultiome.tar.gz"
# download.file(
#   url = multiome_url,
#   destfile = file.path(download_dir, "TonsilAtlasSeuratMultiome.tar.gz")
# )
# # Advice: check that the md5sum is the same as the one in Zenodo
# untar(
#   tarfile = file.path(download_dir, "TonsilAtlasSeuratMultiome.tar.gz"),
#   exdir = download_dir
# )
# multiome_seurat <- readRDS(
#   file.path(download_dir, "/multiome/20230911_tonsil_atlas_multiome_seurat_obj.rds")
# )
# multiome_seurat

## ----eval=FALSE---------------------------------------------------------------
# download_dir = tempdir()
# 
# fragments_url <- "https://zenodo.org/record/8373756/files/fragments_files.tar.gz"
# download.file(
#   url = fragments_url,
#   destfile = file.path(download_dir, "fragments_files.tar.gz")
# )
# untar(
#   tarfile = file.path(download_dir, "fragments_files.tar.gz"),
#   exdir = download_dir
# )

## ----eval=FALSE---------------------------------------------------------------
# library("Seurat")
# 
# download_dir = tempdir()
# 
# options(timeout = 10000000)
# cite_url <- "https://zenodo.org/record/8373756/files/TonsilAtlasSeuratCITE.tar.gz"
# download.file(
#   url = cite_url,
#   destfile = file.path(download_dir, "TonsilAtlasSeuratCITE.tar.gz")
# )
# # Advice: check that the md5sum is the same as the one in Zenodo
# untar(
#   tarfile = file.path(download_dir, "TonsilAtlasSeuratCITE.tar.gz"),
#   exdir = download_dir
# )
# 
# cite_seurat <- readRDS(
#   file.path(download_dir, "CITE-seq/20220215_tonsil_atlas_cite_seurat_obj.rds")
# )
# cite_seurat

## ----eval=FALSE---------------------------------------------------------------
# scirpy_df <- read.csv(
#   file = file.path(download_dir, "CITE-seq/scirpy_tcr_output.tsv"),
#   header = TRUE
# )
# 
# head(scirpy_df)

## ----eval=FALSE---------------------------------------------------------------
# library("SpatialExperiment")
# (spe <- HCATonsilData(assayType = "Spatial"))

## ----eval=FALSE---------------------------------------------------------------
# library("ggspavis")
# sub <- spe[, spe$sample_id == "esvq52_nluss5"]
# plt <- plotVisium(sub, fill="SELENOP") +
#   scale_fill_gradientn(colors=rev(hcl.colors(9, "Spectral")))
# plt$layers[[2]]$aes_params$size <- 1.5
# plt$layers[[2]]$aes_params$alpha <- 1
# plt$layers[[2]]$aes_params$stroke <- NA
# plt

## -----------------------------------------------------------------------------
glossary_df <- TonsilData_glossary()
head(glossary_df)

## -----------------------------------------------------------------------------
TonsilData_cellinfo("Tfr")

## ----eval = TRUE--------------------------------------------------------------
htmltools::includeHTML(
  TonsilData_cellinfo_html("Tfr", display_plot = TRUE)
)

## ----eval=FALSE---------------------------------------------------------------
# library("zellkonverter")
# epithelial <- HCATonsilData(assayType = "RNA", cellType = "epithelial")
# 
# epi_anndatafile <- file.path(tempdir(), "epithelial.h5ad")
# 
# writeH5AD(sce = epithelial, file = epi_anndatafile)

## ----launchisee, eval=FALSE---------------------------------------------------
# if (require(iSEE)) {
#   iSEE(epithelial)
# }

## -----------------------------------------------------------------------------
sessionInfo()

