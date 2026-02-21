---
name: bioconductor-gpumagic
description: The package aims to help users write openCL code with little or no effort. It is able to compile an user-defined R function and run it on a device such as a CPU or a GPU. The user can also write and run their openCL code directly by calling .kernel function.
homepage: https://bioconductor.org/packages/release/bioc/html/gpuMagic.html
---

# bioconductor-gpumagic

name: bioconductor-gpumagic
description: Use the gpuMagic package to compile R functions into OpenCL code for execution on GPUs or CPUs. Trigger this skill when the user needs to accelerate R computations (like matrix operations or sapply-style loops) using hardware acceleration, or when they want to write custom OpenCL kernels directly within R.

# bioconductor-gpumagic

## Overview
The `gpuMagic` package enables high-performance computing in R by compiling user-defined R functions into OpenCL kernels. It allows for significant speedups in parallelizable tasks by offloading computation to GPUs or multi-core CPUs. The package provides a high-level interface (`gpuSapply`) that mimics standard R behavior and a low-level interface (`.kernel`) for direct OpenCL programming.

## Device Management
Before running computations, identify and initialize the target hardware.
- `getDeviceList()`: List available OpenCL devices.
- `getDeviceInfo(id)`: Get detailed specs for a specific device.
- `setDevice(id)`: Set the active device for subsequent operations.
- `gpuMagic.getMemUsage()`: Monitor GPU memory consumption.

## High-Level Workflow: gpuSapply
The easiest way to use `gpuMagic` is via `gpuSapply`, which parallelizes an R function across a set of indices.

### Basic Usage
```r
# Define a function compatible with sapply
myFunc <- function(ind, A, B) {
  res = A %*% B[, ind]
  return(res)
}

# Execute on GPU
result <- gpuSapply(1:ncol(B), myFunc, A, B)
```

### Handling Dynamic Sizes
OpenCL requires fixed memory allocation. If your function uses variables whose sizes depend on input values:
1. **Macros**: Use `.macroParms` to pass variables that should be treated as constants during compilation.
   ```r
   gpuSapply(1:k, myFunc, A, n, .macroParms = "n")
   ```
2. **Reference Functions**: Use `subRef(matrix, rows, cols)` to create a "view" of a matrix without copying, allowing for dynamic-like subsetting.

## Low-Level Workflow: Custom OpenCL Kernels
For advanced users, `.kernel()` allows execution of raw OpenCL C code.

### Workflow
1. **Prepare Data**: Convert R objects to `gpuMatrix` objects to move them to the device.
   ```r
   A_dev <- gpuMatrix(A, type = "float")
   res_dev <- gpuEmptMatrix(row = n, col = 1, type = "float")
   ```
2. **Write Kernel**: Use `gAuto` macros in the kernel signature to automatically match R data types.
   ```r
   src <- "kernel void vecAdd(gAuto1* A, gAuto2* B, gAuto3* res){
     uint id = get_global_id(0);
     res[id] = A[id] + B[id];
   }"
3. **Execute**: Call `.kernel()`. This is non-blocking.
   ```r
   .kernel(src = src, kernel = "vecAdd", parms = list(A_dev, B_dev, res_dev), .globalThreadNum = n)
   ```
4. **Retrieve**: Use `download(res_dev)` to bring data back to R.

## Important Constraints
- **Data Types**: Supports `bool`, `int`, `float`, `double`, etc. `NA` and `NULL` are not supported.
- **Memory**: Avoid allocating variables inside loops or if-statements.
- **Assignments**: Self-assignments like `A[1:2] = A[2:1]` fail because OpenCL executes assignments in sequence without implicit temporary buffers.
- **Functions**: Only a subset of R functions are supported (e.g., `matrix`, `abs`, `sum`, `%*%`, `sweep`). User-defined R functions cannot be called inside the function being compiled.

## Performance Tips
- **No-Copy Operations**: Use `t_nocpy()` for transposes and `return_nocpy()` to avoid unnecessary memory allocation.
- **Precision**: Using `type = "float"` instead of `"double"` can significantly increase speed on consumer GPUs.
- **TDR Settings**: On Windows/NVIDIA, increase the "Timeout Detection and Recovery" limit if kernels take longer than 2 seconds.

## Reference documentation
- [Customized opencl code](./references/Customized-openCL-code.Rmd)
- [gpuMagic quick start guide](./references/Quick_start_guide.Rmd)