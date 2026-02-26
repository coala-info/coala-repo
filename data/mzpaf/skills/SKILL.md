---
name: mzpaf
description: The mzpaf tool parses, serializes, and manipulates standardized fragment ion peak annotations using a concise string-based format. Use when user asks to parse mzPAF strings, generate peak annotations for fragment ions, or programmatically handle mass deltas and confidence scores in mass spectrometry data.
homepage: https://github.com/HUPO-PSI/mzPAF
---


# mzpaf

## Overview
The `mzpaf` skill enables the handling of standardized fragment ion peak annotations. mzPAF is a concise, string-based format designed to describe the origin of fragment ions (e.g., b/y series, neutral losses, isotopes, and adducts) with associated mass deltas and confidence scores. This skill provides guidance on using the Python implementation to programmatically manipulate these annotations and understand the syntax for manual creation or validation.

## Core Syntax Patterns
mzPAF strings follow a specific hierarchy: `[annotation]/[delta]*[confidence]`. Multiple annotations for a single peak are comma-separated.

- **Basic Ion**: `y4`, `b2`
- **Neutral Loss/Gain**: `b2-H2O`, `y7+NH3`
- **Charge States**: `y12^2` (use `^` followed by the integer)
- **Mass Deltas**: `y1/-1.4ppm` or `b2/0.002` (defaults to Th/Da if no unit)
- **Confidence**: `y1*0.95` (value between 0 and 1)
- **Complex Example**: `b2-H2O/3.2ppm*0.75,b4-H2O^2/3.2ppm*0.25`

## Python API Usage
The `mzpaf` Python package is the primary tool for interacting with these strings.

### Parsing and Serialization
```python
import mzpaf

# Parse a string into a list of Annotation objects
line = "b2-H2O/3.2ppm*0.75"
annotations = mzpaf.parse_annotation(line)

# Access components
anno = annotations[0]
print(anno.charge)
print(anno.mass_error['value'])

# Convert back to mzPAF string
print(anno.serialize())

# Convert to JSON-ready dictionary
print(anno.to_json())
```

### Advanced Ion Types
When generating or parsing complex spectra, use the following notation:
- **Immonium Ions**: `IY` (Immonium Tyrosine)
- **Internal Fragments**: `m3:6` (Internal fragment from residues 3 to 6)
- **Precursor Ions**: `p^2`
- **Chemical Formulas**: `f{C16H22O}`
- **SMILES**: `s{CN=C=O}[M+H]`
- **ProForma Integration**: `0@b2{LC[Carbamidomethyl]}` (where `0@` refers to the analyte index)

## Best Practices
- **Case Sensitivity**: mzPAF is case-sensitive. Ensure ion series (a, b, c, x, y, z) are lowercase.
- **Delta Units**: Always specify `ppm` for high-resolution data to avoid ambiguity with absolute m/z deltas.
- **Analyte Referencing**: In chimeric spectra, use the `[index]@` prefix (e.g., `1@y12`) to map the fragment to a specific precursor defined in the metadata.
- **Validation**: Use the `mzpaf.parse_annotation` method within a try-except block to validate if a string conforms to the PSI specification.

## Reference documentation
- [mzPAF GitHub Repository](./references/github_com_HUPO-PSI_mzPAF.md)
- [Bioconda mzpaf Overview](./references/anaconda_org_channels_bioconda_packages_mzpaf_overview.md)