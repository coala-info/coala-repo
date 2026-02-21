# Code example from 'vignette' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide", message=FALSE, warning=FALSE-----------------
knitr::opts_chunk$set(error=FALSE, message=FALSE, warning=FALSE, tidy = FALSE)
library(BiocStyle)
library(scater)
library(Seurat)
library(igraph)

## -----------------------------------------------------------------------------
suppressMessages(library(scRepertoire))

## ----eval=FALSE---------------------------------------------------------------
# S1 <- read.csv(".../Sample1/outs/filtered_contig_annotations.csv")
# S2 <- read.csv(".../Sample2/outs/filtered_contig_annotations.csv")
# S3 <- read.csv(".../Sample3/outs/filtered_contig_annotations.csv")
# S4 <- read.csv(".../Sample4/outs/filtered_contig_annotations.csv")
# 
# contig_list <- list(S1, S2, S3, S4)

## ----eval=FALSE, tidy = FALSE-------------------------------------------------
# # Directory example
# contig.output <- c("~/Documents/MyExperiment")
# contig.list <- loadContigs(input = contig.output,
#                            format = "TRUST4")

## ----eval = FALSE, tidy = FALSE-----------------------------------------------
# # List of data frames example
# S1 <- read.csv("~/Documents/MyExperiment/Sample1/outs/barcode_results.csv")
# S2 <- read.csv("~/Documents/MyExperiment/Sample2/outs/barcode_results.csv")
# S3 <- read.csv("~/Documents/MyExperiment/Sample3/outs/barcode_results.csv")
# S4 <- read.csv("~/Documents/MyExperiment/Sample4/outs/barcode_results.csv")
# 
# contig.list <- list(S1, S2, S3, S4)
# contig.list <- loadContigs(input = contig.list,
#                            format = "WAT3R")

## ----eval = F, tidy = FALSE---------------------------------------------------
# contigs <- read.csv(".../outs/filtered_contig_annotations.csv")
# 
# contig.list <- createHTOContigList(contigs,
#                                    Seurat.Obj,
#                                    group.by = "HTO_maxID")

## ----tidy = FALSE-------------------------------------------------------------
data("contig_list") #the data built into scRepertoire

head(contig_list[[1]])

## ----tidy = FALSE-------------------------------------------------------------
combined.TCR <- combineTCR(contig_list, 
                           samples = c("P17B", "P17L", "P18B", "P18L", 
                                            "P19B","P19L", "P20B", "P20L"),
                           removeNA = FALSE, 
                           removeMulti = FALSE, 
                           filterMulti = FALSE)

head(combined.TCR[[1]])

## ----tidy = FALSE-------------------------------------------------------------
# Load example BCR contig data
BCR.contigs <- read.csv("https://www.borch.dev/uploads/contigs/b_contigs.csv")

## ----tidy = FALSE-------------------------------------------------------------

# Combine using the default similarity clustering
combined.BCR.clustered <- combineBCR(BCR.contigs, 
                                     samples = "Patient1", 
                                     threshold = 0.85)

# The CTstrict column contains cluster IDs (e.g., "cluster.1")
head(combined.BCR.clustered[[1]][, c("barcode", "CTstrict", "IGH", "cdr3_aa1")])

## -----------------------------------------------------------------------------
combined.BCR.aligned <- combineBCR(BCR.contigs, 
                                   samples = "Patient1",
                                   sequence = "aa",        
                                   dist_type = "nw",      
                                   dist_mat = "BLOSUM80",  
                                   threshold = 0.85)

head(combined.BCR.aligned[[1]][, c("barcode", "CTstrict", "IGH", "cdr3_aa1")])

## -----------------------------------------------------------------------------
cleaned.BCR <- combineBCR(BCR.contigs,
                          samples = "Patient1",
                          filterNonproductive = TRUE,
                          filterMulti = TRUE)

head(cleaned.BCR[[1]])

## ----tidy = FALSE-------------------------------------------------------------
combined.TCR <- addVariable(combined.TCR, 
                            variable.name = "Type", 
                            variables = rep(c("B", "L"), 4))

head(combined.TCR[[1]])

## ----tidy = FALSE-------------------------------------------------------------
subset1 <- subsetClones(combined.TCR, 
                        name = "sample", 
                        variables = c("P18L", "P18B"))

head(subset1[[1]][,1:4])

