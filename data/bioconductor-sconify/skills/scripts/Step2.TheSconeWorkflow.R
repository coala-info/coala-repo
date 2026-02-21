# Code example from 'Step2.TheSconeWorkflow' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, 
                      results = "markup", 
                      message = FALSE, 
                      warning = FALSE)

## -----------------------------------------------------------------------------
library(Sconify)
# Markers from the user-generated excel file
marker.file <- system.file('extdata', 'markers.csv', package = "Sconify")
markers <- ParseMarkers(marker.file)

# How to convert your excel sheet into vector of static and functional markers
markers
# Get the particular markers to be used as knn and knn statistics input
input.markers <- markers[[1]]
funct.markers <- markers[[2]]

# Selection of the k. See "Finding Ideal K" vignette
k <- 30

# The built-in scone functions
wand.nn <- Fnn(cell.df = wand.combined, input.markers = input.markers, k = k)
# Cell identity is in rows, k-nearest neighbors are columns
# List of 2 includes the cell identity of each nn, 
#   and the euclidean distance between
#   itself and the cell of interest

# Indices
str(wand.nn[[1]])
wand.nn[[1]][1:20, 1:10]

# Distance
str(wand.nn[[2]])
wand.nn[[2]][1:20, 1:10]

## -----------------------------------------------------------------------------
wand.scone <- SconeValues(nn.matrix = wand.nn, 
                      cell.data = wand.combined, 
                      scone.markers = funct.markers, 
                      unstim = "basal")

wand.scone

## -----------------------------------------------------------------------------
# Constructs KNN list, computes KNN density estimation
wand.knn.list <- MakeKnnList(cell.data = wand.combined, nn.matrix = wand.nn)
wand.knn.list[[8]]

# Finds the KNN density estimation for each cell, ordered by column, in the 
# original data matrix
wand.knn.density <- GetKnnDe(nn.matrix = wand.nn)
str(wand.knn.density)

