# Code example from 'spongEffects' vignette. See references/ for full tutorial.

## ----warning=FALSE, message=FALSE---------------------------------------------
library(SPONGE)
library(doParallel)
library(foreach)
library(dplyr)

# Register your backend here
num.of.cores <- 4
cl <- makeCluster(num.of.cores) 
registerDoParallel(cl)

## ----echo=FALSE, results='asis'-----------------------------------------------
knitr::kable(train_cancer_gene_expr[1:5,1:8])

## ----echo=FALSE, results='asis'-----------------------------------------------
knitr::kable(test_cancer_gene_expr[1:5,1:8])

## ----warning=FALSE, message=FALSE---------------------------------------------
knitr::kable(train_cancer_mir_expr[1:5,1:8])

## ----warning=FALSE, message=FALSE---------------------------------------------
knitr::kable(test_cancer_mir_expr[1:5,1:8])

## ----warning=FALSE, message=FALSE---------------------------------------------
knitr::kable(train_ceRNA_interactions[1:5,1:8])

## ----warning=FALSE, message=FALSE---------------------------------------------
knitr::kable(train_network_centralities[1:5,1:5])

## ----warning=FALSE, message=FALSE---------------------------------------------
knitr::kable(train_cancer_metadata[1:5,1:8])

## ----warning=FALSE, message=FALSE---------------------------------------------
knitr::kable(test_cancer_metadata[1:5,1:8])

## ----message=FALSE, warning=FALSE---------------------------------------------
filtered_network_centralities=filter_ceRNA_network(sponge_effects = train_ceRNA_interactions, Node_Centrality = train_network_centralities,add_weighted_centrality=T, mscor.threshold = 0.01, padj.threshold = 0.1)

## ----warning=FALSE, message=FALSE---------------------------------------------

RNAs <- c("lncRNA","protein_coding")
RNAs.ofInterest <- ensembl.df %>% dplyr::filter(gene_biotype %in% RNAs) %>%
  dplyr::select(ensembl_gene_id)

central_gene_modules<-get_central_modules(central_nodes = RNAs.ofInterest$ensembl_gene_id,node_centrality = filtered_network_centralities$Node_Centrality,ceRNA_class = RNAs, centrality_measure = "Weighted_Degree", cutoff = 10)


## ----warning=FALSE, message=FALSE---------------------------------------------

Sponge.modules <- define_modules(network = filtered_network_centralities$Sponge.filtered, central.modules = central_gene_modules, remove.central = F, set.parallel = F)
# Module size distribution
Size.modules <- sapply(Sponge.modules, length)


## ----warning=FALSE, message=FALSE---------------------------------------------

train.modules <- enrichment_modules(Expr.matrix = train_cancer_gene_expr, modules = Sponge.modules, bin.size = 10, min.size = 1, max.size = 2000, min.expr = 1, method = "OE", cores=1)
test.modules <-  enrichment_modules(Expr.matrix = test_cancer_gene_expr, modules = Sponge.modules, bin.size = 10, min.size = 1, max.size = 2000, min.expr = 1, method = "OE", cores=1)

## ----warning=FALSE, message=FALSE---------------------------------------------
# We find modules that were identified both in the train and test and use those as input features for the model
common_modules = intersect(rownames(train.modules), rownames(test.modules))
train.modules = train.modules[common_modules, ]
test.modules = test.modules[common_modules, ]

trained.model = calibrate_model(Input = train.modules, modules_metadata = train_cancer_metadata, label = "SUBTYPE", sampleIDs = "sampleID",Metric = "Exact_match", n_folds = 2, repetitions = 1)

trained.model[["ConfusionMatrix_training"]]

## -----------------------------------------------------------------------------
Input.test <- t(test.modules) %>% scale(center = T, scale = T)
Prediction.model <- predict(trained.model$Model, Input.test)

# We compute the confusion metrix on the test set
ConfusionMatrix_testing <- caret::confusionMatrix(as.factor(Prediction.model), as.factor(test_cancer_metadata$SUBTYPE))
trained.model$ConfusionMatrix_testing<-ConfusionMatrix_testing
ConfusionMatrix_testing

## -----------------------------------------------------------------------------
# Define random modules
Random.modules <- Random_spongEffects(sponge_modules = Sponge.modules,
                                      gene_expr = train_cancer_gene_expr, min.size = 1,bin.size = 10, max.size = 200,
                                      min.expression=1, replace = F,method = "OE",cores = 1)
# We can now use the randomly defined modules to calculate their enrichment in the test set
Random.modules.test <- enrichment_modules(Expr.matrix = test_cancer_gene_expr, modules = Random.modules$Random_Modules, bin.size = 10, min.size = 1, max.size = 2000, min.expr = 1, method = "OE", cores=1)


