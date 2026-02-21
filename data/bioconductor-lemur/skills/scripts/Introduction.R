# Code example from 'Introduction' vignette. See references/ for full tutorial.

## ----setup_alt, include = FALSE-----------------------------------------------
if(! exists("..options_set") || isFALSE(..options_set)){
  knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    dpi = 40,
    fig_retina = 1,
    dev = "jpeg"
    # dev.args = list(quality = 20)
  )
  ..options_set <- TRUE
}

## ----preparation, echo=FALSE--------------------------------------------------
library(lemur)
set.seed(42)
data(glioblastoma_example_data)
sce <- glioblastoma_example_data[1:50,sample.int(5000, size = 500)]

## ----quick_start, message=FALSE, warning=FALSE--------------------------------
library("lemur")
library("SingleCellExperiment")

fit <- lemur(sce, design = ~ patient_id + condition, n_embedding = 15)
fit <- align_harmony(fit)   # This step is optional
fit <- test_de(fit, contrast = cond(condition = "ctrl") - cond(condition = "panobinostat"))
nei <- find_de_neighborhoods(fit, group_by = vars(patient_id, condition))

## ----load_packages, message=FALSE, warning=FALSE------------------------------
library("tidyverse")
library("SingleCellExperiment")
library("lemur")
set.seed(42)

## ----load_data----------------------------------------------------------------
data(glioblastoma_example_data)
glioblastoma_example_data

## ----raw_umap-----------------------------------------------------------------
orig_umap <- uwot::umap(as.matrix(t(logcounts(glioblastoma_example_data))))

as_tibble(colData(glioblastoma_example_data)) %>%
  mutate(umap = orig_umap) %>%
  ggplot(aes(x = umap[,1], y = umap[,2])) +
    geom_point(aes(color = patient_id, shape = condition), size = 0.5) +
    labs(title = "UMAP of logcounts")

## ----fit_lemur----------------------------------------------------------------
fit <- lemur(glioblastoma_example_data, design = ~ patient_id + condition, 
             n_embedding = 15, test_fraction = 0.5)

fit

## ----align_lemur--------------------------------------------------------------
fit <- align_harmony(fit)

## ----lemur_umap---------------------------------------------------------------
umap <- uwot::umap(t(fit$embedding))

as_tibble(fit$colData) %>%
  mutate(umap = umap) %>%
  ggplot(aes(x = umap[,1], y = umap[,2])) +
    geom_point(aes(color = patient_id), size = 0.5) +
    facet_wrap(vars(condition)) +
    labs(title = "UMAP of latent space from LEMUR")

## ----lemur_test_de------------------------------------------------------------
fit <- test_de(fit, contrast = cond(condition = "panobinostat") - cond(condition = "ctrl"))

## ----umap_de------------------------------------------------------------------
sel_gene <- "ENSG00000172020" # is GAP43

tibble(umap = umap) %>%
  mutate(de = assay(fit, "DE")[sel_gene,]) %>%
  ggplot(aes(x = umap[,1], y = umap[,2])) +
    geom_point(aes(color = de)) +
    scale_color_gradient2() +
    labs(title = "Differential expression on UMAP plot")

## ----de_neighborhoods, paged.print=FALSE--------------------------------------
neighborhoods <- find_de_neighborhoods(fit, group_by = vars(patient_id, condition))

as_tibble(neighborhoods) %>%
  left_join(as_tibble(rowData(fit)[,1:2]), by = c("name" = "gene_id")) %>%
  relocate(symbol, .before = "name") %>%
  arrange(pval) %>%
  dplyr::select(symbol, neighborhood, name, n_cells, pval, adj_pval, lfc, did_lfc) 

## ----umap_de2-----------------------------------------------------------------
sel_gene <- "ENSG00000169429" # is CXCL8

tibble(umap = umap) %>%
  mutate(de = assay(fit, "DE")[sel_gene,]) %>%
  ggplot(aes(x = umap[,1], y = umap[,2])) +
    geom_point(aes(color = de)) +
    scale_color_gradient2() +
    labs(title = "Differential expression on UMAP plot")

