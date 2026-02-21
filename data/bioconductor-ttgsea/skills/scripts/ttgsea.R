# Code example from 'ttgsea' vignette. See references/ for full tutorial.

## ----fig.align='center', message=FALSE, warning=FALSE, eval=TRUE--------------
library(ttgsea)
library(fgsea)
data(examplePathways)
data(exampleRanks)
names(examplePathways) <- gsub("_", " ", substr(names(examplePathways), 9, 1000))

set.seed(1)
fgseaRes <- fgseaSimple(examplePathways, exampleRanks, nperm = 10000)
data.table::data.table(fgseaRes[order(fgseaRes$NES, decreasing = TRUE),])

### convert from gene set defined by BiocSet::BiocSet to list
#library(BiocSet)
#genesets <- BiocSet(examplePathways)
#gsc_list <- as(genesets, "list")

# convert from gene set defined by GSEABase::GeneSetCollection to list
#library(GSEABase)
#genesets <- BiocSet(examplePathways)
#gsc <- as(genesets, "GeneSetCollection")
#gsc_list <- list()
#for (i in 1:length(gsc)) {
#  gsc_list[[setName(gsc[[i]])]] <- geneIds(gsc[[i]])
#}

#set.seed(1)
#fgseaRes <- fgseaSimple(gsc_list, exampleRanks, nperm = 10000)

## ----fig.align='center', message=FALSE, warning=FALSE, eval=TRUE--------------
if (keras::is_keras_available() & reticulate::py_available()) {
  # model parameters
  num_tokens <- 1000
  length_seq <- 30
  batch_size <- 32
  embedding_dim <- 50
  num_units <- 32
  epochs <- 10
  
  # algorithm
  ttgseaRes <- fit_model(fgseaRes, "pathway", "NES",
                         model = bi_lstm(num_tokens, embedding_dim,
                                         length_seq, num_units),
                         num_tokens = num_tokens,
                         length_seq = length_seq,
                         epochs = epochs,
                         batch_size = batch_size,
                         use_generator = FALSE,
                         callbacks = keras::callback_early_stopping(
                            monitor = "loss",
                            patience = 10,
                            restore_best_weights = TRUE))
  
  # prediction for every token
  ttgseaRes$token_pred
  ttgseaRes$token_gsea[["TGF beta"]][,1:5]
}

## ----fig.align='center', message=FALSE, warning=FALSE, eval=TRUE--------------
if (exists("ttgseaRes")) {
  # prediction with MC p-value
  set.seed(1)
  new_text <- c("Cell Cycle DNA Replication",
                "Cell Cycle",
                "DNA Replication",
                "Cycle Cell",
                "Replication DNA",
                "TGF-beta receptor")
  print(predict_model(ttgseaRes, new_text))
  print(predict_model(ttgseaRes, "data science"))
}

## ----fig.align='center', message=FALSE, warning=FALSE, eval=TRUE--------------
if (exists("ttgseaRes")) {
  summary(ttgseaRes$model)
  plot_model(ttgseaRes$model)
}

## ----fig.align='center', message=FALSE, warning=FALSE, eval=FALSE-------------
# if (keras::is_keras_available() & reticulate::py_available()) {
#   # leading edge
#   LE <- unlist(lapply(fgseaRes$leadingEdge, function(x) gsub(",", "", toString(x))))
#   fgseaRes <- cbind(fgseaRes, LE)
# 
#   # model parameters
#   num_tokens <- 1000
#   length_seq <- 30
#   batch_size <- 32
#   embedding_dim <- 50
#   num_units <- 32
#   epochs <- 10
# 
#   # algorithm
#   ttgseaRes <- fit_model(fgseaRes, "LE", "NES",
#                          model = bi_lstm(num_tokens, embedding_dim,
#                                          length_seq, num_units),
#                          num_tokens = num_tokens,
#                          length_seq = length_seq,
#                          epochs = epochs,
#                          batch_size = batch_size,
#                          verbose = 0,
#                          callbacks = callback_early_stopping(
#                             monitor = "loss",
#                             patience = 5,
#                             restore_best_weights = TRUE))
# 
#   # prediction for every token
#   ttgseaRes$token_pred
# 
#   # prediction with MC p-value
#   set.seed(1)
#   new_text <- c("107995 56150", "16952")
#   predict_model(ttgseaRes, new_text)
# }

## ----fig.align='center', message=FALSE, warning=FALSE, eval=FALSE-------------
# if (keras::is_keras_available() & reticulate::py_available()) {
#   ## data preparation
#   library(airway)
#   data(airway)
# 
#   ## differentially expressed genes
#   library(DESeq2)
#   des <- DESeqDataSet(airway, design = ~ dex)
#   des <- DESeq(des)
#   res <- results(des)
#   head(res)
#   # log2FC used for GSEA
#   statistic <- res$"log2FoldChange"
#   names(statistic) <- rownames(res)
#   statistic <- na.omit(statistic)
#   head(statistic)
# 
#   ## gene set
#   library(org.Hs.eg.db)
#   library(BiocSet)
#   go <- go_sets(org.Hs.eg.db, "ENSEMBL", ontology = "BP")
#   go <- as(go, "list")
#   # convert GO id to term name
#   library(GO.db)
#   names(go) <- Term(GOTERM)[names(go)]
# 
#   ## GSEA
#   library(fgsea)
#   set.seed(1)
#   fgseaRes <- fgsea(go, statistic)
#   head(fgseaRes)
# 
#   ## tokenizing text of GSEA
#   # model parameters
#   num_tokens <- 5000
#   length_seq <- 30
#   batch_size <- 64
#   embedding_dim <- 128
#   num_units <- 32
#   epochs <- 20
#   # algorithm
#   ttgseaRes <- fit_model(fgseaRes, "pathway", "NES",
#                          model = bi_lstm(num_tokens, embedding_dim,
#                                          length_seq, num_units),
#                          num_tokens = num_tokens,
#                          length_seq = length_seq,
#                          epochs = epochs,
#                          batch_size = batch_size,
#                          callbacks = keras::callback_early_stopping(
#                            monitor = "loss",
#                            patience = 5,
#                            restore_best_weights = TRUE))
#   # prediction
#   ttgseaRes$token_pred
#   set.seed(1)
#   predict_model(ttgseaRes, c("translation response",
#                              "cytokine activity",
#                              "rhodopsin mediate",
#                              "granzyme",
#                              "histone deacetylation",
#                              "helper T cell",
#                              "Wnt"))
# }

## ----eval=TRUE----------------------------------------------------------------
sessionInfo()

