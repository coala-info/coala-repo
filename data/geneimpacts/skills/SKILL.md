---
name: geneimpacts
description: "geneimpacts normalizes and compares the severity of genomic variant consequences from SnpEff, VEP, and BCFTools annotations. Use when user asks to normalize variant impact categories, compare the severity of different genomic annotations, or identify the most severe effect for a variant."
homepage: https://github.com/brentp/geneimpacts
---


# geneimpacts

## Overview
geneimpacts is a specialized Python library used to normalize and compare the severity of genomic variant consequences. It provides a unified interface for handling disparate annotation formats, specifically the SnpEff `ANN` field, the VEP `CSQ` field, and the BCFTools `BCSQ` field. By transforming these annotations into orderable Python objects, it allows for deterministic prioritization of variant effects based on biological impact, coding status, and gene type.

## Functional Logic and Prioritization
The tool uses a standardized ranking system to compare two annotations (a and b). An annotation is considered more severe if:
1. It is not a pseudogene, while the other is.
2. It is a coding variant, while the other is not.
3. It has a higher impact category (HIGH > MED > LOW).
4. It has better supporting scores (e.g., PolyPhen or SIFT) or longer transcript lengths (secondary ties).

### Impact Category Normalization
To maintain consistency across different tools, geneimpacts simplifies the standard four-category impact scale into three:
- **HIGH**: Remains HIGH.
- **MED**: Renamed from MODERATE (SnpEff/VEP).
- **LOW**: Renamed from MODIFIER (SnpEff/VEP) or LOW.

## Python API Usage
The library is primarily used programmatically to parse strings from VCF INFO fields.

### Parsing Annotations
Use the specific subclass corresponding to the annotation source:
- `SnpEff(annotation_string)`
- `VEP(annotation_string)`
- `BCFT(annotation_string)`

### Finding the Top Severity
The most common pattern is to parse a list of all annotations for a variant and extract the most severe one using the `top_severity` class method.

```python
from geneimpacts import SnpEff, Effect

# Example: Parsing multiple SnpEff annotations from a VCF ANN field
ann_field = "C|stop_gained|HIGH|BTK|..."
ann_list = [SnpEff(a) for a in ann_field.split(',')]

# Get the single highest severity effect
top_effect = Effect.top_severity(ann_list)

# If there is a tie, top_severity returns a list; otherwise, a single Effect object
if isinstance(top_effect, list):
    top_effect = top_effect[0]

print(top_effect.impact_severity) # e.g., "HIGH"
print(top_effect.gene)            # e.g., "BTK"
```

### Comparison Operations
Effect objects support standard comparison operators. If `eff1 < eff2`, then `eff2` is more severe than `eff1`. This allows for native sorting of annotation lists.

```python
effects = [eff1, eff2, eff3]
effects.sort() # Sorts from least severe to most severe
most_severe = effects[-1]
```

## Best Practices
- **Consistent Input**: Ensure the input string passed to the constructor matches the expected format of the tool (e.g., the raw pipe-delimited string from the VCF).
- **Handling Ties**: Always check if `top_severity` returns a list or a single object, as multiple transcripts may have identical severity scores.
- **Integration**: Use geneimpacts as a pre-processing step before loading variant data into databases or filtering tools like GEMINI to ensure only the most relevant functional consequence is considered.

## Reference documentation
- [github.com/brentp/geneimpacts](./references/github_com_brentp_geneimpacts.md)
- [bioconda geneimpacts overview](./references/anaconda_org_channels_bioconda_packages_geneimpacts_overview.md)