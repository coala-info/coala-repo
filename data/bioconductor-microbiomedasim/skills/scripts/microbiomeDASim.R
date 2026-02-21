# Code example from 'microbiomeDASim' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
require(knitr)
opts_chunk$set(concordance=TRUE,tidy=TRUE)

## ----config,echo=FALSE-----------------------------------------
options(width = 65)
options(continue=" ")
options(warn=-1)

## ----pkg_install,eval=FALSE------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE)){
#     install.packages("BiocManager")
# }
# BiocManager::install("microbiomeDASim")

## ----tr_ex,fig.align='center',fig.height=4,fig.width=6,warning=FALSE,tidy=FALSE----
require(microbiomeDASim)
triv_ex <- mvrnorm_sim(n_control=10, n_treat=10, control_mean=2,
                        sigma=1, num_timepoints=2, t_interval=c(1, 2), rho=0.8,
                        corr_str="ar1", func_form="linear",
                        beta= c(1, 2), missing_pct=0,
                        missing_per_subject=0, dis_plot=TRUE)
head(triv_ex$df)
triv_ex$Sigma[seq_len(2), seq_len(2)]

## ----hockey_stick, fig.align='center', fig.height=4, fig.width=6, tidy=FALSE----
true_mean <- mean_trend(timepoints=1:10, form="L_up", beta=0.5, IP=5,
                            plot_trend=TRUE)
hockey_sim <- mvrnorm_sim(n_control=10, n_treat=10, control_mean=2, sigma=1,
                            num_timepoints=10, t_interval=c(0, 9), rho=0.8,
                            corr_str="ar1", func_form="L_up", beta= 0.5, IP=5,
                            missing_pct=0, missing_per_subject=0, dis_plot=TRUE,
                            asynch_time=TRUE)

## ----bug_gen, tidy=FALSE---------------------------------------
bug_gen <- gen_norm_microbiome(features=6, diff_abun_features=3, n_control=30,
                                n_treat=20, control_mean=2, sigma=2,
                                num_timepoints=4, t_interval=c(0, 3),
                                rho=0.9, corr_str="compound",
                                func_form="M", beta=c(4, 3), IP=c(2, 3.3, 6),
                                missing_pct=0.2, missing_per_subject=2,
                                miss_val=0)
head(bug_gen$bug_feat)
bug_gen$Y[, 1:5]
names(bug_gen)

## ----session_info----------------------------------------------
sessionInfo()

