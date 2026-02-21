---
name: crnsimulator
description: The `crnsimulator` tool bridges the gap between formal chemical reaction equations and numerical simulation.
homepage: https://github.com/bad-ants-fleet/crnsimulator
---

# crnsimulator

## Overview
The `crnsimulator` tool bridges the gap between formal chemical reaction equations and numerical simulation. It takes a list of irreversible or reversible reactions with associated rate constants and produces a standalone Python script that uses `scipy.integrate` to solve the resulting ODE system. This is particularly useful for synthetic biology, systems biology, and DNA computing research where complex molecular interactions need to be validated through simulation.

## Installation
Install via bioconda:
```bash
conda install bioconda::crnsimulator
```

## Core Workflow

### 1. Define the CRN
Create a `.crn` file (e.g., `system.crn`) using the following syntax:
```text
# Reaction format: Reactants -> Products [k = rate]
A + B -> B + B [k = 0.2]
B + C -> C + C [k = 0.4]
C + A -> A + A [k = 0.7]

# Optional: Set default initial concentrations
A @i 0.1
B @i 0.01
```

### 2. Generate the ODE Script
Convert the CRN into an executable Python integrator:
```bash
crnsimulator -o simulation.py < system.crn
```

### 3. Execute the Simulation
Run the generated script to produce numerical data or plots:
```bash
python simulation.py --p0 A=0.1 B=0.01 C=0.001 --t8 1000 --pyplot output.pdf
```

## CLI Patterns and Tips

### One-Liner Simulations
You can pipe a CRN string directly into the simulator and pass simulation arguments immediately. The tool will generate the script and execute it in one step:
```bash
echo "A+B->2B [k=0.2]; B+C->2C [k=0.4]; C+A->2A" | crnsimulator --p0 A=0.1,B=0.01,C=0.001 --t8 1000 --pyplot plot.png
```

### Managing Species and Plots
*   **Initial Concentrations**: Use `--p0` to override defaults. Format is `Species=Value`.
*   **Legend Control**: Use `--pyplot-labels` to specify which species appear in the plot legend and in what order.
*   **Overwriting**: Use `--force` if you are iterating on a CRN and need to overwrite the previously generated `.py` script.
*   **Integration Precision**: If the simulation fails to converge or produces "stiff" results, use `--atol` (absolute tolerance) and `--rtol` (relative tolerance) arguments (e.g., `--atol 1e-10 --rtol 1e-10`).

### Constant Concentrations
To keep a species at a constant concentration (e.g., a buffered fuel species), use the `const` flag in the CRN definition if supported by the version, or ensure it is produced and consumed at equal rates.

## Python Library Usage
For integration into larger workflows, use the `ReactionGraph` object:
```python
from crnsimulator import ReactionGraph

crn = [[['A', 'B'], ['B', 'B'], 0.2], 
       [['B', 'C'], ['C', 'C'], 0.4]]
RG = ReactionGraph(crn)
filename, odename = RG.write_ODE_lib(filename='mysim.py')
```

## Reference documentation
- [crnsimulator GitHub Repository](./references/github_com_bad-ants-fleet_crnsimulator.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_crnsimulator_overview.md)