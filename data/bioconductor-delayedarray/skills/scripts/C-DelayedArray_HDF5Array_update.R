# Code example from 'C-DelayedArray_HDF5Array_update' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
library(knitr)
opts_chunk$set(size="scriptsize")
options(width=80)
library(Matrix)
library(DelayedArray)
library(HDF5Array)
library(lobstr)

## ----ConstantArray------------------------------------------------------------
library(DelayedArray)
CM <- ConstantArray(c(1e6, 1e6), value=NA_real_)
CM
lobstr::obj_size(CM)

