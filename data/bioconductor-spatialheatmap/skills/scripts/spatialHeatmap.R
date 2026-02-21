# Code example from 'spatialHeatmap' vignette. See references/ for full tutorial.

## ----setup0, eval=TRUE, echo=FALSE, message=FALSE, warning=FALSE, include=FALSE----
## ThG: chunk added to enable global knitr options. The below turns on
## caching for faster vignette re-build during text editing.
library(knitr); opts_chunk$set(cache=TRUE, message=FALSE, warning=FALSE)

## ----css, echo = FALSE, results = 'asis'--------------------------------------
BiocStyle::markdown(css.files=c('file/custom.css'))

## ----illus, echo=FALSE, fig.wide=TRUE, out.width="100%", fig.cap=("Overview of spatialHeatmap functionality. (A) The _spatialHeatmap_ package plots numeric assay data onto spatially annotated images. The assay data can be provided as numeric vectors, tabular data, _SummarizedExperiment_, or _SingleCellExperiment_ objects. The latter two are widely used data containers for organizing both assays as well as associated annotation data and experimental designs. (B) Anatomical and other spatial images need to be provided as annotated SVG (aSVG) files where the spatial features and the corresponding components of the assay data have matching labels (_e.g._ tissue labels). To work with SVG data efficiently, the _SVG_ S4 class container has been developed. The assay data are used to color the matching spatial features in aSVG images according to a color key. (C)-(D) The result is called a spatial heatmap (SHM). (E) Large-scale data mining such as hierarchical clustering and network analysis can be integrated to facilitate the identification of biomolecules with similar abundance profiles. Moreover, (E) Single cell embedding results can be co-visualized with SHMs.")----
include_graphics('img/graphical_overview_shm.jpg')

## ----eval=TRUE, echo=TRUE, warnings=FALSE, results='hide'---------------------
library(spatialHeatmap); library(SummarizedExperiment); library(ExpressionAtlas); library(GEOquery); library(igraph); library(BiocParallel); library(kableExtra); library(org.Hs.eg.db); library(org.Mm.eg.db); library(ggplot2)

## ----eval=FALSE, echo=TRUE, warnings=FALSE------------------------------------
# browseVignettes('spatialHeatmap')

## ----eval=TRUE, echo=TRUE, message=FALSE, warnings=FALSE----------------------
cache.pa <- '~/.cache/shm' # Path of the cache directory.

## ----eval=TRUE, echo=TRUE, message=FALSE, warnings=FALSE----------------------
tmp.dir <- normalizePath(tempdir(check=TRUE), winslash="/", mustWork=FALSE)

## ----eval=TRUE, echo=TRUE, warnings=FALSE, results='hide'---------------------
svg.hum.pa <- system.file("extdata/shinyApp/data", 'homo_sapiens.brain.svg', package="spatialHeatmap")
svg.hum <- read_svg(svg.hum.pa)

## ----eval=TRUE, echo=TRUE, warnings=FALSE, collapse=TRUE----------------------
feature.hum <- attribute(svg.hum)[[1]]
tail(feature.hum[, 1:6], 3) # Partial features and respective attributes

## ----eval=TRUE, echo=TRUE, warnings=FALSE, collapse=TRUE----------------------
coord.df <- coordinate(svg.hum)[[1]]
tail(coord.df, 3) # Partial features and respective coordinates

## ----eval=TRUE, echo=TRUE, warnings=FALSE, collapse=TRUE----------------------
set.seed(20) # To obtain reproducible results, a fixed seed is set.
unique(feature.hum$feature)[1:10]
my_vec <- setNames(sample(1:100, 4), c('substantia.nigra', 'putamen', 'prefrontal.cortex', 'notMapped'))
my_vec

## ----eval=TRUE, echo=TRUE, warnings=FALSE, collapse=TRUE----------------------
dat.quick <- SPHM(svg=svg.hum, bulk=my_vec)

## ----testshm, eval=TRUE, echo=TRUE, warnings=FALSE, fig.wide=TRUE, results='hide', fig.cap=("SHM of human brain with testing data. The plots from the left to the right represent the color key for the numeric data, followed by four SHM plots and the legend of the spatial features. The numeric values provided in `my_vec` are used to color the corresponding features in the SHM plots according to the color key while the legend plot identifies the spatial regions."), out.width="100%"----
shm.res <- shm(data=dat.quick, ID='testing', ncol=1, sub.title.size=20, legend.nrow=3)

## ----eval=TRUE, echo=TRUE, warnings=FALSE, collapse=TRUE----------------------
# Mapped features
spatialHeatmap::output(shm.res)$mapped_feature

## ----eval=TRUE, echo=TRUE, message=FALSE, warnings=FALSE, results='hide'------
all.hum <- read_cache(cache.pa, 'all.hum') # Retrieve data from cache.
if (is.null(all.hum)) { # Save downloaded data to cache if it is not cached.
  all.hum <- searchAtlasExperiments(properties="cerebellum", species="Homo sapiens")
  save_cache(dir=cache.pa, overwrite=TRUE, all.hum)
}

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
all.hum[2, ]

