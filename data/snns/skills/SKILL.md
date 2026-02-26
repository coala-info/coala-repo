---
name: snns
description: This tool provides implementation patterns and parameters for building Self-Normalizing Networks using SELU activation, Lecun initialization, and Alpha Dropout. Use when user asks to implement self-normalizing properties, prevent vanishing or exploding gradients without batch normalization, or configure SNNs in PyTorch and TensorFlow.
homepage: https://github.com/bioinf-jku/SNNs
---


# snns

## Overview
Self-Normalizing Networks (SNNs) leverage the Scaled Exponential Linear Unit (SELU) activation function to induce self-normalizing properties, effectively preventing vanishing and exploding gradients without the need for Batch Normalization. To achieve this, a specific combination of activation, initialization, and dropout must be used. This skill provides the exact parameters and implementation patterns required to transform standard architectures into SNNs.

## Implementation Patterns

### PyTorch Implementation
In PyTorch, SNNs require the `SELU` activation and `AlphaDropout`. Crucially, the weights must be initialized using a specific configuration of Kaiming Normal to match Lecun initialization.

```python
import torch
import torch.nn as nn

# 1. Use SELU activation
model = nn.Sequential(
    nn.Linear(input_dim, hidden_dim),
    nn.SELU(),
    # 2. Use AlphaDropout instead of standard Dropout
    nn.AlphaDropout(p=0.1),
    nn.Linear(hidden_dim, output_dim)
)

# 3. Critical: Initialize weights with Lecun Normal
# In PyTorch, this is kaiming_normal with fan_in and linear nonlinearity
def init_weights(m):
    if isinstance(m, nn.Linear):
        nn.init.kaiming_normal_(m.weight, mode='fan_in', nonlinearity='linear')

model.apply(init_weights)
```

### TensorFlow 2.x / Keras Implementation
Modern TensorFlow (2.3+) has native support for SNN components within the Keras API.

```python
import tensorflow as tf

model = tf.keras.models.Sequential([
    tf.keras.layers.Dense(
        64, 
        # 1. Use SELU activation
        activation='selu',
        # 2. Use LecunNormal initializer
        kernel_initializer='lecun_normal'
    ),
    # 3. Use AlphaDropout
    tf.keras.layers.AlphaDropout(0.1),
    tf.keras.layers.Dense(10, activation='softmax')
])
```

### TensorFlow 1.x (Legacy)
For older environments, use the `tf.nn` and `tf.contrib` modules.
- **Activation**: `tf.nn.selu`
- **Dropout**: `tf.contrib.nn.alpha_dropout`

## Best Practices for SNNs

### 1. Input Normalization
SNNs assume that the input features are normalized to have a mean of 0 and a standard deviation of 1. Failure to normalize inputs can break the self-normalizing property in the initial layers.

### 2. Architecture Constraints
- **Activation**: Only use `SELU`. Mixing SELU with ReLU or Sigmoid in hidden layers will stop the self-normalization.
- **Dropout**: Only use `Alpha Dropout`. Standard dropout randomly zeros out activations, shifting the mean and variance; Alpha Dropout scales and shifts the remaining activations to preserve the mean and variance.
- **Initialization**: Always use `Lecun Normal`. This ensures the variance of the output of a layer is the same as the variance of its input.

### 3. SELU Constants
If implementing the activation function manually, use the following fixed-point values:
- **Alpha ($\alpha$):** `1.6732632423543772848170429916717`
- **Lambda ($\lambda$):** `1.0507009873554804934193349852946`

## Reference documentation
- [Self-Normalizing Networks Main Repository](./references/github_com_bioinf-jku_SNNs.md)
- [SNN Calculations and Parameters](./references/github_com_bioinf-jku_SNNs_tree_master_Calculations.md)