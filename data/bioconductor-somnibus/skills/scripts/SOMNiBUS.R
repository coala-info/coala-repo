# Code example from 'SOMNiBUS' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  fig.width = 10,
  comment = "#>"
)

## ----installation, echo=TRUE, eval=FALSE--------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("SOMNiBUS")

## ----eval=FALSE, echo=FALSE---------------------------------------------------
# ROOT_PACKAGE_PATH <- paste(getwd(), "/", sep = "")
# devtools::document(ROOT_PACKAGE_PATH)
# devtools::load_all(ROOT_PACKAGE_PATH)

## ----load package, echo=TRUE, message=FALSE, warning=FALSE--------------------
library(SOMNiBUS)

## -----------------------------------------------------------------------------
data("RAdat")
head(RAdat)

## ----eval = FALSE-------------------------------------------------------------
# formatFromBSseq <- function(bsseq_dat, verbose = TRUE)

## ----eval = FALSE-------------------------------------------------------------
# formatFromBismark <- function(..., verbose = TRUE)
# 
# formatFromBSmooth <- function(..., verbose = TRUE)

## -----------------------------------------------------------------------------
RAdat.f <- na.omit(RAdat[RAdat$Total_Counts != 0, ])

## -----------------------------------------------------------------------------
out <- binomRegMethModel(data = RAdat.f, n.k = rep(5, 3), p0 = 0.003, 
                         p1 = 0.9, Quasi = FALSE, RanEff = FALSE,
                         verbose = FALSE)

## ----eval=FALSE---------------------------------------------------------------
# out.ctype <- binomRegMethModel(data = RAdat.f, n.k = rep(5, 2), p0 = 0.003,
#                                p1 = 0.9, covs = "T_cell", verbose = FALSE)

## ----cache = TRUE-------------------------------------------------------------
outs <- runSOMNiBUS(dat = RAdat.f,
                    split = list(approach = "region", gap = 100),
                    n.k = rep(10,3), p0 = 0.003, p1 = 0.9, 
                    min.cpgs = 10, max.cpgs = 2000, verbose = TRUE)

## -----------------------------------------------------------------------------
as.integer(length(unique(RAdat.f$Position)) / 20)

## -----------------------------------------------------------------------------
out$reg.out

## ----fig.cap="The estimates (solid lines) and 95% pointwise confidence intervals (dashed lines) of the intercept, the smooth effect of cell type and RA on methylation levels."----
binomRegMethModelPlot(BEM.obj = out)

## ----fig.cap="The estimates (solid lines) and 95% pointwise confidence intervals (dashed lines) of the intercept, the smooth effect of cell type and RA on methylation levels. (Same ranges of Y axis.)"----
binomRegMethModelPlot(out, same.range = TRUE)

## ----fig.cap="The estimates (solid lines) and 95% pointwise confidence intervals (dashed lines) of the smooth effect of cell type and RA on methylation levels.", echo = TRUE, eval = TRUE----
# creating plot 
binomRegMethModelPlot(BEM.obj = out, same.range = FALSE, verbose = FALSE,
                      covs = c("RA", "T_cell"))

## ----fig.cap="The estimates (solid lines) and 95% pointwise confidence intervals (dashed lines) of the intercept, the smooth effect of cell type and RA on methylation levels.", echo = TRUE, fig.height = 10, eval = TRUE----
# creating a 2x2 matrix 
binomRegMethModelPlot(BEM.obj = out, same.range = FALSE, verbose = FALSE,
                      mfrow = c(2,2))

# creating a 3x1 matrix 
binomRegMethModelPlot(BEM.obj = out, same.range = FALSE, verbose = FALSE,
                      mfrow = c(3,1))

## ----eval = TRUE--------------------------------------------------------------
# simulating new data
pos <- out$uni.pos
my.p <- length(pos)
newdata <- expand.grid(pos, c(0, 1), c(0, 1))
colnames(newdata) <- c("Position", "T_cell", "RA")

## ----eval = TRUE--------------------------------------------------------------
# prediction of methylation levels for the new data (logit scale)
my.pred.log <- binomRegMethModelPred(out, newdata, type = "link.scale", 
                                 verbose = FALSE)

# prediction of methylation levels for the new data (proportion)
my.pred.prop <- binomRegMethModelPred(out, newdata, type = "proportion", 
                                  verbose = FALSE)

## ----echo = TRUE, eval = TRUE-------------------------------------------------
# creating the experimental design
newdata$group <- ""
newdata[(newdata$RA == 0 & newdata$T_cell == 0),]$group <- "CTRL MONO"
newdata[(newdata$RA == 0 & newdata$T_cell == 1),]$group <- "CTRL TCELL"
newdata[(newdata$RA == 1 & newdata$T_cell == 0),]$group <- "RA MONO"
newdata[(newdata$RA == 1 & newdata$T_cell == 1),]$group <- "RA TCELL"

# merge input data and prediction results
pred <- cbind(newdata, Logit = my.pred.log, Prop = my.pred.prop)
head(pred)

## ----echo = TRUE, eval = TRUE-------------------------------------------------
# creating the custom style for each experimental group
style <- list(
  "CTRL MONO" = list(color = "blue", type = "solid"),
  "CTRL TCELL" = list(color = "green", type = "solid"),
  "RA MONO" = list(color = "red", type = "solid"),
  "RA TCELL" = list(color = "black", type = "solid")
) 


## ----fig.cap="The predicted methylation levels in the logit scale for the 4 groups of samples with different disease and cell type status.", echo = TRUE, eval = TRUE----
# creating plot (logit scale)
binomRegMethPredPlot(pred = pred, pred.type = "link.scale", 
                     pred.col = "Logit", group.col = "group", 
                     title = "Logit scale",
                     style = style, verbose = TRUE)

## ----fig.cap="The predicted methylation levels in the proportion scale for the 4 groups of samples with different disease and cell type status.", echo = TRUE, eval = TRUE----
# creating plot (proportion)
binomRegMethPredPlot(pred = pred, pred.type = "proportion",
                     pred.col = "Prop", group.col = "group",
                     title = "Proportion scale",
                     style = style, verbose = FALSE)


## ----fig.cap="The predicted methylation levels in the logit scale without any experimental design.", eval = TRUE, echo = TRUE----
binomRegMethPredPlot(pred = pred, pred.type = "link.scale", pred.col = "Logit", 
                     group.col = NULL, title = "Logit scale", verbose = FALSE)

## ----fig.cap="The predicted methylation levels in the logit scale for the T-cell samples.", echo = TRUE, eval = TRUE----
# exclusion of the MONO cells (not T_cell)
pred[(pred$RA == 0 & pred$T_cell == 0),]$group <- NA
pred[(pred$RA == 1 & pred$T_cell == 0),]$group <- ""

# creating plot (logit scale)
binomRegMethPredPlot(pred = pred, pred.type = "link.scale", 
                     pred.col = "Logit", group.col = "group", 
                     title = "Logit scale",
                     style = style, verbose = FALSE)


## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

