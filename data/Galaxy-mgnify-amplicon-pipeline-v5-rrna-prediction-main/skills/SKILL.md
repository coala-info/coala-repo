---
name: mgnifys-amplicon-pipeline-v50-rrna-prediction
description: This metagenomics workflow processes quality-controlled amplicon sequences and clan information to predict, classify, and visualize ribosomal RNA using Infernal cmsearch, MAPseq, and Krona. Use this skill when you need to identify SSU and LSU rRNA regions within environmental DNA sequences and generate taxonomic abundance profiles and OTU tables against the SILVA database.
homepage: https://iwc.galaxyproject.org/
metadata:
  docker_image: "N/A"
---

# mgnifys-amplicon-pipeline-v50-rrna-prediction

## Overview

This Galaxy workflow implements the rRNA prediction and taxonomic classification stage of the [MGnify](https://www.ebi.ac.uk/metagenomics/) amplicon pipeline (v5.0). It is designed to identify, extract, and classify Small Subunit (SSU) and Large Subunit (LSU) ribosomal RNA sequences from pre-processed metagenomic datasets. The pipeline utilizes [Infernal](http://eddylab.org/infernal/) `cmsearch` against covariance models to detect rRNA genes, followed by a de-overlapping step to ensure high-quality sequence extraction.

Extracted rRNA sequences are classified using [MAPseq](https://github.com/jfmz/mapseq) against the SILVA database. The workflow generates comprehensive outputs, including taxonomic assignments, OTU tables in multiple formats (TSV, HDF5, and JSON) via `biom-convert`, and interactive [Krona](https://github.com/marbl/Krona/wiki) pie charts for visualizing community composition.

This tool is licensed under Apache-2.0 and is tagged for use in metagenomics and amplicon analysis within the microgalaxy community. It requires processed sequences and specific clan information files as primary inputs to facilitate the structural alignment and classification process.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Processed sequences | data_collection_input | Post quality control. |
| 1 | Clan information file | data_input | This file lists which models belong to the same clan. |


To run this subworkflow, provide processed sequences as a data collection in FASTA format alongside a specific clan information file (ribo.claninfo) available from the MGnify FTP repository. Ensure your input collection is correctly structured to allow the pipeline to distinguish between SSU and LSU sequences during the Infernal and MAPseq classification stages. For comprehensive details on obtaining the required covariance models and reference databases, refer to the README.md file. You can use `planemo workflow_job_init` to generate a `job.yml` file for managing these inputs and automating the execution.

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
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)