# Code example from 'covisualize' vignette. See references/ for full tutorial.

## ----setup0, eval=TRUE, echo=FALSE, message=FALSE, warning=FALSE, include=FALSE----
## ThG: chunk added to enable global knitr options. The below turns on
## caching for faster vignette re-build during text editing.
library(knitr); opts_chunk$set(cache=TRUE, message=FALSE, warning=FALSE)

## ----css, echo = FALSE, results = 'asis'--------------------------------------
BiocStyle::markdown(css.files=c('file/custom.css'))

## ----datastr, echo=FALSE, fig.wide=TRUE, out.width="100%", fig.cap=("Schematic view of data structures and creation of co-visualization plots. File imports, classes, and plotting functionalities are illustrated in boxes with color-coded title bars in grey, blue and green, respectively. Quantitative and experimental design data (I) are imported into matching slots of an `SE` container (A). aSVG image files are stored in `SVG` containers (B). Expression profiles of a chosen gene (GeneX) in (A) are mapped to the corresponding spatial features in (B) via common identifiers (here TissuesA and TissueB). The quantitative data is represented in the matching features by colors according to a number to color key and the output is an SHM (a). For co-visualization plots, single-cell data are stored in the `SCE` object class (C). Reduced dimension data for embedding plots can be generated in R or imported from files. The single-cell embedding results are co-visualized with SHMs where the cell-to-tissue mappings are indicated by common colors in the co-visualization plot (b). The `SPHM` meta class organizes the individual objects (A)-(C) along with internally generated data.")----
include_graphics('img/data_str.jpg')

## ----grpcolor, echo=FALSE, fig.wide=TRUE, out.width="100%", fig.cap=("Cell grouping and coloring. (a) For co-visualizing with SHMs, single cells need to have group labels. Five methods are supported to obtain group labels. (b) In the co-visualization plot, matching between cells and aSVG features is indicated by colors between the two. Four coloring options are summarized in a table. The cell grouping and coloring are schematically illustrated in 1-3.")----
include_graphics('img/group_color.jpg')

## ----eval=TRUE, echo=TRUE, warnings=FALSE, results='hide'---------------------
library(spatialHeatmap); library(SummarizedExperiment); library(ggplot2); library(SingleCellExperiment);
library(kableExtra); library(Seurat)

## ----eval=FALSE, echo=TRUE, warnings=FALSE------------------------------------
# browseVignettes('spatialHeatmap')

## ----eval=TRUE, echo=TRUE, message=FALSE, warnings=FALSE----------------------
cache.pa <- '~/.cache/shm' # Set path of the cache directory

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
set.seed(10)

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
sce.pa <- system.file("extdata/shinyApp/data", "cell_mouse_brain.rds", package="spatialHeatmap")
sce <- readRDS(sce.pa)
sce.dimred.quick <- process_cell_meta(sce, qc.metric=list(subsets=list(Mt=rowData(sce)$featureType=='mito'), threshold=1))
colData(sce.dimred.quick)[1:3, 1:2]

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
sce.aggr.quick <- aggr_rep(sce.dimred.quick, assay.na='logcounts', sam.factor='label', aggr='mean')

## ----eval=TRUE, echo=TRUE, warnings=FALSE, results='hide'---------------------
svg.mus.brain.pa <- system.file("extdata/shinyApp/data", "mus_musculus.brain.svg", package="spatialHeatmap")
svg.mus.brain <- read_svg(svg.mus.brain.pa)

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
tail(attribute(svg.mus.brain)[[1]])[, 1:4]

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
lis.match.quick <- list(hypothalamus=c('hypothalamus'), cortex.S1=c('cerebral.cortex', 'nose'))

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
dat.quick <- SPHM(svg=svg.mus.brain, bulk=sce.aggr.quick, cell=sce.dimred.quick, match=lis.match.quick)

