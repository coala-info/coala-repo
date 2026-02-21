# Code example from 'User_Manual' vignette. See references/ for full tutorial.

## ----setup, include = FALSE, warning = FALSE----------------------------------
knitr::opts_chunk$set(comment = FALSE, 
                      warning = FALSE, 
                      message = FALSE)

## -----------------------------------------------------------------------------
require(IgGeneUsage)
require(rstan)
require(knitr)
require(ggplot2)
require(ggforce)
require(ggrepel)
require(reshape2)
require(patchwork)

## -----------------------------------------------------------------------------
data("d_zibb_3", package = "IgGeneUsage")
knitr::kable(head(d_zibb_3))

## ----fig.width=6, fig.height=3.25---------------------------------------------
ggplot(data = d_zibb_3)+
  geom_point(aes(x = gene_name, y = gene_usage_count, col = condition),
             position = position_dodge(width = .7), shape = 21)+
  theme_bw(base_size = 11)+
  ylab(label = "Gene usage [count]")+
  xlab(label = '')+
  theme(legend.position = "top")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.4))

## -----------------------------------------------------------------------------
M <- DGU(ud = d_zibb_3, # input data
         mcmc_warmup = 300, # how many MCMC warm-ups per chain (default: 500)
         mcmc_steps = 1500, # how many MCMC steps per chain (default: 1,500)
         mcmc_chains = 3, # how many MCMC chain to run (default: 4)
         mcmc_cores = 1, # how many PC cores to use? (e.g. parallel chains)
         hdi_lvl = 0.95, # highest density interval level (de fault: 0.95)
         adapt_delta = 0.8, # MCMC target acceptance rate (default: 0.95)
         max_treedepth = 10) # tree depth evaluated at each step (default: 12)

## -----------------------------------------------------------------------------
summary(M)

## -----------------------------------------------------------------------------
rstan::check_hmc_diagnostics(M$fit)

## ----fig.height = 3, fig.width = 6--------------------------------------------
rstan::stan_rhat(object = M$fit)|rstan::stan_ess(object = M$fit)

## ----fig.height = 4, fig.width = 7--------------------------------------------
ggplot(data = M$ppc$ppc_rep)+
  facet_wrap(facets = ~individual_id, ncol = 5)+
  geom_abline(intercept = 0, slope = 1, linetype = "dashed", col = "darkgray")+
  geom_errorbar(aes(x = observed_count, y = ppc_mean_count, 
                    ymin = ppc_L_count, ymax = ppc_H_count), col = "darkgray")+
  geom_point(aes(x = observed_count, y = ppc_mean_count), size = 1)+
  theme_bw(base_size = 11)+
  theme(legend.position = "top")+
  xlab(label = "Observed usage [counts]")+
  ylab(label = "PPC usage [counts]")

## ----fig.height = 3, fig.width = 5--------------------------------------------
ggplot(data = M$ppc$ppc_condition)+
  geom_errorbar(aes(x = gene_name, ymin = ppc_L_prop*100, 
                    ymax = ppc_H_prop*100, col = condition), 
                position = position_dodge(width = 0.65), width = 0.1)+
  geom_point(aes(x = gene_name, y = ppc_mean_prop*100,col = condition), 
                position = position_dodge(width = 0.65))+
  theme_bw(base_size = 11)+
  theme(legend.position = "top")+
  xlab(label = "Observed usage [%]")+
  ylab(label = "PPC usage [%]")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.4))

## -----------------------------------------------------------------------------
kable(x = head(M$dgu), row.names = FALSE, digits = 2)

## ----fig.height = 4, fig.width = 5--------------------------------------------
# format data
stats <- M$dgu
stats <- stats[order(abs(stats$es_mean), decreasing = FALSE), ]
stats$gene_fac <- factor(x = stats$gene_name, levels = unique(stats$gene_name))


ggplot(data = stats)+
  geom_hline(yintercept = 0, linetype = "dashed", col = "gray")+
  geom_errorbar(aes(x = pmax, y = es_mean, ymin = es_L, ymax = es_H), 
                col = "darkgray")+
  geom_point(aes(x = pmax, y = es_mean, col = contrast))+
  geom_text_repel(data = stats[stats$pmax >= 0.95, ],
                  aes(x = pmax, y = es_mean, label = gene_fac),
                  min.segment.length = 0, size = 2.75)+
  theme_bw(base_size = 11)+
  theme(legend.position = "top")+
  xlab(label = expression(pi))+
  xlim(c(0, 1))+
  ylab(expression(gamma))

