---
name: bioconductor-mtbls2
description: This package provides access to the MTBLS2 metabolomics dataset containing LC/MS-based profiling data of Arabidopsis thaliana. Use when user asks to perform comparative profiling of indole-3-acetaldoxime biosynthesis, access raw mzData files for metabolomics testing, or utilize a sample xcmsSet object for workflow benchmarking.
homepage: https://bioconductor.org/packages/release/data/experiment/html/mtbls2.html
---


# bioconductor-mtbls2

name: bioconductor-mtbls2
description: Access and utilize the MTBLS2 metabolomics dataset from Bioconductor. Use this skill when you need to perform comparative LC/MS-based profiling analysis, specifically regarding Indole-3-acetaldoxime (IAOx) biosynthesis in Arabidopsis thaliana, or when you need a sample xcmsSet object for testing metabolomics workflows.

## Overview

The `mtbls2` package is a Bioconductor experiment data package containing LC/MS-based profiling data of silver nitrate-treated *Arabidopsis thaliana* leaves. It compares wild-type plants with `cyp79B2 cyp79B3` double knockout plants, which are impaired in converting tryptophan to indole-3-acetaldoxime (IAOx). The package provides a pre-processed `xcmsSet` object and the underlying raw `mzData` files, making it a standard reference for indolic secondary metabolite research and metabolomics software benchmarking.

## Loading the Data

To use the dataset, load the package and use the `data()` function:

```r
library(mtbls2)
data(mtbls2)

# The object is named 'mtbls2' (or 'mtbls2Set' in some versions)
# It is a formal class 'xcmsSet'
show(mtbls2)
```

## Accessing Raw Files

The package includes the original `mzData` files. You can locate them on your system to perform custom peak picking or raw data inspection:

```r
# Get the path to the mzData directory
filepath <- file.path(find.package("mtbls2"), "mzData")

# List the available mzData files
list.files(filepath, recursive = TRUE)

# Access a specific raw file using xcms
if (require(xcms)) {
    raw_file_path <- filepaths(mtbls2)[1]
    xr <- xcmsRaw(raw_file_path, profmethod = "bin", profstep = 0.1)
    print(xr)
}
```

## Workflow Integration

The `mtbls2` object is an `xcmsSet` object, which is compatible with several Bioconductor tools for metabolomics analysis:

1.  **xcms**: Use for peak grouping, retention time correction, and filling missing peaks.
2.  **CAMERA**: Use for annotation of isotopes and adducts.
3.  **MSnbase**: Use for converting to modern `XCMSnExp` or `OnDiskMSnExp` objects.

### Example: Phenotype Information
The dataset includes 16 observations with two factors: genotype (Col-0 vs cyp79) and replicate (Exp1 vs Exp2).

```r
# View sample metadata
phenoData(mtbls2)

# Access specific factors
genotypes <- mtbls2@phenoData$Factor.Value.genotype.
table(genotypes)
```

## Tips for Usage

- **Object Name**: While the data is loaded via `data(mtbls2)`, the resulting object in the workspace is typically an `xcmsSet` named `mtbls2`.
- **Ionization**: The data was collected in **positive ionization mode**.
- **Legacy Format**: The object is an `xcmsSet` (legacy xcms). If using `xcms` version 3+, you may want to convert it to an `XCMSnExp` object using `as(mtbls2, "XCMSnExp")` for modern workflows.

## Reference documentation

- [MetaboLights MTBLS2 Reference Manual](./references/reference_manual.md)