# Code example from 'SpaceMarkers_vignette' vignette. See references/ for full tutorial.

## ----global.options, include = FALSE------------------------------------------
knitr::opts_knit$set(
    collapse = TRUE,
    comment = "#>",
    fig.align   = 'center'
)

knitr::opts_chunk$set(out.extra = 'style="display:block; margin:auto;"')


## ----eval = FALSE-------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("SpaceMarkers")

## ----message = FALSE, warning = FALSE-----------------------------------------
library(SpaceMarkers)

## -----------------------------------------------------------------------------
data_dir <- "visiumBrCA"
unlink(file.path(data_dir), recursive = TRUE)
dir.create(data_dir,showWarnings = FALSE)
main_10xlink <- "https://cf.10xgenomics.com/samples/spatial-exp/1.3.0"
counts_folder <- "Visium_Human_Breast_Cancer"
counts_file <- "Visium_Human_Breast_Cancer_filtered_feature_bc_matrix.h5"
counts_url<-paste(c(main_10xlink,counts_folder,counts_file), collapse = "/")
sp_folder <- "Visium_Human_Breast_Cancer"
sp_file <- "Visium_Human_Breast_Cancer_spatial.tar.gz"
sp_url<-paste(c(main_10xlink,sp_folder,sp_file),collapse = "/")

## -----------------------------------------------------------------------------
download.file(counts_url,file.path(data_dir,basename(counts_url)), mode = "wb")
counts_matrix <- load10XExpr(visiumDir = data_dir, h5filename = counts_file)
good_gene_threshold <- 3
goodGenes <- rownames(counts_matrix)[
    apply(counts_matrix,1,function(x) sum(x>0)>=good_gene_threshold)]
counts_matrix <- counts_matrix[goodGenes,]

## -----------------------------------------------------------------------------
cogaps_result <- readRDS(system.file("extdata","CoGAPS_result.rds",
    package="SpaceMarkers",mustWork = TRUE))
features <- intersect(rownames(counts_matrix),rownames(
    slot(cogaps_result,"featureLoadings")))
barcodes <- intersect(colnames(counts_matrix),rownames(
    slot(cogaps_result,"sampleFactors")))
counts_matrix <- counts_matrix[features,barcodes]
cogaps_matrix<-slot(cogaps_result,"featureLoadings")[features,]%*%
    t(slot(cogaps_result,"sampleFactors")[barcodes,])

## -----------------------------------------------------------------------------
download.file(sp_url, file.path(data_dir,basename(sp_url)), mode = "wb")
untar(file.path(data_dir,basename(sp_url)), exdir = file.path(data_dir))
spCoords <- load10XCoords(visiumDir = data_dir, 
                          resolution="lowres", version = "1.0")
rownames(spCoords) <- spCoords$barcode
spCoords <- spCoords[barcodes,]
spPatterns <- cbind(spCoords,slot(cogaps_result,"sampleFactors")[barcodes,])
head(spPatterns)

## -----------------------------------------------------------------------------
data("curated_genes")
spPatterns <- spPatterns[c("barcode","y","x","Pattern_1","Pattern_5")]
counts_matrix <- counts_matrix[curated_genes,]
cogaps_matrix <- cogaps_matrix[curated_genes, ]

## -----------------------------------------------------------------------------
optParams <- get_spatial_params_morans_i(spPatterns,visiumDir = data_dir,
                                          resolution = "lowres")

## -----------------------------------------------------------------------------
SpaceMarkers <- get_pairwise_interacting_genes(data = counts_matrix,
                                    reconstruction = cogaps_matrix,
                                    optParams = optParams,
                                    spPatterns = spPatterns,
                                    mode ="residual",analysis="overlap")


## -----------------------------------------------------------------------------
print(head(SpaceMarkers[[1]]$interacting_genes[[1]]))
print(head(SpaceMarkers[[1]]$hotspots))

## -----------------------------------------------------------------------------
SpaceMarkers_DE <- get_pairwise_interacting_genes(
    data=counts_matrix,reconstruction=NULL,
    optParams = optParams,
    spPatterns = spPatterns,
    mode="DE",analysis="overlap")

## -----------------------------------------------------------------------------
residual_p1_p5<-SpaceMarkers[[1]]$interacting_genes[[1]]
DE_p1_p5<-SpaceMarkers_DE[[1]]$interacting_genes[[1]]

## -----------------------------------------------------------------------------
paste(
    "Residual mode identified",dim(residual_p1_p5)[1],
        "interacting genes,while DE mode identified",dim(DE_p1_p5)[1],
        "interacting genes",collapse = NULL)

## -----------------------------------------------------------------------------

compare_genes <- function(ref_list, list2,ref_name = "mode1",
                            list2_name = "mode2", sub_slice = NULL){
    ref_rank <- seq(1,length(ref_list),1)
    list2_ref_rank <- which(list2 %in% ref_list)
    list2_ref_genes <- list2[which(list2 %in% ref_list)]
    ref_genes_only <- ref_list[ !ref_list  %in% list2_ref_genes ]
    mode1 <- data.frame("Gene" = ref_list,"Rank" = ref_rank,"mode"= ref_name)
    mode2 <- data.frame("Gene" = c(list2_ref_genes, ref_genes_only),"Rank" = c(
        list2_ref_rank,rep(NA,length(ref_genes_only))),"mode"= list2_name)
    mode1_mode2 <- merge(mode1, mode2, by = "Gene", all = TRUE) 
    mode1_mode2 <- mode1_mode2[order(mode1_mode2$Rank.x),]
    mode1_mode2 <- subset(mode1_mode2,select = c("Gene","Rank.x","Rank.y"))
    colnames(mode1_mode2) <- c("Gene",paste0(ref_name,"_Rank"),
                                paste0(list2_name,"_Rank"))
    return(mode1_mode2)
}

## -----------------------------------------------------------------------------
res_to_DE <- compare_genes(head(residual_p1_p5$Gene, n = 20),DE_p1_p5$Gene,
                            ref_name="residual",list2_name="DE")
DE_to_res <- compare_genes(head(DE_p1_p5$Gene, n = 20),residual_p1_p5$Gene,
                            ref_name = "DE",list2_name = "residual")

## -----------------------------------------------------------------------------
res_to_DE

## -----------------------------------------------------------------------------
DE_to_res

## -----------------------------------------------------------------------------
SpaceMarkers_enrich <- get_pairwise_interacting_genes(data = counts_matrix,
                                    reconstruction = cogaps_matrix,
                                    optParams = optParams,
                                    spPatterns = spPatterns,
                                    mode ="residual",analysis="enrichment")
SpaceMarkers_DE_enrich <- get_pairwise_interacting_genes(
    data=counts_matrix,reconstruction=NULL,
    optParams = optParams,
    spPatterns = spPatterns,
    mode="DE",analysis="enrichment")
residual_p1_p5_enrichment<-SpaceMarkers_enrich[[1]]$interacting_genes[[1]]$Gene
DE_p1_p5_enrichment<-SpaceMarkers_DE_enrich[[1]]$interacting_genes[[1]]$Gene


## -----------------------------------------------------------------------------
enrich_res_to_de<-compare_genes(
    head(DE_p1_p5_enrichment, 20),
    residual_p1_p5_enrichment,
    ref_name="DE_Enrich",list2_name = "res_Enrich")
enrich_res_to_de

## -----------------------------------------------------------------------------
overlap_enrich_de<-compare_genes(
    head(DE_p1_p5_enrichment,20),
    DE_p1_p5$Gene,
    ref_name="DE_Enrich",
    list2_name="DE_Overlap")
overlap_enrich_de

## -----------------------------------------------------------------------------
tail(SpaceMarkers_DE_enrich[[1]]$interacting_genes[[1]])

## -----------------------------------------------------------------------------
overlap_enrich_res<-compare_genes(
    head(residual_p1_p5$Gene, 20),
    residual_p1_p5_enrichment,
    ref_name ="res_overlap",list2_name="res_enrich")
overlap_enrich_res

## ----message = FALSE, warning=FALSE-------------------------------------------
library(Matrix)
library(rjson)
library(cowplot)
library(RColorBrewer)
library(grid)
library(readbitmap)
library(dplyr)
library(data.table)
library(viridis)
library(ggplot2)

## -----------------------------------------------------------------------------
res_enrich <- SpaceMarkers_enrich[[1]]$interacting_genes[[1]]
hotspots <- SpaceMarkers_enrich[[1]]$hotspots
top <- res_enrich %>% arrange(-SpaceMarkersMetric)
print(head(top))

## -----------------------------------------------------------------------------
createInteractCol <- function(spHotspots, 
                              interaction_cols = c("T.cells","B-cells")){
  col1 <- spHotspots[,interaction_cols[1]]
  col2 <- spHotspots[,interaction_cols[2]]
  one <- col1
  two <- col2
  one[!is.na(col1)] <- "match"
  two[!is.na(col2)] <- "match"
  both_idx <- which(one == two)
  both <- col1
  both[both_idx] <- "interacting"
  one_only <- setdiff(which(!is.na(col1)),unique(c(which(is.na(col1)),
                                                   both_idx)))
  two_only <- setdiff(which(!is.na(col2)),unique(c(which(is.na(col2)),
                                                   both_idx)))
  both[one_only] <- interaction_cols[1]
  both[two_only] <- interaction_cols[2]
  both <- factor(both,levels = c(interaction_cols[1],"interacting",
                                 interaction_cols[2]))
  return(both)
}

