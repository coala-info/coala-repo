---
name: bioconductor-crcl18
description: This package provides matched mRNA and miRNA expression profiles for 18 colorectal cancer cell lines classified by the CRC-Assigner system. Use when user asks to access colorectal cancer cell line datasets, analyze mRNA or miRNA expression profiles, or perform cross-platform data integration for CRC-Assigner subtypes.
homepage: https://bioconductor.org/packages/release/data/experiment/html/CRCL18.html
---


# bioconductor-crcl18

name: bioconductor-crcl18
description: A specialized skill for working with the CRCL18 Bioconductor package. Use this skill when you need to access and analyze mRNA and miRNA expression profiles for 18 colorectal cancer (CRC) cell lines classified by the CRC-Assigner system. This is essential for colorectal cancer research, molecular characterization, and cross-platform (mRNA/miRNA) data integration studies.

# bioconductor-crcl18

## Overview
The `CRCL18` package is a Bioconductor data experiment package providing high-throughput molecular profiles of 18 colorectal cancer cell lines. It includes matched mRNA (Illumina BeadChip) and miRNA (Illumina smallTruSeq) expression data, along with phenotypic information such as CRC-Assigner classifications.

## Loading the Package and Data
To use the dataset, load the library and use the `data()` function to bring the ExpressionSet objects into the R environment.

```r
# Load the package
library(CRCL18)

# Load mRNA expression data (ExpressionSet)
data(CRCLmrna)

# Load miRNA expression data (ExpressionSet)
data(CRCLmirna)
```

## Working with the Data Objects
The data is stored as `ExpressionSet` objects. You can interact with them using standard Biobase methods:

### mRNA Data (`CRCLmrna`)
- **Expression Matrix**: `exprs(CRCLmrna)` - Contains mRNA expression values.
- **Phenotype Data**: `pData(CRCLmrna)` - Contains sample information, including CRC-Assigner subtypes.
- **Feature Data**: `fData(CRCLmrna)` - Contains probe/gene information.

### miRNA Data (`CRCLmirna`)
- **Expression Matrix**: `exprs(CRCLmirna)` - Contains miRNA expression values.
- **Phenotype Data**: `pData(CRCLmirna)` - Contains sample information.
- **Feature Data**: `fData(CRCLmirna)` - Contains miRNA probe information.

## Typical Workflow
1. **Exploration**: Check the dimensions and sample metadata to understand the cohort.
   ```r
   dim(CRCLmrna)
   head(pData(CRCLmrna))
   ```
2. **Subtype Analysis**: Group samples based on the CRC-Assigner classification found in the phenoData.
3. **Integration**: Since both mRNA and miRNA data are available for the same 18 cell lines, you can perform correlation analysis or integrative clustering between the two molecular levels.

## Tips
- Ensure the `Biobase` package is loaded to utilize accessor functions like `exprs()` and `pData()`.
- The cell lines are classified according to the CRC-Assigner system, which is useful for studying subtype-specific molecular signatures.

## Reference documentation
- [CRC line line 18 dataset](./references/CRCL18Vignette.md)