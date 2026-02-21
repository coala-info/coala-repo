---
name: pydna
description: pydna is a specialized library for in silico DNA manipulation that extends Biopython to support double-stranded DNA (dsDNA) logic.
homepage: https://github.com/BjornFJohansson/pydna
---

# pydna

## Overview

pydna is a specialized library for in silico DNA manipulation that extends Biopython to support double-stranded DNA (dsDNA) logic. It allows researchers to simulate laboratory procedures like PCR, restriction-ligation, and various assembly methods with high fidelity. Use this skill to automate the design of complex recombinant pathways, verify cloning strategies, and generate stable, unambiguous documentation for genetic constructs before performing wet-lab experiments.

## Core Classes and Objects

- **Dseqrecord**: The primary class for representing double-stranded DNA. It is a subclass of Biopython's `SeqRecord`.
- **Dseq**: Represents the underlying double-stranded sequence. It can be linear or circular.
- **Amplicon**: A specialized `Dseqrecord` produced by a PCR simulation, containing information about the primers used and their annealing sites.

## Common Workflows

### Sequence Initialization
Create a DNA record from a string or by importing sequences. Always specify the topology for plasmids.
```python
from pydna.dseqrecord import Dseqrecord

# Create a linear fragment
fragment = Dseqrecord("ATGC...")

# Create a circular vector
vector = Dseqrecord("AATG...", circular=True, name="pVector")
```

### Primer Design and PCR
Use `primer_design` to generate primers based on a target melting temperature (Tm), then simulate the reaction with `pcr`.
```python
from pydna.design import primer_design
from pydna.amplify import pcr

# Design primers for a template
amplicon_info = primer_design(template_dsr, target_tm=55)

# Simulate PCR (can add tails/restriction sites to primers)
fwd_primer = "ccccGGATCC" + amplicon_info.forward_primer
rev_primer = "ttttGGATCC" + amplicon_info.reverse_primer
pcr_product = pcr(fwd_primer, rev_primer, template_dsr)
```

### Restriction Digestion and Ligation
Simulate "cut and paste" cloning using Biopython's restriction enzymes.
```python
from Bio.Restriction import BamHI, BglII

# Digest a product (returns a list of fragments)
fragments = pcr_product.cut(BamHI)
payload = fragments[1] # Select the desired fragment

# Linearize a vector and ligate
linear_vector = vector.cut(BglII)[0]
recombinant_plasmid = (linear_vector + payload).looped()
```

## Best Practices and Expert Tips

- **Visualization**: Use the `.figure()` method on `Dseqrecord` or `Amplicon` objects. This provides a text-based representation of the sequence, features, and primer annealing sites, which is essential for verifying that primers are oriented correctly.
- **Feature Management**: Use `.add_feature()` to annotate specific regions. These features are preserved through simulations like PCR and digestion, making it easier to track genes or promoters in the final construct.
- **Circularization**: When creating a circular molecule from a linear ligation product, always call `.looped()`.
- **Origin Synchronization**: When comparing circular plasmids or performing assemblies, use the `.synced()` method to ensure the origin coordinate (0) is consistent across different versions of the vector.
- **GenBank Formatting**: Use `print(dsr.format("genbank"))` to generate standard-compliant files for use in other software or for inclusion in supplemental data.

## Reference documentation
- [pydna GitHub Repository](./references/github_com_pydna-group_pydna.md)