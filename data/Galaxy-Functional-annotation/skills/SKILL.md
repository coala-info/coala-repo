---
name: functional-annotation
description: This Galaxy workflow performs functional annotation of protein sequences using eggNOG Mapper and InterProScan to identify orthologous groups and conserved protein domains. Use this skill when you need to characterize the biological roles of predicted proteins and assign Gene Ontology terms or metabolic pathways to a newly sequenced organism.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# functional-annotation

## Overview

This workflow provides a streamlined pipeline for the functional annotation of protein sequences, enabling researchers to assign biological meaning to genomic data. By processing raw protein inputs, the workflow identifies orthologous groups, gene ontologies, and functional domains essential for downstream biological analysis.

The analysis is powered by two industry-standard tools: [eggNOG Mapper](https://toolshed.g2.bx.psu.edu/repos/galaxyp/eggnog_mapper/eggnog_mapper/2.1.8+galaxy3), which performs fast functional annotation based on precomputed orthology, and [InterProScan](https://toolshed.g2.bx.psu.edu/repos/bgruening/interproscan/interproscan/5.59-91.0+galaxy3), which scans sequences against multiple protein signature databases to identify motifs and families.

The final outputs include comprehensive annotation files and TSV reports detailing the functional characteristics of the input sequences. This workflow is tagged for Genome-annotation and follows [GTN](https://training.galaxyproject.org/) (Galaxy Training Network) standards, provided under a GPL-3.0-or-later license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Protein sequences | data_input | Some protein sequences to functionally annotate |


Ensure your protein sequences are in FASTA format, as both eggNOG Mapper and InterProScan require standard amino acid sequences for accurate orthology and domain mapping. For large-scale projects involving multiple proteomes, organizing your inputs into a dataset collection will streamline the parallel execution of these computationally intensive tools. Consult the accompanying README.md for specific parameter recommendations and database versioning details essential for reproducible functional annotation. You can automate the setup of these inputs by using `planemo workflow_job_init` to generate a `job.yml` file.

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
planemo run functional.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run functional.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run functional.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init functional.ga -o job.yml`
- Lint: `planemo workflow_lint functional.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `functional.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)