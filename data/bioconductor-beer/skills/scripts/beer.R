# Code example from 'beer' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>", 
  message = FALSE
)

## ----load_packages, include = TRUE, results = "hide", message = FALSE, warning = FALSE----
library(ggplot2)
library(dplyr)

## ----install_beer, eval = FALSE-----------------------------------------------
# BiocManager::install("beer")

## ----load_beer, include = TRUE, results = "hide", message = FALSE, warning = FALSE----
library(beer)

## ----load_data----------------------------------------------------------------
data_path <- system.file("extdata/sim_data.rds", package = "beer")
sim_data <- readRDS(data_path)

sim_data

## ----edgeR--------------------------------------------------------------------
edgeR_out <- runEdgeR(sim_data, 
                      assay.names = c(logfc = "edgeR_logfc",
                                      prob = "edgeR_logpval"))

## ----edgeR_hits---------------------------------------------------------------
assay(edgeR_out, "edgeR_hits") <- apply(
  assay(edgeR_out, "edgeR_logpval"), 2, 
  function(sample){
    pval <- 10^(-sample)
    p.adjust(pval, method = "BH") < 0.05
  })

colSums(assay(edgeR_out, "edgeR_hits"))

## ----beer, results = FALSE, message=FALSE, warning = FALSE, error = FALSE-----
## Named vector specifying where we want to store the summarized MCMC output
## NULL indicates that the output should not be stored.
assay_locations <- c(
  phi = "beer_fc_marg", 
  phi_Z = "beer_fc_cond", 
  Z = "beer_prob", 
  c = "sampleInfo", 
  pi = "sampleInfo"
)

beer_out <- brew(edgeR_out, assay.names = assay_locations)

## ----beer_hits----------------------------------------------------------------
## Define matrix of peptides that were run in BEER
was_run <- matrix(rep(beer_out$group != "beads", each = nrow(beer_out)), 
                  nrow = nrow(beer_out))

## Identify super-enriched peptides
## These peptides were in samples that were run, but have missing posterior 
## probabilities
are_se <- was_run & is.na(assay(beer_out, "beer_prob"))

## Enriched peptides are peptides with:
## - posterior probability > 0.5, OR
## - super-enriched peptides
assay(beer_out, "beer_hits") <- assay(beer_out, "beer_prob") > 0.5 | are_se

colSums(assay(beer_out, "beer_hits"))

## ----prior_plot, echo = FALSE, fig.width = 6, fig.height=2.5------------------
data.frame(x = c(seq(0, 1, by = 0.01),
                 seq(0, 0.1, by = 0.001), 
                 1 + seq(0, 49, by = 0.5)), 
           dens = c(dbeta(seq(0, 1, by = 0.01), 80, 20), 
                    dbeta(seq(0, 0.1, by = 0.001), 2, 300), 
                    dgamma(seq(0, 49, by = 0.5), 1.25, 0.1)), 
           param = rep(c("attenuation constant", 
                         "proportion of enriched peptides", 
                         "fold-change for enriched peptides"), 
                       times = c(101, 101, 99))) |>
  ggplot(aes(x = x, y = dens)) +
  facet_wrap(param ~., nrow = 1, scales = "free", 
             labeller = label_wrap_gen()) + 
  labs(x = "value", y = "density") +
  geom_line() +
  theme_bw() +
  theme(aspect.ratio = 1)

## ----edgeR_beadsRR------------------------------------------------------------
## edgeR with beadsRR
edgeR_beadsRR <- runEdgeR(sim_data, beadsRR = TRUE, 
                          assay.names = c(logfc = "edgeR_logfc", 
                                          prob = "edgeR_logpval"))
## Calculate hits
assay(edgeR_beadsRR, "edgeR_hits") <- apply(
  assay(edgeR_beadsRR, "edgeR_logpval"), 2, 
  function(sample){
    pval <- 10^(-sample)
    p.adjust(pval, method = "BH") < 0.05
  })

## Note samples 1-4 have 0 instead of NA now
colSums(assay(edgeR_beadsRR, "edgeR_hits"))

## ----beer_beadsRR, message=FALSE, warning = FALSE, error = FALSE--------------
## BEER with beadsRR added to edgeR output
beer_beadsRR <- brew(edgeR_beadsRR, beadsRR = TRUE, 
                     assay.names = assay_locations)

## Check BEER hits like before
was_run <- matrix(rep(beer_beadsRR$group != "beads", each = nrow(beer_beadsRR)), 
                  nrow = nrow(beer_beadsRR))
