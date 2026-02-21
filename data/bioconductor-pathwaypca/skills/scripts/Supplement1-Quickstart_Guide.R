# Code example from 'Supplement1-Quickstart_Guide' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE,
                      cache = FALSE,
                      comment = "#>")

## ----message = FALSE----------------------------------------------------------
library(parallel)
library(tidyverse)
library(pathwayPCA)

## ----read_gmt-----------------------------------------------------------------
gmt_path <- system.file("extdata", "c2.cp.v6.0.symbols.gmt",
                         package = "pathwayPCA", mustWork = TRUE)
cp_pathwayCollection <- read_gmt(gmt_path, description = FALSE)
cp_pathwayCollection

## ----read_assay---------------------------------------------------------------
assay_path <- system.file("extdata", "ex_assay_subset.csv",
                          package = "pathwayPCA", mustWork = TRUE)
assay_df <- read_csv(assay_path)

## ----TransposeAssay-----------------------------------------------------------
assayT_df <- TransposeAssay(assay_df)
assayT_df

## ----read_pinfo---------------------------------------------------------------
pInfo_path <- system.file("extdata", "ex_pInfo_subset.csv",
                          package = "pathwayPCA", mustWork = TRUE)
pInfo_df <- read_csv(pInfo_path)
pInfo_df

## ----innerJoin----------------------------------------------------------------
exSurv_df <- inner_join(pInfo_df, assayT_df, by = "Sample")
exSurv_df

## ----create_OmicsSurv_object--------------------------------------------------
data("colonSurv_df")
data("colon_pathwayCollection")

colon_OmicsSurv <- CreateOmics(
  assayData_df = colonSurv_df[, -(2:3)],
  pathwayCollection_ls = colon_pathwayCollection,
  response = colonSurv_df[, 1:3],
  respType = "survival"
)

## ----view_Omics---------------------------------------------------------------
colon_OmicsSurv

## ----accessor1----------------------------------------------------------------
getAssay(colon_OmicsSurv)

## ----accessor2----------------------------------------------------------------
getPathwayCollection(colon_OmicsSurv)

## ----accessor3----------------------------------------------------------------
getEventTime(colon_OmicsSurv)[1:10]

## ----accessor4----------------------------------------------------------------
getEvent(colon_OmicsSurv)[1:10]

## ----aespca-------------------------------------------------------------------
colon_aespcOut <- AESPCA_pVals(
  object = colon_OmicsSurv,
  numReps = 0,
  numPCs = 2,
  parallel = TRUE,
  numCores = 2,
  adjustpValues = TRUE,
  adjustment = "BH"
)

## ----superpca-----------------------------------------------------------------
colon_superpcOut <- SuperPCA_pVals(
  object = colon_OmicsSurv,
  numPCs = 2,
  parallel = TRUE,
  numCores = 2,
  adjustpValues = TRUE,
  adjustment = "BH"
)

## ----viewPathwayRanks---------------------------------------------------------
getPathpVals(colon_superpcOut)

## ----tidyOutput---------------------------------------------------------------
colonOutGather_df <-
  getPathpVals(colon_superpcOut) %>%
  gather(variable, value, -terms) %>%
  mutate(score = -log(value)) %>%
  mutate(variable = factor(variable)) %>% 
  mutate(variable = recode_factor(variable,
                                  rawp = "None",
                                  FDR_BH = "FDR"))

graphMax <- ceiling(max(colonOutGather_df$score))

colonOutGather_df

## ----surv_spr_pval_plot, fig.height = 6, fig.width = 10.7, out.width = "100%", out.height = "60%"----
raw_df <- colonOutGather_df %>% 
  filter(variable == "None") %>% 
  select(-variable, -value)

ggplot(raw_df) +
  theme_bw() +
  aes(x = reorder(terms, score), y = score) +
  geom_bar(stat = "identity", position = "dodge", fill = "#005030") +
  scale_fill_discrete(guide = FALSE) +
  ggtitle("Supervised PCA Significant Colon Pathways") +
  xlab("Pathways") +
  scale_y_continuous("Negative Log p-Value", limits = c(0, graphMax)) +
  geom_hline(yintercept = -log(0.01), size = 2) +
  coord_flip()

## ----sessionDetails-----------------------------------------------------------
sessionInfo()

