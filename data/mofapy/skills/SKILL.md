---
name: mofapy
description: mofapy is the Python implementation of the Multi-Omics Factor Analysis (MOFA) framework.
homepage: https://github.com/PMBio/MOFA
---

# mofapy

## Overview
mofapy is the Python implementation of the Multi-Omics Factor Analysis (MOFA) framework. It acts as a statistically rigorous generalization of Principal Component Analysis (PCA) designed specifically for multi-omics data. This skill enables the discovery of "latent factors" that explain variance across different data modalities (views) for the same set of samples. It is particularly effective for identifying disease subgroups, cellular states, and biological pathways that are consistently represented across different layers of biological regulation.

## Installation and Environment Setup
The `mofapy` package is a dependency for the R-based MOFA workflow but can be managed via Python package managers.

- **Conda (Recommended):**
  ```bash
  conda install -c bioconda mofapy
  ```
- **Pip:**
  ```bash
  pip install mofapy
  ```

## Core Workflow Patterns

### 1. Data Preparation
MOFA expects data organized into "views" (different omics types). Input data should be centered and scaled per feature where appropriate.
- Ensure sample IDs match across different views.
- MOFA handles missing values and missing entire assays for specific samples automatically.

### 2. Model Training (via R/Reticulate)
While `mofapy` provides the computational engine, the primary interface is typically through the MOFA R package which calls the Python backend.

```r
library(MOFA)

# 1. Create MOFA object
MOFAobject <- createMOFAobject(data_list)

# 2. Prepare MOFA
MOFAobject <- prepareMOFA(
  MOFAobject, 
  model_options = get_default_model_options(MOFAobject),
  train_options = get_default_train_options(MOFAobject)
)

# 3. Run the model (triggers mofapy backend)
MOFAobject <- runMOFA(MOFAobject, outfile = "model.hdf5")
```

### 3. Downstream Analysis Best Practices
Once the model is trained and saved as an HDF5 file, focus on these key interpretations:
- **Variance Decomposition:** Calculate the fraction of variance explained by each factor in each view to determine which omics types drive specific factors.
- **Loading Inspection:** Identify top features (genes, CpG sites, etc.) with high weights for a specific factor to understand its biological meaning.
- **Factor Correlation:** Correlate latent factors with clinical metadata (e.g., survival, treatment response) to identify biomarkers.
- **Imputation:** Use `impute(MOFAobject)` to fill in missing values in the original data matrices based on the learned latent space.

## Expert Tips
- **Factor Selection:** If the model converges with many factors explaining very little variance, consider reducing the number of factors in `model_options`.
- **Convergence Issues:** If the ELBO (Evidence Lower Bound) does not plateau, increase the `maxiter` parameter in `train_options`.
- **Sparsity:** Use the default sparsity priors (Automatic Relevance Determination) to allow the model to "shut down" factors that do not explain significant variance in any view.

## Reference documentation
- [Multi-Omics Factor Analysis GitHub](./references/github_com_bioFAM_MOFA.md)
- [Bioconda mofapy Overview](./references/anaconda_org_channels_bioconda_packages_mofapy_overview.md)