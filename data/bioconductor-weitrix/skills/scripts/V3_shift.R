# Code example from 'V3_shift' vignette. See references/ for full tutorial.

## ----echo=F-------------------------------------------------------------------
knitr::opts_chunk$set(cache=TRUE, autodep=TRUE)

# To examine objects:
# devtools::load_all(".", export_all=F) ; qwraps2::lazyload_cache_dir("vignettes/3_shift_cache/html")

## ----setup, message=F, warning=F, cache=FALSE---------------------------------
library(tidyverse)    # ggplot2, dplyr, etc
library(patchwork)    # side-by-side ggplots
library(reshape2)     # melt()
library(weitrix)      # Matrices with precision weights

# Produce consistent results
set.seed(12345)

# BiocParallel supports multiple backends. 
# If the default hangs or errors, try others.
# The most reliable backed is to use serial processing
BiocParallel::register( BiocParallel::SerialParam() )

## ----load, message=F, warning=F-----------------------------------------------
peaks <- system.file("GSE83162", "peaks.csv.gz", package="weitrix") %>%
    read.csv(check.names=FALSE)

counts <- system.file("GSE83162", "peak_count.csv.gz", package="weitrix") %>%
    read.csv(check.names=FALSE) %>%
    column_to_rownames("name") %>%
    as.matrix()

genes <- system.file("GSE83162", "genes.csv.gz", package="weitrix") %>%
    read.csv(check.names=FALSE) %>%
    column_to_rownames("name")
    
samples <- data.frame(sample=I(colnames(counts))) %>%
    extract(sample, c("strain","time"), c("(.+)-(.+)"), remove=FALSE) %>%
    mutate(
        strain=factor(strain,unique(strain)), 
        time=factor(time,unique(time)))
rownames(samples) <- samples$sample

groups <- dplyr::select(peaks, group=gene_name, name=name)
# Note the order of this data frame is important

## ----examine_raw--------------------------------------------------------------
samples

head(groups, 10)

counts[1:10,1:5]

## ----shift--------------------------------------------------------------------
wei <- counts_shift(counts, groups)

colData(wei) <- cbind(colData(wei), samples)
rowData(wei)$symbol <- genes$symbol[match(rownames(wei), rownames(genes))]

## ----comp, message=F----------------------------------------------------------
comp_seq <- weitrix_components_seq(wei, p=6, design=~0)

## ----scree--------------------------------------------------------------------
components_seq_screeplot(comp_seq)

## ----exam, fig.height=6-------------------------------------------------------
comp <- comp_seq[[4]]

matrix_long(comp$col, row_info=samples, varnames=c("sample","component")) %>%
    ggplot(aes(x=time, y=value, color=strain, group=strain)) + 
    geom_hline(yintercept=0) + 
    geom_line() + 
    geom_point(alpha=0.75, size=3) + 
    facet_grid(component ~ .) +
    labs(title="Sample scores for each component", y="Sample score", x="Time", color="Strain")

## ----calibrate_all------------------------------------------------------------
cal <- weitrix_calibrate_all(
    wei, 
    design = comp, 
    trend_formula = ~log(per_read_var)+well_knotted_spline(log2(weight),3))

metadata(cal)$weitrix$all_coef

## ----calibrate_all_fig1-------------------------------------------------------
(weitrix_calplot(wei, comp, covar=mu) + labs(title="Before")) +
(weitrix_calplot(cal, comp, covar=mu) + labs(title="After"))

## ----calibrate_all_fig2-------------------------------------------------------
(weitrix_calplot(wei, comp, covar=per_read_var) + labs(title="Before")) +
(weitrix_calplot(cal, comp, covar=per_read_var) + labs(title="After"))

## ----calibrate_all_fig3-------------------------------------------------------
(weitrix_calplot(wei, comp, covar=log(weitrix_weights(wei))) + labs(title="Before")) +
(weitrix_calplot(cal, comp, covar=log(weitrix_weights(wei))) + labs(title="After"))

## ----calibrate_all_fig4-------------------------------------------------------
(weitrix_calplot(wei, comp, funnel=TRUE, guides=FALSE) + labs(title="Before")) +
(weitrix_calplot(cal, comp, funnel=TRUE, guides=FALSE) + labs(title="After"))

## ----C1-----------------------------------------------------------------------
weitrix_confects(cal, comp$col, "C1", fdr=0.05)

## ----C2-----------------------------------------------------------------------
weitrix_confects(cal, comp$col, "C2", fdr=0.05)

## ----C3-----------------------------------------------------------------------
weitrix_confects(cal, comp$col, "C3", fdr=0.05)

## ----C4-----------------------------------------------------------------------
weitrix_confects(cal, comp$col, "C4", fdr=0.05)

## ----sdconfects---------------------------------------------------------------
weitrix_sd_confects(cal, step=0.01)

## ----examiner, message=F, warning=F, fig.show="hold", fig.height=3------------
examine <- function(gene_wanted, title) {
    peak_names <- filter(peaks, gene_name==gene_wanted)$name

    counts[peak_names,] %>% melt(value.name="reads", varnames=c("peak","sample")) %>%
        left_join(samples, by="sample") %>%
        ggplot(aes(x=factor(as.integer(peak)), y=reads)) + 
        facet_grid(strain ~ time) + geom_col() +
        labs(x="Peak",y="Reads",title=title)
}

examine("YLR058C", "SHM2, from C1")
examine("YLR333C", "RPS25B, from C2")
examine("YDR077W", "SED1, from C3")
examine("YIL015W", "BAR1, from C4")
examine("tK(CUU)M", "tK(CUU)M, from C4")
examine("YKL081W", "TEF4, from weitrix_sd_confects")
examine("YPR080W", "TEF1, from weitrix_sd_confects")

## ----calibrate----------------------------------------------------------------
cal_trend <- weitrix_calibrate_trend(
    wei, 
    design = comp, 
    trend_formula = ~log(per_read_var)+well_knotted_spline(log(total_reads),3))

## ----calibrate_trend_fig1-----------------------------------------------------
(weitrix_calplot(wei, comp, covar=mu) + labs(title="Before")) +
(weitrix_calplot(cal_trend, comp, covar=mu) + labs(title="After"))

## ----calibrate_trend_fig2-----------------------------------------------------
(weitrix_calplot(wei, comp, covar=per_read_var) + labs(title="Before")) +
(weitrix_calplot(cal_trend, comp, covar=per_read_var) + labs(title="After"))

## ----calibrate_trend_fig3-----------------------------------------------------
(weitrix_calplot(wei, comp, covar=log(weitrix_weights(wei))) + labs(title="Before")) +
(weitrix_calplot(cal_trend, comp, covar=log(weitrix_weights(wei))) + labs(title="After"))

