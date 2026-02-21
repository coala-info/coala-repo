---
name: pronto
description: The `pronto` skill enables the management of ontology data through a high-level Python interface.
homepage: https://github.com/althonos/pronto
---

# pronto

## Overview
The `pronto` skill enables the management of ontology data through a high-level Python interface. It allows for the extraction of terms, navigation of class hierarchies (superclasses/subclasses), and the creation of new ontological terms from scratch. This skill is essential for bioinformatics workflows that require converting between ontology formats (e.g., OWL to OBO) or performing structural analysis on ontology graphs, such as identifying leaf nodes or calculating term lineages.

## Usage Patterns

### Loading Ontologies
Load ontologies from local files (including compressed `.gz` files) or directly from persistent URLs.

```python
from pronto import Ontology

# Load from a local compressed file
go = Ontology("path/to/go.obo.gz")

# Load from a URL
cl = Ontology("http://purl.obolibrary.org/obo/cl.obo")

# Load using the OBO Library shortcut
stato = Ontology.from_obo_library("stato.owl")
```

### Accessing and Inspecting Terms
Access terms using their compact identifiers (CURIEs).

```python
# Retrieve a term by ID
term = cl['CL:0002116']
print(term.name)

# Check if a term is a leaf node (no subclasses)
if term.is_leaf():
    print(f"{term.id} is a leaf node.")

# Iterate over all terms in the ontology
for term in go.terms():
    print(term.id, term.name)
```

### Creating and Editing Ontologies
Modify existing ontologies or build new ones by defining terms and relationships.

```python
# Create a new term
new_term = ontology.create_term("ID:12345")
new_term.name = "New Biological Process"

# Add relationships (e.g., is_a / superclasses)
new_term.superclasses().add(ontology["ID:00001"])

# Define disjointness
new_term.disjoint_from.add(ontology["ID:00002"])
```

### Exporting and Conversion
Serialize ontologies to different formats, such as OBO or OBO JSON.

```python
# Convert an OWL ontology to OBO format
with open("output.obo", "wb") as f:
    ontology.dump(f, format="obo")
```

## Expert Tips

### Handling Verbose Warnings
`pronto` is strict about non-standard assumptions in ontology files and can be quite verbose. To silence these warnings in production scripts:

```python
import warnings
import pronto
warnings.filterwarnings("ignore", category=pronto.warnings.ProntoWarning)
```

### Performance Considerations
If you only need to parse OBO or OBO Graphs documents without the high-level browsing features of `pronto`, consider using `fastobo` for significantly faster parsing speeds.

### Working with OWL
When loading OWL ontologies, `pronto` reverse-translates them to OBO using the OBO 1.4 Semantics mapping. Note that URIs are automatically compacted to CURIEs whenever possible during this process.

## Reference documentation
- [Pronto GitHub Repository](./references/github_com_althonos_pronto.md)
- [Bioconda Pronto Overview](./references/anaconda_org_channels_bioconda_packages_pronto_overview.md)