## ----eval=TRUE, echo=TRUE, warnings=FALSE, results='hide'---------------------
rse.hum <- read_cache(cache.pa, 'rse.hum') # Read data from cache.
if (is.null(rse.hum)) { # Save downloaded data to cache if it is not cached.
  rse.hum <- getAtlasData('E-GEOD-67196')[[1]][[1]]
  save_cache(dir=cache.pa, overwrite=TRUE, rse.hum)
}

## ----eval=TRUE, echo=TRUE, warnings=FALSE, collapse=TRUE----------------------
colData(rse.hum)[1:2, c(2, 4)]

## ----eval=FALSE, echo=TRUE, warnings=FALSE------------------------------------
# # Remote aSVG repos.
# data(aSVG.remote.repo)
# tmp.dir.ebi <- file.path(tmp.dir, 'ebi.zip')
# tmp.dir.shm <- file.path(tmp.dir, 'shm.zip')
# # Download the remote aSVG repos as zip files.
# download.file(aSVG.remote.repo$ebi, tmp.dir.ebi)
# download.file(aSVG.remote.repo$shm, tmp.dir.shm)
# remote <- list(tmp.dir.ebi, tmp.dir.shm)

## ----eval=TRUE, echo=TRUE, warnings=FALSE, results='hide'---------------------
tmp.dir <- file.path(tempdir(check=TRUE), 'shm') # Empty directory. 

## ----eval=FALSE, echo=TRUE, warnings=FALSE, results='hide'--------------------
# feature.df.hum <- return_feature(feature=c('frontal cortex', 'cerebellum'), species=c('homo sapiens', 'brain'), dir=tmp.dir, remote=remote) # Query aSVGs
# feature.df.hum[1:8, ] # Return first 8 rows for checking
# unique(feature.df.hum$SVG) # Return all matching aSVGs

## ----eval=TRUE, echo=TRUE, warnings=FALSE, results='hide'---------------------
svg.dir <- system.file("extdata/shinyApp/data", package="spatialHeatmap") # Directory of the aSVG collection in spatialHeatmap
feature.df.hum <- return_feature(feature=c('frontal cortex', 'cerebellum'), species=c('homo sapiens', 'brain'), keywords.any=TRUE, return.all=FALSE, dir=svg.dir, remote=NULL)

## ----eval=TRUE, echo=TRUE, warnings=FALSE, collapse=TRUE----------------------
tail(feature.df.hum[, c('feature', 'stroke', 'SVG')], 3)

## ----eval=TRUE, echo=TRUE, warnings=FALSE, collapse=TRUE----------------------
hum.tar <- system.file('extdata/shinyApp/data/target_human.txt', package='spatialHeatmap')
target.hum <- read.table(hum.tar, header=TRUE, row.names=1, sep='\t') # Importing
colData(rse.hum) <- DataFrame(target.hum) # Loading to "colData"
colData(rse.hum)[c(1:2, 41:42), 4:5]

## ----eval=TRUE, echo=TRUE, warnings=FALSE, results='hide'---------------------
se.nor.hum <- norm_data(data=rse.hum, norm.fun='ESF', log2.trans=TRUE)

## ----eval=TRUE, echo=TRUE, warnings=FALSE, results='hide'---------------------
se.aggr.hum <- aggr_rep(data=se.nor.hum, sam.factor='organism_part', con.factor='disease', aggr='mean')
assay(se.aggr.hum)[c(120, 49939, 49977), ]

## ----humtab, eval=TRUE, echo=FALSE, warnings=FALSE----------------------------
cna <- c("cerebellum\\_\\_ALS", "frontal.cortex\\_\\_ALS", "cerebellum\\_\\_normal", "frontal.cortex\\_\\_normal")
kable(assay(se.aggr.hum)[c(120, 49939, 49977), ], caption='Slice of aggregated expression matrix.', col.names=cna, escape=TRUE, row.names=TRUE) %>% kable_styling("striped", full_width = FALSE) %>% scroll_box(width = "700px", height = "220px")

## ----eval=TRUE, echo=TRUE, warnings=FALSE, results='hide'---------------------
se.fil.hum <- filter_data(data=se.aggr.hum, sam.factor='organism_part', con.factor='disease', pOA=c(0.01, 5), CV=c(0.3, 100))
se.fil.hum <- cvt_id(db='org.Hs.eg.db', data=se.fil.hum, from.id='ENSEMBL', to.id='SYMBOL')

## ----eval=TRUE, echo=TRUE, warnings=FALSE, collapse=TRUE----------------------
# Subsetting aSVG features.
svg.hum.sub <- sub_sf(svg.hum, show=c(64:132, 162:163, 164, 190:218))
tail(attribute(svg.hum.sub)[[1]][, 1:6], 3)
# Storing assay data and subsetted aSVG in an 'SPHM' object.
dat.hum <- SPHM(svg=svg.hum.sub, bulk=se.fil.hum)

