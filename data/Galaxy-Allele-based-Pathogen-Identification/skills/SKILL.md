---
name: allele-based-pathogen-identification
description: This microbiome workflow performs allele-based pathogen identification by mapping preprocessed sample collections to a reference genome using Minimap2, Clair3, and BCFtools. Use this skill when you need to accurately identify pathogen strains and analyze genetic variations within complex microbial samples to support epidemiological surveillance or clinical diagnostics.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# allele-based-pathogen-identification

## Overview

This workflow is designed for microbiome analysis, specifically focusing on variant calling and consensus building to identify pathogen strains. It processes a collection of preprocessed samples against a provided reference genome, utilizing a sample profile to guide the identification process.

The core pipeline begins by mapping reads to the reference genome using [minimap2](https://github.com/lh3/minimap2). Variant calling is then performed via [Clair3](https://github.com/HKU-BAL/Clair3), which generates pileup and full alignment VCF files. These results undergo normalization and quality filtering through [bcftools](https://samtools.github.io/bcftools/) and [SnpSift](https://pcingola.github.io/SnpEff/snpsift/introduction/) to ensure high-confidence allele detection.

In addition to variant calling, the workflow calculates comprehensive mapping statistics, including mean depth and coverage percentage per sample using Samtools. It concludes by generating consensus sequences and summary tables that report the number of variants identified across the sample collection.

This tool is part of the [IWC](https://github.com/galaxyproject/iwc) and [GTN](https://training.galaxyproject.org/) ecosystems, supporting FAIR data principles in pathogen genomics. It is released under the [MIT](https://opensource.org/licenses/MIT) license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | collection_of_preprocessed_samples | data_collection_input | Output collection from the Nanopore Preprocessing workflow |
| 1 | samples_profile | parameter_input | based on the lab preparation of the samples during sequencing, there should be a sample profile better than the other, to be chosen as an optional input to Minimap2. e.g. PacBio/Oxford Nanpore  For more details check: https://github.com/lh3/minimap2?tab=readme-ov-file#use-cases |
| 2 | reference_genome_of_tested_strain | data_input | Can be built in the tool later |


For optimal results, provide preprocessed sequencing reads in fastq.gz format organized as a paired or single-end data collection to streamline batch processing. Ensure the reference genome is in FASTA format and matches the specific strain expected in your samples for accurate variant calling with Clair3. You should also prepare a sample profile parameter to guide the identification logic across the cohort. For automated execution and parameter testing, consider using `planemo workflow_job_init` to generate a `job.yml` file. Please refer to the README.md for comprehensive details on specific tool configurations and data requirements.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Convert compressed file to uncompressed. | CONVERTER_gz_to_uncompressed |  |
| 4 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.24+galaxy0 |  |
| 5 | Clair3 | toolshed.g2.bx.psu.edu/repos/iuc/clair3/clair3/0.1.12+galaxy0 |  |
| 6 | Samtools depth | toolshed.g2.bx.psu.edu/repos/iuc/samtools_depth/samtools_depth/1.15.1+galaxy2 |  |
| 7 | Samtools coverage | toolshed.g2.bx.psu.edu/repos/iuc/samtools_coverage/samtools_coverage/1.15.1+galaxy2 |  |
| 8 | bcftools norm | toolshed.g2.bx.psu.edu/repos/iuc/bcftools_norm/bcftools_norm/1.9+galaxy1 |  |
| 9 | Advanced Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/9.3+galaxy1 |  |
| 10 | Remove beginning | Remove beginning1 |  |
| 11 | SnpSift Filter | toolshed.g2.bx.psu.edu/repos/iuc/snpsift/snpSift_filter/4.3+t.galaxy1 |  |
| 12 | Table Compute | toolshed.g2.bx.psu.edu/repos/iuc/table_compute/table_compute/1.2.4+galaxy0 |  |
| 13 | Cut | Cut1 |  |
| 14 | SnpSift Extract Fields | toolshed.g2.bx.psu.edu/repos/iuc/snpsift/snpSift_extractFields/4.3+t.galaxy0 |  |
| 15 | bcftools consensus | toolshed.g2.bx.psu.edu/repos/iuc/bcftools_consensus/bcftools_consensus/1.9+galaxy1 |  |
| 16 | Select first | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_head_tool/9.3+galaxy1 |  |
| 17 | Remove beginning | Remove beginning1 |  |
| 18 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 19 | Count | Count1 |  |
| 20 | Advanced Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/9.3+galaxy1 |  |
| 21 | Cut | Cut1 |  |
| 22 | Paste | Paste1 |  |
| 23 | Select first | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_head_tool/9.3+galaxy1 |  |
| 24 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 25 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | decompressed_rg_file | output1 |
| 4 | map_with_minimap2 | alignment_output |
| 5 | clair3_pileup_vcf | pileup |
| 5 | clair3_full_alignment_vcf | full_alignment |
| 5 | clair3_merged_output | merge_output |
| 8 | normalized_vcf_output | output_file |
| 11 | quality_filtered_vcf_output | output |
| 14 | extracted_fields_from_the_vcf_output | output |
| 15 | bcftools_consensus | output_file |
| 18 | mapping_coverage_percentage_per_sample | output |
| 22 | mapping_mean_depth_per_sample | out_file1 |
| 25 | number_of_variants_per_sample | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run allele-based-pathogen-identification.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run allele-based-pathogen-identification.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run allele-based-pathogen-identification.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init allele-based-pathogen-identification.ga -o job.yml`
- Lint: `planemo workflow_lint allele-based-pathogen-identification.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `allele-based-pathogen-identification.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)