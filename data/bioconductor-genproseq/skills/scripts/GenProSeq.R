# Code example from 'GenProSeq' vignette. See references/ for full tutorial.

## ----eval=TRUE----------------------------------------------------------------
if (keras::is_keras_available() & reticulate::py_available()) {
    library(GenProSeq)
    data("example_PTEN")
    
    # model parameters
    length_seq <- 403
    embedding_dim <- 8
    latent_dim <- 4
    epochs <- 20
    batch_size <- 64
    
    # GAN
    GAN_result <- fit_GAN(prot_seq = example_PTEN,
                        length_seq = length_seq,
                        embedding_dim = embedding_dim,
                        latent_dim = latent_dim,
                        intermediate_generator_layers = list(
                            layer_dense(units = 16),
                            layer_dense(units = 128)),
                        intermediate_discriminator_layers = list(
                            layer_dense(units = 128, activation = "relu"),
                            layer_dense(units = 16, activation = "relu")),
                        prot_seq_val = example_PTEN,
                        epochs = epochs,
                        batch_size = batch_size)
}

## ----eval=TRUE----------------------------------------------------------------
if (keras::is_keras_available() & reticulate::py_available()) {
    ttgsea::plot_model(GAN_result$generator)
}

## ----eval=TRUE----------------------------------------------------------------
if (keras::is_keras_available() & reticulate::py_available()) {
    ttgsea::plot_model(GAN_result$discriminator)
}

## ----eval=TRUE----------------------------------------------------------------
if (keras::is_keras_available() & reticulate::py_available()) {
    set.seed(1)
    gen_prot_GAN <- gen_GAN(GAN_result, num_seq = 100)
    if (require(ggseqlogo)) {
        ggseqlogo::ggseqlogo(substr(gen_prot_GAN$gen_seq, 1, 20))
    }
}

## ----eval=TRUE----------------------------------------------------------------
if (keras::is_keras_available() & reticulate::py_available()) {
    if (require(ggseqlogo)) {
        ggseqlogo::ggseqlogo(substr(example_PTEN, 1, 20))
    }
}

## ----eval=TRUE----------------------------------------------------------------
if (keras::is_keras_available() & reticulate::py_available()) {
    library(GenProSeq)
    data("example_luxA")
    label <- substr(example_luxA, 3, 3)
    
    # model parameters
    length_seq <- 360
    embedding_dim <- 8
    batch_size <- 128
    epochs <- 20
    
    # CVAE
    VAE_result <- fit_VAE(prot_seq = example_luxA,
                        label = label,
                        length_seq = length_seq,
                        embedding_dim = embedding_dim,
                        embedding_args = list(iter = 20),
                        intermediate_encoder_layers = list(layer_dense(units = 128),
                                                            layer_dense(units = 16)),
                        intermediate_decoder_layers = list(layer_dense(units = 16),
                                                            layer_dense(units = 128)),
                        prot_seq_val = example_luxA,
                        label_val = label,
                        epochs = epochs,
                        batch_size = batch_size,
                        use_generator = FALSE,
                        optimizer = keras::optimizer_adam(clipnorm = 0.1),
                        callbacks = keras::callback_early_stopping(
                            monitor = "val_loss",
                            patience = 10,
                            restore_best_weights = TRUE))
}

## ----eval=TRUE----------------------------------------------------------------
if (keras::is_keras_available() & reticulate::py_available()) {
    VAExprs::plot_vae(VAE_result$model)
}

## ----eval=TRUE----------------------------------------------------------------
if (keras::is_keras_available() & reticulate::py_available()) {
    set.seed(1)
    gen_prot_VAE <- gen_VAE(VAE_result, label = rep("I", 100), num_seq = 100)
    if (require(ggseqlogo)) {
        ggseqlogo::ggseqlogo(substr(gen_prot_VAE$gen_seq, 1, 20))
    }
}

## ----eval=TRUE----------------------------------------------------------------
if (keras::is_keras_available() & reticulate::py_available()) {
    gen_prot_VAE <- gen_VAE(VAE_result, label = rep("L", 100), num_seq = 100)
    if (require(ggseqlogo)) {
        ggseqlogo::ggseqlogo(substr(gen_prot_VAE$gen_seq, 1, 20))
    }
}

## ----eval=TRUE----------------------------------------------------------------
if (keras::is_keras_available() & reticulate::py_available()) {
    if (require(ggseqlogo)) {
        ggseqlogo::ggseqlogo(substr(example_luxA, 1, 20))
    }
}

## ----eval=TRUE----------------------------------------------------------------
if (keras::is_keras_available() & reticulate::py_available()) {
    library(GenProSeq)
    prot_seq <- DeepPINCS::SARS_CoV2_3CL_Protease
    
    # model parameters
    length_seq <- 10
    embedding_dim <- 16
    num_heads <- 2
    ff_dim <- 16
    num_transformer_blocks <- 2
    batch_size <- 32
    epochs <- 100
    
    # ART
    ART_result <- fit_ART(prot_seq = prot_seq,
                        length_seq = length_seq,
                        embedding_dim = embedding_dim,
                        num_heads = num_heads,
                        ff_dim = ff_dim,
                        num_transformer_blocks = num_transformer_blocks,
                        layers = list(layer_dropout(rate = 0.1),
                                    layer_dense(units = 32, activation = "relu"),
                                    layer_dropout(rate = 0.1)),
                        prot_seq_val = prot_seq,
                        epochs = epochs,
                        batch_size = batch_size,
                        use_generator = FALSE,
                        callbacks = callback_early_stopping(
                            monitor = "val_loss",
                            patience = 50,
                            restore_best_weights = TRUE))
}

## ----eval=TRUE----------------------------------------------------------------
if (keras::is_keras_available() & reticulate::py_available()) {
    ttgsea::plot_model(ART_result$model)
}

## ----eval=TRUE----------------------------------------------------------------
if (keras::is_keras_available() & reticulate::py_available()) {
    set.seed(1)
    seed_prot <- "SGFRKMAFPS"
    print(gen_ART(ART_result, seed_prot, length_AA = 20, method = "greedy"))
    print(substr(prot_seq, 1, 30))
    print(gen_ART(ART_result, seed_prot, length_AA = 20, method = "beam", b = 5))
    print(substr(prot_seq, 1, 30))
    print(gen_ART(ART_result, seed_prot, length_AA = 20, method = "temperature", t = 0.1))
    print(substr(prot_seq, 1, 30))
    print(gen_ART(ART_result, seed_prot, length_AA = 20, method = "top_k", k = 3))
    print(substr(prot_seq, 1, 30))
    print(gen_ART(ART_result, seed_prot, length_AA = 20, method = "top_p", p = 0.75))
    print(substr(prot_seq, 1, 30))
}

## ----eval=TRUE----------------------------------------------------------------
if (keras::is_keras_available() & reticulate::py_available()) {
    print(stringdist::stringsim(gen_ART(ART_result, seed_prot, length_AA = 20, method = "greedy"),
                        substr(prot_seq, 1, 30)))
    print(stringdist::stringsim(gen_ART(ART_result, seed_prot, length_AA = 30, method = "greedy"),
                        substr(prot_seq, 1, 40)))
    print(stringdist::stringsim(gen_ART(ART_result, seed_prot, length_AA = 40, method = "greedy"),
                        substr(prot_seq, 1, 50)))
    print(stringdist::stringsim(gen_ART(ART_result, seed_prot, length_AA = 50, method = "greedy"),
                        substr(prot_seq, 1, 60)))
}

## ----eval=TRUE----------------------------------------------------------------
sessionInfo()

