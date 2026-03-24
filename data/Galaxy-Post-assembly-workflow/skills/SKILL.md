---
name: post-assembly-workflow
description: "This Galaxy workflow performs comprehensive quality control on primary genome assemblies using long-read and Hi-C data with tools including BlobToolKit, BUSCO, Merqury, and GenomeScope. Use this skill when you need to assess the biological integrity, completeness, and potential contamination of a newly assembled reference genome to ensure it meets high-quality standards for biodiversity genomics."
homepage: https://workflowhub.eu/workflows/1641
---

# Post-assembly workflow

## Overview

The Post-assembly workflow is a comprehensive quality control (QC) pipeline designed for the European Reference Genome Atlas ([ERGA](https://www.erga-biodiversity.eu/)) initiative. It evaluates primary genome assemblies by integrating multiple data types, including long-read FASTQ files, Hi-C sequencing data, and taxonomic metadata. The workflow automates the generation of essential metrics required to assess assembly continuity, completeness, and contamination levels.

The pipeline employs a suite of industry-standard tools to profile the assembly. It uses [Meryl](https://github.com/marbl/meryl) and [GenomeScope](https://github.com/schatzlab/genomescope) for k-mer analysis, [Busco](https://busco.ezlab.org/) for biological completeness, and [Merqury](https://github.com/marbl/merqury) for consensus accuracy (QV) and k-mer completeness. Structural assessment is further supported by [gfastats](https://github.com/GFA-spec/gfastats) for scaffold statistics and [Smudgeplot](https://github.com/KamilSJaron/smudgeplot) for ploidy estimation.

For contamination screening and Hi-C validation, the workflow integrates [BlobToolKit](https://blobtoolkit.genomehubs.org/) to visualize GC content, coverage, and taxonomic hits from [Diamond](https://github.com/bbuchfink/diamond) searches. Hi-C data is processed via [BWA-MEM2](https://github.com/bwa-mem2/bwa-mem2) and [PretextMap](https://github.com/wtsi-hpag/PretextMap) to generate contact maps, providing a visual snapshot of the scaffolding quality. This workflow is licensed under AGPL-3.0-or-later and follows [GTN](https://training.galaxyproject.org/) best practices for reproducible genomics.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Metadata file | data_input |  |
| 1 | NCBI taxonomic ID | parameter_input |  |
| 2 | NCBI taxdump directory | data_input |  |
| 3 | Long-read FASTQ files | data_collection_input |  |
| 4 | Primary genome assembly file (fasta) | data_input |  |
| 5 | Ploidy for model to use | parameter_input |  |
| 6 | DIAMOND database | data_input |  |
| 7 | Hi-C reverse | data_collection_input |  |
| 8 | Hi-C forward | data_collection_input |  |


Ensure your primary assembly is in FASTA format and that long-read and Hi-C data are organized into paired or list collections to maintain proper sample mapping throughout the QC pipeline. You must provide a valid NCBI taxonomic ID and the corresponding taxdump directory to enable accurate contamination screening via BlobToolKit and DIAMOND. For large-scale runs, you can automate the setup of these parameters using `planemo workflow_job_init` to generate a template `job.yml` file. Refer to the `README.md` for specific metadata formatting requirements and detailed instructions on configuring the ploidy and database parameters.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 9 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl/meryl/1.3+galaxy6 |  |
| 10 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 11 | BlobToolKit | toolshed.g2.bx.psu.edu/repos/bgruening/blobtoolkit/blobtoolkit/4.0.7+galaxy2 |  |
| 12 | gfastats | toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.2.0+galaxy0 |  |
| 13 | Convert compressed file to uncompressed. | CONVERTER_gz_to_uncompressed |  |
| 14 | gfastats | toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.6+galaxy0 |  |
| 15 | Diamond | toolshed.g2.bx.psu.edu/repos/bgruening/diamond/bg_diamond/2.0.15+galaxy0 |  |
| 16 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 17 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 18 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl/meryl/1.3+galaxy6 |  |
| 19 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.28+galaxy0 |  |
| 20 | Smudgeplot | toolshed.g2.bx.psu.edu/repos/galaxy-australia/smudgeplot/smudgeplot/0.2.5+galaxy+2 |  |
| 21 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/1.1.4 |  |
| 22 | Bandage Image | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/2022.09+galaxy4 |  |
| 23 | BWA-MEM2 | toolshed.g2.bx.psu.edu/repos/iuc/bwa_mem2/bwa_mem2/2.2.1+galaxy0 |  |
| 24 | BWA-MEM2 | toolshed.g2.bx.psu.edu/repos/iuc/bwa_mem2/bwa_mem2/2.2.1+galaxy0 |  |
| 25 | Merqury | toolshed.g2.bx.psu.edu/repos/iuc/merqury/merqury/1.3+galaxy2 |  |
| 26 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl/meryl/1.3+galaxy6 |  |
| 27 | Samtools stats | toolshed.g2.bx.psu.edu/repos/devteam/samtools_stats/samtools_stats/2.0.4 |  |
| 28 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.4.4+galaxy0 |  |
| 29 | Filter and merge | toolshed.g2.bx.psu.edu/repos/iuc/bellerophon/bellerophon/1.0+galaxy0 |  |
| 30 | Extract dataset | __EXTRACT_DATASET__ |  |
| 31 | Extract dataset | __EXTRACT_DATASET__ |  |
| 32 | Extract dataset | __EXTRACT_DATASET__ |  |
| 33 | Extract dataset | __EXTRACT_DATASET__ |  |
| 34 | Extract dataset | __EXTRACT_DATASET__ |  |
| 35 | GenomeScope | toolshed.g2.bx.psu.edu/repos/iuc/genomescope/genomescope/2.0+galaxy2 |  |
| 36 | BlobToolKit | toolshed.g2.bx.psu.edu/repos/bgruening/blobtoolkit/blobtoolkit/4.0.7+galaxy2 |  |
| 37 | PretextMap | toolshed.g2.bx.psu.edu/repos/iuc/pretext_map/pretext_map/0.1.9+galaxy0 |  |
| 38 | BlobToolKit | toolshed.g2.bx.psu.edu/repos/bgruening/blobtoolkit/blobtoolkit/4.0.7+galaxy2 |  |
| 39 | BlobToolKit | toolshed.g2.bx.psu.edu/repos/bgruening/blobtoolkit/blobtoolkit/4.0.7+galaxy2 |  |
| 40 | BlobToolKit | toolshed.g2.bx.psu.edu/repos/bgruening/blobtoolkit/blobtoolkit/4.0.7+galaxy2 |  |
| 41 | Pretext Snapshot | toolshed.g2.bx.psu.edu/repos/iuc/pretext_snapshot/pretext_snapshot/0.0.3+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 12 | stats | stats |
| 20 | smudgeplot_log | smudgeplot_log |
| 20 | smudgeplot | smudgeplot |
| 22 | outfile | outfile |
| 25 | Merqury on input dataset(s): stats | stats_files |
| 25 | Merqury on input dataset(s): plots | png_files |
| 25 | Merqury on input dataset(s): QV stats | qv_files |
| 27 | output | output |
| 28 | Busco on input dataset(s): full table | busco_table |
| 28 | Busco on input dataset(s): short summary | busco_sum |
| 35 | transformed_linear_plot | transformed_linear_plot |
| 35 | log_plot | log_plot |
| 35 | linear_plot | linear_plot |
| 35 | transformed_log_plot | transformed_log_plot |
| 41 | pretext_snap_out | pretext_snap_out |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run main-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run main-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run main-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init main-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint main-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `main-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
