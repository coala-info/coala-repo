---
name: hardklor
description: "Hardklor deconvolves complex mass spectra to identify overlapping isotopic distributions and assign monoisotopic masses. Use when user asks to deconvolve mass spectra, identify molecular features in high-resolution data, or reduce isotopic distributions to monoisotopic mass assignments."
homepage: https://github.com/mhoopmann/hardklor
---


# hardklor

## Overview
Hardklor is a specialized algorithmic tool used to deconvolve complex mass spectra. It identifies overlapping isotopic distributions and reduces them to single monoisotopic mass assignments. By utilizing the Mercury algorithm and averagine models, it determines the charge state and intensity of features in high-resolution data. It is particularly effective as a preprocessing step to transform raw signal data into a list of discrete molecular features, supporting various input formats including mzXML and compressed MSToolkit formats.

## Command Line Usage and Patterns

Hardklor typically operates using a configuration file or direct command-line arguments.

### Basic Execution
To run Hardklor with a configuration file:
`hardklor Hardklor.conf`

To run with specific parameters via CLI:
`hardklor -p [parameter_file] [input_file]`

### Common CLI Flags
- `-c`: Use when reading centroided data. This disables signal-to-noise (S/N) processing, which is unnecessary for pre-centroided peaks.
- `-xml true`: Generates output in XML format instead of the default text format.
- `-ro true`: Enables "Reduced Output," which provides a more concise summary of identified features.
- `-da`: Toggles the output to show isotope distribution area instead of the base isotope peak intensity.
- `-mol [formula]`: Allows the substitution of a user-defined molecule for the default averagine model (e.g., for specific chemical contexts).

### Configuration Best Practices
- **Signal-to-Noise (S/N) Optimization**: For Orbitrap or LTQ-FT data, set a static S/N cutoff to optimize processing speed and feature detection accuracy.
- **Sensitivity Levels**: Adjust the sensitivity parameter when working with low-abundance peptides. Higher sensitivity levels improve detection of faint signals but may increase false positives.
- **Mass Range Boundaries**: Use the `molecule_max_mz` parameter to set the upper boundary for feature detection, preventing the algorithm from attempting to fit models to noise in high m/z regions.
- **File Paths**: If filenames or paths contain spaces, ensure the entire path is contained within double quotes.

### Data Formats
Hardklor supports several mass spectrometry formats via the MSToolkit library:
- **mzXML**: Standard open format for MS data.
- **.ms1 / .ms2**: Standard text-based MS formats.
- **.cms1 / .cms2**: Compressed versions of MS1/MS2 files for efficient storage.

## Expert Tips
- **Memory Management**: In long-running batch analyses, ensure you are using version 2.3.0 or later, as these versions include specific fixes for memory flushing between analysis rounds.
- **Centroiding High m/z**: If analyzing peaks beyond 2000 m/z, ensure the centroiding algorithm is configured correctly; older versions had limitations in this range that were resolved in version 2.3.2.
- **Chromatographic Persistence**: Hardklor can operate on the assumption that valid signals persist over multiple adjacent spectra. Use the signal detection algorithms to filter out transient noise that does not appear in consecutive scans.

## Reference documentation
- [Hardklor Overview](./references/anaconda_org_channels_bioconda_packages_hardklor_overview.md)
- [Hardklor GitHub README](./references/github_com_mhoopmann_hardklor.md)