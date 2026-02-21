# Tokenizing Text of Gene Set Enrichment Analysis

#### Dongmin Jung

#### December 24, 2020

* [1 Introduction](#introduction)
* [2 Example](#example)
  + [2.1 Terms of gene sets](#terms-of-gene-sets)
  + [2.2 Leading edge genes](#leading-edge-genes)
* [3 Case Study](#case-study)
* [4 Session information](#session-information)
* [5 References](#references)

# 1 Introduction

Functional enrichment analysis methods such as gene set enrichment analysis (GSEA) have been widely used for analyzing gene expression data. GSEA is a powerful method to infer results of gene expression data at a level of gene sets by calculating enrichment scores for predefined sets of genes. GSEA depends on the availability and accuracy of gene sets. There are overlaps between terms of gene sets or categories because multiple terms may exist for a single biological process, and it can thus lead to redundancy within enriched terms. In other words, the sets of related terms are overlapping. Using deep learning, this pakage is aimed to predict enrichment scores for unique tokens or words from text in names of gene sets to resolve this overlapping set issue. Furthermore, we can coin a new term by combining tokens and find its enrichment score by predicting such a combined tokens.

Text can be seen as sequential data, either as a sequence of characters or as a sequence of words. Recurrent Neural Network (RNN) operating on sequential data is a type of the neural network. RNN has been applied to a variety of tasks including natural language processing such as machine translation. However, RNN suffers from the problem of long-term dependencies which means that RNN struggles to remember information for long periods of time. An Long Short-Term Memory (LSTM) network is a special kind of RNN that is designed to solve the long-term dependency problem. The bidirectional LSTM network consists of two distinct LSTM networks, termed the forward LSTM and the backward LSTM, which process the sequences in opposite directions. Gated Recurrent Unit (GRU) is a simplified version of LSTM with less number of parameters, and thus, the total number of parameters can be greatly reduced for a large neural network. LSTM and GRU are known to be successful remedies to the long-term dependency problem. The above models take terms of gene sets as input and enrichment scores as output to predict enrichment scores of new terms.

# 2 Example

## 2.1 Terms of gene sets

### 2.1.1 GSEA

Consider a simple example. Once GSEA is performed, the result calculated from GSEA is fed into the algorithm to train the deep learning models.

```
library(ttgsea)
library(fgsea)
data(examplePathways)
data(exampleRanks)
names(examplePathways) <- gsub("_", " ", substr(names(examplePathways), 9, 1000))

set.seed(1)
fgseaRes <- fgseaSimple(examplePathways, exampleRanks, nperm = 10000)
data.table::data.table(fgseaRes[order(fgseaRes$NES, decreasing = TRUE),])
```

```
##                                                        pathway         pval
##                                                         <char>        <num>
##    1:                                     Mitotic Prometaphase 0.0001520219
##    2:                  Resolution of Sister Chromatid Cohesion 0.0001537043
##    3:                                      Cell Cycle, Mitotic 0.0001255020
##    4:                             RHO GTPases Activate Formins 0.0001534684
##    5:                                               Cell Cycle 0.0001227446
##   ---
## 1416: Downregulation of SMAD2 3:SMAD4 transcriptional activity 0.0022655188
## 1417:                                  HATs acetylate histones 0.0002779322
## 1418:                   TRAF3-dependent IRF activation pathway 0.0010962508
## 1419:                                     Nephrin interactions 0.0013498313
## 1420:                                  Interleukin-6 signaling 0.0004174494
##              padj         ES       NES nMoreExtreme  size
##             <num>      <num>     <num>        <num> <int>
##    1: 0.004481064  0.7253270  2.963541            0    82
##    2: 0.004481064  0.7347987  2.954314            0    74
##    3: 0.004481064  0.5594755  2.751403            0   317
##    4: 0.004481064  0.6705979  2.717798            0    78
##    5: 0.004481064  0.5388497  2.688064            0   369
##   ---
## 1416: 0.028982313 -0.6457899 -1.984552            9    16
## 1417: 0.006365544 -0.4535612 -1.994238            0    68
## 1418: 0.017020529 -0.7176839 -2.022102            4    12
## 1419: 0.019558780 -0.6880106 -2.025979            5    14
## 1420: 0.008590987 -0.8311374 -2.079276            1     8
##                                      leadingEdge
##                                           <list>
##    1:   66336,66977,12442,107995,66442,52276,...
##    2:   66336,66977,12442,107995,66442,52276,...
##    3:   66336,66977,12442,107995,66442,12571,...
##    4:   66336,66977,107995,66442,52276,67629,...
##    5:   66336,66977,12442,107995,66442,19361,...
##   ---
## 1416:    66313,20482,20481,17127,17128,83814,...
## 1417: 74026,319190,244349,75560,13831,246103,...
## 1418:   56489,12914,54131,54123,56480,217069,...
## 1419:   109711,14360,20742,17973,18708,12488,...
## 1420:        16194,16195,16451,12402,16452,20848
```

```
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
```

### 2.1.2 deep learning and embedding

Since deep learning architectures are incapable of processing characters or words in their raw form, the text needs to be converted to numbers as inputs. Word embeddings are the texts converted into numbers. For tokenization, unigram and bigram sequences are used as default. An integer is assigned to each token, and then each term is converted to a sequence of integers. The sequences that are longer than the given maximum length are truncated, whereas shorter sequences are padded with zeros. Keras is a higher-level library built on top of TensorFlow. It is available in R through the keras package. The input to the Keras embedding are integers. These integers are of the tokens. This representation is passed to the embedding layer. The embedding layer acts as the first hidden layer of the neural network.

```
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
```

### 2.1.3 Monte Carlo p-value

Deep learning models predict only enrichment scores. The p-values of the scores are not provided by the model. So, the Monte Carlo p-value method is used within the algorithm. Computing the p-value for a statistical test can be easily accomplished via Monte Carlo. The ordinary Monte Carlo is a simulation technique for approximating the expectation of a function for a general random variable, when the exact expectation cannot be found analytically. The Monte Carlo p-value method simply simulates a lot of datasets under the null, computes a statistic for each generated dataset, and then computes the percentile rank of observed value among these sets of simulated values. The number of tokens used for each simulation is the same to the length of the sequence of the corresponding term. If a new text does not have any tokens, its p-value is not available.

```
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
```

### 2.1.4 visualization

You are allowed to create a visualization of your model architecture.

```
if (exists("ttgseaRes")) {
  summary(ttgseaRes$model)
  plot_model(ttgseaRes$model)
}
```

## 2.2 Leading edge genes

Take another exmaple. A set of names of ranked genes can be seen as sequential data. In the result of GSEA, names of leading edge genes for each gene set are given. The leading edge subset contains genes which contribute most to the enrichment score. Thus the scores of one or more genes of the leading edge subset can be predicted.

```
if (keras::is_keras_available() & reticulate::py_available()) {
  # leading edge
  LE <- unlist(lapply(fgseaRes$leadingEdge, function(x) gsub(",", "", toString(x))))
  fgseaRes <- cbind(fgseaRes, LE)

  # model parameters
  num_tokens <- 1000
  length_seq <- 30
  batch_size <- 32
  embedding_dim <- 50
  num_units <- 32
  epochs <- 10

  # algorithm
  ttgseaRes <- fit_model(fgseaRes, "LE", "NES",
                         model = bi_lstm(num_tokens, embedding_dim,
                                         length_seq, num_units),
                         num_tokens = num_tokens,
                         length_seq = length_seq,
                         epochs = epochs,
                         batch_size = batch_size,
                         verbose = 0,
                         callbacks = callback_early_stopping(
                            monitor = "loss",
                            patience = 5,
                            restore_best_weights = TRUE))

  # prediction for every token
  ttgseaRes$token_pred

  # prediction with MC p-value
  set.seed(1)
  new_text <- c("107995 56150", "16952")
  predict_model(ttgseaRes, new_text)
}
```

# 3 Case Study

The “airway” dataset has four cell lines with two conditions, control and treatment with dexamethasone. By using the package “DESeq2”, differntially expressed genes between controls and treated samples are identified from the gene expression data. Then the log2FC is used as a score for GSEA. For GSEA, GOBP for human is obtained from the package “org.Hs.eg.db”, by using the package “BiocSet”. GSEA is performed by the package “fgsea”. Since “fgsea” can accept a list, the type of gene set is converted to a list. Finally, the result of GSEA is fitted to a deep learning model, and then enrichment scores of new terms can be predicted.

```
if (keras::is_keras_available() & reticulate::py_available()) {
  ## data preparation
  library(airway)
  data(airway)

  ## differentially expressed genes
  library(DESeq2)
  des <- DESeqDataSet(airway, design = ~ dex)
  des <- DESeq(des)
  res <- results(des)
  head(res)
  # log2FC used for GSEA
  statistic <- res$"log2FoldChange"
  names(statistic) <- rownames(res)
  statistic <- na.omit(statistic)
  head(statistic)

  ## gene set
  library(org.Hs.eg.db)
  library(BiocSet)
  go <- go_sets(org.Hs.eg.db, "ENSEMBL", ontology = "BP")
  go <- as(go, "list")
  # convert GO id to term name
  library(GO.db)
  names(go) <- Term(GOTERM)[names(go)]

  ## GSEA
  library(fgsea)
  set.seed(1)
  fgseaRes <- fgsea(go, statistic)
  head(fgseaRes)

  ## tokenizing text of GSEA
  # model parameters
  num_tokens <- 5000
  length_seq <- 30
  batch_size <- 64
  embedding_dim <- 128
  num_units <- 32
  epochs <- 20
  # algorithm
  ttgseaRes <- fit_model(fgseaRes, "pathway", "NES",
                         model = bi_lstm(num_tokens, embedding_dim,
                                         length_seq, num_units),
                         num_tokens = num_tokens,
                         length_seq = length_seq,
                         epochs = epochs,
                         batch_size = batch_size,
                         callbacks = keras::callback_early_stopping(
                           monitor = "loss",
                           patience = 5,
                           restore_best_weights = TRUE))
  # prediction
  ttgseaRes$token_pred
  set.seed(1)
  predict_model(ttgseaRes, c("translation response",
                             "cytokine activity",
                             "rhodopsin mediate",
                             "granzyme",
                             "histone deacetylation",
                             "helper T cell",
                             "Wnt"))
}
```

# 4 Session information

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
## [1] fgsea_1.36.0  ttgsea_1.18.0 keras_2.16.0
##
## loaded via a namespace (and not attached):
##  [1] fastmatch_1.1-6      gtable_0.3.6         xfun_0.53
##  [4] bslib_0.9.0          ggplot2_4.0.0        htmlwidgets_1.6.4
##  [7] visNetwork_2.1.4     lattice_0.22-7       vctrs_0.6.5
## [10] tools_4.5.1          tfruns_1.5.4         generics_0.1.4
## [13] parallel_4.5.1       tibble_3.3.0         sylly.en_0.1-3
## [16] pkgconfig_2.0.3      tokenizers_0.3.0     Matrix_1.7-4
## [19] data.table_1.17.8    RColorBrewer_1.1-3   S7_0.2.0
## [22] lifecycle_1.0.4      farver_2.1.2         compiler_4.5.1
## [25] RhpcBLASctl_0.23-42  codetools_0.2-20     SnowballC_0.7.1
## [28] htmltools_0.5.8.1    sass_0.4.10          yaml_2.3.10
## [31] pillar_1.11.1        crayon_1.5.3         jquerylib_0.1.4
## [34] whisker_0.4.1        BiocParallel_1.44.0  cachem_1.1.0
## [37] koRpus.lang.en_0.1-4 koRpus_0.13-8        text2vec_0.6.4
## [40] rsparse_0.5.3        textstem_0.1.4       stopwords_2.3
## [43] tidyselect_1.2.1     digest_0.6.37        stringi_1.8.7
## [46] slam_0.1-55          dplyr_1.1.4          purrr_1.1.0
## [49] cowplot_1.2.0        fastmap_1.2.0        grid_4.5.1
## [52] cli_3.6.5            magrittr_2.0.4       DiagrammeR_1.0.11
## [55] base64enc_0.1-3      dichromat_2.0-0.1    withr_3.0.2
## [58] scales_1.4.0         float_0.3-3          sylly_0.1-6
## [61] rmarkdown_2.30       reticulate_1.44.0    mlapi_0.1.1
## [64] png_0.1-8            NLP_0.3-2            evaluate_1.0.5
## [67] knitr_1.50           tm_0.7-16            rlang_1.1.6
## [70] Rcpp_1.1.0           zeallot_0.2.0        glue_1.8.0
## [73] xml2_1.4.1           jsonlite_2.0.0       lgr_0.5.0
## [76] R6_2.6.1             tensorflow_2.20.0
```

# 5 References

Alterovitz, G., & Ramoni, M. (Eds.). (2011). Knowledge-Based Bioinformatics: from Analysis to Interpretation. John Wiley & Sons.

Consoli, S., Recupero, D. R., & Petkovic, M. (2019). Data Science for Healthcare: Methodologies and Applications. Springer.

DasGupta, A. (2011). Probability for Statistics and Machine Learning: Fundamentals and Advanced Topics. Springer.

Ghatak, A. (2019). Deep Learning with R. Springer.

Hassanien, A. E., & Elhoseny, M. (2019). Cybersecurity and Secure Information Systems: Challenges and Solutions and Smart Environments. Springer.

Leong, H. S., & Kipling, D. (2009). Text-based over-representation analysis of microarray gene lists with annotation bias. Nucleic acids research, 37(11), e79.

Micheas, A. C. (2018). Theory of Stochastic Objects: Probability, Stochastic Processes and Inference. CRC Press.

Shaalan, K., Hassanien, A. E., & Tolba, F. (Eds.). (2017). Intelligent Natural Language Processing: Trends and Applications (Vol. 740). Springer.