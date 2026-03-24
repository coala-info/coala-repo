---
name: abritamr
description: "This Galaxy workflow utilizes the abriTAMR tool to perform antimicrobial resistance gene detection and classification from bacterial genomic assemblies. Use this skill when you need to identify resistance genes and determine the AMR profile of bacterial isolates for clinical or epidemiological surveillance."
homepage: https://workflowhub.eu/workflows/634
---

# AbritAMR

## Overview

This workflow utilizes [abriTAMR](https://github.com/MDU-PHL/abritamr), an ISO-compliant pipeline designed for the automated detection of antimicrobial resistance (AMR) genes. It acts as a specialized wrapper for [AMRFinderPlus](https://github.com/ncbi/amr), streamlining the process of identifying resistance determinants within bacterial genomic assemblies.

The workflow processes input contigs to identify acquired resistance genes and relevant point mutations. By leveraging the NCBI Bacterial Antimicrobial Resistance Reference Gene Database, it ensures standardized and high-quality results suitable for public health surveillance and genomic research.

Upon completion, the workflow generates comprehensive tabular reports that summarize the resistance profile for each isolate. These outputs categorize findings by drug class, providing a clear overview of the genetic basis for antimicrobial resistance identified in the samples.

## Inputs and data preparation

_None listed._


Ensure your input files are in FASTA format, typically representing assembled contigs or scaffolds for AMR gene detection. Utilizing a dataset collection is highly recommended for batch processing multiple isolates efficiently within a single workflow run. Refer to the `README.md` for comprehensive details on parameter configurations and specific database requirements. You can use `planemo workflow_job_init` to generate a `job.yml` for automated execution and testing.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | abriTAMR | toolshed.g2.bx.psu.edu/repos/iuc/abritamr/abritamr/1.0.14+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-AbritAMR.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-AbritAMR.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-AbritAMR.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-AbritAMR.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-AbritAMR.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-AbritAMR.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