## ----mul, eval=TRUE, echo=TRUE, warnings=FALSE, fig.wide=TRUE, fig.cap=("SHMs of two genes. The subplots are organized by 'condition'. Only cerebellum and frontal cortex are colored, because they are present in both the aSVG and the expression data."), out.width="100%", results='hide'----
res.hum <- shm(data=dat.hum, ID=c('OLFM4', 'PRSS22'), lay.shm='con', legend.r=1.5, legend.nrow=3, h=0.6)

## ----eval=FALSE, echo=TRUE, warnings=FALSE, results='hide'--------------------
# shm(data=dat.hum, ID=c('OLFM4', 'PRSS22'), lay.shm='con', legend.r=1.5, legend.nrow=3, h=0.6, aspr=2.3, animation.scale=0.7, bar.width=0.1, bar.value.size=4, out.dir=tmp.dir)

## ----eval=FALSE, echo=TRUE, warnings=FALSE, results='hide'--------------------
# res <- shm(data=dat.hum, ID=c('OLFM4', 'PRSS22'), lay.shm='con', legend.r=1.5, legend.nrow=3, h=0.5, aspr=2.3, animation.scale=0.7, bar.width=0.08, bar.value.size=12)
# ggsave(file="./shm_hum.svg", plot=output(res)$spatial_heatmap, width=10, height=8)

## ----eval=FALSE, echo=TRUE, warnings=FALSE, results='hide'--------------------
# write_svg(input=res, out.dir=tmp.dir)

## ----eval=FALSE, echo=TRUE, warnings=FALSE, results='hide'--------------------
# Rscript -e "spatialHeatmap::plot_meta(svg.path=system.file('extdata/shinyApp/data', 'mus_musculus.brain.svg', package='spatialHeatmap'), bulk=system.file('extdata/shinyApp/data', 'bulk_mouse_cocluster.rds', package='spatialHeatmap'), sam.factor='tissue', aggr='mean', ID=c('AI593442', 'Adora1'), ncol=1, bar.width=0.1, legend.nrow=5, h=0.6)"

## ----arg, eval=TRUE, echo=FALSE, warnings=FALSE-------------------------------
arg.df <- read.table('file/spatial_hm_arg.txt', header=TRUE, row.names=1, sep='\t')
kable(arg.df, caption='List of important argumnets of \'shm\'.', col.names=colnames(arg.df), row.names=TRUE, escape=TRUE) %>% kable_styling("striped", full_width = FALSE) %>% scroll_box(width = "650px", height = "230px")  

## ----eval=TRUE, echo=TRUE, warnings=FALSE, results='hide'---------------------
all.mus <- read_cache(cache.pa, 'all.mus') # Retrieve data from cache.
if (is.null(all.mus)) { # Save downloaded data to cache if it is not cached.
  all.mus <- searchAtlasExperiments(properties="kidney", species="Mus musculus")
  save_cache(dir=cache.pa, overwrite=TRUE, all.mus)
}

## ----eval=TRUE, echo=TRUE, warnings=FALSE, results='hide'---------------------
all.mus[7, ]
rse.mus <- read_cache(cache.pa, 'rse.mus') # Read data from cache.
if (is.null(rse.mus)) { # Save downloaded data to cache if it is not cached.
  rse.mus <- getAtlasData('E-MTAB-2801')[[1]][[1]]
  save_cache(dir=cache.pa, overwrite=TRUE, rse.mus)
}

## ----eval=TRUE, echo=TRUE, warnings=FALSE, collapse=TRUE----------------------
colData(rse.mus)[1:3, ]

## ----eval=FALSE, echo=TRUE, warnings=FALSE, results='hide'--------------------
# feature.df.mus <- return_feature(feature=c('heart', 'kidney'), species=c('Mus musculus'), dir=tmp.dir, remote=remote)

## ----eval=TRUE, echo=TRUE, warnings=FALSE, results='hide'---------------------
feature.df.mus <- return_feature(feature=c('heart', 'kidney'), species=NULL, dir=svg.dir, remote=NULL) 

## ----eval=TRUE, echo=TRUE, warnings=FALSE, collapse=TRUE----------------------
unique(feature.df.mus$SVG)

## ----eval=TRUE, echo=TRUE, warnings=FALSE, results='hide'---------------------
svg.mus.pa <- system.file("extdata/shinyApp/data", "mus_musculus.male.svg", package="spatialHeatmap")
svg.mus <- read_svg(svg.mus.pa)

