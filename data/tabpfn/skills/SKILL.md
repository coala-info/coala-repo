---
name: tabpfn
description: TabPFN is a transformer-based foundation model designed for classification and regression tasks on tabular data using in-context learning. Use when user asks to perform tabular data classification, run regression on structured datasets, or use a scikit-learn compatible transformer model for zero-shot machine learning.
homepage: https://github.com/PriorLabs/TabPFN
---


# tabpfn

## Overview

TabPFN is a transformer-based foundation model designed specifically for tabular data. Unlike traditional gradient-boosted decision trees (GBDTs) like XGBoost or LightGBM, TabPFN leverages prior training on vast amounts of synthetic and real-world data to perform "In-Context Learning." This allows it to achieve state-of-the-art results on new datasets with very little configuration. It implements a scikit-learn compatible interface, making it easy to integrate into existing data science workflows for both classification and regression tasks.

## Installation

Install the core package via pip:

```bash
pip install tabpfn
```

For advanced features (interpretability, unsupervised tasks, embeddings), install the extensions:

```bash
pip install tabpfn-extensions
```

## Core Usage Patterns

### Classification
TabPFN handles multi-class classification (up to 10 classes by default).

```python
from tabpfn import TabPFNClassifier

# Initialize (defaults to TabPFN 2.5 weights)
clf = TabPFNClassifier()

# Standard sklearn fit/predict workflow
clf.fit(X_train, y_train)
prediction_probabilities = clf.predict_proba(X_test)
predictions = clf.predict(X_test)
```

### Regression
The regressor is trained on synthetic data and provides robust zero-shot performance.

```python
from tabpfn import TabPFNRegressor

regressor = TabPFNRegressor()
regressor.fit(X_train, y_train)
predictions = regressor.predict(X_test)
```

## Expert Tips and Best Practices

### Hardware Optimization
*   **GPU Usage**: A GPU is highly recommended for datasets larger than 1,000 samples. 8GB VRAM is usually sufficient, though 16GB is better for very large datasets.
*   **CPU Fallback**: On CPU, limit your dataset size to ≲1,000 samples to maintain reasonable inference speeds.
*   **Cloud Inference**: If local GPU resources are unavailable, use `tabpfn-client` to offload computation to PriorLabs' hosted inference API.

### Handling Dataset Limits
TabPFN has built-in limits based on its pre-training (typically 50k samples and 10 classes).
*   **Bypassing Limits**: If your dataset has 50k–100k samples, initialize with `ignore_pretraining_limits=True`.
*   **Many Classes**: For problems exceeding 10 classes, use the `many_class` module from `tabpfn-extensions`.

### Model Versioning
You can explicitly choose between model versions if specific behavior is required:

```python
from tabpfn.constants import ModelVersion
clf = TabPFNClassifier.create_default_for_version(ModelVersion.V2)
```

### Feature Modalities
*   **Text Data**: The API client (`tabpfn-client`) has native support for text columns.
*   **Time-Series**: When working with time-series, ensure you generate relevant time-lagged features before passing data to TabPFN, as it treats rows as independent by default.

## Reference documentation
- [TabPFN Main Repository](./references/github_com_PriorLabs_TabPFN.md)