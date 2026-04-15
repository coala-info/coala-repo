---
name: ecoli-comparison
description: This workflow performs comparative genomics on E. coli assemblies by processing FASTA sequences and essential gene tables using LASTZ for alignment and Bedtools for interval analysis. Use this skill when you need to characterize a newly assembled bacterial genome by identifying essential genes and analyzing sequence conservation relative to reference datasets.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# ecoli-comparison

## Overview

This workflow is designed for comparative genomics, specifically to "make sense" of a newly assembled *E. coli* genome. Following common [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) practices, it facilitates the transition from raw assembly to functional understanding by comparing new sequences against established reference data and essential gene lists.

The pipeline begins by filtering assembly sequences by length and performing comparative alignments using [LASTZ](https://github.com/lastz/lastz). It processes multiple input collections and reference tables to identify genomic features and evaluate the structural relationships between the new assembly and known *E. coli* strains.

Extensive data transformation steps—including text manipulation with `sed`, `grep`, and `datamash`—are used to clean and format alignment results. The workflow then utilizes [BEDTools](https://bedtools.readthedocs.io/) to perform interval operations, such as intersecting and complementing genomic regions, to pinpoint specific areas of interest like conserved essential genes or assembly gaps.

By merging and joining these processed datasets, the workflow produces a comprehensive comparison that helps researchers annotate their assembly and evaluate its quality. This automated approach ensures a reproducible path from a FASTA assembly to a detailed genomic analysis.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Ecoli_C_assembly.fna | data_input |  |
| 1 | inline-supplementary-material-7 - Table_S4_Essential genes identi.tsv | data_input |  |
| 2 | Input Dataset Collection | data_collection_input |  |
| 3 | Input Dataset Collection | data_collection_input |  |
| 4 | Input Dataset Collection | data_collection_input |  |


Ensure your primary assembly is in FASTA format and the essential genes list is provided as a TSV file. This workflow utilizes multiple dataset collections to manage comparative data efficiently, so ensure your grouped inputs are correctly organized into collections rather than individual datasets before execution. For automated testing and job configuration, you can use `planemo workflow_job_init` to generate a `job.yml` file. Refer to the README.md for comprehensive details on parameter settings and specific data preparation requirements. Always verify that sequence identifiers match across your assembly and annotation files to prevent tool failures during the filtering and intersection steps.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 5 | Filter sequences by length | toolshed.g2.bx.psu.edu/repos/devteam/fasta_filter_by_length/fasta_filter_by_length/1.1 |  |
| 6 | LASTZ | toolshed.g2.bx.psu.edu/repos/devteam/lastz/lastz_wrapper_2/1.3.2 |  |
| 7 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/4.0 |  |
| 8 | Select | Grep1 |  |
| 9 | Text transformation | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sed_tool/1.1.1 |  |
| 10 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/4.0 |  |
| 11 | Text transformation | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sed_tool/1.1.1 |  |
| 12 | Add column | toolshed.g2.bx.psu.edu/repos/devteam/add_value/addValue/1.0.0 |  |
| 13 | LASTZ | toolshed.g2.bx.psu.edu/repos/devteam/lastz/lastz_wrapper_2/1.3.2 |  |
| 14 | random_lines1 | random_lines1 |  |
| 15 | Filter | Filter1 |  |
| 16 | Search in textfiles | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/1.1.1 |  |
| 17 | Concatenate datasets | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cat/0.1.0 |  |
| 18 | Cut | Cut1 |  |
| 19 | Text transformation | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sed_tool/1.1.1 |  |
| 20 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0 |  |
| 21 | Compute sequence length | toolshed.g2.bx.psu.edu/repos/devteam/fasta_compute_length/fasta_compute_length/1.0.1 |  |
| 22 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/4.0 |  |
| 23 | Merge Columns | toolshed.g2.bx.psu.edu/repos/devteam/merge_cols/mergeCols1/1.0.1 |  |
| 24 | Select | Grep1 |  |
| 25 | Sort | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sort_header_tool/1.1.1 |  |
| 26 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/4.0 |  |
| 27 | Cut | Cut1 |  |
| 28 | Cut | Cut1 |  |
| 29 | Concatenate datasets | cat1 |  |
| 30 | SortBED | toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_sortbed/2.27.0.0 |  |
| 31 | ComplementBed | toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_complementbed/2.27.0.0 |  |
| 32 | Filter | Filter1 |  |
| 33 | Filter | Filter1 |  |
| 34 | Intersect intervals | toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_intersectbed/2.27.0.2 |  |
| 35 | Join two Datasets | join1 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run ecoli-comparison.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run ecoli-comparison.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run ecoli-comparison.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init ecoli-comparison.ga -o job.yml`
- Lint: `planemo workflow_lint ecoli-comparison.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `ecoli-comparison.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)