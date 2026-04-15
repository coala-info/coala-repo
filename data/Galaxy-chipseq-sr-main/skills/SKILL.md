---
name: chip-seq-analysis-single-end-read-processing
description: This Galaxy workflow processes single-end ChIP-seq FASTQ files through adapter trimming with fastp, Bowtie2 alignment, and MACS2 peak calling to identify protein-DNA binding sites. Use this skill when you need to characterize transcription factor binding or histone modifications from single-end sequencing data by generating high-quality alignment files, peak calls, and normalized coverage profiles.
homepage: https://iwc.galaxyproject.org/
metadata:
  docker_image: "N/A"
---

# chip-seq-analysis-single-end-read-processing

## Overview

This Galaxy workflow provides a comprehensive pipeline for processing single-end ChIP-seq data, from raw FASTQ files to peak calling and visualization. It begins with automated adapter removal and quality filtering using [fastp](https://toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/1.0.1+galaxy2), which discards short reads and those with low-quality bases. Cleaned reads are then aligned to a user-specified reference genome using [Bowtie2](https://toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.5.4+galaxy0) and filtered to retain only high-confidence mappings (MAPQ > 30).

Protein-DNA binding sites are identified using [MACS2](https://toolshed.g2.bx.psu.edu/repos/iuc/macs2/macs2_callpeak/2.2.9.1+galaxy0) with a fixed 200bp extension. The workflow handles PCR duplicates during the peak calling stage and generates several key outputs, including narrowPeak files, summits, and normalized or unnormalized coverage profiles. These profiles are automatically converted to BigWig format for seamless integration with genome browsers.

The pipeline concludes by aggregating quality metrics into a [MultiQC](https://toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.27+galaxy3) report, offering a centralized view of trimming statistics, alignment rates, and peak calling results. Users can customize parameters such as adapter sequences, effective genome size, and normalization methods to suit specific experimental designs. This workflow is released under the MIT license and is tagged for ChIP-seq analysis.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | SR fastq input | data_collection_input | Should be a collection with ChIPseq fastqs |
| 1 | Adapter sequence | parameter_input | You can decide to leave it empty for an automatic detection or - For Nextera: CTGTCTCTTATACACATCTCCGAGCCCACGAGAC  - For TruSeq: GATCGGAAGAGCACACGTCTGAACTCCAGTCAC or AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC |
| 2 | Percentage of bad quality bases per read | parameter_input | fastp will discard any read which has more than this percentage of bases with a quality below 30, use 100 to not filter reads based on quality. We recommend to use a value that corresponds approximately to 15bp of good quality (for 100bp reads use 85, for 50bp use 70) |
| 3 | Reference genome | parameter_input | Choose a reference genome to map on |
| 4 | Effective genome size | parameter_input | Used by MACS2: H. sapiens: 2700000000, M. musculus: 1870000000, D. melanogaster: 120000000, C. elegans: 90000000 |
| 5 | Normalize profile | parameter_input | Whether you want to have a profile normalized as Signal to Million Reads |


Organize your single-end sequencing data into a dataset collection of `fastqsanger` files to ensure the workflow processes all samples simultaneously. Before execution, verify your specific adapter sequences and determine the effective genome size required by MACS2 for your target organism. You can automate the configuration of these parameters and input collections by using `planemo workflow_job_init` to generate a `job.yml` file. Refer to the README.md for comprehensive details on quality thresholds and normalization options. Always ensure your reference genome selection matches the Bowtie2 indices available on your Galaxy instance.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 6 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/1.0.1+galaxy2 |  |
| 7 | Bowtie2 | toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.5.4+galaxy0 |  |
| 8 | Filter SAM or BAM, output SAM or BAM | toolshed.g2.bx.psu.edu/repos/devteam/samtool_filter2/samtool_filter2/1.8+galaxy1 |  |
| 9 | MACS2 callpeak | toolshed.g2.bx.psu.edu/repos/iuc/macs2/macs2_callpeak/2.2.9.1+galaxy0 |  |
| 10 | Search in textfiles | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/9.5+galaxy2 | summary of MACS2 |
| 11 | Wig/BedGraph-to-bigWig | wig_to_bigWig |  |
| 12 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.27+galaxy3 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 7 | mapping stats | mapping_stats |
| 8 | filtered BAM | output1 |
| 9 | MACS2 narrowPeak | output_narrowpeaks |
| 9 | MACS2 summits | output_summits |
| 9 | MACS2 peaks | output_tabular |
| 10 | MACS2 report | output |
| 11 | coverage from MACS2 | out_file1 |
| 12 | MultiQC on input dataset(s): Stats | stats |
| 12 | MultiQC webpage | html_report |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run chipseq-sr.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run chipseq-sr.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run chipseq-sr.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init chipseq-sr.ga -o job.yml`
- Lint: `planemo workflow_lint chipseq-sr.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `chipseq-sr.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)