## ----eval=TRUE, echo=TRUE, warnings=FALSE, collapse=TRUE----------------------
mus.tar <- system.file('extdata/shinyApp/data/target_mouse.txt', package='spatialHeatmap')
target.mus <- read.table(mus.tar, header=TRUE, row.names=1, sep='\t') # Importing
colData(rse.mus) <- DataFrame(target.mus) # Loading
target.mus[1:3, ]

## ----eval=TRUE, echo=TRUE, warnings=FALSE, results='hide'---------------------
rse.mus <- cvt_id(db='org.Mm.eg.db', data=rse.mus, from.id='ENSEMBL', to.id='SYMBOL', desc=TRUE) # Convert Ensembl ids to UniProt ids.  
se.nor.mus <- norm_data(data=rse.mus, norm.fun='CNF', log2.trans=TRUE) # Normalization
se.aggr.mus <- aggr_rep(data=se.nor.mus, sam.factor='organism_part', con.factor='strain', aggr='mean') # Aggregation of replicates
se.fil.mus <- filter_data(data=se.aggr.mus, sam.factor='organism_part', con.factor='strain', pOA=c(0.01, 5), CV=c(0.6, 100)) # Filtering of genes with low counts and variance 

## ----musshm, eval=TRUE, echo=TRUE, warnings=FALSE, fig.wide=TRUE, fig.cap=("SHM of mouse organs. This is a multiple-layer image where the shapes of the 'skeletal muscle' is set transparent to expose 'lung' and 'heart'."), out.width="100%", results='hide'----
dat.mus <- SPHM(svg=svg.mus, bulk=se.fil.mus)
shm(data=dat.mus, ID=c('H19'), legend.width=0.7, legend.text.size=10, sub.title.size=9, ncol=3, ft.trans=c('skeletal muscle'), legend.ncol=2, line.size=0.2, line.color='grey70')

## ----musshm1, eval=TRUE, echo=TRUE, warnings=FALSE, fig.wide=TRUE, fig.cap=("SHM of mouse organs. This is a multiple-layer image where the view onto 'lung' and 'heart' is obstructed by displaying the 'skeletal muscle' tissue."), out.width="100%", fig.show='show', results='hide'----
gg <- shm(data=dat.mus, ID=c('H19'), legend.text.size=10, sub.title.size=9, ncol=3, legend.ncol=2, line.size=0.1, line.color='grey70')

## ----eval=TRUE, echo=TRUE, warnings=FALSE, results='hide'---------------------
gset <- read_cache(cache.pa, 'gset') # Retrieve data from cache.
if (is.null(gset)) { # Save downloaded data to cache if it is not cached.
  gset <- getGEO("GSE14502", GSEMatrix=TRUE, getGPL=TRUE)[[1]]
  save_cache(dir=cache.pa, overwrite=TRUE, gset)
}
se.sh <- as(gset, "SummarizedExperiment")

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
rownames(se.sh) <- make.names(rowData(se.sh)[, 'Gene.Symbol'])

## ----eval=TRUE, echo=TRUE, warnings=FALSE, collapse=TRUE----------------------
colData(se.sh)[60:63, 1:2]

## ----eval=TRUE, echo=TRUE, warnings=FALSE, results='hide'---------------------
svg.sh.pa <- system.file("extdata/shinyApp/data", "arabidopsis.thaliana_shoot_shm.svg", package="spatialHeatmap")
svg.sh <- read_svg(svg.sh.pa)

## ----eval=TRUE, echo=TRUE, warnings=FALSE, collapse=TRUE----------------------
sh.tar <- system.file('extdata/shinyApp/data/target_arab.txt', package='spatialHeatmap')
target.sh <- read.table(sh.tar, header=TRUE, row.names=1, sep='\t') # Importing
colData(se.sh) <- DataFrame(target.sh) # Loading
target.sh[60:63, ]

## ----eval=TRUE, echo=TRUE, warnings=FALSE, results='hide'---------------------
se.aggr.sh <- aggr_rep(data=se.sh, sam.factor='samples', con.factor='conditions', aggr='mean') # Replicate agggregation using mean
se.fil.arab <- filter_data(data=se.aggr.sh, sam.factor='samples', con.factor='conditions', pOA=c(0.03, 6), CV=c(0.30, 100)) # Filtering of genes with low intensities and variance

## ----shshm, eval=TRUE, echo=TRUE, warnings=FALSE, fig.wide=TRUE, fig.cap=('SHM of Arabidopsis shoots. The expression profile of the HRE2 gene is plotted for control and hypoxia treatment across six cell types.'), out.width="100%", results='hide'----
dat.sh <- SPHM(svg=svg.sh, bulk=se.fil.arab)
shm(data=dat.sh, ID=c("HRE2"), legend.ncol=2, legend.text.size=10, legend.key.size=0.02)

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
raster.pa1 <- system.file('extdata/shinyApp/data/maize_leaf_shm1.png', package='spatialHeatmap')
svg.pa1 <- system.file('extdata/shinyApp/data/maize_leaf_shm1.svg', package='spatialHeatmap')

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
raster.pa2 <- system.file('extdata/shinyApp/data/maize_leaf_shm2.png', package='spatialHeatmap')
svg.pa2 <- system.file('extdata/shinyApp/data/maize_leaf_shm2.svg', package='spatialHeatmap')

