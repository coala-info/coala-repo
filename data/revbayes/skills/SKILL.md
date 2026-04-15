---
name: revbayes
description: RevBayes is a modular software package for Bayesian phylogenetic inference and general statistical modeling using the Rev probabilistic programming language. Use when user asks to perform phylogenetic analysis, execute Rev scripts, define graphical models, or run MCMC simulations for molecular and morphological data.
homepage: https://revbayes.github.io/
metadata:
  docker_image: "quay.io/biocontainers/revbayes:1.3.2--hf316886_0"
---

# revbayes

## Overview
RevBayes is a modular software package for Bayesian phylogenetic inference and general statistical modeling. It utilizes a specialized probabilistic programming language called "Rev," which is syntactically similar to R but designed for defining Directed Acyclic Graphs (DAGs). This skill enables the creation and execution of phylogenetic models, including molecular substitution models, clock models, and birth-death processes, primarily through the `rb` command-line interface.

## Command Line Usage

### Basic Execution
- **Interactive Mode**: Start the RevBayes interpreter by simply typing `rb` in the terminal.
- **Script Execution**: Run a pre-written Rev script using:
  ```bash
  rb <script_name>.rev
  ```
- **Redirecting Output**: To save console output to a file while running:
  ```bash
  rb <script_name>.rev > output.log 2>&1
  ```

### In-Tool Help
Within the `rb` shell, access documentation for any distribution, function, or move:
- `?dnPoisson` (Displays help for the Poisson distribution)
- `help("mcmc")` (Displays help for the MCMC object)

## Rev Language Best Practices

### Model Specification
RevBayes distinguishes between three types of nodes in a graphical model:
1. **Constant Nodes**: Fixed values.
   `mu <- 0.1`
2. **Deterministic Nodes**: Values calculated from other nodes.
   `lambda := mu * 2`
3. **Stochastic Nodes**: Variables drawn from a distribution.
   `psi ~ dnBirthDeath(lambda=lambda, mu=mu, rootAge=10.0)`

### Data Input
Always verify data dimensions after loading:
- **Molecular/Morphological Data**: `data <- readDiscreteCharacterData("file.nex")`
- **Trees**: `tree <- readTrees("file.tre")[1]`
- **Matrices**: `dist_mat <- readDistanceMatrix("file.csv")`

### MCMC Workflow
A standard Rev script should follow this sequence:
1. **Load Data**: Import alignments and initial trees.
2. **Define Parameters**: Set up priors for substitution rates, branch lengths, and topology.
3. **Define Moves**: Assign proposal algorithms (e.g., `mvScale`, `mvNNI`) to stochastic nodes.
4. **Wrap Model**: Create a model object from any node in the graph: `mymodel = model(psi)`.
5. **Set Up Monitors**: Define output files (`mnFile`) and screen reporting (`mnScreen`).
6. **Run MCMC**: Initialize and run the chain:
   ```rev
   mymcmc = mcmc(mymodel, monitors, moves)
   mymcmc.run(generations=10000)
   ```

## Expert Tips
- **Modular Scripts**: Use `source("sub_script.rev")` to organize complex analyses into smaller, reusable files (e.g., one for the substitution model, one for the clock model).
- **Vectorization**: Many Rev functions are vectorized. Use `rep()` and `vector` types to handle partitioned data efficiently.
- **Convergence**: Always use `mnScreen` to monitor the Likelihood and Posterior in real-time to ensure the chain is not stuck.
- **Path Sampling**: For model selection, use the `pathSampler` or `steppingStoneSampler` objects rather than comparing raw posterior values.

## Reference documentation
- [Rev Language Reference](./references/revbayes_github_io_documentation.md)
- [Tutorial Modules and Workflows](./references/revbayes_github_io_tutorials.md)
- [Interfaces and CLI Setup](./references/revbayes_github_io_interfaces.md)