---
name: pyvolve
description: Pyvolve is a Python-based simulation framework used to generate molecular sequences along a phylogeny using flexible evolutionary models. Use when user asks to simulate nucleotide, amino acid, or codon sequences, define custom substitution matrices, or model site-specific rate heterogeneity.
homepage: https://github.com/sjspielman/pyvolve
metadata:
  docker_image: "quay.io/biocontainers/pyvolve:1.1.0--pyhdfd78af_0"
---

# pyvolve

## Overview
Pyvolve is a Python-based simulation framework designed to generate molecular sequences along a phylogeny. Unlike simple simulators, Pyvolve provides high flexibility in defining evolutionary models, including support for heterotachy, site-specific rates, and complex substitution matrices (e.g., GTR, JTT, WAG, and PAML-style models). It integrates closely with Biopython and NumPy to handle tree structures and numerical computations.

## Installation and Setup
Pyvolve requires Python 3.x and depends on Biopython, NumPy, and SciPy.

```bash
# Installation via pip
pip install pyvolve

# Installation via Conda
conda install -c bioconda pyvolve
```

## Core Simulation Workflow
The standard Pyvolve workflow involves four main components: the Tree, the Model, the Partition, and the Evolver.

### 1. Define the Tree
Load a tree from a Newick file or a string.
```python
import pyvolve
my_tree = pyvolve.read_tree(tree="(A:0.1, B:0.1);")
# Or from a file
my_tree = pyvolve.read_tree(file="path/to/tree.tre")
```

### 2. Define the Evolutionary Model
Specify the type of data (nucleotide, amino acid, or codon) and the substitution parameters.
```python
# Simple Jukes-Cantor Nucleotide Model
nucleotide_model = pyvolve.Model("nucleotide")

# Empirical Amino Acid Model (e.g., WAG)
aa_model = pyvolve.Model("amino_acid", {"matrix": "WAG"})

# Custom GTR Model
parameters = {"mu": {"AC": 1, "AG": 2, "AT": 1, "CG": 1, "CT": 2, "GT": 1},
              "state_freqs": [0.25, 0.25, 0.25, 0.25]}
gtr_model = pyvolve.Model("nucleotide", parameters)
```

### 3. Create a Partition
A partition defines the length of the sequence and the model(s) applied to it.
```python
# Simulate 1000 nucleotides
my_partition = pyvolve.Partition(models=nucleotide_model, size=1000)
```

### 4. Execute the Evolver
The Evolver object manages the simulation process and writes the output.
```python
my_evolver = pyvolve.Evolver(partitions=my_partition, tree=my_tree)
my_evolver(seqfile="simulated_alignment.fasta", ratefile="rates.txt")
```

## Expert Tips and Best Practices
- **Reproducibility**: Always set a random seed when calling the evolver instance: `my_evolver(seed=42)`.
- **Custom Matrices**: For specialized research, you can provide custom exchangeability matrices and state frequencies to the `Model` object.
- **Site Heterogeneity**: To simulate rate variation across sites (e.g., Gamma distribution), pass a `rate_factors` list or a distribution to the `Partition` object.
- **PAML Compatibility**: Pyvolve supports PAML-formatted models. Ensure your parameters dictionary correctly maps to the expected PAML indices if using empirical protein models.
- **Branch Lengths**: Pyvolve interprets branch lengths as the expected number of substitutions per site. Ensure your input tree is scaled appropriately for the desired evolutionary distance.

## Reference documentation
- [Pyvolve GitHub Repository](./references/github_com_sjspielman_pyvolve.md)
- [Bioconda Pyvolve Overview](./references/anaconda_org_channels_bioconda_packages_pyvolve_overview.md)