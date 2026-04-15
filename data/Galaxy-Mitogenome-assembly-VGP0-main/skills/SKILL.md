---
name: mitogenome-assembly-vgp0
description: This workflow assembles mitochondrial genomes from PacBio HiFi reads using MitoHiFi by leveraging a species' Latin name to automatically retrieve reference data. Use this skill when you need to generate a high-quality, annotated mitogenome assembly and associated coverage statistics for a specific organism as part of a comparative genomics or biodiversity study.
homepage: https://iwc.galaxyproject.org/
metadata:
  docker_image: "N/A"
---

# mitogenome-assembly-vgp0

## Overview

The Mitogenome Assembly VGP0 workflow is a specialized pipeline within the [Vertebrate Genomes Project (VGP)](https://vertebrategenomesproject.org/) suite designed to generate high-quality mitochondrial assemblies from PacBio HiFi reads. It utilizes [MitoHiFi](https://github.com/marcelauliano/MitoHiFi) to automate the extraction, assembly, and annotation of the mitogenome. A key feature of this workflow is its independence; it can be executed at any stage of a genomic project without requiring other VGP workflows.

Users provide a collection of PacBio HiFi data, the species' Latin name, and the relevant NCBI genetic code. The workflow automatically retrieves the necessary mitochondrial reference sequences from public databases using the provided species name and email address, eliminating the need for manual reference preparation. 

The pipeline produces a comprehensive set of outputs, including the assembled mitogenome in FASTA format, detailed contig statistics, and a GenBank annotation file. It also generates visual reports for mitogenome coverage and annotation to facilitate immediate quality assessment. This workflow is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) and is tagged for VGP reviewed standards.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Species name (latin name) | parameter_input | Latin name of  the species. E.g. Homo Sapiens |
| 1 | Assembly Name | parameter_input | For Workflow report. |
| 2 | Collection of Pacbio Data | data_collection_input |  |
| 3 | Email adress | parameter_input | Required for NCBI database query |
| 4 | Genetic Code | parameter_input | Organism genetic code following NCBI table (for mitogenome annotation) |


Ensure your PacBio HiFi reads are in FASTQ format and organized into a data collection to match the workflow requirements. You must provide the species' Latin name and the correct NCBI genetic code to allow MitoHiFi to automatically retrieve the appropriate reference and perform accurate annotation. An email address is required for the automated NCBI database queries used during the assembly process. For comprehensive configuration details and parameter explanations, refer to the README.md file. You can also use `planemo workflow_job_init` to generate a `job.yml` for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 5 | Compose text parameter value | toolshed.g2.bx.psu.edu/repos/iuc/compose_text_param/compose_text_param/0.1.1 |  |
| 6 | Compose text parameter value | toolshed.g2.bx.psu.edu/repos/iuc/compose_text_param/compose_text_param/0.1.1 |  |
| 7 | MitoHiFi | toolshed.g2.bx.psu.edu/repos/bgruening/mitohifi/mitohifi/3.2.3+galaxy0 |  |
| 8 | MitoHiFi | toolshed.g2.bx.psu.edu/repos/bgruening/mitohifi/mitohifi/3.2.3+galaxy0 |  |
| 9 | Compress file(s) | toolshed.g2.bx.psu.edu/repos/iuc/compress_file/compress_file/0.1.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | Species Name for report | out1 |
| 6 | Assembly Name for report | out1 |
| 8 | Mitogenome coverage: Image | mitogenome_coverage |
| 8 | Mitogenome annotation: Image | mitogenome_annotation |
| 8 | Mitogenome annotation: GenBank | mitogenome_genbank |
| 8 | Mitogenome: Contigs Statistics | contigs_stats |
| 9 | Compressed Mitogenome | output_file |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Mitogenome-Assembly-VGP0.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Mitogenome-Assembly-VGP0.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Mitogenome-Assembly-VGP0.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Mitogenome-Assembly-VGP0.ga -o job.yml`
- Lint: `planemo workflow_lint Mitogenome-Assembly-VGP0.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Mitogenome-Assembly-VGP0.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)