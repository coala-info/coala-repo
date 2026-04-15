---
name: dinosaur
description: Dinosaur detects peptide features in MS1 mass spectrometry data. Use when user asks to detect peptide features, process mzML files, or perform isotope pattern clustering for proteomics analysis.
homepage: https://github.com/fickludd/dinosaur
metadata:
  docker_image: "quay.io/biocontainers/dinosaur:1.2.0--hdfd78af_1"
---

# dinosaur

## Overview
Dinosaur is a specialized tool for detecting peptide features in MS1 mass spectrometry data. It serves as an improved, open-source reimplementation of the MaxQuant feature-finding logic. The tool is written in Scala and runs on the JVM, processing mzML files through a multi-step pipeline that includes centroiding, hill building, and isotope pattern clustering. Use this skill to guide the extraction of high-quality features for downstream proteomics analysis.

## Installation and Setup
Dinosaur requires Java 1.8 or higher.

- **Conda (Recommended):** `conda install bioconda::dinosaur`
- **Manual:** Download the latest `.jar` file from the GitHub releases page.

## Command Line Usage
The basic syntax for running Dinosaur is:
`java -jar Dinosaur.jar [options] <input.mzML>`

### Common Execution Patterns
- **Standard Run:**
  `java -jar Dinosaur.jar --verbose --concurrency=4 data.mzML`
- **Performance Analysis:**
  `java -jar Dinosaur.jar --profiling --verbose data.mzML`
- **Help and Documentation:**
  - Basic help: `java -jar Dinosaur.jar`
  - Advanced algorithm parameters: `java -jar Dinosaur.jar --advHelp data.mzML` (Note: requires an input file to display advanced help).

## Advanced Parameter Tuning
Dinosaur allows fine-grained control over the feature-finding algorithm. Key parameters include:

- **Centroiding:** Adjust `maxIntensity` and `massEstPoints` to tweak how local maxima are detected and gaussian-fitted.
- **Hill Building:**
  - `hillPPM`: The mass tolerance (in ppm) for joining peaks across subsequent spectra.
  - `hillMaxMissing`: The number of allowed missing spectra before a "hill" is considered complete.
  - `hillBatchSize`: Number of concurrent spectra processed in a batch (default is 100).
- **Isotope Clustering:** Graphs are created by joining hills based on the expected isotope mass difference (`ISOTOPE_MASS_DIFF / z`) and correlating intensity profiles.

## Best Practices
- **Input Preparation:** Always use the mzML format. If working with vendor-specific raw files, convert them using ProteoWizard's `msconvert`.
- **Concurrency:** Match the `--concurrency` flag to the number of available CPU cores to significantly reduce processing time for large datasets.
- **Memory Management:** For very large mzML files, you may need to increase the JVM heap size using the `-Xmx` flag (e.g., `java -Xmx8G -jar Dinosaur.jar ...`).
- **Algorithm Verification:** Use the `--verbose` and `--profiling` flags during initial runs to ensure the centroiding and hill-building steps are behaving as expected for your specific instrument resolution.

## Reference documentation
- [Dinosaur Overview](./references/anaconda_org_channels_bioconda_packages_dinosaur_overview.md)
- [Dinosaur GitHub Repository](./references/github_com_fickludd_dinosaur.md)