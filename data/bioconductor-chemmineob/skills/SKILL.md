---
name: bioconductor-chemmineob
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/ChemmineOB.html
---

# bioconductor-chemmineob

## Overview
ChemmineOB provides an R interface to the OpenBabel C++ library, a powerful open-source cheminformatics toolbox. It enables R users to access high-performance chemical data processing utilities, including format conversion (e.g., SMILES to SDF), descriptor calculation, and fingerprinting. While it can be used standalone, it is most commonly utilized as an acceleration and feature-extension layer for the `ChemmineR` package.

## Core Workflows

### Integration with ChemmineR
For most users, ChemmineOB functions are accessed transparently through `ChemmineR`. Ensure both are loaded:
```r
library(ChemmineR)
library(ChemmineOB)
```

### SWIG Interface for Developers
ChemmineOB exposes the full OpenBabel API via SWIG wrappers. This allows for low-level manipulation of chemical objects.

**Object Creation:**
Create OpenBabel objects using the class name as a function:
```r
# Create a conversion object
ob_conv = OBConversion()
# Create a molecule object
ob_mol = OBMol()
```

**Method Invocation:**
Methods are called using the pattern `ClassName_MethodName(object, arguments)`:
```r
# Add an option to the conversion object
OBConversion_AddOption(ob_conv, "gen2D", "OUT")

# Set the input and output formats
OBConversion_SetInAndOutFormats(ob_conv, "smiles", "sdf")
```

**Handling Pointers and C++ Types:**
- **Strings:** Use `stringp()` to handle `char*` pointers. Access the pointer via `$cast()` and the value via `$value()`.
- **Vectors:** Use type-specific vector functions like `vectorUnsignedInt()`. Access size with `vectorUnsignedInt_size(vec)`.

```r
# Example: Getting a string value from a descriptor
result = stringp()
OBDescriptor_GetStringValue(descriptor_obj, mol_obj, result$cast())
print(result$value())
```

## Platform-Specific Limitations
- **Windows:** The "MACCS" and "InChi" modules are currently unavailable in the Windows distribution of ChemmineOB.
- **Linux/Mac:** Requires a system installation of OpenBabel (2.3.0 or greater).

## Usage Tips
- **Task-Oriented Documentation:** For high-level tasks (like calculating fingerprints or searching), refer to the "OpenBabel Functions" section of the `ChemmineR` vignette.
- **API Reference:** If you are familiar with the C++ OpenBabel API, the R functions follow a predictable naming convention (underscore separation) that maps directly to the C++ methods.
- **Memory Management:** When using the SWIG interface directly, be mindful of object lifecycles, though R's garbage collector handles the wrapper objects.

## Reference documentation
- [ChemmineOB: Interface to a Subset of OpenBabel Functionalities](./references/ChemmineOB.md)