---
name: galaxy-ml
description: galaxy-ml is a machine learning framework that extends the scikit-learn API to support deep learning integration and specialized biomedical data processing. Use when user asks to build end-to-end machine learning pipelines, wrap Keras models for scikit-learn compatibility, perform hyperparameter tuning on genomic data, or use specialized biological sequence encoders and generators.
homepage: https://github.com/goeckslab/Galaxy-ML
---


# galaxy-ml

## Overview
galaxy-ml is a specialized framework that extends scikit-learn's unified API to support complex machine learning workflows, with a focus on biomedical applications. It allows users to build end-to-end pipelines that combine standard estimators with deep learning models and domain-specific preprocessing steps. This skill provides guidance on programmatic model construction, efficient model persistence using HDF5, and the utilization of specialized bio-data generators and encoders.

## Core Implementation Patterns

### Keras Integration with Scikit-Learn
To use deep learning models within scikit-learn workflows (like GridSearchCV), use the `KerasGClassifier` or `KerasGRegressor` wrappers.

1.  **Define the Architecture**: Build a standard Keras `Sequential` model.
2.  **Extract Configuration**: Use `model.get_config()` to pass the architecture to the galaxy-ml wrapper.
3.  **Initialize Wrapper**: Instantiate `KerasGClassifier` with the config.

```python
from keras.models import Sequential
from keras.layers import Dense, Activation
from galaxy_ml.keras_galaxy_models import KerasGClassifier

# Build architecture
model = Sequential()
model.add(Dense(64, input_shape=(input_dim,)))
model.add(Activation('relu'))
model.add(Dense(1, activation='sigmoid'))

# Wrap for scikit-learn compatibility
config = model.get_config()
classifier = KerasGClassifier(config, random_state=42)
```

### Model Persistence
Avoid using standard `pickle` for large biomedical models or pipelines containing large arrays. galaxy-ml provides HDF5-based utilities that are significantly faster and more space-efficient.

*   **Saving**: `dump_model_to_h5(model, 'path/to/save.h5', store_hyperparameter=True)`
*   **Loading**: `model = load_model_from_h5('path/to/save.h5')`

### Hyperparameter Tuning
Since galaxy-ml wrappers implement the scikit-learn API, you can use standard model selection tools. When tuning Keras models, use the `layers_` prefix to target specific layer parameters.

```python
from sklearn.model_selection import GridSearchCV

# Define parameter grid using the galaxy-ml naming convention
params = {
    'epochs': [50, 100],
    'lr': [0.01, 0.001],
    'layers_0_Dense__config__kernel_initializer__config__seed': [42, 999]
}

grid = GridSearchCV(classifier, param_grid=params, scoring='roc_auc', cv=5)
grid.fit(X, y)
```

## Specialized Biomedical Preprocessors
galaxy-ml includes several preprocessors and generators tailored for biological data that should be used in the `Preprocessor` stage of a pipeline:

*   **Sequence Encoders**: `GenomeOneHotEncoder`, `ProteinOneHotEncoder`.
*   **Data Generators**: `FastaDNABatchGenerator`, `FastaProteinBatchGenerator`, `GenomicIntervalBatchGenerator`.
*   **Feature Selection**: `ReliefF`, `SURF`, `MultiSURF` (via skrebate integration).
*   **Imbalanced Data**: `Z_RandomOverSampler` and integrations with `imblearn`.

## Expert Tips
*   **Memory Management**: When working with large genomic datasets, prefer `KerasGBatchClassifier` which works with online data generators to avoid loading entire datasets into RAM.
*   **Parallelism**: Set `n_jobs` in `GridSearchCV` to leverage parallel computation, but ensure your backend (TensorFlow/Keras) is configured to handle thread safety if using deep learning models.
*   **Target Transformation**: Use `BinarizeTargetClassifier` or `BinarizeTargetRegressor` when your labels require specific thresholding or transformation before fitting.

## Reference documentation
- [github_com_goeckslab_Galaxy-ML.md](./references/github_com_goeckslab_Galaxy-ML.md)
- [anaconda_org_channels_bioconda_packages_galaxy-ml_overview.md](./references/anaconda_org_channels_bioconda_packages_galaxy-ml_overview.md)