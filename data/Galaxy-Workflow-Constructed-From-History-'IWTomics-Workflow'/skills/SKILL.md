---
name: workflow-constructed-from-history-iwtomics-workflow
description: This genomics workflow processes BED files and tabular feature headers using the IWTomics suite to perform interval-wise testing and visualization of omics data. Use this skill when you need to identify significant differences in the distribution of genomic features across different types of regions using functional data analysis.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# workflow-constructed-from-history-iwtomics-workflow

## Overview

This workflow implements Interval-Wise Testing (IWTomics) for omics data, a statistical framework designed to identify significant differences between groups of genomic functional curves. It is particularly useful for analyzing high-resolution data, such as recombination rates or epigenetic marks, across specific genomic regions to detect localized patterns of variation.

The pipeline processes multiple genomic datasets, including BED files for specific features (e.g., ETn elements and controls) and recombination hotspots. Using the [IWTomics Load](https://toolshed.g2.bx.psu.edu/repos/iuc/iwtomics_loadandplot/iwtomics_loadandplot/1.0.0.0) tool, the workflow imports these features alongside tabular header files that define the experimental regions and parameters.

Once the data is loaded, the [IWTomics Test](https://toolshed.g2.bx.psu.edu/repos/iuc/iwtomics_testandplot/iwtomics_testandplot/1.0.0.0) step performs functional statistical testing to pinpoint significant differences. The process concludes with the [IWTomics Plot with Threshold](https://toolshed.g2.bx.psu.edu/repos/iuc/iwtomics_plotwithscale/iwtomics_plotwithscale/1.0.0.0) tool, which generates visualizations of the adjusted p-values and genomic scales, allowing for clear identification of significant intervals within the omics profiles.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | ETn_fixed.bed | data_input |  |
| 1 | Control.bed | data_input |  |
| 2 | features_header.tabular | data_input |  |
| 3 | regions_header.tabular | data_input |  |
| 4 | Recombination_hotspots.txt | data_input |  |


Ensure your genomic interval data is provided in BED format, while the metadata for features and regions must be formatted as tabular files with appropriate headers to ensure compatibility with the IWTomics Load tool. While this workflow is configured for individual datasets, you may consider using data collections if you need to scale the analysis to include multiple replicates or conditions. Refer to the `README.md` for comprehensive details on the specific column structures required for the statistical testing of omics data. For automated execution and testing, you can use `planemo workflow_job_init` to generate a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 5 | IWTomics Load | toolshed.g2.bx.psu.edu/repos/iuc/iwtomics_loadandplot/iwtomics_loadandplot/1.0.0.0 |  |
| 6 | IWTomics Test | toolshed.g2.bx.psu.edu/repos/iuc/iwtomics_testandplot/iwtomics_testandplot/1.0.0.0 |  |
| 7 | IWTomics Plot with Threshold | toolshed.g2.bx.psu.edu/repos/iuc/iwtomics_plotwithscale/iwtomics_plotwithscale/1.0.0.0 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run iwtomics-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run iwtomics-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run iwtomics-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init iwtomics-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint iwtomics-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `iwtomics-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)