---
name: metabolome-annotation-workflow-maw
description: This CWL workflow performs metabolome annotation on MS2 .mzML data files by integrating spectral dereplication via the R Spectra package with compound database searching through SIRIUS or MetFrag and RDKit-based candidate selection. Use this skill when identifying unknown metabolites from mass spectrometry data to characterize the chemical diversity and metabolic profiles of biological samples.
homepage: https://workflowhub.eu/workflows/510
metadata:
  docker_image: "N/A"
---

# metabolome-annotation-workflow-maw

## Overview

The [Metabolome Annotation Workflow (MAW)](https://workflowhub.eu/workflows/510) is a Common Workflow Language (CWL) pipeline designed for the automated annotation of mass spectrometry data. It processes MS2 data in `.mzML` format to facilitate metabolite identification through a multi-stage dereplication strategy.

The workflow integrates several bioinformatics and cheminformatics tools across R and Python environments. It begins with spectral database dereplication using the R package `Spectra`, followed by compound database dereplication via either SIRIUS or MetFrag. Final candidate selection and ranking are conducted in Python, leveraging `RDKit` and `PubChemPy` for chemical informatics processing.

MAW adheres to FAIR principles, providing a reproducible environment for metabolomics research. It is designed to work with major chemical registries and databases, including GNPS, HMDB, and MassBank, to ensure comprehensive annotation coverage for mass spectrometry experiments.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| python_script |  | File |  |
| r_script |  | File |  |
| mzml_files |  | File[] |  |
| gnps_file |  | File |  |
| hmdb_file |  | File |  |
| mbank_file |  | File |  |
| ppmx |  | int |  |
| collision_info |  | boolean |  |
| db_name |  | string |  |
| db_path |  | File |  |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| analysis | analysis |  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| candidate_files |  | array |  |
| result |  | File[] |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/510
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata