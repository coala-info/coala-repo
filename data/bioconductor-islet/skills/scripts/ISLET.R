# Code example from 'ISLET' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------------
htmltools::img(src = knitr::image_uri("islet_hex_2.png"), 
               alt = 'logo', 
               style = 'position:absolute; top:0; left:0; padding:10px; height:280px')

## ----eval = FALSE, message = FALSE--------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("ISLET")

## ----eval = TRUE, message = FALSE---------------------------------------------
library(ISLET)
data(GE600)
ls()
GE600_se

## ----eval = TRUE, message = FALSE---------------------------------------------
assays(GE600_se)$counts[1:5, 1:6]

## ----eval = TRUE, message = FALSE---------------------------------------------
colData(GE600_se)

## ----eval = TRUE, message = FALSE---------------------------------------------
study123input <- dataPrep(dat_se=GE600_se)

## ----eval = TRUE, message = FALSE---------------------------------------------
study123input

## ----eval = TRUE, message = FALSE---------------------------------------------
#Use ISLET for deconvolution
res.sol <- isletSolve(input=study123input)

## ----eval = TRUE, message = FALSE---------------------------------------------
#View the deconvolution results
caseVal <- caseEst(res.sol)
ctrlVal <- ctrlEst(res.sol)
length(caseVal) #For cases, a list of 6 cell types' matrices. 
length(ctrlVal) #For controls, a list of 6 cell types' matrices.
caseVal$Bcells[1:5, 1:4] #view the reference panels for B cells, for the first 5 genes and first 4 subjects, in Case group.
ctrlVal$Bcells[1:5, 1:4] #view the reference panels for B cells, for the first 5 genes and first 4 subjects, in Control group.

## ----eval = TRUE, message = FALSE---------------------------------------------
#Test for csDE genes
res.test <- isletTest(input=study123input)

## ----eval = TRUE, message = FALSE---------------------------------------------
#View the test p-values
head(res.test)

## ----eval = TRUE, message = FALSE---------------------------------------------
#(1) Example dataset for 'slope' test
data(GE600age)
ls()

## ----eval = TRUE, message = FALSE---------------------------------------------
assays(GE600age_se)$counts[1:5, 1:6]

## ----eval = TRUE, message = FALSE---------------------------------------------
colData(GE600age_se)

## ----eval = TRUE--------------------------------------------------------------
#(2) Data preparation
study456input <- dataPrepSlope(dat_se=GE600age_se)

## ----eval = TRUE--------------------------------------------------------------
#(3) Test for slope effect(i.e. age) difference in csDE testing
age.test <- isletTest(input=study456input)

## ----eval = TRUE, message = FALSE---------------------------------------------
#View the test p-values
head(age.test)

## ----eval = TRUE, message = FALSE---------------------------------------------
dat123 <- implyDataPrep(sim_se=GE600_se)

## ----eval = TRUE, message = FALSE---------------------------------------------
dat123

## ----eval = TRUE, message = FALSE---------------------------------------------
#Use imply for deconvolution
result <- imply(dat123)

## ----eval = TRUE, message = FALSE---------------------------------------------
#View the subject-specific and cell-type-specific reference panels solved 
#by linear mixed-effect models of the first subject
result$p.ref[,,1]

## ----eval = TRUE, message = FALSE---------------------------------------------
#View the improved cell deconvolution results
head(result$imply.prop)
tail(result$imply.prop)

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

