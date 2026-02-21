# Code example from 'vignette' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  crop = NULL, ## Related to https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html,
  fig.width = 4, fig.height = 2.5, out.width = "75%", dpi = 70
)

## ----vignetteSetup, echo=FALSE, message=FALSE, warning = FALSE----------------
## Track time spent on making the vignette
startTime <- Sys.time()
## Bib setup
library("RefManageR")
## Write bibliography information
bib <- c(
  R = citation(),
  BiocStyle = citation("BiocStyle")[1],
  knitr = citation("knitr")[1],
  RefManageR = citation("RefManageR")[1],
  rmarkdown = citation("rmarkdown")[1],
  sessioninfo = citation("sessioninfo")[1],
  testthat = citation("testthat")[1],
  spaSim = citation("spaSim")[1]
)

## ----install, eval = FALSE----------------------------------------------------
# ## Check that you have a valid Bioconductor installation
# BiocManager::valid()
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#       install.packages("BiocManager")
#   }
# 
# BiocManager::install("spaSim")
# 
# # install from GitHub the development version
# install.packages("devtools")
# devtools::install_github("TrigosTeam/spaSim")

## ----"citation"---------------------------------------------------------------
## Citation info
citation("spaSim")

## -----------------------------------------------------------------------------
library(spaSim)

## -----------------------------------------------------------------------------
set.seed(610)
bg <- simulate_background_cells(n_cells = 5000,
                                width = 2000,
                                height = 2000,
                                method = "Hardcore",
                                min_d = 10,
                                oversampling_rate = 1.6,
                                Cell.Type = "Others")
head(bg)
# use dim(bg)[1] to check if the same number of cells are simulated. 
# if not, increase `oversampling_rate`.
dim(bg)[1]

## ----eval=FALSE---------------------------------------------------------------
# set.seed(610)
# bg_normal <- simulate_background_cells(n_cells = 5000,
#                                       width = 2000,
#                                       height = 2000,
#                                       method = "Even",
#                                       min_d = NULL,
#                                       jitter = 0.3,
#                                       Cell.Type = "Others")
# head(bg_normal)
# dim(bg_normal)[1]

## -----------------------------------------------------------------------------
mix_bg <- simulate_mixing(bg_sample = bg,
                          idents = c("Tumour", "Immune", "Others"),
                          props = c(0.2, 0.3, 0.5), 
                          plot_image = TRUE,
                          plot_colours = c("red","darkgreen","lightgray"))

## -----------------------------------------------------------------------------
cluster_properties <- list(
  C1 =list(name_of_cluster_cell = "Tumour", size = 500, shape = "Oval", 
           centre_loc = data.frame(x = 600, y = 600),infiltration_types = c("Immune1", "Others"), 
           infiltration_proportions = c(0.1, 0.05)), 
  C2 = list(name_of_cluster_cell = "Immune1", size = 600,  shape = "Irregular", 
            centre_loc = data.frame(x = 1500, y = 500), infiltration_types = c("Immune", "Others"),
            infiltration_proportions = c(0.1, 0.05)))
# can use any defined image as background image, here we use mix_bg defined in the previous section
clusters <- simulate_clusters(bg_sample = mix_bg,
                              n_clusters = 2,
                              bg_type = "Others",
                              cluster_properties = cluster_properties,
                              plot_image = TRUE,
                              plot_categories = c("Tumour" , "Immune", "Immune1", "Others"),
                              plot_colours = c("red", "darkgreen", "darkblue", "lightgray"))

## -----------------------------------------------------------------------------
immune_ring_properties <- list(
  I1 = list(name_of_cluster_cell = "Tumour", size = 500, 
            shape = "Circle", centre_loc = data.frame(x = 930, y = 1000), 
            infiltration_types = c("Immune1", "Immune2", "Others"), 
            infiltration_proportions = c(0.15, 0.05, 0.05),
            name_of_ring_cell = "Immune1", immune_ring_width = 150,
            immune_ring_infiltration_types = c("Immune2", "Others"), 
            immune_ring_infiltration_proportions = c(0.1, 0.15)))
rings <- simulate_immune_rings(
  bg_sample = bg,
  bg_type = "Others",
  n_ir = 1,
  ir_properties = immune_ring_properties,
  plot_image = TRUE,
  plot_categories = c("Tumour", "Immune1", "Immune2", "Others"),
  plot_colours = c("red", "darkgreen", "darkblue", "lightgray"))

