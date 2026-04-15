---
name: kmer-counting-meryl
description: This Galaxy workflow processes Illumina sequencing reads using Meryl for k-mer counting and GenomeScope for downstream statistical analysis. Use this skill when you need to estimate genome size, heterozygosity, and repeat content from raw sequencing data to assess the complexity of a genome before assembly.
homepage: https://usegalaxy.org.au/
metadata:
  docker_image: "N/A"
---

# kmer-counting-meryl

## Overview

This workflow performs k-mer counting and genomic profiling using Illumina sequencing data. It utilizes [Meryl](https://toolshed.g2.bx.psu.edu/repos/iuc/meryl/meryl/1.3+galaxy4) to process raw reads and generate a k-mer database, which serves as the foundation for estimating genome characteristics.

The pipeline consists of two primary stages. First, Meryl counts k-mers from the input reads and produces a frequency histogram. This histogram is then passed to [GenomeScope](https://toolshed.g2.bx.psu.edu/repos/iuc/genomescope/genomescope/2.0+galaxy1), which applies a mathematical model to estimate genome size, heterozygosity, and repeat content.

The workflow generates several key outputs, including the Meryl database and histogram files. GenomeScope provides detailed summary reports, model parameters, and multiple visualizations—such as transformed log and linear plots—to help researchers interpret the genomic landscape of their samples.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Illumina reads R1 | data_input |  |


Provide high-quality FASTQ files as the primary input to ensure accurate k-mer frequency calculations during the Meryl indexing steps. While individual datasets are supported, utilizing dataset collections is more efficient when processing multiple sequencing libraries or paired-end data through the k-mer counting pipeline. Consult the `README.md` for comprehensive details on selecting optimal k-mer sizes and interpreting the resulting GenomeScope plots. For automated execution, use `planemo workflow_job_init` to create a `job.yml` file for defining your input paths and parameters.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl/meryl/1.3+galaxy4 |  |
| 2 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl/meryl/1.3+galaxy4 |  |
| 3 | GenomeScope | toolshed.g2.bx.psu.edu/repos/iuc/genomescope/genomescope/2.0+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | Meryl on input dataset(s): read-db.meryldb | read_db |
| 2 | read_db_hist | read_db_hist |
| 3 | summary | summary |
| 3 | model | model |
| 3 | progress | progress |
| 3 | GenomeScope on input dataset(s) Transformed log plot | transformed_log_plot |
| 3 | GenomeScope on input dataset(s) Log plot | log_plot |
| 3 | GenomeScope on input dataset(s) Linear plot | linear_plot |
| 3 | GenomeScope on input dataset(s) Transformed linear plot | transformed_linear_plot |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-kmer_counting.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-kmer_counting.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-kmer_counting.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-kmer_counting.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-kmer_counting.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-kmer_counting.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)