## ----eval=TRUE, echo=TRUE, warnings=FALSE, results='hide', fig.cap=("Co-visualization of 'cell-by-group' coloring. The co-visualization is created with gene `Apod`. Single cells in the embedding plot and their matching aSVG features in the SHM are assigned the same colors that are created according to mean expression values of `Apod` within cell groups.")----
shm.res.quick <- covis(data=dat.quick, ID=c('Apod'), dimred='UMAP', cell.group='label', tar.cell=names(lis.match.quick), assay.na='logcounts', bar.width=0.09, dim.lgd.nrow=2, legend.r=1.5, legend.key.size=0.02, legend.text.size=10, legend.nrow=4, h=0.6, verbose=FALSE) 

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
set.seed(10)

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
colData(sce)[1:3, 1:2]

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
blk.mus.pa <- system.file("extdata/shinyApp/data", "bulk_mouse_cocluster.rds", package="spatialHeatmap") 
blk.mus <- readRDS(blk.mus.pa)
assay(blk.mus)[1:3, 1:5]
colData(blk.mus)[1:3, , drop=FALSE]

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
mus.ann.nor <- read_cache(cache.pa, 'mus.ann.nor') 
if (is.null(mus.ann.nor)) {
  # Joint normalization.
  mus.lis.nor <- norm_cell(sce=sce, bulk=blk.mus, quick.clus=list(min.size = 100, d=15), com=FALSE)
  save_cache(dir=cache.pa, overwrite=TRUE, mus.ann.nor)
}
# Separate bulk and cell data.
blk.mus.nor <- mus.lis.nor$bulk
cell.mus.nor <- mus.lis.nor$cell
colData(cell.mus.nor) <- colData(sce)

## ----eval=TRUE, echo=TRUE, warnings=FALSE, fig.wide=TRUE, fig.cap=('Embedding plot of single-cell data. The cells (dots) are colored by the grouping information stored in the `colData` slot of the corresponding `SCE` object'), out.width="70%", fig.show='show'----
cell.dim <- reduce_dim(cell.mus.nor, min.dim=5)
plot_dim(cell.dim, color.by="label", dim='UMAP')

## ----eval=TRUE, echo=TRUE, warnings=FALSE, results='hide'---------------------
# Aggregation.
blk.mus.aggr <- aggr_rep(blk.mus.nor, sam.factor='sample', aggr='mean')
assay(blk.mus.aggr)[1:2, ]

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
tail(attribute(svg.mus.brain)[[1]])[1:3, 1:4]

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
colnames(blk.mus) %in% attribute(svg.mus.brain)[[1]]$feature

## ----scLabList, eval=TRUE, echo=TRUE, warnings=FALSE--------------------------
lis.match.blk <- list(cerebral.cortex=c('cortex.S1'), hypothalamus=c('corpus.callosum', 'hypothalamus'))

## ----eval=TRUE, echo=TRUE, warnings=FALSE, fig.wide=TRUE, fig.cap=("Co-visualization plot with 'feature-by-group' coloring. This plot is created with gene 'Cacnb4'. Tissues in SHM are colored according to respective expression values of 'Cacnb4', and cells of each group in the embedding plot are assigned the same colors as the matching tissues in SHM."), out.width="100%", results='hide'----
# Store data objects in an SPHM container. 
dat.ann.tocell <- SPHM(svg=svg.mus.brain, bulk=blk.mus.aggr, cell=cell.dim, match=lis.match.blk)
covis(data=dat.ann.tocell, ID=c('Cacnb4'), dimred='UMAP', cell.group='label', tar.bulk=names(lis.match.blk), bar.width=0.09, dim.lgd.nrow=2, dim.lgd.text.size=12, h=0.6, legend.r=1.5, legend.key.size=0.02, legend.text.size=10, legend.nrow=3)

## ----eval=TRUE, echo=TRUE, warnings=FALSE, fig.wide=TRUE, fig.cap=('Co-visualization plot of constant colors. In this plot, mapping beween cell groups and tissues are indicated by fixed colors instead of expression values. '), out.width="100%", fig.show='show', results='hide'----
covis(data=dat.ann.tocell, ID=c('Cacnb4'), profile=FALSE, dimred='UMAP', cell.group='label', tar.bulk=names(lis.match.blk), bar.width=0.09, dim.lgd.nrow=2, dim.lgd.text.size=12, h=0.8, legend.r=1.5, legend.key.size=0.02, legend.text.size=10, legend.nrow=3)

## ----colidp, eval=TRUE, echo=TRUE, warnings=FALSE, fig.wide=TRUE, fig.cap=("Co-visualization plot with 'cell-by-value' coloring. This plot is created with gene 'Cacnb4'. Tissues in SHM and cells in embedding plot are colored independently according to respective expression values of 'Cacnb4'."), out.width="100%", results='hide'----
covis(data=dat.ann.tocell, ID=c('Cacnb4'), col.idp=TRUE, dimred='UMAP', cell.group='label', tar.bulk=names(lis.match.blk), bar.width=0.08, dim.lgd.nrow=2, dim.lgd.text.size=10, h=0.6, legend.r=0.1, legend.key.size=0.01, legend.text.size=10, legend.nrow=2)

