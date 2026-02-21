# Code example from 'Summix' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.path = "man/figures/README-",
  out.width = "100%"
)

## -----------------------------------------------------------------------------
library(Summix)
print(head(ancestryData))

## -----------------------------------------------------------------------------
summix(data = ancestryData,
    reference=c("reference_AF_afr",
        "reference_AF_eas",
        "reference_AF_eur",
        "reference_AF_iam",
        "reference_AF_sas"),
    observed="gnomad_AF_afr")

## -----------------------------------------------------------------------------

adjusted_data<-adjAF(data = ancestryData,
     reference = c("reference_AF_afr", "reference_AF_eur", "reference_AF_iam"),
     observed = "gnomad_AF_afr",
     pi.target = c(1, 0, 0),
     pi.observed = c(0.812142, 0.169953, 0.017905),
     adj_method = 'average',
     N_reference = c(704,741, 47),
     N_observed = 20744,
     filter = TRUE)


## -----------------------------------------------------------------------------
print(adjusted_data$adjusted.AF[1:5,])



## ----summix example-----------------------------------------------------------
library(Summix)

# load the data
data("ancestryData")

# Estimate 5 reference ancestry proportion values for the gnomAD African/African American group
# using a starting guess of .2 for each ancestry proportion.
summix(data = ancestryData,
    reference=c("reference_AF_afr",
        "reference_AF_eas",
        "reference_AF_eur",
        "reference_AF_iam",
        "reference_AF_sas"),
    observed="gnomad_AF_afr",
    pi.start = c(.2, .2, .2, .2, .2),
    goodness.of.fit=TRUE)



## ----adjAF example------------------------------------------------------------
library(Summix)

# load the data
data("ancestryData")


adjusted_data<-adjAF(data = ancestryData,
     reference = c("reference_AF_afr", "reference_AF_eur"),
     observed = "gnomad_AF_afr",
     pi.target = c(1, 0),
     pi.observed = c(.85, .15),
     adj_method = 'average',
     N_reference = c(704,741),
     N_observed = 20744,
     filter = TRUE)
print(adjusted_data$adjusted.AF[1:5,])



## ----summix_local example-----------------------------------------------------
library(Summix)

# load the data
# data("ancestryData")
# 
# results <- summix_local(data = ancestryData,
#                         reference = c("reference_AF_afr",
#                                       "reference_AF_eas",
#                                       "reference_AF_eur",
#                                       "reference_AF_iam",
#                                       "reference_AF_sas"),
#                         NSimRef = c(704,787,741,47,545),
#                         observed="gnomad_AF_afr",
#                         goodness.of.fit = T,
#                         type = "variants",
#                         algorithm = "fastcatch",
#                         minVariants = 150,
#                         maxVariants = 250,
#                         maxStepSize = 1000,
#                         diffThreshold = .02,
#                         override_fit = F,
#                         override_removeSmallAnc = TRUE,
#                         selection_scan = F,
#                         position_col = "POS")
# 
# print(results$results)


