---
name: chip-seq-analysis-paired-end-read-processing
description: "This Galaxy workflow processes paired-end ChIP-seq FASTQ collections through adapter trimming with fastp, Bowtie2 alignment, and MACS2 peak calling to identify protein-DNA binding sites. Use this skill when you need to map transcription factor or histone modification locations, filter for high-quality concordant read pairs, and generate normalized genomic coverage profiles from paired-end sequencing data."
homepage: https://workflowhub.eu/workflows/398
---

# ChIP-seq Analysis: Paired-End Read Processing

## Overview

This Galaxy workflow provides a comprehensive pipeline for processing paired-end ChIP-seq data, from raw FASTQ files to peak calling and visualization. It begins with quality control and adapter trimming using [fastp](https://github.com/OpenGene/fastp), which filters out low-quality bases and short fragments. The processed reads are then aligned to a reference genome using [Bowtie2](https://bowtie-bio.sourceforge.net/bowtie2/index.shtml).

To ensure high-quality results, the workflow applies stringent filters to the alignment files, retaining only concordant pairs with a mapping quality (MAPQ) score greater than 30. Protein-DNA binding sites are identified using [MACS2](https://github.com/macs3-project/MACS), which is optimized for paired-end data and handles PCR duplicate removal during the peak calling process.

The final outputs include filtered BAM files, identified peaks (narrowPeak and summits), and bigWig coverage tracks for genomic visualization. A comprehensive [MultiQC](https://multiqc.info/) report is also generated to aggregate quality metrics across all processing steps. This workflow is released under the MIT license and is tagged for ChIP-seq applications.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | PE fastq input | data_collection_input | Should be a paired collection with ChIPseq fastqs |
| 1 | Percentage of bad quality bases per read | parameter_input | fastp will discard any read which has more than this percentage of bases with a quality below 30, use 100 to not filter reads based on quality. We recommend to use a value that corresponds approximately to 15bp of good quality (for 100bp reads use 85, for 50bp use 70) |
| 2 | Reference genome | parameter_input | Choose a reference genome to map on |
| 3 | Effective genome size | parameter_input | Used by MACS2: H. sapiens: 2700000000, M. musculus: 1870000000, D. melanogaster: 120000000, C. elegans: 90000000 |
| 4 | Normalize profile | parameter_input | Whether you want to have a profile normalized as Signal to Million Fragments |


Ensure your raw sequencing data is organized as a list of dataset pairs in `fastqsanger` format to satisfy the paired-end requirement. You must provide the specific effective genome size for MACS2 and select the appropriate Bowtie2 index for your reference genome. For automated execution, you can initialize your configuration using `planemo workflow_job_init` to generate a `job.yml` file. Refer to the `README.md` for detailed guidance on parameter values like the quality base percentage and normalization options. Note that while the workflow filters for high-quality concordant pairs, MACS2 handles the final removal of PCR duplicates during peak calling.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 5 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/1.0.1+galaxy2 |  |
| 6 | Bowtie2 | toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.5.4+galaxy0 |  |
| 7 | Filter SAM or BAM, output SAM or BAM | toolshed.g2.bx.psu.edu/repos/devteam/samtool_filter2/samtool_filter2/1.8+galaxy1 |  |
| 8 | MACS2 callpeak | toolshed.g2.bx.psu.edu/repos/iuc/macs2/macs2_callpeak/2.2.9.1+galaxy0 |  |
| 9 | Search in textfiles | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/9.5+galaxy2 | summary of MACS2 |
| 10 | Wig/BedGraph-to-bigWig | wig_to_bigWig |  |
| 11 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.27+galaxy3 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 6 | mapping stats | mapping_stats |
| 7 | filtered BAM | output1 |
| 8 | MACS2 peaks | output_tabular |
| 8 | MACS2 narrowPeak | output_narrowpeaks |
| 8 | MACS2 summits | output_summits |
| 9 | MACS2 report | output |
| 10 | coverage from MACS2 | out_file1 |
| 11 | MultiQC on input dataset(s): Stats | stats |
| 11 | MultiQC webpage | html_report |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run chipseq-pe.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run chipseq-pe.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run chipseq-pe.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init chipseq-pe.ga -o job.yml`
- Lint: `planemo workflow_lint chipseq-pe.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `chipseq-pe.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
