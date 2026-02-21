# Code example from 'introduction' vignette. See references/ for full tutorial.

## ----install-bioconductor, message=FALSE, eval=FALSE--------------------------
# if (!requireNamespace("BiocManager")) install.packages("BiocManager")
# BiocManager::install("tidybulk")

## ----install-github, message=FALSE, eval=FALSE--------------------------------
# devtools::install_github("stemangiola/tidybulk")

## ----setup-libraries-and-theme, echo=FALSE, include=FALSE---------------------
library(knitr)
library(dplyr)
library(tidyr)
library(tibble)
library(purrr)
library(magrittr)
library(forcats)
library(ggplot2)
library(ggrepel)
library(SummarizedExperiment)
library(tidybulk)

# Define theme
my_theme = 	
	theme_bw() +
	theme(
		panel.border = element_blank(),
		axis.line = element_line(),
		panel.grid.major = element_line(linewidth = 0.2),
		panel.grid.minor = element_line(linewidth = 0.1),
		text = element_text(size=12),
		legend.position="bottom",
		aspect.ratio=1,
		strip.background = element_blank(),
		axis.title.x  = element_text(margin = margin(t = 10, r = 10, b = 10, l = 10)),
		axis.title.y  = element_text(margin = margin(t = 10, r = 10, b = 10, l = 10))
	)

## ----load airway--------------------------------------------------------------
library(airway)
data(airway)

## ----load tidySummarizedExperiment--------------------------------------------
library(tidySummarizedExperiment)

## ----add-gene-symbol----------------------------------------------------------
library(org.Hs.eg.db)
library(AnnotationDbi)

# Add gene symbol and entrez
airway <-
  airway |>
  
  mutate(entrezid = mapIds(org.Hs.eg.db,
                                      keys = gene_name,
                                      keytype = "SYMBOL",
                                      column = "ENTREZID",
                                      multiVals = "first"
)) 



detach("package:org.Hs.eg.db", unload = TRUE)
detach("package:AnnotationDbi", unload = TRUE)

## ----data-overview------------------------------------------------------------
airway

## ----check-se-class-----------------------------------------------------------
class(airway)

## ----convert-condition-to-factor----------------------------------------------
# Convert dex to factor for proper differential expression analysis
airway = airway |>
  mutate(dex = as.factor(dex))

## ----plot-raw-counts, fig.width = 10, fig.height = 10-------------------------
airway |>
  ggplot(aes(counts + 1, group = .sample, color = dex)) +
  geom_density() +
  scale_x_log10() +
  my_theme +
  labs(title = "Raw counts by treatment (before any filtering)")

## ----preprocessing-aggregate-duplicates---------------------------------------
# Aggregate duplicates
airway = airway |> aggregate_duplicates(feature = "gene_name", aggregation_function = mean)

## ----filtering-abundance-methods----------------------------------------------
# Default (simple filtering)
airway_abundant_default = airway |> keep_abundant(minimum_counts = 10, minimum_proportion = 0.5)

# With factor_of_interest (recommended for complex designs)
airway_abundant_formula = airway |> keep_abundant(minimum_counts = 10, minimum_proportion = 0.5, factor_of_interest = dex)

# With CPM threshold (using design parameter)
airway_abundant_cpm = airway |> keep_abundant(minimum_count_per_million  = 10, minimum_proportion = 0.5, factor_of_interest = dex)


## ----filtering-summary-statistics, fig.width = 10, fig.height = 10, warning = FALSE----
# Example: summary for default tidybulk filtering
# Before filtering
airway |> summarise(
  n_features = n_distinct(.feature),
  min_count = min(counts),
  median_count = median(counts),
  max_count = max(counts)
)

# After filtering
airway_abundant_default |> summarise(
  n_features = n_distinct(.feature),
  min_count = min(counts),
  median_count = median(counts),
  max_count = max(counts)
)

airway_abundant_formula |> summarise(
  n_features = n_distinct(.feature),
  min_count = min(counts),
  median_count = median(counts),
  max_count = max(counts)
)

airway_abundant_cpm |> summarise(
  n_features = n_distinct(.feature),
  min_count = min(counts),
  median_count = median(counts),
  max_count = max(counts)
)

