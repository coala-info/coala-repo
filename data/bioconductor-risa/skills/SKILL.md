---
name: bioconductor-risa
description: This tool processes Investigation/Study/Assay (ISA-Tab) metadata files in R for experimental data management. Use when user asks to read ISA-Tab datasets, convert them into R objects, integrate metadata with xcms for mass spectrometry analysis, or update and write ISA-Tab files.
homepage: https://bioconductor.org/packages/3.5/bioc/html/Risa.html
---

# bioconductor-risa

name: bioconductor-risa
description: Processing Investigation/Study/Assay (ISA-Tab) metadata files in R. Use this skill to read ISA-Tab datasets, convert them into R objects (ISAtab class), integrate with xcms for mass spectrometry analysis, and update or write ISA-Tab metadata files.

# bioconductor-risa

## Overview

The `Risa` package allows R users to work with the Investigation/Study/Assay (ISA-Tab) format, a standard for capturing experimental metadata across various "omics" technologies. It transforms complex metadata collections (Investigation, Study, and Assay files) into structured R objects that can be used for downstream analysis, particularly in metabolomics and proteomics.

## Core Workflows

### Loading ISA-Tab Data

To read an ISA-Tab dataset from a local directory or a zip archive:

```R
library(Risa)

# From a directory
isa_obj <- readISAtab(path = "path/to/isa-directory")

# From a zip file
isa_obj <- readISAtab(zipfile = "experiment.zip", path = "extraction_dir")
```

The resulting object is of class `ISAtab`. You can access its slots (e.g., `isa_obj["assay.filenames"]`) to inspect the experimental structure.

### Integration with xcms

`Risa` provides a direct bridge to the `xcms` package for mass spectrometry data processing.

```R
# Identify the assay file of interest
assay_file <- isa_obj["assay.filenames"][1]

# Build an xcmsSet object using metadata from the ISA-Tab
xcms_set <- processAssayXcmsSet(isa_obj, assay_file)
```

### Updating Metadata

You can programmatically update metadata columns (e.g., adding paths to processed data files) within the ISA object.

```R
# Update a specific column in an assay file
updateAssayMetadata(isa_obj, 
                    assay.filename = "a_metabolite.txt", 
                    col.name = "Derived Spectral Data File", 
                    values = "results_file.txt")
```

### Writing ISA-Tab Files

After modification, you can write the updated ISA-Tab structure back to disk.

```R
# Write the entire ISA-Tab dataset
write.ISAtab(isa_obj, path = "output_directory")

# Or write specific components
write.assay.file(isa_obj, "a_metabolite.txt", path = "output_directory")
```

## Key ISAtab Object Slots

- `investigation.file`: Data frame containing the investigation overview.
- `study.files`: List of data frames for each study.
- `assay.files`: List of data frames for each assay.
- `data.filenames`: List of raw and processed data file names.
- `samples`: List of all sample names in the experiment.
- `sample.to.rawdatafile`: Mapping between samples and their corresponding raw data.

## Tips for Success

- **File Naming**: Ensure ISA-Tab files follow the standard prefixes: `i_` for Investigation, `s_` for Study, and `a_` for Assay.
- **Zip Structure**: When reading from a zip file, ensure the ISA-Tab files are at the root of the archive, not nested inside subfolders.
- **Downstream Compatibility**: The `ISAtab` object is designed to facilitate the creation of `ExpressionSet` or `xcmsSet` objects; always check the `assay.technology.types` slot to confirm the data type before processing.

## Reference documentation

- [Risa: Building R objects from local ISA-Tab files](./references/Risa.md)