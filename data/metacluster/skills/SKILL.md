---
name: metacluster
description: "Metacluster is a Python framework for solving clustering problems using metaheuristic optimization algorithms and performance metrics. Use when user asks to perform metaheuristic clustering, optimize cluster configurations, evaluate clustering performance with nature-inspired algorithms, or automate the comparison of multiple optimization models."
homepage: https://github.com/thieu1995/MetaCluster
---


# metacluster

## Overview

The `metacluster` library is a comprehensive Python framework for solving clustering problems through metaheuristic optimization. It integrates over 200 nature-inspired optimizers and 40+ performance metrics to provide a robust environment for finding global optima in cluster configurations. Use this skill to automate the process of loading datasets, scaling features, selecting optimization algorithms, and evaluating clustering results with high-dimensional data.

## Implementation Patterns

### 1. Data Preparation
MetaCluster requires data in NumPy array format. Use the built-in `Data` class to wrap your features and labels.

```python
import pandas as pd
from metacluster import Data, get_dataset

# Option A: Load built-in datasets
data = get_dataset("Arrhythmia")

# Option B: Load custom data
df = pd.read_csv('dataset.csv')
X = df.iloc[:, :-1].values
y = df.iloc[:, -1].values
data = Data(X, y, name="my_experiment")

# Essential: Always scale features
data.X, scaler = data.scale(data.X, method="StandardScaler")
```

### 2. Configuring Metaheuristics
Define a list of optimizers and their corresponding hyperparameters. You can discover supported algorithms using `MetaCluster.get_support(name="all")`.

```python
list_optimizer = ["BaseFBIO", "OriginalGWO", "OriginalSMA"]
list_paras = [
    {"name": "FBIO", "epoch": 10, "pop_size": 30},
    {"name": "GWO", "epoch": 10, "pop_size": 30},
    {"name": "SMA", "epoch": 10, "pop_size": 30}
]
```

### 3. Execution and Evaluation
The `MetaCluster` class manages the execution of multiple trials and the comparison of different algorithms.

```python
from metacluster import MetaCluster

# Define objectives (e.g., SI: Silhouette Index) and metrics
list_obj = ["SI", "RSI"]
list_metric = ["DBI", "CHI", "SSEI", "NMIS"]

model = MetaCluster(
    list_optimizer=list_optimizer, 
    list_paras=list_paras, 
    list_obj=list_obj, 
    n_trials=3, 
    seed=42
)

# cluster_finder can be "elbow", "gap", etc.
model.execute(
    data=data, 
    cluster_finder="elbow", 
    list_metric=list_metric, 
    save_path="results", 
    verbose=True
)

# Generate visualizations
model.save_boxplots()
model.save_convergences()
```

## Expert Tips

- **Discovery**: If unsure which algorithms or metrics are available, run `MetaCluster.get_support(name="all")` to print the full list of supported methods to the console.
- **Dataset Naming**: Always provide a unique `name` to the `Data` object. MetaCluster uses this name to create the directory structure for saved results and plots.
- **Memory Management**: When running hundreds of optimizers or large populations (`pop_size`), monitor memory usage as MetaCluster stores trial history for visualization.
- **Cluster Finder**: The `cluster_finder` parameter in `execute()` is critical for determining the optimal K value automatically. Common values include `"elbow"` and `"gap"`.

## Reference documentation
- [MetaCluster Main Documentation](./references/github_com_thieu1995_MetaCluster.md)