## ----filtering-density-plot-comparison, fig.width = 10, fig.height = 10-------
# Merge all methods into a single tibble
airway_abundant_all = 
  bind_rows(
    airway |> assay() |> as_tibble(rownames = ".feature") |> pivot_longer(cols = -.feature, names_to = ".sample", values_to = "counts") |> mutate(method = "no filter"),
    airway_abundant_default |> assay() |> as_tibble(rownames = ".feature") |> pivot_longer(cols = -.feature, names_to = ".sample", values_to = "counts") |> mutate(method = "default"),
    airway_abundant_formula |> assay() |> as_tibble(rownames = ".feature") |> pivot_longer(cols = -.feature, names_to = ".sample", values_to = "counts") |> mutate(method = "formula"),
    airway_abundant_cpm |> assay() |> as_tibble(rownames = ".feature") |> pivot_longer(cols = -.feature, names_to = ".sample", values_to = "counts") |> mutate(method = "cpm")
  )

# Density plot across methods
airway_abundant_all |> 
  ggplot(aes(counts + 1, group = .sample, color = method)) +
    geom_density() +
    scale_x_log10() +
    facet_wrap(~fct_relevel(method, "no filter", "default", "formula", "cpm")) +
    my_theme +
    labs(title = "Counts after abundance filtering (tidybulk default)")

## ----update-se-mini-with-filtered---------------------------------------------
airway = airway_abundant_formula

## ----preprocessing-remove-redundancy------------------------------------------
airway_non_redundant = 
  airway |> 
  remove_redundancy(method = "correlation", top = 100, of_samples = FALSE) 

  # Make  

airway |> summarise(
  n_features = n_distinct(.feature),
  min_count = min(counts),
  median_count = median(counts),
  max_count = max(counts)
)

# Summary statistics
airway_non_redundant |> summarise(
  n_features = n_distinct(.feature),
  min_count = min(counts),
  median_count = median(counts),
  max_count = max(counts)
)

# Plot before and after
# Merge before and after into a single tibble
airway_all = bind_rows(
  airway |> assay() |> as_tibble(rownames = ".feature") |> pivot_longer(cols = -.feature, names_to = ".sample", values_to = "counts") |>  mutate(method = "before"),
  airway_non_redundant |> assay() |> as_tibble(rownames = ".feature") |> pivot_longer(cols = -.feature, names_to = ".sample", values_to = "counts") |>  mutate(method = "after")
)

# Density plot
airway_all |>
  ggplot(aes(counts + 1, group = .sample, color = method)) +
  geom_density() +
  scale_x_log10() +
  facet_wrap(~fct_relevel(method, "before", "after")) +
  my_theme +
  labs(title = "Counts after removing redundant transcripts")


## ----filtering-keep-variable--------------------------------------------------
airway_variable = airway |> keep_variable()

## ----filtering-variable-summary-and-plot, fig.width = 10, fig.height = 10-----
# Before filtering
airway |> summarise(
  n_features = n_distinct(.feature),
  min_count = min(counts),
  median_count = median(counts),
  max_count = max(counts)
)

# After filtering
airway_variable |> summarise(
  n_features = n_distinct(.feature),
  min_count = min(counts),
  median_count = median(counts),
  max_count = max(counts)
)

# Density plot
# Merge before and after into a single tibble
airway_all = bind_rows(
  airway |> assay() |> as_tibble(rownames = ".feature") |> pivot_longer(cols = -.feature, names_to = ".sample", values_to = "counts") |> mutate(method = "before"),
  airway_variable |> assay() |> as_tibble(rownames = ".feature") |> pivot_longer(cols = -.feature, names_to = ".sample", values_to = "counts") |> mutate(method = "after")
)

# Density plot
airway_all |>
  ggplot(aes(counts + 1, group = .sample, color = method)) +
  geom_density() +
  scale_x_log10() +
  facet_wrap(~fct_relevel(method, "before", "after")) +
  my_theme +
  labs(title = "Counts after variable filtering")

