---
name: gnomic
description: Gnomic provides a standardized grammar and Python tool for parsing, tracking, and formatting microbial genotypes and genetic modifications. Use when user asks to parse genotype strings, track genetic changes across generations, or generate standardized genetic descriptions.
homepage: https://github.com/biosustain/gnomic
---


# gnomic

## Overview

Gnomic provides a standardized, unambiguous grammar for microbial genetics, bridging the gap between traditional human-readable nomenclature and the precision required for genome engineering. This skill enables the interpretation of complex genotype strings, the tracking of genetic modifications between parent and child strains, and the generation of standardized genetic descriptions.

## Grammar Reference

The gnomic grammar uses specific symbols to denote genetic states and changes. Multiple designations should be separated by spaces or commas.

| Action | Syntax | Example |
| :--- | :--- | :--- |
| **Presence** | `feature` | `geneA` |
| **Deletion** | `-feature` | `-geneA` |
| **Insertion** | `+feature` | `+kanR` |
| **Replacement** | `site>feature` | `lacZ>gfp` |
| **Multiple Integration** | `site>>feature` | `attB>>geneX` |
| **Locus Specification** | `feature@locus` | `-geneA@locus1` |
| **Organism Prefix** | `organism/feature` | `Ec/geneA` |
| **Type Prefix** | `type.feature` | `P.promoterA` |
| **Variants** | `feature(variant)` | `gyrA(D87G)` |
| **Accession** | `feature#db:id` | `geneX#GB:12345` |
| **Fusion** | `feat1:feat2` | `lacZ:gfp` |
| **Plasmid** | `(name)` | `(pUC19)` |

## Python Usage Patterns

The `gnomic` Python package is the primary way to interact with this grammar programmatically.

### Basic Parsing and Inspection
```python
from gnomic import Genotype

# Parse a genotype string
g = Genotype.parse('+Ec/geneA(variant) siteA>P.promoterB:Ec/geneB -geneC')

# Inspect added and removed features
print(g.added_features)
print(g.removed_features)
```

### Tracking Generational Changes
To interpret changes over multiple generations, pass the previous genotype as the `parent`.
```python
g1 = Genotype.parse('+geneA')
g2 = Genotype.parse('-geneB', parent=g1)

# g2 now contains +geneA and -geneB
# View specific changes made in the current generation
for change in g2.changes():
    print(change)
```

### Standardizing Output
Use the `.format()` method to generate a human-readable, standardized string using Δ and → symbols.
```python
# Returns 'ΔsiteA→P.promoterB:Ec/geneB ΔgeneC'
print(g.format())
```

## Expert Tips

- **Accession Numbers**: Always prefer using accession numbers (`#GB:123456`) for features when building automated pipelines to avoid naming ambiguity.
- **HGVS Compatibility**: For sequence-level variants, gnomic supports HGVS nomenclature within the variant parentheses, e.g., `geneY(c.123G>T)`.
- **Complex Fusions**: You can nest fusions and insertions, such as `+{geneA:geneB}:geneC` to describe complex synthetic constructs.
- **State Management**: When simulating a series of engineering steps, always maintain the `Genotype` object and pass it as the `parent` to the next `parse()` call to ensure the cumulative state is tracked correctly.

## Reference documentation
- [gnomic GitHub Repository](./references/github_com_biosustain_gnomic.md)