#NB: Since we are likely to plot multipe genes, this function assumes an
#already transposed counts matrix. This saves time and memory in the long run
#for larger counts matrices
plotSpatialExpr <- function(data,gene,hotspots,patterns,
                               remove.na = TRUE,
                               title = "Expression (Log)", text_size = 15){
  counts <- data
  interact <- createInteractCol(spHotspots = hotspots,
                                interaction_cols = patterns)
  df <- cbind(counts,hotspots,data.frame("region" = interact))
  if (remove.na){
    df <- df[!is.na(df$region),]
  }
  p <- df %>% ggplot( aes_string(x='region',y=gene,
                                            fill='region')) + geom_violin() +
    scale_fill_viridis(discrete = TRUE,alpha=0.6) +
    geom_jitter(color="black",size=0.4,alpha=0.9) +
    theme(legend.position="none",plot.title = element_text(size=text_size),
            axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
    ggtitle(paste0(gene,": ",title)) + xlab("")
  return(p)
}




## -----------------------------------------------------------------------------
genes <- top$Gene
counts_df <- as.data.frame(as.matrix(
  t(counts_matrix[rownames(counts_matrix) %in% genes,])))


## ----suppressMessages=TRUE, warning=FALSE-------------------------------------
spatialMaps <- list()
exprPlots <- list()

for (g in genes){
  
    spatialMaps[[length(spatialMaps)+1]] <- suppressMessages(
        plot_spatial_data_over_image(visiumDir = data_dir,
                                                         df = cbind(spPatterns, counts_df),feature_col = g,
                                                         resolution="lowres",title = g))
  exprPlots[[length(exprPlots)+1]] <- plotSpatialExpr(
    data = counts_df,gene = g,hotspots = hotspots,
                   patterns = c("Pattern_1","Pattern_5"))
}

## ----message=FALSE, warning=FALSE, dpi=60, fig.width=6------------------------

plot_spatial_data_over_image(visiumDir = data_dir,
                         df = cbind(spPatterns, counts_df),
                         feature_col = "Pattern_1",
                         resolution="lowres",title = "Pattern_1")

## ----message=FALSE, warning=FALSE, dpi=60, fig.width=6------------------------


plot_spatial_data_over_image(visiumDir = data_dir,
                         df = cbind(spPatterns, counts_df),
                         feature_col = "Pattern_5",
                         resolution="lowres",title = "Pattern_5")


## ----message=FALSE, warning=FALSE, dpi=60, fig.width=6------------------------
plot_grid(plotlist = list(exprPlots[[1]],spatialMaps[[1]]))


## ----message=FALSE,dpi=60, fig.width=6----------------------------------------
plot_grid(plotlist = list(exprPlots[[3]],spatialMaps[[3]]))

## -----------------------------------------------------------------------------
bottom <- res_enrich %>% arrange(SpaceMarkersMetric)
print(head(bottom))

## ----warning=FALSE------------------------------------------------------------
g <- bottom$Gene[1]
p1 <- plotSpatialExpr(
    data = counts_df,gene = g,hotspots = hotspots, 
                   patterns = c("Pattern_1","Pattern_5"))
p2 <- plot_spatial_data_over_image(visiumDir = data_dir,
                         df = cbind(spPatterns, counts_df),
                         feature_col = g,
                         resolution="lowres",title = g)

plot_grid(plotlist = list(p1,p2))


## -----------------------------------------------------------------------------
unlink(file.path(data_dir), recursive = TRUE)

## ----echo=FALSE---------------------------------------------------------------
parameters = c('visiumDir', 'h5filename')
paramDescript = c('A string path to the h5 file with expression information',
                    'A string of the name of the h5 file in the directory')
paramTable = data.frame(parameters, paramDescript)
knitr::kable(paramTable, col.names = c("Argument","Description"))


## ----echo=FALSE---------------------------------------------------------------
parameters = c('visiumDir', 'resolution')
paramDescript = c(
'A path to the location of the the spatial coordinates folder.',
'String values to look for in the .json object;lowres or highres.')
paramTable = data.frame(parameters, paramDescript)
knitr::kable(paramTable, col.names = c("Argument","Description"))


## ----echo=FALSE---------------------------------------------------------------
parameters = c('spPatterns','visiumDir','spatialDir','pattern','sigma',
               'threshold','resolution')
paramDescript = c('A data frame of spatial coordinates and patterns.',
                  'A directory with the spatial and expression data for 
                  the tissue sample',
                  'A directory with spatial data for the tissue sample',
                  'A string of the .json filename with the image parameters',
                  'A numeric value specifying the kernel distribution width',
                  'A numeric value specifying the outlier threshold for the 
                  kernel',
                  'A string specifying the image resolution to scale')
paramTable = data.frame(parameters, paramDescript)
knitr::kable(paramTable, col.names = c("Argument","Description"))


## ----echo=FALSE---------------------------------------------------------------
parameters = c(
        'data','reconstruction', 'optParams','spPatterns',
        'mode', 'minOverlap','hotspotRegions','analysis')
paramDescript = c(
        'An expression matrix of genes and columns being the samples.',
        'Latent feature matrix. NULL if \'DE\' mode is specified',
        'A matrix of sigmaOpts (width) and the thresOpt (outlierthreshold)',
        'A data frame that contains of spatial coordinates and patterns.',
        'A string of the reference pattern for comparison to other patterns',
        'A string specifying either \'residual\' or \'DE\' mode.',
        'A value that specifies the minimum pattern overlap. 50 is the default',
        'A string specifying the type of analysis')
paramTable = data.frame(parameters, paramDescript)
knitr::kable(paramTable, col.names = c("Argument","Description"))


## -----------------------------------------------------------------------------
sessionInfo()

