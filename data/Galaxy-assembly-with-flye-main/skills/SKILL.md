---
name: genome-assembly-with-flye
description: "This workflow assembles long-read sequencing data from PacBio or Oxford Nanopore using Flye and generates quality metrics and visualizations via Quast, Fasta Statistics, and Bandage. Use this skill when you need to generate a de novo genome assembly from noisy or high-fidelity long reads and evaluate the resulting contiguity and assembly graph structure."
homepage: https://workflowhub.eu/workflows/750
---

# Genome assembly with Flye

## Overview

This workflow provides an automated pipeline for de novo genome assembly using long-read sequencing data from platforms such as Oxford Nanopore or PacBio (HiFi and non-HiFi). It is designed to take raw reads in various formats (FASTA/FASTQ) and generate a high-quality consensus assembly.

The core assembly is performed by [Flye](https://toolshed.g2.bx.psu.edu/repos/bgruening/flye/flye/2.9.6+galaxy0), a versatile assembler that handles a wide range of error rates and read lengths. Following the assembly, the workflow evaluates the results using [Quast](https://toolshed.g2.bx.psu.edu/repos/iuc/quast/quast/5.3.0+galaxy1) for quality assessment and [Fasta Statistics](https://toolshed.g2.bx.psu.edu/repos/iuc/fasta_stats/fasta-stats/2.0) for a summary of the contig metrics.

To assist with structural analysis, the workflow utilizes [Bandage Image](https://toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/2022.09+galaxy4) to render a visual representation of the assembly graph. Users can customize the assembly by adjusting the Flye sequencing mode or Quast organism settings at runtime to match their specific dataset.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input sequence reads | data_input | Sequence reads e.g. nanopore |


Ensure your input sequence reads are in FASTA or FASTQ format (compressed or uncompressed) and correctly labeled as PacBio or Oxford Nanopore data within the Flye tool settings. While single datasets are standard, you may use dataset collections to process multiple samples simultaneously through the workflow. Refer to the project README.md for comprehensive details on parameter adjustments for specific sequencing technologies and organism types. You can streamline your execution by using `planemo workflow_job_init` to generate a `job.yml` file for automated input mapping.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Flye | toolshed.g2.bx.psu.edu/repos/bgruening/flye/flye/2.9.6+galaxy0 |  |
| 2 | Quast | toolshed.g2.bx.psu.edu/repos/iuc/quast/quast/5.3.0+galaxy1 |  |
| 3 | Fasta Statistics | toolshed.g2.bx.psu.edu/repos/iuc/fasta_stats/fasta-stats/2.0 |  |
| 4 | Bandage Image | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/2022.09+galaxy4 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | Flye assembly (consensus) | consensus |
| 1 | Flye assembly (assembly_graph) | assembly_graph |
| 1 | Flye assembly (Graphical Fragment Assembly) | assembly_gfa |
| 1 | Flye assembly (assembly_info) | assembly_info |
| 2 | Quast: HTML report | report_html |
| 3 | Flye assembly statistics | stats_output |
| 4 | Bandage Image: Assembly Graph Image | outfile |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Genome-assembly-with-Flye.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Genome-assembly-with-Flye.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Genome-assembly-with-Flye.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Genome-assembly-with-Flye.ga -o job.yml`
- Lint: `planemo workflow_lint Genome-assembly-with-Flye.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Genome-assembly-with-Flye.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
