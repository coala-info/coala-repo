# Code example from 'pipeComp_scRNA' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
library(BiocStyle)

## -----------------------------------------------------------------------------
library(pipeComp)
# we use the variant of the pipeline used in the paper
pipDef <- scrna_pipeline(pipeClass = "seurat")
pipDef

## -----------------------------------------------------------------------------
source(system.file("extdata", "scrna_alternatives.R", package="pipeComp"))

## -----------------------------------------------------------------------------
alternatives <- list(
  doubletmethod=c("none"),
  filt=c("filt.lenient", "filt.stringent"),
  norm=c("norm.seurat", "norm.sctransform", "norm.scran"),
  sel=c("sel.vst"),
  selnb=2000,
  dr=c("seurat.pca"),
  clustmethod=c("clust.seurat"),
  dims=c(10, 15, 20, 30),
  resolution=c(0.01, 0.1, 0.2, 0.3, 0.5, 0.8, 1, 1.2, 2)
)

## ----eval=FALSE---------------------------------------------------------------
# # available on https://doi.org/10.6084/m9.figshare.11787210.v1
# datasets <- c( mixology10x5cl="/path/to/mixology10x5cl.SCE.rds",
#                simMix2="/path/to/simMix2.SCE.rds",
#                Zhengmix8eq="/path/to/Zhengmix8eq.SCE.rds" )
# # not run
# res <- runPipeline( datasets, alternatives, pipDef, nthreads=3)

## -----------------------------------------------------------------------------
data("exampleResults", package = "pipeComp")
res <- exampleResults

## -----------------------------------------------------------------------------
head(res$evaluation$filtering)

## ----fig.width=6, fig.height=2.5----------------------------------------------
scrna_evalPlot_filtering(res)

## -----------------------------------------------------------------------------
names(res$evaluation$dimreduction)

## -----------------------------------------------------------------------------
names(res$evaluation$dimreduction$silhouette)

## -----------------------------------------------------------------------------
head(res$evaluation$dimreduction$silhouette$top_10_dims)

## ----fig.width=8.5, fig.height=3----------------------------------------------
library(ComplexHeatmap)
scrna_evalPlot_silh( res )
h <- scrna_evalPlot_silh( res, heatmap_legend_param=list(direction="horizontal") )
draw(h, heatmap_legend_side="bottom", annotation_legend_side = "bottom", merge_legend=TRUE)

## -----------------------------------------------------------------------------
res$evaluation$dimreduction$varExpl.subpops[1:5,1:15]

## ----fig.width=8, fig.height=3------------------------------------------------
evalHeatmap(res, step="dimreduction", what="log10_total_features", 
            what2="meanAbsCorr.covariate2")

## ----eval=FALSE---------------------------------------------------------------
# evalHeatmap(res, step="dimreduction", what="log10_total_features",
#             what2="meanAbsCorr.covariate2") +
#   evalHeatmap(res, step="dimreduction", what="log10_total_counts",
#             what2="meanAbsCorr.covariate2")

## ----fig.width=8, fig.height=3------------------------------------------------
evalHeatmap( res, step="dimreduction", what2="meanAbsCorr.covariate2", 
             what=c("log10_total_features","log10_total_counts"), 
             row_title="mean(abs(correlation))\nwith covariate" )

## -----------------------------------------------------------------------------
colnames(res$evaluation$clustering)

## -----------------------------------------------------------------------------
data("clustMetricsCorr", package="pipeComp")
ComplexHeatmap::Heatmap(clustMetricsCorr$pearson, name = "Pearson\ncorr")

## ----fig.height=3, fig.width=7------------------------------------------------
evalHeatmap(res, step="clustering", what=c("MI","ARI"), agg.by=c("filt","norm"))

## ----fig.width=7, fig.height=4------------------------------------------------
evalHeatmap(res, step = "clustering", what=c("MI","ARI"), 
            agg.by=c("norm", "dims"), row_split=norm)

## ----fig.width=8.5, fig.height=4----------------------------------------------
evalHeatmap(res, step = "clustering", what=c("MI","ARI"), agg.by=c("filt","norm")) +
  evalHeatmap(res, step = "clustering", what="ARI", agg.by=c("filt", "norm"),
              filter=n_clus==true.nbClusts, title="ARI at\ntrue k")

## ----fig.width=8, fig.height=5------------------------------------------------
h <- scrna_evalPlot_overall(res)
draw(h, heatmap_legend_side="bottom")

## ----fig.width=7, fig.height=3------------------------------------------------
plotElapsed(res, agg.by="norm")

## -----------------------------------------------------------------------------
pipDef <- addPipelineStep(pipDef, "featureExcl", after="filtering")
# once the step has been added, we can set its function:
stepFn(pipDef, "featureExcl", type="function") <- function(x, classes){
  if(classes!="all"){
    classes <- strsplit(classes, ",")[[1]]
    x <- x[subsetFeatureByType(row.names(x), classes=classes),]
  }
  x
}
pipDef

## -----------------------------------------------------------------------------
alternatives$classes <- c("all","Mt","ribo")
# runPipeline...

## ----eval=FALSE---------------------------------------------------------------
# download.file("https://ndownloader.figshare.com/articles/11787210/versions/1", "datasets.zip")
# unzip("datasets.zip", exdir="datasets")
# datasets <- list.files("datasets", pattern="SCE\\.rds", full.names=TRUE)
# names(datasets) <- sapply(strsplit(basename(datasets),"\\."),FUN=function(x) x[1])

## ----eval=FALSE---------------------------------------------------------------
# source(system.file("extdata", "scrna_alternatives.R", package="pipeComp"))
# sce <- add_meta(sce)
# # requires the variancePartition packages installed:
# sce <- compute_all_gene_info(sce)

