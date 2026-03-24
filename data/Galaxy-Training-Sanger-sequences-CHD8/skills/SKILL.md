---
name: training-sanger-sequences-chd8
description: "This Galaxy workflow processes raw Sanger sequencing data for the CHD8 gene by converting ab1 files to FASTQ, trimming, and performing sequence alignment to generate a consensus sequence. Use this skill when you need to perform quality control and assembly of Sanger chromatograms to identify genetic variants or verify sequence integrity in clinical and research samples."
homepage: https://workflowhub.eu/workflows/1635
---

# Training Sanger sequences CHD8

## Overview

This Galaxy workflow is designed for processing and analyzing Sanger sequencing data, specifically focusing on CHD8 sequences as part of a [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) tutorial. The process begins by unzipping raw sequence archives and filtering FASTA files to isolate specific target identifiers.

The pipeline converts raw `.ab1` chromatogram files into FASTQ format, followed by quality control steps including trimming with `seqtk` and grooming. It manages sequence orientation through reverse-complementation and uses regex-based find-and-replace tools to standardize sequence headers and identifiers.

For the final analysis, the workflow aligns the processed sequences using QIIME and generates a consensus sequence. The results are then verified using NCBI BLAST+ to ensure accurate identification of the genetic data. This workflow is licensed under the [MIT License](https://opensource.org/licenses/MIT) and serves as a standardized approach for Sanger sequence assembly and validation within the Galaxy ecosystem.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | AOPEP_and_CHD8_sequences_20220907.zip?download=1 | data_input |  |
| 1 | Prim | data_input |  |


Ensure your input ZIP file contains the raw .ab1 Sanger trace files and that your primer sequences are provided in FASTA format for accurate filtering. Since the workflow utilizes unzipping and collection-based processing, organizing your trace files into a structured dataset collection after extraction will streamline the downstream conversion to FASTQ. Refer to the README.md for specific regex patterns and identifier mapping required to correctly pair forward and reverse reads. You can use `planemo workflow_job_init` to generate a `job.yml` for automated testing of these input parameters. Detailed configuration for each tool step is available in the accompanying documentation.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Unzip | toolshed.g2.bx.psu.edu/repos/imgteam/unzip/unzip/6.0+galaxy0 |  |
| 3 | Filter FASTA | toolshed.g2.bx.psu.edu/repos/galaxyp/filter_by_fasta_ids/filter_by_fasta_ids/2.3 |  |
| 4 | Filter FASTA | toolshed.g2.bx.psu.edu/repos/galaxyp/filter_by_fasta_ids/filter_by_fasta_ids/2.3 |  |
| 5 | Extract element identifiers | toolshed.g2.bx.psu.edu/repos/iuc/collection_element_identifiers/collection_element_identifiers/0.0.2 |  |
| 6 | Degap.seqs | toolshed.g2.bx.psu.edu/repos/iuc/mothur_degap_seqs/mothur_degap_seqs/1.39.5.0 |  |
| 7 | Degap.seqs | toolshed.g2.bx.psu.edu/repos/iuc/mothur_degap_seqs/mothur_degap_seqs/1.39.5.0 |  |
| 8 | Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regex1/1.0.3 |  |
| 9 | Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regex1/1.0.3 |  |
| 10 | Reverse-Complement | toolshed.g2.bx.psu.edu/repos/devteam/fastx_reverse_complement/cshl_fastx_reverse_complement/1.0.2+galaxy0 |  |
| 11 | Filter collection | __FILTER_FROM_FILE__ |  |
| 12 | Filter collection | __FILTER_FROM_FILE__ |  |
| 13 | ab1 to FASTQ converter | toolshed.g2.bx.psu.edu/repos/ecology/ab1_fastq_converter/ab1_fastq_converter/1.20.0 |  |
| 14 | ab1 to FASTQ converter | toolshed.g2.bx.psu.edu/repos/ecology/ab1_fastq_converter/ab1_fastq_converter/1.20.0 |  |
| 15 | seqtk_trimfq | toolshed.g2.bx.psu.edu/repos/iuc/seqtk/seqtk_trimfq/1.3.1 |  |
| 16 | seqtk_trimfq | toolshed.g2.bx.psu.edu/repos/iuc/seqtk/seqtk_trimfq/1.3.1 |  |
| 17 | FASTQ Groomer | toolshed.g2.bx.psu.edu/repos/devteam/fastq_groomer/fastq_groomer/1.1.5 |  |
| 18 | Sort collection | __SORTLIST__ |  |
| 19 | Sort collection | __SORTLIST__ |  |
| 20 | Reverse-Complement | toolshed.g2.bx.psu.edu/repos/devteam/fastx_reverse_complement/cshl_fastx_reverse_complement/1.0.2+galaxy0 |  |
| 21 | seqtk_mergepe | toolshed.g2.bx.psu.edu/repos/iuc/seqtk/seqtk_mergepe/1.3.1 |  |
| 22 | FASTQ Groomer | toolshed.g2.bx.psu.edu/repos/devteam/fastq_groomer/fastq_groomer/1.1.5 |  |
| 23 | FASTQ to Tabular | toolshed.g2.bx.psu.edu/repos/devteam/fastq_to_tabular/fastq_to_tabular/1.1.5 |  |
| 24 | Tabular-to-FASTA | toolshed.g2.bx.psu.edu/repos/devteam/tabular_to_fasta/tab2fasta/1.1.1 |  |
| 25 | Align sequences | toolshed.g2.bx.psu.edu/repos/iuc/qiime_align_seqs/qiime_align_seqs/1.9.1.0 |  |
| 26 | Consensus sequence from aligned FASTA | toolshed.g2.bx.psu.edu/repos/ecology/aligned_to_consensus/aligned_to_consensus/1.0.0 |  |
| 27 | Merge.files | toolshed.g2.bx.psu.edu/repos/iuc/mothur_merge_files/mothur_merge_files/1.39.5.0 |  |
| 28 | Merge.files | toolshed.g2.bx.psu.edu/repos/iuc/mothur_merge_files/mothur_merge_files/1.39.5.0 |  |
| 29 | Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regex1/1.0.3 |  |
| 30 | Align sequences | toolshed.g2.bx.psu.edu/repos/iuc/qiime_align_seqs/qiime_align_seqs/1.9.1.0 |  |
| 31 | NCBI BLAST+ blastn | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_blastn_wrapper/2.10.1+galaxy2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 20 | output | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run training-sanger-sequences-chd8.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run training-sanger-sequences-chd8.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run training-sanger-sequences-chd8.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init training-sanger-sequences-chd8.ga -o job.yml`
- Lint: `planemo workflow_lint training-sanger-sequences-chd8.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `training-sanger-sequences-chd8.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
