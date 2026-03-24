---
name: gtn-sequence-analyses-removal-of-human-reads-from-sars-cov-2
description: "This Galaxy workflow processes SARS-CoV-2 sequencing data collections by trimming adapters with Trimmomatic and filtering out host sequences using BWA-MEM, Samtools, and seqtk. Use this skill when you need to decontaminate viral sequencing samples by removing human host reads to comply with privacy regulations or focus exclusively on pathogen genomics."
homepage: https://workflowhub.eu/workflows/1653
---

# GTN - Sequence Analyses - Removal of human reads from SARS-CoV-2 sequencing data

## Overview

This workflow is designed to sanitize SARS-CoV-2 sequencing data by identifying and removing human genomic sequences, a critical step for ensuring data privacy and improving the accuracy of downstream viral analysis. The process begins with quality control using [Trimmomatic](https://toolshed.g2.bx.psu.edu/repos/pjbriggs/trimmomatic/trimmomatic/0.38.1) to trim adapters and filter low-quality bases from the input dataset collection.

The core of the removal process involves aligning the processed reads against a human reference genome using [BWA-MEM](https://toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.17.2). By mapping the reads to the host genome, the workflow can distinguish between human genetic material and the viral sequences of interest.

Following alignment, the workflow utilizes [Samtools fastx](https://toolshed.g2.bx.psu.edu/repos/iuc/samtools_fastx/samtools_fastx/1.9+galaxy1) and text processing tools to isolate reads that did not map to the human reference. These filtered identifiers are then passed to [seqtk_subseq](https://toolshed.g2.bx.psu.edu/repos/iuc/seqtk/seqtk_subseq/1.3.1) to extract the final "clean" sequences. The resulting data is re-aggregated into a zipped collection, ready for specialized SARS-CoV-2 variant calling or assembly.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input Dataset Collection | data_collection_input |  |


Ensure your input data is organized as a paired-end dataset collection of FASTQ files to allow the workflow to process multiple samples simultaneously through Trimmomatic and BWA-MEM. During the mapping stage, verify that the human reference genome is correctly selected to ensure accurate identification and subsequent removal of host reads. For automated execution and reproducible parameter mapping, you can use `planemo workflow_job_init` to generate a template `job.yml` file. Please refer to the README.md for exhaustive details on tool configurations and specific data preparation steps required for this analysis.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Trimmomatic | toolshed.g2.bx.psu.edu/repos/pjbriggs/trimmomatic/trimmomatic/0.38.1 |  |
| 2 | Unzip Collection | __UNZIP_COLLECTION__ |  |
| 3 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.17.2 |  |
| 4 | Samtools fastx | toolshed.g2.bx.psu.edu/repos/iuc/samtools_fastx/samtools_fastx/1.9+galaxy1 |  |
| 5 | Select | Grep1 |  |
| 6 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_line/1.1.2 |  |
| 7 | seqtk_subseq | toolshed.g2.bx.psu.edu/repos/iuc/seqtk/seqtk_subseq/1.3.1 |  |
| 8 | seqtk_subseq | toolshed.g2.bx.psu.edu/repos/iuc/seqtk/seqtk_subseq/1.3.1 |  |
| 9 | Zip Collection | __ZIP_COLLECTION__ |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | fastq_out_unpaired | fastq_out_unpaired |
| 1 | fastq_out_paired | fastq_out_paired |
| 2 | forward | forward |
| 2 | reverse | reverse |
| 3 | bam_output | bam_output |
| 4 | forward | forward |
| 5 | out_file1 | out_file1 |
| 6 | outfile | outfile |
| 7 | default | default |
| 8 | default | default |
| 9 | Cleaned Data | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run human-reads-removal.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run human-reads-removal.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run human-reads-removal.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init human-reads-removal.ga -o job.yml`
- Lint: `planemo workflow_lint human-reads-removal.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `human-reads-removal.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