## ----normalization-scale-abundance--------------------------------------------
airway = 
airway |> 
	scale_abundance(method = "TMM", suffix = "_tmm") |>
	scale_abundance(method = "upperquartile", suffix = "_upperquartile") |>
	scale_abundance(method = "RLE", suffix = "_RLE")


## ----normalization-visualize-scaling, fig.width = 10, fig.height = 10---------
# Before scaling
airway |> assay("counts") |> as.matrix() |> rowMeans() |> summary()

airway |> assay("counts_tmm") |> as.matrix() |> rowMeans() |> summary()

airway |> assay("counts_upperquartile") |> as.matrix() |> rowMeans() |> summary()

airway |> assay("counts_RLE") |> as.matrix() |> rowMeans() |> summary()

# Merge all methods into a single tibble
airway_scaled_all = bind_rows(
  airway |> assay("counts") |> as_tibble(rownames = ".feature") |> pivot_longer(cols = -.feature, names_to = ".sample", values_to = "counts") |> mutate(method = "no_scaling"),
  airway |> assay("counts_tmm") |> as_tibble(rownames = ".feature") |> pivot_longer(cols = -.feature, names_to = ".sample", values_to = "counts") |> mutate(method = "TMM"),
  airway |> assay("counts_upperquartile") |> as_tibble(rownames = ".feature") |> pivot_longer(cols = -.feature, names_to = ".sample", values_to = "counts") |> mutate(method = "upperquartile"),
  airway |> assay("counts_RLE") |> as_tibble(rownames = ".feature") |> pivot_longer(cols = -.feature, names_to = ".sample", values_to = "counts") |> mutate(method = "RLE")
)


# Density plot
airway_scaled_all |>
  ggplot(aes(counts + 1, group = .sample, color = method)) +
  geom_density() +
  scale_x_log10() +
  facet_wrap(~fct_relevel(method, "no_scaling", "TMM", "upperquartile", "RLE")) +
  my_theme +
  labs(title = "Scaled counts by method (after scaling)")

## ----eda-remove-zero-variance-------------------------------------------------
library(matrixStats)
# Remove features with zero variance across samples
airway = airway[rowVars(assay(airway)) > 0, ]

## ----eda-mds-analysis, fig.width = 10, fig.height = 10------------------------
airway = airway |>
  reduce_dimensions(method="MDS", .dims = 2)

## ----eda-pca-analysis, fig.width = 10, fig.height = 10------------------------
airway = airway |>
  reduce_dimensions(method="PCA", .dims = 2)

## ----eda-plot-dimensionality-reduction, fig.width = 10, fig.height = 10-------
# MDS plot
airway |>
	pivot_sample() |>
	ggplot(aes(x=`Dim1`, y=`Dim2`, color=`dex`)) +
  geom_point() +
	my_theme +
	labs(title = "MDS Analysis")

# PCA plot
	airway |>
	pivot_sample() |>
	ggplot(aes(x=`PC1`, y=`PC2`, color=`dex`)) +
	geom_point() +
	my_theme +
	labs(title = "PCA Analysis")

## ----eda-clustering-analysis, fig.width = 10, fig.height = 10-----------------
airway = airway |>
  cluster_elements(method="kmeans", centers = 2)

# Visualize clustering
	airway |>
	ggplot(aes(x=`Dim1`, y=`Dim2`, color=`cluster_kmeans`)) +
  geom_point() +
  my_theme +
  labs(title = "K-means Clustering")

## ----differential-expression-multiple-methods, message = FALSE----------------
# Standard differential expression analysis
airway = airway |>

# Use QL method
	test_differential_expression(~ dex, method = "edgeR_quasi_likelihood", prefix = "ql__") |>
	
	# Use edger_robust_likelihood_ratio
	test_differential_expression(~ dex, method = "edger_robust_likelihood_ratio", prefix = "lr_robust__") |>
	
# Use DESeq2 method
	test_differential_expression(~ dex, method = "DESeq2", prefix = "deseq2__") |>
	
	# Use limma_voom
	test_differential_expression(~ dex, method = "limma_voom", prefix = "voom__") |>

# Use limma_voom_sample_weights
	test_differential_expression(~ dex, method = "limma_voom_sample_weights", prefix = "voom_weights__") 



