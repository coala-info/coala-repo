---
name: beacon-workflow
description: "This CWL workflow employs the beacon-oneshot tool to execute standardized genomic and clinical data queries against datasets structured according to the OMOP Common Data Model. Use this skill when you need to facilitate federated discovery of patient cohorts or share sensitive clinical observations across standardized medical research networks."
homepage: https://workflowhub.eu/workflows/882
---
# beacon-workflow

## Overview

The [beacon-workflow](https://workflowhub.eu/workflows/882) is a Common Workflow Language (CWL) implementation designed to facilitate data discovery and querying within the GA4GH Beacon protocol framework. It is part of the broader [beacon-omop-worker-workflows](https://workflowhub.eu/workflows/882) suite, which focuses on integrating Beacon services with the OMOP Common Data Model.

The workflow executes a single primary operation, `beacon-oneshot`, which functions as a worker process to handle discrete data requests. It is optimized for environments where clinical or genomic data must be queried in a standardized, "one-shot" execution pattern to return specific discovery results.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| filters |  | string? |  |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| beacon-oneshot | beacon-oneshot |  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| output_file |  | File |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/882
- `beacon-omop-worker-survival.cwl` — workflow definition (CWL)
- `beacon-omop-worker.cwl` — workflow definition (CWL)
- `workflow_entrypoint.cwl` — workflow definition (CWL)
- `workflow_entrypoint_survival.cwl` — workflow definition (CWL)
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
