# Code example from 'comparison_coding' vignette. See references/ for full tutorial.

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
library(tidySummarizedExperiment)
library(airway)

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

## ----aggregate, message=FALSE, warning=FALSE, results='hide', class.source='yellow', eval=FALSE----
# rowData(airway)$gene_name = rownames(airway)
# airway.aggr = airway |> aggregate_duplicates(.transcript = gene_name)

## ----aggregate long, eval=FALSE-----------------------------------------------
# temp = data.frame(
# 	symbol = dge_list$genes$symbol,
# 	dge_list$counts
# )
# dge_list.nr <- by(temp,	temp$symbol,
# 	function(df)
# 		if(length(df[1,1])>0)
# 			matrixStats:::colSums(as.matrix(df[,-1]))
# )
# dge_list.nr <- do.call("rbind", dge_list.nr)
# colnames(dge_list.nr) <- colnames(dge_list)

## ----normalise----------------------------------------------------------------
airway.norm = airway |> identify_abundant(factor_of_interest = dex) |> scale_abundance()

## ----normalise long, eval=FALSE-----------------------------------------------
# library(edgeR)
# 
# dgList <- DGEList(count_m=x,group=group)
# keep <- filterByExpr(dgList)
# dgList <- dgList[keep,,keep.lib.sizes=FALSE]
# # ... additional processing steps ...
# dgList <- calcNormFactors(dgList, method="TMM")
# norm_counts.table <- cpm(dgList)

## ----include=FALSE------------------------------------------------------------
airway.norm |> dplyr::select(`counts`, counts_scaled, .abundant, everything())

## ----plot_normalise, fig.width = 10, fig.height = 10--------------------------
airway.norm |>
	ggplot(aes(counts_scaled + 1, group=.sample, color=`dex`)) +
	geom_density() +
	scale_x_log10() +
	my_theme

## ----filter variable----------------------------------------------------------
airway.norm.variable = airway.norm |> keep_variable()

## ----filter variable long, eval=FALSE-----------------------------------------
# library(edgeR)
# 
# x = norm_counts.table
# 
# s <- rowMeans((x-rowMeans(x))^2)
# o <- order(s,decreasing=TRUE)
# x <- x[o[1L:top],,drop=FALSE]
# 
# norm_counts.table = norm_counts.table[rownames(x)]
# 
# norm_counts.table$cell_type = tibble_counts[
# 	match(
# 		tibble_counts$sample,
# 		rownames(norm_counts.table)
# 	),
# 	"cell"
# ]

## ----mds----------------------------------------------------------------------
airway.norm.MDS =
  airway.norm |>
  reduce_dimensions(method="MDS", .dims = 2)


## ----eval = FALSE-------------------------------------------------------------
# library(limma)
# 
# count_m_log = log(count_m + 1)
# cmds = limma::plotMDS(count_m_log, ndim = 3, plot = FALSE)
# 
# cmds = cmds %$%	
# 	cmdscale.out |>
# 	setNames(sprintf("Dim%s", 1:6))
# 
# cmds$cell_type = tibble_counts[
# 	match(tibble_counts$sample, rownames(cmds)),
# 	"cell"
# ]

## ----plot_mds, fig.width = 10, fig.height = 10, eval=FALSE--------------------
# airway.norm.MDS |> pivot_sample()  |> dplyr::select(contains("Dim"), everything())
# 
# airway.norm.MDS |>
# 	pivot_sample() |>
#   GGally::ggpairs(columns = 9:11, ggplot2::aes(colour=`dex`))
# 
# 

## ----pca, message=FALSE, warning=FALSE, results='hide'------------------------
airway.norm.PCA =
  airway.norm |>
  reduce_dimensions(method="PCA", .dims = 2)

## ----eval=FALSE---------------------------------------------------------------
# count_m_log = log(count_m + 1)
# pc = count_m_log |> prcomp(scale = TRUE)
# variance = pc$sdev^2
# variance = (variance / sum(variance))[1:6]
# pc$cell_type = counts[
# 	match(counts$sample, rownames(pc)),
# 	"cell"
# ]

## ----plot_pca, fig.width = 10, fig.height = 10, eval=FALSE--------------------
# 
# airway.norm.PCA |> pivot_sample() |> dplyr::select(contains("PC"), everything())
# 
# airway.norm.PCA |>
# 	 pivot_sample() |>
#   GGally::ggpairs(columns = 11:13, ggplot2::aes(colour=`dex`))

## ----rotate-------------------------------------------------------------------
airway.norm.MDS.rotated =
  airway.norm.MDS |>
	rotate_dimensions(`Dim1`, `Dim2`, rotation_degrees = 45)

## ----eval=FALSE---------------------------------------------------------------
# rotation = function(m, d) {
# 	r = d * pi / 180
# 	((bind_rows(
# 		c(`1` = cos(r), `2` = -sin(r)),
# 		c(`1` = sin(r), `2` = cos(r))
# 	) |> as_matrix()) %*% m)
# }
# mds_r = pca |> rotation(rotation_degrees)
# mds_r$cell_type = counts[
# 	match(counts$sample, rownames(mds_r)),
# 	"cell"
# ]

