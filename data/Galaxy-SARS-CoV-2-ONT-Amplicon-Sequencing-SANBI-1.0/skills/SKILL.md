---
name: ont-amplicon-sequencing
description: This workflow processes Oxford Nanopore amplicon sequencing data using a reference genome and primer BED file with tools including NanoPlot, Read It and Keep, and the ARTIC suite. Use this skill when you need to perform viral genomic surveillance or reconstruct consensus genomes from multiplexed amplicon libraries.
homepage: https://www.sanbi.ac.za/
metadata:
  docker_image: "N/A"
---

# ont-amplicon-sequencing

## Overview

This workflow is designed for the analysis of Oxford Nanopore Technologies (ONT) amplicon sequencing data, specifically optimized for viral surveillance such as SARS-CoV-2. It begins with an initial quality assessment of raw reads using [NanoPlot](https://github.com/wdecoster/NanoPlot) to provide a baseline for data quality.

The pipeline then performs rigorous filtering and preprocessing. It uses [Read It and Keep](https://github.com/phe-bioinformatics/read_it_and_keep) to subset reads matching the reference genome and [ARTIC guppyplex](https://artic.network/ncov-2019/ncov2019-bioinformatics-sop.html) to filter reads by length. A second NanoPlot step is included to visualize the quality of the data after these filtering steps, ensuring only high-quality amplicons proceed to assembly.

The final stage utilizes [ARTIC minion](https://artic.network/ncov-2019/ncov2019-bioinformatics-sop.html) to perform read alignment, primer trimming based on a provided BED file, and variant calling. By leveraging the [Medaka](https://github.com/nanoporetech/medaka) polishing model, the workflow generates highly accurate consensus sequences and identifies variants relative to the reference genome.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Sequence Reads | data_collection_input |  |
| 1 | Reference genome | data_input |  |
| 2 | Primer BED file | data_input |  |
| 3 | Minimum read length | parameter_input |  |
| 4 | Maximum read length | parameter_input |  |
| 5 | Medaka model | parameter_input |  |


Ensure your ONT sequence reads are organized into a data collection of fastqsanger or fastq.gz files to enable batch processing, while the reference genome and primer scheme must be provided as individual FASTA and BED datasets respectively. It is critical to select a Medaka model that matches your specific flow cell and sequencing kit to ensure accurate consensus calling. Consult the README.md for detailed instructions on configuring the minimum and maximum read length parameters to suit your specific amplicon panel. You can use `planemo workflow_job_init` to generate a `job.yml` file for streamlined parameter configuration and automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 6 | NanoPlot | toolshed.g2.bx.psu.edu/repos/iuc/nanoplot/nanoplot/1.41.0+galaxy0 |  |
| 7 | Read It and Keep | toolshed.g2.bx.psu.edu/repos/iuc/read_it_and_keep/read_it_and_keep/0.2.2+galaxy0 |  |
| 8 | ARTIC guppyplex | toolshed.g2.bx.psu.edu/repos/iuc/artic_guppyplex/artic_guppyplex/1.2.1+galaxy2 |  |
| 9 | NanoPlot | toolshed.g2.bx.psu.edu/repos/iuc/nanoplot/nanoplot/1.41.0+galaxy0 |  |
| 10 | ARTIC minion | toolshed.g2.bx.psu.edu/repos/iuc/artic_minion/artic_minion/1.2.1+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-ONT_Amplicon_Sequencing.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-ONT_Amplicon_Sequencing.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-ONT_Amplicon_Sequencing.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-ONT_Amplicon_Sequencing.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-ONT_Amplicon_Sequencing.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-ONT_Amplicon_Sequencing.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)