## ----fig.height = 3, fig.width = 5--------------------------------------------
promising_genes <- stats$gene_name[stats$pmax >= 0.95]

ppc_gene <- M$ppc$ppc_condition
ppc_gene <- ppc_gene[ppc_gene$gene_name %in% promising_genes, ]

ppc_rep <- M$ppc$ppc_rep
ppc_rep <- ppc_rep[ppc_rep$gene_name %in% promising_genes, ]



ggplot()+
  geom_point(data = ppc_rep,
             aes(x = gene_name, y = observed_prop*100, col = condition),
             size = 1, fill = "black",
             position = position_jitterdodge(jitter.width = 0.1, 
                                             jitter.height = 0, 
                                             dodge.width = 0.35))+
  geom_errorbar(data = ppc_gene, 
                aes(x = gene_name, ymin = ppc_L_prop*100, 
                    ymax = ppc_H_prop*100, group = condition),
                position = position_dodge(width = 0.35), width = 0.15)+
  theme_bw(base_size = 11)+
  theme(legend.position = "top")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.4))+
  ylab(label = "PPC usage [%]")+
  xlab(label = '')

## ----fig.height = 3, fig.width = 5--------------------------------------------
ggplot()+
  geom_point(data = ppc_rep,
             aes(x = gene_name, y = observed_count, col = condition),
             size = 1, fill = "black",
             position = position_jitterdodge(jitter.width = 0.1, 
                                             jitter.height = 0, 
                                             dodge.width = 0.5))+
  theme_bw(base_size = 11)+
  theme(legend.position = "top")+
  ylab(label = "PPC usage [count]")+
  xlab(label = '')+
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.4))

## ----fig.width=5, fig.height=4------------------------------------------------
ggplot(data = M$gu)+
  geom_errorbar(aes(x = gene_name, y = prob_mean, ymin = prob_L,
                    ymax = prob_H, col = condition),
                width = 0.1, position = position_dodge(width = 0.4))+
  geom_point(aes(x = gene_name, y = prob_mean, col = condition), size = 1,
             position = position_dodge(width = 0.4))+
  theme_bw(base_size = 11)+
  theme(legend.position = "top")+
  ylab(label = "GU [probability]")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.4))

## -----------------------------------------------------------------------------
L <- LOO(ud = d_zibb_3, # input data
         mcmc_warmup = 500, # how many MCMC warm-ups per chain (default: 500)
         mcmc_steps = 1000, # how many MCMC steps per chain (default: 1,500)
         mcmc_chains = 1, # how many MCMC chain to run (default: 4)
         mcmc_cores = 1, # how many PC cores to use? (e.g. parallel chains)
         hdi_lvl = 0.95, # highest density interval level (de fault: 0.95)
         adapt_delta = 0.8, # MCMC target acceptance rate (default: 0.95)
         max_treedepth = 10) # tree depth evaluated at each step (default: 12)

## -----------------------------------------------------------------------------
L_gu <- do.call(rbind, lapply(X = L, FUN = function(x){return(x$gu)}))
L_dgu <- do.call(rbind, lapply(X = L, FUN = function(x){return(x$dgu)}))

## ----fig.width=6, fig.height=5------------------------------------------------
ggplot(data = L_dgu)+
  facet_wrap(facets = ~contrast, ncol = 1)+
  geom_hline(yintercept = 0, linetype = "dashed", col = "gray")+
  geom_errorbar(aes(x = gene_name, y = es_mean, ymin = es_L,
                    ymax = es_H, col = contrast, group = loo_id),
                width = 0.1, position = position_dodge(width = 0.75))+
  geom_point(aes(x = gene_name, y = es_mean, col = contrast,
                 group = loo_id), size = 1,
             position = position_dodge(width = 0.75))+
  theme_bw(base_size = 11)+
  theme(legend.position = "none")+
  ylab(expression(gamma))

## ----fig.width=6, fig.height=5------------------------------------------------
ggplot(data = L_dgu)+
  facet_wrap(facets = ~contrast, ncol = 1)+
  geom_point(aes(x = gene_name, y = pmax, col = contrast,
                 group = loo_id), size = 1,
             position = position_dodge(width = 0.5))+
  theme_bw(base_size = 11)+
  theme(legend.position = "none")+
  ylab(expression(pi))

