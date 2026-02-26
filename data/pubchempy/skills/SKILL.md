---
name: pubchempy
description: PubChemPy is a Python library that retrieves chemical data, properties, and structural information from the PubChem database via its REST API. Use when user asks to fetch molecular properties, search for compounds by name or identifier, perform substructure or similarity searches, and convert chemical identifiers like SMILES or IUPAC names.
homepage: https://github.com/mcs07/PubChemPy
---


# pubchempy

## Overview
PubChemPy is a Python library that wraps the PubChem PUG REST API, allowing for seamless integration of chemical data into informatics workflows. It is designed for tasks that require fetching molecular data, standardizing chemical structures, or mapping identifiers across large datasets. Use this skill to automate the retrieval of physical and chemical properties without manual interaction with the PubChem web interface.

## Core Usage Patterns

### Retrieving Compounds
The most common entry point is retrieving a compound by a known identifier.

```python
import pubchempy as pcp

# Retrieve by CID (PubChem Compound ID)
c = pcp.Compound.from_cid(1423)

# Search by name
results = pcp.get_compounds('Glucose', 'name')
compound = results[0]
```

### Accessing Properties
Once a compound object is retrieved, properties are accessible as attributes. Common properties include:
- `c.isomeric_smiles`: The isomeric SMILES string.
- `c.iupac_name`: The preferred IUPAC name.
- `c.molecular_weight`: The molecular weight as a float.
- `c.xlogp`: The computed octanol-water partition coefficient.
- `c.charge`: The formal charge of the molecule.

### Identifier Conversion
PubChemPy is highly effective for "mapping" tasks, such as converting a list of names to SMILES strings.

```python
def name_to_smiles(name):
    try:
        compounds = pcp.get_compounds(name, 'name')
        return compounds[0].isomeric_smiles if compounds else None
    except pcp.PubChemHTTPError:
        return None
```

### Structural Searches
You can perform complex searches based on chemical structure rather than text.

- **Substructure Search**: Find all compounds containing a specific fragment.
- **Similarity Search**: Find compounds structurally similar to a query molecule.

```python
# Find compounds similar to a SMILES string
similar_compounds = pcp.get_compounds('C1=CC=CC=C1', 'smiles', searchtype='similarity')
```

## Expert Tips and Best Practices

### Batch Requests
To avoid hitting API rate limits and to improve performance, use batch requests when dealing with multiple CIDs. Instead of calling `from_cid` in a loop, pass a list of CIDs to `get_compounds`.

```python
# Efficient batch retrieval
cids = [1, 2, 3, 4, 5]
compounds = pcp.get_compounds(cids)
```

### Handling Rate Limits
PubChem enforces rate limits (typically 5 requests per second). If you encounter `PubChemHTTPError` with a 'Server Busy' message, implement a retry logic with exponential backoff or reduce the frequency of your requests.

### Substance vs. Compound
- **Compound (CID)**: Refers to a unique, standardized chemical structure.
- **Substance (SID)**: Refers to a specific sample or record provided by a contributor, which may contain mixtures or unrefined data.
Always prefer `get_compounds` for clean chemical data unless you specifically need provenance information from `get_substances`.

### Data Types
Be aware that some properties might return `None` if they haven't been calculated or are not applicable to the specific molecule. Always validate the presence of an attribute before performing calculations.

## Reference documentation
- [PubChemPy GitHub Repository](./references/github_com_mcs07_PubChemPy.md)
- [PubChemPy Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pubchempy_overview.md)