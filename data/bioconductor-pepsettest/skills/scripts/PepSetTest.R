# Code example from 'PepSetTest' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval = TRUE--------------------------------------------------------------
# Load library
library(PepSetTest)

# Generate random peptide data
dat <- matrix(rnorm(3000), ncol = 6)
dat[1:30, 4:6] <- dat[1:30, 4:6] + 2
dat <- 2^dat
colnames(dat) <- paste0("Sample", 1:6)
rownames(dat) <- paste0("Peptide", 1:500)

## ----eval = TRUE--------------------------------------------------------------
# Generate group labels and contrasts
group <- c(rep("H", 3), rep("D", 3))
contrasts.par <- "D-H"

## ----eval = TRUE--------------------------------------------------------------
# Generate a mapping table
pep_mapping_tbl <- data.frame(
  peptide = paste0("Peptide", 1:500),
  protein = paste0("Protein", rep(1:100, each = 5))
  )

## ----eval = TRUE--------------------------------------------------------------
# Run the workflow
result <- CompPepSetTestWorkflow(dat, 
                                 contrasts.par = contrasts.par,
                                 group = group,
                                 pep_mapping_tbl = pep_mapping_tbl,
                                 stat = "t",
                                 correlated = TRUE,
                                 equal.correlation = TRUE,
                                 pepC.estim = "mad",
                                 logged = FALSE)

## ----eval = TRUE--------------------------------------------------------------
library(dplyr)
library(tibble)
library(SummarizedExperiment)

colData <- data.frame(sample = LETTERS[seq_along(group)], 
                      group = group) %>% 
  column_to_rownames(var = "sample")
rowData <- pep_mapping_tbl %>% column_to_rownames(var = "peptide")
dat.nn <- dat
rownames(dat.nn) <- NULL
colnames(dat.nn) <- NULL
dat.se <- SummarizedExperiment(assays = list(int = dat.nn), 
                               colData = colData, 
                               rowData = rowData)

## ----eval = TRUE--------------------------------------------------------------
result2 <- CompPepSetTestWorkflow(dat.se, 
                                  contrasts.par = contrasts.par,
                                  group = "group",
                                  pep_mapping_tbl = "protein",
                                  stat = "t",
                                  correlated = TRUE,
                                  equal.correlation = TRUE,
                                  pepC.estim = "mad",
                                  logged = FALSE)

## ----eval = TRUE--------------------------------------------------------------
library(dplyr)
library(tibble)
library(SummarizedExperiment)

colData <- data.frame(sample = LETTERS[seq_along(group)], 
                      group = group,
                      sex = c("M", "F", "M", "F", "F", "M"),
                      age = 1:6) %>% 
  column_to_rownames(var = "sample")
rowData <- pep_mapping_tbl %>% column_to_rownames(var = "peptide")
dat.nn <- dat
rownames(dat.nn) <- NULL
colnames(dat.nn) <- NULL
dat.se <- SummarizedExperiment(assays = list(int = dat.nn), 
                               colData = colData, 
                               rowData = rowData)

## ----eval = TRUE--------------------------------------------------------------
result3 <- CompPepSetTestWorkflow(dat.se, 
                                  contrasts.par = contrasts.par,
                                  group = "group",
                                  pep_mapping_tbl = "protein",
                                  covar = c("sex", "age"),
                                  stat = "t",
                                  correlated = TRUE,
                                  equal.correlation = TRUE,
                                  pepC.estim = "mad",
                                  logged = FALSE)

## ----eval = TRUE--------------------------------------------------------------
result4 <- AggLimmaWorkflow(dat.se, 
                            contrasts.par = contrasts.par,
                            group = "group",
                            pep_mapping_tbl = "protein",
                            covar = c("sex", "age"),
                            method = "robreg",
                            logged = FALSE)

## ----eval = TRUE--------------------------------------------------------------
result4_2 <- SelfContPepSetTestWorkflow(dat.se, 
                                        contrasts.par = contrasts.par,
                                        group = "group",
                                        pep_mapping_tbl = "protein",
                                        covar = c("sex", "age"),
                                        logged = FALSE)