## ----fig.width=6, fig.height=4------------------------------------------------
ggplot(data = L_gu)+
  geom_hline(yintercept = 0, linetype = "dashed", col = "gray")+
  geom_errorbar(aes(x = gene_name, y = prob_mean, ymin = prob_L,
                    ymax = prob_H, col = condition, 
                    group = interaction(loo_id, condition)),
                width = 0.1, position = position_dodge(width = 1))+
  geom_point(aes(x = gene_name, y = prob_mean, col = condition,
                 group = interaction(loo_id, condition)), size = 1,
             position = position_dodge(width = 1))+
  theme_bw(base_size = 11)+
  theme(legend.position = "top")+
  ylab("GU [probability]")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.4))

## -----------------------------------------------------------------------------
data("d_zibb_4", package = "IgGeneUsage")
knitr::kable(head(d_zibb_4))

## ----fig.width=6.5, fig.height=3.25-------------------------------------------
ggplot(data = d_zibb_4)+
  geom_point(aes(x = gene_name, y = gene_usage_count, col = condition, 
                 shape = replicate), position = position_dodge(width = 0.8))+
  theme_bw(base_size = 11)+
  ylab(label = "Gene usage [count]")+
  xlab(label = '')+
  theme(legend.position = "top")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.4))

## -----------------------------------------------------------------------------
M <- DGU(ud = d_zibb_4, # input data
         mcmc_warmup = 500, # how many MCMC warm-ups per chain (default: 500)
         mcmc_steps = 1500, # how many MCMC steps per chain (default: 1,500)
         mcmc_chains = 2, # how many MCMC chain to run (default: 4)
         mcmc_cores = 1, # how many PC cores to use? (e.g. parallel chains)
         hdi_lvl = 0.95, # highest density interval level (de fault: 0.95)
         adapt_delta = 0.8, # MCMC target acceptance rate (default: 0.95)
         max_treedepth = 10) # tree depth evaluated at each step (default: 12)

## ----fig.height = 6, fig.width = 6--------------------------------------------
ggplot(data = M$ppc$ppc_rep)+
  facet_wrap(facets = ~individual_id, ncol = 3)+
  geom_abline(intercept = 0, slope = 1, linetype = "dashed", col = "darkgray")+
  geom_errorbar(aes(x = observed_count, y = ppc_mean_count, 
                    ymin = ppc_L_count, ymax = ppc_H_count), col = "darkgray")+
  geom_point(aes(x = observed_count, y = ppc_mean_count), size = 1)+
  theme_bw(base_size = 11)+
  theme(legend.position = "top")+
  xlab(label = "Observed usage [counts]")+
  ylab(label = "PPC usage [counts]")

## ----fig.weight = 7, fig.height = 4-------------------------------------------
g1 <- ggplot(data = M$gu)+
  geom_errorbar(aes(x = gene_name, y = prob_mean, ymin = prob_L,
                    ymax = prob_H, col = condition),
                width = 0.1, position = position_dodge(width = 0.4))+
  geom_point(aes(x = gene_name, y = prob_mean, col = condition), size = 1,
             position = position_dodge(width = 0.4))+
  theme_bw(base_size = 11)+
  theme(legend.position = "top")+
  ylab(label = "GU [probability]")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.4))


stats <- M$dgu
stats <- stats[order(abs(stats$es_mean), decreasing = FALSE), ]
stats$gene_fac <- factor(x = stats$gene_name, levels = unique(stats$gene_name))

g2 <- ggplot(data = stats)+
  facet_wrap(facets = ~contrast)+
  geom_hline(yintercept = 0, linetype = "dashed", col = "gray")+
  geom_errorbar(aes(x = pmax, y = es_mean, ymin = es_L, ymax = es_H), 
                col = "darkgray")+
  geom_point(aes(x = pmax, y = es_mean, col = contrast))+
  geom_text_repel(data = stats[stats$pmax >= 0.95, ],
                  aes(x = pmax, y = es_mean, label = gene_fac),
                  min.segment.length = 0, size = 2.75)+
  theme_bw(base_size = 11)+
  theme(legend.position = "top")+
  xlab(label = expression(pi))+
  xlim(c(0, 1))+
  ylab(expression(gamma))

## ----fig.height = 6, fig.width = 7--------------------------------------------
(g1/g2)

## -----------------------------------------------------------------------------
sessionInfo()

