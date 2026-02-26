---
name: ramid
description: ramid mitigates motion-induced blurring and artifacts in dynamic CT scans using piecewise linear interpolation and 4D Total Variation regularization. Use when user asks to perform motion-compensated reconstruction, reduce artifacts in synchrotron or industrial CT data, or augment temporal resolution in dynamic datasets.
homepage: https://github.com/eboigne/PyRAMID-CT
---


# ramid

## Overview
PyRAMID-CT is a specialized Python framework designed to mitigate motion-induced blurring and artifacts in dynamic CT scans. It functions by augmenting temporal resolution through piecewise linear interpolation (PLI) and applying 3D+time (4D) Total Variation (TV) regularization. It is primarily used for synchrotron or industrial CT data where sample motion occurs during acquisition, transforming standard reconstructions into motion-compensated dynamic datasets.

## Core Workflow
The standard workflow involves initializing a reconstruction case, loading sinogram data, and executing an iterative solver.

### Basic Implementation
```python
import pyramid_ct

# Initialize the reconstruction object
case = pyramid_ct.Case()

# Load your sinogram data (numpy array)
# Example uses the built-in moving phantom for testing
sino_data = pyramid_ct.utils.example_moving_phantom()
case.set_sinogram_data(sino_data)

# Configure iterations (default is often lower, 200 is a good starting point)
case.nb_it = 200

# Execute the reconstruction
case.run()
```

## Expert Tips and Best Practices

### Algorithm Selection
PyRAMID-CT offers two primary algorithms. The **Chambolle-Pock proximal algorithm** is the recommended choice over sub-gradient descent for better convergence and stability in motion artifact reduction.

### Hardware Acceleration
* **GPU Usage**: Calculations are significantly faster on GPU using PyTorch CUDA. Ensure `cudatoolkit` and a GPU-enabled version of PyTorch are installed in your environment.
* **Precision**: The tool supports both single and double precision. Use single precision (float32) for a significant speed boost on most GPUs unless high-bit depth scientific accuracy is strictly required.

### Geometry Constraints
PyRAMID-CT currently only supports **parallel beam geometries** via the ASTRA Toolbox. It is not suitable for cone-beam or fan-beam data without pre-processing into parallel projections.

### Temporal Resolution
The Piecewise Linear Interpolation (PLI) feature allows you to augment time resolution by a factor of $M$. This is critical when the motion is fast relative to the rotation speed of the CT stage.

### Output Handling
* **Format**: Reconstructed data is output as `.tif` stacks.
* **Post-processing**: Use Fiji (ImageJ) for viewing the resulting 4D stacks. You can drag and drop the entire output folder into Fiji to open it as a virtual stack.

## Troubleshooting
* **Installation**: If dependency solving is slow, use `mamba` instead of `conda`.
* **Verification**: Run `pyramid_ct.run_tests()` immediately after installation to verify that the ASTRA Toolbox and PyTorch CUDA integrations are functioning correctly.

## Reference documentation
- [PyRAMID-CT Main Documentation](./references/github_com_eboigne_PyRAMID-CT.md)