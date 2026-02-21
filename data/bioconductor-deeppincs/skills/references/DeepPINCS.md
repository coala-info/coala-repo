# Protein Interactions and Networks with Compounds based on Sequences using Deep Learning

#### Dongmin Jung

#### September 30, 2021

* [1 Introduction](#introduction)
* [2 Example](#example)
  + [2.1 compound-protein interaction](#compound-protein-interaction)
  + [2.2 chemical-chemical interaction](#chemical-chemical-interaction)
  + [2.3 protein-protein interaction](#protein-protein-interaction)
  + [2.4 single compound](#single-compound)
  + [2.5 single protein](#single-protein)
* [3 Case Study](#case-study)
* [4 Session information](#session-information)
* [5 References](#references)

# 1 Introduction

The identification of novel compound-protein interaction (CPI) is important in drug discovery. Revealing unknown compound-protein interactions is useful to design a new drug for a target protein by screening candidate compounds. The accurate CPI prediction assists in effective drug discovery process. To identify potential CPI effectively, prediction methods based on machine learning and deep learning have been developed. Data for sequences are provided as discrete symbolic data. In the data, compounds are represented as SMILES (simplified molecular-input line-entry system) strings and proteins are sequences in which the characters are amino acids. The outcome is defined as a variable that indicates how strong two molecules interact with each other or whether there is an interaction between them. In this package, a deep-learning based model that takes only sequence information of both compounds and proteins as input and the outcome as output is used to predict CPI. The model is implemented by using compound and protein encoders with useful features. The CPI model also supports other modeling tasks, including protein-protein interaction (PPI), chemical-chemical interaction (CCI), or single compounds and proteins. Although the model is designed for proteins, DNA and RNA can be used if they are represented as sequences.

Multilayer perceptron (MLP) is the simplest form of neural networks consisting only of fully connected layers. Convolutional Neural Network (CNN) has convolutional layers instead of fully connected layers in the initial phase of the network. Recurrent neural network (RNN) are distinguished from other classes by presence of components with memory, containing long short term memory (LSTM) and gated recurrent units (GRU). The graph neural network (GNN) is a class of deep learning methods designed to perform inference on graph data. The graph convolutional network (GCN) is a type of GNN that can work directly on graphs and take advantage of their structural information. The GCN enables to learn hidden layer representations that capture both graph structure and node features. Compounds are represented as graphs and GCN can be used to learn compound-protein interactions. In molecular graph representations, nodes represent atoms and edges represent bonds. Besides graphs, a molecular fingerprint can be extracted from SMILES strings. A molecular fingerprint is a way of encoding the structural features of a molecule. Fingerprints are special kinds of descriptors that characterize a molecule and its properties as a binary bit vector that represents the presence or absence of particular substructure in the molecule. The Chemistry Development Kit (CDK) is an open source toolkit for bioinformatics and cheminformatics. It can accept the SMILES notation of a molecule as input to calculate molecular descriptors and fingerprints or get structural information. It can be implemented in R by the rcdk package.

# 2 Example

## 2.1 compound-protein interaction

The “example\_cpi” dataset has compound-protein pairs and their interactions. Each line has a SMILES string, an amino acid sequence, and a label. Here, the label 1 means that the pair of SMILES and amino acid sequences has interaction and 0 means that the pair does not have interaction. In order to avoid overfitting, the data is split into a training sample and a validation sample. The training sample is used to estimate parameters or weights of the deep learning models. The validation sample is an independent sample, set aside to monitor the misclassification error. Here, 70% of the data are used for training and 30% for validation.

```
if (keras::is_keras_available() & reticulate::py_available()) {
    library(DeepPINCS)
    example_cpi <- example_cpi[1:500,]
    validation_split <- 0.3
    idx <- sample(seq_len(length(example_cpi[,1])))
    train_idx <- seq_len(length(example_cpi[,1])) %in%
        idx[seq_len(round(length(example_cpi[,1]) * (1 - validation_split)))]
}
```

The input sequences are fed into encoders. We need to provide the list of arguments for compound and protein encoder networks and for fully connected layer. For compound and protein networks, input and output tensors of encoders are required. Here, we can choose the graph convolutional network (GCN), recurrent neural network (RNN), convolutional neural network (CNN), and multilayer perceptron (MLP) as encoders. Additionally, we can use our own encoders. Note that the GCN is only available for compounds. The arguments for the “compound” and “protein” are the function of encoders with input and output tensors. The “compound\_arg” and “protein\_arg” are the arguments of the functions. The compound and protein encoders are concatenated and they are passed to the dense layer. A dense layer is a fully connected layer. We now need to compile the model, this step configures the learning process for our neural network architecture. We need to provide three arguments including the optimization algorithm to be used, the loss function to be optimized and metrics for evaluation.

```
if (keras::is_keras_available() & reticulate::py_available()) {
    net_args <- list(
        compound = "gcn_in_out",
        compound_args = list(
            gcn_units = c(128, 64),
            gcn_activation = c("relu", "relu"),
            fc_units = c(10),
            fc_activation = c("relu")),
        protein = "cnn_in_out",
        protein_args = list(
            cnn_filters = c(32),
            cnn_kernel_size = c(3),
            cnn_activation = c("relu"),
            fc_units = c(10),
            fc_activation = c("relu")),
        fc_units = c(1),
        fc_activation = c("sigmoid"),
        loss = "binary_crossentropy",
        optimizer = keras::optimizer_adam(),
        metrics = "accuracy")
}
```

For example, consider the GCN for compounds and the CNN for proteins. For the GCN, we have to set the maximum number of atoms since every compound has not the same number of atoms. The degree of an atom in the graph representation and the atomic symbol and implicit hydrogen count for an atom are used as molecular features. Similarly, we define the maximum number of amino acids because there will be proteins of different lengths. In other words, naturally, some of the proteins are shorter and longer. The layer for embeddings to help us map strings to vectors. For them, we need to provide the dimension of the dense embedding. The n-gram is available only for protein sequences. We can use “callbacks”. The callback functions can terminate the training process, modify the learning rate, and save snapshots of the best version of our model during the training process.

```
if (keras::is_keras_available() & reticulate::py_available()) {
    compound_max_atoms <- 50
    protein_embedding_dim <- 16
    protein_length_seq <- 100
    gcn_cnn_cpi <- fit_cpi(
        smiles = example_cpi[train_idx, 1],
        AAseq = example_cpi[train_idx, 2],
        outcome = example_cpi[train_idx, 3],
        compound_type = "graph",
        compound_max_atoms = compound_max_atoms,
        protein_length_seq = protein_length_seq,
        protein_embedding_dim = protein_embedding_dim,
        protein_ngram_max = 2,
        protein_ngram_min = 1,
        smiles_val = example_cpi[!train_idx, 1],
        AAseq_val = example_cpi[!train_idx, 2],
        outcome_val = example_cpi[!train_idx, 3],
        net_args = net_args,
        epochs = 20,
        batch_size = 64,
        callbacks = keras::callback_early_stopping(
            monitor = "val_accuracy",
            patience = 10,
            restore_best_weights = TRUE))
    ttgsea::plot_model(gcn_cnn_cpi$model)
}
```

Using the trained model, we can predict whether pairs of SMILES and amino acid sequences have interaction or not. A very convenient way to evaluate the accuracy of a model is the use of a table that summarizes the performance of our algorithm against the data provided. The Receiver Operator Characteristic (ROC) is a quantitative analysis technique used in binary classification. The ROC curve is a helpful diagnostic for a model. The Area Under the Curve (AUC) can be calculated and provide a single score to summarize the plot that can be used to compare models. An alternative to the ROC curve is the precision-recall curve that can be useful for imbalanced data.

```
if (keras::is_keras_available() & reticulate::py_available()) {
    pred <- predict_cpi(gcn_cnn_cpi,
        smiles = example_cpi[!train_idx, 1],
        AAseq = example_cpi[!train_idx, 2],
        batch_size = 32)
    pred_calss <- ifelse(pred$values > 0.5, 1, 0)
    table(pred_calss, example_cpi[!train_idx, 3])

    roc <- PRROC::roc.curve(scores.class0 = pred$values[example_cpi[!train_idx, 3] == 1],
        scores.class1 = pred$values[example_cpi[!train_idx,3] == 0],
        curve = TRUE)
    plot(roc)
    pr <- PRROC::pr.curve(scores.class0 = pred$values[example_cpi[!train_idx, 3] == 1],
        scores.class1 = pred$values[example_cpi[!train_idx,3] == 0],
        curve = TRUE)
    plot(pr)
}
```

## 2.2 chemical-chemical interaction

The chemical-chemical interactions such as drug-drug interactions (DDI) have become one of the emerging topics of the clinical drug development. Predictions of DDI are fueled by recent growth of knowledge in molecular biology, computation based simulation or predictions, and a better understanding of the inhibition and induction mechanisms. Here, the molecular fingerprint is used from SMILES strings.

```
if (keras::is_keras_available() & reticulate::py_available()) {
    library(DeepPINCS)
    validation_split <- 0.3
    idx <- sample(seq_len(length(example_cci[,1])))
    train_idx <- seq_len(length(example_cci[,1])) %in%
        idx[seq_len(round(length(example_cci[,1]) * (1 - validation_split)))]

    mlp_mlp_cci <- fit_cpi(
        smiles = example_cci[train_idx, 1:2],
        outcome = example_cci[train_idx, 3],
        compound_type = "fingerprint",
        smiles_val = example_cci[!train_idx, 1:2],
        outcome_val = example_cci[!train_idx, 3],
        net_args = list(
            compound = "mlp_in_out",
            compound_args = list(
                fc_units = c(10, 5),
                fc_activation = c("relu", "relu")),
            fc_units = c(1),
            fc_activation = c("sigmoid"),
            loss = "binary_crossentropy",
            optimizer = keras::optimizer_adam(),
            metrics = "accuracy"),
        epochs = 20, batch_size = 64,
        callbacks = keras::callback_early_stopping(
            monitor = "val_accuracy",
            patience = 10,
            restore_best_weights = TRUE))
    ttgsea::plot_model(mlp_mlp_cci$model)

    pred <- predict_cpi(mlp_mlp_cci,
        smiles = example_cci[!train_idx, 1:2],
        batch_size = 32)
    pred_calss <- ifelse(pred$values > 0.5, 1, 0)
    table(pred_calss, example_cci[!train_idx, 3])
}
```

## 2.3 protein-protein interaction

The protein-protein interactions (PPIs) are biochemical events that play an important role in the functioning of the cell. The prediction of protein-protein interactions has important implications for understanding the behavioral processes of life, preventing diseases, and developing new drugs. Here, the n-gram for proteins is available. However, the q-gram would be better than the n-gram, since the q-gram is a string of q characters. In literature on text classification, the term n-gram is often used instead of the q-gram.

```
if (keras::is_keras_available() & reticulate::py_available()) {
    validation_split <- 0.3
    idx <- sample(seq_len(length(example_ppi[,1])))
    train_idx <- seq_len(length(example_ppi[,1])) %in%
        idx[seq_len(round(length(example_ppi[,1]) * (1 - validation_split)))]

    protein_embedding_dim <- 16
    protein_length_seq <- 100
    mlp_mlp_ppi <- fit_cpi(
        AAseq = example_ppi[train_idx, 1:2],
        outcome = example_ppi[train_idx, 3],
        protein_length_seq = protein_length_seq,
        protein_embedding_dim = protein_embedding_dim,
        AAseq_val = example_ppi[!train_idx, 1:2],
        outcome_val = example_ppi[!train_idx, 3],
        net_args = list(
            protein = "mlp_in_out",
            protein_args = list(
                fc_units = c(10, 5),
                fc_activation = c("relu", "relu")),
            fc_units = c(1),
            fc_activation = c("sigmoid"),
            loss = "binary_crossentropy",
            optimizer = keras::optimizer_adam(),
            metrics = "accuracy"),
        epochs = 20, batch_size = 64,
        callbacks = keras::callback_early_stopping(
            monitor = "val_accuracy",
            patience = 10,
            restore_best_weights = TRUE))
    ttgsea::plot_model(mlp_mlp_ppi$model)

    pred <- predict_cpi(mlp_mlp_ppi,
        AAseq = example_ppi[!train_idx, 1:2],
        batch_size = 32)
    pred_calss <- ifelse(pred$values > 0.5, 1, 0)
    table(pred_calss, example_ppi[!train_idx,3])
}
```

Although the function “fit\_cpi” is designed for amino acid sequences, we may instead use nucleic acid sequences, if they are composed of capital letters of an alphabet.

```
if (keras::is_keras_available() & reticulate::py_available()) {
    validation_split <- 0.1
    idx <- sample(seq_len(length(example_pd[,1])))
    train_idx <- seq_len(length(example_pd[,1])) %in%
        idx[seq_len(round(length(example_pd[,1]) * (1 - validation_split)))]

    protein_embedding_dim <- 16
    protein_length_seq <- 30
    mlp_mlp_pd <- fit_cpi(
        AAseq = example_pd[train_idx, 1:2],
        outcome = example_pd[train_idx, 3],
        protein_length_seq = protein_length_seq,
        protein_embedding_dim = protein_embedding_dim,
        AAseq_val = example_pd[!train_idx, 1:2],
        outcome_val = example_pd[!train_idx, 3],
        net_args = list(
            protein = "mlp_in_out",
            protein_args = list(
                fc_units = c(10, 5),
                fc_activation = c("relu", "relu")),
            fc_units = c(1),
            fc_activation = c("sigmoid"),
            loss = "binary_crossentropy",
            optimizer = keras::optimizer_adam(),
            metrics = "accuracy"),
        epochs = 30, batch_size = 16,
        callbacks = keras::callback_early_stopping(
            monitor = "val_accuracy",
            patience = 10,
            restore_best_weights = TRUE))

    pred <- predict_cpi(mlp_mlp_pd,
        AAseq = example_pd[!train_idx, 1:2],
        batch_size = 16)
    pred_calss <- ifelse(pred$values > 0.5, 1, 0)
    table(pred_calss, example_pd[!train_idx, 3])
}
```

## 2.4 single compound

Even though the function “fit\_cpi” is designed for pairs of compounds, proteins, or both, we may instead use single compounds alone.

```
if (keras::is_keras_available() & reticulate::py_available()) {
    validation_split <- 0.3
    idx <- sample(seq_len(length(example_chem[,1])))
    train_idx <- seq_len(length(example_chem[,1])) %in%
        idx[seq_len(round(length(example_chem[,1]) * (1 - validation_split)))]

    compound_length_seq <- 50
    compound_embedding_dim <- 16
    gcn_chem <- fit_cpi(
        smiles = example_chem[train_idx, 1],
        outcome = example_chem[train_idx, 2],
        compound_type = "sequence",
        compound_length_seq = compound_length_seq,
        compound_embedding_dim = compound_embedding_dim,
        smiles_val = example_chem[!train_idx, 1],
        outcome_val = example_chem[!train_idx, 2],
        net_args = list(
            compound = "mlp_in_out",
            compound_args = list(
                fc_units = c(5),
                fc_activation = c("relu")),
            fc_units = c(1),
            fc_activation = c("sigmoid"),
            loss='binary_crossentropy',
            optimizer = keras::optimizer_adam(),
            metrics = "accuracy"),
        epochs = 20, batch_size = 16,
        callbacks = keras::callback_early_stopping(
            monitor = "val_accuracy",
            patience = 10,
            restore_best_weights = TRUE))
    ttgsea::plot_model(gcn_chem$model)

    pred <- predict_cpi(gcn_chem, smiles = example_chem[!train_idx, 1])
    pred_calss <- ifelse(pred$values > 0.5, 1, 0)
    table(pred_calss, smiles = example_chem[!train_idx,2])
}
```

## 2.5 single protein

In a similar way, we can use single proteins, too. Our model can be extended to multiclass problems.

```
if (keras::is_keras_available() & reticulate::py_available()) {
    example_prot <- example_prot[1:500,]
    example_prot[,2] <- as.numeric(factor(example_prot[,2])) - 1

    validation_split <- 0.3
    idx <- sample(seq_len(length(example_prot[,1])))
    train_idx <- seq_len(length(example_prot[,1])) %in%
        idx[seq_len(round(length(example_prot[,1]) * (1 - validation_split)))]

    protein_embedding_dim <- 16
    protein_length_seq <- 100
    rnn_prot <- fit_cpi(
        AAseq = example_prot[train_idx, 1],
        outcome = to_categorical(example_prot[train_idx, 2]),
        protein_length_seq = protein_length_seq,
        protein_embedding_dim = protein_embedding_dim,
        AAseq_val = example_prot[!train_idx, 1],
        outcome_val = to_categorical(example_prot[!train_idx, 2]),
        net_args = list(
            protein = "rnn_in_out",
            protein_args = list(
                rnn_type = c("gru"),
                rnn_bidirectional = c(TRUE),
                rnn_units = c(50),
                rnn_activation = c("relu"),
                fc_units = c(10),
                fc_activation = c("relu")),
            fc_units = c(3),
            fc_activation = c("softmax"),
            loss = 'categorical_crossentropy',
            optimizer = keras::optimizer_adam(clipvalue = 0.5),
            metrics = "accuracy"),
        epochs = 20, batch_size = 64,
        callbacks = keras::callback_early_stopping(
            monitor = "val_accuracy",
            patience = 10,
            restore_best_weights = TRUE))
    ttgsea::plot_model(rnn_prot$model)

    val_index <- seq_len(length(example_prot[,2]))[!train_idx]
    if (!is.null(rnn_prot$preprocessing$removed_AAseq_val)) {
        pred <- predict_cpi(rnn_prot,
            AAseq = example_prot[val_index[-rnn_prot$preprocessing$removed_AAseq_val[[1]]], 1])
        pred_calss <- apply(pred$values, 1, which.max) - 1
        table(pred_calss, example_prot[val_index[-rnn_prot$preprocessing$removed_AAseq_val[[1]]], 2])
    } else {
        pred <- predict_cpi(rnn_prot, AAseq = example_prot[!train_idx, 1])
        pred_calss <- apply(pred$values, 1, which.max) - 1
        table(pred_calss, example_prot[!train_idx, 2])
    }
}
```

# 3 Case Study

The process of developing drugs is extensive, laborious, expensive, and time consuming. Drug repurposing, also referred to as repositioning, significantly reduces the cost, risk, and time compared to traditional drug development strategies, by recycling already established drugs. In the drug discovery process, it is required to determine the cause of a disease and, thus, a potential biological target. A target can be any biological entity from RNA to a protein to a gene that is ‘druggable’ or accessible to binding with a drug-like compound. Drug interactions with a biological target change the shape or confirmation of some facet of the target when bound to a small molecule and alter the target’s ability to function. This conformational change ideally triggers a desired biological response involved in the particular disease process. Here, deep learning models can be used to identify the candidate drugs for selected targets and disease.

Suppose that we want to identify which existing antiviral drugs can be repurposed to target the SARS coronavirus 3C-like Protease. For training the deep learning model, we use the data from past bioassay data such as high throughput screening (HTS) assay on SARS-CoV 3CL Protease, which conserves large portion of the gene with SARS-CoV-2. For repurposing for COVID-19, the deep learning model is trained using this data to rank drug candidates from the antiviral library.

```
if (keras::is_keras_available() & reticulate::py_available()) {
    compound_length_seq <- 50
    protein_length_seq <- 500
    compound_embedding_dim <- 16
    protein_embedding_dim <- 16

    mlp_mlp <- fit_cpi(
        smiles = example_bioassay[,1],
        AAseq = example_bioassay[,2],
        outcome = example_bioassay[,3],
        compound_type = "sequence",
        compound_length_seq = compound_length_seq,
        protein_length_seq = protein_length_seq,
        compound_embedding_dim = compound_embedding_dim,
        protein_embedding_dim = protein_embedding_dim,
        net_args = list(
            compound = "mlp_in_out",
            compound_args = list(
                fc_units = c(10, 5),
                fc_activation = c("relu", "relu")),
            protein = "mlp_in_out",
            protein_args = list(
                fc_units = c(10, 5),
                fc_activation = c("relu", "relu")),
            fc_units = c(1),
            fc_activation = c("sigmoid"),
            loss = 'binary_crossentropy',
            optimizer = keras::optimizer_adam(),
            metrics = "accuracy"),
        epochs = 20, batch_size = 64,
        validation_split = 0.3,
        verbose = 0,
        callbacks = keras::callback_early_stopping(
            monitor = "val_accuracy",
            patience = 5,
            restore_best_weights = TRUE))
    ttgsea::plot_model(mlp_mlp$model)

    pred <- predict_cpi(mlp_mlp,
        antiviral_drug[,2],
        rep(SARS_CoV2_3CL_Protease, nrow(antiviral_drug)))

    Result <- data.frame(antiviral_drug[,1], pred$values)
    colnames(Result) <- c("drug", "probability")
    Result[order(Result[,2], decreasing = TRUE),]
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
## loaded via a namespace (and not attached):
##  [1] vctrs_0.6.5       cli_3.6.5         knitr_1.50        rlang_1.1.6
##  [5] zeallot_0.2.0     xfun_0.53         png_0.1-8         generics_0.1.4
##  [9] jsonlite_2.0.0    glue_1.8.0        keras_2.16.0      htmltools_0.5.8.1
## [13] sass_0.4.10       rmarkdown_2.30    grid_4.5.1        tfruns_1.5.4
## [17] evaluate_1.0.5    jquerylib_0.1.4   base64enc_0.1-3   fastmap_1.2.0
## [21] yaml_2.3.10       lifecycle_1.0.4   whisker_0.4.1     compiler_4.5.1
## [25] codetools_0.2-20  Rcpp_1.1.0        lattice_0.22-7    digest_0.6.37
## [29] R6_2.6.1          reticulate_1.44.0 pillar_1.11.1     tensorflow_2.20.0
## [33] magrittr_2.0.4    bslib_0.9.0       Matrix_1.7-4      withr_3.0.2
## [37] tools_4.5.1       cachem_1.1.0
```

# 5 References

Balakin, K. V. (2009). Pharmaceutical data mining: approaches and applications for drug discovery. John Wiley & Sons.

Huang, K., Fu, T., Glass, L. M., Zitnik, M., Xiao, C., & Sun, J. (2020). DeepPurpose: A Deep Learning Library for Drug-Target Interaction Prediction. Bioinformatics.

Kipf, T. N., & Welling, M. (2016). Semi-supervised classification with graph convolutional networks. ICLR.

Nguyen, T., Le, H., & Venkatesh, S. (2020). GraphDTA: prediction of drug-target binding affinity using graph convolutional networks. Bioinformatics.

O’Donnell, J. J., Somberg, J., Idemyor, V., & O’Donnell, J. T. (Eds.). (2019). Drug Discovery and Development. CRC Press.

Pedrycz, W., & Chen, S. M. (Eds.). (2020). Deep Learning: Concepts and Architectures. Springer.

Srinivasa, K. G., Siddesh, G. M., & Manisekhar, S. R. (Eds.). (2020). Statistical Modelling and Machine Learning Principles for Bioinformatics Techniques, Tools, and Applications. Springer.

Trabocchi, A. & Lenci, E. (2020). Small molecule drug discovery: methods, molecules and applications. Elsevier.

Tsubaki, M., Tomii, K., & Sese, J. (2019). Compound-protein interaction prediction with end-to-end learning of neural networks for graphs and sequences. Bioinformatics.

Van der Loo, M., & De Jonge, E. (2018). Statistical data cleaning with applications in R. John Wiley & Sons.

Vogel, H. G., Maas, J., & Gebauer, A. (Eds.). (2010). Drug discovery and evaluation: methods in clinical pharmacology. Springer.

Wang, L., Wang, H. F., Liu, S. R., Yan, X., & Song, K. J. (2019). Predicting protein-protein interactions from matrix-based protein sequence using convolution neural network and feature-selective rotation forest. Scientific reports.