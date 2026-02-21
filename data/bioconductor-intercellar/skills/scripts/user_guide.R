# Code example from 'user_guide' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
    comment = "#>",
    error = FALSE,
    warning = FALSE,
    message = FALSE,
    crop = NULL
)

## ----echo=FALSE, out.width='50%', fig.align='center'--------------------------
knitr::include_graphics(path = system.file("app", "www", "logo_lowres.png", 
                                           package="InterCellar", mustWork=TRUE))

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("InterCellar")

## ----setup--------------------------------------------------------------------
library(InterCellar)

## ----demostart, eval=FALSE----------------------------------------------------
# InterCellar::run_app( reproducible = TRUE )

## ----echo=FALSE, out.width='120%',fig.align='center'--------------------------
knitr::include_graphics(path = "screenshots/upload.png")

## ----echo=FALSE, fig.align='center'-------------------------------------------
knitr::include_graphics(path = "screenshots/cl_verse_net.png")

## ----echo=FALSE, fig.align='center'-------------------------------------------
knitr::include_graphics(path = "screenshots/cl_verse_bar.png")

## ----echo=FALSE, fig.align='center'-------------------------------------------
knitr::include_graphics(path = "screenshots/g_verse_table.png")

## ----echo=FALSE, fig.align='center'-------------------------------------------
knitr::include_graphics(path = "screenshots/g_verse_dot.png")

## ----echo=FALSE, fig.align='center'-------------------------------------------
knitr::include_graphics(path = "screenshots/f_verse_sunburst.png")

## ----echo=FALSE, fig.align='center'-------------------------------------------
knitr::include_graphics(path = "screenshots/ipM_analysis.png")

## ----echo=FALSE, fig.align='center'-------------------------------------------
knitr::include_graphics(path = "screenshots/ipM_circle.png")

## ----echo=FALSE, fig.align='center'-------------------------------------------
knitr::include_graphics(path = "screenshots/ipM_function.png")

## ----echo=FALSE, fig.align='center'-------------------------------------------
knitr::include_graphics(path = "screenshots/MC_clust_bar.png")

## ----echo=FALSE, fig.align='center'-------------------------------------------
knitr::include_graphics(path = "screenshots/MC_clust_radar.png")

## ----echo=FALSE, fig.align='center'-------------------------------------------
knitr::include_graphics(path = "screenshots/MC_gene_dot.png")

## ----echo=FALSE, fig.align='center'-------------------------------------------
knitr::include_graphics(path = "screenshots/MC_func_sun.png")

