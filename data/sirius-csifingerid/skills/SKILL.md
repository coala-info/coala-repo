---
name: sirius-csifingerid
description: This skill provides guidance for using the SIRIUS software suite to process tandem mass spectra.
homepage: https://bio.informatik.uni-jena.de/software/sirius/
---

# sirius-csifingerid

## Overview
This skill provides guidance for using the SIRIUS software suite to process tandem mass spectra. It enables the transformation of raw LC-MS/MS data into structural information by identifying molecular formulas, predicting molecular fingerprints, and classifying unknown metabolites. Use this when you need to perform high-confidence structural annotation of metabolites that may be absent from standard spectral libraries.

## Core Workflows and CLI Patterns

### Initializing and Account Management
SIRIUS requires a user account for web service integration (CSI:FingerID, CANOPUS).
- **Login**: `sirius login`
- **Status**: Check your current quota and account status using the CLI to ensure web services are reachable.

### Molecular Formula and Fragmentation Trees
The primary entry point for analysis is computing fragmentation trees and ranking molecular formulas.
- **Basic Analysis**: Use the `formula` command to calculate molecular formulas from MS/MS spectra.
- **Fragmentation Trees**: SIRIUS automatically generates hypothetical fragmentation trees where nodes are molecular formulas and edges are fragmentation events (losses).
- **Isotope Patterns**: The tool ranks formulas by comparing theoretical and observed isotope patterns in high-resolution data.

### Structural Annotation (CSI:FingerID)
Once formulas are identified, use CSI:FingerID to search structure databases.
- **Fingerprint Prediction**: Predicts molecular fingerprints from fragmentation trees.
- **Database Search**: Searches predicted fingerprints against molecular structure databases to identify the most likely candidate.
- **COSMIC**: Use for high-confidence structural annotation of "unknown unknowns" not found in traditional libraries.

### Advanced Modules
- **ZODIAC**: Use for database-independent molecular formula annotation. It improves ranking by considering the entire LC-MS/MS run using Gibbs sampling.
- **CANOPUS**: Use for systematic classification of metabolites into chemical classes (e.g., using ClassyFire taxonomy) directly from MS/MS spectra, even when no structure hit is found.
- **MSNovelist**: Use for de novo structure generation when searching databases yields no satisfactory results.

### Expert Tips
- **Input Formats**: SIRIUS typically processes `.ms`, `.mgf`, or `.xml` files. Ensure your peak lists include accurate mass and intensity.
- **Ionization Modes**: Always specify the correct ionization mode (positive/negative) as predictors are mode-specific.
- **Web Services**: Most advanced features (CSI:FingerID, CANOPUS) require an active internet connection to communicate with the Jena university servers.
- **Citations**: If using specific modules, cite the corresponding paper (e.g., Dührkop et al. 2019 for SIRIUS 4, Hoffmann et al. 2022 for COSMIC).

## Reference documentation
- [SIRIUS Overview and Methods](./references/bio_informatik_uni-jena_de_software_sirius.md)
- [Bioconda Package Information](./references/anaconda_org_channels_bioconda_packages_sirius-csifingerid_overview.md)