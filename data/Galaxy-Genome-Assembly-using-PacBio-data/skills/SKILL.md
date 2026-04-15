---
name: genome-assembly-using-pacbio-data
description: This Galaxy workflow performs de novo genome assembly from PacBio long reads and a reference genome using the Flye assembler followed by quality assessment with BUSCO and QUAST. Use this skill when you need to reconstruct a complete genome from long-read sequencing data and evaluate the biological completeness and structural accuracy of the resulting assembly.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# genome-assembly-using-pacbio-data

## Overview

This workflow is designed for *de novo* genome assembly using long-read PacBio data. It takes raw PacBio reads and a reference genome as inputs to generate a high-quality assembly, following best practices often associated with [GTN](https://training.galaxyproject.org/) tutorials.

The core assembly is performed by [Flye](https://toolshed.g2.bx.psu.edu/repos/bgruening/flye/flye/2.9+galaxy0), a versatile assembler for long and noisy reads. The tool generates a consensus sequence along with graphical representations of the assembly, including a Graphical Fragment Assembly (GFA) and an assembly graph, which are essential for understanding the connectivity of the genomic contigs.

To ensure the reliability of the results, the workflow includes several quality assessment steps. It utilizes [Fasta Statistics](https://toolshed.g2.bx.psu.edu/repos/iuc/fasta_stats/fasta-stats/2.0) for basic metric reporting, [Busco](https://toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.2.2+galaxy2) to evaluate completeness based on conserved orthologs, and [Quast](https://toolshed.g2.bx.psu.edu/repos/iuc/quast/quast/5.0.2+galaxy3) for a detailed comparison against the reference genome.

This workflow is licensed under GPL-3.0-or-later and provides a standardized pipeline for researchers looking to transform raw PacBio sequences into annotated, high-quality genomic assemblies.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | PacBio reads | data_input | PacBio reads in fastq format |
| 1 | Reference genome | data_input | Reference genome from JGI |


Ensure your PacBio reads are in FASTQ or BAM format and the reference genome is provided as a FASTA file. For high-throughput processing of multiple samples, organize your input reads into a dataset collection to efficiently batch the assembly steps. Refer to the README.md for comprehensive details on parameter tuning and specific tool configurations. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated job execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Flye | toolshed.g2.bx.psu.edu/repos/bgruening/flye/flye/2.9+galaxy0 |  |
| 3 | Fasta Statistics | toolshed.g2.bx.psu.edu/repos/iuc/fasta_stats/fasta-stats/2.0 |  |
| 4 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.2.2+galaxy2 |  |
| 5 | Fasta Statistics | toolshed.g2.bx.psu.edu/repos/iuc/fasta_stats/fasta-stats/2.0 |  |
| 6 | Quast | toolshed.g2.bx.psu.edu/repos/iuc/quast/quast/5.0.2+galaxy3 |  |
| 7 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.2.2+galaxy2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | Flye on input dataset(s): assembly info | assembly_info |
| 2 | Flye on input dataset(s): consensus | consensus |
| 2 | Flye on input dataset(s): graphical fragment assembly | assembly_gfa |
| 2 | Flye on input dataset(s): assembly graph | assembly_graph |
| 5 | stats_output | stats_output |
| 6 | Quast on input dataset(s):  HTML report | report_html |
| 7 | busco_sum | busco_sum |


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