## ----coclusOver, echo=FALSE, fig.wide=TRUE, out.width="100%", fig.cap=("Co-clustering illustration. (A) The single-cell and bulk tissue data are jointly pre-processed. (B) Single-cell and bulk data are embedded with dimension reduction methods. (C) The embedding results are used for co-clustering single-cells and bulk tissue data. Cells are assigned to tissues based on the clustering results as follows: (1) If a cluster contains a single tissue, then the cells of this cluster are assigned to the corresponding tissue. (2) If a cluster contains multiple tissues and cells, a nearest-neighbor approach resolves this ambiguous situation by assigning cells to the closest tissue sample. (3) Cells in clusters without tissue samples remain unassigned. (D) The cell-tissue assignments and the similarity scores of the predictions are stored in a table. (E) The predictions are used to color the cells by predicted source tissues in co-visualization plots.")----
include_graphics('img/coclustering.jpg')

## ----optPar, eval=TRUE, echo=FALSE, warnings=FALSE----------------------------
df.opt <- cbind(
Parameter=c('dimensionReduction (dimred)', 'topDimensions (dims)', 'graphBuilding (graph.meth)', 'clusterDetection (cluster)'),
Settings=c( 
'**PCA**, UMAP', '5 to 80 (**14**)', '**knn**, snn', 'wt, **fg**, le'
),
Description=c(
'Dimension reduction methods. Choosing "PCA" and "UMAP" involves utilizing the "denoisePCA" function from the scran package and the "runUMAP" function from the scater package, respectively', 
'Number of top dimensions selected for co-clustering.',
'Methods for building a graph where nodes are cells and edges are connections between nearest neighbors. Choosing "knn" and "snn" involves utilizing the "buildKNNGraph" and "buildSNNGraph" function from the scran package, respectively.',
'Methods for partitioning the graph to generate clusters. Choosing "wt", "fg", and "le" involves utilizing the "cluster_walktrap", "cluster_fast_greedy", and "cluster_leading_eigen" function from the igraph package, respectively.'
)
)
#write.table(df.opt, 'cocluster_para.txt', col.names=TRUE, row.names=TRUE, sep='\t')

kable(df.opt, caption='Settings for optimization. Optimal settings are indicated by bold text.', col.names=colnames(df.opt), row.names=FALSE, escape=TRUE) %>%  kable_styling("striped", full_width = TRUE) %>% scroll_box(width = "700px", height = "230px")

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
set.seed(10)

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
sc.mus.pa <- system.file("extdata/shinyApp/data", "cell_mouse_cocluster.rds", package="spatialHeatmap") 
sc.mus <- readRDS(sc.mus.pa)
colData(sc.mus)[1:3, , drop=FALSE]

## ----eval=TRUE, echo=TRUE, warnings=FALSE, results='hide'---------------------
#mus.lis.nor <- read_cache(cache.pa, 'mus.lis.nor') 
#if (is.null(mus.lis.nor)) {
  mus.lis.nor <- norm_cell(sce=sc.mus, bulk=blk.mus, com=FALSE)
  save_cache(dir=cache.pa, overwrite=TRUE, mus.lis.nor)
#}

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
# Aggregate bulk replicates
blk.mus.aggr <- aggr_rep(data=mus.lis.nor$bulk, assay.na='logcounts', sam.factor='sample', aggr='mean')
# Filter bulk
blk.mus.fil <- filter_data(data=blk.mus.aggr, pOA=c(0.1, 1), CV=c(0.1, 50), verbose=FALSE) 
# Filter cell and subset bulk to genes in cell
blk.sc.mus.fil <- filter_cell(sce=mus.lis.nor$cell, bulk=blk.mus.fil, cutoff=1, p.in.cell=0.1, p.in.gen=0.01, verbose=FALSE) 

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
tail(attribute(svg.mus.brain)[[1]])[1:3, 1:4] # Partial features are shown.

## ----eval=TRUE, echo=TRUE, warnings=FALSE, results='hide'---------------------
coclus.mus <- read_cache(cache.pa, 'coclus.mus')
if (is.null(coclus.mus)) {
  coclus.mus <- cocluster(bulk=blk.sc.mus.fil$bulk, cell=blk.sc.mus.fil$cell, min.dim=14, dimred='PCA', graph.meth='knn', cluster='fg')
  save_cache(dir=cache.pa, overwrite=TRUE, coclus.mus)
}

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
colData(coclus.mus)

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
coclus.mus <- filter_asg(coclus.mus, min.sim=0.1)

