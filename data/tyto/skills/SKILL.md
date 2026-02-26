---
name: tyto
description: Tyto is a Python library that provides a programmatic interface to access ontology terms and perform semantic reasoning. Use when user asks to retrieve ontology term URIs, check semantic relationships between terms, or configure custom ontologies.
homepage: https://github.com/SynBioDex/tyto
---


# tyto

## Overview
Tyto (Take Your Terms from Ontologies) is a lightweight Python library designed to make the semantic web more accessible for scientific computing. It provides a Pythonic interface to dynamically retrieve URIs for ontology terms and perform semantic reasoning—such as checking parent-child relationships—without requiring users to hard-code URIs or manually parse OWL files. It is particularly useful in synthetic biology and bioinformatics for ensuring data follows standardized naming conventions.

## Installation
Install tyto via the bioconda channel:
```bash
conda install bioconda::tyto
```

## Core Usage Patterns

### Accessing Ontology Terms
Tyto provides out-of-the-box support for several major ontologies. Terms are accessed using standard Python attribute (dot) notation, which Tyto converts into the appropriate URI.

```python
from tyto import SO, SBO, NCIT

# Retrieve URIs for specific terms
print(SO.promoter)  # http://purl.obolibrary.org/obo/SO_0000167
print(SBO.systems_biology_representation) # http://biomodels.net/SBO/SBO_0000000
```

### Semantic Reasoning and Inference
Tyto allows you to evaluate the relationships between terms based on the ontology's hierarchy.

```python
# Check if a term is a specialized type of another (is_a relationship)
is_promoter = SO.inducible_promoter.is_a(SO.promoter) # Returns True

# Other available inference methods:
term = SO.inducible_promoter
parents = term.get_parents()
children = term.get_children()
is_descendant = term.is_descendant_of(SO.promoter)
is_ancestor = SO.promoter.is_ancestor_of(term)
```

### Configuring Custom Ontologies
If an ontology is not supported out-of-the-box, you can configure a new interface using a URI and a lookup service (like EBI or Ontobee).

```python
from tyto import EBIOntologyLookupService, Ontology

# Configure a custom ontology interface (e.g., KISAO)
KISAO = Ontology(uri='http://www.biomodels.net/kisao/KISAO_FULL#', 
                 endpoints=[EBIOntologyLookupService])

# Access terms from the new interface
print(KISAO.Gillespie_direct_algorithm)
```

## Expert Tips
- **Dynamic Generation**: Symbols are not hard-coded; Tyto queries web-based lookup services (Ontobee/EBI) dynamically. Ensure you have an active internet connection for first-time term lookups.
- **Local Files**: For offline use or private ontologies, you can import an ontology from a local `.owl` file.
- **Case Sensitivity**: While Tyto handles many naming conventions, ensure your attribute names match the labels defined in the source ontology (often replacing spaces with underscores).
- **Interconversion**: Use `tyto.URI` to wrap raw strings if you need to perform Tyto-specific reasoning methods on a URI string obtained from an external source.

## Reference documentation
- [Tyto GitHub Repository](./references/github_com_SynBioDex_tyto.md)
- [Bioconda Tyto Package Overview](./references/anaconda_org_channels_bioconda_packages_tyto_overview.md)