---
name: beacon-omop-worker-survival
description: This CWL workflow executes survival analysis on clinical datasets standardized to the OMOP Common Data Model to generate time-to-event statistics and survival curves. Use this skill when you need to assess patient mortality rates, determine the duration until specific clinical events occur, or compare survival outcomes across different patient cohorts in a healthcare study.
homepage: https://trefx.uk/
metadata:
  docker_image: "N/A"
---

# beacon-omop-worker-survival

## Overview

This Common Workflow Language (CWL) workflow performs survival analysis on clinical data structured according to the OMOP Common Data Model (CDM). It is designed to operate as a worker within the Beacon ecosystem, enabling standardized longitudinal analysis of patient cohorts across federated data nodes.

The process automates the extraction of time-to-event data from OMOP tables—such as condition occurrences, drug exposures, or death records—to calculate survival probabilities. By utilizing the standardized OMOP schema, the workflow ensures that statistical outputs remain consistent regardless of the underlying database infrastructure.

Detailed documentation and version history can be found on [WorkflowHub](https://workflowhub.eu/workflows/1180). This workflow is typically used in conjunction with other Beacon workers to provide privacy-preserving clinical insights from large-scale observational health data.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| vocabulary |  | string |  |
| output_name |  | string |  |
| strata |  | string? |  |


## Steps

_Step list is not in the RO-Crate metadata; open the main workflow CWL below or see WorkflowHub for the diagram._


## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| output_file |  | File |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/1180
- `beacon-omop-worker-survival.cwl` — workflow definition (CWL)
- `beacon-omop-worker.cwl` — workflow definition (CWL)
- `workflow_entrypoint.cwl` — workflow definition (CWL)
- `workflow_entrypoint_survival.cwl` — workflow definition (CWL)
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata