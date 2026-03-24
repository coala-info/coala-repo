---
name: mitogenome-assembly-vgp0
description: "This Galaxy workflow assembles and annotates mitochondrial genomes from PacBio sequencing data and a species name using the MitoHiFi tool suite. Use this skill when you need to generate a high-quality, circularized, and annotated mitochondrial genome assembly for a target organism from long-read sequencing reads."
homepage: https://workflowhub.eu/workflows/1648
---

# Mitogenome-Assembly-VGP0

## Overview

This workflow provides a standardized pipeline for mitochondrial genome assembly following the [Vertebrate Genomes Project (VGP)](https://vertebrategenomesproject.org/) infrastructure. It is designed to process PacBio sequencing data to generate high-quality, annotated mitogenomes. By utilizing the [MitoHiFi](https://github.com/marcelauliano/MitoHiFi) tool suite, the workflow automates the identification, assembly, and circularization of mitochondrial sequences from long-read collections.

Users provide a collection of PacBio data along with the species' Latin name and an email address to facilitate reference sequence retrieval. The process involves multiple stages of assembly and refinement to ensure structural accuracy. The pipeline is integrated with [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) standards and is tagged as a reviewed VGP workflow.

The final outputs include comprehensive mitogenome annotations, GenBank files, coverage reports, and assembly statistics. For convenience, the workflow also includes a compression step to package the resulting files for downstream analysis or publication. This resource is shared under a [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Collection of Pacbio Data | data_collection_input |  |
| 1 | Species name (latin name) | parameter_input | Latin name of species |
| 2 | Email adress | parameter_input | Required for NCBI database query |


Ensure your PacBio reads are organized into a data collection, typically in FASTQ or FASTA format, to facilitate efficient batch processing through the MitoHiFi tool. Provide the species' Latin name accurately as it is used for fetching reference sequences, and include a valid email address for NCBI Entrez queries. Consult the included README.md for comprehensive details on parameter tuning and specific reference selection strategies. You can automate the setup of these inputs by using `planemo workflow_job_init` to generate a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | MitoHiFi | toolshed.g2.bx.psu.edu/repos/bgruening/mitohifi/mitohifi/3+galaxy0 |  |
| 4 | MitoHiFi | toolshed.g2.bx.psu.edu/repos/bgruening/mitohifi/mitohifi/3+galaxy0 |  |
| 5 | Compress file(s) | toolshed.g2.bx.psu.edu/repos/iuc/compress_file/compress_file/0.1.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | contigs_stats | contigs_stats |
| 4 | mitogenome_coverage | mitogenome_coverage |
| 4 | mitogenome_annotation | mitogenome_annotation |
| 4 | mitogenome_genbank | mitogenome_genbank |
| 5 | output_file | output_file |


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