are_se <- was_run & is.na(assay(beer_beadsRR, "beer_prob"))
beer_hits <- assay(beer_beadsRR, "beer_prob") > 0.5 | are_se

## Note again that samples 1-4 are not NA 
colSums(beer_hits)

## ----edgeR_beadsRR_only-------------------------------------------------------
## edgeR with beadsRR
edgeR_beadsRR <- beadsRR(sim_data, method = "edgeR", 
                         assay.names = c(logfc = "edgeR_logfc", 
                                         prob = "edgeR_logpval"))
## Calculate hits
assay(edgeR_beadsRR, "edgeR_hits") <- apply(
  assay(edgeR_beadsRR, "edgeR_logpval"), 2, 
  function(sample){
    pval <- 10^(-sample)
    p.adjust(pval, method = "BH") < 0.05
  })

## Note samples 5-10 are NA now
colSums(assay(edgeR_beadsRR, "edgeR_hits"))

## ----beer_beadsRR_only, message=FALSE, warning = FALSE, error = FALSE---------
## BEER with beadsRR added to edgeR output
beer_beadsRR <- beadsRR(edgeR_beadsRR, method = "beer",
                        assay.names = assay_locations)

## Check BEER hits like before
was_run <- matrix(rep(beer_beadsRR$group == "beads", each = nrow(beer_beadsRR)), 
                  nrow = nrow(beer_beadsRR))
are_se <- was_run & is.na(assay(beer_beadsRR, "beer_prob"))
beer_hits <- assay(beer_beadsRR, "beer_prob") > 0.5 | are_se

## Note again that samples 5-10 are now NA 
colSums(beer_hits)

## ----warning=FALSE------------------------------------------------------------
## Run edgeR using different parallel environments
runEdgeR(sim_data, BPPARAM = BiocParallel::SerialParam())
runEdgeR(sim_data, BPPARAM = BiocParallel::SnowParam())

## Run beer in parallel
brew(sim_data, BPPARAM = BiocParallel::SerialParam())
brew(sim_data, BPPARAM = BiocParallel::SnowParam())

## ----echo = FALSE, warning = FALSE, fig.align='left', fig.height=5, fig.width=6, fig.cap="Observed versus expected read counts for simulated data. Each point represents a peptide in a given sample. Point in red indicate truly enriched peptides."----

getExpected(sim_data) %>%
  as("DataFrame") %>%
  as_tibble() %>%
  group_by(peptide) %>%
  mutate(sample = factor(sample, 1:10),
         sample_name = paste0(group, " ", sample)) %>%
  arrange(true_Z) %>%
  ggplot(aes(x = expected_rc, y = counts, color = factor(true_Z))) + 
  geom_abline(aes(intercept = 0, slope = 1), size = 1) + 
  geom_point() +
  facet_wrap(sample_name ~., ncol = 4, scales = "free") +
  labs(x = "expected read counts", 
       y = "observed read counts", 
       color = "true enrichment status") +
  scale_x_log10() +
  scale_y_log10() +
  scale_color_manual(values = c("grey", "red"), 
                     breaks = c(0, 1), 
                     labels = c("not enriched", "enriched")) +
  theme_bw() + 
  theme(legend.position = c(0.75, 0.15), 
        axis.text.x = element_text(angle = 45, hjust = 1), 
        aspect.ratio = 1)

## ----echo = FALSE, warning = FALSE, fig.align='left', fig.height=5, fig.width=6, fig.cap="Bayes factors for simulated data."----

brew(sim_data, beadsRR = TRUE) %>%
getBF() %>%
  as("DataFrame") %>%
  as_tibble() %>%
  mutate(
    peptide = factor(peptide, 1:10), 
    sample = factor(sample, 1:10),
         sample_name = paste0(group, " ", sample), 
    pred = ifelse(prob >= 0.5, TRUE, FALSE)) %>%
  ggplot(aes(x = peptide, y = bayes_factors, color = pred)) +
  geom_point() + 
  facet_wrap(sample_name ~., ncol = 4) +
  labs(x = "peptide", 
       y = "Bayes factor", 
       color = "prediction") +
  scale_y_log10() +
  scale_color_manual(
    breaks = c(TRUE, FALSE), 
    values = c("red", "black"), 
    labels = c("enriched", "not enriched")
  ) +
  theme_bw() + 
  theme(legend.position = c(0.75, 0.15),
        aspect.ratio = 1)

## -----------------------------------------------------------------------------
sessionInfo()

