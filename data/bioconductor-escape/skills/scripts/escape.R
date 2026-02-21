# Code example from 'escape' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide", message=FALSE--------------------------------
knitr::opts_chunk$set(tidy=FALSE, error=FALSE, message=FALSE, warning=FALSE)
library(BiocStyle)

## ----eval=FALSE---------------------------------------------------------------
# devtools::install_github("BorchLab/escape")
# 
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("escape")

## -----------------------------------------------------------------------------
suppressPackageStartupMessages({
  pkgs <- c(
    "escape", "SingleCellExperiment", "scran", "Seurat", "SeuratObject",
    "RColorBrewer", "ggplot2"
  )
  invisible(lapply(pkgs, library, character.only = TRUE))
})

## -----------------------------------------------------------------------------
pbmc_small <- get("pbmc_small")
sce.pbmc <- as.SingleCellExperiment(pbmc_small, assay = "RNA")

## -----------------------------------------------------------------------------
data("escape.gene.sets", package="escape")

## ----eval=FALSE, include=FALSE------------------------------------------------
# gs <- getGeneSets(library = c("Library1", "Library2"))

## ----eval=FALSE---------------------------------------------------------------
# GS.hallmark <- getGeneSets(library = "H")

## ----eval=FALSE, tidy=FALSE---------------------------------------------------
# gene.sets <- list(Bcells = c("MS4A1","CD79B","CD79A","IGH1","IGH2"),
# 			            Myeloid = c("SPI1","FCER1G","CSF1R"),
# 			            Tcells = c("CD3E", "CD3D", "CD3G", "CD7","CD8A"))

## ----eval=FALSE, tidy=FALSE---------------------------------------------------
# GS.hallmark <- msigdbr(species  = "Homo sapiens",
#                        category = "H")

## ----tidy = FALSE-------------------------------------------------------------
enrichment.scores <- escape.matrix(pbmc_small, 
                                   gene.sets = escape.gene.sets, 
                                   groups = 1000, 
                                   min.size = 5)

ggplot(data = as.data.frame(enrichment.scores), 
      mapping = aes(enrichment.scores[,1], enrichment.scores[,2])) + 
  geom_point() + 
  theme_classic() + 
  xlab(colnames(enrichment.scores)[1]) + 
  ylab(colnames(enrichment.scores)[2]) 

## ----tidy=FALSE, eval=FALSE---------------------------------------------------
# enrichment.scores <- escape.matrix(pbmc_small,
#                                    gene.sets = escape.gene.sets,
#                                    groups = 1000,
#                                    min.size = 3,
#                                    BPPARAM = BiocParallel::SnowParam(workers = 2))

## ----tidy = FALSE-------------------------------------------------------------
pbmc_small <- runEscape(pbmc_small, 
                        method = "ssGSEA",
                        gene.sets = escape.gene.sets, 
                        groups = 1000, 
                        min.size = 3,
                        new.assay.name = "escape.ssGSEA")

sce.pbmc <- runEscape(sce.pbmc, 
                      method = "UCell",
                      gene.sets = escape.gene.sets, 
                      groups = 1000, 
                      min.size = 5,
                      new.assay.name = "escape.UCell")

## ----tidy = FALSE-------------------------------------------------------------
#Define color palette 
colorblind_vector <- hcl.colors(n=7, palette = "inferno", fixup = TRUE)

FeaturePlot(pbmc_small, "Proinflammatory") + 
  scale_color_gradientn(colors = colorblind_vector) + 
  theme(plot.title = element_blank())

## ----tidy=FALSE---------------------------------------------------------------
pbmc_small <- performNormalization(input.data = pbmc_small, 
                                   assay = "escape.ssGSEA", 
                                   gene.sets = escape.gene.sets)

## ----tidy=FALSE---------------------------------------------------------------
pbmc_small <- performNormalization(input.data = pbmc_small, 
                                   assay = "escape.ssGSEA", 
                                   gene.sets = escape.gene.sets, 
                                   scale.factor = pbmc_small$nFeature_RNA)

## ----tidy=FALSE---------------------------------------------------------------
heatmapEnrichment(pbmc_small, 
                  group.by = "ident",
                  gene.set.use = "all",
                  assay = "escape.ssGSEA")

## ----tidy=FALSE---------------------------------------------------------------
heatmapEnrichment(sce.pbmc, 
                  group.by = "ident",
                  assay = "escape.UCell",
                  scale = TRUE,
                  cluster.rows = TRUE,
                  cluster.columns = TRUE)

## -----------------------------------------------------------------------------
hcl.pals()

## ----tidy=FALSE---------------------------------------------------------------
heatmapEnrichment(pbmc_small, 
                  assay = "escape.ssGSEA",
                  palette = "Spectral") 