## ----differential-expression-edgeR-object-------------------------------------
library(edgeR)

metadata(airway)$tidybulk$edgeR_quasi_likelihood_object |>
  plotBCV()


## ----differential-expression-edgeR-fit----------------------------------------
library(edgeR)

metadata(airway)$tidybulk$edgeR_quasi_likelihood_fit |>
  plotMD()


## ----differential-expression-DESeq2-object------------------------------------
library(DESeq2)

metadata(airway)$tidybulk$DESeq2_object |>
  plotDispEsts()


## ----differential-expression-DESeq2-fit---------------------------------------
library(DESeq2)

metadata(airway)$tidybulk$DESeq2_object |>
  plotMA()


## ----differential-expression-pvalue-histograms, fig.width = 10, fig.height = 10----
	airway |>
  pivot_transcript() |>
  select(
    ql__PValue, 
    lr_robust__PValue, 
    voom__P.Value, 
    voom_weights__P.Value, 
    deseq2__pvalue
  ) |> 
  pivot_longer(everything(), names_to = "method", values_to = "pvalue") |>
  ggplot(aes(x = pvalue, fill = method)) +
  geom_histogram(binwidth = 0.01) +
  facet_wrap(~method) +
  my_theme +
  labs(title = "Histogram of p-values across methods")

## ----differential-expression-summary-statistics-------------------------------
# Summary statistics
airway |> 
  pivot_transcript() |> 
  select(contains("ql|lr_robust|voom|voom_weights|deseq2")) |> 
  select(contains("logFC")) |> 
  summarise(across(everything(), list(min = min, median = median, max = max), na.rm = TRUE))


## ----differential-expression-pvalue-pairplot, fig.width = 10, fig.height = 10, message = FALSE, warning=FALSE----

library(GGally)
airway |> 
  pivot_transcript() |> 
  select(ql__PValue, lr_robust__PValue, voom__P.Value, voom_weights__P.Value, deseq2__pvalue) |> 
  ggpairs(columns = 1:5, size = 0.5) +
  scale_y_log10_reverse() +
  scale_x_log10_reverse() +
  my_theme +
  labs(title = "Pairplot of p-values across methods")

## ----differential-expression-effectsize-pairplot, fig.width = 10, fig.height = 10, message = FALSE, warning=FALSE----
library(GGally)
airway |> 
  pivot_transcript() |> 
  select(ql__logFC, lr_robust__logFC, voom__logFC, voom_weights__logFC, deseq2__log2FoldChange) |> 
  ggpairs(columns = 1:5, size = 0.5) +
  my_theme +
  labs(title = "Pairplot of effect sizes across methods")

## ----differential-expression-volcano-plots-1, fig.width = 10, fig.height = 10----
# Create volcano plots
airway |>

	# Select the columns we want to plot
    pivot_transcript() |> 
    select(
			.feature,
      ql__logFC, ql__PValue,
      lr_robust__logFC, lr_robust__PValue,
      voom__logFC, voom__P.Value,
      voom_weights__logFC, voom_weights__P.Value,
      deseq2__log2FoldChange, deseq2__pvalue
    ) |>

	# Pivot longer to get a tidy data frame
	pivot_longer(
      - .feature,
      names_to = c("method", "stat"),
      values_to = "value", names_sep = "__"
    ) |>

	# Harmonize column names
	mutate(stat  = case_when(
		stat %in% c("logFC", "log2FoldChange") ~ "logFC",
		stat %in% c("PValue", "pvalue", "P.Value", "p.value") ~ "PValue"
	)) |>
  pivot_wider(names_from = "stat", values_from = "value") |>
  unnest(c(logFC, PValue)) |> 

	# Plot
  ggplot(aes(x = logFC, y = PValue)) +
  geom_point(aes(color = PValue < 0.05, size = PValue < 0.05)) +
  scale_y_log10_reverse() +
  scale_color_manual(values = c("TRUE" = "red", "FALSE" = "black")) +
  scale_size_manual(values = c("TRUE" = 0.5, "FALSE" = 0.1)) +
  facet_wrap(~method) +
  my_theme +
  labs(title = "Volcano Plots by Method")

