# Code example from 'V2_tail_length' vignette. See references/ for full tutorial.

## ----echo=F-------------------------------------------------------------------
knitr::opts_chunk$set(cache=TRUE, autodep=TRUE)

# To examine objects:
# devtools::load_all(".", export_all=F) ; qwraps2::lazyload_cache_dir("vignettes/V2_tail_length_cache/html")

## ----setup, message=F, warning=F, cache=FALSE---------------------------------
library(tidyverse)     # ggplot2, etc
library(patchwork)     # side-by-side plots
library(limma)         # differential testing
library(topconfects)   # differential testing - top confident effect sizes
library(org.Sc.sgd.db) # Yeast organism info
library(weitrix)       # Matrices with precisions weights

# Produce consistent results
set.seed(12345)

# BiocParallel supports multiple backends. 
# If the default hangs or errors, try others.
# The most reliable backed is to use serial processing
BiocParallel::register( BiocParallel::SerialParam() )

## ----load, message=F----------------------------------------------------------
tail <- system.file("GSE83162", "tail.csv.gz", package="weitrix") %>%
    read.csv(check.names=FALSE) %>%
    column_to_rownames("Feature") %>%
    as.matrix()

tail_count <- system.file("GSE83162", "tail_count.csv.gz", package="weitrix") %>%
    read.csv(check.names=FALSE) %>%
    column_to_rownames("Feature") %>%
    as.matrix()
    
samples <- data.frame(sample=I(colnames(tail))) %>%
    extract(sample, c("strain","time"), c("(.+)-(.+)"), remove=FALSE) %>%
    mutate(
        strain=factor(strain,unique(strain)), 
        time=factor(time,unique(time)))
rownames(samples) <- colnames(tail)

samples

## ----weitrix, message=FALSE---------------------------------------------------
good <- rowMeans(tail_count) >= 10
table(good)

wei <- as_weitrix(
    tail[good,,drop=FALSE], 
    weights=tail_count[good,,drop=FALSE])

rowData(wei)$gene <- AnnotationDbi::select(
    org.Sc.sgd.db, keys=rownames(wei), columns=c("GENENAME"))$GENENAME
rowData(wei)$total_reads <- rowSums(weitrix_weights(wei))
colData(wei) <- cbind(colData(wei), samples)

## ----cal1---------------------------------------------------------------------
design <- model.matrix(~ strain + time, data=colData(wei))
fit <- weitrix_components(wei, design=design)

## ----cal2---------------------------------------------------------------------
cal <- weitrix_calibrate_all(
    wei, 
    design = fit, 
    trend_formula = ~well_knotted_spline(mu,3)+well_knotted_spline(log(weight),3))

## ----unwei--------------------------------------------------------------------
unwei <- wei
weitrix_weights(unwei) <- weitrix_weights(unwei) > 0 
# (missing data still needs weight 0)

## ----cal-fig1-----------------------------------------------------------------
weitrix_calplot(unwei, fit, covar=mu, guides=FALSE) + labs(title="Unweighted\n") |
weitrix_calplot(wei, fit, covar=mu, guides=FALSE) + labs(title="Weighted by\nread count") |
weitrix_calplot(cal, fit, covar=mu, guides=FALSE) + labs(title="Calibrated\n")

## ----cal-fig2-----------------------------------------------------------------
weitrix_calplot(unwei, fit, covar=log(weitrix_weights(wei)), guides=FALSE) + labs(title="Unweighted\n") |
weitrix_calplot(wei, fit, covar=log(weitrix_weights(wei)), guides=FALSE) + labs(title="Weighted by\nread count") |
weitrix_calplot(cal, fit, covar=log(weitrix_weights(wei)), guides=FALSE) + labs(title="Calibrated\n")

## ----testconfects-------------------------------------------------------------
weitrix_confects(cal, design, coef="strainDeltaSet1", fdr=0.05)

## ----testcohen----------------------------------------------------------------
weitrix_confects(cal, design, coef="strainDeltaSet1", effect="cohen_f", fdr=0.05)

## ----limmadesign--------------------------------------------------------------
fit_cal_design <- cal %>%
    weitrix_elist() %>%
    lmFit(design)

ebayes_fit <- eBayes(fit_cal_design)

topTable(ebayes_fit, "strainDeltaSet1", n=10) %>%
    dplyr::select(
        gene,diff_tail=logFC,ave_tail=AveExpr,adj.P.Val,total_reads)

## ----testf--------------------------------------------------------------------
multiple_contrasts <- limma::makeContrasts(
    timet15m-timet0m, timet30m-timet15m, timet45m-timet30m, 
    timet60m-timet45m,  timet75m-timet60m, timet90m-timet75m, 
    timet105m-timet90m, timet120m-timet105m, 
    levels=design)

weitrix_confects(cal, design, contrasts=multiple_contrasts, fdr=0.05)

