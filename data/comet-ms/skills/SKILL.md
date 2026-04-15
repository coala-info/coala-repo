---
name: comet-ms
description: Comet-ms is an open-source search engine that matches experimental mass spectra against theoretical spectra from a sequence database for proteomics data analysis. Use when user asks to perform peptide identification, generate search parameter files, or execute high-throughput database searches of mass spectrometry data.
homepage: http://comet-ms.sourceforge.net/
metadata:
  docker_image: "quay.io/biocontainers/comet-ms:2024011--hb319eff_0"
---

# comet-ms

## Overview
Comet-ms is an open-source search engine designed for high-throughput proteomics data analysis. It functions as a standalone binary that matches experimental mass spectra against theoretical spectra derived from a sequence database (typically in FASTA format). This skill provides the necessary patterns for executing searches, managing parameters, and handling the various output formats required for downstream proteomic pipelines.

## Core Usage Patterns

### Basic Search Execution
To run a search, Comet typically requires a parameter file and the input spectra files.
```bash
comet [options] <input_files>
```

### Generating and Using Parameter Files
Comet relies heavily on a `comet.params` file to define search tolerances, modifications, and database paths.
- **Generate a default params file**: `comet -p`
- **Run search with specific params**: `comet -Pmy_params.params spectrum_file.mzXML`

### Common CLI Options
- `-p`: Generate a default `comet.params` file in the current directory.
- `-P<params_file>`: Specify a custom parameter file (no space between flag and filename).
- `-D<database_file>`: Override the database path specified in the params file.
- `-N<output_name>`: Specify a base name for the output files.

## Expert Tips & Best Practices
- **Input Formats**: Comet natively supports mzXML, mzML, and raw MS/MS formats (like .mgf or .ms2). Ensure your data is converted to an open format using tools like ProteoWizard if coming from proprietary vendor formats.
- **Multithreading**: Comet is multithreaded. You can control the number of threads used via the `num_threads` setting in the `comet.params` file to optimize performance on HPC clusters or workstations.
- **Output Integration**: Since Comet is a "single-step" tool, its outputs (.pep.xml or .pin.xml) are usually intended for downstream validation tools like PeptideProphet or Percolator.
- **Memory Management**: When searching very large databases (e.g., metaproteomics), monitor RAM usage as Comet loads the index/database into memory for processing.

## Reference documentation
- [Comet MS/MS Search Overview](./references/comet-ms_sourceforge_net_index.md)
- [Bioconda comet-ms Package Details](./references/anaconda_org_channels_bioconda_packages_comet-ms_overview.md)