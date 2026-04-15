---
name: functional-annotation
description: This Galaxy workflow performs functional annotation of protein sequences using eggNOG Mapper and InterProScan to identify orthologous groups and conserved protein domains. Use this skill when you need to characterize the biological roles, metabolic pathways, and molecular functions of predicted proteins from a genome annotation project.
homepage: https://eurosciencegateway.eu/
metadata:
  docker_image: "N/A"
---

# functional-annotation

## Overview

This workflow provides a comprehensive pipeline for the functional annotation of protein sequences, designed to assign biological meaning to genomic data. By identifying orthologous groups, functional categories, and protein domains, it enables researchers to characterize the proteome of an organism. The process begins with a set of protein sequences provided as the primary input.

The analysis is performed using two industry-standard tools: [eggNOG Mapper](https://toolshed.g2.bx.psu.edu/repos/galaxyp/eggnog_mapper/eggnog_mapper/2.1.8+galaxy3) and [InterProScan](https://toolshed.g2.bx.psu.edu/repos/bgruening/interproscan/interproscan/5.59-91.0+galaxy3). EggNOG Mapper facilitates fast functional annotation based on precomputed orthology assignments, while InterProScan scans sequences against multiple protein signature databases to identify conserved domains, families, and motifs.

The final outputs include detailed annotation files and TSV reports containing functional insights such as Gene Ontology (GO) terms, KEGG pathways, and domain architectures. This workflow is a critical component for `genome-annotation` projects and is released under the GPL-3.0-or-later license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Protein sequences | data_input | Some protein sequences to functionally annotate |


Ensure protein sequences are provided in FASTA format with unique identifiers to ensure compatibility with both eggNOG-mapper and InterProScan. If processing multiple proteomes, utilize dataset collections to streamline the workflow execution and manage outputs efficiently. Refer to the `README.md` for comprehensive details on database dependencies and specific tool settings. You may also use `planemo workflow_job_init` to create a `job.yml` for reproducible command-line execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | eggNOG Mapper | toolshed.g2.bx.psu.edu/repos/galaxyp/eggnog_mapper/eggnog_mapper/2.1.8+galaxy3 |  |
| 2 | InterProScan | toolshed.g2.bx.psu.edu/repos/bgruening/interproscan/interproscan/5.59-91.0+galaxy3 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | annotations | annotations |
| 2 | outfile_tsv | outfile_tsv |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Functional annotation of protein sequences.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Functional annotation of protein sequences.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Functional annotation of protein sequences.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Functional annotation of protein sequences.ga -o job.yml`
- Lint: `planemo workflow_lint Functional annotation of protein sequences.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Functional annotation of protein sequences.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)