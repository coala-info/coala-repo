---
name: msprime
description: msprime is a high-performance population genetics simulator that generates ancestral histories and genomic sequence data using the succinct tree sequence data structure. Use when user asks to simulate random genealogies, model complex population demographies, generate genomic mutations, or perform coalescent simulations as an alternative to the Hudson ms program.
homepage: https://github.com/tskit-dev/msprime
metadata:
  docker_image: "quay.io/biocontainers/msprime:0.4.0--py35_gsl1.16_0"
---

# msprime

## Overview
msprime is a high-performance population genetics simulator based on the tskit library. It is designed to simulate random ancestral histories (consistent with various demographic models) and genomic sequence data. By utilizing the succinct tree sequence data structure, msprime can simulate whole chromosomes for millions of individuals with extreme efficiency. It serves as a modern, faster alternative to the classic Hudson `ms` simulator while providing a powerful Python API for complex evolutionary scenarios.

## Command Line Usage (mspms)
The `mspms` command provides a CLI interface that is largely compatible with the original `ms` program.

### Basic Simulation
Simulate a sample of 10 individuals with a population mutation rate (theta) of 5:
```bash
mspms 10 1 -t 5
```

### Recombination and Growth
Simulate 20 samples, 1 replicate, with theta=10 and recombination (rho=5 over a 1000bp region):
```bash
mspms 20 1 -t 10 -r 5 1000
```

### Demographic Events
- **Population Growth**: `-eG <time> <growth_rate>`
- **Population Size Change**: `-en <time> <pop_id> <size_fraction>`
- **Population Split/Join**: `-ej <time> <pop_id_1> <pop_id_2>`

Example: A population split 0.5 units of time ago:
```bash
mspms 10 1 -t 5 -I 2 5 5 -ej 0.5 2 1
```

## Python API Best Practices
While the CLI is useful for simple tasks, the Python API is the preferred method for complex simulations.

### Core Workflow
1. **Simulate Ancestry**: Use `msprime.sim_ancestry()` to generate the tree sequence.
2. **Simulate Mutations**: Use `msprime.sim_mutations()` to add variation to the ancestry.
3. **Analyze**: Use the `tskit` API to process the resulting tree sequence object.

### Defining Demography
Use the `msprime.Demography` class to manage complex population histories rather than raw lists of events.
```python
import msprime

demography = msprime.Demography()
demography.add_population(name="A", initial_size=10000)
demography.add_population(name="B", initial_size=5000)
demography.add_population_split(time=1000, derived=["A", "B"], ancestral="C")
demography.add_population(name="C", initial_size=15000)

ts = msprime.sim_ancestry(samples={"A": 10, "B": 10}, demography=demography, sequence_length=1e6, recombination_rate=1e-8)
```

### Simulation Models
- **Hudson Model**: The default coalescent model (efficient for most cases).
- **Wright-Fisher (WF)**: Use `model="wright_fisher"` for discrete generation simulations (useful for very recent history or high sample sizes relative to population size).
- **SMC/SMC'**: Approximations of the coalescent with recombination for faster performance on very long sequences.

## Expert Tips
- **Tree Sequence Output**: Always save results in the `.trees` format using `ts.dump("filename.trees")`. This format is extremely compressed and contains the full ARG.
- **Recapitation**: If you are using forward-time simulators like SLiM, use `msprime.recapitate()` to efficiently simulate the deep ancestral history that forward simulators often omit for performance.
- **Recombination Maps**: For human or model organism simulations, use `msprime.RecombinationMap` to load variable recombination rates from HapMap or similar formats.
- **Mutation Models**: Beyond the infinite sites model, msprime supports complex models like HKY or GTR via the `msprime.MatrixMutationModel`.

## Reference documentation
- [msprime GitHub Repository](./references/github_com_tskit-dev_msprime.md)
- [msprime Discussions](./references/github_com_tskit-dev_msprime_discussions.md)
- [msprime Issues and Bug Reports](./references/github_com_tskit-dev_msprime_issues.md)