---
name: mmtf-python
description: This tool provides a Pythonic interface for parsing, navigating, and analyzing macromolecular structures in MMTF, PDB, and CIF formats. Use when user asks to fetch structures from the RCSB PDB, navigate structural hierarchies, extract metadata, or perform complex residue selections and geometric queries.
homepage: https://github.com/samirelanduk/atomium
metadata:
  docker_image: "quay.io/biocontainers/mmtf-python:1.0.5--py27_0"
---

# mmtf-python

## Overview
The `mmtf-python` skill (utilizing the `atomium` library) provides a high-level, Pythonic interface for interacting with macromolecular structures. It is designed to handle the Macromolecular Transmission Format (MMTF) alongside traditional PDB and CIF formats. This tool is ideal for researchers and developers who need to extract metadata (like resolution or deposition date), navigate the structural hierarchy (Models, Chains, Residues, Atoms), and perform complex selections using regex or geometric queries.

## Core Usage Patterns

### Loading Structures
You can load data from local files or fetch them directly from the RCSB PDB. The library automatically detects the file format based on the extension or content.

```python
import atomium

# Fetch from RCSB (defaults to .cif if no extension provided)
pdb = atomium.fetch("5HVD")

# Open local files
mmtf_file = atomium.open('/path/to/structure.mmtf')
pdb_file = atomium.open('./complex.pdb.gz') # Supports gzipped files
```

### Handling Biological Assemblies
Many structures contain an "asymmetric unit" which may not represent the functional biological form. Use `generate_assembly` to create the correct biological model.

```python
# Check available assemblies
print(len(pdb.assemblies))

# Generate a specific assembly by ID
bio_model = pdb.generate_assembly(1)
```

### Navigating the Hierarchy
The library uses a nested structure: File -> Model -> Chain -> Residue/Ligand -> Atom.

```python
model = pdb.model # Gets the first model
chains = model.chains() # Returns a set of all chains
chain_a = model.chain("A")

# Accessing residues and ligands
residues = chain_a.residues()
ligands = model.ligands()
```

## Advanced Selection and Filtering
`mmtf-python` supports powerful filtering using keyword arguments and regular expressions.

```python
# Filter residues by name
tyrosines = model.residues(name="TYR")

# Use regex for complex selections
aromatics = model.residues(name__regex="TYR|PHE|TRP")

# Accessing specific residue by ID (Chain + Number)
res = model.residue("A.37")
```

## Metadata Extraction
Access experimental and deposition data directly from the file object.

```python
print(pdb.title)
print(pdb.resolution)
print(pdb.deposition_date)
print(pdb.classification)
print(pdb.source_organism)
```

## Best Practices
- **Prefer MMTF**: When working with large datasets or high-resolution structures, use the `.mmtf` format for significantly faster parsing and reduced disk space compared to `.pdb` or `.cif`.
- **NMR Structures**: Be aware that NMR files often contain multiple models. Iterate through `pdb.models` to analyze the full ensemble.
- **Set Operations**: Since many retrieval methods (like `.residues()`) return sets, you can use standard Python set logic (union, intersection) to combine selections.
- **Coordinate Math**: Use `model.center_of_mass` or `model.radius_of_gyration` for quick geometric assessments of the structure.

## Reference documentation
- [atomium Main Documentation](./references/github_com_samirelanduk_atomium.md)