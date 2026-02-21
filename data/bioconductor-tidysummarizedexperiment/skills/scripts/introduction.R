# Code example from 'introduction' vignette. See references/ for full tutorial.

## ----echo=FALSE, include=FALSE------------------------------------------------
library(knitr)
knitr::opts_chunk$set(warning=FALSE, message=FALSE)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE)) {
#       install.packages("BiocManager")
#   }
# 
# BiocManager::install("tidySummarizedExperiment")

## ----eval=FALSE---------------------------------------------------------------
# remotes::install_github("stemangiola/tidySummarizedExperiment")

## -----------------------------------------------------------------------------
library(ggplot2)
library(dplyr)
library(tidySummarizedExperiment)

## -----------------------------------------------------------------------------
pasilla_tidy <- tidySummarizedExperiment::pasilla 

## -----------------------------------------------------------------------------
pasilla_tidy

## -----------------------------------------------------------------------------
assays(pasilla_tidy)

## -----------------------------------------------------------------------------
pasilla_tidy %>%
    dplyr::slice(1)

## -----------------------------------------------------------------------------
pasilla_tidy %>%
    filter(condition == "untreated")

## -----------------------------------------------------------------------------
pasilla_tidy %>%
    select(.sample)

## -----------------------------------------------------------------------------
pasilla_tidy %>%
    dplyr::count(.sample)

## -----------------------------------------------------------------------------
pasilla_tidy %>%
    distinct(.sample, condition, type)

## -----------------------------------------------------------------------------
pasilla_tidy %>%
    dplyr::rename(sequencing=type)

## -----------------------------------------------------------------------------
pasilla_tidy %>%
    mutate(type=gsub("_end", "", type))

## -----------------------------------------------------------------------------
pasilla_tidy %>%
    unite("group", c(condition, type))

## -----------------------------------------------------------------------------
# Create two subsets of the data
pasilla_subset1 <- pasilla_tidy %>%
    filter(condition == "untreated")

pasilla_subset2 <- pasilla_tidy %>%
    filter(condition == "treated")

# Combine them using append_samples
combined_data <- append_samples(pasilla_subset1, pasilla_subset2)
combined_data

## -----------------------------------------------------------------------------
pasilla_tidy %>%
    group_by(.sample) %>%
    summarise(total_counts=sum(counts))

## -----------------------------------------------------------------------------
pasilla_tidy %>%
    group_by(.feature) %>%
    mutate(mean_count=mean(counts)) %>%
    filter(mean_count > 0)

## -----------------------------------------------------------------------------
my_theme <-
    list(
        scale_fill_brewer(palette="Set1"),
        scale_color_brewer(palette="Set1"),
        theme_bw() +
            theme(
                panel.border=element_blank(),
                axis.line=element_line(),
                panel.grid.major=element_line(size=0.2),
                panel.grid.minor=element_line(size=0.1),
                text=element_text(size=12),
                legend.position="bottom",
                aspect.ratio=1,
                strip.background=element_blank(),
                axis.title.x=element_text(margin=margin(t=10, r=10, b=10, l=10)),
                axis.title.y=element_text(margin=margin(t=10, r=10, b=10, l=10))
            )
    )

## ----plot1--------------------------------------------------------------------
pasilla_tidy %>%
    ggplot(aes(counts + 1, group=.sample, color=`type`)) +
    geom_density() +
    scale_x_log10() +
    my_theme

## -----------------------------------------------------------------------------
sessionInfo()

