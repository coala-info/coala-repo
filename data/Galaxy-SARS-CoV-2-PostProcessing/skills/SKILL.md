---
name: sars-cov-2-postprocessing
description: This SARS-CoV-2 genomics workflow processes consensus genomes and aligned reads using Nextclade for clade assignment and JBrowse for visual inspection against reference annotations and amplicons. Use this skill when you need to assign viral lineages, identify mutations, and visually validate genomic variants within the context of SARS-CoV-2 surveillance.
homepage: https://www.sanbi.ac.za/
metadata:
  docker_image: "N/A"
---

# sars-cov-2-postprocessing

## Overview

This workflow is designed for the downstream analysis and visualization of SARS-CoV-2 genomic data following assembly. It processes consensus genomes and aligned reads (BAM) alongside a reference genome, GFF3 annotations, and amplicon data to provide a comprehensive overview of viral sequence quality and variation.

The pipeline utilizes [Nextclade](https://github.com/nextclade/nextclade) to perform clade assignment, mutation calling, and sequence quality assessment. This step allows researchers to quickly identify specific lineages and evaluate the integrity of the assembled sequences against global SARS-CoV-2 standards.

For interactive data exploration, the workflow integrates [JBrowse](https://jbrowse.org/), generating a web-based genome browser. This enables the simultaneous visualization of aligned reads, consensus sequences, and genomic annotations, facilitating the manual inspection of variants and coverage patterns across the viral genome.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Consensus Genomes | data_collection_input |  |
| 1 | Reference Genome | data_input |  |
| 2 | Aligned reads (BAM) | data_collection_input |  |
| 3 | SARS-CoV-2 Annotation (GFF3) | data_input |  |
| 4 | Amplicons | data_input |  |


Ensure consensus genomes and BAM files are organized into data collections to maintain sample associations during Nextclade analysis and JBrowse visualization. The reference genome must be in FASTA format, while the SARS-CoV-2 annotation should be a valid GFF3 file and amplicons provided in BED format. Using collections instead of individual datasets streamlines the processing of multiple samples simultaneously. Refer to the `README.md` for exhaustive documentation on data formatting and specific tool parameters. You may use `planemo workflow_job_init` to create a `job.yml` for structured workflow execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 5 | Nextclade | toolshed.g2.bx.psu.edu/repos/iuc/nextclade/nextclade/2.7.0+galaxy0 |  |
| 6 | JBrowse | toolshed.g2.bx.psu.edu/repos/iuc/jbrowse/jbrowse/1.16.11+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-SARS-CoV-2_PostProcessing.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-SARS-CoV-2_PostProcessing.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-SARS-CoV-2_PostProcessing.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-SARS-CoV-2_PostProcessing.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-SARS-CoV-2_PostProcessing.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-SARS-CoV-2_PostProcessing.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)