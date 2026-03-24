---
name: mgnifys-amplicon-pipeline-v50
description: "This metagenomics workflow processes SRA accessions through MGnify's amplicon pipeline v5.0 to perform quality control, rRNA prediction for SSU and LSU sequences, and ITS classification. Use this skill when you need to characterize microbial community composition and generate taxonomic abundance summary tables from environmental or clinical amplicon sequencing data."
homepage: https://workflowhub.eu/workflows/1274
---

# MGnify's amplicon pipeline v5.0

## Overview

This Galaxy workflow implements the [MGnify](https://www.ebi.ac.uk/metagenomics/) amplicon pipeline v5.0, designed for the comprehensive analysis of metagenomic amplicon data. It automates the processing of raw sequencing reads from SRA accessions, handling both single-end and paired-end data through specialized quality control sub-workflows. The pipeline utilizes tools like `fastp` and `Trimmomatic` for filtering and base correction to ensure high-quality input for downstream taxonomic classification.

The core analysis involves rRNA prediction and Internal Transcribed Spacer (ITS) identification. By leveraging covariance models and clan information, the workflow classifies sequences into Small Subunit (SSU) and Large Subunit (LSU) categories. It further refines these classifications using specialized databases such as ITSoneDB and UNITE to provide detailed taxonomic insights into fungal and microbial communities.

The final stages of the workflow generate structured taxonomic abundance summary tables at various ranks, including the phylum level. These outputs provide a clear overview of the microbial composition of the samples, facilitating comparative metagenomics and ecological studies. The workflow is licensed under Apache-2.0 and is part of the microgalaxy initiative.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | SRA accession list | data_input | List of SRA accession IDs, one per line. |
| 1 | Clan information file | data_input | Clan information file. |
| 2 | Trimmomatic sliding window number of bases to average across | parameter_input | Number of bases to average across. |
| 3 | Trimmomatic sliding window average quality | parameter_input | Average quality required. |
| 4 | PE fastp - Enable base correction | parameter_input | Enable base correction in overlapped regions. (Paired-end) |
| 5 | Trimmomatic leading | parameter_input | Cut bases off the start of a read, if below a threshold quality. |
| 6 | PE fastp - Qualified quality phred | parameter_input | The quality value that a base is qualified. (Paired-end) |
| 7 | Trimmomatic trailing | parameter_input | Cut bases off the end of a read, if below a threshold quality. |
| 8 | PE fastp - Unqualified percent limit | parameter_input | How many percents of bases are allowed to be unqualified (0~100). (Paired-end) |
| 9 | Trimmomatic min length | parameter_input | Minimum length of reads to be kept. |
| 10 | PE fastp - Length required | parameter_input | Reads shorter than this value will be discarded. (Paired-end) |
| 11 | Length filtering minimum size | parameter_input | Minimum sequence length. |
| 12 | Ambiguity filtering maximal N percentage threshold to conserve sequences | parameter_input | Maximal N percentage threshold to conserve sequences. |
| 13 | SSU taxonomic abundance summary table name | parameter_input |  |
| 14 | SSU phylum level taxonomic abundance summary table name | parameter_input |  |
| 15 | LSU taxonomic abundance summary table name | parameter_input |  |
| 16 | LSU phylum level taxonomic abundance summary table name | parameter_input |  |
| 17 | ITSoneDB taxonomic abundance summary table name | parameter_input |  |
| 18 | ITSoneDB phylum level taxonomic abundance summary table name | parameter_input |  |
| 19 | ITS UNITE DB taxonomic abundance summary table name | parameter_input |  |
| 20 | ITS UNITE DB phylum level taxonomic abundance summary table name | parameter_input |  |


To run this pipeline, provide a text file containing SRA accession IDs and the required clan information file (ribo.claninfo) to facilitate ribosomal model classification. Ensure your input sequences are organized into paired-end or single-end collections as appropriate for the quality control subworkflows, which handle trimming and filtering parameters. For automated execution and parameter management, you can initialize a job configuration using `planemo workflow_job_init`. Refer to the README.md for specific download links for the covariance models and detailed database preparation instructions. One should verify that all taxonomic summary table names are uniquely defined to avoid output conflicts during the final aggregation steps.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 21 | fastq-dl | toolshed.g2.bx.psu.edu/repos/iuc/fastq_dl/fastq_dl/3.0.0+galaxy0 |  |
| 22 | Convert compressed file to uncompressed. | CONVERTER_gz_to_uncompressed |  |
| 23 | Convert compressed file to uncompressed. | CONVERTER_gz_to_uncompressed |  |
| 24 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.3+galaxy1 |  |
| 25 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.3+galaxy1 |  |
| 26 | Convert uncompressed file to compressed | CONVERTER_uncompressed_to_gz |  |
| 27 | Convert uncompressed file to compressed | CONVERTER_uncompressed_to_gz |  |
| 28 | MGnify's amplicon pipeline v5.0 - Quality control SE | (subworkflow) |  |
| 29 | MGnify's amplicon pipeline v5.0 - Quality control PE | (subworkflow) |  |
| 30 | Merge collections | __MERGE_COLLECTION__ |  |
| 31 | MGnify's amplicon pipeline v5.0 - rRNA prediction | (subworkflow) |  |
| 32 | MGnify's amplicon pipeline v5.0 - ITS | (subworkflow) |  |
| 33 | Map empty/not empty collection to boolean  | (subworkflow) |  |
| 34 | Map empty/not empty collection to boolean  | (subworkflow) |  |
| 35 | Map empty/not empty collection to boolean  | (subworkflow) |  |
| 36 | Map empty/not empty collection to boolean  | (subworkflow) |  |
| 37 | MGnify amplicon summary tables | (subworkflow) |  |
| 38 | MGnify amplicon summary tables | (subworkflow) |  |
| 39 | MGnify amplicon summary tables | (subworkflow) |  |
| 40 | MGnify amplicon summary tables | (subworkflow) |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run mgnify-amplicon-pipeline-v5-complete.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run mgnify-amplicon-pipeline-v5-complete.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run mgnify-amplicon-pipeline-v5-complete.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init mgnify-amplicon-pipeline-v5-complete.ga -o job.yml`
- Lint: `planemo workflow_lint mgnify-amplicon-pipeline-v5-complete.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `mgnify-amplicon-pipeline-v5-complete.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
