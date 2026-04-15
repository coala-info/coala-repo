---
name: phyphy
description: The phyphy package provides a Pythonic interface for executing HyPhy evolutionary models and extracting data from the resulting JSON files. Use when user asks to configure HyPhy environments, run phylogenetic analyses like FEL or BUSTED, and convert analysis outputs into CSV or Newick formats.
homepage: https://github.com/sjspielman/phyphy
metadata:
  docker_image: "quay.io/biocontainers/phyphy:0.4.3--py_0"
---

# phyphy

## Overview
The `phyphy` package provides a Pythonic interface for the HyPhy (Hypothesis testing using Phylogenies) software. It eliminates the need for manual interaction with the HyPhy command-line prompt by providing three core modules: `Hyphy` for environment configuration, `Analysis` for executing specific evolutionary models, and `Extractor` for data mining the resulting JSON files. This skill should be used to facilitate batch processing of phylogenetic data and to integrate evolutionary rate estimation into larger bioinformatics pipelines.

## Usage Instructions

### 1. Configuring the HyPhy Environment
Before running analyses, define a `HyPhy` object to specify the executable path and resource usage.

```python
import phyphy

# Use default installation (/usr/local/bin/HYPHYMP)
my_hyphy = phyphy.HyPhy()

# Configure for high-performance computing (MPI)
mpi_hyphy = phyphy.HyPhy(
    executable="HYPHYMPI", 
    mpi_launcher="mpirun", 
    mpi_options="-np 32"
)

# Suppress log files (messages.log and errors.log)
clean_hyphy = phyphy.HyPhy(suppress_log=True)
```

### 2. Executing Evolutionary Analyses
The `Analysis` module contains classes for standard HyPhy methods. Every analysis follows a two-step pattern: initialization and `.run_analysis()`.

**Supported Methods:** `ABSREL`, `BUSTED`, `FEL`, `FUBAR`, `LEISR`, `MEME`, `RELAX`, `SLAC`.

```python
from phyphy import FEL

# Initialize the analysis
# 'data' is the path to your alignment (Nexus or Fasta)
run_fel = FEL(data="/path/to/alignment.nex", hyphy=my_hyphy)

# Execute
run_fel.run_analysis()
```

### 3. Extracting Results
HyPhy produces complex JSON files. Use the `Extractor` module to convert these into flat files or trees.

```python
from phyphy import Extractor

# Initialize extractor with the JSON path
ext = Extractor("/path/to/analysis_output.json")

# Save site-specific results to a CSV
ext.extract_csv("results.csv")

# Extract a Newick tree with branch lengths/attributes
ext.extract_tree("annotated_tree.nwk")
```

## Best Practices and Tips
- **Version Compatibility**: `phyphy` is optimized for HyPhy versions **2.3.7 through 2.3.14**. If using HyPhy 2.5 or later, functionality may be inconsistent due to breaking changes in HyPhy's output schema.
- **Resource Management**: Use the `CPU` argument in the `HyPhy` constructor (e.g., `HyPhy(CPU=4)`) to limit the number of threads used by the `HYPHYMP` executable.
- **Quiet Mode**: Use `quiet=True` in the `HyPhy` object to prevent HyPhy from printing standard output to the console during execution.
- **Data Formats**: While HyPhy often prefers Nexus, `phyphy` handles Fasta inputs effectively. Ensure your tree and alignment are in the same file or provide the tree path explicitly if the analysis class requires it.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_sjspielman_phyphy.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_phyphy_overview.md)