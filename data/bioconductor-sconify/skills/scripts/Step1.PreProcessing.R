# Code example from 'Step1.PreProcessing' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, 
                      results = "markup", 
                      message = FALSE, 
                      warning = FALSE)

## -----------------------------------------------------------------------------
library(Sconify)
# Example fcs file
basal <- system.file('extdata',
    'Bendall_et_al_Cell_Sample_C_basal.fcs',
     package = "Sconify")

# Run this, and check your directory for "markers.csv"
markers <- GetMarkerNames(basal)
markers

## ----eval = FALSE-------------------------------------------------------------
# # Turn this into two columns, one for surface markers, and one for phosphos
# # Label the two columns accoridngly. Save to csv. You'll read this modified
# # file in the ProcessMultipleFiles() function.
# write.csv(markers, "markers.csv", row.names = FALSE)

## ----out.width = "200px", eval = TRUE-----------------------------------------
knitr::include_graphics("original.markers.csv.example.png")


## ----out.width = "200px"------------------------------------------------------
knitr::include_graphics("modified.markers.csv.example.png")


## -----------------------------------------------------------------------------

# FCS file provided in the package
basal <- system.file('extdata',
    'Bendall_et_al_Cell_Sample_C_basal.fcs',
    package = "Sconify")

# Example of data with no transformation
basal.raw <- FcsToTibble(basal, transform = "none")
basal.raw

# Asinh transformation with a scale argument of 5
basal.asinh <- FcsToTibble(basal, transform = "asinh")
basal.asinh


## -----------------------------------------------------------------------------
# The FCS files (THEY NEED TO BE IN THE "....._condidtion.fcs" format")
basal <- system.file('extdata',
    'Bendall_et_al_Cell_Sample_C_basal.fcs',
     package = "Sconify")
il7 <- system.file('extdata',
    'Bendall_et_al_Cell_Sample_C_IL7.fcs',
    package = "Sconify")

# The markers (after they were modified by hand as instructed above)
markers <- system.file('extdata',
    'markers.csv',
    package = "Sconify")
markers <- ParseMarkers(markers)
surface <- markers[[1]]
surface

## -----------------------------------------------------------------------------
# Combining these. Note that default is sub-sampling to 10,000 cells.
# Here, we subsample to 1000 cells to minimize processing time for the vignettes.
# not normalizing, and not scaling.
wand.combined <- ProcessMultipleFiles(files = c(basal, il7), 
                                      input = surface, 
                                      numcells = 1000)
wand.combined
unique(wand.combined$condition)

# Limit your matrix to surface markers, if just using those downstream
wand.combined.input <- wand.combined[,surface]
wand.combined.input

## -----------------------------------------------------------------------------
# We can do this on a single file as well. 
wand.basal <- ProcessMultipleFiles(files = basal, 
                                   numcells = 1000, 
                                   scale = TRUE, 
                                   input = surface)
wand.basal
unique(wand.basal$condition)


## -----------------------------------------------------------------------------
# Using the aforementioned basal fcs file
markers <- system.file('extdata',
    'markers.csv',
    package = "Sconify")

# The markers
markers <- read.csv(markers, stringsAsFactors = FALSE)
surface <- markers$surface

# The function
split.data <- SplitFile(file = basal, 
                        input.markers = surface, 
                        numcells = 1000)
split.data
unique(split.data$condition)

