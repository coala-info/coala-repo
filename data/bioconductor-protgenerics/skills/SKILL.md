---
name: bioconductor-protgenerics
description: This package provides a central infrastructure of S4 generic functions and virtual classes to ensure interoperability between proteomics and mass spectrometry software. Use when user asks to define standardized data accessors, manage mass spectrometry backends, create processing steps for lazy evaluation, or implement filtering methods for spectra and features.
homepage: https://bioconductor.org/packages/release/bioc/html/ProtGenerics.html
---


# bioconductor-protgenerics

## Overview

ProtGenerics is a central infrastructure package in the Bioconductor ecosystem that defines S4 generic functions and virtual classes for proteomics and mass spectrometry. It does not provide data or specific implementations itself; instead, it provides the "vocabulary" (generics) that other packages like `Spectra`, `MSnbase`, `mzR`, and `Chromatograms` implement. Using these generics ensures that different packages can work together seamlessly (e.g., calling `mz(object)` works regardless of whether the object is from package A or package B).

## Core Infrastructure

### The Param Class
The `Param` class is a virtual base class for parameter objects.
- Use `as.list(object)` to convert parameters to a list (excluding hidden slots starting with `.`).
- Inherit from this class when creating new algorithm parameter containers to maintain Bioconductor standards.

### Processing Steps and Queues
ProtGenerics defines the framework for "lazy evaluation" of data transformations, commonly used in the `Spectra` package.
- `ProcessingStep(FUN, ARGS)`: Creates an object representing a function and its arguments to be applied later.
- `executeProcessingStep(object, ...)`: Runs the stored function on data.
- `addProcessing(object, ...)`: Adds a step to an object's internal queue.
- `applyProcessing(object, ...)`: Executes the entire queue and updates the data.

### Backend Management
For packages implementing data backends (like SQL, HDF5, or in-memory):
- `backendInitialize(object, ...)`: Standard entry point for backend setup.
- `isReadOnly(object)`: Checks if the backend supports write operations.
- `backendMerge(object, ...)`: Combines multiple backend instances.

## Common Generic Methods

When working with proteomics objects, use these standard generics instead of accessing slots directly:

### Data Accessors
- `mz(object)` / `intensity(object)`: Get mass-to-charge ratios or intensities.
- `rtime(object)`: Get retention times.
- `peaksData(object)`: Get a list or array of peak data (m/z and intensity).
- `spectra(object)` / `chromatograms(object)`: Access high-level data structures.
- `psms(object)`: Access Peptide-Spectrum Matches.
- `peptides(object)` / `proteins(object)`: Access identification data.

### Filtering
ProtGenerics defines a standard interface for subsetting data:
- `filterSpectra(object, filter, ...)`: Filter spectra based on a criteria object.
- `filterFeatures(object, filter, ...)`: Filter features (e.g., in a QFeatures or MSnSet object).
- `extractByIndex(object, i)`: Standardized integer-based indexing.

### MS Metadata
- `msLevel(object)`: Get the MS level (1, 2, etc.).
- `collisionEnergy(object)`: Get fragmentation energy.
- `isCentroided(object)`: Check if data is centroided or profile mode.
- `polarity(object)`: Get ion polarity.

## Workflow for Developers

1. **Interoperability**: If you are writing a new proteomics package, check `ProtGenerics` first before defining a new generic. If a generic like `mz()` or `tic()` already exists, import it: `importImports("ProtGenerics", "mz")`.
2. **Implementation**: Define your methods for these generics:
   ```r
   setMethod("mz", "MyNewSpectraClass", function(object) {
       # Your implementation here
   })
   ```
3. **Lazy Evaluation**: Use `ProcessingStep` to record user transformations without immediately altering large raw data files.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)