# Code example from 'coseq' vignette. See references/ for full tutorial.

## ----fig.align = "center", out.width = "50%", echo=FALSE----------------------
knitr::include_graphics("coseq_hex.png")
options(rmarkdown.html_vignette.check_title = FALSE)

## ----eval=FALSE---------------------------------------------------------------
# run <- coseq(counts, K=2:25)
# summary(run)
# plot(run)

## ----eval=FALSE---------------------------------------------------------------
# clusters(run)

## ----eval=FALSE---------------------------------------------------------------
# assay(run)

## ----eval=FALSE---------------------------------------------------------------
# run <- coseq(counts, K=2:25, seed=12345)

## ----message=FALSE, warning=FALSE---------------------------------------------
library(coseq)
library(Biobase)
library(corrplot)

data("fietz")
counts <- exprs(fietz)
conds <- pData(fietz)$tissue

## Equivalent to the following:
## counts <- read.table("http://www.math.univ-toulouse.fr/~maugis/coseq/Fietz_mouse_counts.txt",
##                       header=TRUE)
## conds <- c(rep("CP",5),rep("SVZ",5),rep("VZ",5))

## ----eval=FALSE---------------------------------------------------------------
# run <- coseq(..., parallel=TRUE)

## -----------------------------------------------------------------------------
runLogCLR <- coseq(counts, K=2:25, transformation="logclr",norm="TMM", 
                      meanFilterCutoff=50, model="kmeans",
                   nstart=1, iter.max=10)

## -----------------------------------------------------------------------------
runArcsin <- coseq(counts, K=2:20, model="Normal", transformation="arcsin", 
                   meanFilterCutoff=200, iter=10)
runLogit <- coseq(counts, K=2:20, model="Normal", transformation="logit", 
                  meanFilterCutoff=200, verbose=FALSE, iter=10)

## -----------------------------------------------------------------------------
class(runArcsin)
runArcsin

## ----figure=TRUE, fig.width=6, fig.height=4-----------------------------------
compareICL(list(runArcsin, runLogit))

## ----figure=TRUE, fig.width=7, fig.height=7-----------------------------------
compareARI(runArcsin, K=8:12)

## -----------------------------------------------------------------------------
summary(runArcsin)

## ----fig.width=6, fig.height=4------------------------------------------------
## To obtain all plots
## plot(runArcsin)
plot(runArcsin, graphs="boxplots")
plot(runArcsin, graphs="boxplots", add_lines = FALSE)
plot(runArcsin, graphs="boxplots", conds=conds)
plot(runArcsin, graphs="boxplots", conds=conds, collapse_reps = "sum")
plot(runArcsin, graphs="profiles")

plot(runArcsin, graphs="probapost_boxplots")
plot(runArcsin, graphs="probapost_histogram")

## ----figure=TRUE, fig.width=4, fig.height=4-----------------------------------
rho <- NormMixParam(runArcsin)$rho
## Covariance matrix for cluster 1
rho1 <- rho[,,1]
colnames(rho1) <- rownames(rho1) <- paste0(colnames(rho1), "\n", conds)
corrplot(rho1)

## -----------------------------------------------------------------------------
labels <- clusters(runArcsin)
table(labels)
probapost <- assay(runArcsin)
head(probapost)

metadata(runArcsin)
likelihood(runArcsin)
nbCluster(runArcsin)
ICL(runArcsin)
model(runArcsin)
transformationType(runArcsin)

## -----------------------------------------------------------------------------
## arcsine-transformed normalized profiles
tcounts(runArcsin)

## normalized profiles
profiles(runArcsin)

## -----------------------------------------------------------------------------
fullres <- coseqFullResults(runArcsin)
class(fullres)
length(fullres)
names(fullres)

## ----message=FALSE, warning=FALSE---------------------------------------------
library(DESeq2)
dds <- DESeqDataSetFromMatrix(counts, DataFrame(group=factor(conds)), ~group)
dds <- DESeq(dds, test="LRT", reduced = ~1)
res <- results(dds)
summary(res)

## By default, alpha = 0.10
run <- coseq(dds, K=2:15, verbose=FALSE)

## The following two lines provide identical results
run <- coseq(dds, K=2:15, alpha=0.05)
run <- coseq(dds, K=2:15, subset=results(dds, alpha=0.05))

## ----message=FALSE, warning=FALSE---------------------------------------------
library(edgeR)
y <- DGEList(counts=counts, group=factor(conds))
y <- calcNormFactors(y)
design <- model.matrix(~conds)
y <- estimateDisp(y, design)

## edgeR: QLF test
fit <- glmQLFit(y, design)
qlf <- glmQLFTest(fit, coef=2)

## edgeR: LRT test
fit <- glmFit(y,design)
lrt <- glmLRT(fit,coef=2)

run <- coseq(counts, K=2:15, subset=lrt, alpha=0.1)
run <- coseq(counts, K=2:15, subset=qlf, alpha=0.1)

## ----fig.width=6, fig.height=4------------------------------------------------
## Simulate toy data, n = 300 observations
set.seed(12345)
countmat <- matrix(runif(300*10, min=0, max=500), nrow=300, ncol=10)
countmat <- countmat[which(rowSums(countmat) > 0),]
conds <- c(rep("A", 4), rep("B", 3), rep("D", 3))

