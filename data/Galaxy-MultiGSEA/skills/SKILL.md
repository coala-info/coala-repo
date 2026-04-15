---
name: multigsea
description: This Galaxy workflow integrates transcriptome, proteome, and metabolome data to perform multi-omics gene set enrichment analysis using the multiGSEA tool. Use this skill when you need to identify enriched biological pathways across multiple molecular layers to gain a holistic understanding of complex biological systems or disease states.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# multigsea

## Overview

This workflow performs integrated multi-omics gene set enrichment analysis using the [multiGSEA](https://toolshed.g2.bx.psu.edu/repos/iuc/multigsea/multigsea/1.12.0+galaxy0) tool. It is designed to ingest three distinct data layers—transcriptome, proteome, and metabolome—provided in TSV format. By combining these inputs, the workflow enables a holistic biological perspective that single-omics analyses might miss.

The core processing is handled by the multiGSEA tool, which calculates enrichment scores across the integrated datasets. Following the primary analysis, the workflow applies a filtering step and utilizes a [text-based search](https://toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/9.3+galaxy1) to isolate specific pathways or significant results. The final output is a refined, filtered dataset ready for biological interpretation.

Developed with [Multi-omics](https://training.galaxyproject.org/) research in mind, this workflow is licensed under the MIT license and aligns with [GTN](https://training.galaxyproject.org/) standards for Galaxy-based bioinformatics. For detailed documentation on the underlying parameters and usage, please refer to the README.md in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | transcriptome.tsv | data_input |  |
| 1 | proteome.tsv | data_input |  |
| 2 | metabolome.tsv | data_input |  |


Ensure all omics inputs are formatted as tab-separated values (TSV) with consistent feature identifiers across the transcriptome, proteome, and metabolome files. While individual datasets are used here, organizing multi-omics data into collections can streamline processing if handling multiple experimental conditions or replicates. Refer to the `README.md` for specific column requirements and mapping instructions necessary for successful integration. You can use `planemo workflow_job_init` to generate a `job.yml` for automated testing and execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | multiGSEA | toolshed.g2.bx.psu.edu/repos/iuc/multigsea/multigsea/1.12.0+galaxy0 |  |
| 4 | Filter | Filter1 |  |
| 5 | Search in textfiles | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/9.3+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | Filtered output | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run multigsea.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run multigsea.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run multigsea.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init multigsea.ga -o job.yml`
- Lint: `planemo workflow_lint multigsea.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `multigsea.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)