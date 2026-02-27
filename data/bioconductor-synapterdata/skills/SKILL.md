---
name: bioconductor-synapterdata
description: This package provides experimental mass spectrometry datasets and example files for the synapter proteomics workflow. Use when user asks to access example LC-MS data, load pre-processed Synapter objects, or run the synapter vignette.
homepage: https://bioconductor.org/packages/release/data/experiment/html/synapterdata.html
---


# bioconductor-synapterdata

name: bioconductor-synapterdata
description: Data package for the synapter package, providing experimental mass spectrometry data for spatial proteomics and ion mobility-resolved label-free quantitative proteomics. Use this skill when a user needs to access, load, or use the example datasets (PLGS and MSe results) required for the synapter workflow or vignettes.

# bioconductor-synapterdata

## Overview
The `synapterdata` package is a dedicated experiment data package for the `synapter` software. It contains liquid chromatography-mass spectrometry (LC-MS) data used to demonstrate the functionality of the `synapter` package, specifically for re-processing and improving the identification and quantification of MSe data. It provides pre-processed data from a spiked-in mixture (UPS1 protein mix in a yeast background) to facilitate testing and learning the synapter pipeline.

## Loading the Data
To use the datasets provided by this package, you must first load the library and then use the `load` or `data` functions, or access the file paths directly using `system.file`.

```r
# Load the package
library(synapterdata)

# List available data files in the package
dir(system.file("exdata", package = "synapterdata"))
```

## Typical Workflow Integration
The primary use of `synapterdata` is to provide inputs for the `synapter` package functions. The package includes several types of files:

1.  **Identification Files**: PLGS (ProteinLynx Global SERVER) output files.
2.  **Quantitation Files**: MSe analysis files.
3.  **Fasta Files**: Sequence databases used for the analysis.

### Accessing Example Files
Use `getFasta()`, `getIdent()`, and `getQuant()` to retrieve the paths to the example data:

```r
# Get path to the example FASTA file
fasta_path <- getFasta()

# Get paths to identification (PLGS) files
ident_paths <- getIdent()

# Get paths to quantitation (MSe) files
quant_paths <- getQuant()
```

### Using with synapter
These paths are typically passed to the `synergise` function or the `Synapter` class constructor:

```r
library(synapter)

# Example: Running the synergise analysis with synapterdata
output_dir <- tempdir()
synergise(object = getIdent()[1], 
          quantfile = getQuant()[1], 
          fastafile = getFasta(),
          outputDir = output_dir)
```

## Available Datasets
The package provides specific objects that can be loaded directly into the R session:

- `ups250`: A `Synapter` object containing data for 250ng of UPS1.
- `ups500`: A `Synapter` object containing data for 500ng of UPS1.
- `master`: A `Master` object used for combining multiple identification files.

```r
# Load a pre-processed Synapter object
data(ups250)
summary(ups250)
```

## Tips
- This package is large because it contains raw-ish experimental data; ensure you have sufficient disk space during installation.
- Use `synapterdata` primarily for benchmarking your `synapter` installation or following the official `synapter` vignette.
- The data represents a controlled spike-in experiment (Universal Proteomics Standard - UPS1), which is ideal for calculating false discovery rates (FDR) and performance metrics.

## Reference documentation
- [synapter Bioconductor page](https://bioconductor.org/packages/release/bioc/html/synapter.html)
- [synapterdata Bioconductor page](https://bioconductor.org/packages/release/data/experiment/html/synapterdata.html)