## -----------------------------------------------------------------------------
immune_ring_properties <- list( 
  I1 = list(name_of_cluster_cell = "Tumour", size = 500, 
            shape = "Circle", centre_loc = data.frame(x = 930, y = 1000), 
            infiltration_types = c("Immune1", "Immune2", "Others"), 
            infiltration_proportions = c(0.15, 0.05, 0.05),
            name_of_ring_cell = "Immune1", immune_ring_width = 150,
            immune_ring_infiltration_types = c("Immune2", "Others"), 
            immune_ring_infiltration_proportions = c(0.1, 0.15)), 
  I2 = list(name_of_cluster_cell = "Tumour", size = 400, shape = "Oval",
           centre_loc = data.frame(x = 1330, y = 1100), 
           infiltration_types = c("Immune1",  "Immune2", "Others"), 
           infiltration_proportions = c(0.15, 0.05, 0.05),
           name_of_ring_cell = "Immune1", immune_ring_width = 150,
           immune_ring_infiltration_types = c("Immune2","Others"), 
           immune_ring_infiltration_proportions = c(0.1, 0.15)))

rings <- simulate_immune_rings(bg_sample = bg,
                              bg_type = "Others",
                              n_ir = 2,
                              ir_properties = immune_ring_properties,
                              plot_image = TRUE,
                              plot_categories = c("Tumour", "Immune1", "Immune2", "Others"),
                              plot_colours = c("red", "darkgreen", "darkblue", "lightgray"))

## -----------------------------------------------------------------------------
double_ring_properties <- list(
 I1 = list(name_of_cluster_cell = "Tumour", size = 300, shape = "Circle", 
           centre_loc = data.frame(x = 1000, y = 1000), 
           infiltration_types = c("Immune1", "Immune2", "Others"), 
           infiltration_proportions = c(0.15, 0.05, 0.05), 
           name_of_ring_cell = "Immune1", immune_ring_width = 80,
           immune_ring_infiltration_types = c("Tumour", "Others"), 
           immune_ring_infiltration_proportions = c(0.1, 0.15), 
           name_of_double_ring_cell = "Immune2", double_ring_width = 100,
           double_ring_infiltration_types = c("Others"), 
           double_ring_infiltration_proportions = c( 0.15)),      
 I2 = list(name_of_cluster_cell = "Tumour", size = 300, shape = "Oval",
           centre_loc = data.frame(x = 1200, y = 1200), 
           infiltration_types = c("Immune1", "Immune2", "Others"), 
           infiltration_proportions = c(0.15, 0.05, 0.05),
           name_of_ring_cell = "Immune1", immune_ring_width = 80,
           immune_ring_infiltration_types = c("Tumour","Others"), 
           immune_ring_infiltration_proportions = c(0.1,0.15), 
           name_of_double_ring_cell = "Immune2", double_ring_width = 100,
           double_ring_infiltration_types = c("Others"), 
           double_ring_infiltration_proportions = c(0.15)))
double_rings <- simulate_double_rings(bg_sample = bg1,
                                     bg_type = "Others",
                                     n_dr = 2,
                                     dr_properties = double_ring_properties,
                                     plot_image = TRUE,
                                     plot_categories = c("Tumour", "Immune1", "Immune2", "Others"),
                                     plot_colours = c("red", "darkgreen", "darkblue", "lightgray"))

## -----------------------------------------------------------------------------
properties_of_stripes <- list(
 S1 = list(number_of_stripes = 1, name_of_stripe_cell = "Immune1", 
           width_of_stripe = 40, infiltration_types = c("Others"),
           infiltration_proportions = c(0.08)), 
 S2 = list(number_of_stripes = 5, name_of_stripe_cell = "Immune2", 
           width_of_stripe = 40, infiltration_types = c("Others"), 
           infiltration_proportions = c(0.08)))
vessles <- simulate_stripes(bg_sample = bg1,
                           n_stripe_type = 2,
                           stripe_properties = properties_of_stripes,
                           plot_image = TRUE)

