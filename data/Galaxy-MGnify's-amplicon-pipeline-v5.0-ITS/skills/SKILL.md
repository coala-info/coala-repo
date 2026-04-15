---
name: mgnifys-amplicon-pipeline-v50-its
description: This metagenomics workflow processes sequence data and BED files to classify Internal Transcribed Spacer regions using MAPseq against the ITSoneDB and UNITE databases. Use this skill when you need to characterize fungal or eukaryotic community composition from environmental samples by generating taxonomic classifications, OTU tables, and Krona visualizations.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# mgnifys-amplicon-pipeline-v50-its

## Overview

This workflow implements the [MGnify](https://www.ebi.ac.uk/metagenomics/) amplicon pipeline v5.0 specifically for Internal Transcribed Spacer (ITS) regions. It is designed for the taxonomic classification and visualization of fungal and eukaryotic communities within metagenomics datasets. The pipeline accepts processed sequences and BED files (LSU and SSU) as primary inputs to isolate and analyze the ITS regions.

The core processing involves masking sequences with `bedtools MaskFastaBed` followed by high-throughput taxonomic assignment using [MAPseq](https://github.com/jfmz/mapseq). The workflow performs parallel classifications against two major reference databases: [ITSoneDB](https://itsonedb.org/) and the [UNITE DB](https://unite.ut.ee/). This dual-database approach ensures comprehensive coverage and comparative accuracy for fungal ribosomal DNA analysis.

Final outputs include detailed taxonomic classifications and OTU tables provided in multiple formats, including HDF5, JSON, and BIOM via `biom_convert`. For data exploration, the pipeline generates interactive [Krona pie charts](https://github.com/marbl/Krona/wiki) to visualize taxonomic abundance. The workflow is tagged for use in [microgalaxy](https://usegalaxy.eu/) and the Galaxy Training Network (GTN), following the Apache-2.0 license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | LSU and SSU BED | data_collection_input | A BED file containing the LSU and SSU coordinates. |
| 1 | Processed sequences | data_collection_input | Processed sequences. |


Ensure your input data is organized into paired data collections, specifically providing processed sequences in FASTA format and corresponding LSU/SSU coordinates in BED format. Using collections instead of individual datasets is essential for the workflow to correctly map identifiers across the filtering and masking steps. For automated execution and parameter scaling, you can initialize a job configuration using `planemo workflow_job_init`. Refer to the README.md for comprehensive details on database versions and specific file naming conventions. This preparation ensures the pipeline accurately generates taxonomic classifications and OTU tables across both ITSoneDB and UNITE databases.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Filter empty datasets | __FILTER_EMPTY_DATASETS__ |  |
| 3 | Extract element identifiers | toolshed.g2.bx.psu.edu/repos/iuc/collection_element_identifiers/collection_element_identifiers/0.0.2 |  |
| 4 | Filter collection | __FILTER_FROM_FILE__ |  |
| 5 | bedtools MaskFastaBed | toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_maskfastabed/2.31.1 |  |
| 6 | MAPseq | toolshed.g2.bx.psu.edu/repos/iuc/mapseq/mapseq/2.1.1+galaxy0 |  |
| 7 | MAPseq | toolshed.g2.bx.psu.edu/repos/iuc/mapseq/mapseq/2.1.1+galaxy0 |  |
| 8 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy0 |  |
| 9 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy0 |  |
| 10 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy0 |  |
| 11 | Filter empty datasets | __FILTER_EMPTY_DATASETS__ |  |
| 12 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy0 |  |
| 13 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy0 |  |
| 14 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy0 |  |
| 15 | Filter empty datasets | __FILTER_EMPTY_DATASETS__ |  |
| 16 | Filter empty datasets | __FILTER_EMPTY_DATASETS__ |  |
| 17 | Filter empty datasets | __FILTER_EMPTY_DATASETS__ |  |
| 18 | Filter empty datasets | __FILTER_EMPTY_DATASETS__ |  |
| 19 | Map empty/not empty collection to boolean  | (subworkflow) |  |
| 20 | Filter empty datasets | __FILTER_EMPTY_DATASETS__ |  |
| 21 | Filter empty datasets | __FILTER_EMPTY_DATASETS__ |  |
| 22 | Filter empty datasets | __FILTER_EMPTY_DATASETS__ |  |
| 23 | Map empty/not empty collection to boolean  | (subworkflow) |  |
| 24 | Map empty/not empty collection to boolean  | (subworkflow) |  |
| 25 | Krona pie chart | toolshed.g2.bx.psu.edu/repos/crs4/taxonomy_krona_chart/taxonomy_krona_chart/2.7.1+galaxy0 |  |
| 26 | Map empty/not empty collection to boolean  | (subworkflow) |  |
| 27 | Krona pie chart | toolshed.g2.bx.psu.edu/repos/crs4/taxonomy_krona_chart/taxonomy_krona_chart/2.7.1+galaxy0 |  |
| 28 | Convert | toolshed.g2.bx.psu.edu/repos/iuc/biom_convert/biom_convert/2.1.15+galaxy1 |  |
| 29 | Convert | toolshed.g2.bx.psu.edu/repos/iuc/biom_convert/biom_convert/2.1.15+galaxy1 |  |
| 30 | Convert | toolshed.g2.bx.psu.edu/repos/iuc/biom_convert/biom_convert/2.1.15+galaxy1 |  |
| 31 | Convert | toolshed.g2.bx.psu.edu/repos/iuc/biom_convert/biom_convert/2.1.15+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | ITS FASTA files | output |
| 16 | ITS taxonomic classifications using ITSoneDB | output |
| 17 | ITS OTU tables (ITSoneDB) | output |
| 20 | ITS taxonomic classifications using UNITE DB | output |
| 21 | ITS OTU tables (UNITE DB) | output |
| 25 | ITS taxonomic abundance pie charts (ITSoneDB) | output |
| 27 | ITS taxonomic abundance pie charts (UNITE DB) | output |
| 28 | ITS OTU tables in HDF5 format (ITSoneDB) | output_fp |
| 29 | ITS OTU tables in JSON format (ITSoneDB) | output_fp |
| 30 | ITS OTU tables in HDF5 format (UNITE DB) | output_fp |
| 31 | ITS OTU tables in JSON format (UNITE DB) | output_fp |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run mgnify-amplicon-pipeline-v5-its.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run mgnify-amplicon-pipeline-v5-its.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run mgnify-amplicon-pipeline-v5-its.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init mgnify-amplicon-pipeline-v5-its.ga -o job.yml`
- Lint: `planemo workflow_lint mgnify-amplicon-pipeline-v5-its.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `mgnify-amplicon-pipeline-v5-its.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)