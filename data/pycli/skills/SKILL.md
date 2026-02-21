---
name: pycli
description: PyClick (pycli) is a specialized Python framework designed for modeling user click behavior in web search results.
homepage: https://github.com/markovi/PyClick
---

# pycli

## Overview
PyClick (pycli) is a specialized Python framework designed for modeling user click behavior in web search results. It allows for the estimation of document relevance and position bias by fitting probabilistic models to historical search logs. You should use this skill when you need to execute baseline click models, predict click-through rates (CTR), or develop custom models using Maximum Likelihood Estimation (MLE) or Expectation-Maximization (EM) algorithms.

## Command Line Usage
The primary way to interact with the tool's functionality is through the provided example scripts which serve as the CLI interface for model training and evaluation.

### Running Click Models
To run a click model against a dataset, use the following pattern:
`python examples/SimpleExample.py <CLICK_MODEL> <DATA_PATH> <SESSION_NUM>`

*   **CLICK_MODEL**: Choose from implemented models:
    *   `GCTR`: Global CTR (Random)
    *   `RCTR`: Rank-based CTR
    *   `DCTR`: Document-based CTR
    *   `PBM`: Position-Based Model
    *   `CM`: Cascade Model
    *   `UBM`: User Browsing Model
    *   `DCM`: Dependent Click Model
    *   `CCM`: Click-Chain Model
    *   `DBN`: Dynamic Bayesian Network
    *   `SDBN`: Simplified DBN
*   **DATA_PATH**: Path to the search session data (e.g., `examples/data/YandexRelPredChallenge`).
*   **SESSION_NUM**: The number of search sessions to process from the data.

### Performance Optimization
*   **Use PyPy**: It is highly recommended to run scripts using the PyPy interpreter instead of standard CPython. This typically results in a 10-100x speed increase for the iterative inference algorithms.

## Implementation Best Practices
When extending the tool or selecting models, follow these architectural patterns:

### Inference Selection
*   **MLEInference**: Use when all random variables in your model are observed.
*   **EMInference**: Use when the model contains latent (unobserved) variables, such as "examination" or "satisfaction" in complex models like DBN.

### Parameter Containers
Choose the appropriate container based on what the parameter depends on:
*   **QueryDocumentParamContainer**: For relevance/attractiveness parameters (depends on the query and the document).
*   **RankParamContainer**: For examination parameters (depends on the document rank).
*   **RankPrevClickParamContainer**: For parameters depending on rank and the position of the last click (specifically for UBM).
*   **SingleParamContainer**: For global constants (e.g., continuation probability).

### Custom Model Workflow
1.  Inherit from `pyclick.click_models.ClickModel`.
2.  Define parameter names using an `Enum`.
3.  Implement the `update` method based on the chosen inference method (MLE or EM).
4.  Implement `get_conditional_click_probs` to calculate $P(C_k | C_1, \dots, C_{k-1})$.
5.  Implement `predict_click_probs` for full click probability $P(C=1)$.

## Reference documentation
- [PyClick README](./references/github_com_markovi_PyClick_blob_master_README.md)
- [PyClick Examples](./references/github_com_markovi_PyClick_tree_master_examples.md)