---
name: apollo-load-test
description: "This workflow integrates genomic scaffolds, GFF3 annotations, and BAM or BigWig evidence tracks into a collaborative environment using JBrowse and Apollo. Use this skill when you need to perform manual curation and structural refinement of gene models to improve the accuracy of a genome assembly's functional annotations."
homepage: https://workflowhub.eu/workflows/1554
---

# Apollo Load Test

## Overview

This workflow is designed for refining genome annotations using [Apollo](https://genomearchitect.readthedocs.io/en/latest/), integrated within the Galaxy ecosystem. It follows [GTN](https://training.galaxyproject.org/) methodologies for collaborative genome curation, allowing users to visualize and manually edit gene models based on various evidence tracks.

The process begins by ingesting genomic data, including [scaffold sequences](https://zenodo.org/record/3270822/files/Amel_4.5_scaffolds.fa.gz?download=1) and [existing GFF3 annotations](https://zenodo.org/record/3270822/files/amel_OGSv3.2.gff3.gz?download=1). It also incorporates evidence tracks such as [BigWig](https://zenodo.org/record/3270822/files/forager.bw) and [BAM](https://zenodo.org/record/3270822/files/forager_Amel4.5_accepted_hits.bam) files to provide the necessary biological context for manual refinement.

The workflow automates the setup of the Apollo environment by registering user accounts and managing organism profiles. It utilizes [JBrowse](https://jbrowse.org/) to generate the underlying visualization tracks, which are then pushed to an Apollo instance. The final step provides an interactive iframe for real-time manual curation of the genome.

Tagged with **Genome-annotation** and **GTN**, this workflow serves as both a functional pipeline for curators and a load test for Apollo-Galaxy integrations. It ensures that all necessary components—from data preparation to the interactive annotation interface—are correctly synchronized for collaborative research.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | https://zenodo.org/record/3270822/files/Amel_4.5_scaffolds.fa.gz?download=1 | data_input |  |
| 1 | https://zenodo.org/record/3270822/files/amel_OGSv3.2.gff3.gz?download=1 | data_input |  |
| 2 | https://zenodo.org/record/3270822/files/forager.bw | data_input |  |
| 3 | https://zenodo.org/record/3270822/files/forager_Amel4.5_accepted_hits.bam | data_input |  |


Ensure your reference genome is in FASTA format and annotations are provided as GFF3, while supporting evidence like BigWig and BAM files should be properly formatted for JBrowse integration. Since this workflow processes individual genomic tracks, ensure each dataset is correctly typed and labeled before launching the Apollo account registration and organism creation steps. Consult the README.md for comprehensive instructions on configuring the Apollo instance and managing user permissions. You can streamline the execution by using planemo workflow_job_init to generate a job.yml file for your input parameters.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | Register Account | toolshed.g2.bx.psu.edu/repos/gga/apollo_create_account/create_account/3.1 |  |
| 5 | List Organisms | toolshed.g2.bx.psu.edu/repos/gga/apollo_list_organism/list_organism/3.1 |  |
| 6 | JBrowse | toolshed.g2.bx.psu.edu/repos/iuc/jbrowse/jbrowse/1.16.11+galaxy1 |  |
| 7 | Create or Update Organism | toolshed.g2.bx.psu.edu/repos/gga/apollo_create_or_update/create_or_update/4.2.5 |  |
| 8 | Annotate | toolshed.g2.bx.psu.edu/repos/gga/apollo_iframe/iframe/4.2.5 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | output | output |
| 5 | output | output |
| 6 | output | output |
| 7 | output | output |
| 8 | output | output |


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
