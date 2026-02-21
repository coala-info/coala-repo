# Code example from 'MW_ST000629_enrichment' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("fobitools")

## ----warning = FALSE, message = FALSE, comment = FALSE------------------------
library(fobitools)

## ----warning = FALSE, message = FALSE, comment = FALSE------------------------
# CRAN
library(tidyverse)
library(ggrepel)
library(kableExtra)

# Bioconductor
library(POMA)
library(metabolomicsWorkbenchR)
library(SummarizedExperiment)

## ----warning = FALSE, message = FALSE, comment = FALSE------------------------
data <- do_query(
  context = "study",
  input_item = "analysis_id",
  input_value = "AN000961",
  output_item = "SummarizedExperiment")

## ----warning = FALSE, message = FALSE, comment = FALSE------------------------
## features 
features <- assay(data)
rownames(features) <- rowData(data)$metabolite

## metadata
pdata <- colData(data) %>%
  as.data.frame() %>%
  tibble::rownames_to_column("ID") %>%
  relocate(grouping, .before = Sodium.level) %>%
  mutate(grouping = case_when(grouping == "A(salt sensitive)" ~ "A",
                              grouping == "B(salt insensitive)" ~ "B"))

## ----warning = FALSE, message = FALSE, comment = FALSE------------------------
data_sumexp <- PomaCreateObject(metadata = pdata, features = t(features))

## ----warning = FALSE, message = FALSE, comment = FALSE------------------------
data_preprocessed <- data_sumexp %>%
  PomaImpute(group_by = "grouping") %>%
  PomaNorm()

## ----warning = FALSE, message = FALSE, comment = FALSE------------------------
limma_res <- data_preprocessed %>%
  PomaLimma(contrast = "A-B", adjust = "fdr") %>%
  dplyr::rename(ID = feature)

# show the first 10 features
limma_res %>%
  dplyr::slice(1L:10L) %>%
  kbl(row.names = FALSE, booktabs = TRUE) %>%
  kable_styling(latex_options = c("striped"))

## ----warning = FALSE, message = FALSE, comment = FALSE, eval = FALSE----------
# cat(limma_res$ID, sep = "\n")

## ----MAconvertID, message = FALSE, warning = FALSE, comment = FALSE, echo = FALSE, fig.align = "center", out.width = "100%", fig.cap = 'Metabolite names conversion using MetaboAnalyst.'----
knitr::include_graphics("figure/MetaboAnalyst_convertID.png")

## ----warning = FALSE, message = FALSE, comment = FALSE, eval = FALSE----------
# ST000629_MetaboAnalyst_MapNames <- readr::read_delim("https://www.metaboanalyst.ca/MetaboAnalyst/resources/users/XXXXXXX/name_map.csv", delim = ",")

## ----warning = FALSE, message = FALSE, comment = FALSE, echo = FALSE----------
load("data/ST000629_MetaboAnalyst_MapNames.rda")

## ----warning = FALSE, message = FALSE, comment = FALSE------------------------
annotated_limma <- ST000629_MetaboAnalyst_MapNames %>%
  dplyr::rename(ID = Query) %>%
  dplyr::mutate(ID = tolower(ID)) %>% 
  dplyr::right_join(limma_res %>% 
                      dplyr::mutate(ID = tolower(ID)),
                    by = "ID")

limma_FOBI_names <- annotated_limma %>%
  dplyr::pull("KEGG") %>%
  fobitools::id_convert(to = "FOBI")

# show the ID conversion results
limma_FOBI_names %>%
  head() %>%
  kbl(row.names = FALSE, booktabs = TRUE) %>%
  kable_styling(latex_options = c("striped"))

## ----warning = FALSE, message = FALSE, comment = FALSE------------------------
limma_FOBI_names <- limma_FOBI_names %>%
  dplyr::right_join(annotated_limma, by = "KEGG") %>%
  dplyr::select(FOBI, KEGG, ID, log2FC, pvalue, adj_pvalue) %>%
  dplyr::arrange(-dplyr::desc(pvalue))

## ----warning = FALSE, message = FALSE, comment = FALSE------------------------
metaboliteList <- limma_FOBI_names$FOBI[limma_FOBI_names$pvalue < 0.05]
metaboliteUniverse <- limma_FOBI_names$FOBI

fobitools::ora(metaboliteList = metaboliteList,
               metaboliteUniverse = metaboliteUniverse,
               pvalCutoff = 1) %>%
  kbl(row.names = FALSE, booktabs = TRUE) %>%
  kable_styling(latex_options = c("striped"))

## ----warning = FALSE, message = FALSE, comment = FALSE------------------------
limma_FOBI_msea <- limma_FOBI_names %>%
  select(FOBI, pvalue) %>%
  filter(!is.na(FOBI)) %>%
  dplyr::arrange(-dplyr::desc(abs(pvalue)))

FOBI_msea <- as.vector(limma_FOBI_msea$pvalue)
names(FOBI_msea) <- limma_FOBI_msea$FOBI

msea_res <- fobitools::msea(FOBI_msea, pvalCutoff = 1)

msea_res %>%
  kbl(row.names = FALSE, booktabs = TRUE) %>%
  kable_styling(latex_options = c("striped"))

## ----warning = FALSE, message = FALSE, comment = FALSE, fig.width = 12, fig.height = 8----
ggplot(msea_res, aes(x = -log10(pval), y = NES, color = NES, size = classSize, label = className)) +
  xlab("-log10(P-value)") +
  ylab("NES (Normalized Enrichment Score)") +
  geom_point() +
  ggrepel::geom_label_repel(color = "black", size = 7) +
  theme_bw() +
  theme(legend.position = "top",
        text = element_text(size = 22)) +
  scale_color_viridis_c() +
  scale_size(guide = "none")

## ----warning = FALSE, message = FALSE, comment = FALSE, fig.width = 12, fig.height = 10----
FOBI_terms <- msea_res %>%
  unnest(cols = leadingEdge)

fobitools::fobi %>%
  filter(FOBI %in% FOBI_terms$leadingEdge) %>%
  pull(id_code) %>%
  fobi_graph(get = "anc",
             labels = TRUE,
             legend = TRUE,
             labelsize = 6,
             legendSize = 20)

## -----------------------------------------------------------------------------
sessionInfo()

