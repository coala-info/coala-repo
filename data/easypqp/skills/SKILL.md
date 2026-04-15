---
name: easypqp
description: EasyPQP generates and calibrates peptide query parameters and spectral libraries for targeted proteomics analysis. Use when user asks to generate libraries from search results, convert Sage or pepXML files, create in-silico libraries from FASTA files, or prepare assays and decoys for OpenSWATH.
homepage: https://github.com/grosenberger/easypqp
metadata:
  docker_image: "quay.io/biocontainers/easypqp:0.1.56--pyhdfd78af_0"
---

# easypqp

## Overview
EasyPQP is a specialized tool designed to simplify and accelerate the generation of peptide query parameters for OpenSWATH. It acts as a bridge between database search engines (like MSFragger or Sage) and targeted proteomics analysis. The tool handles the conversion of various identification formats (pepXML, idXML, TSV), performs statistical validation via PyProphet or PeptideProphet, and calibrates retention times (RT) and ion mobilities (IM). It is particularly useful for creating both cumulative and run-specific libraries required for non-linear RT alignment.

## Common CLI Patterns

### Library Generation
The primary workflow involves generating a library from search results.
```bash
# Generate a library from pepXML and mzXML files
easypqp library --psm results.pepXML --spectra data.mzXML --output_file library.pqp
```

### Sage Integration
For Sage search results, use the dedicated parser which supports memory-efficient streaming for large datasets.
```bash
# Convert Sage results to EasyPQP format
easypqp convertsage --psm results.sage.tsv --report results.json --output_file converted.tsv

# Use streaming for large files (>2GB)
easypqp convertsage --psm large_results.sage.tsv --streaming
```

### In-Silico Library Generation
Generate predicted libraries directly from FASTA files using deep learning models for RT, CCS, and MS2 intensity.
```bash
# Generate in-silico library from FASTA
easypqp insilico-library --fasta proteome.fasta --output_file predicted.tsv
```

### Utility Commands
EasyPQP includes several sub-commands for downstream OpenSWATH preparation:
- `openswath-assay-generator`: Create assays from a PQP library.
- `openswath-decoy-generator`: Generate decoys for the library.
- `filter-unimod`: Restrict PTMs based on UniMod specifications.
- `reduce`: Downsample or filter libraries.

## Expert Tips and Best Practices

- **Full Installation**: Always install with the `[all]` extra (`pip install easypqp[all]`) to ensure `easypqp_rs` and `pyprophet` are available for in-silico generation and statistical validation.
- **Calibration**: When generating libraries, ensure you provide internal or external standards for RT and IM calibration to improve OpenSWATH alignment performance.
- **In-Silico Models**: If no specific models are provided in a config file for `insilico-library`, EasyPQP automatically downloads pretrained CNN-Transformer models (RT/CCS) and BERT-based models (MS2).
- **Deterministic Testing**: If using EasyPQP in a CI/CD pipeline, note that the `convertsage` command can have timestamps removed from output for deterministic validation.
- **Path Handling**: For in-silico tasks, use absolute paths for configuration files to avoid resolution errors during model loading.



## Subcommands

| Command | Description |
|---------|-------------|
| easypqp convert | Convert pepXML files for EasyPQP |
| easypqp convertpsm | Convert psm.tsv files for EasyPQP |
| easypqp library | Generate EasyPQP library |
| easypqp openswath-assay-generator | Generates filtered and optimized assays for OpenSwathWorflow |
| easypqp openswath-decoy-generator | Generate decoys for spectral libraries / transition files for targeted proteomics and metabolomics analysis. |
| easypqp_convertsage | Convert Sage Search results for EasyPQP |
| easypqp_filter-unimod | Filter unimodified peptides from a PQP file. |
| easypqp_insilico-library | Generate In-Silico Predicted Library |
| easypqp_reduce | Reduce PQP files for OpenSWATH linear and non-linear alignment |
| easypqp_targeted-file-converter | Convert different spectral libraries / transition files for targeted proteomics and metabolomics analysis. |

## Reference documentation
- [EasyPQP: Simple library generation for OpenSWATH](./references/github_com_grosenberger_easypqp_blob_master_README.md)
- [EasyPQP Changelog and Version History](./references/github_com_grosenberger_easypqp_blob_master_CHANGELOG.md)