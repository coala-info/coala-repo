# Code example from 'VisiumIO' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(cache = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("VisiumIO")

## ----include=TRUE,results="hide",message=FALSE,warning=FALSE------------------
library(VisiumIO)

## ----eval=FALSE---------------------------------------------------------------
# TENxVisium(
#     resources = "path/to/10x/visium/file.tar.gz",
#     spatialResource = "path/to/10x/visium/spatial/file.spatial.tar.gz",
#     spacerangerOut = "path/to/10x/visium/sample/folder",
#     sample_id = "sample01",
#     images = c("lowres", "hires", "detected", "aligned"),
#     jsonFile = "scalefactors_json.json",
#     tissuePattern = "tissue_positions.*\\.csv",
#     spatialCoordsNames = c("pxl_col_in_fullres", "pxl_row_in_fullres")
# )

## -----------------------------------------------------------------------------
outs_folder <- system.file(
    file.path("extdata", "10xVisium", "section1", "outs"),
    package = "VisiumIO"
)

vis <- TENxVisium(
    spacerangerOut = outs_folder, processing = "raw", images = "lowres"
)
vis

## -----------------------------------------------------------------------------
import(vis)

## ----eval=FALSE---------------------------------------------------------------
# TENxVisiumList(
#     sampleFolders = "path/to/10x/visium/sample/folder",
#     sample_ids = c("sample01", "sample02"),
#     ...
# )

## -----------------------------------------------------------------------------
sample_dirs <- list.dirs(
    system.file(
        file.path("extdata", "10xVisium"), package = "VisiumIO"
    ),
    recursive = FALSE, full.names = TRUE
)
    
vlist <- TENxVisiumList(
    sampleFolders = sample_dirs,
    sample_ids = basename(sample_dirs),
    processing = "raw",
    images = "lowres"
)
vlist

## -----------------------------------------------------------------------------
import(vlist)

## ----eval=FALSE---------------------------------------------------------------
# TENxVisiumHD(
#     spacerangerOut = "./Visium_HD/",
#     sample_id = "sample01",
#     processing = c("filtered", "raw"),
#     images = c("lowres", "hires", "detected", "aligned_fiducials"),
#     bin_size = c("002", "008", "016"),
#     jsonFile = .SCALE_JSON_FILE,
#     tissuePattern = "tissue_positions\\.parquet",
#     spatialCoordsNames = c("pxl_col_in_fullres", "pxl_row_in_fullres"),
#     ...
# )

## -----------------------------------------------------------------------------
visfold <- system.file(
    package = "VisiumIO", "extdata", mustWork = TRUE
)
TENxVisiumHD(
    spacerangerOut = visfold, images = "lowres", bin_size = "002"
) |> import()

## -----------------------------------------------------------------------------
TENxVisiumHD(
    spacerangerOut = visfold, images = "lowres", bin_size = "002",
    format = "h5"
) |> import()

## ----session-info, echo=FALSE, results='asis'---------------------------------
html_output <- paste0(
    "<details><summary>",
    "Click to expand <code>sessionInfo()</code>",
    "</summary>\n\n",
    "<pre><code>",
    paste(capture.output(sessionInfo()), collapse = "\n"),
    "</code></pre>\n</details>"
)
cat(html_output)

