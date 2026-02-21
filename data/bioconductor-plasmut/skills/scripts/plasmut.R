# Code example from 'plasmut' vignette. See references/ for full tutorial.

## ----installation, eval = FALSE-----------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("plasmut")

## ----setup, message=FALSE-----------------------------------------------------
library(magrittr)
library(tidyverse)
library(plasmut)
knitr::opts_chunk$set(cache=TRUE)
lo <- function(p) log(p/(1-p))

## ----data_wrangling-----------------------------------------------------------
## sample data
p53 <- tibble(y=c(4, 0),
              n=c(1000, 600),
              analyte=c("plasma", "buffy coat"),
              mutation="TP53",
              sample_id="id1")
dat <- p53 %>%
    unite("uid", c(sample_id, mutation), remove=FALSE) %>%
    group_by(uid) %>%
    nest()
## required format for plasmut
dat

## ----parameters---------------------------------------------------------------
## Parameters
param.list <- list(ctc=list(a=1, b=10e3),
                   ctdna=list(a=1, b=9),
                   chip=list(a=1, b=9),
                   montecarlo.samples=50e3,
                   prior.weight=0.1)

## ----montecarlo---------------------------------------------------------------
stats <- importance_sampler(dat$data[[1]], param.list)
## Just the mutation-level summary statistics (marginal likelihoods and bayes factors)
importance_sampler(dat$data[[1]], param.list, save_montecarlo=FALSE)

## ----prior.weight, cache=TRUE-------------------------------------------------
fun <- function(montecarlo.samples, data,
                param.list, prior.weight=0.1){
    param.list$montecarlo.samples <- montecarlo.samples
    param.list$prior.weight <- prior.weight
    res <- importance_sampler(data, param.list,
                              save_montecarlo=FALSE) %>%
        mutate(montecarlo.samples=montecarlo.samples,
               prior.weight=param.list$prior.weight)
    res
}
fun2 <- function(montecarlo.samples, data,
                 param.list, prior.weight=0.1,
                 nreps=100){
    res <- replicate(nreps, fun(montecarlo.samples, data,
                                param.list,
                                prior.weight=prior.weight),
                     simplify=FALSE) %>%
        do.call(bind_rows, .) %>%
        group_by(montecarlo.samples, prior.weight) %>%
        summarize(mean_bf=mean(bayesfactor),
                  sd_bf=sd(bayesfactor),
                  .groups="drop")
    res
}
S <- c(100, 1000, seq(10e3, 50e3, by=10000))
results <- S %>%
    map_dfr(fun2, data=dat$data[[1]], param.list=param.list)
results2 <- S %>%
    map_dfr(fun2, data=dat$data[[1]], param.list=param.list,
            prior.weight=1)
combined <- bind_rows(results, results2)

## ----standardev, fig.width=8, fig.height=5------------------------------------
combined %>%
    mutate(prior.weight=factor(prior.weight)) %>%
    ggplot(aes(montecarlo.samples, sd_bf)) +
    geom_point(aes(color=prior.weight)) +
    geom_line(aes(group=prior.weight, color=prior.weight)) +
    scale_y_log10() +
    theme_bw(base_size=16) +
    xlab("Monte Carlo samples") +
    ylab("Standard deviation of\n log Bayes Factor")

## ----means, fig.width=8, fig.height=5-----------------------------------------
combined %>%
    mutate(prior.weight=factor(prior.weight)) %>%
    filter(montecarlo.samples > 100) %>%
    ggplot(aes(prior.weight, mean_bf)) +
    geom_point() +
    theme_bw(base_size=16) +
    ylab("Mean log Bayes factor") +
    xlab("Prior weight")

## ----vanterve-----------------------------------------------------------------
data(crcseq, package="plasmut")
crcseq %>% select(-position)

## ----vanterve-importance-sampling---------------------------------------------
params <- list(ctdna = list(a = 1, b = 9), 
               ctc = list(a = 1, b = 10^3), 
               chip = list(a= 1, b = 9), 
               montecarlo.samples = 50e3, 
               prior.weight = 0.1)
muts <- unite(crcseq, "uid", c(patient, gene), remove = FALSE) %>% 
        group_by(uid) %>% nest()
#Each element of the data column contains a table with the variant and total allele counts in plasma and buffy coat. 
#Run the importance sampler
muts$IS <- muts$data %>% map(importance_sampler, params)
fun <- function(x){
    result <- x$data %>%
        select(-position) %>%
        mutate(bayes_factor = x$IS$bayesfactor$bayesfactor)
    return(result)
}
bf <- apply(muts, 1, fun) 
bf %>% do.call(rbind, .) %>%
    as_tibble() %>%
    select(patient, gene, aa, bayes_factor) %>%
    rename(log_bf=bayes_factor) %>%
    distinct()

## ----session------------------------------------------------------------------
sessionInfo()

