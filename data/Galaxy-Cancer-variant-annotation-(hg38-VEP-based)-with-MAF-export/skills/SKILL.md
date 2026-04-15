---
name: cancer-variant-annotation-hg38-vep-based-with-maf-export
description: This Galaxy workflow annotates human cancer variants using Ensembl VEP, vcfanno, and SnpSift before exporting results in MAF and tabular formats. Use this skill when you need to predict the functional impact of somatic or germline mutations in hg38 genomic data and generate standardized reports for cancer gene analysis.
homepage: https://usegalaxy.eu
metadata:
  docker_image: "N/A"
---

# cancer-variant-annotation-hg38-vep-based-with-maf-export

## Overview

This Galaxy workflow provides a comprehensive pipeline for the functional annotation of cancer variants using the hg38 reference genome. It integrates [Ensembl VEP](https://toolshed.g2.bx.psu.edu/repos/iuc/ensembl_vep/ensembl_vep/106.1+galaxy1) and [vcfanno](https://toolshed.g2.bx.psu.edu/repos/iuc/vcfanno/vcfanno/0.3.3+galaxy0) to predict variant effects and incorporate custom genomic annotations. The process is designed to handle somatic and germline variants, utilizing sample metadata and study identifiers to contextualize the results.

The pipeline performs extensive data processing and filtering using [SnpSift](https://toolshed.g2.bx.psu.edu/repos/iuc/snpsift/snpSift_filter/4.3+t.galaxy1) and [bcftools](https://toolshed.g2.bx.psu.edu/repos/iuc/bcftools_plugin_split_vep/bcftools_plugin_split_vep/1.15.1+galaxy2) to isolate high-impact mutations and relevant cancer genes. It cross-references variants against established databases such as UniProt, CGI, and CIViC. A key feature of this workflow is the conversion of VCF data into the Mutation Annotation Format (MAF) using [vcf2maf](https://toolshed.g2.bx.psu.edu/repos/iuc/vcf2maf/vcf2maf/1.6.21+galaxy1), facilitating downstream bioinformatic analysis and visualization.

The final outputs include detailed tabular reports for variants and genes, somatic and germline mutation summaries, and Loss of Heterozygosity (LOH) reports. These results are organized into structured collections and can be automatically exported to a specified remote directory. This workflow is tagged under **EOSC4Cancer** and is licensed under **GPL-3.0-or-later**.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Variants to be annotated | data_input |  |
| 1 | Annotations data | data_collection_input |  |
| 2 | Sample metadata | data_input |  |
| 4 | Report germline variants? | parameter_input |  |
| 5 | Export folder | parameter_input |  |
| 6 | Study ID | parameter_input |  |


To ensure successful execution, provide input variants in VCF format and sample metadata as a tabular file, while the required annotation data must be supplied as a data collection. Ensure that the study ID and export folder parameters are correctly defined to facilitate the automated MAF export and reporting steps. For comprehensive guidance on formatting metadata and configuring VEP parameters, refer to the README.md file. You can use `planemo workflow_job_init` to generate a `job.yml` file for streamlined execution and reproducibility. One should verify that all reference genome versions (hg38) match across the input datasets and the VEP tool configuration.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Create text file | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_text_file_with_recurring_lines/1.1.0 |  |
| 7 | Create text file | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_text_file_with_recurring_lines/1.1.0 |  |
| 8 | Predict variant effects | toolshed.g2.bx.psu.edu/repos/iuc/ensembl_vep/ensembl_vep/106.1+galaxy1 |  |
| 9 | Extract dataset | __EXTRACT_DATASET__ |  |
| 10 | Select last | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_tail_tool/1.1.0 |  |
| 11 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/1.1.3 |  |
| 12 | Build list | __BUILD_LIST__ |  |
| 13 | Cut | Cut1 |  |
| 14 | Cut | Cut1 |  |
| 15 | Cut | Cut1 |  |
| 16 | Cut | Cut1 |  |
| 17 | Relabel identifiers | __RELABEL_FROM_FILE__ |  |
| 18 | Add line to file | toolshed.g2.bx.psu.edu/repos/bgruening/add_line_to_file/add_line_to_file/0.1.0 |  |
| 19 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/1.1.3 |  |
| 20 | Parse parameter value | param_value_from_file |  |
| 21 | Parse parameter value | param_value_from_file |  |
| 22 | Sort collection | __SORTLIST__ |  |
| 23 | Compose text parameter value | toolshed.g2.bx.psu.edu/repos/iuc/compose_text_param/compose_text_param/0.1.1 |  |
| 24 | Extract dataset | __EXTRACT_DATASET__ |  |
| 25 | Extract dataset | __EXTRACT_DATASET__ |  |
| 26 | Extract dataset | __EXTRACT_DATASET__ |  |
| 27 | Extract dataset | __EXTRACT_DATASET__ |  |
| 28 | Extract dataset | __EXTRACT_DATASET__ |  |
| 29 | Extract dataset | __EXTRACT_DATASET__ |  |
| 30 | Extract dataset | __EXTRACT_DATASET__ |  |
| 31 | vcfanno | toolshed.g2.bx.psu.edu/repos/iuc/vcfanno/vcfanno/0.3.3+galaxy0 |  |
| 32 | bcftools split-vep | toolshed.g2.bx.psu.edu/repos/iuc/bcftools_plugin_split_vep/bcftools_plugin_split_vep/1.15.1+galaxy2 |  |
| 33 | SnpSift Filter | toolshed.g2.bx.psu.edu/repos/iuc/snpsift/snpSift_filter/4.3+t.galaxy1 |  |
| 34 | SnpSift Filter | toolshed.g2.bx.psu.edu/repos/iuc/snpsift/snpSift_filter/4.3+t.galaxy1 |  |
| 35 | SnpSift Filter | toolshed.g2.bx.psu.edu/repos/iuc/snpsift/snpSift_filter/4.3+t.galaxy1 |  |
| 36 | Build list | __BUILD_LIST__ |  |
| 37 | Relabel identifiers | __RELABEL_FROM_FILE__ |  |
| 38 | Convert VCF to MAF | toolshed.g2.bx.psu.edu/repos/iuc/vcf2maf/vcf2maf/1.6.21+galaxy1 |  |
| 39 | Filter collection | __FILTER_FROM_FILE__ |  |
| 40 | Extract dataset | __EXTRACT_DATASET__ |  |
| 41 | Extract dataset | __EXTRACT_DATASET__ |  |
| 42 | Extract dataset | __EXTRACT_DATASET__ |  |
| 43 | SnpSift Extract Fields | toolshed.g2.bx.psu.edu/repos/iuc/snpsift/snpSift_extractFields/4.3+t.galaxy0 |  |
| 44 | SnpSift Extract Fields | toolshed.g2.bx.psu.edu/repos/iuc/snpsift/snpSift_extractFields/4.3+t.galaxy0 |  |
| 45 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_column/1.1.3 |  |
| 46 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_column/1.1.3 |  |
| 47 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_column/1.1.3 |  |
| 48 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/1.1.3 |  |
| 49 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/1.1.3 |  |
| 50 | Build list | __BUILD_LIST__ |  |
| 51 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0+galaxy2 |  |
| 52 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/2.0 |  |
| 53 | Relabel identifiers | __RELABEL_FROM_FILE__ |  |
| 54 | Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/1.1.2 |  |
| 55 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_column/1.1.3 |  |
| 56 | Filter collection | __FILTER_FROM_FILE__ |  |
| 57 | Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/1.1.2 |  |
| 58 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/1.1.3 |  |
| 59 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 60 | Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/1.1.2 |  |
| 61 | Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/1.1.2 |  |
| 62 | Column arrange | toolshed.g2.bx.psu.edu/repos/bgruening/column_arrange_by_header/bg_column_arrange_by_header/0.2 |  |
| 63 | Export datasets | export_remote |  |
| 64 | Column arrange | toolshed.g2.bx.psu.edu/repos/bgruening/column_arrange_by_header/bg_column_arrange_by_header/0.2 |  |
| 65 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/2.0 |  |
| 66 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0 |  |
| 67 | Add line to file | toolshed.g2.bx.psu.edu/repos/bgruening/add_line_to_file/add_line_to_file/0.1.0 |  |
| 68 | Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/1.1.2 |  |
| 69 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_column/1.1.3 |  |
| 70 | Split file | toolshed.g2.bx.psu.edu/repos/bgruening/split_file_to_collection/split_file_to_collection/0.5.0 |  |
| 71 | Filter | Filter1 |  |
| 72 | Column arrange | toolshed.g2.bx.psu.edu/repos/bgruening/column_arrange_by_header/bg_column_arrange_by_header/0.2 |  |
| 73 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/4.2 |  |
| 74 | Transpose | toolshed.g2.bx.psu.edu/repos/iuc/datamash_transpose/datamash_transpose/1.1.0 |  |
| 75 | Column arrange | toolshed.g2.bx.psu.edu/repos/bgruening/column_arrange_by_header/bg_column_arrange_by_header/0.2 |  |
| 76 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/1.1.3 |  |
| 77 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/1.1.3 |  |
| 78 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/1.1.3 |  |
| 79 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/1.1.3 |  |
| 80 | Extract dataset | __EXTRACT_DATASET__ |  |
| 81 | Extract dataset | __EXTRACT_DATASET__ |  |
| 82 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/4.2 |  |
| 83 | Merge collections | __MERGE_COLLECTION__ |  |
| 84 | Merge collections | __MERGE_COLLECTION__ |  |
| 85 | Extract dataset | __EXTRACT_DATASET__ |  |
| 86 | Extract dataset | __EXTRACT_DATASET__ |  |
| 87 | Extract dataset | __EXTRACT_DATASET__ |  |
| 88 | Extract dataset | __EXTRACT_DATASET__ |  |
| 89 | Extract dataset | __EXTRACT_DATASET__ |  |
| 90 | Extract dataset | __EXTRACT_DATASET__ |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 19 | annotation_metadata | outfile |
| 28 | uniprot_cancer_genes | output |
| 29 | cgi_genes | output |
| 30 | civic_genes | output |
| 31 | final_variants | out_vcf |
| 59 | maf_report | output |
| 62 | variant_reports_tabular | output |
| 64 | gene_reports_tabular | output |
| 77 | mutations_summary | outfile |
| 80 | somatic_report | output |
| 81 | loh_report | output |
| 85 | somatic_cancer_report | output |
| 86 | loh_cancer_report | output |
| 87 | germline_cancer_report | output |
| 88 | gene_cards_somatic | output |
| 89 | gene_cards_loh | output |
| 90 | gene_cards_germline | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Cancer_variant_annotation_(hg38_VEP-based)_with_MAF_export.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Cancer_variant_annotation_(hg38_VEP-based)_with_MAF_export.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Cancer_variant_annotation_(hg38_VEP-based)_with_MAF_export.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Cancer_variant_annotation_(hg38_VEP-based)_with_MAF_export.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Cancer_variant_annotation_(hg38_VEP-based)_with_MAF_export.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Cancer_variant_annotation_(hg38_VEP-based)_with_MAF_export.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)