## ----differential-expression-volcano-plots-2, fig.width = 10, fig.height = 10----
# Create volcano plots
airway |>

	# Select the columns we want to plot
    pivot_transcript() |> 
    select(
			symbol,
      ql__logFC, ql__PValue,
      lr_robust__logFC, lr_robust__PValue,
      voom__logFC, voom__P.Value,
      voom_weights__logFC, voom_weights__P.Value,
      deseq2__log2FoldChange, deseq2__pvalue
    ) |>

	# Pivot longer to get a tidy data frame
	pivot_longer(
      - symbol,
      names_to = c("method", "stat"),
      values_to = "value", names_sep = "__"
    ) |>

	# Harmonize column names
	mutate(stat  = case_when(
		stat %in% c("logFC", "log2FoldChange") ~ "logFC",
		stat %in% c("PValue", "pvalue", "P.Value", "p.value") ~ "PValue"
	)) |>
  pivot_wider(names_from = "stat", values_from = "value") |>
  unnest(c(logFC, PValue)) |> 

	# Plot
  ggplot(aes(x = logFC, y = PValue)) +
  geom_point(aes(color = PValue < 0.05, size = PValue < 0.05)) +
  ggrepel::geom_text_repel(aes(label = symbol), size = 2, max.overlaps = 20) +
  scale_y_log10_reverse() +
  scale_color_manual(values = c("TRUE" = "red", "FALSE" = "black")) +
  scale_size_manual(values = c("TRUE" = 0.5, "FALSE" = 0.1)) +
  facet_wrap(~method, scales = "free_y") +
  my_theme +
  labs(title = "Volcano Plots by Method")

## ----differential-expression-contrasts----------------------------------------
# Using contrasts for more complex comparisons
airway |>
	test_differential_expression(
		~ 0 + dex,                  
		contrasts  = c("dextrt - dexuntrt"),
        method = "edgeR_quasi_likelihood", 
		prefix = "contrasts__"
	) |> 

	# Print the gene statistics
  pivot_transcript() |>
  select(contains("contrasts"))

## ----differential-expression-contrasts-DESeq2---------------------------------
# Using contrasts for more complex comparisons
airway |>
	test_differential_expression(
		~ 0 + dex,                  
		contrasts  = list(c("dex", "trt", "untrt")),
		method = "DESeq2",
		prefix = "contrasts__"
  ) |>
  pivot_transcript() |>
  select(contains("contrasts"))

## ----differential-expression-contrasts-limma-voom-----------------------------
# Using contrasts for more complex comparisons
airway |>
	test_differential_expression(
		~ 0 + dex,                  
		contrasts  = c("dextrt - dexuntrt"),
		method = "limma_voom",
		prefix = "contrasts__"
	) |>
  pivot_transcript() |>
  select(contains("contrasts"))

## ----differential-expression-treat-method-------------------------------------
# Using contrasts for more complex comparisons
airway |>
	test_differential_expression(
		~ 0 + dex,                  
		contrasts  = c("dextrt - dexuntrt"),
        method = "edgeR_quasi_likelihood", 
		test_above_log2_fold_change = 2, 
		prefix = "treat__"
	) |> 

	# Print the gene statistics
  pivot_transcript() |>
  select(contains("treat"))

## ----differential-expression-mixed-models-------------------------------------
# Using glmmSeq for mixed models
airway |>
  keep_abundant(formula_design = ~ dex) |>
  
  # Select 100 genes in the interest of execution time
  _[1:100,] |>

  # Fit model
  test_differential_expression(
    ~ dex + (1|cell), 
    method = "glmmseq_lme4", 
    cores = 1,
	prefix = "glmmseq__"
  ) 

  airway |>
  pivot_transcript() 

## ----differential-expression-gene-description---------------------------------
# Add gene descriptions using the original SummarizedExperiment
airway |> 

	describe_transcript() |>

	# Filter top significant genes
	filter(ql__FDR < 0.05) |>

	# Print the gene statistics
	pivot_transcript() |> 
  filter(description |> is.na() |> not()) |>
	select(.feature, description, contains("ql")) |> 
	head()