## -----------------------------------------------------------------------------
subset2 <- combined.TCR[c(3,4)]
head(subset2[[1]][,1:4])

## ----eval = FALSE, tidy = FALSE-----------------------------------------------
# exportClones(combined,
#              write.file = TRUE,
#              dir = "~/Documents/MyExperiment/Sample1/"
#              file.name = "clones.csv")

## -----------------------------------------------------------------------------
immunarch <- exportClones(combined.TCR, 
                          format = "immunarch", 
                          write.file = FALSE)
head(immunarch[[1]][[1]])

## ----eval = FALSE, tidy = FALSE-----------------------------------------------
# combined <- annotateInvariant(combined,
#                               type = "MAIT",
#                               species = "human")
# 
# combined <- annotateInvariant(combined,
#                               type = "iNKT",
#                               species = "human")

## ----tidy = FALSE-------------------------------------------------------------
clonalQuant(combined.TCR, 
            cloneCall="strict", 
            chain = "both", 
            scale = TRUE)

## -----------------------------------------------------------------------------
clonalQuant(combined.TCR, 
            cloneCall="gene", 
            group.by = "Type", 
            scale = TRUE)

## ----tidy = FALSE-------------------------------------------------------------
clonalAbundance(combined.TCR, 
                cloneCall = "gene", 
                scale = FALSE)

## -----------------------------------------------------------------------------
clonalAbundance(combined.TCR, 
                cloneCall = "gene", 
                scale = TRUE)

## ----tidy = FALSE-------------------------------------------------------------
clonalLength(combined.TCR, 
             cloneCall="aa", 
             chain = "both") 

## ----tidty = FALSE------------------------------------------------------------
clonalLength(combined.TCR, 
             cloneCall="aa", 
             chain = "TRA", 
             scale = TRUE) 

## ----tidy = FALSE-------------------------------------------------------------
clonalCompare(combined.TCR, 
                  top.clones = 10, 
                  samples = c("P17B", "P17L"), 
                  cloneCall="aa", 
                  graph = "alluvial")

## ----tidy = FALSE-------------------------------------------------------------
clonalCompare(combined.TCR, 
              top.clones = 10,
              highlight.clones = c("CVVSDNTGGFKTIF_CASSVRRERANTGELFF", "NA_CASSVRRERANTGELFF"),
              relabel.clones = TRUE,
              samples = c("P17B", "P17L"), 
              cloneCall="aa", 
              graph = "alluvial")

## -----------------------------------------------------------------------------
clonalCompare(combined.TCR, 
              clones = c("CVVSDNTGGFKTIF_CASSVRRERANTGELFF", "NA_CASSVRRERANTGELFF"),
              relabel.clones = TRUE,
              samples = c("P17B", "P17L"), 
              cloneCall="aa", 
              graph = "alluvial")

## ----tidy = FALSE-------------------------------------------------------------
clonalScatter(combined.TCR, 
              cloneCall ="gene", 
              x.axis = "P18B", 
              y.axis = "P18L",
              dot.size = "total",
              graph = "proportion")

## ----tidy = FALSE-------------------------------------------------------------
clonalHomeostasis(combined.TCR, 
                  cloneCall = "gene")


## ----tidy = FALSE-------------------------------------------------------------
clonalHomeostasis(combined.TCR, 
                  cloneCall = "gene",
                  cloneSize = c(Rare = 0.001, Small = 0.01, Medium = 0.1, 
                                Large = 0.3, Hyperexpanded = 1))

## ----tidy = FALSE-------------------------------------------------------------
combined.TCR <- addVariable(combined.TCR, 
                            variable.name = "Type", 
                            variables = rep(c("B", "L"), 4))

## ----tidy = FALSE-------------------------------------------------------------
clonalHomeostasis(combined.TCR, 
                  group.by = "Type",
                  cloneCall = "gene")

## ----tidy = FALSE-------------------------------------------------------------
clonalProportion(combined.TCR, 
                 cloneCall = "gene") 

## -----------------------------------------------------------------------------
clonalProportion(combined.TCR, 
                 cloneCall = "nt",
                 clonalSplit = c(1, 5, 10, 100, 1000, 10000)) 

## ----tidy = FALSE-------------------------------------------------------------
vizGenes(combined.TCR,
         x.axis = "TRBV",
         y.axis = NULL, # No specific y-axis variable, will group all samples
         plot = "barplot",
         summary.fun = "proportion") 

