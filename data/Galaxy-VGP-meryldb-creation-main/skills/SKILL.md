---
name: quality-evaluation
description: This genomics workflow processes PacBio HiFi reads using Meryl and GenomeScope to generate a k-mer database and estimate fundamental genomic characteristics. Use this skill when you need to determine genome size, heterozygosity, and repeat content to inform assembly parameters or perform quality control for vertebrate genome projects.
homepage: https://iwc.galaxyproject.org/
metadata:
  docker_image: "N/A"
---

# quality-evaluation

## Overview

This workflow serves as the initial stage of the [Vertebrate Genomes Project (VGP)](https://vertebrategenomesproject.org/) assembly pipeline. Its primary purpose is to generate a Meryl database from Pacbio HiFi long reads, which is essential for estimating assembly parameters and performing k-mer based quality control in downstream steps.

The process utilizes [Meryl](https://github.com/marbl/meryl) to perform k-mer counting and merging across the input data collection. By processing the raw reads with user-defined k-mer lengths and ploidy settings, the workflow creates a comprehensive profile of the genomic data's k-mer distribution.

Following the database creation, the workflow runs [GenomeScope](http://qb.cshl.edu/genomescope/) to analyze the k-mer frequencies. This analysis provides critical insights into genomic complexity, including estimates of genome size, heterozygosity, and repeat content. The resulting outputs include various diagnostic plots (linear and log scales) and model parameters necessary for configuring subsequent assembly workflows and evaluating results with Merqury.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Collection of Pacbio Data | data_collection_input | Collection of Pacbio Data in fastq format. |
| 1 | K-mer length | parameter_input | K-mer length used to calculate k-mer spectra. For a human genome, the best k-mer size is k=21 for both haploid (3.1G) or diploid (6.2G). |
| 2 | Ploidy | parameter_input | Ploidy for model to use. Default=2 |


Ensure your PacBio HiFi reads are provided as a dataset collection of FASTQ files to allow the Meryl tool to process the data efficiently in parallel. Verify that the k-mer length and ploidy parameters match your specific organism's characteristics for accurate GenomeScope modeling. Refer to the README.md for comprehensive details on selecting the optimal k-mer size and preparing your input collections. You can automate the configuration of these inputs using `planemo workflow_job_init` to generate a template `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl/meryl/1.3+galaxy5 |  |
| 4 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl/meryl/1.3+galaxy5 |  |
| 5 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl/meryl/1.3+galaxy5 |  |
| 6 | GenomeScope | toolshed.g2.bx.psu.edu/repos/iuc/genomescope/genomescope/2.0+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | Merged Meryl Database | read_db |
| 6 | GenomeScope summary | summary |
| 6 | GenomeScope model | model |
| 6 | GenomeScope transformed linear plot | transformed_linear_plot |
| 6 | GenomeScope linear plot | linear_plot |
| 6 | GenomeScope log plot | log_plot |
| 6 | GenomeScope transformed log plot | transformed_log_plot |
| 6 | GenomeScope model parameters | model_params |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run meryldb-creation.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run meryldb-creation.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run meryldb-creation.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init meryldb-creation.ga -o job.yml`
- Lint: `planemo workflow_lint meryldb-creation.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `meryldb-creation.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)