---
name: minepy
description: The minepy tool identifies and characterizes complex functional and non-functional relationships in high-dimensional data using MINE statistics. Use when user asks to calculate MIC scores, identify non-linear associations, perform high-throughput screening of pairwise relationships, or rank variables by relationship strength.
homepage: http://minepy.readthedocs.io
---


# minepy

## Overview
The `minepy` skill provides a robust framework for discovering and characterizing relationships in high-dimensional data. Unlike standard correlation coefficients (like Pearson's), MINE statistics can capture a wide range of functional and non-functional relationships (e.g., sinusoidal, exponential, or periodic) with high equitable power. This skill focuses on using the Python API and understanding the core estimators like MICe and TICe for efficient high-throughput screening and ranking of associations.

## Core Concepts and Best Practices

### Selecting the Right Estimator
*   **MIC (Maximal Information Coefficient):** Use for assessing the strength of a relationship. It is normalized between 0 and 1.
*   **MICe (MIC-approx):** Use for a more efficient estimation of MIC, especially in large datasets.
*   **TICe (Total Information Coefficient):** Use for high-throughput screening. It is computationally faster than MIC and is recommended for testing the significance of many pairwise relationships simultaneously.
*   **GMIC (Generalized Mean Information Coefficient):** Use when you need a measure that is more sensitive to specific types of functional relationships.

### Python API Usage
The `mine` class is the primary interface for calculating MINE statistics.

```python
from minepy import MINE

# Initialize MINE object
# alpha: search effort (default 0.6)
# c: determines how many clumps the columns are divided into (default 15)
# est: estimator type ("mic_approx" or "mic_e")
m = MINE(alpha=0.6, c=15, est="mic_approx")

# Compute scores for two vectors x and y
m.compute_score(x, y)

print(f"MIC: {m.mic()}")
print(f"TIC: {m.tic()}")
```

### Parameter Tuning
*   **Alpha ($\alpha$):** Controls the window size for the grid search. A value of 0.6 is generally recommended. Lower values increase speed but decrease the ability to find complex patterns; higher values (up to 1.0) increase sensitivity but are computationally expensive.
*   **C:** Controls the granularity of the grid. Increasing `c` beyond 15 rarely improves results but significantly increases computation time.

### Workflow for Large Datasets
When dealing with thousands of variables, follow the **MICtools** strategy:
1.  **Screening:** Use `TICe` to perform a rapid screening of all pairwise relationships to identify those that are statistically significant.
2.  **Ranking:** Use `MICe` only on the subset of significant associations identified in step 1 to rank them by the strength of the relationship.

## Common Patterns

### Batch Processing
For calculating MIC between one variable and a set of others:
```python
import numpy as np
from minepy import MINE

def get_mic_scores(target, features):
    mine = MINE(alpha=0.6, c=15)
    scores = []
    for col in features.T:
        mine.compute_score(target, col)
        scores.append(mine.mic())
    return scores
```

### Handling Non-Linearity
If Pearson's $R$ is low but `minepy` reports a high MIC, the relationship is likely non-linear (e.g., a circle or a wave). Use this discrepancy to flag interesting features that traditional linear models would ignore.

## Reference documentation
- [minepy Documentation](./references/minepy_readthedocs_io_en_latest.md)
- [minepy Overview and Installation](./references/anaconda_org_channels_bioconda_packages_minepy_overview.md)