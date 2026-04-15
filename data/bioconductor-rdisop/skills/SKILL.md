---
name: bioconductor-rdisop
description: This tool identifies molecular sum formulas from exact mass and isotope pattern data using the Rdisop Bioconductor package. Use when user asks to decompose masses into chemical formulas, calculate theoretical isotope distributions, or perform molecular formula arithmetic in R.
homepage: https://bioconductor.org/packages/release/bioc/html/Rdisop.html
---

# bioconductor-rdisop

name: bioconductor-rdisop
description: Expert guidance for the Rdisop Bioconductor package to determine molecular sum formulas from exact mass and isotope patterns. Use this skill when you need to decompose masses into chemical formulas, calculate theoretical isotope distributions, or handle molecular formula arithmetic (adding/subtracting fragments) in R.

# bioconductor-rdisop

## Overview
The `Rdisop` package provides algorithms for mass decomposition—the process of identifying the elemental composition (sum formula) of a metabolite based on high-resolution mass spectrometry data. It can identify formulas using either a single exact mass or a full isotope pattern (masses and intensities).

## Core Workflows

### 1. Basic Molecule Handling
Create molecule objects to retrieve canonical formulas and exact masses.
```r
library(Rdisop)

# Create a molecule from a string
mol <- getMolecule("C2H5OH")

# Access properties
getFormula(mol)  # Returns "C2H6O"
getMass(mol)     # Returns 46.04186
```

### 2. Decomposing a Single Mass
Find all chemical formulas matching a specific mass within a ppm error window.
```r
# Find formulas for mass 147.053 within 10ppm (default)
results <- decomposeMass(147.053, ppm=10)

# Inspect results
getFormula(results)
getScore(results)
getValid(results) # Checks Nitrogen rule/DBE
```

### 3. Decomposing Isotope Patterns
Use both mass and intensity lists to rank candidate formulas using Bayesian scoring.
```r
masses <- c(147.053, 148.056)
intensities <- c(93, 5.8)

# Decompose based on the pattern
candidates <- decomposeIsotopes(masses, intensities)

# View top candidates as a data frame
data.frame(
  Formula = getFormula(candidates),
  Score = getScore(candidates),
  Valid = getValid(candidates)
)
```

### 4. Formula Arithmetic (Adducts and Fragments)
Modify formulas by adding or subtracting specific groups, useful for removing ESI adducts (like [M+H]+) or adding lost fragments.
```r
# Remove a proton from a detected formula to get the neutral mass
neutral_mol <- subMolecules("C5H10NO4", "H")
getFormula(neutral_mol)

# Add a fragment
complex_mol <- addMolecules("C6H12O6", "Na")
```

### 5. Customizing Elements
By default, `Rdisop` uses CHNOPS. For molecules containing metals or other elements, initialize a custom element set.
```r
# Initialize a larger set including Magnesium and Iron
custom_elements <- initializeCHNOPSMgKCaFe()

# Use the custom set in functions
mol <- getMolecule("C55H72MgN4O5", elements=custom_elements)
```

## Tips for Success
- **PPM Window**: If `decomposeMass` returns no results, slightly increase the `ppm` argument.
- **N-Rule**: The `getValid()` function checks the Nitrogen rule. While most metabolites follow this, some exceptions exist; do not discard "Invalid" results immediately if they have high scores.
- **Charge**: When using `getMolecule` for ions, specify the charge `z` (e.g., `z=1`).
- **Isotope Extraction**: Use `getIsotope(molecule, index)` to retrieve specific peaks from the theoretical distribution.

## Reference documentation
- [Mass decomposition with the Rdisop package](./references/Rdisop.md)
- [Rdisop Source Vignette](./references/Rdisop.Rmd)