## ----eval=TRUE, echo=TRUE, warnings=FALSE, results='hide'---------------------
svg.overlay <- read_svg(svg.path=c(svg.pa1, svg.pa2), raster.path=c(raster.pa1, raster.pa2))

## ----eval=TRUE, echo=TRUE, warnings=FALSE, collapse=TRUE----------------------
attribute(svg.overlay)[[1]][1:3, ]

## ----eval=TRUE, echo=TRUE, warnings=FALSE, collapse=TRUE----------------------
df.ovl <- data.frame(matrix(runif(6, min=0, max=5), nrow=3))
colnames(df.ovl) <- c('cell1', 'cell2') # Assign column names.
rownames(df.ovl) <- paste0('gene', seq_len(3)) # Assign row names 
df.ovl[1:2, ]

## ----overCol, eval=TRUE, echo=TRUE, warnings=FALSE, fig.wide=TRUE, fig.cap=('Superimposing raster images with SHMs (colorful backaground). The expression profiles of gene1 are plotted on ABS cells.'), out.width="80%", fig.show='show', results='hide'----
dat.over <- SPHM(svg=svg.overlay, bulk=df.ovl)
shm(data=dat.over, charcoal=FALSE, ID=c('gene1'), alpha.overlay=0.5, bar.width=0.09, sub.title.vjust=4, legend.r=0.2)

## ----overChar, eval=TRUE, echo=TRUE, warnings=FALSE, fig.wide=TRUE, fig.cap=('Superimposing raster images with SHMs (black and white background). The expression profiles of gene1 are plotted on ABS cells.'), out.width="80%", fig.show='show', results='hide'----
shm(data=dat.over, charcoal=TRUE, ID=c('gene1'), alpha.overlay=0.5, bar.width=0.09, sub.title.vjust=4, legend.r=0.2)

## ----eval=TRUE, echo=TRUE, warnings=FALSE, results='hide'---------------------
se.mus.vars <- readRDS(system.file('extdata/shinyApp/data/mus_brain_vars_se.rds', package='spatialHeatmap'))

## ----eval=TRUE, echo=TRUE, warnings=FALSE, collapse=TRUE----------------------
colData(se.mus.vars)[1:3, ]
unique(colData(se.mus.vars)$comVar)

## ----eval=TRUE, echo=TRUE, warnings=FALSE, collapse=TRUE----------------------
se.mus.vars.nor <- norm_data(data=se.mus.vars, norm.fun='ESF', log2.trans=TRUE) # Normalization.
se.mus.vars.aggr <- aggr_rep(data=se.mus.vars.nor, sam.factor='tissue', con.factor='comVar', aggr='mean') # Aggregate replicates.
assay(se.mus.vars.aggr)[1:3, 1:3]

## ----eval=TRUE, echo=TRUE, warnings=FALSE, results='hide'---------------------
svg.mus.brain.pa <- system.file("extdata/shinyApp/data", "mus_musculus.brain.svg", package="spatialHeatmap")
svg.mus.brain <- read_svg(svg.mus.brain.pa)

## ----eval=TRUE, echo=TRUE, warnings=FALSE, collapse=TRUE----------------------
tail(attribute(svg.mus.brain)[[1]], 3)

## ----dimshm, eval=TRUE, echo=TRUE, warnings=FALSE, fig.wide=TRUE, fig.cap=("SHM plots of multiple variable. Gene expression values of `Acnat1` in hippocampus and hypothalamus under composite variables are mapped to corresponding aSVG features. "), out.width="100%", results='hide'----
dat.mul.dim <- SPHM(svg=svg.mus.brain, bulk=se.mus.vars.aggr)
shm(data=dat.mul.dim, ID=c('Acnat1'), legend.r=1.5, legend.key.size=0.02, legend.text.size=12, legend.nrow=3)

## ----eval=TRUE, echo=TRUE, warnings=FALSE, collapse=TRUE----------------------
df.random <- data.frame(matrix(runif(50, min=0, max=10), nrow=10))
colnames(df.random) <- c('shoot_totalA__treatment1', 'shoot_totalA__treatment2', 'shoot_totalB__treatment1', 'shoot_totalB__treatment2', 'notMapped') # Assign column names
rownames(df.random) <- paste0('gene', 1:10) # Assign row names 
df.random[1:2, ]

## ----eval=TRUE, echo=TRUE, warnings=FALSE, results='hide'---------------------
svg.sh1 <- system.file("extdata/shinyApp/data", "arabidopsis.thaliana_organ_shm1.svg", package="spatialHeatmap")
svg.sh2 <- system.file("extdata/shinyApp/data", "arabidopsis.thaliana_organ_shm2.svg", package="spatialHeatmap")
svg.sh.mul <- read_svg(c(svg.sh1, svg.sh2))

