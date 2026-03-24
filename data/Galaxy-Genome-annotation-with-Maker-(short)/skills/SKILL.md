---
name: genome-annotation-with-maker-short
description: "This Galaxy workflow performs genome annotation by integrating genome sequences, EST/cDNA, and protein data using Maker, while validating results with Busco and visualizing them in JBrowse. Use this skill when you need to identify gene structures in a newly assembled genome and assess the completeness of the resulting gene set using ortholog benchmarks."
homepage: https://workflowhub.eu/workflows/1549
---

# Genome annotation with Maker (short)

## Overview

This workflow provides a streamlined pipeline for structural genome annotation using the [Maker](https://toolshed.g2.bx.psu.edu/repos/iuc/maker/maker/2.31.10) ecosystem. It integrates a reference genome assembly with transcriptomic evidence (EST/cDNA) and protein homology data, utilizing ab initio gene predictors such as SNAP and Augustus to generate high-quality gene models.

The process begins with an initial quality assessment of the input assembly using [Fasta Statistics](https://toolshed.g2.bx.psu.edu/repos/simon-gladman/fasta_stats/fasta-stats/1.0.0) and [Busco](https://toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/3.0.2+galaxy1) to establish a baseline for genome completeness. Following the annotation run, the workflow automatically maps and renames annotation IDs to ensure standardized nomenclature across the resulting datasets.

Final outputs include comprehensive genome annotation statistics, extracted sequences for CDS, exons, and peptides via [gffread](https://toolshed.g2.bx.psu.edu/repos/devteam/gffread/gffread/2.2.1.1), and an interactive [JBrowse](https://toolshed.g2.bx.psu.edu/repos/iuc/jbrowse/jbrowse/1.16.4+galaxy3) instance for visual inspection. A final round of Busco analysis is performed on the predicted proteins to validate the biological completeness of the annotated gene set.

This workflow is tagged with **Genome-annotation** and **GTN**, making it an ideal resource for researchers following Galaxy Training Network tutorials or performing rapid annotation of small to mid-sized eukaryotic genomes.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Genome sequence | data_input |  |
| 1 | EST and/or cDNA | data_input |  |
| 2 | Proteins | data_input |  |
| 3 | SNAP model | data_input |  |
| 4 | Augustus model | data_input |  |


Ensure your genome, EST, and protein sequences are in FASTA format, while SNAP and Augustus models must be provided as HMM or model files respectively. While individual datasets are standard for this workflow, using collections for protein or EST evidence can streamline processing if you have multiple source files. Refer to the README.md for comprehensive details on parameter tuning and model training requirements. You can use `planemo workflow_job_init` to generate a `job.yml` for automated testing and execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 5 | Fasta Statistics | toolshed.g2.bx.psu.edu/repos/simon-gladman/fasta_stats/fasta-stats/1.0.0 |  |
| 6 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/3.0.2+galaxy1 |  |
| 7 | Maker | toolshed.g2.bx.psu.edu/repos/iuc/maker/maker/2.31.10 |  |
| 8 | Map annotation ids | toolshed.g2.bx.psu.edu/repos/iuc/maker_map_ids/maker_map_ids/2.31.10 |  |
| 9 | Genome annotation statistics | toolshed.g2.bx.psu.edu/repos/iuc/jcvi_gff_stats/jcvi_gff_stats/0.8.4 |  |
| 10 | gffread | toolshed.g2.bx.psu.edu/repos/devteam/gffread/gffread/2.2.1.1 |  |
| 11 | JBrowse | toolshed.g2.bx.psu.edu/repos/iuc/jbrowse/jbrowse/1.16.4+galaxy3 |  |
| 12 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/3.0.2+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | stats | stats |
| 6 | busco_sum | busco_sum |
| 6 | busco_missing | busco_missing |
| 6 | busco_table | busco_table |
| 8 | renamed | renamed |
| 9 | graphs | graphs |
| 9 | summary | summary |
| 10 | output_cds | output_cds |
| 10 | output_exons | output_exons |
| 10 | output_pep | output_pep |
| 11 | output | output |
| 12 | Busco summary final round | busco_sum |


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
