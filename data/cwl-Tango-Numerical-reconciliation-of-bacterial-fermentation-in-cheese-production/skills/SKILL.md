---
name: tango-numerical-reconciliation-of-bacterial-fermentation-in
description: "This CWL workflow utilizes optimization and dynamic simulation tools to perform numerical reconciliation of bacterial fermentation in cheese production through metabolic modeling. Use this skill when characterizing the metabolic interactions and population dynamics of microbial communities during food fermentation processes."
homepage: https://workflowhub.eu/workflows/873
---
# Tango: Numerical reconciliation of bacterial fermentation in cheese production

## Overview

The Tango workflow implements the numerical reconciliation of bacterial fermentation in cheese production as described by [Lecomte et al. (2024)](https://doi.org/10.1016/j.ymben.2024.02.014). This [Common Workflow Language (CWL)](https://workflowhub.eu/workflows/873) pipeline uses metabolic modeling to reveal the dynamics and mechanisms of bacterial interactions within microbial communities.

The execution process follows a structured sequence to move from raw parameters to finalized visualizations:
* **Optimization:** Parameters for individual bacterial models are first obtained through an optimization step.
* **Simulation:** The workflow simulates both individual and community dynamics to model metabolic behavior during fermentation.
* **Visualization:** Results are processed through automated plotting tools to assemble the figures reported in the associated manuscript.

The workflow manages its own environment by creating specific directory structures for models, results, and figures, ensuring a reproducible path from metabolic modeling to data interpretation in microbial ecology.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| #main/community |  | array |  |
| #main/pure_culture |  | array |  |
| #main/which_figures |  | array |  |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| #main/dynamics | #main/dynamics |  |
| #main/mkdir_figures | #main/mkdir_figures |  |
| #main/mkdir_models | #main/mkdir_models |  |
| #main/mkdir_results | #main/mkdir_results |  |
| #main/optimize | #main/optimize |  |
| #main/plot_figures | #main/plot_figures |  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| #main/figures |  | Directory |  |
| #main/results |  | Directory |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/873
- `packed.cwl` — workflow definition (CWL)
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
