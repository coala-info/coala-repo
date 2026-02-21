# Code example from 'magrene' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    fig.align = 'center',
    crop = NULL ## Related to https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html
)

## ----intro_motifs, echo = FALSE, fig.cap = "Network motifs and functions to identify them. Shaded boxes indicate paralogs. Regulators and targets are indicated in purple and green, respectively. Arrows indicate directed regulatory interactions, while dashed lines indicate protein-protein interaction."----
knitr::include_graphics("motifs_vignette.png")

## ----"install", eval = FALSE--------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#       install.packages("BiocManager")
#   }
# 
# BiocManager::install("magrene")

## ----load---------------------------------------------------------------------
library(magrene)
set.seed(123) # for reproducibility

## ----data---------------------------------------------------------------------
data(gma_grn)
head(gma_grn)

data(gma_ppi)
head(gma_ppi)

data(gma_paralogs)
head(gma_paralogs)

## ----filtering----------------------------------------------------------------
# Include only WGD-derived paralogs
paralogs <- gma_paralogs[gma_paralogs$type == "WGD", 1:2]

# Keep only the top 30k edges of the GRN, remove "Weight" variable
grn <- gma_grn[1:30000, 1:2]

## ----ppi_v--------------------------------------------------------------------
# Find PPI V motifs
ppi_v <- find_ppi_v(gma_ppi, paralogs)
head(ppi_v)

## ----V------------------------------------------------------------------------
# Find V motifs
v <- find_v(grn, paralogs)
head(v)

## ----lambda-------------------------------------------------------------------
lambda <- find_lambda(grn, paralogs)
head(lambda)

## ----delta--------------------------------------------------------------------
# Find delta motifs from lambda motifs
delta <- find_delta(edgelist_ppi = gma_ppi, lambda_vec = lambda)
head(delta)

## ----bifan--------------------------------------------------------------------
# Find bifans from lambda motifs
bifan <- find_bifan(paralogs = paralogs, lambda_vec = lambda)
head(bifan)

## ----count--------------------------------------------------------------------
count_df <- data.frame(
    Motif = c("PPI V", "V", "Lambda", "Delta", "Bifan"),
    Count = c(
        length(ppi_v), length(v), length(lambda), length(delta), length(bifan)
    )
)

count_df

## ----generate_nulls-----------------------------------------------------------
generate_nulls(grn, paralogs, gma_ppi, n = 5)

## ----calculate_Z--------------------------------------------------------------
# Load null distros
data(nulls)
head(nulls)

# Create list of observed frequencies
observed <- list(
    lambda = length(lambda), 
    bifan = length(bifan), 
    V = length(v),
    PPI_V = length(ppi_v),
    delta = length(delta)
)
calculate_Z(observed, nulls)

## ----similarity---------------------------------------------------------------
sim <- sd_similarity(gma_ppi, paralogs)
head(sim)

summary(sim$sorensen_dice)

## ----sessioninfo--------------------------------------------------------------
sessioninfo::session_info()