## ----tidy=FALSE---------------------------------------------------------------
heatmapEnrichment(sce.pbmc, 
                  group.by = "ident",
                  assay = "escape.UCell") + 
  scale_fill_gradientn(colors = rev(brewer.pal(11, "RdYlBu"))) 

## ----tidy=FALSE---------------------------------------------------------------
geyserEnrichment(pbmc_small,
                 assay = "escape.ssGSEA",
                 gene.set.use = "T1-Interferon")

## ----tidy=FALSE---------------------------------------------------------------
geyserEnrichment(pbmc_small,
                 assay = "escape.ssGSEA",
                 gene.set.use = "T1-Interferon",
                 order.by = "mean")

## ----tidy=FALSE---------------------------------------------------------------
geyserEnrichment(pbmc_small,
                 assay = "escape.ssGSEA",
                 gene.set.use = "T1-Interferon",
                 facet.by = "groups")

## ----tidy=FALSE---------------------------------------------------------------
geyserEnrichment(pbmc_small,
                 assay = "escape.ssGSEA",
                 gene.set.use = "T1-Interferon",
                 color.by  = "T1-Interferon")

## ----tidy=FALSE---------------------------------------------------------------
ridgeEnrichment(sce.pbmc,
                assay = "escape.UCell",
                gene.set.use = "T2_Interferon")

## ----tidy=FALSE---------------------------------------------------------------
ridgeEnrichment(sce.pbmc,
                assay = "escape.UCell",
                gene.set.use = "T2_Interferon",
                add.rug = TRUE,
                scale = TRUE)

## ----tidy=FALSE---------------------------------------------------------------
splitEnrichment(pbmc_small,
                assay = "escape.ssGSEA",
                gene.set.use = "Lipid-mediators",
                split.by = "groups")

## ----tidy=FALSE---------------------------------------------------------------
splitEnrichment(pbmc_small,
                assay = "escape.ssGSEA",
                gene.set.use = "Lipid-mediators",
                split.by = "ident",
                group.by = "groups")

## ----tidy=FALSE---------------------------------------------------------------
gseaEnrichment(pbmc_small,
               gene.set.use = "T2_Interferon",
               gene.sets    = escape.gene.sets,
               group.by     = "ident",
               summary.fun  = "mean",
               nperm        = 1000)

## ----tidy=FALSE, eval=FALSE---------------------------------------------------
# densityEnrichment(pbmc_small,
#                   gene.set.use = "T2_Interferon",
#                   gene.sets = escape.gene.sets)

## ----tidy=FALSE---------------------------------------------------------------
scatterEnrichment(pbmc_small, 
                  assay = "escape.ssGSEA",
                  x.axis = "T2-Interferon",
                  y.axis = "Lipid-mediators")

## ----tidy=FALSE---------------------------------------------------------------
scatterEnrichment(sce.pbmc, 
                  assay = "escape.UCell",
                  x.axis = "T2_Interferon",
                  y.axis = "Lipid_mediators",
                  style = "hex")

## ----tidy=FALSE---------------------------------------------------------------
pbmc_small <- performPCA(pbmc_small, 
                         assay = "escape.ssGSEA",
                         n.dim = 1:10)

## ----tidy=FALSE---------------------------------------------------------------
pcaEnrichment(pbmc_small, 
              dimRed = "escape.PCA",
              x.axis = "PC1",
              y.axis = "PC2")

## ----tidy=FALSE---------------------------------------------------------------
pcaEnrichment(pbmc_small, 
              dimRed = "escape.PCA",
              x.axis = "PC1",
              y.axis = "PC2",
              add.percent.contribution = TRUE,
              display.factors = TRUE,
              number.of.factors = 10)

## ----tidy=FALSE---------------------------------------------------------------
DEG.markers <- FindMarkers(pbmc_small, 
                           ident.1 = "0", 
                           ident.2 = "1")

GSEA.results <- enrichIt(input.data = DEG.markers, 
                         gene.sets = escape.gene.sets, 
                         ranking_fun = "signed_log10_p")               

head(GSEA.results)

## ----tidy=FALSE---------------------------------------------------------------
## (1) Bar plot –20 most significant per database
enrichItPlot(GSEA.results)               

## (2) Dot plot – coloured by –log10 padj, sized by core-hits
enrichItPlot(GSEA.results, "dot", top = 10) 

## (3) C-net plot – network of pathways ↔ leading-edge genes
enrichItPlot(GSEA.results, "cnet", top = 5) 

## ----tidy=FALSE---------------------------------------------------------------
pbmc_small <- performNormalization(pbmc_small, 
                                   assay = "escape.ssGSEA", 
                                   gene.sets = escape.gene.sets,
                                   make.positive = TRUE)

all.markers <- FindAllMarkers(pbmc_small, 
                              assay = "escape.ssGSEA_normalized", 
                              min.pct = 0,
                              logfc.threshold = 0)

head(all.markers)

## -----------------------------------------------------------------------------
sessionInfo()