## ----arabshm, eval=TRUE, echo=TRUE, warnings=FALSE, fig.wide=TRUE, fig.cap=("Spatial heatmap of Arabidopsis at two growth stages. The expression profile of 'gene2' under condition1 and condition2 is plotted for two growth stages (top and bottom row)."), out.width="100%", fig.show='show', results='hide'----
dat.mul.svg <- SPHM(svg=svg.sh.mul, bulk=df.random)
shm(data=dat.mul.svg, ID=c('gene2'), width=0.7, legend.r=0.2, legend.width=1, preserve.scale=TRUE, bar.width=0.09, line.color='grey50') 

## ----eval=TRUE, echo=TRUE, warnings=FALSE, collapse=TRUE----------------------
sub.mus <- sf_var(data=rse.mus, feature='organism_part', ft.sel=c('brain', 'lung', 'colon', 'kidney', 'liver'), variable='strain', var.sel=c('DBA.2J', 'C57BL.6', 'CD1'), com.by='ft')
colData(sub.mus)[1:3, c('organism_part', 'strain')]

## ----eval=TRUE, echo=TRUE, warnings=FALSE, results='hide'---------------------
sub.mus.fil <- filter_data(data=sub.mus, pOA=c(0.5, 15), CV=c(0.8, 100), verbose=FALSE)

## ----eval=TRUE, echo=TRUE, warnings=FALSE, results='hide'---------------------
enr.res <- spatial_enrich(sub.mus.fil, method=c('edgeR'), norm='TMM', log2.fc=1, fdr=0.05, outliers=1)

## ----enOvl, eval=TRUE, echo=TRUE, warnings=FALSE, fig.wide=TRUE, fig.cap=('Overlap of enriched biomolecules across spatial features.'), out.width="100%", fig.show='show', results='hide'----
ovl_enrich(enr.res, type='up', plot='upset')

## ----eval=TRUE, echo=TRUE, warnings=FALSE, collapse=TRUE----------------------
en.brain <- query_enrich(enr.res, 'brain')
up.brain <- subset(rowData(en.brain), type=='up' & total==4)
up.brain[1:2, 1:3] # Enriched.
dn.brain <- subset(rowData(en.brain), type=='down' & total==4)
dn.brain[1:2, 1:3] # Depleted. 

## ----enr, eval=TRUE, echo=TRUE, warnings=FALSE, fig.wide=TRUE, fig.cap=('Enrichment SHMs. Top row: SHMs of spatially-enriched gene. Bottom row: SHMs of spatially-depleted gene.'), out.width="100%", fig.show='show'----
dat.enrich <- SPHM(svg=svg.mus, bulk=en.brain)
shm(data=dat.enrich, ID=c('Kif5c', 'Cdhr5'), legend.r=1, legend.nrow=7, sub.title.size=15, ncol=3, bar.width=0.09, lay.shm='gene')

## ----prof, eval=TRUE, echo=TRUE, warnings=FALSE, fig.wide=TRUE, fig.cap=('Line graph of gene expression profiles.'), out.width="100%", fig.show='show'----
graph_line(assay(en.brain)[c('Kif5c', 'Cdhr5'), ], lgd.pos='right')

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
sub.mat <- submatrix(data=se.fil.mus, ID='Kif5c', p=0.15)

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
assay(sub.mat)[1:2, 1:3] # Subsetted assay matrix

## ----static, eval=TRUE, echo=TRUE, warnings=FALSE, fig.cap=("Matrix Heatmap. Rows are genes and columns are samples. The query gene is tagged by black lines."), out.width='100%'----
res.hc <- matrix_hm(ID=c('Kif5c'), data=sub.mat, angleCol=60, angleRow=60, cexRow=0.8, cexCol=0.8, margin=c(10, 6), static=TRUE, arg.lis1=list(offsetRow=0.01, offsetCol=0.01))

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
cut_dendro(res.hc$rowDendrogram, h=15, 'Kif5c')

## ----eval=TRUE, echo=TRUE, warnings=FALSE, results='hide'---------------------
adj.mod <- adj_mod(data=sub.mat)

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
adj.mod[['adj']][1:3, 1:3]

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
adj.mod[['mod']][1:3, ] 

## ----inter, eval=TRUE, echo=TRUE, warnings=FALSE, fig.cap=("Static network. Node size denotes gene connectivity while edge thickness stands for co-expression similarity.")----
network(ID="Kif5c", data=sub.mat, adj.mod=adj.mod, adj.min=0, vertex.label.cex=1.2, vertex.cex=3, edge.cex=3, mar.key=c(3, 10, 1, 10), static=TRUE)

## ----eval=FALSE, echo=TRUE, warnings=FALSE------------------------------------
# network(ID="Kif5c", data=sub.mat, adj.mod=adj.mod, desc='desc', static=FALSE)

## ----eval=FALSE, echo=TRUE, warnings=FALSE------------------------------------
# shiny_shm()

## ----shiny, echo=FALSE, fig.wide=TRUE, fig.cap=("Screenshot of spatialHeatmap's Shiny App."), out.width="100%"----
include_graphics('img/shiny.jpg')

## ----eval=FALSE, echo=TRUE, warnings=FALSE------------------------------------
# se.fil.arab <- filter_data(data=se.aggr.sh, desc="Target.Description", sam.factor='samples', con.factor='conditions', pOA=c(0.03, 6), CV=c(0.30, 100), file='./filtered_data.txt')

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
vec <- sample(x=1:100, size=5) # Random numeric values
names(vec) <- c('putamen__variable1', 'putamen__variable2', 'prefrontal.cortex__variable1', 'prefrontal.cortex__variable2', 'notMapped') # Assign unique names to random values
vec

## ----vecshm, eval=FALSE, echo=TRUE, warnings=FALSE, fig.wide=FALSE, fig.cap=c('SHMs created with a vector. '), results='hide'----
# dat.vec <- SPHM(svg=svg.hum, bulk=vec)
# shm(data=dat.vec, ID='testing', ncol=1, legend.r=1.2, sub.title.size=14, ft.trans='g4320', legend.nrow=3)

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
df.test <- data.frame(matrix(sample(x=1:1000, size=100), nrow=20)) # Create numeric data.frame
colnames(df.test) <- names(vec) # Assign column names
rownames(df.test) <- paste0('gene', 1:20) # Assign row names
df.test[1:3, ]

## ----dfshm, eval=FALSE, echo=TRUE, warnings=FALSE, fig.wide=FALSE, fig.cap=c('SHMs created with a `data.frame`.'), results='hide'----
# dat.df <- SPHM(svg=svg.hum, bulk=df.test)
# shm(data=dat.df, ID=c('gene1'), ncol=1, legend.r=1.2, sub.title.size=14, legend.nrow=3)

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
df.test$ann <- paste0('ann', 1:20)
df.test[1:3, ]

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
spft <- c(rep('putamen', 4), rep('prefrontal.cortex', 4))
vars <- rep(c('variable1', 'variable1', 'variable2', 'variable2'), 2)
target.test <- data.frame(spFeature=spft, variable=vars, row.names=paste0('assay', 1:8))
target.test

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
df.se <- data.frame(matrix(sample(x=1:1000, size=160), nrow=20))
rownames(df.se) <- paste0('gene', 1:20)
colnames(df.se) <- row.names(target.test)
df.se[1:3, ]

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
se <- SummarizedExperiment(assays=df.se, colData=target.test)
se

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
rowData(se) <- df.test['ann']

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
se.aggr <- aggr_rep(data=se, sam.factor='spFeature', con.factor='variable', aggr='mean')
assay(se.aggr)[1:2, ]

## ----seshm, eval=FALSE, echo=TRUE, warnings=FALSE, fig.wide=FALSE, fig.cap=c('SHMs created with a `SummarizedExperiment` object.'), results='hide'----
# dat.se <- SPHM(svg=svg.hum, bulk=se.aggr)
# shm(data=dat.se, ID=c('gene1'), ncol=1, legend.r=1.2, sub.title.size=14, ft.trans=c('g4320'), legend.nrow=3)

## ----eval=FALSE, echo=TRUE, warnings=FALSE------------------------------------
# tmp.dir1 <- file.path(tempdir(check=TRUE), 'shm1')
# if (!dir.exists(tmp.dir1)) dir.create(tmp.dir1)
# svg.hum.pa <- system.file("extdata/shinyApp/data", 'homo_sapiens.brain.svg', package="spatialHeatmap")
# file.copy(from=svg.hum.pa, to=tmp.dir1, overwrite=TRUE) # Copy "homo_sapiens.brain.svg" file into 'tmp.dir1'

## ----eval=FALSE, echo=TRUE, warnings=FALSE, results='hide'--------------------
# feature.df <- return_feature(feature=c('frontal cortex', 'prefrontal cortex'), species=c('homo sapiens', 'brain'), dir=tmp.dir1, remote=NULL, keywords.any=FALSE)
# feature.df

## ----eval=FALSE, echo=TRUE, warnings=FALSE------------------------------------
# f.new <- c('prefrontalCortex', 'frontalCortex')

## ----eval=FALSE, echo=TRUE, warnings=FALSE------------------------------------
# s.new <- c('0.05', '0.1') # New strokes.
# c.new <- c('red', 'green') # New colors.

## ----eval=FALSE, echo=TRUE, warnings=FALSE------------------------------------
# feature.df.new <- cbind(featureNew=f.new, strokeNew=s.new, colorNew=c.new, feature.df)
# feature.df.new