## ----eval=TRUE, echo=TRUE, warnings=FALSE, fig.wide=TRUE, fig.cap=('Embedding plot of co-clusters. Large and small circles refer to tissues and single cells respectively. '), out.width="80%", fig.show='show', results='hide'----
plot_dim(coclus.mus, dim='PCA', color.by='cluster', cocluster.only=TRUE, group.sel=NULL)

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
# Separate bulk data.
coclus.blk <- subset(coclus.mus, , bulkCell=='bulk')
# Separate single cell data.
coclus.sc <- subset(coclus.mus, , bulkCell=='cell')

## ----eval=TRUE, echo=TRUE, warnings=FALSE, fig.wide=TRUE, fig.cap=("Co-visualization of 'cell-by-value' coloring with the co-clustering method. This plot is created on gene 'Atp2b1'. Each cell and each tissue are colored independently according to expression values of 'Atp2b1'."), out.width="100%", results='hide'----
# Store data objects in an SPHM container. 
dat.auto.idp <- SPHM(svg=svg.mus.brain, bulk=coclus.blk, cell=coclus.sc)
covis(data=dat.auto.idp, ID=c('Atp2b1'), dimred='TSNE', tar.cell=c('hippocampus', 'hypothalamus', 'cerebellum', 'cerebral.cortex'), col.idp=TRUE, dim.lgd.text.size=10, dim.lgd.nrow=2, bar.width=0.08, legend.nrow=3, h=0.6, legend.key.size=0.01, legend.text.size=10, legend.r=0.27)

## ----eval=TRUE, echo=TRUE, warnings=FALSE, collapse=TRUE----------------------
# Importing bulk data.
blk.sp <- readRDS(system.file("extdata/shinyApp/data", "bulk_sp.rds", package="spatialHeatmap"))
# Bulk assay data are partially shown.
assay(blk.sp)[1:3, ]
# Importing SRSC data.
srt.sc <- read_cache(cache.pa, 'srt.sc') 
if (is.null(srt.sc)) {
  srt.sc <- readRDS(gzcon(url("https://zenodo.org/records/18098376/files/srt_sc.rds?download=1")))
  save_cache(dir=cache.pa, overwrite=TRUE, srt.sc)
}
# SRSC assay data are partially shown.
srt.sc@assays$SCT@data[1:3, 1:2]

## ----eval=TRUE, echo=TRUE, warnings=FALSE, collapse=TRUE----------------------
# SRSC metadata of cells are partially shown.
srt.sc@meta.data[1:2, c('seurat_clusters', 'nFeature_SCT')]

## ----eval=TRUE, echo=TRUE, warnings=FALSE, collapse=TRUE----------------------
# Coordinates of spatial spots are partially shown.
srt.sc@images[['anterior1']]@boundaries$centroids@coords[1:3, ]

## ----eval=TRUE, echo=TRUE, warnings=FALSE, results='hide'---------------------
svg.mus.sp <- read_svg(system.file("extdata/shinyApp/data", "mus_musculus.brain_sp.svg", package="spatialHeatmap"), srsc=TRUE)

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
attribute(svg.mus.sp)[[1]][7:8, c('feature', 'id', 'fill', 'stroke')]

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
angle(svg.mus.sp)[[1]] <- angle(svg.mus.sp)[[1]] + 90 

## ----eval=TRUE, echo=TRUE, warnings=FALSE, fig.wide=TRUE, fig.cap=("Co-visualization of SRSC data with SHM. This plot is created on gene 'Epha4'. Each spatial spot and each tissue are colored independently according to expression values of 'Epha4'."), out.width="100%", fig.show='show', results='hide'----
# Association between "cerebral.cortex" and clusters.
lis.match <- list(cerebral.cortex=c('clus1', 'clus3', 'clus5', 'clus10', 'clus14'))   
dat.srsc <- SPHM(svg=svg.mus.sp, bulk=blk.sp, cell=srt.sc, match=lis.match)
covis(data=dat.srsc, ID='Epha4', assay.na='logcounts', dimred='TSNE', cell.group='seurat_clusters', tar.bulk=c('cerebral.cortex'), col.idp=TRUE, image='anterior1', bar.width=0.07, dim.lgd.nrow=2, dim.lgd.text.size=8, legend.r=0.1, legend.key.size=0.013, legend.text.size=10, legend.nrow=3, h=0.6, profile=TRUE, ncol=3, vjust=5, dim.lgd.key.size=3, size.r=0.97, dim.axis.font.size=8, size.pt=1.5, lgd.plots.size=c(0.35, 0.25, 0.35), verbose=FALSE)

