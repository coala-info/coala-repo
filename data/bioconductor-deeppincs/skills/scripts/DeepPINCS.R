# Code example from 'DeepPINCS' vignette. See references/ for full tutorial.

## ----eval=TRUE----------------------------------------------------------------
if (keras::is_keras_available() & reticulate::py_available()) {
    library(DeepPINCS)
    example_cpi <- example_cpi[1:500,]
    validation_split <- 0.3
    idx <- sample(seq_len(length(example_cpi[,1])))
    train_idx <- seq_len(length(example_cpi[,1])) %in%
        idx[seq_len(round(length(example_cpi[,1]) * (1 - validation_split)))]
}

## ----eval=TRUE----------------------------------------------------------------
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

## ----eval=TRUE----------------------------------------------------------------
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

## ----eval=TRUE----------------------------------------------------------------
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

## ----eval=TRUE----------------------------------------------------------------
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

## ----eval=TRUE----------------------------------------------------------------
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

## ----eval=TRUE----------------------------------------------------------------
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

## ----eval=TRUE----------------------------------------------------------------
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

## ----eval=TRUE----------------------------------------------------------------
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

## -----------------------------------------------------------------------------
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

## ----eval=TRUE----------------------------------------------------------------
sessionInfo()