## ----tidy = FALSE-------------------------------------------------------------
# Peripheral Blood Samples
vizGenes(combined.TCR[c("P17B", "P18B", "P19B", "P20B")],
         x.axis = "TRBV",
         y.axis = "TRBJ",
         plot = "heatmap",
         summary.fun = "percent") # Display percentages

# Lung Samples
vizGenes(combined.TCR[c("P17L", "P18L", "P19L", "P20L")],
         x.axis = "TRBV",
         y.axis = "TRBJ",
         plot = "heatmap",
         summary.fun = "percent") # Display percentages

## ----tidy = FALSE-------------------------------------------------------------
vizGenes(combined.TCR[c("P17B", "P17L")],
         x.axis = "TRBV",
         y.axis = "TRAV",
         plot = "heatmap",
         summary.fun = "count") 

## -----------------------------------------------------------------------------
percentGenes(combined.TCR,
             chain = "TRB",
             gene = "Vgene",
             summary.fun = "percent")

## -----------------------------------------------------------------------------
df.genes <- percentGenes(combined.TCR,
                         chain = "TRB",
                         gene = "Vgene",
                         exportTable = TRUE,
                         summary.fun = "proportion") 

# Performing PCA on the gene usage matrix
pc <- prcomp(t(df.genes) )

# Getting data frame to plot from
df_plot <- as.data.frame(cbind(pc$x[,1:2], colnames(df.genes)))
colnames(df_plot) <- c("PC1", "PC2", "Sample")
df_plot$PC1 <- as.numeric(df_plot$PC1)
df_plot$PC2 <- as.numeric(df_plot$PC2)

ggplot(df_plot, aes(x = PC1, y = PC2)) +
  geom_point(aes(fill = Sample), shape = 21, size = 5) +
  guides(fill=guide_legend(title="Samples")) +
  scale_fill_manual(values = hcl.colors(nrow(df_plot), "inferno")) +
  theme_classic() +
  labs(title = "PCA of TRBV Gene Usage")

## -----------------------------------------------------------------------------
percentVJ(combined.TCR[1:2],
          chain = "TRB",
          summary.fun = "percent")

## -----------------------------------------------------------------------------
df.vj <- percentVJ(combined.TCR,
                   chain = "TRB",
                   exportTable = TRUE,
                   summary.fun = "proportion") # Export proportions for PCA

# Performing PCA on the V-J pairing matrix
pc.vj <- prcomp(t(df.vj))

# Getting data frame to plot from
df_plot_vj <- as.data.frame(cbind(pc.vj$x[,1:2], colnames(df.vj)))
colnames(df_plot_vj) <- c("PC1", "PC2", "Sample")
df_plot_vj$PC1 <- as.numeric(df_plot_vj$PC1)
df_plot_vj$PC2 <- as.numeric(df_plot_vj$PC2)

# Plotting the PCA results
ggplot(df_plot_vj, aes(x = PC1, y = PC2)) +
  geom_point(aes(fill = Sample), shape = 21, size = 5) +
  guides(fill=guide_legend(title="Samples")) +
  scale_fill_manual(values = hcl.colors(nrow(df_plot_vj), "inferno")) +
  theme_classic() +
  labs(title = "PCA of TRBV-TRBJ Gene Pairings")

## ----message = FALSE, tidy = FALSE--------------------------------------------
percentAA(combined.TCR, 
          chain = "TRB", 
          aa.length = 20)

## ----tidy = FALSE-------------------------------------------------------------
positionalEntropy(combined.TCR, 
                  chain = "TRB", 
                  aa.length = 20)

## ----tidy = FALSE-------------------------------------------------------------
positionalProperty(combined.TCR[c(1,2)], 
                  chain = "TRB", 
                  aa.length = 20, 
                  method = "atchleyFactors") + 
  scale_color_manual(values = hcl.colors(5, "inferno")[c(2,4)])

## ----tidy = FALSE-------------------------------------------------------------
percentKmer(combined.TCR, 
            cloneCall = "aa",
            chain = "TRB", 
            motif.length = 3, 
            top.motifs = 25)

## -----------------------------------------------------------------------------
percentKmer(combined.TCR, 
            cloneCall = "nt",
            chain = "TRB", 
            motif.length = 3, 
            top.motifs = 25)

