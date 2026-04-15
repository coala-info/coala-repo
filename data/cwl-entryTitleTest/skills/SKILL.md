---
name: entrytitletest
description: This Common Workflow Language workflow imports raw cryo-electron microscopy movies using the pwem tool and manages their deposition into the EMPIAR database. Use this skill when archiving structural biology datasets or sharing raw micrograph data with the scientific community through public repositories.
homepage: https://workflowhub.eu/workflows/188
metadata:
  docker_image: "N/A"
---

# entrytitletest

## Overview

This [Common Workflow Language](https://commonwl.org/) (CWL) workflow, titled **entryTitleTest**, provides a streamlined pipeline for Cryo-EM data processing and deposition. It is designed to automate the initial handling of microscopy data and its subsequent submission to public archives.

The workflow consists of two primary functional stages:
*   **Data Ingestion:** Uses `pwem` to import raw movie files into the processing environment.
*   **Deposition:** Utilizes `empiar` to manage the deposition of data to the [Electron Microscopy Public Image Archive (EMPIAR)](https://www.ebi.ac.uk/empiar/).

Licensed under [Apache-2.0](https://www.apache.org/licenses/LICENSE-2.0), the complete workflow definition and version history can be accessed via [WorkflowHub](https://workflowhub.eu/workflows/188). It serves as a foundational tool for researchers needing to standardize their Cryo-EM metadata and deposition routines.

## Inputs

_None listed._


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| 2_ProtImportMovies | pwem - import movies | *3* Movies imported from /home/irene/testIrene/*.tiff, Is the data phase flipped : False, Sampling rate : *1.00* Å/px |
| 87_EmpiarDepositor | empiar - Empiar deposition | Generated deposition files:, - [[/home/irene/ScipionUserData/projects/workflowhub/Runs/000087_EmpiarDepositor/extra/topLevelFolderTest/workflow.json][Scipion workflow]], - [[Runs/000087_EmpiarDepositor/extra/topLevelFolderTest/deposition.json][Deposition json]] |

## Outputs

_None listed._


## Files

- WorkflowHub: https://workflowhub.eu/workflows/188
- `workflow.cwl` — workflow definition (CWL)
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata