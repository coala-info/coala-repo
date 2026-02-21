# Code example from 'NeuCA' vignette. See references/ for full tutorial.

## ---- eval = TRUE, message = FALSE--------------------------------------------
library(NeuCA)
data("Baron_scRNA")
data("Seg_scRNA")

## ---- eval = TRUE, message = FALSE--------------------------------------------
Baron_anno = data.frame(Baron_true_cell_label, row.names = colnames(Baron_counts))
Baron_sce = SingleCellExperiment(
    assays = list(normcounts = as.matrix(Baron_counts)),
    colData = Baron_anno
    )
# use gene names as feature symbols
rowData(Baron_sce)$feature_symbol <- rownames(Baron_sce)
# remove features with duplicated names
Baron_sce <- Baron_sce[!duplicated(rownames(Baron_sce)), ]

## ---- eval = TRUE, message = FALSE--------------------------------------------
Seg_anno = data.frame(Seg_true_cell_label, row.names = colnames(Seg_counts))
Seg_sce <- SingleCellExperiment(
    assays = list(normcounts = as.matrix(Seg_counts)),
    colData = Seg_anno
)
# use gene names as feature symbols
rowData(Seg_sce)$feature_symbol <- rownames(Seg_sce)
# remove features with duplicated names
Seg_sce <- Seg_sce[!duplicated(rownames(Seg_sce)), ]

## ---- eval = TRUE, message = FALSE--------------------------------------------
predicted.label = NeuCA(train = Baron_sce, test = Seg_sce, 
                        model.size = "big", verbose = FALSE)
#Baron_scRNA is used as the training scRNA-seq dataset
#Seg_scRNA is used as the testing scRNA-seq dataset

## ---- eval = TRUE, message = FALSE, echo=FALSE--------------------------------
library(knitr)
library(kableExtra)
df <- data.frame(Cat = c("Small", "Medium", "Big"), 
                 Layers = c("3", "4", "5"), 
                 Nodes = c("64", "64,128", "64,128,256"))
kable(df, col.names = c("", "Number of layers", "Number of nodes in hidden layers"), 
      escape = FALSE, caption = "Tuning model sizes in the neural-network classifier training.") %>%
  kable_styling(latex_options = "striped")

## ---- eval = TRUE-------------------------------------------------------------
head(predicted.label)
table(predicted.label)

## ---- eval = TRUE-------------------------------------------------------------
table(predicted.label, Seg_true_cell_label)

## ---- eval = TRUE, message = FALSE, echo=F------------------------------------
library(networkD3)
source = rep(NA, choose(length(unique(Seg_true_cell_label)),2)+length(unique(Seg_true_cell_label)))
target = rep(NA, choose(length(unique(Seg_true_cell_label)),2)+length(unique(Seg_true_cell_label)))
value = rep(NA, choose(length(unique(Seg_true_cell_label)),2)+length(unique(Seg_true_cell_label)))
links = data.frame(source, target, value)
cfm = table(predicted.label, Seg_true_cell_label)
id = 1
for(i in 1:ncol(cfm)){
  for(j in i:nrow(cfm)){
    links[id,1] = paste0(colnames(cfm)[i], "_true")
   links[id,2] = paste0(rownames(cfm)[j], "_pred")
   links[id,3] = cfm[j,i]
    id = id + 1
  }
}

nodes <- data.frame(
  name=c(paste0(colnames(cfm), "_true"), paste0(rownames(cfm), "_pred"))
)

links$IDsource <- match(links$source, nodes$name)-1 
links$IDtarget <- match(links$target, nodes$name)-1

p <- sankeyNetwork(Links = links, Nodes = nodes,
              Source = "IDsource", Target = "IDtarget",
              Value = "value", NodeID = "name", 
              sinksRight=FALSE)
p

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

