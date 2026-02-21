# Code example from 'progeny' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----load, message=FALSE------------------------------------------------------
library(progeny)
library(ggplot2)
library(dplyr)

## ----model--------------------------------------------------------------------
model <- progeny::model_human_full
head(model)

## ----w_dist-------------------------------------------------------------------
# Get top 100 significant genes per pathway
model_100 <- model %>%
  group_by(pathway) %>%
  slice_min(order_by = p.value, n = 200)

# Plot
ggplot(data=model_100, aes(x=weight, color=pathway, fill=pathway)) +
  geom_density() +
  theme(text = element_text(size=12)) +
  facet_wrap(~ pathway, scales='free') +
  xlab('scores') +
  ylab('densities') +
  theme_bw() +
  theme(legend.position = "none")


