---
name: easypqp
description: EasyPQP is a specialized tool for generating peptide query parameter libraries used in OpenSWATH workflows.
homepage: https://github.com/grosenberger/easypqp
---

# easypqp

## Overview
EasyPQP is a specialized tool for generating peptide query parameter libraries used in OpenSWATH workflows. It processes search engine outputs (pepXML, idXML, TSV) and applies statistical validation (via PyProphet) and calibration (RT and Ion Mobility) to produce high-quality spectral libraries. It also supports in-silico library generation using deep learning models for RT and fragment intensity prediction.

## Command Line Interface
EasyPQP provides several subcommands for different stages of the library generation pipeline.

### Core Commands
- `easypqp convert`: Converts search engine results (e.g., pepXML) into the internal format.
- `easypqp library`: Generates a spectral library from converted files, including RT calibration.
- `easypqp insilico-library`: Generates a library directly from a FASTA file using deep learning predictors.
- `easypqp convertsage`: Specifically handles Sage search engine TSV outputs.
- `easypqp convertpsm`: Converts Peptide-Spectrum Matches (PSMs).

### In-Silico Library Generation
To generate a library from a FASTA file, use the `insilico-library` command. This requires the `easypqp[all]` or `easypqp[rust]` installation.

```bash
easypqp insilico-library --fasta your_proteome.fasta --output_file insilico_library.tsv
```

**Note on Models:** If specific feature generators are not defined in a configuration, EasyPQP automatically downloads and uses:
- **RT:** `rt_cnn_tf` (CNN-Transformer)
- **CCS:** `ccs_cnn_tf` (CNN-Transformer)
- **MS2:** `ms2_bert` (BERT-based)

### Utility Commands
- `easypqp reduce`: Reduces the size of a library.
- `easypqp filter-unimod`: Restricts the UniMod database for specific modifications and site-specificities.
- `easypqp openswath-assay-generator`: Generates assays specifically formatted for OpenSWATH.
- `easypqp openswath-decoy-generator`: Generates decoy sequences for FDR estimation.

## Best Practices
- **Installation:** Always install in a Python virtual environment. Use `pip install easypqp[all]` to ensure all optional features like `easypqp_rs` (for in-silico generation) and `pyprophet` (for validation) are available.
- **Calibration:** Ensure you provide internal or external standards for retention time and ion mobility calibration to ensure consistency across runs.
- **PTM Handling:** When working with Post-Translational Modifications, use `filter-unimod` to restrict the search space to modifications of interest, which improves search speed and reduces false positives.
- **Run-Specific Libraries:** In addition to cumulative libraries, generate run-specific libraries to facilitate non-linear RT alignment within OpenSWATH.

## Reference documentation
- [EasyPQP GitHub Repository](./references/github_com_grosenberger_easypqp.md)
- [EasyPQP Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_easypqp_overview.md)