## -----------------------------------------------------------------------------
# First specify the cluster and immune ring properties
## tumour cluster properties
properties_of_clusters <- list(
 C1 = list( name_of_cluster_cell = "Tumour", size = 300, shape = "Oval", 
            centre_loc = data.frame("x" = 500, "y" = 500),
            infiltration_types = c("Immune1", "Others"), 
            infiltration_proportions = c(0.3, 0.05)))
## immune ring properties
immune_ring_properties <- list( 
  I1 = list(name_of_cluster_cell = "Tumour", size = 300, 
            shape = "Circle", centre_loc = data.frame(x = 1030, y = 1100), 
            infiltration_types = c("Immune1", "Immune2", "Others"), 
            infiltration_proportions = c(0.15, 0.05, 0.05),
            name_of_ring_cell = "Immune1", immune_ring_width = 150,
            immune_ring_infiltration_types = c("Others"), 
            immune_ring_infiltration_proportions = c(0.15)), 
  I2 = list(name_of_cluster_cell = "Tumour", size = 200, shape = "Oval",
           centre_loc = data.frame(x = 1430, y = 1400), 
           infiltration_types = c("Immune1",  "Immune2", "Others"), 
           infiltration_proportions = c(0.15, 0.05, 0.05),
           name_of_ring_cell = "Immune1", immune_ring_width = 150,
           immune_ring_infiltration_types = c("Others"), 
           immune_ring_infiltration_proportions = c(0.15)))
# simulation
# no background sample is input, TIS simulates the background cells from scratch
# `n_cells`, `width`, `height`, `min_d` and `oversampling_rate` are parameters for simulating background cells
# `n_clusters`, `properties_of_clusters` are parameters for simulating clusters on top of the background cells
# `plot_image`, `plot_categories`, `plot_colours` are params for plotting
simulated_image <- TIS(bg_sample = NULL,
   n_cells = 5000,
   width = 2000,
   height = 2000,
   bg_method = "Hardcore",
   min_d = 10,
   oversampling_rate = 1.6, 
   n_clusters = 1,
   properties_of_clusters = properties_of_clusters,
   n_immune_rings = 2,
   properties_of_immune_rings = immune_ring_properties,
   plot_image = TRUE,
   plot_categories = c("Tumour", "Immune1", "Immune2", "Others"),
   plot_colours = c("red", "darkgreen", "darkblue", "lightgray"))

## -----------------------------------------------------------------------------
#cell types present in each image
idents <- c("Tumour", "Immune", "Others")
# Each vector corresponds to each cell type in `idents`. 
# Each element in each vector is the proportion of the cell type in each image.
# (4 images, so 4 elements in each vector)
Tumour_prop <- rep(0.1, 4)
Immune_prop <- seq(0, 0.3, 0.1)
Others_prop <- seq(0.9, 0.6, -0.1)
# put the proportion vectors in a list
prop_list <- list(Tumour_prop, Immune_prop, Others_prop)

# simulate 
bg_list <- 
 multiple_background_images(bg_sample = bg, idents = idents, props = prop_list,
                            plot_image = TRUE, plot_colours = c("red", "darkgreen", "lightgray"))

## -----------------------------------------------------------------------------
# if a property is fixed, use a number for that parameter.
# if a property spans a range, use a numeric vector for that parameter, e.g.
range_of_size <- seq(200, 500, 100)
cluster_list <- 
 multiple_images_with_clusters(bg_sample = bg1,
                               cluster_shape = 1,
                               prop_infiltration = 0.1,
                               cluster_size = range_of_size,
                               cluster_loc_x = 0,
                               cluster_loc_y = 0,
                               plot_image = TRUE,
                               plot_categories = c("Tumour", "Immune", "Others"),
                               plot_colours = c("red", "darkgreen", "lightgray"))

## -----------------------------------------------------------------------------
# shape "2" - Tumour cluster with more and more immune infiltration
range_of_infiltration <- c(0.1, 0.3, 0.5)
cluster_list <- 
  multiple_images_with_clusters(bg_sample = bg1,
                                cluster_shape = 2,
                                prop_infiltration = range_of_infiltration,
                                cluster_size = 200,
                                cluster_loc_x = 0,
                                cluster_loc_y = 0,
                                plot_image = TRUE, 
                                plot_categories = c("Tumour" , "Immune", "Others"),
                                plot_colours = c("red","darkgreen", "lightgray"))