## ----eval=FALSE, echo=TRUE, warnings=FALSE------------------------------------
# update_feature(df.new=feature.df.new, dir=tmp.dir1)

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
remat.hum <- list(frontal.cortex=c('frontal.cortex', 'prefrontal.cortex'))

## ----shmNoMatch, eval=TRUE, echo=TRUE, warnings=FALSE, fig.wide=TRUE, fig.cap=("SHMs before re-matching."), out.width="100%", results='hide'----
dat.no.match <- SPHM(svg=svg.hum.sub, bulk=se.fil.hum)
shm(data=dat.no.match, ID=c('OLFM4'), lay.shm='con', ncol=1, legend.r=0.8, legend.nrow=2, h=0.6)

## ----remat, eval=TRUE, echo=TRUE, warnings=FALSE, fig.wide=TRUE, fig.cap=("SHMs after re-matching. The spatial feature `frontal.cortex` in assay data is re-matched to aSVG features `frontal.cortex` and `prefrontal.cortex`."), out.width="100%", results='hide'----
dat.rematch <- SPHM(svg=svg.hum.sub, bulk=se.fil.hum, match=remat.hum)
shm(data=dat.rematch, ID=c('OLFM4'), lay.shm='con', ncol=1, legend.r=0.8, legend.nrow=2, h=0.6)

## ----eval=TRUE, echo=TRUE, warnings=FALSE, results='hide'---------------------
all.chk <- read_cache(cache.pa, 'all.chk') # Retrieve data from cache.
if (is.null(all.chk)) { # Save downloaded data to cache if it is not cached.
  all.chk <- searchAtlasExperiments(properties="heart", species="gallus")
  save_cache(dir=cache.pa, overwrite=TRUE, all.chk)
}

## ----eval=TRUE, echo=TRUE, warnings=FALSE, results='hide'---------------------
all.chk[3, ]
rse.chk <- read_cache(cache.pa, 'rse.chk') # Read data from cache.
if (is.null(rse.chk)) { # Save downloaded data to cache if it is not cached.
  rse.chk <- getAtlasData('E-MTAB-6769')[[1]][[1]]
  save_cache(dir=cache.pa, overwrite=TRUE, rse.chk)
}

## ----eval=TRUE, echo=TRUE, warnings=FALSE-------------------------------------
colData(rse.chk)[1:3, ]

## ----eval=FALSE, echo=TRUE, warnings=FALSE, results='hide'--------------------
# tmp.dir <- file.path(tempdir(check=TRUE), 'shm')
# # Query aSVGs.
# feature.df <- return_feature(feature=c('heart', 'kidney'), species=c('gallus'), dir=tmp.dir, remote=remote)

## ----eval=TRUE, echo=TRUE, warnings=FALSE, results='hide'---------------------
feature.df <- return_feature(feature=c('heart', 'kidney'), species=c('gallus'), dir=svg.dir, remote=NULL)
feature.df[1:2, c('feature', 'stroke', 'SVG')] # A slice of the search result.

## ----eval=TRUE, echo=TRUE, warnings=FALSE, results='hide'---------------------
svg.chk.pa <- system.file("extdata/shinyApp/data", "gallus_gallus.svg", package="spatialHeatmap")
svg.chk <- read_svg(svg.chk.pa)

## ----eval=TRUE, echo=TRUE, warnings=FALSE, collapse=TRUE----------------------
chk.tar <- system.file('extdata/shinyApp/data/target_chicken.txt', package='spatialHeatmap')
target.chk <- read.table(chk.tar, header=TRUE, row.names=1, sep='\t') # Importing
colData(rse.chk) <- DataFrame(target.chk) # Loading
target.chk[1:3, ]

## ----eval=TRUE, echo=TRUE, warnings=FALSE, results='hide'---------------------
se.nor.chk <- norm_data(data=rse.chk, norm.fun='ESF', log2.trans=TRUE) # Normalization
se.aggr.chk <- aggr_rep(data=se.nor.chk, sam.factor='organism_part', con.factor='age', aggr='mean') # Replicate agggregation using mean 
se.fil.chk <- filter_data(data=se.aggr.chk, sam.factor='organism_part', con.factor='age', pOA=c(0.01, 5), CV=c(0.6, 100)) # Filtering of genes with low counts and varince

## ----chkshm, eval=TRUE, echo=TRUE, warnings=FALSE, fig.wide=TRUE, fig.cap=("Time course of chicken organs. The SHM shows the expression profile of a single gene across nine time points and four organs."), out.width="100%", results='hide'----
dat.chk <- SPHM(svg=svg.chk, bulk=se.fil.chk)
shm(data=dat.chk, ID='ENSGALG00000006346', width=0.9, legend.width=0.9, legend.r=1.5, sub.title.size=9, ncol=3, legend.nrow=3, label=TRUE, verbose=FALSE)

## ----eval=TRUE, echo=TRUE-----------------------------------------------------
sessionInfo()