## ----warning=FALSE, message=FALSE---------------------------------------------
# We find random modules that were identified both in the train and test and use those as input features for the model
common_modules_random = intersect(rownames(Random.modules$Enrichment_Random_Modules), rownames(Random.modules.test))
Random.modules.train = Random.modules$Enrichment_Random_Modules[common_modules_random, ]
Random.modules.test = Random.modules.test[common_modules_random, ]

Random.model = calibrate_model(Input = Random.modules.train, modules_metadata = train_cancer_metadata, label = "SUBTYPE", sampleIDs = "sampleID",Metric = "Exact_match", n_folds = 2, repetitions = 1)

Random.model[["ConfusionMatrix_training"]]

## -----------------------------------------------------------------------------
Input.test <- t(Random.modules.test) %>% scale(center = T, scale = T)
Input.test<-Input.test[ , apply(Input.test, 2, function(x) !any(is.na(x)))]

Prediction.model <- predict(Random.model$Model, Input.test)

# We compute the confusion metrix on the test set
ConfusionMatrix_testing_random <- caret::confusionMatrix(as.factor(Prediction.model), as.factor(test_cancer_metadata$SUBTYPE))
Random.model$ConfusionMatrix_testing_random<-ConfusionMatrix_testing_random
ConfusionMatrix_testing_random

## -----------------------------------------------------------------------------
Input.centralgenes.train <- train_cancer_gene_expr[rownames(train_cancer_gene_expr) %in% names(Sponge.modules), ]
Input.centralgenes.test <- test_cancer_gene_expr[rownames(test_cancer_gene_expr) %in% names(Sponge.modules), ]

common_modules = intersect(rownames(Input.centralgenes.train), rownames(Input.centralgenes.test))
Input.centralgenes.train = Input.centralgenes.train[common_modules, ]
Input.centralgenes.test = Input.centralgenes.test[common_modules, ]

# Calibrate model
CentralGenes.model = calibrate_model(Input = Input.centralgenes.train, modules_metadata = train_cancer_metadata, label = "SUBTYPE", sampleIDs = "sampleID",Metric = "Exact_match", n_folds = 1, repetitions = 1)

# Validate on test set
Input.centralgenes.test <- t(Input.centralgenes.test) %>% scale(center = T, scale = T)
CentralGenes.prediction <- predict(CentralGenes.model$Model, Input.centralgenes.test)

# We compute the confusion metrix on the test set
ConfusionMatrix_testing <- caret::confusionMatrix(as.factor(CentralGenes.prediction), as.factor(test_cancer_metadata$SUBTYPE))
CentralGenes.model$ConfusionMatrix_testing<-ConfusionMatrix_testing
ConfusionMatrix_testing


## -----------------------------------------------------------------------------
plot_accuracy_sensitivity_specificity(trained_model=trained.model,central_genes_model=NA,
                                      random_model= Random.model,
                                      training_dataset_name="TCGA",testing_dataset_name="TCGA",
                                      subtypes=as.factor(test_cancer_metadata$SUBTYPE))

## ----warning=FALSE, message=FALSE---------------------------------------------
lollipop_plot=plot_top_modules(trained_model=trained.model, k_modules_red = 2, k_modules = 4)
lollipop_plot

## ----warning=FALSE, message=FALSE---------------------------------------------
density_plot_train=plot_density_scores(trained_model=trained.model,spongEffects = train.modules, meta_data = train_cancer_metadata, label = "SUBTYPE", sampleIDs = "sampleID")
density_plot_train


## -----------------------------------------------------------------------------
heatmap.train = plot_heatmaps(trained_model = trained.model,spongEffects = train.modules,
               meta_data = train_cancer_metadata, label = "SUBTYPE", sampleIDs = "sampleID",Modules_to_Plot = 2,
              show.rownames = F, show.colnames = F)
heatmap.train

## -----------------------------------------------------------------------------
heatmap.test = plot_heatmaps(trained_model = trained.model,spongEffects = test.modules,
               meta_data = test_cancer_metadata, label = "SUBTYPE", sampleIDs = "sampleID",Modules_to_Plot = 2,
              show.rownames = F, show.colnames = F)
heatmap.test

## -----------------------------------------------------------------------------
plot_involved_miRNAs_to_modules(sponge_modules=Sponge.modules,
                                trained_model=trained.model,
                                gene_mirna_candidates= train_genes_miRNA_candidates,
                                k_modules = 2,
                                filter_miRNAs = 0.0,
                                bioMart_gene_symbol_columns = "hgnc_symbol",
                                bioMart_gene_ensembl = "hsapiens_gene_ensembl")

## ----warning=FALSE, message=FALSE---------------------------------------------
#stop your backend parallelisation if registered
stopCluster(cl) 