## -----------------------------------------------------------------------------
# shape "3" - Immune cluster
cluster_list <- 
  multiple_images_with_clusters(bg_sample = bg1,
                                 cluster_shape = 3,
                                 prop_infiltration = 0.1,
                                 cluster_size = 500,
                                 cluster_loc_x = 0,
                                 cluster_loc_y = 0,
                                 plot_image = TRUE, 
                                 plot_categories = c("Immune", "Others"),
                                 plot_colours = c("darkgreen", "lightgray"))

## -----------------------------------------------------------------------------
# if a property is to be fixed, use a number for that parameter.
# if a property is to span a range, use a numeric vector for that parameter, e.g.
range_ring_width <- seq(50, 120, 30)

# This example uses ring shape 1
par(mfrow=c(2,1))
immune_ring_list <- 
 multiple_images_with_immune_rings(bg_sample = bg,
                                   cluster_size = 200,
                                   ring_shape = 1,
                                   prop_infiltration = 0,
                                   ring_width = range_ring_width,
                                   cluster_loc_x = 0,
                                   cluster_loc_y = 0,
                                   prop_ring_infiltration = 0.1,
                                   plot_image = TRUE,
                                   plot_categories = c("Tumour", "Immune", "Others"),
                                   plot_colours = c("red", "darkgreen", "lightgray"))

## -----------------------------------------------------------------------------
# shape "2" - Immune ring at different locations
cluster_loc_x <- c(-300, 0, 300)
cluster_loc_y <- c(-300, 0, 300)
immune_ring_list <- 
 multiple_images_with_immune_rings(bg_sample = bg,
                                   cluster_size = 200,
                                   ring_shape = 2,
                                   prop_infiltration = 0,
                                   ring_width = 70,
                                   cluster_loc_x = cluster_loc_x,
                                   cluster_loc_y = cluster_loc_y,
                                   prop_ring_infiltration = 0.1,
                                   plot_image = TRUE,
                                   plot_categories = c("Tumour", "Immune", "Others"),
                                   plot_colours = c("red", "darkgreen", "lightgray"))

## -----------------------------------------------------------------------------
# shape "3" - Immune ring has different "Tumour" proportions
prop_ring_infiltration <- c(0.1, 0.2, 0.3)
immune_ring_list <- 
 multiple_images_with_immune_rings(bg_sample = bg,
                                   cluster_size = 200,
                                   ring_shape = 2,
                                   prop_infiltration = 0,
                                   ring_width = 70,
                                   cluster_loc_x = 0,
                                   cluster_loc_y = 0,
                                   prop_ring_infiltration = prop_ring_infiltration,
                                   plot_image = TRUE,
                                   plot_categories = c("Tumour", "Immune", "Others"),
                                   plot_colours = c("red", "darkgreen", "lightgray"))

## -----------------------------------------------------------------------------
# The following code will not run as SPIAT is still not released yet. You can try out the dev version on Github~
# if (requireNamespace("SPIAT", quietly = TRUE)) {
#   # visualise
#   SPIAT::plot_cell_categories(sce_object = simulated_image, 
#                               categories_of_interest = c("Tumour", "Immune1", "Immune2", "Others"),
#                               colour_vector = c("red", "darkgreen", "darkblue", "lightgray"),
#                               feature_colname = "Cell.Type")
#   # calculate average minimum distance of the cells
#   SPIAT::average_minimum_distance(sce_object = simulated_image)
#   # You can also try other functions :)
# }

## ----createVignette, eval=FALSE-----------------------------------------------
# ## Create the vignette
# library("rmarkdown")
# system.time(render("vignette.Rmd", "BiocStyle::html_document"))
# ## Extract the R code
# library("knitr")
# knit("vignette.Rmd", tangle = TRUE)

## ----reproduce1, echo=FALSE---------------------------------------------------
## Date the vignette was generated
Sys.time()

## ----reproduce2, echo=FALSE---------------------------------------------------
## Processing time in seconds
totalTime <- diff(c(startTime, Sys.time()))
round(totalTime, digits = 3)

## ----reproduce3, echo=FALSE-------------------------------------------------------------------------------------------
## Session info
library("sessioninfo")
options(width = 120)
session_info()


## ----vignetteBiblio, results = "asis", echo = FALSE, warning = FALSE, message = FALSE---------------------------------
## Print bibliography
PrintBibliography(bib, .opts = list(hyperlink = "to.doc", style = "html"))

