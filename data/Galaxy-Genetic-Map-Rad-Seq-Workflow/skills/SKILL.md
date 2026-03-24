---
name: genetic-map-rad-seq-workflow
description: "This Galaxy workflow processes RAD-Seq FASTA files from parents and progeny using Stacks de novo map and genotypes tools to identify markers and call genotypes. Use this skill when you need to construct a genetic map for a population to study inheritance or genomic architecture in species lacking a reference genome."
homepage: https://workflowhub.eu/workflows/1683
---

# Genetic Map Rad Seq Workflow

## Overview

This workflow is designed for ecological and genomic research to construct genetic maps using Restriction site Associated DNA Sequencing (RAD-Seq) data. It provides a standardized pipeline within Galaxy to process raw sequencing reads from a mapping population, specifically optimized for organisms where a reference genome may not be available.

The process begins by taking FASTA sequences from two parents and twenty progeny. These inputs are processed by the [Stacks: de novo map](https://toolshed.g2.bx.psu.edu/repos/iuc/stacks_denovomap/stacks_denovomap/1.46.0) tool, which clusters reads into stacks to identify loci and alleles across the individuals. This step builds a comprehensive catalog of markers without the need for prior genomic alignment.

In the final stage, the [Stacks: genotypes](https://toolshed.g2.bx.psu.edu/repos/iuc/stacks_genotypes/stacks_genotypes/1.46.0) tool analyzes the identified loci to determine the segregation of alleles from parents to offspring. It filters and exports the genotype data into formats suitable for linkage mapping software. This workflow aligns with [GTN](https://training.galaxyproject.org/) (Galaxy Training Network) standards for ecology and evolutionary biology applications.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | female.fa | data_input |  |
| 1 | male.fa | data_input |  |
| 2 | progeny_1.fa | data_input |  |
| 3 | progeny_2.fa | data_input |  |
| 4 | progeny_3.fa | data_input |  |
| 5 | progeny_4.fa | data_input |  |
| 6 | progeny_5.fa | data_input |  |
| 7 | progeny_6.fa | data_input |  |
| 8 | progeny_7.fa | data_input |  |
| 9 | progeny_8.fa | data_input |  |
| 10 | progeny_9.fa | data_input |  |
| 11 | progeny_10.fa | data_input |  |
| 12 | progeny_11.fa | data_input |  |
| 13 | progeny_12.fa | data_input |  |
| 14 | progeny_13.fa | data_input |  |
| 15 | progeny_14.fa | data_input |  |
| 16 | progeny_15.fa | data_input |  |
| 17 | progeny_16.fa | data_input |  |
| 18 | progeny_17.fa | data_input |  |
| 19 | progeny_18.fa | data_input |  |
| 20 | progeny_19.fa | data_input |  |
| 21 | progeny_20.fa | data_input |  |


Ensure all input files are in FASTA format, specifically separating parental reads from individual progeny files to satisfy the Stacks requirements. While this workflow uses individual datasets for each progeny, organizing them into a dataset collection can streamline management in larger RAD-Seq projects. Refer to the `README.md` for comprehensive details on parameter tuning and population map configuration. You can use `planemo workflow_job_init` to generate a `job.yml` for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 22 | Stacks: de novo map | toolshed.g2.bx.psu.edu/repos/iuc/stacks_denovomap/stacks_denovomap/1.46.0 |  |
| 23 | Stacks: genotypes | toolshed.g2.bx.psu.edu/repos/iuc/stacks_genotypes/stacks_genotypes/1.46.0 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run genetic-map-rad-seq.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run genetic-map-rad-seq.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run genetic-map-rad-seq.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init genetic-map-rad-seq.ga -o job.yml`
- Lint: `planemo workflow_lint genetic-map-rad-seq.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `genetic-map-rad-seq.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
