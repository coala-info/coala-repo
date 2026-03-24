---
name: genome-annotation-with-prokka
description: "This Galaxy workflow performs rapid prokaryotic genome annotation on FASTA contigs using Prokka and generates visualizable results with JBrowse. Use this skill when you need to identify protein-coding genes, tRNA, and rRNA sequences in a newly assembled bacterial or archaeal genome to characterize its functional potential."
homepage: https://workflowhub.eu/workflows/1497
---

# Genome Annotation with Prokka

## Overview

This workflow provides an automated pipeline for the rapid functional annotation of prokaryotic genomes. It accepts a FASTA file of genomic contigs as input and leverages [Prokka](https://toolshed.g2.bx.psu.edu/repos/crs4/prokka/prokka/1.14.5) to identify and label genomic features such as coding sequences (CDS), ribosomal RNA (rRNA), and transfer RNA (tRNA) genes.

The process begins by running the Prokka suite, which coordinates several analysis tools to produce a comprehensive annotation set. Following the annotation step, the workflow utilizes [JBrowse](https://toolshed.g2.bx.psu.edu/repos/iuc/jbrowse/jbrowse/1.16.11+galaxy1) to generate an interactive, web-based visualization of the genome, allowing researchers to manually inspect the spatial distribution of identified features.

The primary output is a standardized GFF3 file containing the structural and functional annotations. Developed in alignment with [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) standards and licensed under GPL-3.0-or-later, this workflow is a reliable tool for microbial genomics and comparative analysis.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | contigs.fasta | data_input |  |


Ensure your input is a high-quality FASTA file containing assembled contigs, as Prokka relies on these sequences for accurate gene prediction and functional annotation. While the workflow is configured for individual datasets, utilizing dataset collections is highly recommended when processing multiple genomes to maintain organizational efficiency. For comprehensive details on specific tool parameters and environment setup, please consult the README.md file. You may also use `planemo workflow_job_init` to create a `job.yml` file for streamlined local testing and execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Prokka | toolshed.g2.bx.psu.edu/repos/crs4/prokka/prokka/1.14.5 |  |
| 2 | JBrowse | toolshed.g2.bx.psu.edu/repos/iuc/jbrowse/jbrowse/1.16.11+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | gff_output | out_gff |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-workflow-workflow-constructed-from-history--prokka-workflow-.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-workflow-workflow-constructed-from-history--prokka-workflow-.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-workflow-workflow-constructed-from-history--prokka-workflow-.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-workflow-workflow-constructed-from-history--prokka-workflow-.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-workflow-workflow-constructed-from-history--prokka-workflow-.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-workflow-workflow-constructed-from-history--prokka-workflow-.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
