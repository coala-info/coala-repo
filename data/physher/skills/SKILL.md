---
name: physher
description: physher is a multi-algorithmic framework designed for high-performance phylogenetic analysis and the estimation of divergence times and evolutionary rates. Use when user asks to estimate divergence times, perform variational inference for phylogenetics, or run maximum likelihood and MCMC evolutionary models.
homepage: https://github.com/4ment/physher
---


# physher

## Overview
physher is a multi-algorithmic framework designed for high-performance phylogenetic analysis. Unlike many traditional tools, it provides a flexible C-based engine that supports a variety of inference methods, including advanced Variational Inference (VI) and analytical gradients. It is primarily used to estimate divergence times and evolutionary rates. Version 2.0+ utilizes a JSON-based configuration system for defining models and parameters, making it highly scriptable for bioinformatics pipelines.

## Installation and Setup
The most efficient way to deploy physher is via the Bioconda channel:

```bash
conda install bioconda::physher
```

To build from source (requires GSL library and a C compiler):
```bash
git clone https://github.com/4ment/physher
cmake -S physher/ -B physher/build
cmake --build physher/build/ --target install
```

Verify the installation by running the command without arguments:
```bash
physher
```

## Command Line Usage
The primary interface for physher is the execution of a JSON configuration file that defines the data, model, and inference algorithm.

### Basic Execution
```bash
physher <config_file>.json
```

### Common Patterns
- **Variational Inference (ELBO):** Often used for rapid approximation of the posterior distribution.
  ```bash
  physher JC69-time-ELBO.json
  ```
- **Maximum Likelihood:** Used for point estimation of branch lengths and model parameters.
- **MCMC:** Used for full posterior sampling.

## Expert Tips and Best Practices
- **Configuration Format:** Ensure you are using the JSON format required by physher v2.0+. Version 2 is incompatible with the older configuration formats used in version 1.
- **Dependencies:** If building from source on Linux (Debian/Ubuntu), ensure `libgsl-dev` and `gcc` are present. On macOS, use `brew install gsl`.
- **Performance:** For users requiring integration with Python-based phylogenetic workflows, physher provides C++ wrappers that are utilized by tools like `torchtree` via `torchtree-physher`.
- **Example Workflows:** When starting a new project, refer to the `examples/` directory in the source repository (e.g., `examples/fluA`) to understand the structure of the required JSON input files.

## Reference documentation
- [physher Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_physher_overview.md)
- [physher GitHub Repository](./references/github_com_4ment_physher.md)