## ----echo=FALSE, fig.wide=TRUE, out.width="100%", fig.cap=('Screenshot of the co-visualization output in Shiny App.')----
include_graphics('img/shiny_covis.jpg')

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
shiny.dat.pa <- system.file("extdata/shinyApp/data", "shiny_covis_bulk_cell_mouse_brain.rds", package="spatialHeatmap")
shiny.dat <- readRDS(shiny.dat.pa)
colData(shiny.dat)

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
manual.clus.mus.sc.pa <- system.file("extdata/shinyApp/data", "manual_cluster_mouse_brain.txt", package="spatialHeatmap")
manual.clus.mus.sc <- read.table(manual.clus.mus.sc.pa, header=TRUE, sep='\t')
manual.clus.mus.sc[1:3, ]

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
sce.clus <- cell_group(sce=sce.dimred.quick, df.group=manual.clus.mus.sc, cell='cell', cell.group='cluster')
colData(sce.clus)[1:3, c('cluster', 'label', 'variable')]

## ----eval=TRUE, echo=TRUE, warnings=FALSE, fig.wide=TRUE, fig.cap=('Embedding plot of single cells. The cells (dots) are colored by the grouping information stored in the `colData` slot of the corresponding `SCE` object .'), out.width="70%", fig.show='show'----
plot_dim(sce.clus, color.by="cluster", dim='TSNE')

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
tail(attribute(svg.mus.brain)[[1]])[1:3, 1:4]

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
lis.match.clus <- list(clus1=c('cerebral.cortex'), clus3=c('brainstem', 'medulla.oblongata'))

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
sce.clus.aggr <- aggr_rep(sce.clus, assay.na='logcounts', sam.factor='cluster', con.factor='variable', aggr='mean')
colData(sce.clus.aggr)[1:3, c('cluster', 'label', 'variable')]

## ----eval=TRUE, echo=TRUE, warnings=FALSE, fig.wide=TRUE, fig.cap=('Co-visualization plot created with cluster groupings.'), out.width="100%", results='hide'----
# Store data objects in an SPHM container. 
dat.man.tobulk <- SPHM(svg=svg.mus.brain, bulk=sce.clus.aggr, cell=sce.clus, match=lis.match.clus)
covis(data=dat.man.tobulk, ID=c('Tcea1'), dimred='TSNE', cell.group='cluster', assay.na='logcounts', tar.cell=names(lis.match.clus), bar.width=0.09, dim.lgd.nrow=1, h=0.6, legend.r=1.5, legend.key.size=0.02, legend.text.size=12, legend.nrow=4, verbose=FALSE)

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
# Separate single cell data.
coclus.sc <- subset(coclus.mus, , bulkCell=='cell')
# Summarize expression values in each cell group.
sc.aggr.coclus <- aggr_rep(data=coclus.sc, assay.na='logcounts', sam.factor='assignedBulk', aggr='mean')
colData(sc.aggr.coclus)

## ----eval=TRUE, echo=TRUE, warnings=FALSE, fig.wide=TRUE, fig.cap=("Co-clustering based co-visualization plot with 'cell-by-group' coloring."), out.width="100%", results='hide'----
# Store data objects in an SPHM container. 
dat.auto.tobulk <- SPHM(svg=svg.mus.brain, bulk=sc.aggr.coclus, cell=coclus.sc)
covis(data=dat.auto.tobulk, ID=c('Atp2b1'), dimred='TSNE', tar.cell=c('hippocampus', 'hypothalamus', 'cerebellum', 'cerebral.cortex'), dim.lgd.text.size=10, dim.lgd.nrow=2, bar.width=0.09, legend.nrow=5, h=0.6, legend.key.size=0.02, legend.text.size=12, legend.r=1.5)

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
coclus.blk <- subset(coclus.mus, , bulkCell=='bulk')

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
colnames(coclus.blk) %in% attribute(svg.mus.brain)[[1]]$feature

