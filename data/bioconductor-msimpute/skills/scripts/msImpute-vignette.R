# Code example from 'msImpute-vignette' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("msImpute")

## ----setup, message=FALSE-----------------------------------------------------
library(reticulate)
library(msImpute)
library(limma)
library(imputeLCMD)
library(ComplexHeatmap)

## -----------------------------------------------------------------------------
data(pxd014777)
y <- pxd014777

## -----------------------------------------------------------------------------
table(is.infinite(data.matrix(log2(y))))

## -----------------------------------------------------------------------------
y <- log2(y+0.25)

## -----------------------------------------------------------------------------
# quantile normalisation
y <- normalizeBetweenArrays(y, method = "quantile")

## -----------------------------------------------------------------------------

batch <- as.factor(gsub("(2018.*)_RF.*","\\1", colnames(y)))
experiment <- as.factor(gsub(".*(S[1-9]).*","\\1", colnames(y)))


hdp <- selectFeatures(y, method = "ebm", group = batch)


# peptides missing in one or more experimental group will have a NaN EBM, which is a measure of entropy of 
# distribution of observed values
table(is.nan(hdp$EBM))

# construct matrix M to capture missing entries
M <- ifelse(is.na(y),1,0)
M <- M[hdp$msImpute_feature,]

# plot a heatmap of missingness patterns for the selected peptides




## ----fig.cap="Heatmap of missing value patterns for peptides selected as informative peptides", fig.align="center"----
ha_column <- HeatmapAnnotation(batch = batch,
                               experiment = experiment,
                               col = list(batch = c('20181023' = "#B24745FF",
                                                    '20181024'= "#00A1D5FF"),
                                          experiment=c("S1"="#DF8F44FF",
                                                       "S2"="#374E55FF",
                                                       "S4"="#79AF97FF")))

hm <- Heatmap(M,
column_title = "dropout pattern, columns ordered by dropout similarity",
              name = "Intensity",
              col = c("#8FBC8F", "#FFEFDB"),
              show_row_names = FALSE,
              show_column_names = FALSE,
              cluster_rows = TRUE,
              cluster_columns = TRUE,
              show_column_dend = FALSE,
              show_row_dend = FALSE,
              top_annotation = ha_column,
              row_names_gp =  gpar(fontsize = 7),
              column_names_gp = gpar(fontsize = 8),
              heatmap_legend_param = list(#direction = "horizontal",
              heatmap_legend_side = "bottom",
              labels = c("observed","missing"),
              legend_width = unit(6, "cm")),
         )
hm <- draw(hm, heatmap_legend_side = "left")

## -----------------------------------------------------------------------------
data(pxd007959)

sample_annot <- pxd007959$samples
y <- pxd007959$y
y <- log2(y)

## -----------------------------------------------------------------------------
y <- normalizeBetweenArrays(y, method = "cyclicloess")

## ----fig.align="center"-------------------------------------------------------
# determine missing values pattern
group <- sample_annot$group
hdp <- selectFeatures(y, method="ebm", group = group)

## ----fig.cap="Dropout pattern of informative peptides", fig.align="center"----
# construct matrix M to capture missing entries
M <- ifelse(is.na(y),1,0)
M <- M[hdp$msImpute_feature,]



# plot a heatmap of missingness patterns for the selected peptides
ha_column <- HeatmapAnnotation(group = as.factor(sample_annot$group),
                               col=list(group=c('Control' = "#E64B35FF",
                                                'Mild' = "#3C5488FF",
                                                'Moderate' = "#00A087FF",
                                                'Severe'="#F39B7FFF")))

hm <- Heatmap(M,
column_title = "dropout pattern, columns ordered by dropout similarity",
              name = "Intensity",
              col = c("#8FBC8F", "#FFEFDB"),
              show_row_names = FALSE,
              show_column_names = FALSE,
              cluster_rows = TRUE,
              cluster_columns = TRUE,
              show_column_dend = FALSE,
              show_row_dend = FALSE,
              top_annotation = ha_column,
              row_names_gp =  gpar(fontsize = 7),
              column_names_gp = gpar(fontsize = 8),
              heatmap_legend_param = list(#direction = "horizontal",
              heatmap_legend_side = "bottom",
              labels = c("observed","missing"),
              legend_width = unit(6, "cm")),
         )
