---
name: kmer-profiling-hifi-trio-vgp2
description: This VGP workflow utilizes Meryl and GenomeScope to process PacBio HiFi reads alongside paternal and maternal sequencing data for k-mer frequency analysis and haplotype partitioning. Use this skill when you need to estimate genomic complexity, including genome size, heterozygosity, and repeat content, while generating haplotype-specific k-mer databases for trio-based assembly quality control.
homepage: https://iwc.galaxyproject.org/
metadata:
  docker_image: "N/A"
---

# kmer-profiling-hifi-trio-vgp2

## Overview

This Galaxy workflow is a critical component of the [Vertebrate Genomes Project (VGP)](https://vertebrategenomesproject.org/) pipeline, designed to analyze genomic complexity and data quality through *k*-mer profiling. By processing PacBio HiFi long reads from an offspring alongside short-read sequencing data from both parents, the workflow estimates essential assembly parameters such as genome size, heterozygosity levels, and repeat content.

The process utilizes [Meryl](https://github.com/marbl/meryl) to count and group *k*-mers, effectively partitioning the offspring's long reads into haplotype-specific databases. These databases serve as the foundation for downstream quality control and assembly validation, particularly for use with tools like Merqury.

The final outputs include comprehensive [GenomeScope](http://qb.cshl.edu/genomescope/genomescope2.0/) profiles for the child and both parental genomes. These profiles provide visual diagnostics through linear and log plots, as well as detailed summary statistics and model parameters necessary for high-quality genome assembly. This workflow is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) and carries the VGP Reviewed tag.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Pacbio Hifi reads | data_collection_input |  |
| 1 | Paternal reads | data_collection_input | Collection of Illumina reads for the father of the Individual sequenced with Pacbio Hifi. |
| 2 | Maternal reads | data_collection_input | Collection of Illumina reads for the mother of the Individual sequenced with Pacbio Hifi. |
| 3 | K-mer length | parameter_input |  |
| 4 | Ploidy | parameter_input |  |


Ensure all HiFi and parental reads are provided as fastq or fastq.gz data collections to maintain the expected workflow structure. For optimal results, verify that the k-mer length and ploidy parameters align with your specific organism's genomic characteristics. Detailed instructions on data preparation and parameter selection can be found in the accompanying README.md file. You can use `planemo workflow_job_init` to generate a `job.yml` file for streamlined execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 5 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 6 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl_count_kmers/meryl_count_kmers/1.3+galaxy7 |  |
| 7 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl/meryl/1.3+galaxy6 |  |
| 8 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl/meryl/1.3+galaxy6 |  |
| 9 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl_groups_kmers/meryl_groups_kmers/1.3+galaxy7 |  |
| 10 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl_groups_kmers/meryl_groups_kmers/1.3+galaxy7 |  |
| 11 | GenomeScope | toolshed.g2.bx.psu.edu/repos/iuc/genomescope/genomescope/2.0.1+galaxy0 |  |
| 12 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl_histogram_kmers/meryl_histogram_kmers/1.3+galaxy7 |  |
| 13 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl_histogram_kmers/meryl_histogram_kmers/1.3+galaxy7 |  |
| 14 | GenomeScope | toolshed.g2.bx.psu.edu/repos/iuc/genomescope/genomescope/2.0.1+galaxy0 |  |
| 15 | GenomeScope | toolshed.g2.bx.psu.edu/repos/iuc/genomescope/genomescope/2.0.1+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 8 | Meryl database : maternal | mat_db |
| 8 | Meryl database : Child | read_db |
| 8 | Meryl database : paternal | pat_db |
| 11 | GenomeScope transformed linear plot (child) | transformed_linear_plot |
| 11 | GenomeScope transformed log plot (child) | transformed_log_plot |
| 11 | GenomeScope summary (child) | summary |
| 11 | GenomeScope linear plot (child) | linear_plot |
| 11 | GenomeScope log plot (child) | log_plot |
| 11 | GenomeScope Model Parameters (child) | model_params |
| 14 | GenomeScope linear plot (paternal) | linear_plot |
| 14 | GenomeScope transformed log plot (paternal) | transformed_log_plot |
| 14 | GenomeScope log plot (paternal) | log_plot |
| 14 | GenomeScope transformed linear plot (paternal) | transformed_linear_plot |
| 15 | GenomeScope linear plot (maternal) | linear_plot |
| 15 | GenomeScope log plot (maternal) | log_plot |
| 15 | GenomeScope transformed log plot (maternal) | transformed_log_plot |
| 15 | GenomeScope transformed linear plot (maternal) | transformed_linear_plot |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run kmer-profiling-hifi-trio-VGP2.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run kmer-profiling-hifi-trio-VGP2.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run kmer-profiling-hifi-trio-VGP2.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init kmer-profiling-hifi-trio-VGP2.ga -o job.yml`
- Lint: `planemo workflow_lint kmer-profiling-hifi-trio-VGP2.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `kmer-profiling-hifi-trio-VGP2.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)