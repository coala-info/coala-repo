---
name: pomegranate
description: pomegranate is a library for probabilistic modeling that emphasizes modularity and speed.
homepage: https://github.com/jmschrei/pomegranate
---

# pomegranate

## Overview
pomegranate is a library for probabilistic modeling that emphasizes modularity and speed. Following its v1.0.0 rewrite, the library uses PyTorch as its computational backend, replacing the older Cython implementation. This allows every model to function as a `torch.nn.Module`, providing native support for GPU acceleration, serialization, and mixed precision. The library is unique in its treatment of all models as probability distributions, allowing users to nest complex structures—such as placing Hidden Markov Models into Bayes classifiers—with ease.

## Core Usage and Best Practices

### Installation and Versioning
*   **Modern Version**: Install the PyTorch-backed version using `pip install pomegranate`.
*   **Legacy Support**: If you require the old Cython-based API (v0.14.8 and below), use `pip install pomegranate==0.14.8`. Note that the APIs are not backwards compatible.

### PyTorch Integration
Since models are now PyTorch modules, follow standard PyTorch workflows:
*   **Device Management**: Explicitly move both the model and the data to the GPU for acceleration.
    ```python
    model = Normal().to("cuda")
    X = torch.randn(100, 4).to("cuda")
    model.fit(X)
    ```
*   **Serialization**: Use `torch.save` and `torch.load` for saving and restoring models, as pomegranate no longer uses custom JSON serialization.

### Handling Missing Values
pomegranate supports missing data natively through `torch.masked.MaskedTensor`. Instead of using `NaN` in standard tensors, wrap your data in a MaskedTensor to ensure the underlying algorithms correctly ignore missing observations during training and inference.

### Model Selection Tips
*   **Distributions**: Most distributions are multivariate by default and treat features independently (with the exception of the `Normal` distribution).
*   **Hidden Markov Models**: 
    *   Use `DenseHMM` for models with fully connected or nearly dense transition matrices; it is optimized for speed on the GPU.
    *   Use `SparseHMM` when dealing with large, sparse transition graphs to save memory.
*   **Bayesian Networks**: Use `BayesClassifier` for supervised classification tasks involving multiple distributions.

### Training and Inference
*   **Fit Method**: Use the `.fit()` method for batch training.
*   **Probability Estimation**: Use `.log_probability(X)` to calculate the log-likelihood of observations.
*   **Prior Probabilities**: You can pass prior probabilities to models to facilitate semi-supervised learning or to incorporate domain knowledge.

## Reference documentation
- [pomegranate README](./references/github_com_jmschrei_pomegranate.md)