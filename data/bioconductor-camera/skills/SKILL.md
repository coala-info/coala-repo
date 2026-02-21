---
name: bioconductor-camera
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/CAMERA.html
---

# bioconductor-camera

## Overview

CAMERA (Collection of Algorithms for MEtabolite pRofile Annotation) is a Bioconductor package for the post-processing of LC-MS data. It performs deconvolution of co-eluting substances by grouping peaks into "pseudospectra" based on retention time and peak shape correlation. It then annotates these groups for isotopes and adducts (e.g., [M+H]+, [M+Na]+), allowing for the calculation of neutral molecular masses.

## Core Workflow

The standard workflow transforms an `xcmsSet` (or `XcmsExperiment`) object into an `xsAnnotate` object, followed by sequential grouping and annotation steps.

### 1. Initialization and Grouping
Create the CAMERA object and perform initial grouping based on retention time (FWHM).

```R
library(CAMERA)

# Initialize with an xcmsSet object (xs)
an <- xsAnnotate(xs)

# Group peaks by retention time
an <- groupFWHM(an, perfwhm = 0.6)
```

### 2. Refinement and Correlation
Refine groups using peak shape correlation across samples to separate co-eluting compounds.

```R
# Verify grouping with EIC correlation
# cor_eic_th is the correlation threshold (0-1)
an <- groupCorr(an, cor_eic_th = 0.75)
```

### 3. Annotation
Identify isotopes and adducts within the pseudospectra.

```R
# Annotate isotopes
an <- findIsotopes(an, mzabs = 0.01)

# Annotate adducts (specify polarity: "positive" or "negative")
an <- findAdducts(an, polarity="positive")
```

### 4. Exporting Results
Extract the annotated peak table for downstream analysis.

```R
# Get the final peaklist
peaklist <- getPeaklist(an)

# Save to CSV
write.csv(peaklist, file="camera_results.csv")
```

## Advanced Features

### Wrapper Functions
For a streamlined analysis, use the `annotate` wrapper which runs the standard workflow in one command.

```R
# Full annotation run
xsa <- annotate(xs, polarity="positive")
```

### Integration with xcms diffreport
Combine CAMERA annotations with statistical results from xcms.

```R
# Requires a filled xcmsSet
diffreport <- annotateDiffreport(xs.fill, polarity="positive")
```

### Isotope Validation
Use database-specific statistics (e.g., KEGG) to validate putative isotope clusters.

```R
# Advanced isotope detection with validation
an <- findIsotopesWithValidation(an, ppm = 10, maxcharge = 3)
```

### Visualization
Inspect pseudospectra and extracted ion chromatograms (EICs).

```R
# Plot EICs for pseudospectrum index 2
plotEICs(an, pspec = 2)

# Plot the mass spectrum for pseudospectrum index 2
plotPsSpectrum(an, pspec = 2, maxlabel = 5)
```

## Tips for Success

- **Order Matters**: Always run `groupFWHM` before `groupCorr` to avoid extremely long runtimes.
- **Polarity**: Ensure the `polarity` argument in `findAdducts` matches your experimental settings.
- **Rule Tables**: CAMERA uses default adduct rules. You can provide custom rules via the `rules` parameter in `findAdducts` using `read.csv()` on the package's internal rule files.
- **Pseudospectra**: The `pcgroup` column in the final peaklist indicates which peaks CAMERA believes belong to the same molecule.

## Reference documentation

- [LC-MS Peak Annotation and Identification with CAMERA](./references/CAMERA.md)
- [Isotope cluster detection and validation](./references/IsotopeDetectionVignette.md)
- [Atom count expectations with compoundQuantiles](./references/compoundQuantilesVignette.md)