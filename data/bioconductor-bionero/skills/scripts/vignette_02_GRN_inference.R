# Code example from 'vignette_02_GRN_inference' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  message = TRUE,
  warning = FALSE,
  cache = FALSE,
  fig.align = 'center',
  fig.width = 5,
  fig.height = 4,
  crop = NULL
)

## ----installation, eval=FALSE-------------------------------------------------
# if(!requireNamespace('BiocManager', quietly = TRUE))
#   install.packages('BiocManager')
# 
# BiocManager::install("BioNERO")

## ----load_package-------------------------------------------------------------
# Load package after installation
library(BioNERO)
set.seed(123) # for reproducibility

## -----------------------------------------------------------------------------
# Load example data set
data(zma.se)

# Preprocess the expression data
final_exp <- exp_preprocess(
    zma.se, 
    min_exp = 10, 
    variance_filter = TRUE, 
    n = 2000
)

## ----load_tfs-----------------------------------------------------------------
data(zma.tfs)
head(zma.tfs)

## ----exp2grn, fig.small=TRUE--------------------------------------------------
# Using 10 trees for demonstration purposes. Use the default: 1000
grn <- exp2grn(
    exp = final_exp, 
    regulators = zma.tfs$Gene, 
    nTrees = 10
)
head(grn)

## ----genie3-------------------------------------------------------------------
# Using 10 trees for demonstration purposes. Use the default: 1000
genie3 <- grn_infer(
    final_exp, 
    method = "genie3", 
    regulators = zma.tfs$Gene, 
    nTrees = 10)
head(genie3)
dim(genie3)

## ----aracne-------------------------------------------------------------------
aracne <- grn_infer(final_exp, method = "aracne", regulators = zma.tfs$Gene)
head(aracne)
dim(aracne)

## ----clr----------------------------------------------------------------------
clr <- grn_infer(final_exp, method = "clr", regulators = zma.tfs$Gene)
head(clr)
dim(clr)

## ----grn_combined-------------------------------------------------------------
grn_list <- grn_combined(final_exp, regulators = zma.tfs$Gene, nTrees = 10)
head(grn_list$genie3)
head(grn_list$aracne)
head(grn_list$clr)

## ----get_hubs-----------------------------------------------------------------
hubs <- get_hubs_grn(grn)
hubs

## ----plot_static, fig.height=4, fig.width=4-----------------------------------
plot_grn(grn)

## ----plot_interactive---------------------------------------------------------
plot_grn(grn, interactive = TRUE, dim_interactive = c(500,500))

## -----------------------------------------------------------------------------
sessionInfo()

