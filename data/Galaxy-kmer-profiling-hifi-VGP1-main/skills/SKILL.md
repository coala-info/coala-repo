---
name: k-mer-profiling-and-reads-statistics-vgp1
description: This Galaxy workflow processes PacBio HiFi reads using Meryl, GenomeScope, and RDeval to generate k-mer databases and comprehensive read statistics. Use this skill when you need to estimate genome size, heterozygosity, and repeat content or assess the quality and complexity of sequencing data prior to de novo assembly.
homepage: https://iwc.galaxyproject.org/
metadata:
  docker_image: "N/A"
---

# k-mer-profiling-and-reads-statistics-vgp1

## Overview

This Galaxy workflow is designed for the initial evaluation of PacBio HiFi reads and genome profiling as part of the Vertebrate Genomes Project (VGP) pipeline. It utilizes [Meryl](https://github.com/marbl/meryl) to generate a k-mer database and histogram from raw sequencing data, which serves as the foundation for estimating genomic complexity. By analyzing k-mer distributions, the workflow provides critical insights into genome size, heterozygosity levels, and repeat content.

The pipeline integrates [GenomeScope](https://github.com/schatzlab/genomescope) to produce various linear and log plots, alongside a detailed summary of model parameters. These outputs are essential for determining downstream assembly parameters and performing quality control. Additionally, the workflow includes [rdeval](https://github.com/mshakiba/rdeval) for comprehensive read statistics and [Mash](https://github.com/marbl/Mash) for distance estimation between datasets, ensuring the integrity of the input HiFi data.

Key inputs include a collection of HiFi long reads in FASTQ format, the species and assembly names, k-mer length, and ploidy. The resulting Meryl database is a primary output used for subsequent assembly assessment with tools like Merqury. This workflow is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) and is tagged for VGP reviewed standards.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Species Name | parameter_input | For Workflow report. |
| 1 | Assembly Name | parameter_input | For Workflow report. |
| 2 | Collection of Pacbio Data | data_collection_input | A simple list collection containing PacBio data in either fastq or fasta format |
| 3 | K-mer length | parameter_input | K-mer length to use to generate the k-mer database. |
| 4 | Ploidy | parameter_input | Ploidy for the organism being assembled |


Ensure your PacBio HiFi reads are organized into a dataset collection of FASTQ files to enable proper batch processing and downstream QC analysis. You should verify that the k-mer length and ploidy parameters match your specific organism's profile to ensure accurate GenomeScope modeling and Meryl database generation. For large-scale or automated execution, consider using `planemo workflow_job_init` to generate a `job.yml` file for managing these parameters. Detailed instructions on file preparation and specific tool settings can be found in the README.md.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 5 | Compose text parameter value | toolshed.g2.bx.psu.edu/repos/iuc/compose_text_param/compose_text_param/0.1.1 |  |
| 6 | Compose text parameter value | toolshed.g2.bx.psu.edu/repos/iuc/compose_text_param/compose_text_param/0.1.1 |  |
| 7 | Test if collection has only one item or is empty | (subworkflow) |  |
| 8 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl_count_kmers/meryl_count_kmers/1.4.1+galaxy0 |  |
| 9 | Compose text parameter value | toolshed.g2.bx.psu.edu/repos/iuc/compose_text_param/compose_text_param/0.1.1 |  |
| 10 | Mash evaluation | (subworkflow) |  |
| 11 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl_groups_kmers/meryl_groups_kmers/1.4.1+galaxy0 |  |
| 12 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl_histogram_kmers/meryl_histogram_kmers/1.4.1+galaxy0 |  |
| 13 | GenomeScope | toolshed.g2.bx.psu.edu/repos/iuc/genomescope/genomescope/2.1.0+galaxy0 |  |
| 14 | Parse kcov | (subworkflow) |  |
| 15 | Image Montage | toolshed.g2.bx.psu.edu/repos/bgruening/imagemagick_image_montage/imagemagick_image_montage/7.1.2-2+galaxy1 |  |
| 16 | Parse Estimated Genome Size | (subworkflow) |  |
| 17 | Parse parameter value | param_value_from_file |  |
| 18 | Parse parameter value | param_value_from_file |  |
| 19 | Parse parameter value | param_value_from_file |  |
| 20 | rdeval | toolshed.g2.bx.psu.edu/repos/richard-burhans/rdeval/rdeval/0.0.8+galaxy0 |  |
| 21 | Column join | toolshed.g2.bx.psu.edu/repos/iuc/collection_column_join/collection_column_join/0.0.3 |  |
| 22 | rdeval report | toolshed.g2.bx.psu.edu/repos/richard-burhans/rdeval/rdeval_report/0.0.8+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | Species for report | out1 |
| 6 | Assembly for report | out1 |
| 9 | K-mer length for report | out1 |
| 11 | Merged Meryl Database | read_db |
| 13 | GenomeScope Model | model |
| 13 | GenomeScope summary | summary |
| 13 | GenomeScope transformed log plot | transformed_log_plot |
| 13 | GenomeScope Model Parameters | model_params |
| 13 | GenomeScope log plot | log_plot |
| 13 | GenomeScope linear plot | linear_plot |
| 13 | GenomeScope transformed linear plot | transformed_linear_plot |
| 15 | Montage Genomescope | output |
| 17 | Homozygous Read Coverage | float_param |
| 19 | Est_size_param | text_param |
| 20 | Reads Statistics | stats_outfile |
| 21 | Merged Read Statistics | tabular_output |
| 22 | Rdeval report | outfile |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run kmer-profiling-hifi-VGP1.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run kmer-profiling-hifi-VGP1.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run kmer-profiling-hifi-VGP1.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init kmer-profiling-hifi-VGP1.ga -o job.yml`
- Lint: `planemo workflow_lint kmer-profiling-hifi-VGP1.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `kmer-profiling-hifi-VGP1.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)