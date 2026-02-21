# Code example from 'MOFA' vignette. See references/ for full tutorial.

## ---- eval = FALSE---------------------------------------------------------
#  if (!requireNamespace("BiocManager", quietly = TRUE))
#      install.packages("BiocManager")
#  BiocManager::install("MOFA", version = "3.9")

## ---- eval = FALSE---------------------------------------------------------
#  devtools::install_github("bioFAM/MOFA", build_opts = c("--no-resave-data"))

## ---- eval = FALSE---------------------------------------------------------
#  if (!requireNamespace("BiocManager", quietly = TRUE))
#      install.packages("BiocManager")
#  BiocManager::install("MOFAdata", version = "3.9")

## ---- eval = FALSE---------------------------------------------------------
#  devtools::install_github("bioFAM/MOFAdata", build_opts = c("--no-resave-data"))

## ---- eval = FALSE---------------------------------------------------------
#  library(reticulate)
#  
#  # Using a specific python binary
#  use_python("/home/user/python", required = TRUE)
#  
#  # Using a conda enviroment called "r-reticulate"
#  use_condaenv("r-reticulate", required = TRUE)
#  
#  # Using a virtual environment called "r-reticulate"
#  use_virtualenv("r-reticulate", required = TRUE)

## ---- eval=FALSE-----------------------------------------------------------
#  library(MOFA)
#  library(MOFAdata)

## ---- eval = FALSE---------------------------------------------------------
#  vignette("MOFA_example_simulated")

## ---- eval = FALSE---------------------------------------------------------
#  vignette("MOFA_example_CLL")

## ---- eval=FALSE-----------------------------------------------------------
#  vignette("MOFA_example_scMT")

## ---- eval = FALSE---------------------------------------------------------
#  if (!requireNamespace("BiocManager", quietly = TRUE))
#      install.packages("BiocManager")
#  BiocManager::install(c("MultiAssayExperiment", "pcaMethods"))

## ---- eval = FALSE---------------------------------------------------------
#  library(reticulate)
#  use_python("YOUR_PYTHON_PATH", required=TRUE) # fill in YOUR_PYTHON_PATH

## --------------------------------------------------------------------------
sessionInfo()

