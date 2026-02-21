---
name: comparems2
description: comparems2 is a lightweight tool for the global comparison of tandem mass spectrometry (MS/MS) data.
homepage: http://www.ms-utils.org/compareMS2.html
---

# comparems2

## Overview

comparems2 is a lightweight tool for the global comparison of tandem mass spectrometry (MS/MS) data. Instead of relying on peptide identification, it compares the raw MS/MS spectra between two datasets to determine their similarity. It uses a dot-product algorithm (similar to SpectraST) to calculate the relationship between pairs of spectra. This approach is highly effective for sample differentiation and phylogenetic studies where shared peptide sequences are quantified by the frequency of highly similar spectra.

## Usage Instructions

### Basic Command Structure
The tool requires two input files in Mascot Generic Format (.mgf).

```bash
compareMS2 -1 <first_dataset.mgf> -2 <second_dataset.mgf> [options]
```

### Common Options
- `-1 <filename>`: Path to the first MGF dataset (required).
- `-2 <filename>`: Path to the second MGF dataset (required).
- `-o <filename>`: Specify the output filename for the comparison results.
- `-p <tolerance>`: Set the precursor mass tolerance. This is critical for determining which spectra are candidates for comparison.

### Best Practices
- **Format Consistency**: Ensure both datasets are in MGF format. If your data is in mzML or mzXML, you must convert it to MGF first (e.g., using ProteoWizard's msconvert).
- **Precursor Tolerance**: Adjust the `-p` parameter based on the mass accuracy of the instrument used to acquire the data (e.g., use a smaller tolerance for Orbitrap data compared to TOF or Ion Trap data).
- **Experimental Conditions**: For meaningful results, compare datasets acquired under similar chromatographic and ionization conditions, as these factors significantly influence spectral patterns.

## Reference documentation
- [compareMS2 Overview](./references/anaconda_org_channels_bioconda_packages_comparems2_overview.md)
- [compareMS2 Official Documentation](./references/www_ms-utils_org_compareMS2.html.md)