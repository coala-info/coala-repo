---
name: variant-calling-from-matched-tumornormal-sample-pair-hg38-ve
description: This workflow performs somatic variant calling from matched tumor and normal paired-end FASTQ reads using BWA-MEM for alignment and VarScan for mutation detection against the hg38 reference genome. Use this skill when you need to identify tumor-specific genomic alterations while filtering out germline variations and assessing sample quality through comprehensive metrics.
homepage: https://usegalaxy.eu
metadata:
  docker_image: "N/A"
---

# variant-calling-from-matched-tumornormal-sample-pair-hg38-ve

## Overview

This Galaxy workflow performs somatic variant calling using matched tumor and normal sample pairs aligned to the hg38 reference genome. It is designed to process paired-end sequencing data, accepting forward and reverse reads for both tissue types alongside critical metadata such as estimated tissue purity, patient sex, and specific genomic regions of interest.

The pipeline begins with rigorous raw data quality control using [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) and [MultiQC](https://multiqc.info/), followed by adapter trimming and filtering via [Trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic). Cleaned reads are mapped to the reference genome using [BWA-MEM](http://bio-bwa.sourceforge.net/). Subsequent processing steps include duplicate removal with Samtools, indel realignment via BamLeftAlign, and MD tag calculation to refine the alignments for accurate downstream analysis.

Somatic mutations are identified using [VarScan somatic](http://varscan.sourceforge.net/), which statistically compares the tumor and normal samples to distinguish somatic alterations from germline variants and sequencing noise. The workflow also generates comprehensive alignment reports through [QualiMap BamQC](http://qualimap.conesalab.org/), providing insights into genomic coverage and mapping quality for both samples.

Developed under the [EOSC4Cancer](https://eosc4cancer.eu/) initiative and licensed under GPL-3.0-or-later, this workflow ensures a standardized approach to cancer genomics. For detailed execution instructions and parameter configurations, please refer to the [README.md](README.md) in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | ID of matched normal sample | parameter_input |  |
| 1 | NORMAL sample forward reads | data_input |  |
| 2 | NORMAL sample reverse reads | data_input |  |
| 3 | Sample ID (tumor tissue) | parameter_input |  |
| 5 | TUMOR sample forward reads | data_input |  |
| 6 | TUMOR sample reverse reads | data_input |  |
| 7 | Estimated tumor tissue purity | parameter_input |  |
| 9 | Estimated normal tissue purity | parameter_input |  |
| 10 | Patient sex | parameter_input |  |
| 11 | Regions of interest | data_input |  |


To prepare for this workflow, ensure your paired-end sequencing data for both normal and tumor samples are in fastq.gz format and that your regions of interest are provided as a BED file. You should input the forward and reverse reads as individual datasets for each sample, while ensuring the patient sex and tissue purity parameters are accurately specified to guide the somatic variant calling. For large-scale runs, you can automate the setup of these parameters and inputs using `planemo workflow_job_init` to generate a `job.yml` file. Detailed descriptions of each parameter and specific file requirements can be found in the accompanying README.md. Please verify that all input datasets are correctly labeled to ensure the metadata and final reports are generated with the proper sample identifiers.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | Compose text parameter value | toolshed.g2.bx.psu.edu/repos/iuc/compose_text_param/compose_text_param/0.1.1 |  |
| 8 | Compose text parameter value | toolshed.g2.bx.psu.edu/repos/iuc/compose_text_param/compose_text_param/0.1.1 |  |
| 12 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.73+galaxy0 |  |
| 13 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.73+galaxy0 |  |
| 14 | Trimmomatic | toolshed.g2.bx.psu.edu/repos/pjbriggs/trimmomatic/trimmomatic/0.38.1 |  |
| 15 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.73+galaxy0 |  |
| 16 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.73+galaxy0 |  |
| 17 | Trimmomatic | toolshed.g2.bx.psu.edu/repos/pjbriggs/trimmomatic/trimmomatic/0.38.1 |  |
| 18 | Create text file | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_text_file_with_recurring_lines/1.1.0 |  |
| 19 | Compose text parameter value | toolshed.g2.bx.psu.edu/repos/iuc/compose_text_param/compose_text_param/0.1.1 |  |
| 20 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.17.1 |  |
| 21 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.73+galaxy0 |  |
| 22 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.73+galaxy0 |  |
| 23 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.9 |  |
| 24 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.17.1 |  |
| 25 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.73+galaxy0 |  |
| 26 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.73+galaxy0 |  |
| 27 | Create text file | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_text_file_with_recurring_lines/1.1.0 |  |
| 28 | Samtools view | toolshed.g2.bx.psu.edu/repos/iuc/samtools_view/samtools_view/1.9+galaxy3 |  |
| 29 | Build list | __BUILD_LIST__ |  |
| 30 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.9 |  |
| 31 | Convert | Convert characters1 |  |
| 32 | Select | Grep1 |  |
| 33 | Relabel identifiers | __RELABEL_FROM_FILE__ |  |
| 34 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_line/1.1.2 |  |
| 35 | Samtools view | toolshed.g2.bx.psu.edu/repos/iuc/samtools_view/samtools_view/1.9+galaxy3 |  |
| 36 | Pick parameter value | pick_value |  |
| 37 | RmDup | toolshed.g2.bx.psu.edu/repos/devteam/samtools_rmdup/samtools_rmdup/2.0.1 |  |
| 38 | BamLeftAlign | toolshed.g2.bx.psu.edu/repos/devteam/freebayes/bamleftalign/1.3.1 |  |
| 39 | CalMD | toolshed.g2.bx.psu.edu/repos/devteam/samtools_calmd/samtools_calmd/2.0.2 |  |
| 40 | Samtools view | toolshed.g2.bx.psu.edu/repos/iuc/samtools_view/samtools_view/1.9+galaxy3 |  |
| 41 | Samtools view | toolshed.g2.bx.psu.edu/repos/iuc/samtools_view/samtools_view/1.9+galaxy3 |  |
| 42 | Extract dataset | __EXTRACT_DATASET__ |  |
| 43 | Extract dataset | __EXTRACT_DATASET__ |  |
| 44 | QualiMap BamQC | toolshed.g2.bx.psu.edu/repos/iuc/qualimap_bamqc/qualimap_bamqc/2.2.2d+galaxy3 |  |
| 45 | QualiMap BamQC | toolshed.g2.bx.psu.edu/repos/iuc/qualimap_bamqc/qualimap_bamqc/2.2.2d+galaxy3 |  |
| 46 | VarScan somatic | toolshed.g2.bx.psu.edu/repos/iuc/varscan_somatic/varscan_somatic/2.4.3.6 |  |
| 47 | Extract dataset | __EXTRACT_DATASET__ |  |
| 48 | Extract dataset | __EXTRACT_DATASET__ |  |
| 49 | Split file | toolshed.g2.bx.psu.edu/repos/bgruening/split_file_to_collection/split_file_to_collection/0.5.0 |  |
| 50 | Split file | toolshed.g2.bx.psu.edu/repos/bgruening/split_file_to_collection/split_file_to_collection/0.5.0 |  |
| 51 | Apply rules | __APPLY_RULES__ |  |
| 52 | Apply rules | __APPLY_RULES__ |  |
| 53 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/4.2 |  |
| 54 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/4.2 |  |
| 55 | Select | Grep1 |  |
| 56 | Select | Grep1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 12 | fastqc_html_normal_fw_before | html_file |
| 13 | fastqc_html_normal_rv_before | html_file |
| 15 | fastqc_html_tumor_fw_before | html_file |
| 16 | fastqc_html_tumor_rv_before | html_file |
| 21 | fastqc_html_normal_fw_after | html_file |
| 22 | fastqc_html_normal_rv_after | html_file |
| 23 | multiqc_html_pre_trim | html_report |
| 25 | fastqc_html_tumor_fw_after | html_file |
| 26 | fastqc_html_tumor_rv_after | html_file |
| 30 | multiqc_html_post_trim | html_report |
| 31 | analysis_metadata | out_file1 |
| 44 | bamqc_html_normal | output_html |
| 45 | bamqc_html_tumor | output_html |
| 46 | VarScan Output | output |
| 55 | bamqc_normal_genome_results | out_file1 |
| 56 | bamqc_tumor_genome_results | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Variant_calling_from_matched_tumor_normal_sample_pair_(hg38_version).ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Variant_calling_from_matched_tumor_normal_sample_pair_(hg38_version).ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Variant_calling_from_matched_tumor_normal_sample_pair_(hg38_version).ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Variant_calling_from_matched_tumor_normal_sample_pair_(hg38_version).ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Variant_calling_from_matched_tumor_normal_sample_pair_(hg38_version).ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Variant_calling_from_matched_tumor_normal_sample_pair_(hg38_version).ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)