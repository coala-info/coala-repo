---
name: assembly-with-flye
description: "This Galaxy workflow performs de novo assembly of long-read sequencing data using Flye and evaluates the resulting contigs with Quast, Bandage, and Fasta Statistics. Use this skill when you need to reconstruct a genome from noisy long reads and require comprehensive quality metrics and visual representations of the assembly graph."
homepage: https://workflowhub.eu/workflows/225
---

# Assembly with Flye

## Overview

This workflow performs *de novo* assembly of long-read sequencing data using [Flye](https://github.com/fenderglass/Flye). It is designed to take raw long reads as input and generate a high-quality consensus assembly along with the underlying assembly graph in GFA format.

Beyond the initial assembly, the pipeline integrates several tools for structural visualization and statistical evaluation. [Bandage](https://rrwick.github.io/Bandage/) generates a graphical representation of the assembly fragments, while [Fasta Statistics](https://github.com/galaxyproject/tools-iuc/tree/master/tools/fasta_stats) and a Gnuplot-based bar chart provide a detailed breakdown of contig sizes and distribution.

To ensure the reliability of the results, the workflow utilizes [Quast](http://quast.sourceforge.net/quast) to produce comprehensive quality reports. These outputs include HTML and PDF summaries that detail key assembly metrics, allowing users to assess the completeness and accuracy of the generated contigs. This workflow is tagged with LG-WF for easy categorization within the Galaxy environment.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | long reads | data_input |  |


Ensure your long-read data is uploaded in fastq, fasta, or compressed fastq.gz format to ensure compatibility with the Flye assembler. While the workflow accepts individual datasets, using dataset collections is recommended for efficiently managing and processing multiple sequencing runs simultaneously. Please consult the README.md for exhaustive documentation on input requirements and specific tool parameters. You can also utilize `planemo workflow_job_init` to create a `job.yml` for streamlined execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Flye assembly | toolshed.g2.bx.psu.edu/repos/bgruening/flye/flye/2.8.2+galaxy0 |  |
| 2 | Fasta Statistics | toolshed.g2.bx.psu.edu/repos/iuc/fasta_stats/fasta-stats/1.0.3 |  |
| 3 | Bandage Image | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/0.8.1+galaxy3 |  |
| 4 | Quast | toolshed.g2.bx.psu.edu/repos/iuc/quast/quast/5.0.2+galaxy1 |  |
| 5 | Bar chart | barchart_gnuplot |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | Flye assembly on input dataset(s) (consensus) | consensus |
| 1 | Flye assembly on input dataset(s) (assembly_graph) | assembly_graph |
| 1 | Flye assembly on input dataset(s) (Graphical Fragment Assembly) | assembly_gfa |
| 1 | Flye assembly on input dataset(s) (assembly_info) | assembly_info |
| 1 | Flye assembly on input dataset(s) (log) | flye_log |
| 2 | stats | stats |
| 3 | Bandage Image on input dataset(s): Assembly Graph Image | outfile |
| 4 | Quast on input dataset(s): Log | log |
| 4 | Quast on input dataset(s):  PDF report | report_pdf |
| 4 | Quast on input dataset(s): tabular report | quast_tabular |
| 4 | Quast on input dataset(s):  HTML report | report_html |
| 5 | Bar chart showing contig sizes | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Assembly_with_Flye.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Assembly_with_Flye.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Assembly_with_Flye.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Assembly_with_Flye.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Assembly_with_Flye.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Assembly_with_Flye.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
