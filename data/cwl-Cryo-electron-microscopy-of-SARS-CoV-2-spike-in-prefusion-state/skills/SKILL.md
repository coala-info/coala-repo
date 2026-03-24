---
name: cryo-electron-microscopy-of-sars-cov-2-spike-in-prefusion-st
description: "This CWL workflow processes cryo-electron microscopy movies using pwem and empiar to perform continuous flexibility analysis on SARS-CoV-2 spike proteins in their prefusion state. Use this skill when you need to characterize the conformational landscape and structural dynamics of viral spike proteins to understand their functional mechanisms."
homepage: https://workflowhub.eu/workflows/160
---
# Cryo electron microscopy of SARS-CoV-2 spike in prefusion state

## Overview

This [Common Workflow Language (CWL)](https://commonwl.org/) workflow is designed for the continuous flexibility analysis of SARS-CoV-2 Spike protein structures in their prefusion state. It provides a standardized pipeline for processing cryo-electron microscopy (cryo-EM) data to better understand the conformational dynamics of viral proteins.

The workflow consists of two primary functional stages:
*   **Data Import:** Utilizing the `pwem` tool to import raw movie data into the processing environment.
*   **Deposition Management:** Interacting with the [EMPIAR](https://www.ebi.ac.uk/empiar/) repository for data deposition or retrieval tasks.

Licensed under Apache-2.0, the workflow is hosted on [WorkflowHub](https://workflowhub.eu/workflows/160). It serves as a reproducible framework for structural biologists to analyze large-scale datasets while maintaining consistency across different computational environments.

## Inputs

_None listed._


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| 2_ProtImportMovies | pwem - import movies | *20* Movies imported from /home/ubuntu/scipion/data/tests/relion_tutorial/micrographs/*.mrc, Is the data phase flipped : False, Sampling rate : *1.00* Å/px |
| 379_EmpiarDepositor | empiar - Empiar deposition | Generated deposition files:, - [[/home/ubuntu/ScipionUserData/projects/testEmpiar3/Runs/000379_EmpiarDepositor/extra/SARS-CoV-2-spike/workflow.json][Scipion workflow]], - [[Runs/000379_EmpiarDepositor/extra/SARS-CoV-2-spike/deposition.json][Deposition json]] |

## Outputs

_None listed._


## Files

- WorkflowHub: https://workflowhub.eu/workflows/160
- `workflow.cwl` — workflow definition (CWL)
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