## ----eval=TRUE, echo=TRUE, warnings=FALSE, fig.wide=TRUE, fig.cap=("Co-clustering based co-visualization plot wiht 'feature-by-group' coloring."), out.width="100%", results='hide'----
# Store data objects in an SPHM container. 
dat.auto.tocell <- SPHM(svg=svg.mus.brain, bulk=coclus.blk, cell=coclus.sc)
covis(data=dat.auto.tocell, ID=c('Atp2b1'), dimred='TSNE', tar.bulk=colnames(coclus.blk), assay.na='logcounts', legend.nrow=5, dim.lgd.text.size=10, dim.lgd.nrow=2, bar.width=0.08, h=0.6, legend.key.size=0.02, legend.text.size=12, legend.r=1.5)

## ----eval=TRUE, echo=TRUE, warnings=FALSE, fig.wide=TRUE, fig.cap=("Co-clustering based co-visualization plot with 'fixed-by-group' coloring."), out.width="100%", results='hide'----
covis(data=dat.auto.tocell, ID=c('Atp2b1'), dimred='TSNE', profile=FALSE, assay.na='logcounts', legend.nrow=4, dim.lgd.text.size=10, dim.lgd.nrow=2, bar.width=0.09)

## ----eval=TRUE, echo=TRUE, warnings=FALSE, fig.wide=TRUE, fig.cap=('Embedding plot of tissues and single cells of mouse brain. Tissues and single cells are indicated by large and small circles respectively. '), out.width="100%", fig.show='show'----
plot_dim(coclus.mus, dim='PCA', color.by='sample', x.break=seq(-10, 10, 1), y.break=seq(-10, 10, 1), panel.grid=TRUE, lgd.ncol=2)

## ----eval=TRUE, echo=TRUE, warnings=FALSE, results='hide'---------------------
df.desired.bulk <- data.frame(x.min=c(-8), x.max=c(5), y.min=c(1), y.max=c(5), desiredBulk=c('hippocampus'), dimred='PCA') 
df.desired.bulk

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
# Incorporate desired bulk
coclus.mus.tailor <- refine_asg(sce.all=coclus.mus, df.desired.bulk=df.desired.bulk)
# Separate cells from bulk
coclus.sc.tailor <- subset(coclus.mus.tailor, , bulkCell=='cell')

## ----aftertailor, eval=TRUE, echo=TRUE, warnings=FALSE, fig.wide=TRUE, fig.cap=("Co-visualization plot with 'feature-by-group' coloring after tailoring. This plot is created on gene 'Atp2b1'. Only the tissue and cells of hippocampus are shown to indicate the tailoring."), out.width="100%", results='hide'----
# Store data objects in an SPHM container. 
dat.auto.tocell.tailor <- SPHM(svg=svg.mus.brain, bulk=coclus.blk, cell=coclus.sc.tailor)
covis(data=dat.auto.tocell.tailor, ID=c('Atp2b1'), dimred='PCA', tar.bulk=c('hippocampus'), assay.na='logcounts', legend.nrow=4, dim.lgd.text.size=10, dim.lgd.nrow=2, bar.width=0.08, legend.r=1.5)

## ----beforetailor, eval=TRUE, echo=TRUE, warnings=FALSE, fig.wide=TRUE, fig.cap=("Co-visualization plot with 'feature-by-group' coloring before tailoring. This plot is created on gene 'Atp2b1'. Only the tissue and cells of hippocampus are shown."), out.width="100%", results='hide'----
covis(data=dat.auto.tocell, ID=c('Atp2b1'), dimred='PCA', tar.bulk=c('hippocampus'), assay.na='logcounts', legend.nrow=4, dim.lgd.text.size=10, dim.lgd.nrow=2, bar.width=0.08, legend.r=1.5)

## ----tailorShiny, echo=FALSE, fig.wide=TRUE, out.width="100%", fig.cap=("Screenshot of the Shiny App for selecting desired tissues. On the left is the embedding plot of single cells, where target cells are selected with the 'Lasso Select' tool. On the right, desired tissues are assigned for selected cells.")----
include_graphics('img/assign_bulk.png')

## ----eval=F, echo=TRUE, warnings=FALSE----------------------------------------
# desired.blk.pa <- system.file("extdata/shinyApp/data", "selected_cells_with_desired_bulk.txt", package="spatialHeatmap")
# df.desired.blk <- read.table(desired.blk.pa, header=TRUE, row.names=1, sep='\t')
# df.desired.blk[1:3, ]

## ----eval=TRUE, echo=TRUE-----------------------------------------------------
sessionInfo()

