---
name: sanger1-from-ab1-to-aligned-consensus-and-primers-fasta-blas
description: This Galaxy workflow processes forward and reverse Sanger sequencing chromatograms in AB1 format using primers to perform quality trimming, sequence alignment with QIIME, and taxonomic identification via NCBI BLAST+. Use this skill when you need to transform raw DNA trace files into validated consensus sequences for biodiversity monitoring or species-level identification.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# sanger1-from-ab1-to-aligned-consensus-and-primers-fasta-blas

## Overview

This workflow automates the processing of Sanger sequencing data, transforming raw chromatogram files into aligned consensus sequences and taxonomic identifications. It accepts forward (L) and reverse (H) sequence collections in AB1 format, alongside LCOI and HCOI primer sequences, providing a streamlined pipeline for DNA barcoding and sequence analysis.

The pipeline begins by converting AB1 files to FASTQ format and performing quality trimming using [seqtk](https://toolshed.g2.bx.psu.edu/repos/iuc/seqtk/seqtk_trimfq/1.3.1). It manages sequence orientation through reverse-complementation and merges paired reads to reconstruct the full-length target fragment. Additional processing steps include degapping and filtering to ensure only high-quality data proceeds to the alignment phase.

In the final stages, sequences are aligned using [QIIME](https://toolshed.g2.bx.psu.edu/repos/iuc/qiime_align_seqs/qiime_align_seqs/1.9.1.0) to generate a representative consensus sequence. This consensus is then queried against databases using [NCBI BLAST+](https://toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_blastn_wrapper/2.10.1+galaxy2) for identification. This [GTN](https://training.galaxyproject.org/) compatible workflow is released under the [MIT](https://opensource.org/licenses/MIT) license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | L sequences (Forward) | data_collection_input |  |
| 1 | H sequences (Reverse) | data_collection_input |  |
| 2 | LCOI primers | data_input |  |
| 3 | HCOI primers | data_input |  |


Ensure your forward (L) and reverse (H) Sanger sequences are uploaded as .ab1 files and organized into two separate list collections with matching element identifiers to facilitate proper merging. The LCOI and HCOI primer sequences should be provided as individual FASTA datasets. For automated execution, you can initialize a job template using `planemo workflow_job_init` to configure your `job.yml`. Refer to the README.md for comprehensive details on parameter settings and naming conventions required for successful alignment. One should verify that the collection order is consistent before running the workflow to ensure correct pairing of forward and reverse reads.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | ab1 to FASTQ converter | toolshed.g2.bx.psu.edu/repos/ecology/ab1_fastq_converter/ab1_fastq_converter/1.20.0 |  |
| 5 | ab1 to FASTQ converter | toolshed.g2.bx.psu.edu/repos/ecology/ab1_fastq_converter/ab1_fastq_converter/1.20.0 |  |
| 6 | Filter FASTA | toolshed.g2.bx.psu.edu/repos/galaxyp/filter_by_fasta_ids/filter_by_fasta_ids/2.3 |  |
| 7 | Filter FASTA | toolshed.g2.bx.psu.edu/repos/galaxyp/filter_by_fasta_ids/filter_by_fasta_ids/2.3 |  |
| 8 | seqtk_trimfq | toolshed.g2.bx.psu.edu/repos/iuc/seqtk/seqtk_trimfq/1.3.1 |  |
| 9 | seqtk_trimfq | toolshed.g2.bx.psu.edu/repos/iuc/seqtk/seqtk_trimfq/1.3.1 |  |
| 10 | Degap.seqs | toolshed.g2.bx.psu.edu/repos/iuc/mothur_degap_seqs/mothur_degap_seqs/1.39.5.0 |  |
| 11 | Degap.seqs | toolshed.g2.bx.psu.edu/repos/iuc/mothur_degap_seqs/mothur_degap_seqs/1.39.5.0 |  |
| 12 | Sort collection | __SORTLIST__ |  |
| 13 | FASTQ Groomer | toolshed.g2.bx.psu.edu/repos/devteam/fastq_groomer/fastq_groomer/1.1.5 |  |
| 14 | Reverse-Complement | toolshed.g2.bx.psu.edu/repos/devteam/fastx_reverse_complement/cshl_fastx_reverse_complement/1.0.2+galaxy0 |  |
| 15 | Reverse-Complement | toolshed.g2.bx.psu.edu/repos/devteam/fastx_reverse_complement/cshl_fastx_reverse_complement/1.0.2+galaxy0 |  |
| 16 | Sort collection | __SORTLIST__ |  |
| 17 | seqtk_mergepe | toolshed.g2.bx.psu.edu/repos/iuc/seqtk/seqtk_mergepe/1.3.1 |  |
| 18 | FASTQ Groomer | toolshed.g2.bx.psu.edu/repos/devteam/fastq_groomer/fastq_groomer/1.1.5 |  |
| 19 | FASTQ to Tabular | toolshed.g2.bx.psu.edu/repos/devteam/fastq_to_tabular/fastq_to_tabular/1.1.5 |  |
| 20 | Tabular-to-FASTA | toolshed.g2.bx.psu.edu/repos/devteam/tabular_to_fasta/tab2fasta/1.1.1 |  |
| 21 | Align sequences | toolshed.g2.bx.psu.edu/repos/iuc/qiime_align_seqs/qiime_align_seqs/1.9.1.0 |  |
| 22 | Consensus sequence from aligned FASTA | toolshed.g2.bx.psu.edu/repos/ecology/aligned_to_consensus/aligned_to_consensus/1.0.0 |  |
| 23 | Merge.files | toolshed.g2.bx.psu.edu/repos/iuc/mothur_merge_files/mothur_merge_files/1.39.5.0 |  |
| 24 | Merge.files | toolshed.g2.bx.psu.edu/repos/iuc/mothur_merge_files/mothur_merge_files/1.39.5.0 |  |
| 25 | Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regex1/1.0.3 |  |
| 26 | Align sequences | toolshed.g2.bx.psu.edu/repos/iuc/qiime_align_seqs/qiime_align_seqs/1.9.1.0 |  |
| 27 | NCBI BLAST+ blastn | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_blastn_wrapper/2.10.1+galaxy2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | output | output |
| 8 | default | default |
| 9 | default | default |
| 12 | output | output |
| 13 | output_file | output_file |
| 15 | output | output |
| 16 | output | output |
| 17 | default | default |
| 18 | output_file | output_file |
| 21 | log | log |
| 21 | aligned_sequences | aligned_sequences |
| 22 | output | output |
| 23 | output | output |
| 24 | output | output |
| 25 | out_file1 | out_file1 |
| 26 | aligned_sequences | aligned_sequences |
| 26 | log | log |
| 27 | w_blast_output | blast_output |
| 27 | w_consensus_aligned_sequences | consensus_aligned_sequences |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run sanger1-from-ab1-to-aligned-consensus-and-primers-fasta---blast.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run sanger1-from-ab1-to-aligned-consensus-and-primers-fasta---blast.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run sanger1-from-ab1-to-aligned-consensus-and-primers-fasta---blast.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init sanger1-from-ab1-to-aligned-consensus-and-primers-fasta---blast.ga -o job.yml`
- Lint: `planemo workflow_lint sanger1-from-ab1-to-aligned-consensus-and-primers-fasta---blast.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `sanger1-from-ab1-to-aligned-consensus-and-primers-fasta---blast.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)