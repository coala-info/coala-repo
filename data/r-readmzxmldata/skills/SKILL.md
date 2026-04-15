---
name: r-readmzxmldata
description: The readMzXmlData package extracts mass spectrometry spectral data and metadata from mzXML files. Use when user asks to read mzXML files, import mass spectrometry data from a directory, or extract spectral information for MALDIquant analysis.
homepage: https://cloud.r-project.org/web/packages/readMzXmlData/index.html
---

# r-readmzxmldata

## Overview
The `readMzXmlData` package provides functions to read mass spectrometry data stored in the mzXML format. It extracts both the spectral data (mass-to-charge ratios and intensities) and associated metadata. It is particularly useful as a data provider for the `MALDIquant` framework.

## Installation
```R
install.packages("readMzXmlData")
```

## Main Functions

### readMzXmlFile
Reads a single mzXML file.
```R
library(readMzXmlData)
spec <- readMzXmlFile("path/to/file.mzXML", removeMetaData = FALSE)

# Accessing data
mass <- spec$spectrum$mass
intensity <- spec$spectrum$intensity
meta <- spec$metaData
```

### readMzXmlDir
Reads all mzXML files in a directory recursively.
```R
specs <- readMzXmlDir("path/to/directory", 
                      fileExtension = "mzXML", 
                      removeCalibrationScans = TRUE)

# Returns a list where each element is a spectrum object
first_spec_mass <- specs[[1]]$spectrum$mass
```

## Workflows

### Basic Plotting
```R
spec <- readMzXmlFile("sample.mzXML")
plot(spec$spectrum$mass, spec$spectrum$intensity, 
     type = "l", xlab = "m/z", ylab = "Intensity",
     main = spec$metaData$file)
```

### Processing Multiple Files
```R
# Read all files
all_specs <- readMzXmlDir("data_folder/")

# Extract base names for legend
file_names <- sapply(all_specs, function(x) basename(x$metaData$file))

# Plot first spectrum and add others
plot(all_specs[[1]]$spectrum$mass, all_specs[[1]]$spectrum$intensity, type = "l")
for(i in 2:length(all_specs)) {
  lines(all_specs[[i]]$spectrum$mass, all_specs[[i]]$spectrum$intensity, col = i)
}
```

## Tips
- **Memory Management**: If you are loading a large number of files and do not need the headers/metadata, set `removeMetaData = TRUE` to save RAM.
- **File Extensions**: While "mzXML" is standard, some vendors or converters use "xml". Use the `fileExtension` argument in `readMzXmlDir` to handle this.
- **Calibration Scans**: `readMzXmlDir` automatically ignores directories named "Calibration" by default (`removeCalibrationScans = TRUE`). Set to `FALSE` if those scans are required.
- **MALDIquant Integration**: This package is designed to work seamlessly with `MALDIquant`. Use `mqReadMzXml` for direct compatibility.

## Reference documentation
- [Package Manual](./references/reference_manual.md)