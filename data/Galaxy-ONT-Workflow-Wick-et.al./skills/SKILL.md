---
name: ont-workflow-wick-etal
description: This workflow performs de novo genome assembly on Oxford Nanopore sequencing data using Unicycler and SPAdes, followed by assembly graph visualization and assessment with Bandage. Use this skill when you need to generate high-quality bacterial genome assemblies from long-read data and evaluate the connectivity and quality of the resulting assembly graphs.
homepage: https://workflowhub.eu/workflows/52
metadata:
  docker_image: "N/A"
---

# ont-workflow-wick-etal

## Overview

This Galaxy workflow is designed for the assembly and visualization of genomic data, specifically optimized for Oxford Nanopore Technologies (ONT) sequencing. It implements assembly strategies associated with the methodologies of [Wick et al.](https://github.com/rrwick), focusing on producing high-quality bacterial genome reconstructions from long-read data.

The pipeline processes three primary data inputs using multiple instances of [Unicycler](https://toolshed.g2.bx.psu.edu/repos/iuc/unicycler/unicycler/0.4.6.0) and [SPAdes](https://toolshed.g2.bx.psu.edu/repos/nml/spades/spades/1.2). These tools are utilized to generate de novo assemblies, leveraging Unicycler's ability to bridge the gap between different sequencing modalities and SPAdes' robust assembly algorithms to ensure contiguous and accurate genomic outputs.

To facilitate quality control and structural analysis, the workflow integrates [Bandage](https://toolshed.g2.bx.psu.edu/repos/iuc/bandage/) for both image generation and assembly graph information. This allows users to visually inspect the connectivity of the assembly graphs and retrieve detailed statistics, providing a comprehensive overview of the assembly's success and complexity.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | https://ndownloader.figshare.com/files/8812159 | data_input |  |
| 1 | https://ndownloader.figshare.com/files/8811148 | data_input |  |
| 2 | https://ndownloader.figshare.com/files/8811145 | data_input |  |


For this ONT assembly workflow, ensure your input files are in FASTQ format, typically representing long-read sequencing data required for Unicycler and SPAdes. You can upload these as individual datasets or organize them into a collection if you intend to process multiple samples through the assembly and Bandage visualization steps. Refer to the README.md for comprehensive details on parameter settings and specific data requirements. You may use `planemo workflow_job_init` to generate a `job.yml` file for automated execution and reproducible input mapping.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Create assemblies with Unicycler | toolshed.g2.bx.psu.edu/repos/iuc/unicycler/unicycler/0.4.6.0 |  |
| 4 | spades | toolshed.g2.bx.psu.edu/repos/nml/spades/spades/1.2 |  |
| 5 | Create assemblies with Unicycler | toolshed.g2.bx.psu.edu/repos/iuc/unicycler/unicycler/0.4.6.0 |  |
| 6 | Create assemblies with Unicycler | toolshed.g2.bx.psu.edu/repos/iuc/unicycler/unicycler/0.4.6.0 |  |
| 7 | Bandage Image | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/0.8.1+galaxy0 |  |
| 8 | Bandage Info | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_info/0.8.1+galaxy0 |  |
| 9 | Bandage Image | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/0.8.1+galaxy0 |  |
| 10 | Bandage Info | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_info/0.8.1+galaxy0 |  |
| 11 | Bandage Image | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/0.8.1+galaxy0 |  |
| 12 | Bandage Info | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_info/0.8.1+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-ONT_-_Workflow-Wick-et.al..ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-ONT_-_Workflow-Wick-et.al..ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-ONT_-_Workflow-Wick-et.al..ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-ONT_-_Workflow-Wick-et.al..ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-ONT_-_Workflow-Wick-et.al..ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-ONT_-_Workflow-Wick-et.al..ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)