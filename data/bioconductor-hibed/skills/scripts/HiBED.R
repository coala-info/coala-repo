# Code example from 'HiBED' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(cache = FALSE, warning = FALSE, message = FALSE, 
                        cache.lazy = FALSE,collapse = TRUE, comment = "#>"
)
library(HiBED)

## ----eval=TRUE----------------------------------------------------------------
library(HiBED)

## ----eval=TRUE----------------------------------------------------------------
data("HiBED_Libraries")

## ----eval=TRUE----------------------------------------------------------------

# Step 1 load and process example
library(FlowSorted.Blood.EPIC)
library(FlowSorted.DLPFC.450k)
library(minfi)
Mset<-preprocessRaw(FlowSorted.DLPFC.450k)
             
Examples_Betas<-getBeta(Mset)


# Step 2: use the HiBED_deconvolution function in combinatation with the
# reference libraries for brain cell deconvolution.


 HiBED_result<-HiBED_deconvolution(Examples_Betas, h=2)
                                
 head(HiBED_result)



## -----------------------------------------------------------------------------
sessionInfo()

