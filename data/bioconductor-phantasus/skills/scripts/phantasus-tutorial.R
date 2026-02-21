# Code example from 'phantasus-tutorial' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# library(phantasus)
# servePhantasus()

## ----out.width = "750px", echo = FALSE----------------------------------------
knitr::include_graphics("images/start_screen.jpg")

## ----out.width = "750px", echo = FALSE----------------------------------------
knitr::include_graphics("images/dataset_loaded.jpg")

## ----out.width = "500px", echo = FALSE----------------------------------------
knitr::include_graphics("images/huge_value.jpg")

## ----out.width = "500px", echo = FALSE----------------------------------------
knitr::include_graphics("images/adjust_tool.jpg")

## ----out.width = "600px", echo = FALSE----------------------------------------
knitr::include_graphics("images/duplicates.jpg")

## ----out.width = "500px", echo = FALSE----------------------------------------
knitr::include_graphics("images/collapse_tool.jpg")

## ----out.width = "500px", echo = FALSE----------------------------------------
knitr::include_graphics("images/calculated_annotation_tool.jpg")

## ----out.width = "600px", echo = FALSE----------------------------------------
knitr::include_graphics("images/calculated_annotation_loaded.jpg")

## ----out.width = "500px", echo = FALSE----------------------------------------
knitr::include_graphics("images/filter_tool.jpg")

## ----out.width = "500px", echo = FALSE----------------------------------------
knitr::include_graphics("images/filter_tool_result.jpg")

## ----out.width = "550px", echo = FALSE----------------------------------------
knitr::include_graphics("images/pcaplot_tool_clean.png")

## ----out.width = "550px", echo = FALSE----------------------------------------
knitr::include_graphics("images/pcaplot_tool_finished.png")

## ----out.width = "500px", echo = FALSE----------------------------------------
knitr::include_graphics("images/kmeans_tool.jpg")

## ----out.width = "600px", echo = FALSE----------------------------------------
knitr::include_graphics("images/kmeans_result.jpg")

## ----out.width = "500px", echo = FALSE----------------------------------------
knitr::include_graphics("images/hierarchical_tool.jpg")

## ----out.width = "600px", echo = FALSE----------------------------------------
knitr::include_graphics("images/good_samples.jpg")

## ----out.width = "500px", echo = FALSE----------------------------------------
knitr::include_graphics("images/limma_tool.jpg")

## ----out.width = "600px", echo = FALSE----------------------------------------
knitr::include_graphics("images/limma_results.png")

## ----out.width = "600px", echo = FALSE----------------------------------------
knitr::include_graphics("images/fgsea_tool.png")

## ----out.width = "800px", echo = FALSE----------------------------------------
knitr::include_graphics("images/fgsea_result.png")

## ----out.width = "600px", echo = FALSE----------------------------------------
knitr::include_graphics("images/annotation_tool.png")

## ----out.width = "600px", echo = FALSE----------------------------------------
knitr::include_graphics("images/annotation_result.png")

## ----out.width = "600px", echo = FALSE----------------------------------------
knitr::include_graphics("images/enrichr.png")

## ----out.width = "600px", echo = FALSE----------------------------------------
knitr::include_graphics("images/enrichr_result.png")

## ----out.width = "300px", echo = FALSE----------------------------------------
knitr::include_graphics("images/shiny_gam.jpg")

## ----out.width = "600px", echo = FALSE----------------------------------------
knitr::include_graphics("images/shiny_gam_result.jpg")

## ----out.width = "600px", echo = FALSE----------------------------------------
knitr::include_graphics("images/fgsea_genes.png")

## ----out.width = "600px", echo = FALSE----------------------------------------
knitr::include_graphics("images/fgsea_search.png")

## ----out.width = "600px", echo = FALSE----------------------------------------
knitr::include_graphics("images/GSEA_plot.png")

## ----out.width = "600px", echo = FALSE----------------------------------------
knitr::include_graphics("images/link.png")

## ----out.width="500px", echo = FALSE------------------------------------------
knitr::include_graphics("images/open_file_tool.jpg")

## ----message=FALSE, cache=TRUE, eval=FALSE------------------------------------
# library(GEOquery)
# library(limma)
# gse14308 <- getGEO("GSE14308", AnnotGPL = TRUE)[[1]]
# gse14308$condition <- sub("-.*$", "", gse14308$title)
# pData(gse14308) <- pData(gse14308)[, c("title", "geo_accession", "condition")]
# gse14308 <- gse14308[, order(gse14308$condition)]
# 
# fData(gse14308) <- fData(gse14308)[, c("Gene ID", "Gene symbol")]
# exprs(gse14308) <- normalizeBetweenArrays(log2(exprs(gse14308)+1), method="quantile")
# 
# ess <- list(GSE14308_norm=gse14308)
# 
# preloadedDir <- tempdir()
# 
# save(ess, file=file.path(preloadedDir, "GSE14308_norm.rda"))

## ----eval=F-------------------------------------------------------------------
# servePhantasus(preloadedDir=preloadedDir)

## ----out.width="650px", echo = FALSE------------------------------------------
knitr::include_graphics("images/gse14308_norm.png")

## ----eval=F-------------------------------------------------------------------
# updateARCHS4(cacheDir=cacheDir)

## ----eval=TRUE----------------------------------------------------------------
data("fgseaExample", package="phantasus")
head(fgseaExample)

