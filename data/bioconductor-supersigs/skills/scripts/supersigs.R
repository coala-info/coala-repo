# Code example from 'supersigs' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  warning = FALSE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(supersigs)

## -----------------------------------------------------------------------------
# Load packages for make_matrix function
suppressPackageStartupMessages({
  library(VariantAnnotation)
})

fl <- system.file("extdata", "chr22.vcf.gz", package="VariantAnnotation")
vcf <- VariantAnnotation::readVcf(fl, "hg19") 
# Subset to first sample
vcf <- vcf[, 1]
# Subset to row positions with homozygous or heterozygous alt
positions <- geno(vcf)$GT != "0|0" 
vcf <- vcf[positions[, 1],]
colData(vcf)$age <- 50    # Add patient age to colData
dt <- process_vcf(vcf)
head(dt)

## -----------------------------------------------------------------------------
head(example_dt)

## -----------------------------------------------------------------------------
# Load packages for make_matrix function
suppressPackageStartupMessages({
  library(BSgenome.Hsapiens.UCSC.hg19)
})

## -----------------------------------------------------------------------------
input_dt <- make_matrix(example_dt)
head(input_dt)

## -----------------------------------------------------------------------------
suppressPackageStartupMessages({
  library(dplyr)
})

# Add IndVar column
input_dt <- input_dt %>%
  mutate(IndVar = c(1, 1, 1, 0, 0)) %>%
  relocate(IndVar)

head(input_dt)

## -----------------------------------------------------------------------------
set.seed(1)
supersig <- get_signature(data = input_dt, factor = "Smoking")
supersig

## -----------------------------------------------------------------------------
features <- simplify_signature(object = supersig, iupac = FALSE)
features_iupac <- simplify_signature(object = supersig, iupac = TRUE)

## -----------------------------------------------------------------------------
library(ggplot2)
data.frame(features = names(features_iupac),
           differences = features_iupac) %>%
  ggplot(aes(x = features, y = differences)) +
  geom_col() +
  theme_minimal()

## -----------------------------------------------------------------------------
newdata = predict_signature(supersig, newdata = input_dt, factor = "Smoking")

newdata %>%
  select(X1, score)

## -----------------------------------------------------------------------------
names(supersig_ls)

## -----------------------------------------------------------------------------
# Use pre-trained signature
newdata = predict_signature(supersig_ls[["SMOKING (LUAD)"]], 
                            newdata = input_dt, factor = "Smoking")
newdata %>%
  select(IndVar, X1, X2, X3, score)

## -----------------------------------------------------------------------------
adjusted_dt <- partial_signature(data = input_dt, object = supersig)
head(adjusted_dt)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

## ----eval = F, include=F------------------------------------------------------
# build_vignettes()

