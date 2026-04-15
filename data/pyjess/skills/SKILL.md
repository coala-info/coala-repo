---
name: pyjess
description: pyjess is a high-performance Python library for identifying 3D structural motifs in proteins using the JESS template matching algorithm. Use when user asks to search for catalytic sites, perform 3D template matching on protein structures, or identify geometric arrangements of residues.
homepage: https://github.com/althonos/pyjess
metadata:
  docker_image: "quay.io/biocontainers/pyjess:0.9.1--py310h1fe012e_0"
---

# pyjess

## Overview

pyjess is a high-performance Python library providing Cython bindings for the JESS algorithm, a 3D template matching software for protein structures. It is primarily used to identify specific geometric arrangements of residues—such as catalytic sites—within a query protein structure. pyjess is optimized for speed (10x faster than the original JESS) and provides seamless integration with common structural biology libraries like BioPython, Gemmi, and Biotite.

## Core Workflow

### 1. Preparing Templates
Templates define the geometric constraints of the residues you are looking for. Load them from `.qry` files.

```python
import pyjess
from pathlib import Path

# Load a single template
template = pyjess.Template.load("site_template.qry", id="active_site_1")

# Load multiple templates for a batch search
template_paths = Path("templates/").glob("*.qry")
templates = [pyjess.Template.load(p, id=p.stem) for p in template_paths]
```

### 2. Loading Query Structures
Molecules can be loaded directly from PDB/mmCIF files or converted from other Python objects.

```python
# Direct load
mol = pyjess.Molecule.load("protein.pdb")

# Conversion from BioPython
from Bio.PDB import PDBParser
structure = PDBParser().get_structure("id", "protein.pdb")
mol = pyjess.Molecule.from_biopython(structure)

# Conversion from Gemmi
import gemmi
st = gemmi.read_structure("protein.pdb")
mol = pyjess.Molecule.from_gemmi(st[0])
```

### 3. Executing the Query
Initialize the `Jess` engine with your templates and run the query against a molecule.

```python
jess = pyjess.Jess(templates)
query = jess.query(
    mol, 
    rmsd_threshold=2.0,      # Max RMSD for a hit
    distance_cutoff=3.0,     # Distance constraint
    max_dynamic_distance=3.0 # Flexibility allowance
)

for hit in query:
    print(f"Match: {hit.template().id} in {hit.molecule().id}")
    print(f"RMSD: {hit.rmsd:.3f}, Log E-value: {hit.log_evalue:.3f}")
```

## Expert Tips and Best Practices

### Parallel Processing
The `Jess.query` method is thread-safe once the `Jess` instance is initialized. Use a `ThreadPool` to process multiple molecules against the same set of templates efficiently.

```python
import multiprocessing.pool

molecules = [pyjess.Molecule.load(p) for p in pdb_files]
with multiprocessing.pool.ThreadPool() as pool:
    results = pool.map(jess.query, molecules)
```

### Handling Hits
*   **Iterative Computation**: Hits are computed on-the-fly. If you only need the top hit, you can break the loop early to save time.
*   **PDB Output**: You can export hits directly to PDB format for visualization in tools like PyMOL.
    ```python
    with open("hit.pdb", "w") as f:
        hit.dump(f, format="pdb")
    ```

### Performance Tuning
*   **Thresholds**: Lowering the `rmsd_threshold` significantly reduces the search space and increases speed, but may miss distant structural homologs.
*   **Memory**: For very large datasets, load molecules one by one within the processing loop rather than pre-loading all into a list to conserve RAM.

## Reference documentation
- [pyjess Overview and API](./references/github_com_althonos_pyjess.md)
- [Bioconda Installation](./references/anaconda_org_channels_bioconda_packages_pyjess_overview.md)