## ----examine, fig.height=6----------------------------------------------------
view_gene <- function(id) {
    gene <- rowData(wei)[id,"gene"]
    if (is.na(gene)) gene <- ""
    tails <- weitrix_x(cal)[id,]
    std_errs <- weitrix_weights(cal)[id,] ^ -0.5
    ggplot(samples) +
        aes(x=time,color=strain,group=strain, 
            y=tails, ymin=tails-std_errs, ymax=tails+std_errs) +
        geom_errorbar(width=0.2) + 
        geom_hline(yintercept=0) + 
        geom_line() + 
        geom_point(aes(size=tail_count[id,])) +
        labs(x="Time", y="Tail length", size="Read count", title=paste(id,gene)) +
        theme(axis.text.x=element_text(angle=90, hjust=1, vjust=0.5))
}

caption <- plot_annotation(
    caption="Error bars show +/- one standard error of measurement.")

# Top confident differences between WT and deltaSet1
view_gene("YDR170W-A") +
view_gene("YIL015W") +
view_gene("YAR009C") +
view_gene("YJR027W/YJR026W") +
caption

# Top confident changes over time
view_gene("YNL036W") +
view_gene("YBL097W") +
view_gene("YBL016W") +
view_gene("YKR093W") +
caption

## ----echo=F,eval=F------------------------------------------------------------
# # Top "significant" genes
# view_gene("YDR170W-A")
# view_gene("YJR027W/YJR026W")
# view_gene("YIL015W")
# view_gene("YIL053W")
# 
# # topconfects has highlighted some genes with lower total reads
# view_gene("YCR014C")

## ----excess, warning=F--------------------------------------------------------
confects <- weitrix_sd_confects(cal, ~1)
confects

## ----excess2, echo=FALSE------------------------------------------------------
plot(effect ~ total_reads, data=confects$table, log="x", cex=0.5, col="gray",
   ylab="confect (black) and effect (gray)")
points(confect ~ total_reads, data=confects$table, cex=0.5)

confects$table$name[1:2] %>% map(view_gene) %>% purrr::reduce(`+`)
confects$table$name[3:4] %>% map(view_gene) %>% purrr::reduce(`+`)
confects$table$name[5:6] %>% map(view_gene) %>% purrr::reduce(`+`) + caption

## ----excess3, warning=F-------------------------------------------------------
confects2 <- weitrix_sd_confects(cal, ~time)
confects2

## ----excess4, echo=FALSE------------------------------------------------------
plot(effect ~ total_reads, data=confects2$table, log="x", cex=0.5, col="gray",
   ylab="confect (black) and effect (gray)")
points(confect ~ total_reads, data=confects2$table, cex=0.5)

confects2$table$name[1:2] %>% map(view_gene) %>% purrr::reduce(`+`)
confects2$table$name[3:4] %>% map(view_gene) %>% purrr::reduce(`+`)
confects2$table$name[5:6] %>% map(view_gene) %>% purrr::reduce(`+`) + caption

## ----comp, message=F----------------------------------------------------------
comp_seq <- weitrix_components_seq(cal, p=6)

## ----scree--------------------------------------------------------------------
components_seq_screeplot(comp_seq)

## ----exam---------------------------------------------------------------------
comp <- comp_seq[[3]]

matrix_long(comp$col[,-1], row_info=samples, varnames=c("sample","component")) %>%
    ggplot(aes(x=time, y=value, color=strain, group=strain)) + 
    geom_hline(yintercept=0) + 
    geom_line() + 
    geom_point(alpha=0.75, size=3) + 
    facet_grid(component ~ .) +
    labs(title="Sample scores for each component", y="Sample score", x="Time", color="Strain")

## ----C1-----------------------------------------------------------------------
result_C1 <- weitrix_confects(cal, comp$col, coef="C1")

## ----examine_C1, echo=FALSE, fig.height=6-------------------------------------
result_C1$table %>% 
    dplyr::select(gene,loading=effect,confect,total_reads) %>% 
    head(10)

cat(sum(!is.na(result_C1$table$confect)), 
    "genes significantly non-zero at FDR 0.05\n")

result_C1$table$name[1:4] %>% map(view_gene) %>% purrr::reduce(`+`) + caption

## ----C2-----------------------------------------------------------------------
result_C2 <- weitrix_confects(cal, comp$col, coef="C2")

## ----examine_C2, echo=FALSE, fig.height=6-------------------------------------
result_C2$table %>% 
    dplyr::select(gene,loading=effect,confect,total_reads) %>% 
    head(10)

cat(sum(!is.na(result_C2$table$confect)), 
    "genes significantly non-zero at FDR 0.05\n")

result_C2$table$name[1:4] %>% map(view_gene) %>% purrr::reduce(`+`) + caption

## ----C3-----------------------------------------------------------------------
result_C3 <- weitrix_confects(cal, comp$col, coef="C3")

## ----examine_C3, echo=FALSE, fig.height=6-------------------------------------
result_C3$table %>% 
    dplyr::select(gene,loading=effect,confect,total_reads) %>% 
    head(10)

cat(sum(!is.na(result_C3$table$confect)), 
    "genes significantly non-zero at FDR 0.05\n")

result_C3$table$name[1:4] %>% map(view_gene) %>% purrr::reduce(`+`) + caption

#view_gene("YDR461W") #MFA1

