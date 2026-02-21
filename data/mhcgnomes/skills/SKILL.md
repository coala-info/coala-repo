---
name: mhcgnomes
description: The `mhcgnomes` skill provides a robust framework for handling the often inconsistent naming conventions found in immunological databases like IEDB, IMGT/HLA, and IPD/MHC.
homepage: https://github.com/til-unc/mhcgnomes
---

# mhcgnomes

## Overview
The `mhcgnomes` skill provides a robust framework for handling the often inconsistent naming conventions found in immunological databases like IEDB, IMGT/HLA, and IPD/MHC. It transforms "wild" MHC strings into structured objects, allowing for reliable comparison and standardization across different bioinformatics tools and datasets. Use this skill to resolve ambiguities between alleles, serotypes, haplotypes, and functional supertypes.

## Usage Patterns

### Parsing and Normalization
The primary function is `mhcgnomes.parse()`. It returns a structured object (usually an `Allele`) that can be converted into various string representations.

```python
import mhcgnomes

# Parse a non-standard string
allele = mhcgnomes.parse("HLA-A0201")

# Standard IMGT/HLA format
print(allele.to_string())        # Output: 'HLA-A*02:01'

# Compact format (often used in predictors)
print(allele.compact_string())   # Output: 'A0201'
```

### Handling Complex Entities
MHCgnomes identifies more than just alleles. It uses a heuristic ranking system to categorize strings into specific types:

- **Serotypes**: e.g., "HLA-A2" or "A2"
- **Supertypes**: e.g., "A2 supertype"
- **Class II Heterodimers**: e.g., "DQ2.5" (parsed as DQA1*05:01/DQB1*02:01)
- **Mutants**: e.g., "HLA-B*08:01 N80I mutant" (captured in the `mutations` field)
- **Haplotypes**: e.g., "H2-k" (distinguished from the H2-K gene)

### Accessing Structured Data
Once parsed, you can programmatically access the components of the MHC name:

```python
result = mhcgnomes.parse("HLA-A*02:01:01S")

print(result.species.name)    # "Homo sapiens"
print(result.gene.name)       # "A"
print(result.allele_fields)   # ("02", "01", "01")
print(result.annotations)     # ("S",)
```

## Expert Tips
- **Heuristic Ranking**: If a string is ambiguous, `mhcgnomes` ranks interpretations. It prefers `Allele` over `Serotype` or `Haplotype`.
- **Species Prefixes**: For human alleles, the "HLA-" prefix is optional during parsing but will be included in `to_string()` by default.
- **Non-Human MHC**: The library supports archaic systems like mouse (H2) and rat (RT1). Note that capitalization is often unreliable in these systems; `mhcgnomes` handles this internally to distinguish between genes and haplotypes.
- **Digit Variations**: The library is designed to handle the transition from two-digit to three-digit fields (e.g., `A*02` vs `A*002`).

## Reference documentation
- [mhcgnomes GitHub Repository](./references/github_com_pirl-unc_mhcgnomes.md)