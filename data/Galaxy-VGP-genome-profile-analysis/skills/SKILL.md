---
name: vgp-genome-profile-analysis
description: This Galaxy workflow processes PacBio sequencing data using Meryl and GenomeScope to generate k-mer databases and estimate genome characteristics such as size, heterozygosity, and repetitiveness. Use this skill when you need to perform initial genome profiling and quality control to determine optimal assembly parameters for a new reference genome.
homepage: https://usegalaxy.eu
metadata:
  docker_image: "N/A"
---

# vgp-genome-profile-analysis

## Overview

This workflow is a specialized component of the Vertebrate Genomes Project (VGP) pipeline designed for initial genome profiling. Its primary purpose is to generate a [Meryl](https://toolshed.g2.bx.psu.edu/repos/iuc/meryl/meryl/1.3+galaxy4) database from raw sequencing reads, which serves as a foundational requirement for downstream assembly parameter estimation and quality control using tools like Merqury.

The process begins by taking a collection of PacBio data and user-specified parameters for k-mer length and ploidy. It employs [Meryl](https://toolshed.g2.bx.psu.edu/repos/iuc/meryl/meryl/1.3+galaxy4) to perform k-mer counting and merging, resulting in a consolidated k-mer database. This data is then analyzed by [GenomeScope](https://toolshed.g2.bx.psu.edu/repos/iuc/genomescope/genomescope/2.0+galaxy1) to model the genomic profile.

The workflow produces several critical outputs, including the merged Meryl database and a comprehensive [GenomeScope](https://toolshed.g2.bx.psu.edu/repos/iuc/genomescope/genomescope/2.0+galaxy1) report. These results provide detailed insights into genome size, heterozygosity, and repeat content through various visualizations, such as linear and log-scale plots, as well as specific model parameters necessary for high-quality genome assembly.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Collection of Pacbio Data | data_collection_input | Collection of Pacbio Data in fastq format. |
| 1 | K-mer length | parameter_input | K-mer length used to calculate k-mer spectra. For a human genome, the best k-mer size is k=21 for both haploid (3.1G) or diploid (6.2G). |
| 2 | Ploidy | parameter_input | Ploidy for model to use. Default=2 |


For optimal results, provide your PacBio reads as a list collection of fastq.gz files to streamline the Meryl database construction. Ensure that the k-mer length and ploidy parameters are tailored to your specific organism to produce accurate GenomeScope profiles. Consult the README.md for detailed instructions on data preparation and parameter optimization. You may also use `planemo workflow_job_init` to create a `job.yml` for configuring your workflow runs.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl/meryl/1.3+galaxy4 |  |
| 4 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl/meryl/1.3+galaxy4 |  |
| 5 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl/meryl/1.3+galaxy4 |  |
| 6 | GenomeScope | toolshed.g2.bx.psu.edu/repos/iuc/genomescope/genomescope/2.0+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | Merged Meryl Database | read_db |
| 6 | summary | summary |
| 6 | model | model |
| 6 | GenomeScope on input dataset(s) Transformed linear plot | transformed_linear_plot |
| 6 | GenomeScope on input dataset(s) Linear plot | linear_plot |
| 6 | GenomeScope on input dataset(s) Log plot | log_plot |
| 6 | GenomeScope on input dataset(s) Transformed log plot | transformed_log_plot |
| 6 | model_params | model_params |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run genome_profiling.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run genome_profiling.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run genome_profiling.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init genome_profiling.ga -o job.yml`
- Lint: `planemo workflow_lint genome_profiling.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `genome_profiling.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)