## ----batch-correction-adjust-abundance----------------------------------------
# Adjust for batch effects
airway = airway |>
  adjust_abundance(
	  .factor_unwanted = cell, 
	  .factor_of_interest = dex, 
    method = "combat_seq", 
	  abundance = "counts_tmm"
  )

# Scatter plot of adjusted vs unadjusted
airway |> 
  
  # Subset genes to speed up plotting
  _[1:100,] |> 
  select(symbol, .sample, counts_tmm, counts_tmm_adjusted) |> 
  
  ggplot(aes(x = counts_tmm + 1, y = counts_tmm_adjusted + 1)) +
  geom_point(aes(color = .sample), size = 0.1) +
  ggrepel::geom_text_repel(aes(label = symbol), size = 2, max.overlaps = 20) +
  scale_x_log10() +
  scale_y_log10() +
  my_theme +
  labs(title = "Scatter plot of adjusted vs unadjusted")

## ----enrichment-gene-rank-analysis--------------------------------------------
# Run gene rank enrichment (GSEA style)
gene_rank_res =
  airway |>

    # Filter for genes with entrez IDs
  filter(!entrezid |> is.na()) |>
  aggregate_duplicates(feature = "entrezid") |> 

  # Test gene rank
  test_gene_rank(
    .entrez = entrezid,
    .arrange_desc = lr_robust__logFC,
    species = "Homo sapiens",
    gene_sets = c("H", "C2", "C5")
  )

## ----enrichment-inspect-significant-genesets----------------------------------
# Inspect significant gene sets (example for C2 collection)
gene_rank_res |>
  filter(gs_collection == "C2") |>
  dplyr::select(-fit) |>
  unnest(test) |>
  filter(p.adjust < 0.05)

## ----enrichment-visualize-gsea-plots------------------------------------------
  library(enrichplot)
  library(patchwork)
  gene_rank_res |>
    unnest(test) |>
    head() |>
    mutate(plot = pmap(
      list(fit, ID, idx_for_plotting, p.adjust),
      ~ enrichplot::gseaplot2(
        ..1, geneSetID = ..3,
        title = sprintf("%s \nadj pvalue %s", ..2, round(..4, 2)),
        base_size = 6, rel_heights = c(1.5, 0.5), subplots = c(1, 2)
      )
    )) |>
    pull(plot) 
detach("package:enrichplot", unload = TRUE)

## ----enrichment-gene-overrepresentation---------------------------------------
# Test gene overrepresentation
airway_overrep = 
  airway |>
  
  # Label genes to test overrepresentation of
  mutate(genes_to_test = ql__FDR < 0.05) |>
  
    # Filter for genes with entrez IDs
  filter(!entrezid |> is.na()) |>
  
  test_gene_overrepresentation(
    .entrez = entrezid,
    species = "Homo sapiens",
    .do_test = genes_to_test,
    gene_sets = c("H", "C2", "C5")
  )

  airway_overrep

## ----enrichment-egsea-analysis, eval=FALSE------------------------------------
# library(EGSEA)
# # Test gene enrichment
#   airway |>
# 
#   # Filter for genes with entrez IDs
#   filter(!entrezid |> is.na()) |>
#   aggregate_duplicates(feature = "entrezid") |>
# 
#   # Test gene enrichment
#   test_gene_enrichment(
#     .formula = ~dex,
#     .entrez = entrezid,
#     species = "human",
#     gene_sets = "h",
#     methods = c("roast"),  # Use a more robust method
#     cores = 2
#   )
# detach("package:EGSEA", unload = TRUE)

## ----deconvolution-examples---------------------------------------------------

airway = 
  airway |> 
  
  filter(!symbol |> is.na()) |> 
  deconvolve_cellularity(method = "cibersort", cores = 1, prefix = "cibersort__", feature_column = "symbol") 


## ----install-immunedeconv, eval=FALSE-----------------------------------------
# if (!requireNamespace("immunedeconv")) BiocManager::install("immunedeconv")

