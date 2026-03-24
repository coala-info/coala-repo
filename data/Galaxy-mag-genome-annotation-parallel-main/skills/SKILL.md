---
name: mag-genome-annotation-parallel
description: "This workflow performs parallel annotation of bacterial metagenome-assembled genomes using Bakta, Integron Finder, PlasmidFinder, and ISEScan to generate standardized genomic features and merged summary tables. Use this skill when you need to simultaneously characterize gene functions, mobile genetic elements, plasmids, and insertion sequences across a large collection of prokaryotic assemblies to compare genomic content and horizontal gene transfer potential."
homepage: https://workflowhub.eu/workflows/2115
---

# MAG Genome Annotation Parallel

## Overview

This workflow provides an automated, parallelized pipeline for the comprehensive annotation of Metagenome-Assembled Genomes (MAGs). It is designed to process multiple prokaryotic genome assemblies simultaneously, utilizing a suite of specialized tools to identify genomic features, mobile genetic elements, and functional sequences.

The core annotation engine leverages [Bakta](https://github.com/oschwengers/bakta) for general feature prediction (CDS, tRNA, rRNA, and CRISPR arrays), [Integron Finder](https://github.com/gem-pasteur/Integron_Finder) for detecting integrons and gene cassettes, [PlasmidFinder](https://bitbucket.org/genomicepidemiology/plasmidfinder/src/master/) for identifying plasmid replicon sequences, and [ISEScan](https://github.com/xiezhq/ISEScan) for the detection of insertion sequences.

Following the parallel annotation steps, the workflow reformats and normalizes the data to produce unified result files. It collapses individual genome outputs into merged summary tables for plasmid content, integrons, and IS elements, facilitating comparative analysis across the entire dataset.

The final output includes standardized annotation matrices and an integrated [MultiQC](https://multiqc.info/) report. This report provides a global overview of annotation completeness, gene content, and processing metrics across all input genomes, ensuring a streamlined quality control and discovery process.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Bacterial Genomes | data_collection_input | Input a collection with bacterial genomes |
| 1 | Plasmid detection database | parameter_input | Select a database to identify plasmids with PlasmidFinder. |
| 2 | Bacterial genome annotation database | parameter_input | Select a database to predict CDS and small proteins (sORF) with Bakta. |
| 3 | AMRFinderPlus database | parameter_input | Select a database to annotate AMR genes with Bakta. |
| 4 | Run Bakta | parameter_input | Choose if you want to run bakta or not (can take a long time) |


Upload your MAG assemblies as a single list collection of FASTA files to ensure the workflow processes all genomes in parallel. You must provide the specific database paths for PlasmidFinder, Bakta, and AMRFinderPlus as parameter inputs before execution. While Bakta is optional, using it requires selecting the appropriate bacterial genome annotation database to generate comprehensive GFF3 and GenBank outputs. For complex configurations or automated execution, you can use `planemo workflow_job_init` to generate a `job.yml` file. Please refer to the README.md for detailed instructions on database versioning and specific output formats for each annotation tool.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 5 | Bacterial Genome Annotation - IWC | (subworkflow) |  |
| 6 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy3 |  |
| 7 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy3 |  |
| 8 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 9 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy3 |  |
| 10 | Convert | Convert characters1 |  |
| 11 | Column join | toolshed.g2.bx.psu.edu/repos/iuc/collection_column_join/collection_column_join/0.0.3 |  |
| 12 | Convert | Convert characters1 |  |
| 13 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 14 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 15 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.33+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 8 | PlasmidFinder Merged Summary | output |
| 11 | bakta cut annotation summary | tabular_output |
| 13 | Integron Finder Merged Output | output |
| 14 | ISEScan Merged Output | output |
| 15 | multiqc html report | html_report |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run MAG-Genome-Annotation-Parallel.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run MAG-Genome-Annotation-Parallel.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run MAG-Genome-Annotation-Parallel.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init MAG-Genome-Annotation-Parallel.ga -o job.yml`
- Lint: `planemo workflow_lint MAG-Genome-Annotation-Parallel.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `MAG-Genome-Annotation-Parallel.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
