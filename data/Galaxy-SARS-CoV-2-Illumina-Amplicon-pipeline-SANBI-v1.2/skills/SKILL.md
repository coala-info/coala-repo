---
name: sars-cov-2-illumina-amplicon-pipeline-sanbi-v12
description: "This workflow processes Illumina paired-end amplicon sequencing data for SARS-CoV-2 using tools like fastp, BBMap, iVar, and SnpEff to perform read filtering, alignment, and variant calling against a reference genome. Use this skill when you need to generate high-quality consensus genomes and identify annotated variants from COVID-19 clinical samples to track lineage evolution or public health outbreaks."
homepage: https://workflowhub.eu/workflows/519
---

# SARS-CoV-2 Illumina Amplicon pipeline - SANBI - v1.2

## Overview

This Galaxy workflow provides a comprehensive pipeline for the analysis of SARS-CoV-2 Illumina amplicon sequencing data, developed by the South African National Bioinformatics Institute (SANBI). It automates the process of transforming raw paired-end reads into consensus sequences and annotated variant calls. The pipeline integrates standard ARTIC network bioinformatics practices, utilizing tools like [fastp](https://github.com/OpenGene/fastp) for quality control and [BBMap](https://sourceforge.net/projects/bbmap/) for alignment against a reference genome.

The workflow performs essential post-alignment processing, including primer clipping via `samtools ampliconclip` and variant calling using [iVar](https://andersen-lab.github.io/ivar/html/manualpage.html). It generates high-quality consensus genomes and annotates variants with [SnpEff](https://pcingola.github.io/SnpEff/), specifically tailored for SARS-CoV-2. Users can customize the analysis by adjusting parameters for read fractions, minimum quality scores, and coverage thresholds.

Final outputs include primer-trimmed BAM files, tabular variant reports, annotated VCFs, and consensus FASTA files. The pipeline also produces comprehensive quality metrics through [QualiMap](http://qualimap.genesilico.pl/) and [MultiQC](https://multiqc.info/), alongside aggregated coverage data and multi-FASTA collections for downstream phylogenetics. This workflow is released under the **MIT** license and is tagged for **COVID-19**, **ARTIC**, and **iwc** (Intergalactic Workflow Commission) standards.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Paired read collection for samples | data_collection_input |  |
| 1 | Reference FASTA | data_input |  |
| 2 | Primer BED | data_input |  |
| 3 | Read fraction to call variant | parameter_input |  |
| 4 | Minimum quality score to call base | parameter_input |  |
| 5 | Max Viz. Coverage Threshold | parameter_input |  |


Ensure your input reads are organized into a paired-end dataset collection (fastqsanger) to enable batch processing, while the reference genome and primer scheme must be provided as individual FASTA and BED datasets respectively. Verify that your primer BED file follows the standard ARTIC format to ensure accurate amplicon clipping and variant calling. For automated execution and parameter reproducibility, you can initialize a job template using `planemo workflow_job_init` to generate a `job.yml` file. Consult the accompanying README.md for comprehensive details on specific parameter thresholds and tool configurations.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 6 | Read It and Keep | toolshed.g2.bx.psu.edu/repos/iuc/read_it_and_keep/read_it_and_keep/0.2.2+galaxy0 |  |
| 7 | Text transformation | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sed_tool/1.1.1 |  |
| 8 | Text transformation | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sed_tool/1.1.1 |  |
| 9 | Compose text parameter value | toolshed.g2.bx.psu.edu/repos/iuc/compose_text_param/compose_text_param/0.1.1 |  |
| 10 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.20.1+galaxy0 |  |
| 11 | BBTools: BBMap | toolshed.g2.bx.psu.edu/repos/iuc/bbtools_bbmap/bbtools_bbmap/1.0.0+galaxy4 |  |
| 12 | Samtools stats | toolshed.g2.bx.psu.edu/repos/devteam/samtools_stats/samtools_stats/2.0.2+galaxy2 |  |
| 13 | Samtools view | toolshed.g2.bx.psu.edu/repos/iuc/samtools_view/samtools_view/1.9+galaxy3 |  |
| 14 | QualiMap BamQC | toolshed.g2.bx.psu.edu/repos/iuc/qualimap_bamqc/qualimap_bamqc/2.2.2d+galaxy3 |  |
| 15 | Samtools ampliconclip | toolshed.g2.bx.psu.edu/repos/iuc/samtools_ampliconclip/samtools_ampliconclip/1.13 |  |
| 16 | Flatten collection | __FLATTEN__ |  |
| 17 | ivar variants | toolshed.g2.bx.psu.edu/repos/iuc/ivar_variants/ivar_variants/1.3.1+galaxy2 |  |
| 18 | ivar consensus | toolshed.g2.bx.psu.edu/repos/iuc/ivar_consensus/ivar_consensus/1.3.1+galaxy0 |  |
| 19 | bamCoverage | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_bam_coverage/deeptools_bam_coverage/3.5.1.0.0 |  |
| 20 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.11+galaxy0 |  |
| 21 | SnpEff eff: | toolshed.g2.bx.psu.edu/repos/iuc/snpeff_sars_cov_2/snpeff_sars_cov_2/4.5covid19 |  |
| 22 | Text transformation | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sed_tool/1.1.1 |  |
| 23 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 24 | Concatenate datasets | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cat/0.1.1 |  |
| 25 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/1.1.2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 15 | primer_trimmed_bam | output_bam |
| 17 | ivar_variants_tabular | output_variants_tabular |
| 20 | bamqc_report_html | html_report |
| 21 | snpeff_annotated_vcf | snpeff_output |
| 22 | ivar_consensus_genome | output |
| 23 | combined_coverage | output |
| 24 | combined_multifasta | out_file1 |
| 25 | outfile | outfile |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-SARS-CoV-2_Illumina_Amplicon_pipeline_-_SANBI_-_v1.2.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-SARS-CoV-2_Illumina_Amplicon_pipeline_-_SANBI_-_v1.2.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-SARS-CoV-2_Illumina_Amplicon_pipeline_-_SANBI_-_v1.2.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-SARS-CoV-2_Illumina_Amplicon_pipeline_-_SANBI_-_v1.2.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-SARS-CoV-2_Illumina_Amplicon_pipeline_-_SANBI_-_v1.2.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-SARS-CoV-2_Illumina_Amplicon_pipeline_-_SANBI_-_v1.2.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