## ----umap_de3-----------------------------------------------------------------
neighborhood_coordinates <- neighborhoods %>%
  dplyr::filter(name == sel_gene) %>%
  unnest(c(neighborhood)) %>%
  dplyr::rename(cell_id = neighborhood) %>%
  left_join(tibble(cell_id = rownames(umap), umap), by = "cell_id") %>%
  dplyr::select(name, cell_id, umap)

tibble(umap = umap) %>%
  mutate(de = assay(fit, "DE")[sel_gene,]) %>%
  ggplot(aes(x = umap[,1], y = umap[,2])) +
    geom_point(aes(color = de)) +
    scale_color_gradient2() +
    geom_density2d(data = neighborhood_coordinates, breaks = 0.5, 
                   contour_var = "ndensity", color = "black") +
    labs(title = "Differential expression with neighborhood boundary")


## ----volcano_plot-------------------------------------------------------------
neighborhoods %>%
  drop_na() %>%
  ggplot(aes(x = lfc, y = -log10(pval))) +
    geom_point(aes(color  = adj_pval < 0.1)) +
    labs(title = "Volcano plot of the neighborhoods")

neighborhoods %>%
  drop_na() %>%
  ggplot(aes(x = n_cells, y = -log10(pval))) +
    geom_point(aes(color  = adj_pval < 0.1)) +
    labs(title = "Neighborhood size vs neighborhood significance")

## ----tumor_cell_annotation, paged.print=FALSE---------------------------------
tumor_label_df <- tibble(cell_id = colnames(fit),
       chr7_total_expr = colMeans(logcounts(fit)[rowData(fit)$chromosome == "7",]),
       chr10_total_expr = colMeans(logcounts(fit)[rowData(fit)$chromosome == "10",])) %>%
  mutate(is_tumor = chr7_total_expr > 0.8 & chr10_total_expr < 2.5)


ggplot(tumor_label_df, aes(x = chr10_total_expr, y = chr7_total_expr)) +
    geom_point(aes(color = is_tumor), size = 0.5) +
    geom_hline(yintercept = 0.8) +
    geom_vline(xintercept = 2.5) +
    labs(title = "Simple gating strategy to find tumor cells")

tibble(umap = umap) %>%
  mutate(is_tumor = tumor_label_df$is_tumor) %>%
  ggplot(aes(x = umap[,1], y = umap[,2])) +
    geom_point(aes(color = is_tumor), size = 0.5) +
    labs(title = "The tumor cells are enriched in parts of the big blob") +
    facet_wrap(vars(is_tumor))

## ----tumor_de_neighborhood, paged.print=FALSE---------------------------------
tumor_fit <- fit[, tumor_label_df$is_tumor]
tum_nei <- find_de_neighborhoods(tumor_fit, group_by = vars(patient_id, condition), verbose = FALSE)

as_tibble(tum_nei) %>%
  left_join(as_tibble(rowData(fit)[,1:2]), by = c("name" = "gene_id")) %>%
  dplyr::relocate(symbol, .before = "name") %>%
  filter(adj_pval < 0.1) %>%
  arrange(did_pval)  %>%
  dplyr::select(symbol, name, neighborhood, n_cells, adj_pval, lfc, did_pval, did_lfc) %>%
  print(n = 10)

## ----tumor_de_neighborhood_plot, paged.print=FALSE----------------------------
sel_gene <- "ENSG00000142534" # is RPS11

as_tibble(colData(fit)) %>%
  mutate(expr = assay(fit, "logcounts")[sel_gene,]) %>%
  mutate(is_tumor = tumor_label_df$is_tumor) %>%
  mutate(in_neighborhood = id %in% filter(tum_nei, name == sel_gene)$neighborhood[[1]]) %>%
  ggplot(aes(x = condition, y = expr)) +
    geom_jitter(size = 0.3, stroke = 0) +
    geom_point(data = . %>% summarize(expr = mean(expr), .by = c(condition, patient_id, is_tumor, in_neighborhood)),
               aes(color = patient_id), size = 2) +
    stat_summary(fun.data = mean_se, geom = "crossbar", color = "red") +
    facet_wrap(vars(is_tumor, in_neighborhood), labeller = label_both) 


## ----fix_linear_coef, message=FALSE, warning=FALSE----------------------------
fit <- lemur(sce, design = ~ patient_id + condition, n_embedding = 15, linear_coefficient_estimator = "zero")

## ----session_info-------------------------------------------------------------
sessionInfo()

