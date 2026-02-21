# Code example from 'rGenomeTracks' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
# loading the rGenomeTracks
library(rGenomeTracks)
# loading example data
#library(rGenomeTracksData)

## ----eval=FALSE---------------------------------------------------------------
# install_pyGenomeTracks()

## ----eval=FALSE---------------------------------------------------------------
# # Download h5 example
# ah <- AnnotationHub()
# query(ah, "rGenomeTracksData")
# h5_dir <-  ah[["AH95901"]]
# 
#  # Create HiC track from HiC matrix
#  h5 <- track_hic_matrix(
#    file = h5_dir, depth = 250000, min_value = 5, max_value = 200,
#    transform = "log1p", show_masked_bins = FALSE
#  )
# 

## -----------------------------------------------------------------------------
 # Load other examples
 tads_dir <- system.file("extdata", "tad_classification.bed", package = "rGenomeTracks")
 arcs_dir <- system.file("extdata", "links2.links", package = "rGenomeTracks")
 bw_dir <- system.file("extdata", "bigwig2_X_2.5e6_3.5e6.bw", package = "rGenomeTracks")
 
 # Create TADS track
 tads <- track_domains(
   file = tads_dir, border_color = "black",
   color = "none", height = 5,
   line_width = 5,
   show_data_range = FALSE,
   overlay_previous = "share-y"
 )

 # Create arcs track
 arcs <- track_links(
   file = arcs_dir, links_type = "triangles",
   line_style = "dashed",
   overlay_previous = "share-y",
   color = "darkred",
   line_width = 3,
   show_data_range = FALSE
 )

 # Create bigwig track
 bw <- track_bigwig(
   file = bw_dir, color = "red",
   max_value = 50,
   min_value = 0,
   height = 4,
   overlay_previous = "no",
   show_data_range = FALSE
 )


## -----------------------------------------------------------------------------
 # Create one object from HiC, arcs and bigwid
 tracks <- tads + arcs + bw

## ----eval=FALSE---------------------------------------------------------------
#  # Plot the tracks
# ## Note to verify installing miniconda if not installed.
# 
#  layout(matrix(c(1,1,2,3,4,4), nrow = 3, ncol = 2, byrow = TRUE))
#  plot_gtracks(tracks, chr = "X", start = 25 * 10^5, end = 31 * 10^5)
# 
# # Plot HiC, TADS and bigwig tracks
#  plot_gtracks(h5 + tads + bw, chr = "X", start = 25 * 10^5, end = 31 * 10^5)

## ----echo=FALSE---------------------------------------------------------------
plot(imager::load.image(system.file("extdata", "images/example1.png", package = "rGenomeTracks")), axes = FALSE)
plot(imager::load.image(system.file("extdata", "images/example2.png", package = "rGenomeTracks")), axes = FALSE)

## -----------------------------------------------------------------------------
dirs <- list.files(system.file("extdata", package = "rGenomeTracks"), full.names = TRUE)

# filter only bed files (without bedgraphs or narrowpeaks)
bed_dirs <- grep(
  dirs,  pattern = ".bed(?!graph)", perl = TRUE, value = TRUE)

bed_list <- lapply(bed_dirs, track_bed)

bed_tracks <- Reduce("+", bed_list)

## -----------------------------------------------------------------------------
sessionInfo()

