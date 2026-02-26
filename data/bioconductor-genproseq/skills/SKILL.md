---
name: bioconductor-genproseq
description: GenProSeq provides tools for protein engineering by training deep generative models like GANs, VAEs, and Transformers to generate novel amino acid sequences. Use when user asks to train generative models on protein sequences, generate novel protein sequences, or perform Word2vec embedding for amino acids.
homepage: https://bioconductor.org/packages/release/bioc/html/GenProSeq.html
---


# bioconductor-genproseq

name: bioconductor-genproseq
description: Expert guidance for using the GenProSeq R package to generate protein sequences using deep generative models (GAN, VAE, and Transformer-based Autoregressive models). Use this skill when a user needs to train models on protein sequences, generate novel sequences, or perform word embedding (Word2vec) for amino acids.

# bioconductor-genproseq

## Overview
GenProSeq is a Bioconductor package designed for protein engineering through deep generative modeling. It provides tools to convert amino acid sequences into numerical formats (Word2vec embedding) and train three primary types of models:
1. **Generative Adversarial Networks (GAN)**: For mimicking sequence distributions.
2. **Variational Autoencoders (VAE)**: For latent space representation and conditional generation (CVAE).
3. **Autoregressive Transformers (ART)**: For predicting subsequent amino acids based on context.

**Note:** This package requires a working Python environment with `keras` and `tensorflow` installed via `reticulate`.

## Core Workflows

### 1. Generative Adversarial Networks (GAN)
Use `fit_GAN` to train a model on aligned sequences and `gen_GAN` to produce new ones.

```r
library(GenProSeq)
data("example_PTEN")

# Train GAN
GAN_result <- fit_GAN(
  prot_seq = example_PTEN,
  length_seq = 403,
  embedding_dim = 8,
  latent_dim = 4,
  epochs = 20,
  batch_size = 64
)

# Generate 100 sequences
gen_prot_GAN <- gen_GAN(GAN_result, num_seq = 100)
```

### 2. Conditional Variational Autoencoders (CVAE)
Use `fit_VAE` for unsupervised learning of latent spaces. Adding a `label` parameter enables conditional generation.

```r
data("example_luxA")
label <- substr(example_luxA, 3, 3) # Example: using 3rd AA as label

# Train VAE
VAE_result <- fit_VAE(
  prot_seq = example_luxA,
  label = label,
  length_seq = 360,
  embedding_dim = 8,
  epochs = 20,
  batch_size = 128
)

# Generate sequences with a specific label (e.g., "I")
gen_prot_VAE <- gen_VAE(VAE_result, label = rep("I", 100), num_seq = 100)
```

### 3. Autoregressive Transformer (ART)
Use `fit_ART` to train a language model on protein sequences. This is effective for modeling long-term dependencies.

```r
# Train Transformer
ART_result <- fit_ART(
  prot_seq = my_sequences,
  length_seq = 10,
  embedding_dim = 16,
  num_heads = 2,
  ff_dim = 16,
  num_transformer_blocks = 2,
  epochs = 100
)

# Generate using different sampling methods
# Methods: "greedy", "beam", "temperature", "top_k", "top_p"
seed_prot <- "SGFRKMAFPS"
new_seq <- gen_ART(ART_result, seed_prot, length_AA = 20, method = "top_p", p = 0.75)
```

## Evaluation and Visualization
* **Sequence Logos**: Use `ggseqlogo::ggseqlogo()` on the generated character vectors to visualize conservation.
* **Similarity**: Use `stringdist::stringsim()` to compare generated sequences against real sequences to evaluate how well the model captured the distribution.
* **Model Architecture**: Use `ttgsea::plot_model()` or `VAExprs::plot_vae()` on the result objects to inspect the neural network layers.

## Tips
* **Alignment**: GAN and VAE models typically require input sequences to be aligned to the same length.
* **Embedding**: The package uses Word2vec for embedding in GAN/VAE. You can tune this via `embedding_args` in the fit functions.
* **Hardware**: Deep learning models are computationally intensive; ensure `keras::is_keras_available()` returns `TRUE` before starting.

## Reference documentation
- [Generating Protein Sequences with Deep Generative Models](./references/GenProSeq.md)