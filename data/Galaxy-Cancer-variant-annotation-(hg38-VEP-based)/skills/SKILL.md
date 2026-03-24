---
name: cancer-variant-annotation-hg38-vep-based
description: "This workflow performs comprehensive cancer variant annotation on hg38 genomic data using Ensembl VEP, vcfanno, and SnpSift to integrate clinical evidence from databases like CIViC and CGI. Use this skill when you need to identify pathogenic somatic mutations, assess loss of heterozygosity, or prioritize clinically actionable variants and biomarkers in cancer research datasets."
homepage: https://workflowhub.eu/workflows/607
---

# Cancer variant annotation (hg38 VEP-based)

## Overview

This Galaxy workflow provides a comprehensive pipeline for the functional annotation and prioritization of cancer variants using the hg38 reference genome. It integrates [Ensembl VEP](https://www.ensembl.org/info/docs/tools/vep/index.html) to predict variant effects and utilizes `vcfanno` to incorporate diverse biological contexts from external datasets. The workflow is designed to handle both somatic and germline variants, with a specific parameter to toggle germline reporting.

The pipeline processes input variants through a series of sophisticated filtering and transformation steps using `SnpSift`, `bcftools`, and various text-processing utilities. It cross-references variants against multiple high-value cancer databases, including [CIViC](https://civicdb.org), [Cancer Genome Interpreter (CGI)](https://www.cancergenomeinterpreter.org), and UniProt cancer gene lists. These integrations allow the workflow to identify known hotspots, actionable biomarkers, and clinically relevant mutations.

The final outputs are highly structured, providing both raw annotated VCFs and refined tabular reports. Key deliverables include a Mutation Annotation Format (MAF) report, somatic and loss-of-heterozygosity (LOH) reports, and gene-specific summaries. This workflow is tagged under **EOSC4Cancer** and is released under the **MIT** license, making it a robust tool for standardized cancer genomics research.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Variants to be annotated | data_input |  |
| 1 | Annotations data | data_collection_input |  |
| 3 | Report germline variants? | parameter_input |  |


Ensure your input variants are in VCF format and the annotation data is provided as a data collection to facilitate the multi-step enrichment process. The workflow relies on specific hg38 reference coordinates, so verify that all input datasets use the same genomic assembly to avoid tool failures during VEP or vcfanno steps. For automated execution and environment setup, you can use `planemo workflow_job_init` to generate a `job.yml` template. Detailed configuration for the germline reporting parameters and specific database versions can be found in the README.md file. One should always consult the README.md for comprehensive instructions on preparing the complex annotation collection required for this pipeline.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Create text file | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_text_file_with_recurring_lines/1.1.0 |  |
| 4 | Create text file | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_text_file_with_recurring_lines/1.1.0 |  |
| 5 | Predict variant effects | toolshed.g2.bx.psu.edu/repos/iuc/ensembl_vep/ensembl_vep/106.1+galaxy1 |  |
| 6 | Extract dataset | __EXTRACT_DATASET__ |  |
| 7 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/1.1.3 |  |
| 8 | Build list | __BUILD_LIST__ |  |
| 9 | Cut | Cut1 |  |
| 10 | Cut | Cut1 |  |
| 11 | Relabel identifiers | __RELABEL_FROM_FILE__ |  |
| 12 | Add line to file | toolshed.g2.bx.psu.edu/repos/bgruening/add_line_to_file/add_line_to_file/0.1.0 |  |
| 13 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/1.1.3 |  |
| 14 | Sort collection | __SORTLIST__ |  |
| 15 | Extract dataset | __EXTRACT_DATASET__ |  |
| 16 | Extract dataset | __EXTRACT_DATASET__ |  |
| 17 | Extract dataset | __EXTRACT_DATASET__ |  |
| 18 | Extract dataset | __EXTRACT_DATASET__ |  |
| 19 | Extract dataset | __EXTRACT_DATASET__ |  |
| 20 | Extract dataset | __EXTRACT_DATASET__ |  |
| 21 | Extract dataset | __EXTRACT_DATASET__ |  |
| 22 | vcfanno | toolshed.g2.bx.psu.edu/repos/iuc/vcfanno/vcfanno/0.3.3+galaxy0 |  |
| 23 | bcftools split-vep | toolshed.g2.bx.psu.edu/repos/iuc/bcftools_plugin_split_vep/bcftools_plugin_split_vep/1.15.1+galaxy2 |  |
| 24 | SnpSift Filter | toolshed.g2.bx.psu.edu/repos/iuc/snpsift/snpSift_filter/4.3+t.galaxy1 |  |
| 25 | SnpSift Filter | toolshed.g2.bx.psu.edu/repos/iuc/snpsift/snpSift_filter/4.3+t.galaxy1 |  |
| 26 | SnpSift Filter | toolshed.g2.bx.psu.edu/repos/iuc/snpsift/snpSift_filter/4.3+t.galaxy1 |  |
| 27 | Build list | __BUILD_LIST__ |  |
| 28 | Relabel identifiers | __RELABEL_FROM_FILE__ |  |
| 29 | Convert VCF to MAF | toolshed.g2.bx.psu.edu/repos/iuc/vcf2maf/vcf2maf/1.6.21+galaxy1 |  |
| 30 | Filter collection | __FILTER_FROM_FILE__ |  |
| 31 | Extract dataset | __EXTRACT_DATASET__ |  |
| 32 | Extract dataset | __EXTRACT_DATASET__ |  |
| 33 | Extract dataset | __EXTRACT_DATASET__ |  |
| 34 | SnpSift Extract Fields | toolshed.g2.bx.psu.edu/repos/iuc/snpsift/snpSift_extractFields/4.3+t.galaxy0 |  |
| 35 | SnpSift Extract Fields | toolshed.g2.bx.psu.edu/repos/iuc/snpsift/snpSift_extractFields/4.3+t.galaxy0 |  |
| 36 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_column/1.1.3 |  |
| 37 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_column/1.1.3 |  |
| 38 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_column/1.1.3 |  |
| 39 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/1.1.3 |  |
| 40 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/1.1.3 |  |
| 41 | Build list | __BUILD_LIST__ |  |
| 42 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0+galaxy2 |  |
| 43 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/2.0 |  |
| 44 | Relabel identifiers | __RELABEL_FROM_FILE__ |  |
| 45 | Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/1.1.2 |  |
| 46 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_column/1.1.3 |  |
| 47 | Filter collection | __FILTER_FROM_FILE__ |  |
| 48 | Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/1.1.2 |  |
| 49 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/1.1.3 |  |
| 50 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 51 | Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/1.1.2 |  |
| 52 | Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/1.1.2 |  |
| 53 | Column arrange | toolshed.g2.bx.psu.edu/repos/bgruening/column_arrange_by_header/bg_column_arrange_by_header/0.2 |  |
| 54 | Column arrange | toolshed.g2.bx.psu.edu/repos/bgruening/column_arrange_by_header/bg_column_arrange_by_header/0.2 |  |
| 55 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/2.0 |  |
| 56 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0 |  |
| 57 | Add line to file | toolshed.g2.bx.psu.edu/repos/bgruening/add_line_to_file/add_line_to_file/0.1.0 |  |
| 58 | Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/1.1.2 |  |
| 59 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_column/1.1.3 |  |
| 60 | Split file | toolshed.g2.bx.psu.edu/repos/bgruening/split_file_to_collection/split_file_to_collection/0.5.0 |  |
| 61 | Filter | Filter1 |  |
| 62 | Column arrange | toolshed.g2.bx.psu.edu/repos/bgruening/column_arrange_by_header/bg_column_arrange_by_header/0.2 |  |
| 63 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/4.2 |  |
| 64 | Transpose | toolshed.g2.bx.psu.edu/repos/iuc/datamash_transpose/datamash_transpose/1.1.0 |  |
| 65 | Column arrange | toolshed.g2.bx.psu.edu/repos/bgruening/column_arrange_by_header/bg_column_arrange_by_header/0.2 |  |
| 66 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/1.1.3 |  |
| 67 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/1.1.3 |  |
| 68 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/1.1.3 |  |
| 69 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/1.1.3 |  |
| 70 | Extract dataset | __EXTRACT_DATASET__ |  |
| 71 | Extract dataset | __EXTRACT_DATASET__ |  |
| 72 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/4.2 |  |
| 73 | Merge collections | __MERGE_COLLECTION__ |  |
| 74 | Merge collections | __MERGE_COLLECTION__ |  |
| 75 | Extract dataset | __EXTRACT_DATASET__ |  |
| 76 | Extract dataset | __EXTRACT_DATASET__ |  |
| 77 | Extract dataset | __EXTRACT_DATASET__ |  |
| 78 | Extract dataset | __EXTRACT_DATASET__ |  |
| 79 | Extract dataset | __EXTRACT_DATASET__ |  |
| 80 | Extract dataset | __EXTRACT_DATASET__ |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 13 | annotation_metadata | outfile |
| 15 | dbsnp_vcf | output |
| 16 | cancer_hotspots | output |
| 17 | civic_variants | output |
| 18 | cgi_biomarkers | output |
| 19 | uniprot_cancer_genes | output |
| 20 | cgi_genes | output |
| 21 | civic_genes | output |
| 22 | final_variants | out_vcf |
| 50 | maf_report | output |
| 53 | variant_reports_tabular | output |
| 54 | gene_reports_tabular | output |
| 67 | mutations_summary | outfile |
| 70 | somatic_report | output |
| 71 | loh_report | output |
| 75 | somatic_cancer_report | output |
| 76 | loh_cancer_report | output |
| 77 | germline_cancer_report | output |
| 78 | gene_cards_somatic | output |
| 79 | gene_cards_loh | output |
| 80 | gene_cards_germline | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Cancer_variant_annotation_(hg38_VEP-based).ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Cancer_variant_annotation_(hg38_VEP-based).ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Cancer_variant_annotation_(hg38_VEP-based).ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Cancer_variant_annotation_(hg38_VEP-based).ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Cancer_variant_annotation_(hg38_VEP-based).ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Cancer_variant_annotation_(hg38_VEP-based).ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
