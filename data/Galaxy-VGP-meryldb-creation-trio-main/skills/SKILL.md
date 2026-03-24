---
name: quality-evaluation-for-trio-assembly
description: "This workflow utilizes Meryl and GenomeScope to process PacBio HiFi reads alongside maternal and paternal Illumina data for k-mer frequency analysis and haplotype partitioning. Use this skill when you need to estimate genome size, heterozygosity, and repeat content or prepare k-mer databases for high-quality trio-binned diploid genome assemblies."
homepage: https://workflowhub.eu/workflows/365
---

# Quality Evaluation For Trio Assembly

## Overview

This workflow is a critical component of the [Vertebrate Genomes Project (VGP)](https://vertebrategenomesproject.org/) pipeline, designed to evaluate genome complexity and data quality through k-mer frequency analysis. It specifically handles trio-based data, utilizing sequencing reads from an offspring and both parents to facilitate haplotype-specific assembly assessment and quality control.

The process begins by interlacing parental short-read sequences and counting k-mers across all inputs using [Meryl](https://github.com/marbl/meryl). By comparing the k-mer profiles of the PacBio HiFi reads from the child against the maternal and paternal datasets, the workflow partitions the reads into haplotype-specific databases. These databases serve as the foundation for estimating assembly parameters and performing rigorous validation with tools like Merqury.

In addition to generating k-mer databases, the workflow employs [GenomeScope](http://qb.cshl.edu/genomescope/) to provide insights into the genomic landscape. It generates detailed metrics and visualizations—including linear and log plots—regarding genome size, heterozygosity levels, and repeat content for the child and both parental genomes.

Detailed information on input requirements and file preparation can be found in the [README.md](README.md) located in the Files section. This workflow is provided under a [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | K-mer length | parameter_input | K-mer length used to calculate k-mer spectra. For a human genome, the best k-mer size is k=21 for both haploid (3.1G) or diploid (6.2G). |
| 1 | Pacbio Hifi reads | data_collection_input |  |
| 2 | Collection of Paired Reads - Paternal | data_collection_input | Collection of Paired Illumina Data in fastq format for Parent 1. |
| 3 | Collection of Paired Reads - Maternal | data_collection_input | Collection of Paired Illumina Data in fastq format for Parent 2. |
| 4 | Ploidy | parameter_input | Ploidy for model to use. Default=2 |


Ensure all sequencing data is provided in FASTQ format, utilizing data collections for the PacBio HiFi reads and the paired-end Illumina reads from both parents to maintain organization. The workflow requires specific k-mer lengths and ploidy parameters to accurately partition the offspring's long reads into haplotype-specific Meryl databases. For automated execution and parameter configuration, you can use `planemo workflow_job_init` to generate a `job.yml` file. Refer to the README.md for comprehensive details on input preparation and expected genomic complexity metrics.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 5 | FASTQ interlacer | toolshed.g2.bx.psu.edu/repos/devteam/fastq_paired_end_interlacer/fastq_paired_end_interlacer/1.2.0.1+galaxy0 |  |
| 6 | FASTQ interlacer | toolshed.g2.bx.psu.edu/repos/devteam/fastq_paired_end_interlacer/fastq_paired_end_interlacer/1.2.0.1+galaxy0 |  |
| 7 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl/meryl/1.3+galaxy6 |  |
| 8 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl/meryl/1.3+galaxy6 |  |
| 9 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl/meryl/1.3+galaxy6 |  |
| 10 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl/meryl/1.3+galaxy6 |  |
| 11 | GenomeScope | toolshed.g2.bx.psu.edu/repos/iuc/genomescope/genomescope/2.0+galaxy1 |  |
| 12 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl/meryl/1.3+galaxy6 |  |
| 13 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl/meryl/1.3+galaxy6 |  |
| 14 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl/meryl/1.3+galaxy6 |  |
| 15 | GenomeScope | toolshed.g2.bx.psu.edu/repos/iuc/genomescope/genomescope/2.0+galaxy1 |  |
| 16 | GenomeScope | toolshed.g2.bx.psu.edu/repos/iuc/genomescope/genomescope/2.0+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | outfile_pairs_from_coll | outfile_pairs_from_coll |
| 6 | outfile_pairs_from_coll | outfile_pairs_from_coll |
| 8 | Meryl pat.meryldb | pat_db |
| 8 | Meryl mat.meryldb | mat_db |
| 8 | Meryl read-db.meryldb | read_db |
| 11 | GenomeScope summary (child) | summary |
| 11 | GenomeScope transformed log plot (child) | transformed_log_plot |
| 11 | GenomeScope transformed linear plot (child) | transformed_linear_plot |
| 11 | GenomeScope linear plot (child) | linear_plot |
| 11 | GenomeScope model (child) | model |
| 11 | GenomeScope log plot (child) | log_plot |
| 15 | GenomeScope log plot (paternal) | log_plot |
| 15 | GenomeScope transformed linear plot (paternal) | transformed_linear_plot |
| 15 | GenomeScope linear plot (paternal) | linear_plot |
| 15 | GenomeScope transformed log plot (paternal) | transformed_log_plot |
| 16 | GenomeScope transformed log plot (maternal) | transformed_log_plot |
| 16 | GenomeScope transformed linear plot (maternal) | transformed_linear_plot |
| 16 | GenomeScope linear plot (maternal) | linear_plot |
| 16 | GenomeScope log plot (maternal) | log_plot |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run meryldb-creation-trio.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run meryldb-creation-trio.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run meryldb-creation-trio.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init meryldb-creation-trio.ga -o job.yml`
- Lint: `planemo workflow_lint meryldb-creation-trio.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `meryldb-creation-trio.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
