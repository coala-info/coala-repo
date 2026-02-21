# Code example from 'SimulationVignette' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, comment = '##', results = 'markup', warning = FALSE)

## ----eval=FALSE---------------------------------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("retrofit")

## ----load_library, echo = FALSE-----------------------------------------------
library(retrofit)

## ----data---------------------------------------------------------------------
data("vignetteSimulationData")
x = vignetteSimulationData$n10m3_x

## ----decompose initialization-------------------------------------------------
iterations  = 10
L           = 20

## ----decompose----------------------------------------------------------------
result  = retrofit::decompose(x, L=L, iterations=iterations, verbose=TRUE)
H   = result$h
W   = result$w
Th  = result$th

## ----load_retrofit_results----------------------------------------------------
H   = vignetteSimulationData$results_4k_iterations$decompose$h
W   = vignetteSimulationData$results_4k_iterations$decompose$w
Th  = vignetteSimulationData$results_4k_iterations$decompose$th

## ----retrofit reproducibility, eval = FALSE-----------------------------------
# iterations = 4000
# set.seed(12)
# result = retrofit::decompose(x, L=L, iterations=iterations)

## ----reference----------------------------------------------------------------
sc_ref_w = vignetteSimulationData$sc_ref_w

## ----annotate-----------------------------------------------------------------
K             = 10
result        = retrofit::annotateWithCorrelations(sc_ref=sc_ref_w, K=K, 
                                                   decomp_w=W, decomp_h=H)
H_annotated   = result$h
W_annotated   = result$w
ranked_cells  = result$ranked_cells

## ----retrofit-----------------------------------------------------------------
iterations  = 10
L           = 20
K           = 10 
result      = retrofit::retrofit(x, 
                                 sc_ref=sc_ref_w,
                                 iterations=iterations, 
                                 L=L, 
                                 K=K)

## ----visualize_correlations---------------------------------------------------
# correlation between true and estimated cell-type proportions
correlations        = stats::cor(sc_ref_w[ranked_cells], W_annotated[,ranked_cells])
ranked_correlations = sort(diag(correlations), decreasing=TRUE)
df                  = data.frame(x=1:length(ranked_correlations), 
                                 y=ranked_correlations, 
                                 label_x1=1, 
                                 label_x2=2, 
                                 label_y=seq(from=0.5, by=-0.05, length.out=10),
                                 label_cell=ranked_cells,
                                 label_corr=format(round(ranked_correlations, digits=4)))

gg <- ggplot2::ggplot(df,ggplot2::aes(x=x, y=y, group=1)) + 
  ggplot2::geom_line(ggplot2::aes(x=x, y=y)) + 
  ggplot2::geom_point(ggplot2::aes(x=x, y=y)) + 
  ggplot2::theme_bw() + 
  ggplot2::theme(axis.text.x=ggplot2::element_blank()) +
  ggplot2::ylim(0, 1.05) +
  ggplot2::ylab(expression(paste("Correlation (",W^0,",",widetilde(W),")"))) +
  ggplot2::geom_text(data=df, ggplot2::aes(x=label_x1, y=label_y, label=label_corr), size=4, hjust=0) +
  ggplot2::geom_text(data=df, ggplot2::aes(x=label_x2, y=label_y, label=label_cell), size=4, hjust=0)
plot(gg)

## ----visualize_rmse-----------------------------------------------------------
H_true  = vignetteSimulationData$sc_ref_h
H_est   = H_annotated
corrH   = sort(diag(stats::cor(H_true,H_est)), decreasing=TRUE, na.last=TRUE)
df      = data.frame(x=seq(0,1,length.out = 1000), 
                     y=corrH)
df_text = data.frame(x=0.2,
                     y=0.6,
                     label = c(paste("RETROFIT:", round(DescTools::AUC(x=seq(0,1,length.out = 1000), y=corrH),digits=3))))

gg   <- ggplot2::ggplot(df, ggplot2::aes(x=x,y=y)) +
  ggplot2::geom_line() + 
  ggplot2::scale_color_manual('gray30') + 
  ggplot2::xlab("Normalized Rank") +
  ggplot2::ylab(expression(paste("Correlation (",H,",",widetilde(H),")"))) +
  ggplot2::theme_bw() +
  ggplot2::geom_text(data = df_text, ggplot2::aes(label = label)) 
plot(gg)

## -----------------------------------------------------------------------------
sessionInfo()

