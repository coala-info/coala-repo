---
name: bioconductor-genomeinfodbdata
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/GenomeInfoDbData.html
---

# bioconductor-genomeinfodbdata

name: bioconductor-genomeinfodbdata
description: Provides species and taxonomy ID lookup tables for Bioconductor's GenomeInfoDb. Use this skill when you need to map between NCBI taxonomy IDs, genera, and species names, or when you need to verify valid species identifiers for genomic data annotation.

# bioconductor-genomeinfodbdata

## Overview
The `GenomeInfoDbData` package is a core Bioconductor annotation data package. It serves as the underlying data provider for the `GenomeInfoDb` package, containing the mapping between NCBI taxonomy IDs and species names. It is primarily used to ensure consistency in species nomenclature across Bioconductor objects.

## Loading the Data
The package contains a single primary dataset called `specData`.

```r
library(GenomeInfoDbData)
data(specData)
```

## Working with specData
The `specData` object is a data frame containing three columns:
- `tax_id`: The NCBI Taxonomy ID (integer).
- `genus`: The scientific genus (factor).
- `species`: The specific epithet (character).

### Common Workflows

**1. Finding a Taxonomy ID for a specific species**
To retrieve the tax_id for a known organism:
```r
# Example: Find ID for Human
subset(specData, genus == "Homo" & species == "sapiens")$tax_id
# Output: 9606
```

**2. Finding species information from a Taxonomy ID**
To identify an organism based on its NCBI ID:
```r
# Example: Find species for tax_id 10090
subset(specData, tax_id == 10090)
# Output: Mus musculus
```

**3. Listing all species within a Genus**
```r
# Example: List all species in the Drosophila genus
dros_species <- subset(specData, genus == "Drosophila")$species
```

## Usage Tips
- **Data Source**: The data is derived from the NCBI taxonomy dump (`taxdump.tar.gz`).
- **Integration**: While you can query `specData` directly, most high-level Bioconductor functions (like `seqlevelsStyle` or `getChromInfoFromNCBI`) use this data internally via the `GenomeInfoDb` package.
- **Case Sensitivity**: Ensure "genus" starts with an uppercase letter and "species" is lowercase, following standard biological nomenclature.

## Reference documentation
- [GenomeInfoDbData Reference Manual](./references/reference_manual.md)