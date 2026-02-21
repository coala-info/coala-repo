# Code example from 'Vignette' vignette. See references/ for full tutorial.

## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
knitr::opts_chunk$set(fig.width=5, fig.height=4) 

## ----results='hide', message=FALSE, warning=FALSE------------------------
library(BDMMAcorrect)
require(SummarizedExperiment)
data(Microbiome_dat)
### Access phenotypes information 
col_data <- colData(Microbiome_dat)
pheno <- data.frame(col_data$main, col_data$confounder)
batch <- col_data[,3]
### Access taxonomy read counts 
counts <- t(assay(Microbiome_dat))
### Indicate whether the phenotype variables are continuous
continuous <- mcols(col_data)[1:2,]

## ---- echo=TRUE----------------------------------------------------------
figure = VBatch(Microbiome_dat = Microbiome_dat, method = "bray")
print(figure)

## ---- echo=TRUE----------------------------------------------------------
main_variable <- pheno[,1]
main_variable[main_variable == 0] <- "Control"
main_variable[main_variable == 1] <- "Case"
figure <- VBatch(Microbiome_dat = Microbiome_dat, main_variable = main_variable, method = "bray")
print(figure[[1]])

## ---- echo=TRUE----------------------------------------------------------
print(figure[[2]])

## ---- echo=TRUE----------------------------------------------------------
output <- BDMMA(Microbiome_dat = Microbiome_dat, burn_in = 4000, sample_period = 4000)
print(output$selected.taxa)
head(output$parameter_summary)
print(output$PIP)
print(output$bFDR)

## ---- include=FALSE------------------------------------------------------
knitr::opts_chunk$set(fig.width=6, fig.height=2.5) 

## ---- echo=TRUE----------------------------------------------------------
figure <- trace_plot(trace = output$trace, param = c("alpha_1", "beta1_10"))
print(figure)

## ---- echo=TRUE----------------------------------------------------------
### Simulate counts
counts <- rmultinom(100,10000,rep(0.02,50))
### Simulate covariates
main <- rbinom(100,1,0.5)
confounder <- rnorm(100,0,1)
### Simulate batches
batch <- c(rep(1,50),rep(2,50))

library(SummarizedExperiment)
col_data <- DataFrame(main, confounder, batch)
mcols(col_data)$continous <- c(0L, 1L, 0L)
### pack different datasets into a SummarizedExperiment object
Microbiome_dat <- SummarizedExperiment(list(counts), colData=col_data)

