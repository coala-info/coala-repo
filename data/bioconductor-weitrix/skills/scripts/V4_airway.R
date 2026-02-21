# Code example from 'V4_airway' vignette. See references/ for full tutorial.

## ----echo=F-------------------------------------------------------------------
# To examine objects:
# devtools::load_all(".", export_all=F) ; qwraps2::lazyload_cache_dir("vignettes/V4_airway/html")

knitr::opts_chunk$set(cache=TRUE, autodep=TRUE)

## ----setup, warning=F, message=F, cache=FALSE---------------------------------
library(weitrix)
library(ComplexHeatmap)
library(EnsDb.Hsapiens.v86)
library(edgeR)
library(limma)
library(reshape2)
library(tidyverse)
library(airway)

set.seed(1234)

# BiocParallel supports multiple backends. 
# If the default hangs or errors, try others.
# The most reliable backed is to use serial processing
BiocParallel::register( BiocParallel::SerialParam() )

## -----------------------------------------------------------------------------
data("airway")
airway

## -----------------------------------------------------------------------------
counts <- assay(airway,"counts")

design <- model.matrix(~ dex + cell, data=colData(airway))

good <- filterByExpr(counts, design=design) 
table(good)

airway_dgelist <- DGEList(counts[good,]) %>% calcNormFactors()

airway_lcpm <- cpm(airway_dgelist, log=TRUE, prior.count=1)

## -----------------------------------------------------------------------------
airway_weitrix <- as_weitrix(airway_lcpm)

# Include row and column information
colData(airway_weitrix) <- colData(airway)
rowData(airway_weitrix) <- 
    mcols(genes(EnsDb.Hsapiens.v86))[rownames(airway_weitrix),c("gene_name","gene_biotype")]

airway_weitrix

## -----------------------------------------------------------------------------
fit <- weitrix_components(airway_weitrix, design=design)

## -----------------------------------------------------------------------------
weitrix_calplot(airway_weitrix, fit, covar=mu, guides=FALSE)

## -----------------------------------------------------------------------------
airway_cal <- weitrix_calibrate_all(
    airway_weitrix, 
    design = fit, 
    trend_formula = ~well_knotted_spline(mu,5))

metadata(airway_cal)

weitrix_calplot(airway_cal, fit, covar=mu)

## -----------------------------------------------------------------------------
weitrix_calplot(airway_cal, fit, funnel=TRUE)

## ----fig.height=8-------------------------------------------------------------
weitrix_calplot(airway_cal, fit, covar=mu, cat=col)

## ----eval=FALSE---------------------------------------------------------------
# airway_cal <- weitrix_calibrate_all(
#     airway_weitrix,
#     design = fit,
#     trend_formula = ~col*well_knotted_spline(mu,4))

## -----------------------------------------------------------------------------
airway_voomed <- voom(airway_dgelist, design, plot=TRUE)

weitrix_calplot(airway_voomed, design, covar=mu)

## ----warning=FALSE------------------------------------------------------------
confects <- weitrix_sd_confects(airway_cal)
confects

## ----warning=FALSE------------------------------------------------------------
confects2 <- weitrix_sd_confects(airway_cal, assume_normal=FALSE)
confects2

## -----------------------------------------------------------------------------
interesting <- confects$table$index[1:20]

centered <- weitrix_x(airway_cal) - rowMeans(weitrix_x(airway_cal))
rownames(centered) <- rowData(airway_cal)$gene_name
Heatmap(
    centered[interesting,], 
    name="log2 RPM\nvs row mean", 
    cluster_columns=FALSE)

## ----message=F----------------------------------------------------------------
comp_seq <- weitrix_components_seq(airway_cal, p=6, n_restarts=1)
comp_seq

## ----message=F----------------------------------------------------------------
rand_weitrix <- weitrix_randomize(airway_cal)
rand_comp <- weitrix_components(rand_weitrix, p=1, n_restarts=1)

components_seq_screeplot(comp_seq, rand_comp)

## -----------------------------------------------------------------------------
comp <- comp_seq[[4]]

comp$col[,-1] %>% melt(varnames=c("Run","component")) %>%
    left_join(as.data.frame(colData(airway)), by="Run") %>%
    ggplot(aes(y=cell, x=value, color=dex)) + 
    geom_vline(xintercept=0) + 
    geom_point(alpha=0.5, size=3) + 
    facet_grid(~ component) +
    labs(title="Sample scores for each component", x="Sample score", y="Cell line", color="Treatment")

comp$row[,-1] %>% melt(varnames=c("name","component")) %>%
    ggplot(aes(x=comp$row[name,"(Intercept)"], y=value)) + 
    geom_point(cex=0.5, alpha=0.5) + 
    facet_wrap(~ component) +
    labs(title="Gene loadings for each component vs average log2 RPM", x="average log2 RPM", y="gene loading")

## ----message=F----------------------------------------------------------------
comp_nonvarimax <- weitrix_components(airway_cal, p=4, use_varimax=FALSE)

comp_nonvarimax$col[,-1] %>% melt(varnames=c("Run","component")) %>%
    left_join(as.data.frame(colData(airway)), by="Run") %>%
    ggplot(aes(y=cell, x=value, color=dex)) + 
    geom_vline(xintercept=0) + 
    geom_point(alpha=0.5, size=3) + 
    facet_grid(~ component) +
    labs(title="Sample scores for each component, no varimax rotation", x="Sample score", y="Cell line", color="Treatment")

## -----------------------------------------------------------------------------
weitrix_confects(airway_cal, comp$col, "C1")

## -----------------------------------------------------------------------------
airway_elist <- weitrix_elist(airway_cal)

fit <- 
    lmFit(airway_elist, comp$col) %>% 
    eBayes()

fit$df.prior
fit$s2.prior

topTable(fit, "C1")

all_top <- topTable(fit, "C1", n=Inf, sort.by="none")
plotMD(fit, "C1", status=all_top$adj.P.Val <= 0.01)

