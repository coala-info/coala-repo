---
name: cutampruncutamptag-analysis-protein-dna-interaction-mapping
description: This workflow processes paired-end FASTQ sequencing data for CUT&RUN and CUT&TAG epigenomic profiling using Cutadapt for trimming, Bowtie2 for alignment, and MACS2 for peak calling. Use this skill when you need to identify high-resolution genomic binding sites for transcription factors or histone modifications from low-input chromatin profiling experiments.
homepage: https://iwc.galaxyproject.org/
metadata:
  docker_image: "N/A"
---

# cutampruncutamptag-analysis-protein-dna-interaction-mapping

## Overview

This Galaxy workflow provides a comprehensive pipeline for mapping protein-DNA interactions using paired-end CUT&RUN or CUT&TAG sequencing data. It begins by preprocessing raw FASTQ files with [Cutadapt](https://toolshed.g2.bx.psu.edu/repos/lparsons/cutadapt/cutadapt/5.2+galaxy1) to remove adapters and low-quality bases, followed by alignment via [Bowtie2](https://toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.5.5+galaxy0). The alignment configuration is specifically optimized for short fragments, utilizing the dovetail option and supporting fragment lengths up to 1kb.

Post-alignment, the workflow applies rigorous quality controls, filtering for concordant pairs and a MAPQ score of at least 30. It utilizes [Picard MarkDuplicates](https://toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_MarkDuplicates/3.1.1.0) to remove PCR artifacts and converts the resulting BAM files to BED format via [bedtools](https://toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_bamtobed/2.31.1+galaxy0). This conversion ensures that [MACS2](https://toolshed.g2.bx.psu.edu/repos/iuc/macs2/macs2_callpeak/2.2.9.1+galaxy0) accounts for both ends of the paired-end fragments during peak calling.

The final stages focus on signal visualization and reporting. The workflow generates narrowPeak files and summits optimized for the punctate signals characteristic of these assays, alongside bigWig coverage tracks that can be normalized to Signal per Million Reads. A consolidated [MultiQC](https://toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.33+galaxy0) report is produced to provide a high-level overview of mapping statistics and library quality. For detailed information on input parameters and file preparation, please refer to the README.md in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | PE fastq input | data_collection_input | Should be a paired collection with CUT and RUN fastqs |
| 1 | adapter_forward | parameter_input | Please use: For R1: - For TrueSeq (CUT and RUN): GATCGGAAGAGCACACGTCTGAACTCCAGTCAC or AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC - For Nextera (CUT and TAG): CTGTCTCTTATACACATCTCCGAGCCCACGAGAC |
| 2 | adapter_reverse | parameter_input | Please use: For R2: - For TruSeq (CUT and RUN): GATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT or AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT - For Nextera (CUT and TAG): CTGTCTCTTATACACATCTGACGCTGCCGACGA |
| 3 | reference_genome | parameter_input | reference_genome |
| 4 | effective_genome_size | parameter_input | Used by MACS2: H. sapiens: 2700000000, M. musculus: 1870000000, D. melanogaster: 120000000, C. elegans: 90000000 |
| 5 | normalize_profile | parameter_input | Whether you want to have a profile normalized as Signal to Million Reads |


For optimal results, organize your paired-end sequencing data into a list of dataset pairs (fastqsanger) before launching the workflow. Ensure you provide the correct adapter sequences—typically TruSeq for CUT&RUN or Nextera for CUT&TAG—and specify the effective genome size required for accurate MACS2 peak calling. Refer to the `README.md` for detailed guidance on determining adapter types and selecting appropriate reference genome parameters. You can use `planemo workflow_job_init` to generate a `job.yml` file for streamlined execution and parameter management. Always verify that your input collection is properly formatted to ensure the downstream alignment and filtering steps process the paired reads correctly.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 6 | Cutadapt | toolshed.g2.bx.psu.edu/repos/lparsons/cutadapt/cutadapt/5.2+galaxy1 |  |
| 7 | Bowtie2 | toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.5.5+galaxy0 |  |
| 8 | Filter SAM or BAM, output SAM or BAM | toolshed.g2.bx.psu.edu/repos/devteam/samtool_filter2/samtool_filter2/1.8+galaxy1 |  |
| 9 | MarkDuplicates | toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_MarkDuplicates/3.1.1.0 |  |
| 10 | bedtools BAM to BED | toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_bamtobed/2.31.1+galaxy0 |  |
| 11 | MACS2 callpeak | toolshed.g2.bx.psu.edu/repos/iuc/macs2/macs2_callpeak/2.2.9.1+galaxy0 |  |
| 12 | Search in textfiles | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/9.5+galaxy3 |  |
| 13 | Wig/BedGraph-to-bigWig | wig_to_bigWig |  |
| 14 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.33+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 7 | Mapping stats | mapping_stats |
| 9 | BAM filtered rmDup | outFile |
| 9 | MarkDuplicates metrics | metrics_file |
| 11 | MACS2 summits | output_summits |
| 11 | MACS2 narrowPeak | output_narrowpeaks |
| 11 | MACS2 peaks xls | output_tabular |
| 12 | MACS2 report | output |
| 13 | Coverage from MACS2 (bigwig) | out_file1 |
| 14 | MultiQC on input dataset(s): Stats | stats |
| 14 | MultiQC webpage | html_report |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run cutandrun.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run cutandrun.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run cutandrun.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init cutandrun.ga -o job.yml`
- Lint: `planemo workflow_lint cutandrun.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `cutandrun.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)