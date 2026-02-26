---
name: isocor
description: "This tool corrects mass spectrometry data for naturally occurring isotopes and tracer purity. Use when user asks to correct mass spectrometry data for isotopic labeling experiments."
homepage: https://github.com/MetaSys-LISBP/IsoCor/
---


# isocor

yaml
name: isocor
description: |
  A scientific software for correcting mass spectrometry (MS) data for naturally occurring isotopes and tracer purity.
  Use when dealing with MS data from labeling experiments to accurately determine isotopologue distributions and mean enrichment.
  This tool is particularly useful for metabolic studies involving isotopic tracers.
```
## Overview
IsoCor is a specialized tool designed to correct mass spectrometry data for the presence of naturally occurring isotopes and the purity of isotopic tracers. It is essential for accurately analyzing data from experiments that use isotopic labeling to understand metabolic pathways and flux. IsoCor outputs the isotopologue distribution of molecules and calculates mean isotopic enrichment, making it a crucial component in metabolic flux analysis.

## Usage

IsoCor can be installed via pip and run from the command line or used as a Python library.

### Installation

Install IsoCor using pip:
```bash
pip install isocor
```

### Running IsoCor

You can launch the graphical interface with:
```bash
isocor
```

IsoCor is also available directly from the command line and as a Python library. For command-line usage, refer to the official documentation for specific parameters and input formats.

### Key Features

*   **Correction of naturally occurring isotopes**: Accounts for isotopes of both non-tracer and tracer elements.
*   **Correction of tracer purity**: Adjusts for the purity of the isotopic tracer used.
*   **Mass-spectrometer and resolution agnostic**: Applicable to various MS instruments and resolutions.
*   **Singly- and multiply-charged ions**: Supports both types of ions.
*   **Any tracer element**: Can be used with any element having two or more isotopes.
*   **Derivatization contribution**: Accounts for the impact of derivatization steps.
*   **Isotopic InChIs**: Generates isotopic InChIs for tracer isotopologues.

## Expert Tips

*   **Consult the documentation**: For detailed usage instructions, parameter explanations, and advanced options, always refer to the official IsoCor documentation at [isocor.readthedocs.io](https://isocor.readthedocs.io/).
*   **Explore tutorials**: The documentation includes tutorials that guide you through selecting the best correction options for your specific experiments.
*   **Understand your data**: Ensure you have a clear understanding of your mass spectrometry data, including the elements involved, tracer isotopes, and any potential derivatization steps, to effectively configure IsoCor.

## Reference documentation
- [IsoCor Documentation](https://isocor.readthedocs.io/)
- [IsoCor GitHub Repository](https://github.com/MetaSys-LISBP/IsoCor/)