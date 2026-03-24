---
name: nmr-pipe
description: "This CWL workflow processes 2D 1H 15N HSQC NMR spectra using NMRPipe tools to convert raw data into peak lists containing 1H and 15N chemical shift values. Use this skill when characterizing protein-ligand binding sites or identifying chemical shift perturbations across multiple experimental samples."
homepage: https://workflowhub.eu/workflows/43
---
# NMR pipe

## Overview

This [Common Workflow Language (CWL)](https://workflowhub.eu/workflows/43) workflow automates the processing and peak picking of 2D 1H 15N HSQC NMR spectra using the NMRPipe toolset. It is designed to streamline the conversion of raw spectral data into structured chemical shift values for protein analysis.

The pipeline executes a four-step sequence to transform raw data into results:
* **Conversion:** Transforms Bruker data into processing scripts and generates Free Induction Decay (FID) files.
* **Formatting:** Converts FID files into the standard NMRPipe format.
* **Analysis:** Performs automated peak picking to identify spectral features.

The final output is a peak list containing 1H and 15N chemical shift values for each spectrum. These results are used to characterize ligand binding sites by comparing shift differences across various protein-ligand complexes, such as the MDM2 protein samples documented on [WorkflowHub](https://workflowhub.eu/workflows/43).

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| workdir_array |  | Directory[] |  |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| brucker_to_script | brucker_to_script |  |
| script_to_fid | script_to_fid |  |
| fid_to_pipe | fid_to_pipe |  |
| pipe_to_pick | pipe_to_pick |  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| final_result |  | File[] |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/43
- `nmrpipe_workflow.cwl` — workflow definition (CWL)
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