## ----tidy = FALSE-------------------------------------------------------------
clonalDiversity(combined.TCR, 
                cloneCall = "gene")

## ----tidy = FALSE-------------------------------------------------------------
combined.TCR <- addVariable(combined.TCR, 
                            variable.name = "Patient", 
                             variables = c("P17", "P17", "P18", "P18", 
"P19","P19", "P20", "P20"))

## ----tidy = FALSE-------------------------------------------------------------
clonalDiversity(combined.TCR, 
                cloneCall = "gene", 
                group.by = "Patient", 
                metric = "inv.simpson")

## ----tidy = FALSE-------------------------------------------------------------
clonalDiversity(combined.TCR, 
                cloneCall = "gene", 
                x.axis = "Patient", 
                metric = "inv.simpson")

## ----message=FALSE, tidy = FALSE----------------------------------------------
clonalRarefaction(combined.TCR,
                  plot.type = 1,
                  hill.numbers = 0,
                  n.boots = 2)

clonalRarefaction(combined.TCR,
                  plot.type = 2,
                  hill.numbers = 0,
                  n.boots = 2)

clonalRarefaction(combined.TCR,
                  plot.type = 3,
                  hill.numbers = 0,
                  n.boots = 2)

## ----tidy = FALSE-------------------------------------------------------------
clonalRarefaction(combined.TCR,
                  plot.type = 1,
                  hill.numbers = 1,
                  n.boots = 2)

clonalRarefaction(combined.TCR,
                  plot.type = 2,
                  hill.numbers = 1,
                  n.boots = 2)

clonalRarefaction(combined.TCR,
                  plot.type = 3,
                  hill.numbers = 1,
                  n.boots = 2)

## ----tidy = FALSE-------------------------------------------------------------
clonalSizeDistribution(combined.TCR, 
                       cloneCall = "aa", 
                       method= "ward.D2")

## ----tidy = FALSE-------------------------------------------------------------
clonalOverlap(combined.TCR, 
              cloneCall = "strict", 
              method = "morisita")

## ----tidy = FALSE-------------------------------------------------------------
clonalOverlap(combined.TCR, 
              cloneCall = "strict", 
              method = "raw")

## ----tidy = FALSE-------------------------------------------------------------
scRep_example <- get(data("scRep_example"))

#Making a Single-Cell Experiment object
sce <- Seurat::as.SingleCellExperiment(scRep_example)

#Adding patient information
scRep_example$Patient <- substr(scRep_example$orig.ident, 1,3)

#Adding type information
scRep_example$Type <- substr(scRep_example$orig.ident, 4,4)

## ----tidy = FALSE-------------------------------------------------------------
# Check the first 10 variable features before removal
VariableFeatures(scRep_example)[1:10]

## ----tidy = FALSE-------------------------------------------------------------
# Remove TCR VDJ genes
scRep_example <- quietTCRgenes(scRep_example)

# Check the first 10 variable features after removal
VariableFeatures(scRep_example)[1:10]

## ----tidy = FALSE-------------------------------------------------------------
sce <- combineExpression(combined.TCR, 
                         sce, 
                         cloneCall="gene", 
                         group.by = "sample", 
                         proportion = TRUE)

#Define color palette 
colorblind_vector <- hcl.colors(n=7, palette = "inferno", fixup = TRUE)

plotUMAP(sce, colour_by = "cloneSize") +
    scale_color_manual(values=rev(colorblind_vector[c(1,3,5,7)]))

## ----tidy = FALSE-------------------------------------------------------------
scRep_example <- combineExpression(combined.TCR, 
                                   scRep_example, 
                                   cloneCall="gene", 
                                   group.by = "sample", 
                                   proportion = FALSE, 
                                   cloneSize=c(Single=1, Small=5, Medium=20, Large=100, Hyperexpanded=500))

# Bug in Seurat 5.3.1 no longer handles NA for DimPlot
# Will Update in Future Commits

# Seurat::DimPlot(scRep_example, group.by = "cloneSize") +
#    scale_color_manual(values=rev(colorblind_vector[c(1,3,4,5,7)]))

## ----eval=FALSE, tidy = FALSE-------------------------------------------------
# #This is an example of the process, which will not be evaluated during knit
# TCR <- combineTCR(...)
# BCR <- combineBCR(...)
# list.receptors <- c(TCR, BCR)
# 
# 
# seurat <- combineExpression(list.receptors,
#                             seurat,
#                             cloneCall="gene",
#                             proportion = TRUE)

