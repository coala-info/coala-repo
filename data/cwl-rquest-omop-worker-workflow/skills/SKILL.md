---
name: rquest-omop-worker-workflow
description: This CWL workflow utilizes the run_query tool to execute clinical data requests against OMOP-compliant databases based on structured JSON cohort definitions and connection parameters. Use this skill when you need to identify specific patient cohorts, quantify population demographics, or extract observational health data for multi-center clinical research projects.
homepage: https://trefx.uk/
metadata:
  docker_image: "N/A"
---

# rquest-omop-worker-workflow

## Overview

The [rquest-omop-worker-workflow](https://workflowhub.eu/workflows/471) is a Common Workflow Language (CWL) implementation designed for the RQuest OMOP Worker tool, developed as part of the Hutch and TRE-FX projects. It facilitates clinical data discovery by executing queries against databases formatted to the OMOP Common Data Model.

The workflow centers on the `run_query` tool, which processes a structured JSON payload containing cohort definitions, project metadata, and logical rules (e.g., person-level attributes and Boolean operators). This allows researchers to define complex inclusion and exclusion criteria for cohort selection within a Trusted Research Environment (TRE).

Currently, the workflow requires direct database connection parameters as inputs to authenticate and access the target data source. Users should note that while the workflow is fully operational on x86 architectures, support for ARM-based systems is currently unavailable.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| body |  | File |  |
| result_modifiers |  | string? |  |
| is_availability |  | boolean |  |
| results |  | string? |  |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| run_query | run_query |  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| output_file |  | File |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/471
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata