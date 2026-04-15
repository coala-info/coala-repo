---
name: amos
description: AMOS maps tensor computations to hardware-specific intrinsics by automatically configuring and transforming compute loops. Use when user asks to translate tensor expressions into hardware instructions, perform ISA-aware mapping, or automate the tensorization of computations for spatial accelerators.
homepage: https://github.com/pku-liang/AMOS
metadata:
  docker_image: "quay.io/biocontainers/amos:3.1.0--py27pl5.22.0_3"
---

# amos

## Overview

AMOS (Automatic Mapping for Spatial accelerators) is a specialized mapper designed to translate tensor computations into efficient hardware-specific intrinsics. Unlike general hardware-aware mapping, AMOS focuses on ISA-aware mapping, which handles the complex task of configuring and transforming compute loops to meet the rigid constraints of hardware instructions (e.g., CUDA WMMA or PTX MMA). It functions as an extension of the TVM framework, specifically through the `auto_tensorize` module, to provide automated exploration and verification of mapping possibilities that might be overlooked by manual optimization.

## Environment Setup

Before using AMOS, ensure the environment is correctly configured to link with its dependencies and the TVM backend.

1.  **Set Environment Variables**:
    ```bash
    export AMOS_HOME=~/AMOS
    export PYTHONPATH=$PYTHONPATH:$AMOS_HOME/python
    ```
2.  **Build Configuration**:
    Modify `build/config.cmake` to point to your local LLVM and CUDA installations.
    *   `set(USE_LLVM /path/to/llvm-config)`
    *   `set(USE_CUDA ON)`
3.  **Python Dependencies**:
    AMOS requires specific versions of libraries to maintain compatibility with its search algorithms:
    *   `xgboost==1.5.0`
    *   `numpy`, `decorator`, `attrs`, `tornado`, `psutil`, `cloudpickle`, `synr`, `pebble`, `sklearn`

## Core Workflow: Mapping Tensor Computations

The primary interface for AMOS is the `auto_tensorize` (aliased as `at`) module within TVM.

### 1. Define the Compute
Use TVM's Tensor Expression (TE) to define the operation (e.g., Conv2d, MatMul).
```python
import tvm
from tvm import auto_tensorize as at

# Define placeholders and compute logic using tvm.te
# Example: Conv2d with padding and reduction axes
```

### 2. Initialize the Mapper
The mapping process involves identifying the relationship between the software loops and the target hardware intrinsics.
*   **Hardware Abstraction**: Define the target hardware's capabilities.
*   **Mapping Exploration**: Use AMOS to search for valid mapping candidates that satisfy the hardware's spatial and temporal constraints.

### 3. Verification and Performance Modeling
*   **Verification**: AMOS automatically verifies that the generated mapping is functionally equivalent to the original tensor expression.
*   **Performance Model**: Use the `perf_model` option during benchmarking to evaluate the efficiency of different mapping strategies.

## Best Practices and Expert Tips

*   **Intrinsic Constraints**: ISA-aware mapping is highly sensitive to loop tiling and data layout. If a mapping fails, check if the input shapes are multiples of the hardware intrinsic's required dimensions (e.g., 16x16x16 for certain Tensor Core operations).
*   **LLVM Versioning**: Ensure you use LLVM 10.0.0 as recommended in the documentation, as newer versions may introduce breaking changes in the IR generation used by AMOS.
*   **Virtual Environments**: Always run AMOS within a dedicated virtual environment to avoid conflicts with other TVM installations, as AMOS uses a modified version of the TVM source tree.
*   **Search Space**: For complex computations, the mapping search space can be vast. Use the built-in exploration tools to prune invalid mappings early based on hardware constraints.

## Reference documentation
- [AMOS: Enabling Automatic Mapping for Tensor Computations On Spatial Accelerators with Hardware Abstraction](./references/github_com_pku_liang_AMOS.md)