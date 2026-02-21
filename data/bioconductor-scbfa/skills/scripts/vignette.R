# Code example from 'vignette' vignette. See references/ for full tutorial.

## ----echo = FALSE-------------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----eval=FALSE,include=TRUE,results="hide",message=FALSE,warning=FALSE-------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("scBFA")

## ----include=TRUE,results="hide",message=FALSE,warning=FALSE------------------
library(zinbwave)
library(SingleCellExperiment)
library(ggplot2)
library(scBFA)

## -----------------------------------------------------------------------------

# raw counts matrix with rows are genes and columns are cells
data("exprdata")

# a vector specify the ground truth of cell types provided by conquer database
data("celltype")



## -----------------------------------------------------------------------------
sce <- SingleCellExperiment(assay = list(counts = exprdata))

## ----include=TRUE,results="hide",message=FALSE--------------------------------
bfa_model = scBFA(scData = sce, numFactors = 2) 

## ----fig.width=8, fig.height=6------------------------------------------------
set.seed(5)
df = as.data.frame(bfa_model$ZZ)
df$celltype = celltype

p1 <- ggplot(df,aes(x = V1,y = V2,colour = celltype))
p1 <- p1 + geom_jitter(size=2.5,alpha = 0.8) 
colorvalue <- c("#43d5f9","#24b71f","#E41A1C", "#ffc935","#3d014c","#39ddb2",
                "slateblue2","maroon","#f7df27","palevioletred1","olivedrab3",
                "#377EB8","#5043c1","blue","aquamarine2","chartreuse4",
                "burlywood2","indianred1","mediumorchid1")
p1 <- p1 + xlab("tsne axis 1") + ylab("tsne axis 2") 
p1 <- p1 + scale_color_manual(values = colorvalue)
p1 <- p1 + theme(panel.background = element_blank(),
                  legend.position = "right",
                  axis.text=element_blank(),
                  axis.line.x = element_line(color="black"),
                  axis.line.y = element_line(color="black"),
                  plot.title = element_blank()
                   )
p1

## -----------------------------------------------------------------------------
bpca = BinaryPCA(scData = sce) 

## ----fig.width=8, fig.height=6------------------------------------------------

df = as.data.frame(bpca$x[,c(1:2)])
colnames(df) = c("V1","V2")
df$celltype = celltype

p1 <- ggplot(df,aes(x = V1,y = V2,colour = celltype))
p1 <- p1 + geom_jitter(size=2.5,alpha = 0.8) 
colorvalue <- c("#43d5f9","#24b71f","#E41A1C", "#ffc935","#3d014c","#39ddb2",
                "slateblue2","maroon","#f7df27","palevioletred1","olivedrab3",
                "#377EB8","#5043c1","blue","aquamarine2","chartreuse4",
                "burlywood2","indianred1","mediumorchid1")
p1 <- p1 + xlab("tsne axis 1") + ylab("tsne axis 2") 
p1 <- p1 + scale_color_manual(values = colorvalue)
p1 <- p1 + theme(panel.background = element_blank(),
                legend.position = "right",
                axis.text=element_blank(),
                axis.line.x = element_line(color="black"),
                axis.line.y = element_line(color="black"),
                plot.title = element_blank()
                )
p1

## -----------------------------------------------------------------------------
sessionInfo()

