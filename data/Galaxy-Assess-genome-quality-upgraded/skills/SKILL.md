---
name: assess-genome-quality-upgraded
description: "This Galaxy workflow assesses the quality of a polished genome assembly and a reference genome using BUSCO for evolutionary completeness and QUAST for structural metrics. Use this skill when you need to determine the biological integrity and assembly statistics of a de novo genome to verify its suitability for downstream genomic research."
homepage: https://workflowhub.eu/workflows/1580
---

# Assess genome quality - upgraded

## Overview

This Galaxy workflow provides a streamlined pipeline for evaluating the quality and completeness of genomic assemblies. It is designed to process a polished assembly alongside a reference genome to generate standardized quality metrics, following best practices often highlighted in [GTN](https://training.galaxyproject.org/) (Galaxy Training Network) tutorials.

The workflow integrates two primary analytical tools: [Busco](https://busco.ezlab.org/) and [Quast](https://quast.sourceforge.net/). Busco assesses the biological completeness of the assembly by identifying the presence of universal single-copy orthologs. Simultaneously, Quast calculates various assembly statistics—such as N50, contig counts, and misassemblies—by comparing the polished assembly against the provided reference genome.

Upon completion, the workflow generates comprehensive outputs including a Busco short summary and detailed data table, as well as an interactive Quast HTML report. These results allow researchers to quickly determine the structural integrity and gene-content conservation of their genome assemblies under the [GPL-3.0-or-later](https://www.gnu.org/licenses/gpl-3.0.en.html) license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Polished assembly | data_input |  |
| 1 | Reference genome | data_input |  |


Ensure your polished assembly and reference genome are provided in FASTA format to ensure compatibility with BUSCO and QUAST. While individual datasets are suitable for single runs, utilizing data collections is more efficient when evaluating multiple assembly iterations or lineages. Please consult the `README.md` for exhaustive documentation on specific tool parameters and lineage datasets. For automated testing or batch execution, you can generate a configuration file using `planemo workflow_job_init`.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.5.0+galaxy0 |  |
| 3 | Quast | toolshed.g2.bx.psu.edu/repos/iuc/quast/quast/5.2.0+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | Busco short summary | busco_sum |
| 2 | busco_table | busco_table |
| 3 | Quast on input dataset(s):  HTML report | report_html |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-workflow-assess-genome-quality.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-workflow-assess-genome-quality.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-workflow-assess-genome-quality.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-workflow-assess-genome-quality.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-workflow-assess-genome-quality.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-workflow-assess-genome-quality.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
