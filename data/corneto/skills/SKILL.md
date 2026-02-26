---
name: corneto
description: Corneto is a Python framework that reconstructs biological signaling pathways and metabolic models by solving network inference problems through mathematical optimization. Use when user asks to infer causal networks from omics data, integrate prior biological knowledge into network models, or solve combinatorial optimization problems like Steiner Tree inference.
homepage: https://github.com/saezlab/corneto/
---


# corneto

## Overview

CORNETO (COmbinatorial Reconstruction of NETworks from Omics) is a specialized Python framework designed to solve network inference problems by framing them as mathematical optimization tasks. It allows researchers to integrate prior biological knowledge with experimental omics data to reconstruct causal signaling pathways or metabolic models. The tool is built to be modular, supporting multiple mathematical backends and solvers to guarantee optimal solutions for complex biological queries.

## Installation and Environment Setup

### Choose the Correct Flavor
Install CORNETO based on your specific solver requirements and research needs:

*   **Research Stack (Recommended):** Includes Gurobi, PICOS, and visualization tools.
    `pip install corneto[research]`
*   **Open-Source Stack:** Uses open-source solvers like SCIP or HiGHS.
    `pip install corneto[os]`
*   **Machine Learning Stack:** Includes JAX, Keras, and scikit-learn dependencies.
    `pip install corneto[ml]`

### Conda Workflow
For the most stable environment, especially when using Graphviz for network visualization:
1. Create the environment: `conda create -n corneto python>=3.10`
2. Activate: `conda activate corneto`
3. Install system dependencies: `conda install python-graphviz`
4. Install the framework: `pip install corneto[research]`

## Solver Configuration

### Gurobi Integration
CORNETO performs best with the Gurobi optimizer. After obtaining an academic or commercial license and installing the Gurobi software:
*   Verify the installation within Python:
    ```python
    from corneto.utils import check_gurobi
    check_gurobi()
    ```

### Backend Selection
CORNETO supports both **CVXPY** and **PICOS** backends. 
*   Use **CVXPY** for standard convex optimization problems.
*   Use **PICOS** when specific MILP (Mixed-Integer Linear Programming) features or specific solvers are required for combinatorial problems like Steiner Tree inference.

## Best Practices for Network Inference

*   **Leverage Multi-Sample Power:** When working with multiple experimental conditions, use CORNETO's multi-sample primitives. This allows the model to "borrow strength" across samples, leading to more robust and comparable subnetworks than solving each sample in isolation.
*   **Prioritize Exact Solvers:** Whenever possible, use MILP-capable solvers (like Gurobi or SCIP) rather than heuristic approaches to ensure the resulting subnetwork is mathematically optimal given the constraints and prizes.
*   **Modular Constraints:** Treat biological assumptions as modular constraints. You can plug in new scoring functions or priors without rewriting the core optimization logic.
*   **Visualization:** Ensure `python-graphviz` is installed in your environment to utilize the built-in plotting capabilities for inferred signaling paths.

## Troubleshooting

*   **Solver Errors:** If a model fails to solve, verify that the problem is not "Infeasible." This often happens if constraints (e.g., mandatory terminals in a Steiner Tree) cannot be connected within the provided prior knowledge network.
*   **Dependency Conflicts:** If using the `ml` flavor, ensure your CUDA drivers are compatible with the JAX/Keras versions installed by CORNETO.

## Reference documentation
- [CORNETO GitHub Repository](./references/github_com_saezlab_corneto.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_corneto_overview.md)