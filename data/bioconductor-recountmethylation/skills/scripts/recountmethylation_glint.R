# Code example from 'recountmethylation_glint' vignette. See references/ for full tutorial.

## ----chunk_settings, eval = T, echo = F---------------------------------------
knitr::opts_chunk$set(eval = FALSE, echo = TRUE, warning = FALSE, message = FALSE)

## ----setup, eval = T, echo = F------------------------------------------------
# get the system load paths
dpath <- system.file("extdata", "glint_files", 
                     package = "recountmethylation")  # local path to example data
res1.fname <- "glint_results_tutorialdata.epistructure.pcs.txt" 
res1.fpath <- file.path(dpath, res1.fname)
res1 <- read.table(res1.fpath, sep = "\t")            # read in example dataset #1
res2.fpath <- file.path(dpath, "glint_results_minfidata.epistructure.pcs.txt")
res2 <- read.table(res2.fpath, sep = "\t")            # read in example dataset #2

## -----------------------------------------------------------------------------
# BiocManager::install("basilisk")
# library(basilisk)

## -----------------------------------------------------------------------------
# env.name <- "glint_env"          # name the new virtual environment
# pkg.name <- "recountmethylation" # set env properties
# pkgv <- c("python==2.7",         # python version (v2.7)
#           "numpy==1.15",         # numpy version (v1.15)
#           "pandas==0.22",        # pandas version (v0.22)
#           "scipy==1.2",          # scipy version (v1.2)
#           "scikit-learn==0.19",  # scikit-learn (v0.19)
#           "matplotlib==2.2",     # matplotlib (v2.2)
#           "statsmodels==0.9",    # statsmodels (v0.9)
#           "cvxopt==1.2")         # cvxopt (v1.2)
# glint_env <- BasiliskEnvironment(envname = env.name, pkgname = pkg.name,
#                                  packages = pkgv)
# proc <- basiliskStart(glint_env) # define run process
# on.exit(basiliskStop(proc))      # define exit process

## -----------------------------------------------------------------------------
# library(minfiData)
# ms <- get(data("MsetEx")) # load example MethylSet

## -----------------------------------------------------------------------------
# dpath <- system.file("extdata", "glint_files",
#                      package = "recountmethylation") # get the dir path
# cgv.fpath <- file.path(dpath, "glint_epistructure_explanatory-cpgs.rda")
# glint.cgv <- get(load(cgv.fpath)) # load explanatory probes

## -----------------------------------------------------------------------------
# mf <- ms[rownames(ms) %in% glint.cgv,] # filter ms on explanatory probes
# dim(mf)                                # mf dimensions: [1] 4913    6

## -----------------------------------------------------------------------------
# # get covar -- all vars should be numeric/float
# covar <- as.data.frame(colData(mf)[,c("age", "sex")]) # get sample metadata
# covar[,"sex"] <- ifelse(covar[,"sex"] == "M", 1, 0)   # relabel sex for glint
# # write covariates matrix
# covar.fpath <- file.path("covariates_minfidata.txt")  # specify covariate table path
# # write table colnames, values
# write.table(covar, file = covar.fpath, sep = "\t", row.names = T,
#             col.names = T, append = F, quote = F)     # write covariates table

## -----------------------------------------------------------------------------
# bval.fpath <- file.path("bval_minfidata.txt")     # specify dnam fractions table name
# mbval <- t(apply(as.matrix(getBeta(mf)),1,function(ri){
#   ri[is.na(ri)] <- median(ri,na.rm=T)             # impute na's with row medians
#   return(round(ri, 4))
# })); rownames(mbval) <- rownames(mf)              # assign probe ids to row names
# write.table(mbval, file = bval.fpath, sep = sepsym,
#             row.names = T, col.names = T, append = F,
#             quote = F)                            # write dnam fractions table

## -----------------------------------------------------------------------------
# glint.dpath <- "glint-1.0.4"                         # path to the main glint app dir
# glint.pypath <- file.path(glint.dpath, "glint.py")   # path to the glint .py script
# data.fpath <- file.path("bval_minfidata.txt")        # path to the DNAm data table
# covar.fpath <- file.path("covariates_minfidata.txt") # path to the metadata table
# out.fstr <- file.path("glint_results_minfidata")     # base string for ouput results files
# covarv <- c("age", "sex")                            # vector of valid covariates
# covar.str <- paste0(covarv, collapse = " ")          # format the covariates vector
# cmd.str <- paste0(c("python", glint.pypath,
#                     "--datafile", data.fpath,
#                     "--covarfile", covar.fpath,
#                     "--covar", covar.str,
#                     "--epi", "--out", out.fstr),
#                   collapse = " ")                    # get the final command line call

## -----------------------------------------------------------------------------
# basiliskRun(proc, function(cmd.str){system(cmd.str)}, cmd.str = cmd.str) # run glint
# # this returns:
# # INFO      >>> python glint-1.0.4/glint.py --datafile bval_minfidata.txt --covarfile covariates_minfidata.txt --covar age sex --epi --out glint_results_minfidata
# # INFO      Starting GLINT...
# # INFO      Validating arguments...
# # INFO      Loading file bval_minfidata.txt...
# # INFO      Checking for missing values in the data file...
# # INFO      Validating covariates file...
# # INFO      Loading file covariates_minfidata.txt...
# # INFO      New covariates were found: age, sex.
# # INFO      Running EPISTRUCTURE...
# # INFO      Removing non-informative sites...
# # INFO      Including sites...
# # INFO      Include sites: 4913 CpGs from the reference list of 4913 CpGs will be included...
# # WARNING   Found no sites to exclude.
# # INFO      Using covariates age, sex.
# # INFO      Regressing out covariates...
# # INFO      Running PCA...
# # INFO      The first 1 PCs were saved to glint_results_minfidata.epistructure.pcs.txt.
# # INFO      Added covariates epi1.
# # Validating all dependencies are installed...
# # All dependencies are installed
# # [1] 0

## -----------------------------------------------------------------------------
# out.fpath <- paste0(out.fpath, ".epistructure.pcs.txt")
# res2 <- read.table(out.fpath, sep = "\t")

## ----eval = T-----------------------------------------------------------------
colnames(res2) <- c("sample", "epistructure.pc")
dim(res2)
res2

## ----eval = T-----------------------------------------------------------------
utils::sessionInfo()

