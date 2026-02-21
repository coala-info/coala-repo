# Code example from 'GNOSIS' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# 
# BiocManager::install("GNOSIS")

## ----include=TRUE, results="hide", message=FALSE, warning=FALSE---------------
library(GNOSIS)

## ----eval=FALSE---------------------------------------------------------------
# GNOSIS()

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("figures/GNOSIS_Pic.png")

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("figures/GNOSIS_File_Upload.png")

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("figures/GNOSIS_Select_Study.png")

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("figures/GNOSIS_Preview_Clinical.png")

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("figures/GNOSIS_Preview_CNA.png")

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("figures/GNOSIS_Preview_MAF.png")

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("figures/GNOSIS_Column_Selection.png")

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("figures/GNOSIS_Reformatting.png")

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("figures/GNOSIS_Filtering.png")

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("figures/GNOSIS_Survival_Recoding.png")

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("figures/GNOSIS_CNA_Calc.png")

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("figures/GNOSIS_Boxplot.png")

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("figures/GNOSIS_KM_Curves_Clinical.png")

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("figures/GNOSIS_KM_Curves_CNA.png")

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("figures/GNOSIS_Association.png")

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("figures/GNOSIS_Univariate_Cox.png")

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("figures/GNOSIS_Multivariable_Cox.png")

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("figures/GNOSIS_Cox_Assumption.png")

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("figures/GNOSIS_Adjusted_KM_Curves.png")

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("figures/GNOSIS_Rpart_Tree.png")

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("figures/GNOSIS_MAF_Summary_Text.png")

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("figures/GNOSIS_MAF_Summary_Plot.png")

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("figures/GNOSIS_MAF_Lollipop_Plot.png")

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("figures/GNOSIS_Input_Log.png")

## -----------------------------------------------------------------------------
sessionInfo()

