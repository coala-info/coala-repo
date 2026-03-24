---
name: mrsa-amr-gene-detection
description: "This workflow identifies antimicrobial resistance genes and performs genome annotation on bacterial contigs and paired-end reads using staramr, Bakta, and Bowtie2. Use this skill when you need to characterize the resistome of a bacterial pathogen and visualize its genomic features to identify specific resistance markers."
homepage: https://workflowhub.eu/workflows/1488
---

# mrsa AMR gene detection

## Overview

This workflow is designed for the identification and annotation of antimicrobial resistance (AMR) genes within assembled bacterial genomes, specifically optimized for MRSA analysis. It processes two primary inputs: assembled genomic contigs and a collection of paired-end sequencing reads.

The core analysis utilizes [staramr](https://toolshed.g2.bx.psu.edu/repos/nml/staramr/staramr_search/0.10.0+galaxy1) to scan for resistance genes and [Bakta](https://toolshed.g2.bx.psu.edu/repos/iuc/bakta/bakta/1.8.2+galaxy0) for rapid, comprehensive genome annotation. To ensure data integrity and provide coverage context, [Bowtie2](https://toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.5.4+galaxy0) maps the raw paired-end reads back to the assembly.

Downstream processing includes data filtering and the conversion of tabular results into GFF3 format. The workflow generates detailed AMR summaries, annotation reports, and mapping statistics. For interactive exploration, it produces a [JBrowse](https://toolshed.g2.bx.psu.edu/repos/iuc/jbrowse/jbrowse/1.16.11+galaxy1) visualization that integrates the annotated features and resistance gene locations.

Developed under the MIT license, this tool aligns with [GTN](https://training.galaxyproject.org/) standards and [Microgalaxy](https://microgalaxy.usegalaxy.eu/) practices for reproducible genome annotation and pathogen surveillance.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | contigs | data_input |  |
| 1 | Input Paired End Reads Collection | data_collection_input |  |


Ensure your input contigs are in FASTA format and your raw sequencing data is organized into a paired-end dataset collection to facilitate efficient mapping and annotation. Using a collection for the reads allows the workflow to scale across multiple samples while maintaining proper forward and reverse associations for the Bowtie2 step. Refer to the included `README.md` for comprehensive details on specific parameter settings and the required database versions for Bakta and staramr. You can automate the configuration of these inputs by generating a `job.yml` file using `planemo workflow_job_init`.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | staramr | toolshed.g2.bx.psu.edu/repos/nml/staramr/staramr_search/0.10.0+galaxy1 |  |
| 3 | Bakta | toolshed.g2.bx.psu.edu/repos/iuc/bakta/bakta/1.8.2+galaxy0 |  |
| 4 | Bowtie2 | toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.5.4+galaxy0 |  |
| 5 | Select | Grep1 |  |
| 6 | Table to GFF3 | toolshed.g2.bx.psu.edu/repos/iuc/tbl2gff3/tbl2gff3/1.2 |  |
| 7 | JBrowse | toolshed.g2.bx.psu.edu/repos/iuc/jbrowse/jbrowse/1.16.11+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | stararm_detailed_summary | detailed_summary |
| 3 | bakta_annotation_summary | annotation_tsv |
| 4 | mapping_stats | mapping_stats |
| 7 | jbrowse_output | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run main-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run main-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run main-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init main-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint main-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `main-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