## ----deconvolution-examples2, eval=FALSE--------------------------------------
# 
# airway =
# 
# airway |>
# # Example using LLSR
# deconvolve_cellularity(method = "llsr", prefix = "llsr__", feature_column = "symbol") |>
# 
# # Example using EPIC
# deconvolve_cellularity(method = "epic", cores = 1, prefix = "epic__") |>
# 
# # Example using MCP-counter
# deconvolve_cellularity(method = "mcp_counter", cores = 1, prefix = "mcp__") |>
# 
# # Example using quanTIseq
# deconvolve_cellularity(method = "quantiseq", cores = 1, prefix = "quantiseq__") |>
# 
# # Example using xCell
# deconvolve_cellularity(method = "xcell", cores = 1, prefix = "xcell__")

## ----deconvolution-plotting, fig.width = 10, fig.height = 10------------------
# Visualize CIBERSORT results
airway	 |>
  pivot_sample() |>
  dplyr::select(.sample, contains("cibersort__")) |>
  pivot_longer(cols = -1, names_to = "Cell_type_inferred", values_to = "proportion") |>
  ggplot(aes(x = .sample, y = proportion, fill = Cell_type_inferred)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(labels = scales::percent) +
  my_theme +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
  labs(title = "CIBERSORT Cell Type Proportions")


## ----deconvolution-plotting2, fig.width = 10, fig.height = 10, eval=FALSE-----
# 
#  # Repeat similar plotting for LLSR, EPIC, MCP-counter, quanTIseq, and xCell
# airway	 |>
#   pivot_sample() |>
#   select(.sample, contains("llsr__")) |>
#   pivot_longer(cols = -1, names_to = "Cell_type_inferred", values_to = "proportion") |>
#   ggplot(aes(x = .sample, y = proportion, fill = Cell_type_inferred)) +
#   geom_bar(stat = "identity") +
#   scale_y_continuous(labels = scales::percent) +
#   my_theme +
#   theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
#   labs(title = "LLSR Cell Type Proportions")
# 
#   airway	 |>
#   pivot_sample() |>
#   select(.sample, contains("epic__")) |>
#   pivot_longer(cols = -1, names_to = "Cell_type_inferred", values_to = "proportion") |>
#   ggplot(aes(x = .sample, y = proportion, fill = Cell_type_inferred)) +
#   geom_bar(stat = "identity") +
#   scale_y_continuous(labels = scales::percent) +
#   my_theme +
#   theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
#   labs(title = "EPIC Cell Type Proportions")
# 
#   airway	 |>
#   pivot_sample() |>
#   select(.sample, contains("mcp__")) |>
#   pivot_longer(cols = -1, names_to = "Cell_type_inferred", values_to = "proportion") |>
#   ggplot(aes(x = .sample, y = proportion, fill = Cell_type_inferred)) +
#   geom_bar(stat = "identity") +
#   scale_y_continuous(labels = scales::percent) +
#   my_theme +
#   theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
#   labs(title = "MCP-counter Cell Type Proportions")
# 
#   airway	 |>
#   pivot_sample() |>
#   select(.sample, contains("quantiseq__")) |>
#   pivot_longer(cols = -1, names_to = "Cell_type_inferred", values_to = "proportion") |>
#   ggplot(aes(x = .sample, y = proportion, fill = Cell_type_inferred)) +
#   geom_bar(stat = "identity") +
#   scale_y_continuous(labels = scales::percent) +
#   my_theme +
#   theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
#   labs(title = "quanTIseq Cell Type Proportions")
# 
#   airway	 |>
#   pivot_sample() |>
#   select(.sample, contains("xcell__")) |>
#   pivot_longer(cols = -1, names_to = "Cell_type_inferred", values_to = "proportion") |>
#   ggplot(aes(x = .sample, y = proportion, fill = Cell_type_inferred)) +
#   geom_bar(stat = "identity") +
#   scale_y_continuous(labels = scales::percent) +
#   my_theme +
#   theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
#   labs(title = "xCell Cell Type Proportions")
# 

## ----bibliography-get-methods-------------------------------------------------
# Get bibliography of all methods used in our workflow
airway |> get_bibliography()

## ----session-info-------------------------------------------------------------
sessionInfo()

