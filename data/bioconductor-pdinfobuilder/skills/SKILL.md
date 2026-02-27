---
name: bioconductor-pdinfobuilder
description: This tool builds custom R annotation packages for Affymetrix and NimbleGen microarrays to be used with the Bioconductor oligo package. Use when user asks to create platform design annotation packages, build custom microarray annotation from raw design files, or generate seed objects for Affymetrix and NimbleGen platforms.
homepage: https://bioconductor.org/packages/release/bioc/html/pdInfoBuilder.html
---


# bioconductor-pdinfobuilder

name: bioconductor-pdinfobuilder
description: Building annotation packages (Platform Design Info) for use with the Bioconductor 'oligo' package. Use this skill when you need to create custom R annotation packages for Affymetrix (Expression, SNP, Tiling, Exon, Gene) or NimbleGen (Expression, Tiling) microarrays from raw design files like CDF, PGF, CLF, NDF, and BPMAP.

# bioconductor-pdinfobuilder

## Overview

The `pdInfoBuilder` package is used to create "Platform Design" (PD) annotation packages. These packages are essential for processing high-density microarray data using the `oligo` package. While many annotation packages are available on Bioconductor, `pdInfoBuilder` allows users to build their own when using custom arrays or when specific versions of design files are required.

## Core Workflow

The general process involves creating a "Seed" object containing metadata and file paths, then passing that seed to `makePdInfoPackage`.

### 1. Identify Required Files
The files needed depend on the array type:
*   **Affymetrix Expression:** CDF, CEL (for geometry), and Probe Sequence (TAB).
*   **Affymetrix Exon/Gene ST:** PGF, CLF, and Probeset Annotation (CSV).
*   **Affymetrix SNP:** CDF, SNP Annotation (CSV), and Probe Sequence (TAB).
*   **Affymetrix Tiling:** BPMAP and CEL (for geometry).
*   **NimbleGen Expression:** NDF and XYS.
*   **NimbleGen Tiling:** NDF, POS, and XYS.

### 2. Create a Seed Object
Initialize the appropriate seed class for your platform.

```r
library(pdInfoBuilder)

# Example for Affymetrix Gene ST
seed <- new("AffyGenePDInfoPkgSeed",
            pgfFile = "HuGene-1_0-st-v1.r4.pgf",
            clfFile = "HuGene-1_0-st-v1.r4.clf",
            probeFile = "HuGene-1_0-st-v1.na27.2.hg18.probeset.csv",
            author = "Your Name",
            email = "user@example.com",
            biocViews = "AnnotationData",
            genomebuild = "NCBI Build 36",
            organism = "Human",
            species = "Homo Sapiens")

# Example for NimbleGen Expression
seed <- new("NgsExpressionPDInfoPkgSeed",
            ndfFile = "HG18_60mer_expr.ndf",
            xysFile = "sample.xys",
            author = "Your Name",
            biocViews = "AnnotationData",
            organism = "Human",
            species = "Homo Sapiens")
```

### 3. Build the Package
Run the builder function to generate the package directory.

```r
makePdInfoPackage(seed, destDir = ".")
```

### 4. Install the Package
The output of `makePdInfoPackage` is a source R package. You must install it to use it with `oligo`.

```r
# From R
install.packages("./pd.hugene.1.0.st.v1", repos = NULL, type = "source")
```

## Platform Specific Seeds

| Platform | Seed Class | Key Arguments |
| :--- | :--- | :--- |
| Affy Expression | `AffyExpressionPDInfoPkgSeed` | `cdfFile`, `celFile`, `tabSeqFile` |
| Affy Exon ST | `AffyExonPDInfoPkgSeed` | `pgfFile`, `clfFile`, `probeFile` |
| Affy Gene ST | `AffyGenePDInfoPkgSeed` | `pgfFile`, `clfFile`, `probeFile` |
| Affy SNP | `AffySNPPDInfoPkgSeed2` | `cdfFile`, `csvAnnoFile`, `csvSeqFile` |
| Affy Tiling | `AffyTilingPDInfoPkgSeed` | `bpmapFile`, `celFile` |
| NimbleGen Expr | `NgsExpressionPDInfoPkgSeed` | `ndfFile`, `xysFile` |
| NimbleGen Tiling| `NgsTilingPDInfoPkgSeed` | `ndfFile`, `xysFile`, `posFile` |

## Tips and Troubleshooting
*   **Memory Requirements:** Building packages for large arrays (like SNP 6.0 or Tiling) can be RAM-intensive. Ensure at least 4-8GB of RAM is available.
*   **Column Names:** If the builder fails to find required columns in CSV files, it will suggest names. Rename your CSV columns to match these suggestions.
*   **CRLMM Support:** For Human Affymetrix SNP arrays, it is highly recommended to use the pre-built Bioconductor packages, as they contain specific calibration data for the CRLMM algorithm that custom-built packages lack.
*   **CEL/XYS Files:** The intensity files (CEL/XYS) provided to the seed are used only as templates to determine the physical geometry (rows/columns) of the array.

## Reference documentation
- [Building Annotation Packages with pdInfoBuilder](./references/BuildingPDInfoPkgs.md)
- [Building a PDInfo Package for an Affymetrix Mapping Chip](./references/howto-AffymetrixMapping.md)