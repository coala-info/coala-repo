# Code example from 'RedisParamUserGuide' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    eval =  RedisParam::rpalive()
)

## -----------------------------------------------------------------------------
# library(RedisParam)
# p <- RedisParam(workers = 5)
# result <- bplapply(1:7, function(i) Sys.getpid(), BPPARAM = p)
# table(unlist(result))

## ----eval = FALSE-------------------------------------------------------------
# Sys.getpid()
# library(RedisParam)
# p <- RedisParam(jobname = "demo", is.worker = TRUE)
# bpstart(p)

## ----eval = FALSE-------------------------------------------------------------
# Sys.getpid()            # e.g., 8563
# library(RedisParam)
# p <- RedisParam(jobname = 'demo', is.worker = FALSE)
# result <- bplapply(1:7, function(i) Sys.getpid(), BPPARAM = p)
# unique(unlist(result)) # e.g., 9677

## ----eval = FALSE-------------------------------------------------------------
# rpstopall(p)

## ----sessionInfo, echo = FALSE------------------------------------------------
# sessionInfo()

