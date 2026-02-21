# Code example from 'extend-target' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  message = FALSE,
  warning = FALSE
)

## ----load_libraries-----------------------------------------------------------
# load libraries
library(target)

## ----load data----------------------------------------------------------------
# load data
data("sim_peaks")
data("sim_transcripts")

## ----define_function----------------------------------------------------------
# source the plotting function
source(system.file('extdata', 'plot-profiles.R', package = 'target'))

## ----cooperative_example,fig.align='center',fig.width=7, fig.height=6---------
# simulate and plot cooperative factors
plot_profiles(sim_peaks,
              sim_transcripts,
              n = 5000,
              change = c(3, 3))

## ----competitive_example,fig.align='center',fig.width=7, fig.height=6---------
# simulate and plot competitve factors
plot_profiles(sim_peaks,
              sim_transcripts,
              n = 5000,
              change = c(3, -3))

## ----session_info-------------------------------------------------------------
sessionInfo()

