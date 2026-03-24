---
name: testentrytitlenew
description: "This CWL workflow imports raw cryo-electron microscopy movies using pwem and manages their deposition to the EMPIAR database. Use this skill when you need to archive structural biology datasets or share raw microscopy data with the scientific community for peer review and reproducibility."
homepage: https://workflowhub.eu/workflows/183
---
# testEntryTitleNew

## Overview

This [Common Workflow Language (CWL)](https://workflowhub.eu/workflows/183) workflow is designed for the initial stages of Cryo-EM data management and archival. It provides a standardized pipeline for handling raw microscopy data, licensed under Apache-2.0.

The workflow consists of two primary functional stages:
*   **pwem - import movies**: Facilitates the ingestion of raw Cryo-EM movie files into the processing environment.
*   **empiar - Empiar deposition**: Automates the preparation and deposition of data to the Electron Microscopy Public Image Archive (EMPIAR).

By integrating these steps, the workflow ensures a consistent path from data acquisition to public repository submission, streamlining the administrative overhead associated with Cryo-EM data sharing.

## Inputs

_None listed._


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| 2_ProtImportMovies | pwem - import movies | *3* Movies imported from /home/irene/testIrene/*.tiff, Is the data phase flipped : False, Sampling rate : *1.00* Å/px |
| 87_EmpiarDepositor | empiar - Empiar deposition | Generated deposition files:, - [[/home/irene/ScipionUserData/projects/testK/Runs/000087_EmpiarDepositor/extra/topFolder/workflow.json][Scipion workflow]], - [[Runs/000087_EmpiarDepositor/extra/topFolder/deposition.json][Deposition json]] |

## Outputs

_None listed._


## Files

- WorkflowHub: https://workflowhub.eu/workflows/183
- `workflow.cwl` — workflow definition (CWL)
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