hm <- draw(hm, heatmap_legend_side = "left")

## -----------------------------------------------------------------------------
# imputation

y_qrilc <- impute.QRILC(y)[[1]]

y_msImpute <- msImpute(y, method = "v2-mnar", group = group)



group <- as.factor(sample_annot$group)


## ----eval=FALSE---------------------------------------------------------------
# virtualenv_create('msImpute-reticulate')
# virtualenv_install("msImpute-reticulate","scipy")
# virtualenv_install("msImpute-reticulate","cython")
# virtualenv_install("msImpute-reticulate","POT")
# 
# use_virtualenv("msImpute-reticulate")
# 
# top.hvp <- findVariableFeatures(y)
# 
# computeStructuralMetrics(y_msImpute, group, y[rownames(top.hvp)[1:50],], k = 16)

## ----eval=FALSE---------------------------------------------------------------
# computeStructuralMetrics(y_qrilc, group, y[rownames(top.hvp)[1:50],], k = 16)

## -----------------------------------------------------------------------------
par(mfrow=c(2,2))
pcv <- plotCV2(y, main = "data")
pcv <- plotCV2(y_msImpute, main = "msImpute v2-mnar")
pcv <- plotCV2(y_qrilc, main = "qrilc")

## -----------------------------------------------------------------------------
data(pxd010943)
y <- pxd010943
# no problematic values for log- transformation
table(is.infinite(data.matrix(log2(y))))

y <- log2(y)
y <- normalizeBetweenArrays(y, method = "quantile")

## -----------------------------------------------------------------------------
group <- as.factor(gsub("_[1234]", "", colnames(y)))
group

hdp <- selectFeatures(y, method = "ebm", group = group) 

table(hdp$msImpute_feature)
table(is.nan(hdp$EBM))

table(complete.cases(y))


## ----fig.cap="Dropout pattern of informative peptides", fig.align="center"----

# construct matrix M to capture missing entries
M <- ifelse(is.na(y),1,0)
M <- M[hdp$msImpute_feature,]

# plot a heatmap of missingness patterns for the selected peptides



ha_column <- HeatmapAnnotation(group = group)

hm <- Heatmap(M,
column_title = "dropout pattern, columns ordered by dropout similarity",
              name = "Intensity",
              col = c("#8FBC8F", "#FFEFDB"),
              show_row_names = FALSE,
              show_column_names = FALSE,
              cluster_rows = TRUE,
              cluster_columns = TRUE,
              show_column_dend = FALSE,
              show_row_dend = FALSE,
              top_annotation = ha_column,
              row_names_gp =  gpar(fontsize = 7),
              column_names_gp = gpar(fontsize = 8),
              heatmap_legend_param = list(#direction = "horizontal",
              heatmap_legend_side = "bottom",
              labels = c("observed","missing"),
              legend_width = unit(6, "cm")),
         )
hm <- draw(hm, heatmap_legend_side = "left")

## -----------------------------------------------------------------------------
y_msImpute_mar <- msImpute(y, method = "v2") # no need to specify group if data is MAR.
y_msImpute_mnar <- msImpute(y, method = "v2-mnar", group = group)

## -----------------------------------------------------------------------------

computeStructuralMetrics(y_msImpute_mar, group, y=NULL)

## -----------------------------------------------------------------------------
computeStructuralMetrics(y_msImpute_mnar, group, y = NULL)

## -----------------------------------------------------------------------------
par(mfrow=c(2,2))
pcv <- plotCV2(y, main = "data")
pcv <- plotCV2(y_msImpute_mnar, main = "msImpute v2-mnar")
pcv <- plotCV2(y_msImpute_mar, main = "msImpute v2")

## ----echo=FALSE---------------------------------------------------------------
sessionInfo()

