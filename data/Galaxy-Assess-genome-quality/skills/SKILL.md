---
name: assess-genome-quality
description: "This genomics workflow evaluates the quality of a polished assembly relative to a reference genome using BUSCO for gene content completeness and QUAST for structural assembly metrics. Use this skill when you need to validate the integrity and biological completeness of a de novo genome assembly before proceeding with functional annotation or comparative genomics."
homepage: https://workflowhub.eu/workflows/229
---

# Assess genome quality

## Overview

This workflow evaluates the quality and biological completeness of a genomic assembly. It requires two primary inputs: a polished assembly and a reference genome for comparative benchmarking. The process is designed to provide a comprehensive overview of assembly contiguity and gene content.

The pipeline integrates two industry-standard tools: [Busco](https://busco.ezlab.org/) and [Quast](https://quast.sourceforge.net/). Busco assesses the assembly by searching for Benchmarking Universal Single-Copy Orthologs, offering a metric for genomic completeness. Simultaneously, Quast performs a structural evaluation, comparing the polished assembly against the reference to identify misassemblies, unaligned sequences, and various N50 statistics.

The workflow generates a variety of diagnostic outputs, including visual summaries and detailed reports in HTML, PDF, and tabular formats. These results allow researchers to quickly identify missing orthologs and structural discrepancies, ensuring the assembly is suitable for downstream analysis. This workflow is tagged under **LG-WF**.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Polished assembly | data_input |  |
| 1 | Reference genome | data_input |  |


Ensure both the polished assembly and reference genome are provided in FASTA format with consistent header naming to avoid processing errors in BUSCO and QUAST. While single datasets are standard, you may use dataset collections to assess multiple assembly versions in a single workflow run. Consult the `README.md` for detailed instructions on selecting the correct BUSCO lineage and specific QUAST thresholds for your target organism. For automated testing or command-line execution, use `planemo workflow_job_init` to create a template `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.2.2+galaxy0 |  |
| 3 | Quast | toolshed.g2.bx.psu.edu/repos/iuc/quast/quast/5.0.2+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | busco_table | busco_table |
| 2 | Busco summary image | summary_image |
| 2 | busco_missing | busco_missing |
| 2 | Busco short summary | busco_sum |
| 3 | Quast on input dataset(s): Log | log |
| 3 | unalign | unalign |
| 3 | Quast on input dataset(s):  PDF report | report_pdf |
| 3 | Quast on input dataset(s): tabular report | quast_tabular |
| 3 | Quast on input dataset(s):  HTML report | report_html |
| 3 | mis_ass | mis_ass |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Assess_genome_quality.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Assess_genome_quality.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Assess_genome_quality.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Assess_genome_quality.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Assess_genome_quality.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Assess_genome_quality.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
