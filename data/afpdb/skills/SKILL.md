---
name: afpdb
description: afpdb is a NumPy-based library for high-performance protein structure manipulation, selection, and preparation for AI models. Use when user asks to load PDB files, select residues using contig syntax, renumber chains, identify protein interfaces, or analyze antibody CDR regions.
homepage: https://github.com/data2code/afpdb
metadata:
  docker_image: "quay.io/biocontainers/afpdb:0.3.1--pyhcf36b3e_0"
---

# afpdb

## Overview

`afpdb` is a NumPy-based library designed to bridge the gap between traditional structural biology tools and modern protein AI models. It provides a streamlined API for complex tasks like residue relabeling, interface computing, and antibody-specific analysis. By leveraging the same architecture as AlphaFold and RFDiffusion, it allows for extremely fast execution and concise code when processing large-scale structural datasets that would be cumbersome in Biopython.

## Core Usage Patterns

### Initialization and I/O
Load structures from local files or fetch them directly from the PDB.
```python
from afpdb.afpdb import Protein, RS, RL, ATS

# Load from PDB ID or local file
p = Protein("5cil") 
p.summary().display()

# Save modified structures
p.save("output.pdb")
```

### Selection with Contig Syntax
`afpdb` uses a powerful selection syntax similar to RFDiffusion.
- **Residue Selection (RS):** `p.rs("H1-100,L1-100")` selects specific ranges.
- **Boolean Operations:** Use `|` (OR), `&` (AND), and `~` (NOT) to combine selections.
- **Extraction:** `q = p.extract(RS("H") | RS("L"))` creates a new Protein object from a selection.

### Preparing Structures for AI Models
Prepare sequences for AlphaFold or ESMFold by handling missing residues or gaps.
```python
# Replace missing residues with Glycine for AlphaFold input
sequence = p.seq(gap="G")

# Relabel residues starting from 1
p.renumber("RESTART", inplace=True)
```

### Interface and Neighbor Analysis
Identify residues at the interface of two chains or within a specific distance.
```python
# Find residues in H and L chains within 4A of antigen chain P
rs_binder, rs_seed, df_dist = p.rs_around("P", dist=4)
```

### Antibody-Specific Analysis
`afpdb` includes specialized methods for immunoglobulins.
```python
# Identify CDRs and variable domains using IMGT scheme
rs_cdr, rs_var, chain_type, cdr_def = p.rs_antibody(scheme="imgt")

# Analyze scFv structures
# p.rs_antibody can also set B-factors to visualize CDRs
```

## Expert Tips

- **In-place Operations:** Many methods like `renumber` support `inplace=True`. Use this to save memory when working with very large complexes.
- **Visualization:** If working in a Jupyter environment, `p.show(show_sidechains=True)` provides an interactive 3D view.
- **B-Factor Manipulation:** You can use B-factors as a "data channel" to highlight specific regions (like CDRs or high-error regions from AlphaFold) before exporting to PyMOL.
- **Chain Mapping:** Use `p.align(target_protein)` for automatic chain mapping and structural alignment, which is more robust than simple RMSD calculations for multi-chain complexes.

## Reference documentation
- [Afpdb - An Efficient Protein Structure Manipulation Tool](./references/github_com_data2code_afpdb.md)
- [afpdb - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_afpdb_overview.md)