## Run coseq
coexp <- coseq(object=countmat, K=2:15, iter=5, transformation="logclr",
                    model="kmeans", seed=12345)

## Original boxplot
p <- plot(coexp, graphs = "boxplots", conds = conds, 
     profiles_order = sort(unique(clusters(coexp)), decreasing=TRUE), 
     collapse_reps = "average",
     n_row = 3, n_col = 4)
p$boxplots

## ----fig.width=6, fig.height=4------------------------------------------------
library(ggplot2)
p$boxplot + 
  theme_bw() + 
  coord_fixed(ratio = 20) +
  theme(axis.ticks = element_line(color="black", size=1.5),
        axis.line = element_line(color="black", size=1.5),
        text = element_text(size = 15)) +
  scale_fill_brewer(type = "qual")

## ----eval=FALSE---------------------------------------------------------------
# ## Plot and summarize results
# p <- plot(coexp, graph = "boxplots")$boxplots
# library(ggforce)
# pdf("coseq_boxplots_by_page.pdf")
# for(k in seq_len(ncol(assay(coexp))))
#     print(p + facet_wrap_paginate(~labels, page = k, nrow = 1, ncol = 1))
# dev.off()

## ----message=FALSE------------------------------------------------------------
## Reproducible example
set.seed(12345)
countmat <- matrix(runif(300*8, min=0, max=500), nrow=300, ncol=8)
countmat <- countmat[which(rowSums(countmat) > 0),]
conds <- rep(c("A","C","B","D"), each=2)
colnames(countmat) <- factor(1:8)
run <- coseq(object=countmat, K=2:4, iter=5, model = "Normal",
             transformation = "arcsin")
 
## Problem: Conditions B and C are not in the same order in these graphics
p1 <- plot(run, graph = "boxplots", conds = conds)$boxplots
p2 <- plot(run, graph = "boxplots", conds = conds, 
           collapse_reps = "average")$boxplots
 
## Solution 1 ------------------------------------------------------
## Create a new plot
dat_adjust <- p2$data
dat_adjust$conds <- factor(dat_adjust$conds, levels = c("A", "C", "B", "D"))
gg_color <- function(n) {
    hues = seq(15, 375, length = n + 1)
    hcl(h = hues, l = 65, c = 100)[1:n]
}
## p3 and p1 have conditions in the same order now
p3 <- ggplot(dat_adjust, aes(x=conds, y=y_prof)) +
    geom_boxplot(aes(fill = conds)) +
    scale_fill_manual(name = "Conditions",
                        values = gg_color(4)[c(1,3,2,4)]) +
    stat_summary(fun=mean, geom="line", aes(group=1), colour="red")  +
    stat_summary(fun=mean, geom="point", colour="red") +
    scale_y_continuous(name="Average expression profiles") +
    scale_x_discrete(name="Conditions") +
    facet_wrap(~labels)
 
## Solution 2 -------------------------------------------------------
## Order samples by conditions in the count matrix before running coseq
 
countmat_order <- countmat[,order(conds)]
conds_order <- conds[order(conds)]
run_order <- coseq(object=countmat_order, K=2:4, iter=5, model = "Normal",
             transformation = "arcsin")
## p4 and p5 have conditions in the same order too
p4 <- plot(run_order, graph = "boxplots", conds = conds_order)$boxplots
p5 <- plot(run_order, graph = "boxplots", conds = conds_order, 
           collapse_reps = "average")$boxplots

## ----message = FALSE----------------------------------------------------------
# Simulate toy data, n = 300 observations, factorial 2x2 design ---------------
set.seed(12345)
counts <- round(matrix(runif(300*8, min=0, max=500), nrow=300, ncol=8))
factor_1 <- rep(c("A","B"), each=4)
factor_2 <- rep(c("C", "D"), times=4)
## Create some "differential expression" for each factor
counts[1:50, 1:4] <- 10*counts[1:50, 1:4]
counts[51:100, c(1,3,5,7)] <- 10*counts[51:100, c(1,3,5,7)]
design <- model.matrix(~factor_1 + factor_2)

## Option 1: edgeR analysis (here with the QLF test) with several contrasts-----
y <- DGEList(counts=counts)
y <- calcNormFactors(y)
y <- estimateDisp(y, design)
fit <- glmQLFit(y, design)
## Test of significance for factor_1
qlf_1 <- glmQLFTest(fit, coef=2)
## Test of significance for factor_2
qlf_2 <- glmQLFTest(fit, coef=3)
## Make sure to use sort.by = "none" in topTags so that the indices are in the 
##   same order! Also only keep unique indices
de_indices <- c(unique(
    which(topTags(qlf_1, sort.by = "none", n=Inf)$table$FDR < 0.05),
    which(topTags(qlf_2, sort.by = "none", n=Inf)$table$FDR < 0.05)
))
## Now run coseq on the subset of DE genes, using prev normalization factors
run <- coseq(counts, K=2:25, 
             normFactors = y$samples$norm.factors,
             subset = de_indices)

## Option 2: edgeR analysis with overall LRT test-------------------------------
y <- DGEList(counts=counts)
y <- calcNormFactors(y)
y <- estimateDisp(y, design)
fit <- glmQLFit(y, design)
qlf_any <- glmQLFTest(fit, coef=2:3)
##  Now run coseq directly on the edgeR output
run2 <- coseq(counts, K=2:25, subset=qlf_any, alpha=0.05)

