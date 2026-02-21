# Code example from 'selectKSigs' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
library(BiocStyle)

## -----------------------------------------------------------------------------
library(HiLDA)
library(tidyr)
library(ggplot2)
library(dplyr)
inputFile <- system.file("extdata/esophageal.mp.txt.gz", package="HiLDA")
G <- hildaReadMPFile(inputFile, numBases=5, trDir=TRUE)

## -----------------------------------------------------------------------------
library(selectKSigs)
load(system.file("extdata/sample.rdata", package = "selectKSigs"))

## ----include=FALSE------------------------------------------------------------
set.seed(5)
results <- cv_PMSignature(G, Kfold = 3, nRep = 3, Klimit = 7)
print(results)

## -----------------------------------------------------------------------------
results$Kvalue <- seq_len(nrow(results)) + 1
results_df <- gather(results, Method, value, -Kvalue) %>% 
  group_by(Method) %>%
  mutate(xmin = which.min(value) + 1 - 0.1,
         xmax = which.min(value) + 1 + 0.1)

ggplot(results_df) +
  geom_point(aes(x = Kvalue, y = value, color = Method), size = 2) +
  facet_wrap(~ Method, scales = "free") + 
  geom_rect(mapping = aes(xmin = xmin, xmax = xmax, 
                          ymin = -Inf, ymax = Inf),
            fill = 'grey', alpha = 0.05) +
  theme_bw()+
  xlab("Number of signatures")

## -----------------------------------------------------------------------------
sessionInfo()