## ----tidy = FALSE-------------------------------------------------------------
clonalOverlay(scRep_example, 
              reduction = "umap", 
              cutpoint = 1, 
              bins = 10, 
              facet.by = "Patient") + 
              guides(color = "none")

## ----tidy = FALSE-------------------------------------------------------------
#ggraph needs to be loaded due to issues with ggplot
library(ggraph)

#No Identity filter
clonalNetwork(scRep_example, 
              reduction = "umap", 
              group.by = "seurat_clusters",
              filter.clones = NULL,
              filter.identity = NULL,
              cloneCall = "aa")

## ----tidy = FALSE-------------------------------------------------------------
#Examining Cluster 3 only
clonalNetwork(scRep_example, 
              reduction = "umap", 
              group.by = "seurat_clusters",
              filter.identity = 3,
              cloneCall = "aa")

## ----tidy = FALSE-------------------------------------------------------------
shared.clones <- clonalNetwork(scRep_example, 
                               reduction = "umap", 
                               group.by = "seurat_clusters",
                               cloneCall = "aa", 
                               exportClones = TRUE)
head(shared.clones)

## ----tidy = FALSE-------------------------------------------------------------
scRep_example <- highlightClones(scRep_example, 
                    cloneCall= "aa", 
                    sequence = c("CAERGSGGSYIPTF_CASSDPSGRQGPRWDTQYF", 
                                 "CARKVRDSSYKLIF_CASSDSGYNEQFF"))

# Bug in Seurat 5.3.1 no longer handles NA for DimPlot
# Will Update in Future Commits

# Seurat::DimPlot(scRep_example, group.by = "highlight") + 
#   guides(color=guide_legend(nrow=3,byrow=TRUE)) + 
#   ggplot2::theme(plot.title = element_blank(), 
#                 legend.position = "bottom")

## ----tidy = FALSE-------------------------------------------------------------
clonalOccupy(scRep_example, 
              x.axis = "seurat_clusters")

## -----------------------------------------------------------------------------
clonalOccupy(scRep_example, 
             x.axis = "ident", 
             proportion = TRUE, 
             label = FALSE)

## ----tidy = FALSE-------------------------------------------------------------
alluvialClones(scRep_example, 
               cloneCall = "aa", 
               y.axes = c("Patient", "ident", "Type"), 
               color = c("CVVSDNTGGFKTIF_CASSVRRERANTGELFF", "NA_CASSVRRERANTGELFF")) + 
    scale_fill_manual(values = c("grey", colorblind_vector[3]))

## ----tidy = FALSE-------------------------------------------------------------
alluvialClones(scRep_example, 
                   cloneCall = "gene", 
                   y.axes = c("Patient", "ident", "Type"), 
                   color = "ident") 

## ----tidy = FALSE-------------------------------------------------------------
library(circlize)
library(scales)

circles <- getCirclize(scRep_example, 
                       group.by = "seurat_clusters")

#Just assigning the normal colors to each cluster
grid.cols <- hue_pal()(length(unique(scRep_example$seurat_clusters)))
names(grid.cols) <- unique(scRep_example$seurat_clusters)

#Graphing the chord diagram
chordDiagram(circles, self.link = 1, grid.col = grid.cols)

## -----------------------------------------------------------------------------
subset <- subset(scRep_example, Type == "L")

circles <- getCirclize(subset, group.by = "ident", proportion = TRUE)

grid.cols <- scales::hue_pal()(length(unique(subset@active.ident)))
names(grid.cols) <- levels(subset@active.ident)

chordDiagram(circles, 
             self.link = 1, 
             grid.col = grid.cols, 
             directional = 1, 
             direction.type =  "arrows",
             link.arr.type = "big.arrow")

## -----------------------------------------------------------------------------
# Calculate and plot all three STARTRAC indices
StartracDiversity(scRep_example, 
                  type = "Type", 
                  group.by = "Patient")

## -----------------------------------------------------------------------------
# Calculate and plot only the clonal expansion index
StartracDiversity(scRep_example, 
                  type = "Type", 
                  group.by = "Patient",
                  index = "expa")