## ----plot_rotate_1, fig.width = 10, fig.height = 10---------------------------
airway.norm.MDS.rotated |>
	ggplot(aes(x=`Dim1`, y=`Dim2`, color=`dex` )) +
  geom_point() +
  my_theme

## ----plot_rotate_2, fig.width = 10, fig.height = 10---------------------------
airway.norm.MDS.rotated |>
	pivot_sample() |>
	ggplot(aes(x=`Dim1_rotated_45`, y=`Dim2_rotated_45`, color=`dex` )) +
  geom_point() +
  my_theme

## ----de, message=FALSE, warning=FALSE, results='hide'-------------------------
airway.de =
	airway |>
	test_differential_expression( ~ dex, method = "edgeR_quasi_likelihood") |>
  pivot_transcript()
airway.de

## ----eval=FALSE---------------------------------------------------------------
# library(edgeR)
# 
# dgList <- DGEList(counts=counts_m,group=group)
# keep <- filterByExpr(dgList)
# dgList <- dgList[keep,,keep.lib.sizes=FALSE]
# dgList <- calcNormFactors(dgList)
# design <- model.matrix(~group)
# dgList <- estimateDisp(dgList,design)
# fit <- glmQLFit(dgList,design)
# qlf <- glmQLFTest(fit,coef=2)
# topTags(qlf, n=Inf)

## ----de contrast, message=FALSE, warning=FALSE, results='hide', eval=FALSE----
# airway.de =
# 	airway |>
# 	identify_abundant(factor_of_interest = dex) |>
# 	test_differential_expression(
# 		~ 0 + dex,
# 		.contrasts = c( "dexuntrt - dextrt"),
# 		method = "edgeR_quasi_likelihood"
# 	) |>
#   pivot_transcript()

## ----adjust, message=FALSE, warning=FALSE, results='hide'---------------------
airway.norm.adj =
	airway.norm 	|> adjust_abundance(	.factor_unwanted = cell, .factor_of_interest = dex, method="combat")



## ----eval=FALSE---------------------------------------------------------------
# library(sva)
# 
# count_m_log = log(count_m + 1)
# 
# design =
# 		model.matrix(
# 			object = ~ factor_of_interest + batch,
# 			data = annotation
# 		)
# 
# count_m_log.sva =
# 	ComBat(
# 			batch =	design[,2],
# 			mod = design,
# 			...
# 		)
# 
# count_m_log.sva = ceiling(exp(count_m_log.sva) -1)
# count_m_log.sva$cell_type = counts[
# 	match(counts$sample, rownames(count_m_log.sva)),
# 	"cell"
# ]
# 

## ----cibersort, eval=FALSE----------------------------------------------------
# # Requires gene symbols that match reference data
# # airway.cibersort =
# # 	airway |>
# # 	deconvolve_cellularity( cores=1, prefix = "cibersort__") |>
# #   pivot_sample()
# 

## ----eval=FALSE---------------------------------------------------------------
# 
# source("CIBERSORT.R")
# count_m |> write.table("mixture_file.txt")
# results <- CIBERSORT(
# 	"sig_matrix_file.txt",
# 	"mixture_file.txt",
# 	perm=100, QN=TRUE
# )
# results$cell_type = tibble_counts[
# 	match(tibble_counts$sample, rownames(results)),
# 	"cell"
# ]
# 

## ----plot_cibersort, eval=FALSE-----------------------------------------------
# # airway.cibersort |>
# # 	pivot_longer(
# # 		names_to= "Cell_type_inferred",
# # 		values_to = "proportion",
# # 		names_prefix ="cibersort__",
# # 		cols=contains("cibersort__")
# # 	) |>
# #   ggplot(aes(x=Cell_type_inferred, y=proportion, fill=cell)) +
# #   geom_boxplot() +
# #   facet_wrap(~cell) +
# #   my_theme +
# #   theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5), aspect.ratio=1/5)
# 

## ----cluster------------------------------------------------------------------
airway.norm.cluster =
	airway.norm |>
	cluster_elements(method="kmeans", centers = 2)

## ----eval=FALSE---------------------------------------------------------------
# library(stats)
# 
# count_m_log = log(count_m + 1)
# count_m_log_centered = count_m_log - rowMeans(count_m_log)
# 
# kmeans_result = kmeans(t(count_m_log_centered), centers = 2)
# 
# cluster_labels = kmeans_result$cluster

## ----differential-------------------------------------------------------------
airway.norm.de =
	airway.norm |>
	test_differential_abundance(~ dex, method="edgeR_quasi_likelihood")

## ----eval=FALSE---------------------------------------------------------------
# library(edgeR)
# 
# count_m_log = log(count_m + 1)
# 
# design = model.matrix(~ dex, data = annotation)
# 
# dge = DGEList(counts = count_m)
# dge = calcNormFactors(dge)
# dge = estimateDisp(dge, design)
# 
# fit = glmQLFit(dge, design)
# qlf = glmQLFTest(fit, coef=2)
# 
# results = topTags(qlf, n = Inf)

## ----session-info-------------------------------------------------------------
sessionInfo()

