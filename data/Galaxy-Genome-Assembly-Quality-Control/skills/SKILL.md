---
name: genome-assembly-quality-control
description: "This Galaxy workflow evaluates genome assembly quality using PacBio subreads, assembly files, and a reference genome through tools including Busco, Quast, Chromeister, and Merqury. Use this skill when you need to validate the biological completeness, k-mer consensus accuracy, and structural consistency of de novo assemblies to ensure high-quality genomic data for downstream analysis."
homepage: https://workflowhub.eu/workflows/1646
---

# Genome Assembly Quality Control

## Overview

This Galaxy workflow provides a comprehensive quality control (QC) pipeline for evaluating genome assemblies generated from PacBio data. By comparing assembly versions (such as those from Flye and Hifiasm) against a reference genome and raw sequencing reads, the workflow assesses completeness, continuity, and accuracy.

The analysis utilizes several industry-standard tools to generate comparative metrics. [Busco](https://toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.3.2+galaxy0) evaluates biological completeness by identifying conserved orthologs, while [Quast](https://toolshed.g2.bx.psu.edu/repos/iuc/quast/quast/5.2.0+galaxy0) provides structural statistics and misassembly detection. For visual synteny and large-scale rearrangements, [Chromeister](https://toolshed.g2.bx.psu.edu/repos/iuc/chromeister/chromeister/1.5.a+galaxy1) generates comparative dot plots between the assemblies and the reference.

To ensure base-level accuracy and k-mer completeness, the workflow incorporates [Meryl](https://toolshed.g2.bx.psu.edu/repos/iuc/meryl/meryl/1.3+galaxy6) for k-mer counting and [Merqury](https://toolshed.g2.bx.psu.edu/repos/iuc/merqury/merqury/1.3+galaxy2) for reference-free evaluation. These tools allow users to calculate consensus quality (QV) scores and identify potential contamination or missing genomic content based on the original PacBio subreads.

This workflow is licensed under GPL-3.0-or-later and is tagged for Assembly and GTN (Galaxy Training Network) applications, making it suitable for standardized genomic research and training.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | GCA_000146045.2_genomic.fna | data_input |  |
| 1 | Scerevisiae-INSC1019.flye.30x.fa | data_input |  |
| 2 | Scerevisiae-INSC1019.hifiasm.30x.fa | data_input |  |
| 3 | SRR13577847_subreads.30x.fastq.gz | data_input |  |


Ensure your assembly and reference files are in FASTA format, while raw PacBio subreads should be provided as compressed FASTQ (.fastq.gz) files for tools like Meryl and Merqury. While this workflow uses individual datasets for specific assembly comparisons, you may find it efficient to organize larger batches of reads into collections for high-throughput analysis. Refer to the README.md for comprehensive details on parameter settings and the specific lineage datasets required for BUSCO. You can automate the configuration of these input parameters by using `planemo workflow_job_init` to generate a template `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.3.2+galaxy0 |  |
| 5 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.3.2+galaxy0 |  |
| 6 | Quast | toolshed.g2.bx.psu.edu/repos/iuc/quast/quast/5.2.0+galaxy0 |  |
| 7 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.3.2+galaxy0 |  |
| 8 | Chromeister | toolshed.g2.bx.psu.edu/repos/iuc/chromeister/chromeister/1.5.a+galaxy1 |  |
| 9 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl/meryl/1.3+galaxy6 |  |
| 10 | Merqury | toolshed.g2.bx.psu.edu/repos/iuc/merqury/merqury/1.3+galaxy2 |  |
| 11 | Merqury | toolshed.g2.bx.psu.edu/repos/iuc/merqury/merqury/1.3+galaxy2 |  |
| 12 | Merqury | toolshed.g2.bx.psu.edu/repos/iuc/merqury/merqury/1.3+galaxy2 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

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
