# Code example from 'magpie' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------------
htmltools::img(
    src = knitr::image_uri("magpie_hex.png"),
    alt = "logo",
    style = "position:absolute; top:0; left:0; padding:10px; height:280px"
)

## ----eval = FALSE, warning=FALSE, message=FALSE-------------------------------
# install.packages("devtools") # if you have not installed "devtools" package
# library(devtools)
# install_github("https://github.com/dxd429/magpie",
#     build_vignettes = TRUE
# )

## ----eval = FALSE, warning=FALSE, message=FALSE-------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# BiocManager::install("magpie")

## ----eval=FALSE,warning=FALSE,message=FALSE-----------------------------------
# library(magpie)
# vignette("magpie")

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
library(magpie)
power.test <- quickPower(dataset = "GSE46705") # Options are 'GSE46705', 'GSE55575', and 'GSE94613'.

## ----eval=FALSE, message=FALSE, warning=FALSE---------------------------------
# ### write out .xlsx
# writeToxlsx(power.test, file = "test_TRESS.xlsx")
# 
# ### write out stratified results
# writeToxlsx_strata(power.test, file = "test_strata_TRESS.xlsx")

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
### plot FDR under sequencing depth 1x
plotRes(power.test, depth_factor = 1, value_option = "FDR")

### plot all in a panel under sequencing depth 1x
plotAll(power.test, depth_factor = 1)

### plot a FDR strata result
plotStrata(power.test, value_option = "FDR")

### plot all strata results in a panel
plotAll_Strata(power.test)

## ----eval= FALSE--------------------------------------------------------------
# install.packages("devtools") # if you have not installed "devtools" package
# library(devtools)
# install_github("https://github.com/dxd429/magpieData",
#     build_vignettes = TRUE
# )

## ----eval=FALSE, message=FALSE, warning=FALSE---------------------------------
# ## Use "makeTxDbFromUCSC" function to create an annotation file of hg18
# library(GenomicFeatures)
# hg18 <- makeTxDbFromUCSC(genome = "hg18", tablename = "knownGene")
# saveDb(hg18, file = "hg18.sqlite")

## ----eval=FALSE, message=FALSE, warning=FALSE---------------------------------
# library(magpieData)
# library(magpie)
# ### Get the example data
# BAM_path <- getBAMpath()
# ### Call powerEval()
# power.test <- powerEval(
#     Input.file = c("Ctrl1.chr15.input.bam", "Ctrl2.chr15.input.bam", "Case1.chr15.input.bam", "Case2.chr15.input.bam"),
#     IP.file = c("Ctrl1.chr15.ip.bam", "Ctrl2.chr15.ip.bam", "Case1.chr15.ip.bam", "Case2.chr15.ip.bam"),
#     BamDir = BAM_path,
#     annoDir = paste0(BAM_path, "/hg18_chr15.sqlite"),
#     variable = rep(c("Ctrl", "Trt"), each = 2),
#     bam_factor = 0.03,
#     nsim = 10,
#     N.reps = c(2, 3, 5, 7),
#     depth_factor = c(1, 2),
#     thres = c(0.01, 0.05, 0.1),
#     Test_method = "TRESS" ## TRESS or exomePeak2
# )

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
library(magpie)
power.test <- quickPower(dataset = "GSE46705")

## ----eval=FALSE, message=FALSE, warning=FALSE---------------------------------
# ### write out .xlsx
# writeToxlsx(power.test, file = "test_TRESS.xlsx")
# 
# ### write out stratified results
# writeToxlsx_strata(power.test, file = "test_strata_TRESS.xlsx")

## ----echo=FALSE---------------------------------------------------------------
tb1 <- data.frame(
    FDR = rep("", 4),
    N_rep = c(2, 3, 5, 7),
    s0.01 = c(0.36, 0.14, 0.06, 0.04),
    s0.05 = c(0.48, 0.27, 0.13, 0.11),
    s0.1 = c(0.57, 0.38, 0.21, 0.17)
)
names(tb1) <- c("FDR", "N.rep", "0.01", "0.05", "0.1")
kableExtra::kable_styling(kableExtra::kable(tb1, align = "l"), latex_options = "HOLD_position")

## ----echo=FALSE---------------------------------------------------------------
tb2 <- data.frame(
    FDR = rep("", 4),
    N_rep = c(2, 3, 5, 7),
    s1 = c(0.41, 0.23, 0.15, 0.12),
    s2 = c(0.46, 0.30, 0.16, 0.14),
    s3 = c(0.47, 0.27, 0.11, 0.08),
    s4 = c(0.58, 0.28, 0.12, 0.11)
)
names(tb2) <- c("FDR", "N.rep", "(0, 27.68]", "(27.68, 54.3]", "(54.3, 92.64]", "(92.64, Inf]")
kableExtra::kable_styling(knitr::kable(tb2, align = "l"), latex_options = "HOLD_position")

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------

### plot FDR under sequencing depth 1x
plotRes(power.test, depth_factor = 1, value_option = "FDR")

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
### plot all in a panel under sequencing depth 1x
plotAll(power.test, depth_factor = 1)

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
### plot a FDR strata result
plotStrata(power.test, value_option = "FDR")

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
### plot all strata results in a panel
plotAll_Strata(power.test)

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

