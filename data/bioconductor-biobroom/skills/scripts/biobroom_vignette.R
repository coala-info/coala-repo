# Code example from 'biobroom_vignette' vignette. See references/ for full tutorial.

## ----global_options, include=FALSE, echo=FALSE--------------------------------
knitr::opts_chunk$set(fig.width=12, fig.height=6, out.width='700in', out.height='350in', 
                      echo=TRUE, warning=FALSE, message=FALSE, cache=FALSE, dev='png')

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("biobroom")

## ----eval=FALSE---------------------------------------------------------------
# library(biobroom)
# ?edgeR_tidiers
# ?DESeq2_tidiers
# ?limma_tidiers
# ?ExpressionSet_tidiers
# ?MSnSet_tidiers
# ?qvalue_tidiers

## -----------------------------------------------------------------------------
library(qvalue)
data(hedenfalk)

qobj <- qvalue(hedenfalk$p)
names(qobj)

## -----------------------------------------------------------------------------
library(biobroom)
# use tidy/augment/glance to restructure the qvalue object
head(tidy(qobj))
head(augment(qobj))
head(glance(qobj))

## -----------------------------------------------------------------------------
# create sample names
df <- data.frame(gene = 1:length(hedenfalk$p))
head(augment(qobj, data = df))

## -----------------------------------------------------------------------------
library(ggplot2)
# use augmented data to compare p-values to q-values
ggplot(augment(qobj), aes(p.value, q.value)) + geom_point() +
  ggtitle("Simulated P-values versus Computed Q-values") + theme_bw()

## -----------------------------------------------------------------------------
library(dplyr)

# Find significant genes under 0.05 threshold
sig.genes <- augment(qobj) %>% filter(q.value < 0.05)
head(sig.genes)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("airway")

## -----------------------------------------------------------------------------
library(DESeq2)
library(airway)

data(airway)
airway_se <- airway

## -----------------------------------------------------------------------------
airway_dds <- DESeqDataSet(airway_se, design = ~cell + dex)

head(tidy(airway_dds))

## -----------------------------------------------------------------------------
# differential expression analysis
deseq <- DESeq(airway_dds)
results <- results(deseq)
# tidy results
tidy_results <- tidy(results)
head(tidy_results)

## -----------------------------------------------------------------------------
ggplot(tidy_results, aes(x=estimate, y=log(p.value),
                         color=log(baseMean))) + geom_point(alpha=0.5) +
  ggtitle("Volcano Plot For Airway Data via DESeq2") + theme_bw()

## -----------------------------------------------------------------------------
library(edgeR)
data(hammer)

hammer.counts <- Biobase::exprs(hammer)[, 1:4]
hammer.treatment <- Biobase::phenoData(hammer)$protocol[1:4]

y <- DGEList(counts=hammer.counts,group=hammer.treatment)
y <- calcNormFactors(y)
y <- estimateCommonDisp(y)
y <- estimateTagwiseDisp(y)
et <- exactTest(y)

## -----------------------------------------------------------------------------
head(tidy(et))

## -----------------------------------------------------------------------------
glance(et, alpha = 0.05)

## -----------------------------------------------------------------------------
ggplot(tidy(et), aes(x=estimate, y=log(p.value), color=logCPM)) +
  geom_point(alpha=0.5) + ggtitle("Volcano Plot for Hammer Data via EdgeR") +
  theme_bw()

## -----------------------------------------------------------------------------
# create random data and design
dat <- matrix(rnorm(1000), ncol=4)
dat[, 1:2] <- dat[, 1:2] + .5  # add an effect
rownames(dat) <- paste0("g", 1:nrow(dat))
des <- data.frame(treatment = c("a", "a", "b", "b"),
                  confounding = rnorm(4))

## -----------------------------------------------------------------------------
lfit <- lmFit(dat, model.matrix(~ treatment + confounding, des))
eb <- eBayes(lfit)

head(tidy(lfit))
head(tidy(eb))

## -----------------------------------------------------------------------------
ggplot(tidy(eb), aes(x=estimate, y=log(p.value), color=statistic)) + 
  geom_point() + ggtitle("Nested Volcano Plots for Simulated Data Processed with limma") +
  theme_bw()
  

## -----------------------------------------------------------------------------
library(Biobase)

head(tidy(hammer))

## -----------------------------------------------------------------------------
head(tidy(hammer, addPheno = TRUE))

## -----------------------------------------------------------------------------
ggplot(tidy(hammer, addPheno=TRUE), aes(x=protocol, y=log(value))) +
  geom_boxplot() + ggtitle("Boxplot Showing Effect of Protocol on Expression")

## -----------------------------------------------------------------------------
library(MSnbase)
data(msnset)

head(tidy(msnset))

head(tidy(msnset, addPheno = TRUE))

## ----eval=FALSE---------------------------------------------------------------
# options(biobroom.return = "data.frame")
# options(biobroom.return = "data.table")

