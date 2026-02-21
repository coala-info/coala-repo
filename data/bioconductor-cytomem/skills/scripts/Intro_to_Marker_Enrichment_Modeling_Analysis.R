# Code example from 'Intro_to_Marker_Enrichment_Modeling_Analysis' vignette. See references/ for full tutorial.

## ----install_MEM,eval = FALSE-------------------------------------------------
# 
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("cytoMEM")
# 

## ----PBMC_data,eval=TRUE------------------------------------------------------
library(cytoMEM)
data(PBMC)
head(PBMC)

## ----MEM,eval=TRUE------------------------------------------------------------

MEM_values <-
  MEM(
    PBMC,
    transform = TRUE,
    cofactor = 15,
    # Change choose.markers to TRUE to see and select channels in console
    choose.markers = FALSE,
    markers = "all",
    choose.ref = FALSE,
    zero.ref = FALSE,
    # Change rename.markers to TRUE to see and choose new names for channels in console
    rename.markers = FALSE,
    new.marker.names = "none",
    IQR.thresh = NULL
  )

str(MEM_values)


## ----build_heatmaps,eval=TRUE-------------------------------------------------

build_heatmaps(
  MEM_values,
  cluster.MEM = "both",
  cluster.medians = "none",
  cluster.IQRs = "none",
  display.thresh = 1,
  output.files = FALSE,
  labels = FALSE,
  only.MEMheatmap = FALSE)


## ----RMSD, eval=TRUE----------------------------------------------------------
#data(MEM_matrix)

MEM_RMSD(
  MEM_values[[5]][[1]],
  format=NULL,
  output.matrix=FALSE)


## ----eval=TRUE----------------------------------------------------------------

sessionInfo()


