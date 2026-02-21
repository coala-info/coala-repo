# Code example from 'rifiComparative' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
devtools::load_all(".")

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(echo = TRUE,
                      message = TRUE,
                      warning = TRUE)

## ----echo = FALSE, message = FALSE--------------------------------------------
require(rifiComparative)
suppressPackageStartupMessages(library(SummarizedExperiment))

## ----loading_fun, eval = TRUE-------------------------------------------------
data(stats_se_cdt1)
data(stats_se_cdt2)
data(differential_expression)
inp_s <-  
    loading_fun(stats_se_cdt1, stats_se_cdt2, differential_expression)[[1]]
head(inp_s, 5)
inp_f <- 
    loading_fun(stats_se_cdt1, stats_se_cdt2, differential_expression)[[2]]
head(inp_f, 5)

## ----joining_data_row, eval = TRUE--------------------------------------------
data(inp_s)
data(inp_f)
data_combined_minimal <- 
joining_data_row(input1 = inp_s, input2 = inp_f)
head(data_combined_minimal, 5)

## ----joinging_data_column, eval = TRUE----------------------------------------
data(data_combined_minimal)
df_comb_minimal <- joining_data_column(data = data_combined_minimal)
head(df_comb_minimal, 5)

## ----make_pen HL, eval = FALSE------------------------------------------------
# 
# df_comb_minimal[,"distance_HL"] <-
#     df_comb_minimal[, "half_life.cdt1"] - df_comb_minimal[, "half_life.cdt2"]
# 
# pen_HL <- make_pen(
#     probe = df_comb_minimal,
#     FUN = rifiComparative:::fragment_HL_pen,
#     cores = 2,
#     logs = as.numeric(rep(NA, 8))
# )

## ----make_pen int, eval = FALSE-----------------------------------------------
# 
# df_comb_minimal[,"distance_int"] <- df_comb_minimal[,"logFC_int"]
# 
# pen_int <- make_pen(
#     probe = df_comb_minimal,
#     FUN = rifiComparative:::fragment_inty_pen,
#     cores = 2,
#     logs = as.numeric(rep(NA, 8))
# )

## ----penalties, eval = TRUE---------------------------------------------------
data(df_comb_minimal) 
penalties_df <- penalties(df_comb_minimal)[[1]]
pen_HL <- penalties(df_comb_minimal)[[2]]
pen_int <- penalties(df_comb_minimal)[[3]]
head(penalties_df, 5)

## ----fragment_HL, eval = TRUE-------------------------------------------------
penalties_df <-
    fragment_HL(
    probe = penalties_df,
    cores = 2,
    pen = pen_HL[[1]][[9]],
    pen_out = pen_HL[[1]][[10]]
)

## ----fragment_inty, eval = TRUE-----------------------------------------------
fragment_int <-
    fragment_inty(
        probe = penalties_df,
        cores = 2,
        pen = pen_int[[1]][[9]],
        pen_out = pen_int[[1]][[10]]
    )
head(fragment_int, 5)

## ----t_test_function_HL, eval = TRUE------------------------------------------
data(fragment_int)
stats_df_comb_minimal <- statistics(data= fragment_int)[[1]]
df_comb_uniq_minimal <- statistics(data= fragment_int)[[2]]

## ----rifi_visualization_comparison, eval = FALSE------------------------------
# data(data_combined_minimal)
# data(stats_df_comb_minimal)
# data(annot_g)
# rifi_visualization_comparison(
#      data = data_combined_minimal,
#      data_c = stats_df_comb_minimal,
#      genomeLength = annot_g[[2]],
#      annot = annot_g[[1]]
#      )

## ----visualization, echo = FALSE, fig.cap = "**genome fragments visualization of both conditions**", out.width = '100%'----
knitr::include_graphics("visualization_cdts.png")

## ----adjusting_HLToInt, eval = TRUE-------------------------------------------
data(stats_df_comb_minimal) 
data(annot_g)
df_adjusting_HLToInt <- adjusting_HLToInt(data = stats_df_comb_minimal, 
                                          annotation = annot_g[[1]])
head(df_adjusting_HLToInt, 5)

## ----figures_fun, eval = FALSE, echo = TRUE, out.width = '100%'---------------
#  data(data_combined_minimal)
#  data(df_comb_minimal)
#  data(differential_expression)
#  data(df_mean_minimal)
#  figures_fun(data.1 = df_mean_minimal, data.2 = data_combined_minimal,
#  input.1 = df_comb_minimal, input.2 = differential_expression, cdt1 = "sc",
#  cdt2 = "fe")

## ----echo = FALSE, fig.cap = "**\\label{fig:figs}Decay rate vs. Synthesis rate**", out.width = '100%'----
knitr::include_graphics("Decay_rate_vs_Synthesis_rate.png")

## ----echo = FALSE, fig.cap = "**\\label{fig:figs}Heatscatter Decay rate vs. Synthesis rate**", out.width = '100%'----
knitr::include_graphics("heatscatter_Decay_rate_vs_Synthesis_rate.png")

## ----echo = FALSE, fig.cap = "**\\label{fig:figs}Half-life Density**", out.width = '100%'----
knitr::include_graphics("density_HL.png")

## ----echo = FALSE, fig.cap = "**\\label{fig:figs}Half-life Classification**", out.width = '100%'----
knitr::include_graphics("histogram_count.png")

## ----echo = FALSE, fig.cap = "**\\label{fig:figs}Half-life Scatter Plot **", out.width = '100%'----
knitr::include_graphics("scatter_plot_HL.png")

## ----echo = FALSE, fig.cap = "**\\label{fig:figs}Volcano Plot**", out.width = '100%'----
knitr::include_graphics("volcano_plot.png")

## ----gff3_preprocess----------------------------------------------------------
gff3_preprocess(path = gzfile(
   system.file("extdata", "gff_synechocystis_6803.gff.gz", package = "rifiComparative")
 ))

## -----------------------------------------------------------------------------
sessionInfo()

