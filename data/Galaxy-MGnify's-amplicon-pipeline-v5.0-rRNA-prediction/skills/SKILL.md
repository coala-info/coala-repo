---
name: mgnifys-amplicon-pipeline-v50-rrna-prediction
description: This metagenomics workflow identifies and classifies SSU and LSU rRNA sequences from processed amplicon data and clan information using Infernal cmsearch, MAPseq, and the SILVA database. Use this skill when you need to perform taxonomic profiling of environmental samples by extracting ribosomal RNA regions and generating OTU tables or Krona visualizations.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# mgnifys-amplicon-pipeline-v50-rrna-prediction

## Overview

This workflow implements the rRNA prediction and classification stage of the [MGnify](https://www.ebi.ac.uk/metagenomics/) amplicon pipeline v5.0. It is designed to identify, extract, and taxonomically annotate Small Subunit (SSU) and Large Subunit (LSU) ribosomal RNA sequences from pre-processed metagenomic or amplicon datasets.

The pipeline begins by using [Infernal's cmsearch](http://eddylab.org/infernal/) and a deoverlapping tool to detect rRNA genes based on covariance models. Once identified, the specific SSU and LSU regions are extracted into FASTA format using `bedtools`. These sequences are then taxonomically classified using [MAPseq](https://github.com/jfmeyer/mapseq) against the SILVA database, providing high-resolution assignments for the detected ribosomal fragments.

The final outputs include detailed taxonomic classification files, OTU tables, and interactive [Krona](https://github.com/marbl/Krona/wiki) pie charts for visualizing taxonomic abundance. To support downstream ecological analysis, the workflow also generates OTU tables in BIOM format (both HDF5 and JSON). This toolset is tagged for metagenomics and amplicon analysis under the Apache-2.0 license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Processed sequences | data_collection_input | Post quality control. |
| 1 | Clan information file | data_input | This file lists which models belong to the same clan. |


To run this workflow, ensure your processed sequences are provided as a fasta data collection and the clan information is uploaded as a tabular file. Using collections is essential for handling multiple samples simultaneously through the Infernal and MAPseq steps. For detailed parameter settings and reference database versions, refer to the README.md file. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution. Ensure all input sequences are properly formatted to avoid errors during the rRNA prediction and taxonomic classification stages.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | cmsearch | toolshed.g2.bx.psu.edu/repos/bgruening/infernal/infernal_cmsearch/1.1.5+galaxy0 |  |
| 3 | Filter empty datasets | __FILTER_EMPTY_DATASETS__ |  |
| 4 | CMsearch deoverlap | toolshed.g2.bx.psu.edu/repos/rnateam/cmsearch_deoverlap/cmsearch_deoverlap/0.08+galaxy2 |  |
| 5 | Query Tabular | toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.2 |  |
| 6 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy0 |  |
| 7 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy0 |  |
| 8 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy0 |  |
| 9 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy0 |  |
| 10 | Concatenate | toolshed.g2.bx.psu.edu/repos/devteam/concat/gops_concat_1/1.0.1 |  |
| 11 | Concatenate | toolshed.g2.bx.psu.edu/repos/devteam/concat/gops_concat_1/1.0.1 |  |
| 12 | Filter empty datasets | __FILTER_EMPTY_DATASETS__ |  |
| 13 | Filter empty datasets | __FILTER_EMPTY_DATASETS__ |  |
| 14 | Concatenate | toolshed.g2.bx.psu.edu/repos/devteam/concat/gops_concat_1/1.0.1 |  |
| 15 | Extract element identifiers | toolshed.g2.bx.psu.edu/repos/iuc/collection_element_identifiers/collection_element_identifiers/0.0.2 |  |
| 16 | Extract element identifiers | toolshed.g2.bx.psu.edu/repos/iuc/collection_element_identifiers/collection_element_identifiers/0.0.2 |  |
| 17 | Filter collection | __FILTER_FROM_FILE__ |  |
| 18 | Filter collection | __FILTER_FROM_FILE__ |  |
| 19 | bedtools getfasta | toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_getfastabed/2.31.1+galaxy0 |  |
| 20 | bedtools getfasta | toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_getfastabed/2.31.1+galaxy0 |  |
| 21 | FASTA Width | toolshed.g2.bx.psu.edu/repos/devteam/fasta_formatter/cshl_fasta_formatter/1.0.1+galaxy2 |  |
| 22 | FASTA Width | toolshed.g2.bx.psu.edu/repos/devteam/fasta_formatter/cshl_fasta_formatter/1.0.1+galaxy2 |  |
| 23 | MAPseq | toolshed.g2.bx.psu.edu/repos/iuc/mapseq/mapseq/2.1.1+galaxy0 |  |
| 24 | MAPseq | toolshed.g2.bx.psu.edu/repos/iuc/mapseq/mapseq/2.1.1+galaxy0 |  |
| 25 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy0 |  |
| 26 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy0 |  |
| 27 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy0 |  |
| 28 | Filter empty datasets | __FILTER_EMPTY_DATASETS__ |  |
| 29 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy0 |  |
| 30 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy0 |  |
| 31 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy0 |  |
| 32 | Filter empty datasets | __FILTER_EMPTY_DATASETS__ |  |
| 33 | Filter empty datasets | __FILTER_EMPTY_DATASETS__ |  |
| 34 | Filter empty datasets | __FILTER_EMPTY_DATASETS__ |  |
| 35 | Filter empty datasets | __FILTER_EMPTY_DATASETS__ |  |
| 36 | Map empty/not empty collection to boolean  | (subworkflow) |  |
| 37 | Filter empty datasets | __FILTER_EMPTY_DATASETS__ |  |
| 38 | Filter empty datasets | __FILTER_EMPTY_DATASETS__ |  |
| 39 | Filter empty datasets | __FILTER_EMPTY_DATASETS__ |  |
| 40 | Map empty/not empty collection to boolean  | (subworkflow) |  |
| 41 | Map empty/not empty collection to boolean  | (subworkflow) |  |
| 42 | Krona pie chart | toolshed.g2.bx.psu.edu/repos/crs4/taxonomy_krona_chart/taxonomy_krona_chart/2.7.1+galaxy0 |  |
| 43 | Map empty/not empty collection to boolean  | (subworkflow) |  |
| 44 | Krona pie chart | toolshed.g2.bx.psu.edu/repos/crs4/taxonomy_krona_chart/taxonomy_krona_chart/2.7.1+galaxy0 |  |
| 45 | Convert | toolshed.g2.bx.psu.edu/repos/iuc/biom_convert/biom_convert/2.1.15+galaxy1 |  |
| 46 | Convert | toolshed.g2.bx.psu.edu/repos/iuc/biom_convert/biom_convert/2.1.15+galaxy1 |  |
| 47 | Convert | toolshed.g2.bx.psu.edu/repos/iuc/biom_convert/biom_convert/2.1.15+galaxy1 |  |
| 48 | Convert | toolshed.g2.bx.psu.edu/repos/iuc/biom_convert/biom_convert/2.1.15+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 14 | LSU and SSU BED regions | output |
| 21 | SSU FASTA files | output |
| 22 | LSU FASTA files | output |
| 33 | SSU taxonomic classifications using SILVA DB | output |
| 34 | SSU OTU tables (SILVA DB) | output |
| 37 | LSU taxonomic classifications using SILVA DB | output |
| 38 | LSU OTU tables (SILVA DB) | output |
| 42 | SSU taxonomic abundance pie charts (SILVA DB) | output |
| 44 | LSU taxonomic abundance pie charts (SILVA DB) | output |
| 45 | SSU OTU tables in HDF5 format (SILVA DB) | output_fp |
| 46 | SSU OTU tables in JSON format (SILVA DB) | output_fp |
| 47 | LSU OTU tables in HDF5 format (SILVA DB) | output_fp |
| 48 | LSU OTU tables in JSON format (SILVA DB) | output_fp |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run mgnify-amplicon-pipeline-v5-rrna-prediction.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run mgnify-amplicon-pipeline-v5-rrna-prediction.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run mgnify-amplicon-pipeline-v5-rrna-prediction.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init mgnify-amplicon-pipeline-v5-rrna-prediction.ga -o job.yml`
- Lint: `planemo workflow_lint mgnify-amplicon-pipeline-v5-rrna-prediction.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `mgnify-amplicon-pipeline-v5-rrna-prediction.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)