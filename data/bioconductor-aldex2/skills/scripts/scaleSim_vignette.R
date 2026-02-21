# Code example from 'scaleSim_vignette' vignette. See references/ for full tutorial.

## ----installScaleSim, warning = FALSE, message = FALSE------------------------
##If needed, install devtools
##install.packages("devtools")
# devtools::load_all("~/Documents/0_git/ALDEx_bioc")
library(ALDEx2)
set.seed(1234)

## ----dataSim1, message = FALSE, warning = FALSE-------------------------------
library(tidyverse)
##Function to create the true abundances via Poisson resampling
create_true_abundances <- function(d, n){
  dd <- length(d)/2
  dat <- d %>%
    sapply(function(x) rpois(n, lambda=x)) %>%
    t() %>%
    as.data.frame() %>%
    split(rep(1:2, each=dd)) %>%
    purrr::map(~`rownames<-`(.x, paste0("Taxa", 1:dd))) %>%
    purrr::map(t) %>%
    do.call(rbind, .) %>%
    as.data.frame() %>%
    cbind(Condition=factor(rep(c("Pre", "Post"), each=n), 
      levels = c("Pre", "Post")), .) %>% `rownames<-`(., NULL)
  return(dat)
}

## ----dataSim2, message = FALSE------------------------------------------------
##Function to resample data to an arbitrary size
resample_data <- function(dat, seq.depth){
  ddat <- as.matrix(dat[,-1])/rowSums(as.matrix(dat[,-1]))
  for (i in 1:nrow(dat)){
    dat[i,-1] <- rmultinom(1, size=seq.depth, prob=ddat[i,])
  }
  return(dat)
}

## ----dataSim3, message = FALSE------------------------------------------------
###Setting the data parameters for the simulation
##Denotes the mean for the 20 taxa
##Note only taxa 3, 4, 15, and 20 change
d.pre <- c(4000, 4000, 4000, 4000, 4000,
  400,400,400,400,4000,400,500,500,500,
  400,400,400,400,400,400)
d.post <- d.pre
d.post[c(3,4,15,20)] <- c(3000, 2000, 200, 100)

#Combining together
d <- c(d.pre, d.post)

##Create scale abundances
dat <- create_true_abundances(d, n=100)
##Create resampled data
rdat <- resample_data(dat, seq.depth=5000)

## ----dataSim5, message = FALSE------------------------------------------------
## Finding sample totals
totals <- rowSums(dat[,-1])

flow_cytometry <- function(totals, samp.names, replicates = 3){
  samp.names <- rep(samp.names, each = replicates)
  flow_vals <- sapply(totals, FUN = function(totals,   
    replicates){rnorm(replicates,totals,3e2)}, 
    replicates = replicates, simplify = TRUE)
  flow_data <- data.frame("sample" = samp.names, "flow" = c(flow_vals))
  return(flow_data)
}

flow_data <- flow_cytometry(totals, rownames(dat))

## ----dataElements-------------------------------------------------------------
##Inspecting elements
Y <- t(rdat[,-1])
Y[1:5,1:5]

conds <- as.character(rdat[,1])
conds

head(flow_data)

## ----defaultModel, message = FALSE--------------------------------------------
## Original ALDEx2
mod.base <- aldex(Y, conds, gamma = NULL)
mod.base %>% filter(we.eBH < 0.05)

## ----defaultModel2, message = FALSE-------------------------------------------
## Recreating ALDEx2
mod.clr <- aldex(Y, conds, gamma = 1e-3)
mod.clr %>% filter(we.eBH < 0.05)

