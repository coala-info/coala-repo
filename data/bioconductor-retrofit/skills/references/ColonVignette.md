# Retrofit Colon Vignette

Adam Keebum Park, Roopali Singh

#### 2025-10-30

# Contents

* [1 Introduction](#introduction)
* [2 Package Installation and other requirements](#package-installation-and-other-requirements)
* [3 Spatial Transcriptomics Data](#spatial-transcriptomics-data)
* [4 Reference-free Deconvolution](#reference-free-deconvolution)
* [5 Cell-type Annotation via annotated single-cell reference](#cell-type-annotation-via-annotated-single-cell-reference)
* [6 Cell-type Annotation via known marker genes](#cell-type-annotation-via-known-marker-genes)
* [7 Results and visualization](#results-and-visualization)
  + [7.1 Figure 4A: Proportion of different cell types in the tissue.](#figure-4a-proportion-of-different-cell-types-in-the-tissue.)
  + [7.2 Figure 4C: Localization of cell types with the dominant cell type in each spot](#figure-4c-localization-of-cell-types-with-the-dominant-cell-type-in-each-spot)
  + [7.3 Figure 4D: Gene expression of Epithelial marker genes across spots](#figure-4d-gene-expression-of-epithelial-marker-genes-across-spots)
  + [7.4 Figure 4E: Proportion of Epithelial cells across spots](#figure-4e-proportion-of-epithelial-cells-across-spots)
  + [7.5 Figure 5A: Proportion of different cell types in different spots](#figure-5a-proportion-of-different-cell-types-in-different-spots)
  + [7.6 Figure 5D: Spots with 1 dominant cell type i.e., proportion > 0.5](#figure-5d-spots-with-1-dominant-cell-type-i.e.-proportion-0.5)
  + [7.7 Figure 5E: Co-localized spots for Epithelial cells](#figure-5e-co-localized-spots-for-epithelial-cells)
  + [7.8 Figure 6C: Concordance between expression profiles of found genes obtained from RETROFIT and scRNA-seq data](#figure-6c-concordance-between-expression-profiles-of-found-genes-obtained-from-retrofit-and-scrna-seq-data)
* [8 Session information](#session-information)

# 1 Introduction

RETROFIT is a statistical method for reference-free deconvolution of spatial transcriptomics data to estimate cell type mixtures. In this Vignette, we will estimate cell type composition of a Colon dataset. We will annotate cell types using marker gene lists as well as single cell reference.
We will also reproduce some of the results from the paper for illustration.

# 2 Package Installation and other requirements

Install and load the packages using the following steps:

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("retrofit")
```

```
library(retrofit)
```

# 3 Spatial Transcriptomics Data

First load the Colon ST data from fetal 12 PCW tissue, using the following command:

```
data("vignetteColonData")
X = vignetteColonData$a3_x
```

# 4 Reference-free Deconvolution

Initialize the required parameters for deconvolution.
- iterations: Number of iterations (default = 4000)
- L: Number of components required

```
iterations  = 10
L           = 20
```

After initialization, run retrofit on the data (X) as follows:

```
result = retrofit::decompose(X, L=L, iterations=iterations, verbose=TRUE)
```

```
## [1] "iteration: 1 0.15 Seconds"
## [1] "iteration: 2 0.144 Seconds"
## [1] "iteration: 3 0.14 Seconds"
## [1] "iteration: 4 0.139 Seconds"
## [1] "iteration: 5 0.185 Seconds"
## [1] "iteration: 6 0.142 Seconds"
## [1] "iteration: 7 0.141 Seconds"
## [1] "iteration: 8 0.142 Seconds"
## [1] "iteration: 9 0.144 Seconds"
## [1] "iteration: 10 0.148 Seconds"
## [1] "Iteration mean:  0.148  seconds  total:  1.475  seconds"
```

```
H   = result$h
W   = result$w
Th  = result$th
```

After deconvolution of ST data, we have our estimates of W (a matrix of order G x L), H (a matrix of order L x S) and Theta (a vector of L components). Here, we are using number of iterations as 20 for demonstration purposes. For reproducing results in the paper, we need to run RETROFIT for iterations = 4000. The whole computation is omitted here due to time complexity (> 10min). We will load the results from 4000 iterations for the rest of the analysis.

```
H   = vignetteColonData$a3_results_4k_iterations$decompose$h
W   = vignetteColonData$a3_results_4k_iterations$decompose$w
Th  = vignetteColonData$a3_results_4k_iterations$decompose$th
```

Above results are obtained by running the code below.

```
iterations = 4000
set.seed(1)
result = retrofit::decompose(x, L=L, iterations=iterations)
```

Next, we need to annotate the components, to get the proportion of K cell types. We can do this in two ways: (a) using an annotated single cell reference or (b) using the known marker genes.

# 5 Cell-type Annotation via annotated single-cell reference

Here, we will annotate components using single-cell reference. Load the single-cell reference data:

```
sc_ref = vignetteColonData$sc_ref
```

This file contains average gene expression values for K=8 cell types. Run the following command to get K cell-type mixtures from the ST data X:

```
K = ncol(sc_ref) # number of cell types
result    = annotateWithCorrelations(sc_ref, K, W, H)
H_sc      = result$h
W_sc      = result$w
H_sc_prop = result$h_prop
W_sc_prop = result$w_prop
```

We assign components to the cell type it has maximum correlation with as shown in figure above. Finally, cell-type proportions for each spot in the ST data (X) are stored in H\_mark\_prop of order K x S.
You can verify that the mappings from both methods are largely similar.

```
W_norm <- W
for(i in 1:nrow(W)){
    W_norm[i,]=W[i,]/sum(W[i,])
}

corrplot::corrplot(stats::cor(sc_ref, W_norm),
                   is.corr=FALSE,
                   mar=c(0,0,1,0),
                   col = colorRampPalette(c("white", "deepskyblue", "blue4"))(100),
                   main="Correlation-based Mapping Matrix")
```

![](data:image/png;base64...)

# 6 Cell-type Annotation via known marker genes

Here, we will annotate using known marker genes for cell types. Load the marker gene list:

```
marker_ref = vignetteColonData$marker_ref
```

This file contains the list of marker genes for K = 8 cell types. Run the following command to get K cell-type mixtures from the ST data X:

```
K = length(marker_ref) # number of cell types
result      = retrofit::annotateWithMarkers(marker_ref, K, W, H)
H_mark      = result$h
W_mark      = result$w
H_mark_prop = result$h_prop
W_mark_prop = result$w_prop
gene_sums   = result$gene_sums
```

```
corrplot::corrplot(gene_sums,
                   is.corr=FALSE,
                   mar=c(0,0,1,0),
                   col=colorRampPalette(c("white", "deepskyblue", "blue4"))(100),
                   main="Marker-based Mapping Matrix")
```

![](data:image/png;base64...)

We assign components to the cell type it has maximum average marker expression in, as shown in figure above. Finally, cell-type proportions for each spot in the ST data (X) are stored in H\_est of order K x S.

# 7 Results and visualization

Hereon, we will be reproducing some of the analysis from the paper using marker-based mapping results.

## 7.1 Figure 4A: Proportion of different cell types in the tissue.

Proportion of cell-types in this tissue:

```
rowSums(H_mark_prop)/ncol(H_mark_prop)
```

```
## Endothelium  Epithelial Fibroblasts      Immune      Muscle    Myo.Meso
##  0.13018273  0.13980586  0.24423669  0.09745911  0.12181790  0.10049303
##      Neural   Pericytes
##  0.09560567  0.07039902
```

## 7.2 Figure 4C: Localization of cell types with the dominant cell type in each spot

Load the coordinates for the spots in the tissue and the tissue image:

```
coords=vignetteColonData$a3_coords
img <- png::readPNG(RCurl::getURLContent("https://user-images.githubusercontent.com/90921267/210159136-96b56551-f414-4b0b-921e-98f05a98c8bc.png"))
t <- grid::rasterGrob(img, width=ggplot2::unit(1,"npc"), height=ggplot2::unit(1,"npc"), interpolate = FALSE)
```

Find the cell-type with maximum proportion in each spot and plot:

```
dat=as.data.frame(cbind(coords,t(H_mark_prop)))
colnames(dat)=c(colnames(coords),rownames(H_mark_prop))

df=dat[,-c(1:3)]
df$CellType=NA
for(i in 1:nrow(df)){
  df$CellType[i]=names(which.max(df[i,-c(1:2)]))
}
df$CellType=factor(df$CellType,levels=c("Epithelial", "Immune", "Myo.Meso","Muscle",
                                        "Neural", "Endothelium", "Pericytes","Fibroblasts"))

ggplot2::ggplot(df, ggplot2::aes(x=imagerow, y=imagecol))  +
  ggplot2::geom_point(size=1.8, shape=21, ggplot2::aes(fill=CellType))+
  ggplot2::scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9","#009E73", "#CC79A7",
                             "#0072B2", "#D55E00" ,"#F0E442"),
                    labels=c("Epithelial", "Immune","Myofibroblasts/\nMesothelium",
                             "Muscle","Neural","Endothelium",
                             "Pericytes","Fibroblasts"))+
  ggplot2::xlab("") + ggplot2::ylab("") + ggplot2::theme_classic()+
  ggplot2::theme(legend.position = "none",
                 axis.line = ggplot2::element_blank(),
                 plot.margin = ggplot2::margin(-0.2, -0.2, 0.2, -1, "cm"),
                 axis.text.x = ggplot2::element_blank(), axis.text.y = ggplot2::element_blank(),
                 axis.ticks.x = ggplot2::element_blank(),  axis.ticks.y = ggplot2::element_blank())
```

![](data:image/png;base64...)

## 7.3 Figure 4D: Gene expression of Epithelial marker genes across spots

Plot the spatial expression for Epithelial markers:

```
df = as.data.frame(cbind(coords, t(X[marker_ref$Epithelial,])))
df$metagene = unname(rowSums(df[,-c(1:5)]))
df$metagene[df$metagene>quantile(df$metagene,0.95)]=quantile(df$metagene,0.95)

ggplot2::ggplot(df, ggplot2::aes(x=imagerow, y=imagecol))  +
  # ggplot2::annotation_custom(t, 700, 6400, 990, 6550) +
  ggplot2::geom_point(size=1.5, ggplot2::aes(color=metagene))+
  ggplot2::scale_color_gradientn(name="Epithelial Markers ",
                                 colors=colorspace::adjust_transparency("grey20",
                                                                        alpha = c(0,0.5,1)),
                                 n.breaks=3) +
  ggplot2::xlab("") + ggplot2::ylab("") +
  ggplot2::theme_classic()+
  ggplot2::theme(legend.key.height = ggplot2::unit(0.2, 'cm'), #change legend key size
                 legend.key.width = ggplot2::unit(0.8, 'cm'),
                 legend.title = ggplot2::element_text(size=10),
                 legend.position = "bottom",
                 legend.box.margin=ggplot2::margin(-20,-10,-5,-10),
                 plot.margin = ggplot2::margin(-0.2, -0.2, 0.2, -1, "cm"),
                 axis.line=ggplot2::element_blank(),
                 legend.text=ggplot2::element_text(size=8),
                 axis.text.x = ggplot2::element_blank(),
                 axis.text.y = ggplot2::element_blank(),
                 axis.ticks.x=ggplot2::element_blank(),
                 axis.ticks.y=ggplot2::element_blank())
```

![](data:image/png;base64...)

## 7.4 Figure 4E: Proportion of Epithelial cells across spots

Plot the estimated proportions for Epithelial cell-type:

```
df=dat[,-c(1:3)]
ggplot2::ggplot(df, ggplot2::aes(x=imagerow, y=imagecol))  +
  # ggplot2::annotation_custom(t, 700, 6400, 990, 6550) +
  ggplot2::geom_point(size=1.5, ggplot2::aes(color=Epithelial))+
  ggplot2::scale_color_gradientn(name="Epithelial ",
                                 colors=colorspace::adjust_transparency("grey20",
                                                                        alpha = c(0,0.5,1)),
                                 n.breaks=3, limits=c(0,1)) +
  ggplot2::xlab("") + ggplot2::ylab("") +
  ggplot2::theme_classic()+
  ggplot2::theme(legend.key.height = ggplot2::unit(0.2, 'cm'), #change legend key size
        legend.key.width = ggplot2::unit(0.8, 'cm'),
        legend.title = ggplot2::element_text(size=10),
        legend.position = "bottom",
        legend.box.margin=ggplot2::margin(-20,-10,-5,-10),
        plot.margin = ggplot2::margin(-0.2, -0.2, 0.2, -1, "cm"),
        axis.line=ggplot2::element_blank(),
        legend.text=ggplot2::element_text(size=8),
        axis.text.x = ggplot2::element_blank(), axis.text.y = ggplot2::element_blank(),
        axis.ticks.x=ggplot2::element_blank(),axis.ticks.y=ggplot2::element_blank())
```

![](data:image/png;base64...)

Verify that the spatial pattern exhibited by the epithelial markers is largely similar to that of the estimated proportion for epithelial cells.

## 7.5 Figure 5A: Proportion of different cell types in different spots

Visualize the proportion of different cell types and colocalization patterns:

```
## Structure Plots
plotfn <- function(df=NULL)
{
  #reshape to long format
  df$num <- 1:nrow(df)
  df1 <- reshape2::melt(df,id.vars = "num")
  #reversing order for cosmetic reasons
  df1 <- df1[rev(1:nrow(df1)),]

  #plot
  p <- ggplot2::ggplot(df1, ggplot2::aes(x=num,y=value,fill=variable))+
    ggplot2::geom_bar(stat="identity",position="fill",width = 1, space = 0)+
    ggplot2::scale_x_continuous(expand = c(0, 0))+
    ggplot2::scale_y_continuous(expand = c(0, 0))+
    ggplot2::labs(x = NULL, y = NULL)+
    ggplot2::theme_grey(base_size=7)+
    ggplot2::theme(legend.text = ggplot2::element_text(size = 20),legend.position = "bottom",
          legend.key.size = ggplot2::unit(0.4, "cm"),
          legend.title = ggplot2::element_blank(),
          axis.ticks = ggplot2::element_blank(),
          axis.text.y = ggplot2::element_text(size = 15),
          axis.text.x = ggplot2::element_blank())+
    ggplot2::scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9",
                               "#009E73", "#CC79A7", "#0072B2",
                               "#D55E00", "#F0E442"))

  p
}

df=as.data.frame(t(H_mark_prop[c(2,4,6,5,7,1,8,3),]))
#pick max cluster, match max to cluster
maxval <- apply(df,1,max)
matchval <- vector(length=nrow(df))
for(j in 1:nrow(df)) matchval[j] <- match(maxval[j],df[j,])
#add max and match to df
df_q <- df
df_q$maxval <- maxval
df_q$matchval <- matchval
#order dataframe ascending match and decending max
df_q <- df_q[with(df_q, order(matchval,-maxval)), ]
#remove max and match
df_q$maxval <- NULL
df_q$matchval <- NULL

plotfn(df=df_q)+
  ggplot2::theme(legend.position="bottom")+
  ggplot2::ggtitle("Fetal 12 PCW (B)")+
  ggplot2::theme(plot.title = ggplot2::element_text(hjust=0.5,size=25))
```

![](data:image/png;base64...)

## 7.6 Figure 5D: Spots with 1 dominant cell type i.e., proportion > 0.5

Plot the proportion of only dominant cell types i.e., cell types with proportion > 0.5 in a spot.

```
df=dat
df_new=df[df$Epithelial>0.5 | df$Fibroblasts>0.5 | df$Myo.Meso>0.5 |
            df$Endothelium>0.5 | df$Pericytes>0.5 | df$Neural>0.5 |
            df$Immune>0.5 | df$Muscle>0.5,-c(1:3)]
df_new$CellType=1*(df_new$Epithelial>0.5) + 2*(df_new$Immune>0.5) +
  3*(df_new$Myo.Meso>0.5) + 4*(df_new$Muscle>0.5) + 5*(df_new$Neural>0.5)+
  6*(df_new$Endothelium>0.5) + 7*(df_new$Pericytes>0.5) + 8*(df_new$Fibroblasts>0.5)
df_new$CellType=factor(df_new$CellType)

ggplot2::ggplot(df_new, ggplot2::aes(x=imagerow, y=imagecol))  +
  # ggplot2::annotation_custom(t, 700, 6400, 990, 6550) +
  ggplot2::geom_point(size=1.8, shape=21, ggplot2::aes(fill=CellType))+
  ggplot2::scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9",
                             "#009E73", "#CC79A7", "#0072B2",
                             "#D55E00", "#F0E442"),
                    labels=c("Epithelial","Immune",
                             "Myofibroblasts\nMesothelium",
                             "Muscle", "Neural", "Endothelium",
                             "Pericytes", "Fibroblasts"))+
  ggplot2::xlab("") + ggplot2::ylab("") +
  ggplot2::theme_classic()+
  ggplot2::theme(legend.key.height = ggplot2::unit(0.5, 'cm'), #change legend key size
        legend.key.width = ggplot2::unit(1, 'cm'),
        legend.title = ggplot2::element_blank(),
        legend.position = "none",
        plot.margin = ggplot2::margin(-0.2, -0.2, 0.2, -1, "cm"),
        axis.line=ggplot2::element_blank(),
        legend.text=ggplot2::element_text(size=9),
        axis.text.x = ggplot2::element_blank(), axis.text.y = ggplot2::element_blank(),
        axis.ticks.x=ggplot2::element_blank(),axis.ticks.y=ggplot2::element_blank())
```

![](data:image/png;base64...)

## 7.7 Figure 5E: Co-localized spots for Epithelial cells

Visualize the spots that contain cell types co-localized with Epithelial cells:

```
#Epithelial
df=dat
df_new=df[df$Epithelial>0.25,]
df_new=df_new[df_new$Fibroblasts>0.25 | df_new$Myo.Meso>0.25 |
                  df_new$Endothelium>0.25 | df_new$Pericytes>0.25 | df_new$Neural>0.25 |
                  df_new$Immune>0.25 | df_new$Muscle>0.25,-c(1:3)]

df_new$CellType=NA
for(i in 1:nrow(df_new)){
  df_new$CellType[i]=names(which.max(df_new[i,-c(1:2,4)]))
}

df_new$CellType=factor(df_new$CellType,c("Immune", "Myo.Meso",
                                         "Muscle","Neural",
                                         "Endothelium",
                                         "Pericytes","Fibroblasts"))

ggplot2::ggplot(df_new, ggplot2::aes(x=imagerow, y=imagecol))  +
  ggplot2::ylim(min(df$imagecol),max(df$imagecol)) +
  ggplot2::xlim(min(df$imagerow),max(df$imagerow))+
  ggplot2::geom_point(size=1.8, shape=21, ggplot2::aes(fill=CellType))+
  ggplot2::scale_fill_manual(values=c("#E69F00", "#56B4E9", "#0072B2","#F0E442"),
    labels=c("Immune", "Myofibroblasts\nMesothelium", "Endothelium",
      "Fibroblasts"))+
  ggplot2::xlab("") + ggplot2::ylab("") +
  ggplot2::theme_classic()+
  ggplot2::theme(legend.key.height = ggplot2::unit(0.2, 'cm'), #change legend key size
        legend.key.width = ggplot2::unit(1, 'cm'),
        legend.title = ggplot2::element_blank(),
        legend.position = "bottom",
        plot.margin = ggplot2::margin(-0.15, -0.5, 0.2, -0.55, "cm"), #A3
        axis.line = ggplot2::element_blank(),
        axis.text.x = ggplot2::element_blank(), axis.text.y = ggplot2::element_blank(),
        axis.ticks.x=ggplot2::element_blank(),axis.ticks.y=ggplot2::element_blank())
```

![](data:image/png;base64...)

## 7.8 Figure 6C: Concordance between expression profiles of found genes obtained from RETROFIT and scRNA-seq data

```
df=vignetteColonData$marker_ref_df
gene1=vignetteColonData$fetal12_genes
gene1=gene1[!(gene1 %in% df$Gene)] #common genes
W1=vignetteColonData$a3_results_4k_iterations$annotateWithCorrelations$w
W12=vignetteColonData$intestine_w_12pcw
W12=W12[gene1,]
W12_prop=W12
w_rowsums1 = rowSums(W12)
for (i in 1:length(w_rowsums1)){
  if(w_rowsums1[i] > 0){
    W12_prop[i,] = W12_prop[i,]/w_rowsums1[i]
  }
}
W1_prop=W1[gene1,-c(1:2)]

dat=data.frame(gene=c(rep(gene1,8)),
               celltype=factor(c(rep("Epithelial",length(gene1)),rep("Fibroblasts",length(gene1)),
                                 rep("Myofibroblasts\nMesothelium",length(gene1)),rep("Endothelium",length(gene1)),
                                 rep("Pericytes",length(gene1)),rep("Neural",length(gene1)),
                                 rep("Immune",length(gene1)),rep("Muscle",length(gene1))
               ),levels=c("Epithelial","Immune","Fibroblasts","Endothelium",
                          "Neural","Pericytes", "Myofibroblasts\nMesothelium","Muscle")),
               stage=c(rep("Fetal 12 PCW (B)",length(gene1)*8)),
               gene_exp1=c(W1_prop[gene1,"Epithelial"],W1_prop[gene1,"Fibroblasts"],
                           W1_prop[gene1,"Myo.Meso"],W1_prop[gene1,"Endothelium"],
                           W1_prop[gene1,"Pericytes"],W1_prop[gene1,"Neural"],
                           W1_prop[gene1,"Immune"],W1_prop[gene1,"Muscle"]
               ),
               gene_exp2=c(W12_prop[gene1,"Epithelial"],W12_prop[gene1,"Fibroblasts"],
                           W12_prop[gene1,"Myo.Meso"],W12_prop[gene1,"Endothelium"],
                           W12_prop[gene1,"Pericytes"],W12_prop[gene1,"Neural"],
                           W12_prop[gene1,"Immune"],W12_prop[gene1,"Muscle"]
               ))

ggplot2::ggplot(dat, ggplot2::aes(celltype, gene)) +
  ggplot2::geom_point(shape=21, ggplot2::aes(fill=gene_exp1, size=gene_exp2)) +
  ggplot2::theme_classic() +
  ggplot2::scale_fill_gradientn(colors = pals::brewer.blues(20)[2:20],
                                name = "Expression (RETROFIT)") +
  ggplot2::facet_grid(cols=ggplot2::vars(stage))+
  ggplot2::theme(axis.text.x=ggplot2::element_text(size=20, angle = 45, hjust = 1),
                 axis.text.y=ggplot2::element_text(size=20),
                 legend.title=ggplot2::element_text(size=20),
                 legend.text=ggplot2::element_text(size=20),
                 legend.key.width=ggplot2::unit(0.3,"cm"),
                 legend.position="right"
                 ) +
  ggplot2::guides(size=ggplot2::guide_legend("Expression (scRNA-seq)"))+
  ggplot2::xlab('')+
  ggplot2::ylab('Genes')+
  ggplot2::theme()
```

![](data:image/png;base64...)

# 8 Session information

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] retrofit_1.10.0  Rcpp_1.1.0       BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10         generics_0.1.4      bitops_1.0-9
##  [4] stringi_1.8.7       digest_0.6.37       magrittr_2.0.4
##  [7] evaluate_1.0.5      grid_4.5.1          RColorBrewer_1.1-3
## [10] bookdown_0.45       maps_3.4.3          fastmap_1.2.0
## [13] plyr_1.8.9          jsonlite_2.0.0      pals_1.10
## [16] tinytex_0.57        BiocManager_1.30.26 scales_1.4.0
## [19] jquerylib_0.1.4     cli_3.6.5           rlang_1.1.6
## [22] withr_3.0.2         cachem_1.1.0        yaml_2.3.10
## [25] corrplot_0.95       tools_4.5.1         reshape2_1.4.4
## [28] dplyr_1.1.4         colorspace_2.1-2    ggplot2_4.0.0
## [31] mapproj_1.2.12      vctrs_0.6.5         R6_2.6.1
## [34] png_0.1-8           lifecycle_1.0.4     magick_2.9.0
## [37] stringr_1.5.2       pkgconfig_2.0.3     bslib_0.9.0
## [40] pillar_1.11.1       gtable_0.3.6        glue_1.8.0
## [43] xfun_0.53           tibble_3.3.0        tidyselect_1.2.1
## [46] knitr_1.50          dichromat_2.0-0.1   farver_2.1.2
## [49] htmltools_0.5.8.1   rmarkdown_2.30      labeling_0.4.3
## [52] compiler_4.5.1      S7_0.2.0            RCurl_1.98-1.17
```