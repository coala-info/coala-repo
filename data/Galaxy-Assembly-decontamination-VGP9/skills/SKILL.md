---
name: assembly-decontamination-vgp9
description: This workflow decontaminates scaffolded genome assemblies by identifying non-target sequences and mitochondrial DNA using Kraken2, NCBI BLAST+, and gfastats. Use this skill when you need to clean a draft vertebrate genome assembly by removing foreign biological contaminants and mis-scaffolded mitochondrial sequences to ensure high-quality curated results.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# assembly-decontamination-vgp9

## Overview

This workflow is designed for the decontamination of scaffolded genome assemblies, following the curation standards established by the [Vertebrate Genomes Project (VGP)](https://vertebrategenomesproject.org/). It identifies and removes non-target sequences, such as bacterial contaminants and misplaced mitochondrial DNA, to ensure the integrity of the final assembly.

The pipeline utilizes [Kraken2](https://github.com/DerrickWood/kraken2) for taxonomic classification and [NCBI BLAST+ blastn](https://blast.ncbi.nlm.nih.gov/Blast.cgi) to pinpoint mitochondrial scaffolds. Initial preprocessing steps include sequence masking with `dustmasker` and text transformations to prepare the assembly for rigorous screening against user-provided reference databases.

After identifying contaminants, the workflow filters the assembly and generates a comprehensive list of sequences marked for removal. The final output is a decontaminated assembly processed via [gfastats](https://github.com/GFA-spec/gfastats), providing both the cleaned FASTA file and detailed assembly statistics. This workflow is tagged for [GTN](https://training.galaxyproject.org/) and VGP curated pipelines, ensuring compatibility with standard genome assembly benchmarks.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Scaffolded assembly (fasta) | data_input |  |
| 1 | Database for Kraken2 | parameter_input | Select the database to query to identify non-target contaminants. |


Ensure the scaffolded assembly is provided in FASTA format and that the Kraken2 database is correctly selected from the available system data tables or provided as a compatible archive. While the workflow is designed for individual datasets, you can utilize dataset collections to process multiple assemblies in parallel. Please consult the `README.md` for detailed instructions on interpreting the contaminant lists and fine-tuning the BLASTn parameters. For automated execution, you may use `planemo workflow_job_init` to create a `job.yml` file for your inputs.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | NCBI BLAST+ dustmasker | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_dustmasker_wrapper/2.14.1+galaxy2 |  |
| 3 | Text transformation | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sed_tool/9.3+galaxy1 |  |
| 4 | Kraken2 | toolshed.g2.bx.psu.edu/repos/iuc/kraken2/kraken2/2.1.3+galaxy1 |  |
| 5 | NCBI BLAST+ blastn | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_blastn_wrapper/2.14.1+galaxy2 |  |
| 6 | Cut | Cut1 |  |
| 7 | Parse mitochondrial blast | toolshed.g2.bx.psu.edu/repos/iuc/parse_mito_blast/parse_mito_blast/1.0.2+galaxy0 |  |
| 8 | Filter | Filter1 |  |
| 9 | Cut | Cut1 |  |
| 10 | Concatenate datasets | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cat/9.3+galaxy1 |  |
| 11 | gfastats | toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.6+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | Kraken2 classification scores | output |
| 7 | mito_scaff_names | mito_scaff_names |
| 8 | contaminants_table | out_file1 |
| 10 | full contaminant + mito scaffold list | out_file1 |
| 11 | final decontaminated assembly | output |


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