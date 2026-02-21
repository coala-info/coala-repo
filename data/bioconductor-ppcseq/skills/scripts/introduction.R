# Code example from 'introduction' vignette. See references/ for full tutorial.

## ----echo=FALSE, include=FALSE------------------------------------------------
library(knitr)
knitr::opts_chunk$set(
    warning=FALSE,
    message=FALSE
)

## -----------------------------------------------------------------------------
library(dplyr)
library(ppcseq)

## ----eval=FALSE---------------------------------------------------------------
# fileConn<-file("~/.R/Makevars")
# writeLines(c( "CXX14FLAGS += -O3","CXX14FLAGS += -DSTAN_THREADS", "CXX14FLAGS += -pthread"), fileConn)
# close(fileConn)

## ----eval=FALSE---------------------------------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# BiocManager::install("ppcseq")

## -----------------------------------------------------------------------------
data("counts")
counts 

## ----warning=FALSE, message=FALSE,results='hide'------------------------------
# Import libraries

if(Sys.info()[['sysname']] == "Linux")
counts.ppc = 
	counts %>%
	mutate(is_significant = FDR < 0.0001) %>%
	identify_outliers(
		formula = ~ Label,
		.sample = sample, 
		.transcript = symbol,
		.abundance = value,
		.significance = PValue,
		.do_check = is_significant,
		percent_false_positive_genes = 5, 
		approximate_posterior_inference = FALSE,
		cores = 1, 
		
		# This is ONLY for speeding up the Vignette execution
		draws_after_tail = 1
	)

## -----------------------------------------------------------------------------
if(Sys.info()[['sysname']] == "Linux")
counts.ppc 

## -----------------------------------------------------------------------------
if(Sys.info()[['sysname']] == "Linux")
counts.ppc_plots = 
	counts.ppc %>% 
	plot_credible_intervals() 

## -----------------------------------------------------------------------------
if(Sys.info()[['sysname']] == "Linux")
counts.ppc_plots %>%
	pull(plot) %>% 
	.[seq_len(1)]

## ----softwareinfo-------------------------------------------------------------
sessionInfo()

