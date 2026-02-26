---
name: perl-metabolomics-fragment-annotation
description: This tool annotates mass spectrometry fragmentation patterns by matching experimental peaks against theoretical chemical masses. Use when user asks to interpret MS/MS spectra, calculate exact masses for fragments, or automate the identification of chemical substructures in metabolomics datasets.
homepage: https://metacpan.org/pod/Metabolomics::Fragment::Annotation
---


# perl-metabolomics-fragment-annotation

## Overview
This skill provides guidance on using the `perl-metabolomics-fragment-annotation` tool to interpret mass spectrometry fragmentation patterns. It facilitates the chemical annotation of fragments by calculating theoretical masses and matching them against experimental peaks. Use this tool when you need to automate the identification of substructures or specific losses within metabolomics datasets.

## Usage Guidelines

### Installation
The tool is primarily distributed via Bioconda. Ensure your environment is configured with the bioconda channel.
```bash
conda install -c bioconda perl-metabolomics-fragment-annotation
```

### Core Functionality
The package functions as a Perl extension (`Metabolomics::Fragment::Annotation`). While it can be invoked via custom Perl scripts, it is often used to:
- Perform exact mass calculations for fragments.
- Annotate MS/MS spectra based on predefined fragmentation rules.
- Handle chemical formulas and isotope patterns relevant to small molecule metabolomics.

### Common Patterns
When using the library in a script, focus on the following objects:
- **Fragment Objects**: Define the core chemical entity being analyzed.
- **Annotation Engines**: Match experimental m/z values to theoretical fragments within a specified mass tolerance (ppm or Da).

### Best Practices
- **Mass Tolerance**: Always define a strict mass tolerance (e.g., 5-10 ppm for high-resolution Orbitrap or Q-TOF data) to reduce false positive annotations.
- **Adduct Awareness**: Ensure that the fragment calculations account for the correct ionization mode (positive vs. negative) and potential adducts (H+, Na+, etc.).
- **Data Pre-processing**: Clean your peak lists (de-isotoping and de-noising) before passing them to the annotation engine for better accuracy.

## Reference documentation
- [Metabolomics::Fragment::Annotation Documentation](./references/metacpan_org_pod_Metabolomics__Fragment__Annotation.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-metabolomics-fragment-annotation_overview.md)