---
name: hmmlearn
description: "hmmlearn is a Python library for unsupervised learning and inference of Hidden Markov Models with a scikit-learn compatible API. Use when user asks to train hidden Markov models, decode hidden state sequences, or predict the likelihood of observations using Gaussian, multinomial, or Poisson distributions."
homepage: https://github.com/hmmlearn/hmmlearn
---


# hmmlearn

## Overview

`hmmlearn` is a Python library for unsupervised learning and inference of Hidden Markov Models. It provides a scikit-learn compatible API, allowing users to train models, decode hidden state sequences, and predict the likelihood of new observations. The library supports several types of emission distributions, including Gaussian, Gaussian Mixture Models (GMM), and Multinomial distributions. It is specifically designed for cases where the underlying state transitions are governed by a Markov chain but only the outputs (emissions) are visible.

## Core Usage Patterns

### Model Selection
Choose the class based on your data's emission type:
- `GaussianHMM`: For continuous observations with Gaussian distributions.
- `GMMHMM`: For complex continuous observations modeled by mixtures of Gaussians.
- `MultinomialHMM`: For discrete observations (categorical data).
- `PoissonHMM`: For count-based data.

### Basic Workflow
```python
from hmmlearn import hmm
import numpy as np

# 1. Initialize model
model = hmm.GaussianHMM(n_components=3, covariance_type="full", n_iter=100)

# 2. Fit the model
# X is a matrix of shape (n_samples, n_features)
model.fit(X)

# 3. Predict hidden states (Viterbi)
states = model.predict(X)

# 4. Calculate log-likelihood of the sequence
log_likelihood = model.score(X)
```

### Handling Multiple Sequences
`hmmlearn` requires all sequences to be concatenated into a single matrix `X`, with a separate `lengths` array indicating the size of each individual sequence.
```python
X1 = np.array([[0.5], [1.0], [-0.1]])
X2 = np.array([[0.2], [0.7]])
X = np.concatenate([X1, X2])
lengths = [len(X1), len(X2)]

model.fit(X, lengths=lengths)
```

## Expert Tips and Best Practices

- **Covariance Types**: For `GaussianHMM`, use `covariance_type="diag"` (default) for efficiency if features are independent, or `"full"` if there are strong correlations between features.
- **Convergence Monitoring**: Always check `model.monitor_.converged` after fitting to ensure the EM algorithm reached a local optimum.
- **Model Selection (AIC/BIC)**: For Gaussian, GMM, and Poisson HMMs, you can use the `.aic(X)` and `.bic(X)` methods to compare models with different numbers of hidden states (`n_components`).
- **Manual Initialization**: If you have prior knowledge of the transition matrix or start probabilities, set `init_params=""` and manually assign `model.startprob_` and `model.transmat_` before calling `fit`.
- **Avoiding Underflow**: The library performs computations in log-space to prevent numerical underflow issues common in long sequences. Use `.score()` and `.decode()` which return log-probabilities.
- **Categorical Data**: When using `MultinomialHMM`, ensure your observations are integers in the range `[0, n_features)`.

## Reference documentation
- [hmmlearn Main Repository](./references/github_com_hmmlearn_hmmlearn.md)
- [hmmlearn Issues and Feature Discussions](./references/github_com_hmmlearn_hmmlearn_issues.md)