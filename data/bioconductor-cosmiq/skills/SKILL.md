---
name: bioconductor-cosmiq
description: "bioconductor-cosmiq preprocesses liquid- or gas-chromatography mass spectrometry data to improve signal-to-noise ratios and detect peaks. Use when user asks to preprocess LCMS or GCMS data, combine mass spectra into a master spectrum, or perform peak picking using continuous wavelet transformation."
homepage: https://bioconductor.org/packages/release/bioc/html/cosmiq.html
---


# bioconductor-cosmiq

## Overview
`cosmiq` is a Bioconductor package designed for the preprocessing of liquid- or gas-chromatography mass spectrometry (LCMS/GCMS) data. It is particularly effective for high-resolution data (e.g., TOF or Q-TOF). The package improves signal-to-noise ratios (SNR) by combining mass spectra across scans and datasets to create a "master spectrum" for peak detection. It utilizes Continuous Wavelet Transformation (CWT) for robust peak picking in both the mass (m/z) and retention time (RT) domains.

## Typical Workflow

### 1. Data Initialization
`cosmiq` uses the `xcmsSet` object structure. You must first define your input files and metadata.

```R
library(cosmiq)
library(faahKO)

# Locate files
cdfpath <- file.path(find.package("faahKO"), "cdf")
my.input.files <- dir(c(paste(cdfpath, "WT", sep='/'), 
                        paste(cdfpath, "KO", sep='/')), full.names=TRUE)

# Initialize xcmsSet
xs <- new("xcmsSet")
xs@filepaths <- my.input.files
class <- as.data.frame(c(rep("KO", 6), rep("WT", 6)))
rownames(class) <- basename(my.input.files)
xs@phenoData <- class
```

### 2. The Wrapper Function
For a quick end-to-end execution, use the `cosmiq()` wrapper.

```R
# Run full pipeline
x <- cosmiq(files=my.input.files, mzbin=0.25, SNR.Th=0, linear=TRUE)

# Visualize results
image(t(x$eicmatrix), main='mz versus RT map')
head(x$xs@peaks)
```

### 3. Step-by-Step Manual Processing
If fine-tuning is required, execute the pipeline stages manually:

**A. Combine Spectra**
Overlay and sum intensities from all scans and datasets to generate a master spectrum.
```R
x_combined <- combine_spectra(xs=xs, mzbin=0.25, linear=TRUE, continuum=FALSE)
plot(x_combined$mz, x_combined$intensity, type='l')
```

**B. Detect Relevant Masses**
Identify m/z peaks on the master spectrum using CWT.
```R
xy <- peakdetection(x=x_combined$mz, y=x_combined$intensity, 
                    scales=1:10, SNR.Th=1.0, SNR.area=20, mintr=0.5)
```

**C. Retention Time Correction**
Align samples using the `obiwarp` algorithm.
```R
# Create dummy peaks for xcms compatibility
xs@peaks <- matrix(c(rep(1, length(my.input.files) * 6), 
                     1:length(my.input.files)), ncol=7)
colnames(xs@peaks) <- c("mz", "mzmin", "mzmax", "rt", "rtmin", "rtmax", "sample")

# Align
xs <- xcms::retcor(xs, method="obiwarp", profStep=1, distFunc="cor", center=1)
```

**D. Generate EIC Matrix and Detect RT Peaks**
Compute the Extracted Ion Chromatogram (EIC) matrix and identify chromatographic peaks.
```R
eicmat <- eicmatrix(xs=xs, xy=xy, center=1)

rxy <- retention_time(xs=xs, RTscales=c(1:10, seq(12,32, by=2)), 
                      xy=xy, eicmatrix=eicmat, RTSNR.Th=120, RTSNR.area=20)
```

**E. Quantify and Export**
Create the final data matrix and extract the peak table.
```R
xs <- create_datamatrix(xs=xs, rxy=rxy)
peaktable <- xcms::peakTable(xs)
```

## Key Functions
- `cosmiq()`: Main wrapper function for the entire workflow.
- `combine_spectra()`: Merges all scans into a single master spectrum to increase SNR.
- `peakdetection()`: Uses CWT to find peaks in the m/z domain.
- `eicmatrix()`: Generates a matrix of extracted ion chromatograms.
- `retention_time()`: Detects peaks in the chromatographic (RT) domain.
- `create_datamatrix()`: Quantifies features across all samples based on detected mz/RT coordinates.

## Tips
- **High Resolution**: `cosmiq` is optimized for high-accuracy mass data (FWHM > 20,000).
- **Alignment**: Because features are detected on a combined master spectrum/EIC, traditional feature alignment between runs is often unnecessary; the data matrix is calculated directly from the master list.
- **Memory**: For very large datasets, consider processing reduced m/z ranges if memory limits are reached.

## Reference documentation
- [cosmiq - COmbining Single Masses Into Quantities](./references/cosmiq.md)