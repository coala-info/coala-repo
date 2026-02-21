---
name: sompy
description: `sompy` is a lightweight, NumPy-based library for implementing Self-Organizing Maps (SOM).
homepage: https://github.com/ttlg/sompy
---

# sompy

## Overview

`sompy` is a lightweight, NumPy-based library for implementing Self-Organizing Maps (SOM). It provides a straightforward API to project high-dimensional input data onto a lower-dimensional (typically 2D) grid while preserving the topological properties of the input space. Use this skill to guide the initialization, parameter tuning, and training of SOM models for data analysis and visualization.

## Installation

Install the library via pip or conda:

```bash
# Using pip
pip install sompy

# Using conda (via bioconda)
conda install bioconda::sompy
```

*Note: The original documentation specifies Python 2 as a requirement. When using in modern environments, be prepared to handle potential syntax adjustments.*

## Core Usage Pattern

The standard workflow involves preparing a NumPy array, initializing the SOM object with a target grid shape, and executing the training process.

```python
from sompy import SOM
import numpy as np
import matplotlib.pyplot as plt

# 1. Prepare input data (rows = samples, cols = features)
input_data = np.random.rand(10000, 3)

# 2. Define the output grid dimensions (height, width)
output_shape = (40, 40)

# 3. Initialize the SOM
som = SOM(output_shape, input_data)

# 4. Configure hyperparameters
# neighbor: neighborhood function spread
# learning_rate: initial step size for weight updates
som.set_parameter(neighbor=0.1, learning_rate=0.2)

# 5. Train the model (specify number of iterations)
output_map = som.train(10000)

# 6. Visualize the resulting map
plt.imshow(output_map, interpolation='none')
plt.show()
```

## Expert Tips and Best Practices

### Hyperparameter Tuning
- **Neighborhood (neighbor):** Controls how many adjacent nodes are updated along with the Best Matching Unit (BMU). Start with a larger value to organize the global structure and decrease it for fine-tuning.
- **Learning Rate:** A higher initial learning rate (e.g., 0.2 to 0.5) helps in the early stages of training.

### Data Preparation
- Ensure input data is normalized or standardized. Since SOM relies on Euclidean distance to find the BMU, features with larger scales will disproportionately influence the topology.

### Known Issues and Troubleshooting
- **Reshape Logic:** Be aware of a reported issue in the `train` function regarding the output layer reshape. If the output map dimensions appear swapped or incorrect, verify the internal reshape logic:
  - Standard: `self.output_layer.reshape((self.shape[1], self.shape[0], self.input_dim))`
  - Potential Fix: `self.output_layer.reshape((self.shape[0], self.shape[1], self.input_dim))`

## Reference documentation
- [GitHub Repository Overview](./references/github_com_ttlg_sompy.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_sompy_overview.md)
- [Known Issues - Reshape Bug](./references/github_com_ttlg_sompy_issues.md)