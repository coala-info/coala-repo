---
name: scikit-learn
description: Scikit-learn is a Python library for classical machine learning that provides tools for regression, classification, clustering, and dimensionality reduction. Use when user asks to train models, preprocess data using transformers, build machine learning pipelines, or evaluate model performance.
homepage: https://github.com/scikit-learn/scikit-learn
---


# scikit-learn

## Overview
Scikit-learn is the industry-standard Python library for classical machine learning. It provides a consistent API for a wide range of algorithms including regression, classification, clustering, and dimensionality reduction. This skill focuses on the "Estimator" API pattern, efficient data handling using NumPy/SciPy, and robust model evaluation workflows.

## Core API Patterns
All objects in scikit-learn follow a consistent interface:
- **Estimators**: Use `.fit(X, y)` to train a model from data.
- **Transformers**: Use `.transform(X)` to modify data (e.g., scaling, encoding). Use `.fit_transform(X)` for efficiency during training.
- **Predictors**: Use `.predict(X)` or `.predict_proba(X)` to generate outputs from a fitted model.

## Best Practices
- **Pipelines**: Always wrap transformers and estimators in a `sklearn.pipeline.Pipeline`. This prevents data leakage by ensuring preprocessing parameters are calculated only on the training fold during cross-validation.
- **ColumnTransformer**: Use `sklearn.compose.ColumnTransformer` to apply different preprocessing steps to different feature subsets (e.g., OneHotEncoding for categories, StandardScaler for numerics).
- **Cross-Validation**: Use `cross_val_score` or `GridSearchCV` rather than a single train/test split to ensure model stability.
- **Data Types**: Ensure input `X` is a 2D array-like (NumPy array or Pandas DataFrame) and `y` is a 1D array-like.
- **Reproducibility**: Always set the `random_state` parameter in stochastic algorithms (e.g., Random Forest, SGD) to ensure consistent results across runs.

## Common Workflows
### Model Selection and Hyperparameter Tuning
1. Define a parameter grid.
2. Use `GridSearchCV` or `RandomizedSearchCV` (for large search spaces).
3. Access the best model via the `best_estimator_` attribute.

### Evaluation Metrics
- **Classification**: Use `classification_report` for a comprehensive view of precision, recall, and F1-score.
- **Regression**: Use `mean_squared_error` or `r2_score`.
- **Visualizations**: Use "Display" classes like `ConfusionMatrixDisplay` or `RocCurveDisplay` for quick plotting with Matplotlib.

## CLI and Environment
- **Installation**: `pip install -U scikit-learn` or `conda install -c conda-forge scikit-learn`.
- **Testing**: Run `pytest sklearn` from the root directory to verify the installation and environment compatibility.
- **Thread Control**: Use the `threadpoolctl` library to limit the number of threads used by OpenBLAS or MKL if running in a constrained environment.

## Reference documentation
- [scikit-learn GitHub Repository](./references/github_com_scikit-learn_scikit-learn.md)
- [scikit-learn Wiki](./references/github_com_scikit-learn_scikit-learn_wiki.md)