## -----------------------------------------------------------------------------
# # Calculate pairwise migration between tissues
StartracDiversity(scRep_example, 
                  type = "Type", 
                  group.by = "Patient",
                  index = "migr",
                  pairwise = "Type")

## ----message = FALSE, tidy = FALSE--------------------------------------------
clonalBias(scRep_example, 
           cloneCall = "aa", 
           split.by = "Patient", 
           group.by = "seurat_clusters",
           n.boots = 10, 
           min.expand =5)

## ----tidy = FALSE-------------------------------------------------------------
# Run clustering on the first two samples for the TRA chain
sub_combined <- clonalCluster(combined.TCR[c(1,2)], 
                              chain = "TRA", 
                              sequence = "aa", 
                              threshold = 0.85)

# View the new cluster column
head(sub_combined[[1]][, c("barcode", "TCR1", "TRA.Cluster")])

## ----tidy = FALSE-------------------------------------------------------------
#Adding patient information
scRep_example$Patient <- substr(scRep_example$orig.ident, 1,3)

#Adding type information
scRep_example$Type <- substr(scRep_example$orig.ident, 4,4)

## -----------------------------------------------------------------------------
# Run clustering, but group calculations by "Patient"
scRep_example <- clonalCluster(scRep_example, 
                               chain = "TRA", 
                               sequence = "aa", 
                               threshold = 0.85, 
                               group.by = "Patient")

#Define color palette 
num_clusters <- length(unique(na.omit(scRep_example$TRA.Cluster)))
cluster_colors <- hcl.colors(n = num_clusters, palette = "inferno")

# Bug in Seurat 5.3.1 no longer handles NA for DimPlot
# Will Update in Future Commits

# DimPlot(scRep_example, group.by = "TRA.Cluster") +
#  scale_color_manual(values = cluster_colors, na.value = "grey") + 
#  NoLegend()

## ----tidy = FALSE-------------------------------------------------------------
set.seed(42)
#Clustering Patient 19 samples
igraph.object <- clonalCluster(combined.TCR[c(5,6)],
                               chain = "TRB",
                               sequence = "aa",
                               group.by = "sample",
                               threshold = 0.85, 
                               exportGraph = TRUE)

#Setting color scheme
col_legend <- factor(igraph::V(igraph.object)$group)
col_samples <- hcl.colors(2,"inferno")[as.numeric(col_legend)]
color.legend <- factor(unique(igraph::V(igraph.object)$group))
sample.vertices <- V(igraph.object)[sample(length(igraph.object), 500)]

subgraph.object <- induced_subgraph(igraph.object, vids = sample.vertices)
V(subgraph.object)$degrees <- igraph::degree(subgraph.object)
edge_alpha_color <- adjustcolor("gray", alpha.f = 0.3)

#Plotting
plot(subgraph.object,
     layout = layout_nicely(subgraph.object),
     vertex.label = NA,
     vertex.size = sqrt(igraph::V(subgraph.object)$degrees), 
     vertex.color = col_samples[sample.vertices],
     vertex.frame.color = "white", 
     edge.color = edge_alpha_color,
     edge.arrow.size = 0.05,
     edge.curved = 0.05, 
     margin = -0.1)
legend("topleft", 
       legend = levels(color.legend), 
       pch = 16, 
       col = unique(col_samples), 
       bty = "n")

## -----------------------------------------------------------------------------
# Generate the sparse matrix
adj.matrix <- clonalCluster(combined.TCR[c(1,2)],
                            chain = "TRB",
                            exportAdjMatrix = TRUE)

# View the dimensions and a snippet of the matrix
dim(adj.matrix)
print(adj.matrix[1:10, 1:10])

## -----------------------------------------------------------------------------
# Cluster using both TRB and TRA chains simultaneously
clustered_both <- clonalCluster(combined.TCR[c(1,2)], 
                                chain = "both")

# View the new "Multi.Cluster" column
head(clustered_both[[1]][, c("barcode", "TCR1", "TCR2", "Multi.Cluster")])

## -----------------------------------------------------------------------------
# Cluster using the walktrap algorithm
graph_walktrap <- clonalCluster(combined.TCR[c(1,2)],
                                cluster.method = "walktrap",
                                exportGraph = TRUE)

# Compare the number of clusters found
length(unique(V(graph_walktrap)$cluster))

## -----------------------------------------------------------------------------
sessionInfo()

