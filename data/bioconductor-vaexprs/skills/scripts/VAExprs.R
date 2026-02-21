# Code example from 'VAExprs' vignette. See references/ for full tutorial.

## ----eval=TRUE----------------------------------------------------------------
if (keras::is_keras_available() & reticulate::py_available()) {
    library(VAExprs)
    
    ### simulate differentially expressed genes
    set.seed(1)
    g <- 3
    n <- 100
    m <- 1000
    mu <- 5
    sigma <- 5
    mat <- matrix(rnorm(n*m*g, mu, sigma), m, n*g)
    rownames(mat) <- paste0("gene", seq_len(m))
    colnames(mat) <- paste0("cell", seq_len(n*g))
    group <- factor(sapply(seq_len(g), function(x) { 
        rep(paste0("group", x), n)
    }))
    names(group) <- colnames(mat)
    mu_upreg <- 6
    sigma_upreg <- 10
    deg <- 100
    for (i in seq_len(g)) {
        mat[(deg*(i-1) + 1):(deg*i), group == paste0("group", i)] <- 
            mat[1:deg, group==paste0("group", i)] + rnorm(deg, mu_upreg, sigma_upreg)
    }
    # positive expression only
    mat[mat < 0] <- 0
    x_train <- as.matrix(t(mat))
    
    # heatmap
    heatmap(mat, Rowv = NA, Colv = NA, 
            col = colorRampPalette(c('green', 'red'))(100), 
            scale = "none")
}

## ----eval=TRUE----------------------------------------------------------------
if (keras::is_keras_available() & reticulate::py_available()) {
    # model parameters
    batch_size <- 32
    original_dim <- 1000
    intermediate_dim <- 512
    epochs <- 100
    
    # VAE
    vae_result <- fit_vae(x_train = x_train, x_val = x_train,
                        encoder_layers = list(layer_input(shape = c(original_dim)),
                                            layer_dense(units = intermediate_dim,
                                                        activation = "relu")),
                        decoder_layers = list(layer_dense(units = intermediate_dim,
                                                        activation = "relu"),
                                            layer_dense(units = original_dim,
                                                        activation = "sigmoid")),
                        epochs = epochs, batch_size = batch_size,
                        use_generator = FALSE,
                        callbacks = keras::callback_early_stopping(
                            monitor = "val_loss",
                            patience = 10,
                            restore_best_weights = TRUE))
}

## ----eval=TRUE----------------------------------------------------------------
if (keras::is_keras_available() & reticulate::py_available()) {
    # model architecture
    plot_vae(vae_result$model)
}

## ----eval=TRUE----------------------------------------------------------------
if (keras::is_keras_available() & reticulate::py_available()) {
    # sample generation
    set.seed(1)
    gen_sample_result <- gen_exprs(vae_result, num_samples = 100)
    
    # heatmap
    heatmap(cbind(t(x_train), t(gen_sample_result$x_gen)),
            col = colorRampPalette(c('green', 'red'))(100),
            Rowv=NA)
}

## ----eval=TRUE----------------------------------------------------------------
if (keras::is_keras_available() & reticulate::py_available()) {
    # plot for augmented data
    plot_aug(gen_sample_result, "PCA")
}

## ----eval=TRUE----------------------------------------------------------------
if (keras::is_keras_available() & reticulate::py_available()) {
    library(VAExprs)
    library(SC3)
    library(SingleCellExperiment)
    
    # create a SingleCellExperiment object
    sce <- SingleCellExperiment::SingleCellExperiment(
        assays = list(counts = as.matrix(yan)),
        colData = ann
    )
    
    # define feature names in feature_symbol column
    rowData(sce)$feature_symbol <- rownames(sce)
    # remove features with duplicated names
    sce <- sce[!duplicated(rowData(sce)$feature_symbol), ]
    # remove genes that are not expressed in any samples
    sce <- sce[which(rowMeans(assay(sce)) > 0),]
    dim(assay(sce))
    
    # model parameters
    batch_size <- 32
    original_dim <- 19595
    intermediate_dim <- 256
    epochs <- 100
    
    # model
    cvae_result <- fit_vae(object = sce,
                        encoder_layers = list(layer_input(shape = c(original_dim)),
                                            layer_dense(units = intermediate_dim,
                                                        activation = "relu")),
                        decoder_layers = list(layer_dense(units = intermediate_dim,
                                                        activation = "relu"),
                                            layer_dense(units = original_dim,
                                                        activation = "sigmoid")),
                        epochs = epochs, batch_size = batch_size,
                        use_generator = TRUE,
                        callbacks = keras::callback_early_stopping(
                            monitor = "loss",
                            patience = 20,
                            restore_best_weights = TRUE))
    
    # model architecture
    plot_vae(cvae_result$model)
}

## ----eval=TRUE----------------------------------------------------------------
if (keras::is_keras_available() & reticulate::py_available()) {
    # sample generation
    set.seed(1)
    gen_sample_result <- gen_exprs(cvae_result, 100,
                                batch_size, use_generator = TRUE)
    
    # plot for augmented data
    plot_aug(gen_sample_result, "PCA")
}

## ----eval=TRUE----------------------------------------------------------------
sessionInfo()

