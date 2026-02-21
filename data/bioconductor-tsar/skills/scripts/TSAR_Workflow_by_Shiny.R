# Code example from 'TSAR_Workflow_by_Shiny' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(warning = FALSE, message = FALSE, comment = "#>")

## ----echo=FALSE, fig.width=4, out.width="400px"-------------------------------
knitr::include_graphics("images/TSAR_logo.png")

## ----setup--------------------------------------------------------------------
library(TSAR)
library(shiny)

## -----------------------------------------------------------------------------
data("qPCR_data1")
qPCR_data1 <- remove_raw(qPCR_data1, removerange = c("B", "H", "1", "12"))

## ----eval = FALSE-------------------------------------------------------------
# runApp(weed_raw(qPCR_data1))

## ----out.width = "400px", echo = FALSE----------------------------------------
knitr::include_graphics("images/weed_raw.png")

## ----out.width = "400px", echo = FALSE----------------------------------------
knitr::include_graphics("images/weed_raw1.png")

## ----out.width = "400px", echo = FALSE----------------------------------------
knitr::include_graphics("images/weed_raw2.png")

## ----eval = FALSE-------------------------------------------------------------
# runApp(analyze_norm(qPCR_data1))

## ----out.width = "400px", echo = FALSE----------------------------------------
knitr::include_graphics("images/analyze_norm.png")

## ----out.width = "400px", echo = FALSE----------------------------------------
knitr::include_graphics("images/analyze_norm1.png")
knitr::include_graphics("images/analyze_norm12.png")

## ----out.width = "400px", echo = FALSE----------------------------------------
knitr::include_graphics("images/analyze_norm2.png")
knitr::include_graphics("images/analyze_norm3.png")

## ----out.width = "400px", echo = FALSE----------------------------------------
knitr::include_graphics("images/analyze_norm4.png")

## ----eval = FALSE-------------------------------------------------------------
# runApp(graph_tsar())

## ----out.width = "400px", echo = FALSE----------------------------------------
knitr::include_graphics("images/graph_tsar_01.png")
knitr::include_graphics("images/graph_tsar_02.png")
knitr::include_graphics("images/graph_tsar_03.png")
knitr::include_graphics("images/graph_tsar_04.png")

## ----out.width = "400px", echo = FALSE----------------------------------------
knitr::include_graphics("images/graph_tsar.png")
knitr::include_graphics("images/graph_tsar1.png")

## ----out.width = "400px", echo = FALSE----------------------------------------
knitr::include_graphics("images/graph_tsar2.png")

## ----echo=FALSE, out.width="400px"--------------------------------------------
knitr::include_graphics("images/graph_tsar_32.png")

## ----out.width = "400px", echo = FALSE----------------------------------------
knitr::include_graphics("images/graph_tsar3.png")

## ----out.width = "400px", echo = FALSE----------------------------------------
knitr::include_graphics("images/graph_tsar6.png")

## ----out.width = "400px", echo = FALSE----------------------------------------
knitr::include_graphics("images/graph_tsar5.png")
knitr::include_graphics("images/graph_tsar4.png")

## -----------------------------------------------------------------------------
citation("TSAR")
citation()
citation("dplyr")
citation("ggplot2")
citation("shiny")
citation("utils")

## -----------------------------------------------------------------------------
sessionInfo()

