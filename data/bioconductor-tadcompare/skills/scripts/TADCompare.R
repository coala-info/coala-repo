# Code example from 'TADCompare' vignette. See references/ for full tutorial.

## ----set-options, echo=FALSE, cache=FALSE, message=FALSE, warning = FALSE-----
options(stringsAsFactors = FALSE, warning = FALSE, message = FALSE)

## ----eval = FALSE-------------------------------------------------------------
# 
# BiocManager::install("TADCompare")
# # Or, for the developmental version
# devtools::install_github("dozmorovlab/TADCompare")

## -----------------------------------------------------------------------------
library(dplyr)
library(SpectralTAD)
library(TADCompare)

## -----------------------------------------------------------------------------
# Get the rao contact matrices built into the package
data("rao_chr22_prim")
data("rao_chr22_rep")
# We see these are n x n matrices
dim(rao_chr22_prim)
dim(rao_chr22_rep)
# And, get a glimpse how the data looks like
rao_chr22_prim[100:105, 100:105]
# Running the algorithm with resolution specified
results = TADCompare(rao_chr22_prim, rao_chr22_rep, resolution = 50000)
# Repeating without specifying resolution
no_res = TADCompare(rao_chr22_prim, rao_chr22_rep)
# We can see below that resolution can be estimated automatically if necessary
identical(results$Diff_Loci, no_res$Diff_Loci)

## -----------------------------------------------------------------------------
head(results$TAD_Frame)

## -----------------------------------------------------------------------------
head(results$Boundary_Scores)

## -----------------------------------------------------------------------------
p <- results$Count_Plot
class(p)
plot(p)

## -----------------------------------------------------------------------------
# Call TADs using SpectralTAD
bed_coords1 = bind_rows(SpectralTAD::SpectralTAD(rao_chr22_prim, chr = "chr22", levels = 3))
bed_coords2 = bind_rows(SpectralTAD(rao_chr22_rep,  chr = "chr22", levels = 3))
# Combining the TAD boundaries for both contact matrices
Combined_Bed = list(bed_coords1, bed_coords2)

# Printing the combined list of TAD boundaries

## -----------------------------------------------------------------------------
# Running TADCompare with pre-specified TADs
TD_Compare = TADCompare(rao_chr22_prim, rao_chr22_rep, resolution = 50000, pre_tads = Combined_Bed)

# Returning the boundaries
head(TD_Compare$TAD_Frame)
# Testing to show that all pre-specified boundaries are returned
table(TD_Compare$TAD_Frame$Boundary %in% bind_rows(Combined_Bed)$end) 

## -----------------------------------------------------------------------------
data("GM12878.40kb.raw.chr2")
data("IMR90.40kb.raw.chr2")
mtx1 <- GM12878.40kb.raw.chr2
mtx2 <- IMR90.40kb.raw.chr2
res <- 40000 # Set resolution
# Globally normalize matrices for better visual comparison (does not affect TAD calling)
mtx1_total <- sum(mtx1)
mtx2_total <- sum(mtx2)
(scaling_factor <- mtx1_total / mtx2_total)
# Rescale matrices depending on which matrix is smaller
if (mtx1_total > mtx2_total) {
  mtx2 <- mtx2 * scaling_factor
} else {
  mtx1 <- mtx1 * (1 / scaling_factor)
}
# Coordinates of interesting regions
start_coord <- 8000000
end_coord   <- 16000000
# Another interesting region
# start_coord <- 40000000
# end_coord   <- 48000000

## ----fig.width=10, fig.height=6-----------------------------------------------
# Running TADCompare as-is
TD_Compare <- TADCompare(mtx1, mtx2, resolution = res)
# Running the plotting algorithm with pre-specified TADs
p <- DiffPlot(tad_diff    = TD_Compare, 
              cont_mat1   = mtx1,
              cont_mat2   = mtx2,
              resolution  = res,
              start_coord = start_coord,
              end_coord   = end_coord,
              show_types  = TRUE, 
              point_size  = 5,
              max_height  = 5,
              rel_heights = c(1, 2),
              palette     = "RdYlBu")
plot(p)

## ----fig.width=10, fig.height=6-----------------------------------------------
# Call TADs using SpectralTAD
bed_coords1 = bind_rows(SpectralTAD(mtx1, chr = "chr2", levels = 3))
bed_coords2 = bind_rows(SpectralTAD::SpectralTAD(mtx2, chr = "chr2", levels = 3))
# Placing the data in a list for the plotting procedure
Combined_Bed = list(bed_coords1, bed_coords2)

# Running TADCompare with pre-specified TADs
TD_Compare <-  TADCompare(mtx1, mtx2, resolution = res, pre_tads = Combined_Bed)
# Running the plotting algorithm with pre-specified TADs
p <- DiffPlot(tad_diff    = TD_Compare, 
              cont_mat1   = mtx1,
              cont_mat2   = mtx2,
              resolution  = res,
              start_coord = start_coord,
              end_coord   = end_coord,
              pre_tad     = Combined_Bed,
              show_types  = FALSE, 
              point_size  = 5,
              max_height  = 10,
              rel_heights = c(1.5, 2),
              palette     = "RdYlBu")
plot(p)

## -----------------------------------------------------------------------------
# Get the list of contact matrices
data("time_mats")
# Checking format
head(time_mats[[1]])
# These are sparse 3-column matrices
# Running MultiCompare
time_var <- TimeCompare(time_mats, resolution = 50000)

## -----------------------------------------------------------------------------
head(time_var$TAD_Bounds)

## -----------------------------------------------------------------------------
head(time_var$All_Bounds)

## -----------------------------------------------------------------------------
time_var$Count_Plot

## -----------------------------------------------------------------------------
# Get the rao contact matrices built into the package
data("time_mats")
# Running MultiCompare
con_tads <- ConsensusTADs(time_mats, resolution = 50000)

## -----------------------------------------------------------------------------
head(con_tads$Consensus)

## -----------------------------------------------------------------------------
head(con_tads$All_Regions)

## -----------------------------------------------------------------------------
sessionInfo()

