---
name: bioconductor-alabaster.vcf
description: This package saves and loads Bioconductor VCF objects as structured artifacts to preserve complex metadata and enable efficient storage. Use when user asks to stage VCF objects to disk, load staged VCF data back into R, or convert VariantAnnotation objects into the alabaster file format.
homepage: https://bioconductor.org/packages/release/bioc/html/alabaster.vcf.html
---


# bioconductor-alabaster.vcf

## Overview

The `alabaster.vcf` package is part of the **alabaster** ecosystem, designed to facilitate the "staging" of Bioconductor objects. While standard VCF files are common, they often lack the ability to store complex R-specific metadata (like `rowData` or `colData` decorations) and do not support efficient random access for all components. `alabaster.vcf` solves this by decomposing `CollapsedVCF` and `ExpandedVCF` objects into a structured directory of artifacts (HDF5 for assays, CSV/JSON for metadata, and BCF for headers).

## Core Workflow

### Staging a VCF Object

To save a VCF object to disk, use the `stageObject` function. This creates the necessary file structure and returns metadata that must be written to a JSON file.

```r
library(alabaster.vcf)
library(VariantAnnotation)

# 1. Prepare your VCF object
# vcf <- readVcf(fl, genome="hg19")

# 2. Define a staging directory
tmp <- tempfile()
dir.create(tmp)

# 3. Stage the object
# This creates the subdirectories and files inside 'tmp'
meta <- stageObject(vcf, tmp, path="my_vcf_data")

# 4. Write the metadata to disk
.writeMetadata(meta, tmp)
```

### Loading a Staged VCF

To reload the object, you first acquire the metadata for the specific entry and then use `loadObject`.

```r
# 1. Locate and acquire the metadata
meta <- acquireMetadata(tmp, "my_vcf_data/experiment.json")

# 2. Load the object back into R
vcf_roundtrip <- loadObject(meta, tmp)
```

## Advanced Usage

### Loading as a SummarizedExperiment

Because `VCF` objects in Bioconductor inherit from `SummarizedExperiment`, you can load the staged data using `alabaster.se` if you only need the underlying matrix and annotation data without the specific VCF class overhead.

```r
library(alabaster.se)
se <- loadSummarizedExperiment(meta, tmp)
```

### Key Components of Staged Output

When inspecting the staging directory, you will find:
- `header/header.bcf`: The VCF header information.
- `assays/`: HDF5 files containing genotype calls (GT, GQ, etc.).
- `rowranges/`: Genomic coordinates and sequence information.
- `coldata/` and `rowdata/`: Metadata for samples and variants.

## Tips and Best Practices

1. **Metadata Persistence**: Always remember to call `.writeMetadata()`. Without the `.json` files, `loadObject` will not be able to reconstruct the object.
2. **Directory Management**: The `path` argument in `stageObject` defines the subdirectory within your project folder. Use unique paths if staging multiple objects in one directory.
3. **Cross-Package Compatibility**: Data staged with `alabaster.vcf` can be read by any implementation that understands the `vcf_experiment` schema, making it useful for sharing data between R and other environments (like Python via `dolomite-vcf`).

## Reference documentation

- [Saving VCFs to artifacts and back again](./references/userguide.md)