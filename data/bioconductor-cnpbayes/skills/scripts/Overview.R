# Code example from 'Overview' vignette. See references/ for full tutorial.

## ----lib, message=FALSE----------------------------------------------------
library(CNPBayes)
library(SummarizedExperiment)
library(ggplot2)
library(tidyverse)

## ----find_cnps-------------------------------------------------------------
path <- system.file("extdata", package="CNPBayes")
se <- readRDS(file.path(path, "simulated_se.rds"))
grl <- readRDS(file.path(path, "grl_deletions.rds"))

## ----summary, message=FALSE------------------------------------------------
##cnv.region <- consensusCNP(grl, max.width=5e6)
cnv.region <- readRDS(file.path(path, "cnv_region.rds"))
i <- subjectHits(findOverlaps(cnv.region, rowRanges(se)))
med.summary <- matrixStats::colMedians(assays(se)[["cn"]][i, ], na.rm=TRUE)

## ----model_construction----------------------------------------------------
mp <- McmcParams(nStarts=5, burnin=500, iter=1000, thin=1)

## ----gibbs-----------------------------------------------------------------
model.list <- gibbs(model="SB", dat=med.summary, k_range=c(2, 3), mp=mp,
                    max_burnin=400, top=2)

## ----ggfunctions-----------------------------------------------------------
model <- model.list[[1]]
model
chains <- ggChains(model)
chains[[1]]
chains[[2]]

## ----posteriorPredictive---------------------------------------------------
## only one batch
full.data <- tibble(y=med.summary,
                    batch=paste("Batch 1"))
predictive <- posteriorPredictive(model) %>%
  mutate(batch=paste("Batch", batch),
         component=factor(component))
predictive$n <- 4000
predictive$component <- factor(predictive$component)
ggplot(predictive, aes(x=y, n_facet=n,
                       y=..count../n_facet,
                       fill=component)) +
  geom_histogram(data=full.data, aes(y, ..density..),
                 bins=400,
                 inherit.aes=FALSE,
                 color="gray70",
                 fill="gray70",
                 alpha=0.1) +
  geom_density(adjust=1, alpha=0.4, size=0.75, color="gray30") +
  ## show marginal density
  theme(panel.background=element_rect(fill="white"),
        axis.line=element_line(color="black"),
        legend.position="bottom",
        legend.direction="horizontal") +
  scale_y_sqrt() +
  xlab("average copy number") +
  ylab("density") +
  guides(color=FALSE)

## ----cn_model--------------------------------------------------------------
cn.model <- CopyNumberModel(model)
ggMixture(cn.model)

## ----probCopyNumber--------------------------------------------------------
probs <- probCopyNumber(cn.model)
head(probs)

## ----downsample------------------------------------------------------------
mb <- MultiBatchModelExample
full.data <- tibble(medians=y(mb),
                    plate=batch(mb),
                    batch_orig=as.character(batch(mb)))
partial.data <- downSample(full.data,
                           size=1000,
                           min.batchsize=50)
## confusingly, the downsampled data uses a different indexing for batch
plate.mapping <- partial.data %>%
  select(c(plate, batch_index)) %>%
  group_by(plate) %>%
  summarize(batch_index=unique(batch_index))

## ----fit_downsample--------------------------------------------------------
model <- gibbs(model="MB", k_range=c(3, 3),
               dat=partial.data$medians,
               batches=partial.data$batch_index,
               mp=mp)[[1]]

## ----upSample--------------------------------------------------------------
full.data2 <- left_join(full.data, plate.mapping, by="plate")
model.up <- upSample2(full.data2, model)
model.up
nrow(probz(model.up))
head(round(probz(model.up)), 2)

## ----copy-number-model-----------------------------------------------------
cn.model <- CopyNumberModel(model.up)
mapping(cn.model)
round(head(probz(cn.model)), 2)
round(head(probCopyNumber(cn.model)), 2)

