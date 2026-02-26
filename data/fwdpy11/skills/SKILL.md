---
name: fwdpy11
description: "fwdpy11 is a Python package for forward-time population genetic simulation. Use when user asks to perform population genetic simulations, analyze population dynamics, or model evolutionary processes."
homepage: https://github.com/molpopgen/fwdpy11
---


# fwdpy11

A Python package for forward-time population genetic simulation using fwdpp as its C++ backend.
  Use this skill when Claude needs to perform population genetic simulations, analyze population dynamics,
  or model evolutionary processes using forward-time simulation. This includes tasks such as:
  - Setting up and running forward-time population genetic simulations.
  - Analyzing population structure and genetic variation over time.
  - Simulating evolutionary scenarios with multiple populations.
  - Customizing simulation parameters for specific research questions.
body: |
  ## Overview
  fwdpy11 is a powerful Python library designed for forward-time population genetic simulations. It leverages the efficient C++ library fwdpp to handle complex simulations, allowing researchers to model population dynamics, genetic drift, selection, and other evolutionary forces. This skill enables Claude to set up, run, and analyze these simulations, providing insights into population genetics and evolutionary processes.

  ## Usage Instructions

  fwdpy11 is primarily used through its Python API. While there isn't a direct command-line interface for running simulations, you will typically interact with fwdpy11 within a Python script or interactive session.

  ### Core Concepts and Workflow

  1.  **Installation**:
      Install fwdpy11 via conda:
      ```bash
      conda install bioconda::fwdpy11
      ```

  2.  **Importing and Initialization**:
      Begin by importing the necessary components and initializing simulation parameters.

      ```python
      import fwdpy11
      import numpy as np

      # Define simulation parameters
      N = 1000  # Population size
      T = 100   # Number of generations
      mu = 1e-5 # Mutation rate
      rho = 1e-8 # Recombination rate

      # Initialize population object
      pop = fwdpy11.Population.init(N, mu, rho)
      ```

  3.  **Running Simulations**:
      fwdpy11 allows for flexible simulation of various evolutionary scenarios. You can evolve the population over a specified number of generations.

      ```python
      # Evolve the population for T generations
      pop.evolve(T)
      ```

  4.  **Customization and Advanced Features**:
      fwdpy11 supports custom temporal samplers for analyzing populations during a simulation and flexible interfaces for multi-population models.

      *   **Custom Temporal Samplers**: You can write custom Python functions to analyze population state at specific time points or intervals. These functions are passed to the `evolve` method.

          ```python
          def my_sampler(pop, t):
              # Analyze population state at generation t
              print(f"Analyzing population at generation {t}: {pop.num_mutations()} mutations")

          pop.evolve(T, sampler=my_sampler)
          ```

      *   **Multiple Populations**: fwdpy11 provides an interface for simulating models with multiple, interacting populations. This typically involves setting up a `Population` object that manages these sub-populations.

          ```python
          # Example for multi-population setup (conceptual)
          # Refer to fwdpy11 documentation for specific implementation details
          # multi_pop = fwdpy11.MultiPopulation(...)
          # multi_pop.evolve(...)
          ```

  5.  **Analysis and Output**:
      After simulation, you can access various properties of the population object to analyze results, such as the number of mutations, allele frequencies, or demographic history.

      ```python
      print(f"Total mutations after simulation: {pop.num_mutations()}")
      # Further analysis can be done using methods like pop.get_allele_counts(), etc.
      ```

  ### Expert Tips

  *   **Leverage `fwdpp`'s C++ backend**: For performance-critical simulations, understand that fwdpy11's speed comes from its C++ core. Complex custom logic might benefit from being implemented in C++ and integrated if performance is a bottleneck.
  *   **Parallel Computation**: fwdpy11 supports parallel computation using Python's `multiprocessing` or `concurrent.futures` modules. This is crucial for running many simulations or simulations with large populations.
  *   **Documentation**: The official documentation is the primary resource for detailed usage, advanced features, and specific parameter explanations. Refer to `https://molpopgen.github.io/fwdpy11/` for comprehensive guides.
  *   **Citation**: When using fwdpy11 for research, please cite the relevant publications as listed in the project's README.

  ## Reference documentation
  - [fwdpy11 GitHub Repository](./references/github_com_molpopgen_fwdpy11.md)
  - [fwdpy11 Documentation](./references/github_com_molpopgen_fwdpy11_tree_main_doc.md)