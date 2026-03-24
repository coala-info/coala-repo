---
name: metagenomics-taxonomic-and-antibiotic-resistance-gene-arg-pr
description: "This workflow processes quality-filtered metagenomic short-read collections to perform taxonomic profiling and antibiotic resistance gene prediction using Sylph, Groot, deepARG, and argNorm. Use this skill when you need to characterize the microbial composition of environmental or clinical samples while identifying and standardizing the nomenclature of antibiotic resistance genes across different detection tools."
homepage: https://workflowhub.eu/workflows/2068
---

# Metagenomics Taxonomic and Antibiotic Resistance Gene (ARG) Profiling

## Overview

This workflow provides a comprehensive pipeline for the taxonomic and functional analysis of metagenomic short-read data. Starting from quality-controlled and host-filtered paired-end reads, it simultaneously performs taxonomic profiling and identifies Antibiotic Resistance Genes (ARGs) to characterize the microbial community and its resistance potential.

Taxonomic profiling is executed using [Sylph](https://github.com/bluenote-1577/sylph), which enables fast and accurate estimation of species abundance. For ARG detection, the workflow employs a dual approach: [Groot](https://github.com/synergy-au/groot) utilizes variation graphs for read mapping, while [deepARG](https://github.com/gaurav-sharma/deepARG) applies deep learning models to identify ARG-like sequences.

To ensure consistency across different detection tools, the workflow integrates [argNorm](https://github.com/BigDataBiology/argNorm) to normalize ARG annotations to the Antibiotic Resistance Ontology (ARO). Final results are aggregated using [ToolDistillator](https://github.com/iuc/tooldistillator) and [MultiQC](https://multiqc.info/), providing summarized reports and standardized outputs for downstream comparative analysis.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Metagenomics Reads after Quality Control and Host/Contamination Removal | data_collection_input | Metagenomics short-reads after quality control and host/contamination removal as a paired collection of fastqsanger(.gz) files |
| 1 | Taxonomy Profiling Database for Sylph | parameter_input | Sylph will profile the reads against this database. |
| 2 | ARG Database for Groot | parameter_input | Database that will be used by Groot to type Antibiotic Resistance Genes (ARGs) |
| 3 | Taxonomic Information Database for Sylph | parameter_input | Sylph profiling outputs do not have taxonomic information, only genome information. With this database, Sylph can turn standard output into a taxonomic profile. |
| 4 | Average Read Length for Groot | parameter_input | This sets the length of the sequence segments (in base pairs) used to create 'fingerprints' (MinHash sketches) of the ARG variation graphs. It should match the average length of the reads (e.g., 100 bp for short reads). Matching the window size to the read length ensures accurate and efficient alignment of reads to the ARG database during analysis. |
| 5 | Coverage Threshold for Groot to Report an ARG | parameter_input | Groot will report ARGs with a coverage higher than the defined value. For example, when 0.95 is set, Groot will report only ARGs where reads cover 95% of bases. |
| 6 | ARG Database used by Groot for ARGnorm | parameter_input | Database used by Groot that will be used by argNorm to normalize the ARG annotations to the ARO. It must be the same one set for Groot. |
| 7 | Minimum probability for considering a reads as ARG-like in deepARG | parameter_input | deepARG categorizes ARGs into two groups based on probability: detected ARGs (sequences with probability ≥ defined threshold) and potential ARGs (sequences with probability &lt; defined threshold). |
| 9 | ARG Database for DeepARG | parameter_input | Database that will be used by deepARG to predict Antibiotic Resistance Genes (ARGs) |


Ensure your input metagenomics short reads are provided as a paired collection of fastqsanger or fastqsanger.gz files that have already undergone quality control and host removal. You must supply specific database parameters for Sylph, Groot, and DeepARG to ensure accurate taxonomic and ARG profiling. Using a paired collection is essential for the internal concatenation and flattening steps required by the ARG prediction tools. For automated execution, you can initialize your environment using `planemo workflow_job_init` to generate a `job.yml` template. Please refer to the README.md for comprehensive details on database versions and specific parameter thresholds.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 8 | Create text file | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_text_file_with_recurring_lines/9.5+galaxy2 | This step generates a fallback file in case Groot fails. |
| 10 | Unzip collection | __UNZIP_COLLECTION__ |  |
| 11 | Extract element identifiers | toolshed.g2.bx.psu.edu/repos/iuc/collection_element_identifiers/collection_element_identifiers/0.0.2 |  |
| 12 | sylph profile | toolshed.g2.bx.psu.edu/repos/bgruening/sylph_profile/sylph_profile/0.8.1+galaxy0 |  |
| 13 | DeepARG short reads | toolshed.g2.bx.psu.edu/repos/iuc/deeparg_short_reads/deeparg_short_reads/1.0.4+galaxy1 |  |
| 14 | Concatenate datasets | cat1 | Concatenate files R1 and R2 together to enable analysis with Groot |
| 15 | Flatten collection | __FLATTEN__ | Remove a collection level so that outputs can be taken into account by tooldistillator |
| 16 | argNorm | toolshed.g2.bx.psu.edu/repos/iuc/argnorm/argnorm/1.0.0+galaxy0 |  |
| 17 | Groot | toolshed.g2.bx.psu.edu/repos/iuc/groot/groot/1.1.2+galaxy2 |  |
| 18 | Remove beginning | Remove beginning1 | Removal of the first line because it is not necessary for tooldistillator |
| 19 | Relabel identifiers | __RELABEL_FROM_FILE__ |  |
| 20 | Remove beginning | Remove beginning1 | Removal of the first argNorm line that causes a multiQC error |
| 21 | argNorm | toolshed.g2.bx.psu.edu/repos/iuc/argnorm/argnorm/1.0.0+galaxy0 |  |
| 22 | table rename column | toolshed.g2.bx.psu.edu/repos/recetox/table_pandas_rename_column/table_pandas_rename_column/2.2.3+galaxy1 | Rename #ARG column in ARG because it causes multiQC error |
| 23 | Filter failed datasets | __FILTER_FAILED_DATASETS__ |  |
| 24 | Remove beginning | Remove beginning1 | Removal of the first argNorm line that causes a multiQC error |
| 25 | ToolDistillator | toolshed.g2.bx.psu.edu/repos/iuc/tooldistillator/tooldistillator/1.0.4+galaxy0 |  |
| 26 | table rename column | toolshed.g2.bx.psu.edu/repos/recetox/table_pandas_rename_column/table_pandas_rename_column/2.2.3+galaxy1 | Rename Groot columns because there is no information on initial output |
| 27 | ToolDistillator Summarize | toolshed.g2.bx.psu.edu/repos/iuc/tooldistillator_summarize/tooldistillator_summarize/1.0.4+galaxy0 |  |
| 28 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.33+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 12 | Sylph sylphmpa Files | sylphmpa_files |
| 12 | Sylph Taxonomy Profiling | output_sylph_prof |
| 12 | Sylph Merge Taxonomy | sylph_merge_tax_out |
| 13 | DeepARG Mapping ARG (>min probability) | output_mapping_ARG |
| 13 | DeepARG Mapping Potential ARG (<min probability) | output_mapping_potential_ARG |
| 13 | DeepARG ARG Subtype | output_subtype_ARG |
| 13 | DeepARG ARG Type | output_type_ARG |
| 13 | DeepARG Merged ARG | output_merged_ARG |
| 13 | DeepARG All Hits | output_all_hits |
| 14 | Paired end Concatenated | out_file1 |
| 15 | output | output |
| 16 | argNorm DeepARG Report | output |
| 17 | Groot Report | report_out |
| 23 | argNorm Groot Report | output |
| 25 | Tooldistillator Results | output_json |
| 27 | Tooldistillator Summarize | summary_json |
| 28 | MultiQC report | html_report |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run metagenomic-raw-reads-amr-analysis.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run metagenomic-raw-reads-amr-analysis.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run metagenomic-raw-reads-amr-analysis.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init metagenomic-raw-reads-amr-analysis.ga -o job.yml`
- Lint: `planemo workflow_lint metagenomic-raw-reads-amr-analysis.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `metagenomic-raw-reads-amr-analysis.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
