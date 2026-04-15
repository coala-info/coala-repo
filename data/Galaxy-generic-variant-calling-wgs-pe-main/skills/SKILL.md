---
name: generic-variation-analysis-on-wgs-pe-data
description: This workflow performs variant analysis on paired-end whole genome sequencing data by mapping reads with BWA-MEM and calling variants with LoFreq against a GenBank-formatted reference genome. Use this skill when you need to identify and annotate genetic variations across a wide range of allele frequencies in viral or bacterial samples using sensitive calling and SnpEff functional annotation.
homepage: https://iwc.galaxyproject.org/
metadata:
  docker_image: "N/A"
---

# generic-variation-analysis-on-wgs-pe-data

## Overview

This workflow performs comprehensive variant analysis on Whole Genome Sequencing (WGS) paired-end data. It is designed to be versatile, utilizing a reference genome provided in GenBank format to support various organisms, including those related to the `mpxv` tag. The pipeline requires a paired-end data collection, a GenBank genome file, and a specified name for the generated genome database.

The process begins with quality control and adapter trimming using [fastp](https://github.com/OpenGene/fastp), while simultaneously building a custom [SnpEff](https://pcingola.github.io/SnpEff/) database from the input GenBank file. Reads are mapped to the reference using [BWA-MEM](https://github.com/lh3/bwa), followed by alignment cleaning with [Samtools](http://www.htslib.org/) and duplicate removal via [Picard MarkDuplicates](https://broadinstitute.github.io/picard/).

For sensitive variant detection, the workflow employs the [Lofreq](https://csb5.github.io/lofreq/) suite, which performs Viterbi realignment and adds indel qualities to improve calling accuracy across a wide range of allele frequencies. The resulting variants are then filtered and annotated with functional information using SnpEff. [MultiQC](https://multiqc.info/) is used to aggregate preprocessing and mapping statistics into a single report.

This workflow is released under the MIT license. For specific details on input preparation and execution, please refer to the [README.md](README.md) located in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Paired Collection | data_collection_input | Illumina reads with fastqsanger encoding |
| 1 | GenBank genome | data_input | GenBank with annotations for the genome of interest |
| 2 | Name for genome database | parameter_input | Should describe your reference genome, e.g. mpxv for Monkeypox virus. |


Ensure your sequencing data is organized as a Paired Collection of fastq.gz files and that your reference genome is provided in GenBank format to enable automated SnpEff database building. You must provide a specific string for the genome database name to ensure consistency across the annotation steps. For automated execution, you can initialize a job template using `planemo workflow_job_init` to generate a `job.yml` file. Refer to the README.md for comprehensive details on file preparation and specific parameter requirements. This workflow is optimized for sensitive variant calling across a wide range of allele frequencies using LoFreq.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.23.2+galaxy0 |  |
| 4 | SnpEff build: | toolshed.g2.bx.psu.edu/repos/iuc/snpeff/snpEff_build_gb/4.3+T.galaxy4 |  |
| 5 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.17.2 |  |
| 6 | Samtools view | toolshed.g2.bx.psu.edu/repos/iuc/samtools_view/samtools_view/1.13+galaxy1 |  |
| 7 | MarkDuplicates | toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_MarkDuplicates/2.18.2.2 |  |
| 8 | Samtools stats | toolshed.g2.bx.psu.edu/repos/devteam/samtools_stats/samtools_stats/2.0.2+galaxy2 |  |
| 9 | Realign reads | toolshed.g2.bx.psu.edu/repos/iuc/lofreq_viterbi/lofreq_viterbi/2.1.5+galaxy0 |  |
| 10 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.11+galaxy0 |  |
| 11 | Insert indel qualities | toolshed.g2.bx.psu.edu/repos/iuc/lofreq_indelqual/lofreq_indelqual/2.1.5+galaxy0 |  |
| 12 | Call variants | toolshed.g2.bx.psu.edu/repos/iuc/lofreq_call/lofreq_call/2.1.5+galaxy1 |  |
| 13 | Lofreq filter | toolshed.g2.bx.psu.edu/repos/iuc/lofreq_filter/lofreq_filter/2.1.5+galaxy0 |  |
| 14 | SnpEff eff: | toolshed.g2.bx.psu.edu/repos/iuc/snpeff/snpEff/4.3+T.galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | fastp_pe | output_paired_coll |
| 3 | fastp_html_report | report_html |
| 4 | SnpEff4.3 database | snpeff_output |
| 4 | Fasta sequences for genbank file | output_fasta |
| 5 | bwa_mem_alignments | bam_output |
| 6 | filtered_alignment | outputsam |
| 7 | markduplicates_stats | metrics_file |
| 7 | markduplicates_reads | outFile |
| 8 | mapped_reads_stats | output |
| 9 | realigned_deduplicated_filtered_mapped_reads | realigned |
| 10 | preprocessing_and_mapping_reports | html_report |
| 11 | realigned_deduplicated_filtered_mapped_reads_with_indel_quals | output |
| 12 | called_variants | variants |
| 13 | soft_filtered_variants | outvcf |
| 14 | SnpEff eff: stats | statsFile |
| 14 | SnpEff variants | snpeff_output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Generic-variation-analysis-on-WGS-PE-data.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Generic-variation-analysis-on-WGS-PE-data.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Generic-variation-analysis-on-WGS-PE-data.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Generic-variation-analysis-on-WGS-PE-data.ga -o job.yml`
- Lint: `planemo workflow_lint Generic-variation-analysis-on-WGS-PE-data.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Generic-variation-analysis-on-WGS-PE-data.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)