## ----defaultModel3, message = FALSE-------------------------------------------
plot(mod.base$effect, mod.clr$effect, xlab = "Original ALDEx2 
  Effect Size", ylab = "Minimal Noise Effect Size")
abline(a=0,b=1, col = "red", lty = "dashed")

## ----defaultModelNoise, message = FALSE---------------------------------------
## Adding noise
mod.ss <- aldex(Y, conds, gamma = .25)
mod.ss %>% filter(we.eBH < 0.05)

## ----defaultModelNoise2, message = FALSE--------------------------------------
## Adding more noise
mod.coda <- aldex(Y, conds, gamma = 1)
mod.coda %>% filter(we.eBH < 0.05)

## ----measureMod---------------------------------------------------------------
flow_data_collapse <- flow_data %>%
  group_by(sample) %>%
  mutate(mean = mean(flow)) %>%
  mutate(stdev = sd(flow)) %>%
  select(-flow) %>%
  ungroup() %>%
  unique()

## ----measureModSamps----------------------------------------------------------
scale_samps <- matrix(NA, nrow = 200, ncol = 128)
for(i in 1:nrow(scale_samps)){
  scale_samps[i,] <- rnorm(128, flow_data_collapse$mean[i], flow_data_collapse$stdev[i])
}

## ----measureModFit, message = FALSE-------------------------------------------
mod.flow <- aldex(Y, conds, gamma = scale_samps)
mod.flow %>% filter(we.eBH < 0.05)

## ----knowModSamps-------------------------------------------------------------
# make a per-sample vector of scales
scales <- c(rep(1, 100), rep(0.9, 100))
scale_samps <- aldex.makeScaleMatrix(.15, scales, conds, log=FALSE)
# note 10% difference is about 2^.13
# can exactly replicate the above in log space with: 
# scales <- c(rep(.13, 100), rep(0, 100))
# scale_samps <- aldex.makeScaleMatrix(.15,scales, conds, log=TRUE)

## ----knowModFit, message = FALSE----------------------------------------------
mod.know <- aldex(Y, conds, gamma = scale_samps)
mod.know %>% filter(we.eBH < 0.05)

## ----aldex.plot, echo=FALSE, warning=FALSE------------------------------------
par(mfrow=c(2,2))
aldex.plot(mod.clr, xlim=c(0.1,0.8), ylim=c(-0.5,2), main='Default/CLR')
abline(h=0, lty=2, col='grey')
aldex.plot(mod.ss, xlim=c(0.1,0.8), ylim=c(-0.5,2), main='Relaxed')
abline(h=0, lty=2, col='grey')
aldex.plot(mod.flow, xlim=c(0.1,0.8), ylim=c(-0.5,2), main='Flow')
abline(h=0, lty=2, col='grey')
aldex.plot(mod.know, xlim=c(0.1,0.8), ylim=c(-0.5,2), main='Knowledge')
abline(h=0, lty=2, col='grey')

## ----graph, echo = FALSE, warning = FALSE-------------------------------------
library(ggplot2)
library(ggpattern)
library(cowplot)

##Function to label True/false positive/negatives
sig_code <- function(sig, Taxa, truth){
  out <- rep("TN", length(Taxa))
  out[sig &(Taxa %in% truth)] <- "TP" # True Positives
  out[sig & (out!="TP")] <- "FP" # False Positives
  out[!sig & (Taxa %in% truth)] <- "FN" # False Negatives
  return(out)
}

##Function to summarize aldex2 output
summary_aldex2 <- function(fit, pval = 0.05){
  fit %>%
    as.data.frame() %>%
    rownames_to_column("category") %>%
    select(category, effect, we.ep, we.eBH) %>%
    mutate(padj=we.eBH) %>%
    mutate(mean=effect) %>%
    mutate(low=NA, high=NA) %>%
    mutate(sig = ifelse(padj <= pval, TRUE, FALSE))
}

##Function to create the grid plot
plot_sig2 <- function(rrs, truth, ...){
  names(rrs) <- model.names[names(rrs)]
  bind_rows(rrs, .id="Model") %>%
    select(Model, category, sig) %>%
    mutate(Taxa = category) %>%
    mutate(Taxa=as.numeric(sub("Taxa", "", Taxa))) %>%
    mutate(sigcode = sig_code(sig, Taxa, truth)) %>%
    mutate(Taxa=factor(Taxa), sigcode=factor(sigcode,
                                             levels=c("TP", "TN",
                                                      "FP", "FN"))) %>%
    mutate(Model=factor(Model, levels=model.name.levels)) %>%
    ggplot(aes(x=Taxa, y=Model)) +
    geom_tile_pattern(aes(fill=sigcode, pattern = sigcode), color="darkgrey",pattern_fill = 'grey',pattern_colour  = 'grey', pattern_density = 0.015) +
    theme_minimal() +
    theme(panel.grid = element_blank(),
          legend.title=element_blank(),
          text = element_text(size=16),
          axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
    scale_pattern_manual(values = c(TP = "none", TN = "none", FP = "none", FN = "stripe")) +
    scale_fill_manual(values= c("black", "white", "grey", "white"))
}

##Plotting the results
##Pvalue at default of 0.05

p1 <- gather(dat, Taxa, Count, -Condition) %>%
    mutate(Taxa=as.numeric(sub("Taxa", "", Taxa))) %>%
    mutate(Taxa=factor(Taxa)) %>%
    ggplot(aes(x=Taxa, y=Count)) +
    geom_boxplot(aes(fill = Condition, color = Condition), position=position_dodge(width=1),
                size=1)+
    scale_y_log10() +
    theme_bw() +
    scale_fill_manual(values = c("#fdae61", "#2b83ba")) +
    scale_color_manual(values = c("#fdae61", "#2b83ba")) +
    labs(color='Antibiotic\nTreatment') +
    labs(fill='Antibiotic\nTreatment') +
    theme(axis.title.x = element_blank(),
                 axis.text.x = element_blank(),
                 axis.ticks.x=element_blank(),
                 text = element_text(size=16))

dd <- length(d)/2
truth1 <- !(d[1:dd]==d[(dd+1):(2*dd)])##testing if the mean is different
truth2 <- (1:dd)[truth1]##Locations of the differences

model.names <- c("mod.base"="ALDEx2",
                 "mod.clr" = "CLR",
                 "mod.ss"= "Relaxed",
                 "mod.know" = "Knowledged-Based",
                 "mod.flow" = "Flow-Based")
model.name.levels <- c("Flow-Based", "Knowledged-Based", "Relaxed",  "CLR", "ALDEx2")

rrs <- list(mod.base=summary_aldex2(mod.base), 
            mod.clr = summary_aldex2(mod.clr),
            mod.ss = summary_aldex2(mod.ss), 
            mod.know = summary_aldex2(mod.know),
            mod.flow = summary_aldex2(mod.flow))

p2 <- plot_sig2(rrs, truth=truth2)
p <- plot_grid(p1, p2, nrow=2, align="v", rel_heights=c(1.7, 1))
p

## ----senAnalysis, message = FALSE---------------------------------------------
gamma_to_test <- c(1e-3, .1, .25, .5, .75, 1, 2, 3, 4, 5)

##Run the CLR function
clr <- aldex.clr(Y, conds)

##Run sensitivity analysis function
sen_res <- aldex.senAnalysis(clr, gamma = gamma_to_test)

## ----senAnalysis2, message = FALSE--------------------------------------------
length(sen_res)
length(gamma_to_test)

head(sen_res[[1]])

## ----senAnalysis3, message = FALSE--------------------------------------------
##Plotting
plotGamma(sen_res, thresh = .1)

## ----session------------------------------------------------------------------
sessionInfo()

