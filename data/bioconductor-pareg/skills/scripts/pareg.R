# Code example from 'pareg' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
#  if (!require("BiocManager", quietly = TRUE)) {
#    install.packages("BiocManager")
#  }
#  BiocManager::install("pareg")

## ----message=FALSE------------------------------------------------------------
library(ggraph)
library(tidyverse)
library(ComplexHeatmap)
library(enrichplot)

library(pareg)

set.seed(42)

## -----------------------------------------------------------------------------
group_num <- 2
pathways_from_group <- 10

gene_groups <- purrr::map(seq(1, group_num), function(group_idx) {
  glue::glue("g{group_idx}_gene_{seq_len(15)}")
})
genes_bg <- paste0("bg_gene_", seq(1, 50))

df_terms <- purrr::imap_dfr(
  gene_groups,
  function(current_gene_list, gene_list_idx) {
    purrr::map_dfr(seq_len(pathways_from_group), function(pathway_idx) {
      data.frame(
        term = paste0("g", gene_list_idx, "_term_", pathway_idx),
        gene = c(
          sample(current_gene_list, 10, replace = FALSE),
          sample(genes_bg, 10, replace = FALSE)
        )
      )
    })
  }
)

df_terms %>%
  sample_n(5)

## -----------------------------------------------------------------------------
mat_similarities <- compute_term_similarities(
  df_terms,
  similarity_function = jaccard
)

hist(mat_similarities, xlab = "Term similarity")

## -----------------------------------------------------------------------------
Heatmap(
  mat_similarities,
  name = "Similarity",
  col = circlize::colorRamp2(c(0, 1), c("white", "black"))
)

## -----------------------------------------------------------------------------
active_terms <- similarity_sample(mat_similarities, 5)
active_terms

## -----------------------------------------------------------------------------
de_genes <- df_terms %>%
  filter(term %in% active_terms) %>%
  distinct(gene) %>%
  pull(gene)

other_genes <- df_terms %>%
  distinct(gene) %>%
  pull(gene) %>%
  setdiff(de_genes)

## -----------------------------------------------------------------------------
df_study <- data.frame(
  gene = c(de_genes, other_genes),
  pvalue = c(rbeta(length(de_genes), 0.1, 1), rbeta(length(other_genes), 1, 1)),
  in_study = c(
    rep(TRUE, length(de_genes)),
    rep(FALSE, length(other_genes))
  )
)

table(
  df_study$pvalue <= 0.05,
  df_study$in_study, dnn = c("sig. p-value", "in study")
)

## -----------------------------------------------------------------------------
fit <- pareg(
  df_study %>% select(gene, pvalue),
  df_terms,
  network_param = 1, term_network = mat_similarities
)

## -----------------------------------------------------------------------------
fit %>%
  as.data.frame() %>%
  arrange(desc(abs(enrichment))) %>%
  head() %>%
  knitr::kable()

## -----------------------------------------------------------------------------
plot(fit, min_similarity = 0.1)

## -----------------------------------------------------------------------------
obj <- as_enrichplot_object(fit)

dotplot(obj) +
  scale_colour_continuous(name = "Enrichment Score")
treeplot(obj) +
  scale_colour_continuous(name = "Enrichment Score")

## -----------------------------------------------------------------------------
sessionInfo()

