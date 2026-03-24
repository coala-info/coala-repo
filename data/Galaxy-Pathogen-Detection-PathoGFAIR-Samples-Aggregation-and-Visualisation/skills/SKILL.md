---
name: pathogen-detection-pathogfair-samples-aggregation-and-visual
description: "This workflow aggregates pathogen detection results from multiple samples, including antimicrobial resistance (AMR) genes and virulence factors (VF), using tools like bedtools, ClustalW, and FastTree to generate comparative visualizations. Use this skill when you need to synthesize multi-sample pathogenomic data into comprehensive reports, heatmaps, and phylogenetic trees to analyze the distribution and evolutionary relationships of resistance and virulence markers across a cohort."
homepage: https://workflowhub.eu/workflows/1487
---

# Pathogen Detection PathoGFAIR Samples Aggregation and Visualisation

## Overview

This workflow provides a comprehensive pipeline for aggregating and visualizing pathogen detection results across multiple samples. It integrates data from antimicrobial resistance (AMR) and virulence factor (VF) identification tools with sample metadata, mapping statistics, and assembly contigs. The primary goal is to transform individual sample outputs into comparative reports and high-level visualizations suitable for pathogen surveillance and genomic epidemiology.

The process begins by filtering failed or empty datasets and generating descriptive bar charts for quality control metrics, including host read removal percentages, mapping depth, coverage, and variant/SNP counts. It then aggregates genomic data—such as contigs and identified genes—into unified formats, using text processing and regex tools to normalize identifiers and prepare data for downstream comparative analysis.

Advanced analysis steps include the generation of gene distribution heatmaps using [ggplot2](https://ggplot2.tidyverse.org/) and the construction of phylogenetic trees. The workflow utilizes [ClustalW](http://www.clustal.org/clustal2/) for multiple sequence alignment and [FastTree](http://www.microbesonline.org/fasttree/) to infer evolutionary relationships based on AMR and VF profiles. These results are rendered as Newick tree graphs and PDF/PNG heatmaps for easy interpretation.

For detailed setup instructions and execution parameters, please refer to the [README.md](README.md) in the Files section. This workflow is licensed under the MIT license and is associated with the [microgalaxy](https://usegalaxy.eu/) and [IWC](https://github.com/galaxyproject/iwc) communities.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | amr_identified_by_ncbi | data_collection_input | output_of_abricate_with_amrfinderncbi |
| 1 | vfs_of_genes_identified_by_vfdb | data_collection_input | output_of_abricate_with_vfdb |
| 2 | metadata | data_input | samples_metadata |
| 3 | removed_hosts_percentage_tabular | data_input | removed_hosts_percentage_tabular |
| 4 | mapping_mean_depth_per_sample | data_input | mapping_mean_depth_per_sample |
| 5 | amrs | data_collection_input | amrs |
| 6 | mapping_coverage_percentage_per_sample | data_input | mapping_coverage_percentage_per_sample |
| 7 | number_of_variants_per_sample | data_input | number_of_variants_per_sample |
| 8 | contigs | data_collection_input | Contigs |
| 9 | vfs | data_collection_input | VFs |


This workflow requires a combination of tabular datasets and data collections containing FASTA sequences and screening results (AMR and VFDB). Ensure that input collections for contigs, AMRs, and virulence factors are properly paired and labeled to facilitate accurate sample aggregation and phylogenetic analysis. Key file types include tabular reports for mapping depth, coverage, and host removal percentages, alongside metadata files for group-based splitting. For complex configurations or automated execution, you can use `planemo workflow_job_init` to generate a `job.yml` file. Please refer to the README.md for comprehensive details on parameter settings and data preparation requirements.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 10 | Filter failed datasets | __FILTER_FAILED_DATASETS__ |  |
| 11 | Filter failed datasets | __FILTER_FAILED_DATASETS__ |  |
| 12 | Bar chart | barchart_gnuplot |  |
| 13 | Bar chart | barchart_gnuplot |  |
| 14 | Bar chart | barchart_gnuplot |  |
| 15 | Filter failed datasets | __FILTER_FAILED_DATASETS__ |  |
| 16 | Bar chart | barchart_gnuplot |  |
| 17 | Bar chart | barchart_gnuplot |  |
| 18 | Filter failed datasets | __FILTER_FAILED_DATASETS__ |  |
| 19 | Filter failed datasets | __FILTER_FAILED_DATASETS__ |  |
| 20 | Remove beginning | Remove beginning1 |  |
| 21 | Remove beginning | Remove beginning1 |  |
| 22 | Remove beginning | Remove beginning1 |  |
| 23 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 24 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 25 | Remove beginning | Remove beginning1 |  |
| 26 | Count | Count1 |  |
| 27 | Count | Count1 |  |
| 28 | Group | Grouping1 |  |
| 29 | Unique | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sorted_uniq/9.3+galaxy1 |  |
| 30 | Split by group | toolshed.g2.bx.psu.edu/repos/bgruening/split_file_on_column/tp_split_on_column/0.6 |  |
| 31 | Unique | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sorted_uniq/9.3+galaxy1 |  |
| 32 | Cut | Cut1 |  |
| 33 | Cut | Cut1 |  |
| 34 | Filter empty datasets | __FILTER_EMPTY_DATASETS__ |  |
| 35 | Cut | Cut1 |  |
| 36 | Cut | Cut1 |  |
| 37 | Cut | Cut1 |  |
| 38 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 39 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 40 | Column join | toolshed.g2.bx.psu.edu/repos/iuc/collection_column_join/collection_column_join/0.0.3 |  |
| 41 | bedtools getfasta | toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_getfastabed/2.30.0+galaxy1 |  |
| 42 | Remove beginning | Remove beginning1 |  |
| 43 | bedtools getfasta | toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_getfastabed/2.30.0+galaxy1 |  |
| 44 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3 |  |
| 45 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3 |  |
| 46 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3 |  |
| 47 | Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regex1/1.0.3 |  |
| 48 | bedtools getfasta | toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_getfastabed/2.30.0+galaxy1 |  |
| 49 | Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regex1/1.0.3 |  |
| 50 | Multi-Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_multijoin_tool/9.3+galaxy1 |  |
| 51 | Heatmap w ggplot | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_heatmap/ggplot2_heatmap/3.4.0+galaxy0 |  |
| 52 | Filter empty datasets | __FILTER_EMPTY_DATASETS__ |  |
| 53 | ClustalW | toolshed.g2.bx.psu.edu/repos/devteam/clustalw/clustalw/2.1+galaxy1 |  |
| 54 | Filter empty datasets | __FILTER_EMPTY_DATASETS__ |  |
| 55 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_column/9.3+galaxy1 |  |
| 56 | FASTA-to-Tabular | toolshed.g2.bx.psu.edu/repos/devteam/fasta_to_tabular/fasta2tab/1.1.1 |  |
| 57 | Filter empty datasets | __FILTER_EMPTY_DATASETS__ |  |
| 58 | FASTA-to-Tabular | toolshed.g2.bx.psu.edu/repos/devteam/fasta_to_tabular/fasta2tab/1.1.1 |  |
| 59 | Cut | Cut1 |  |
| 60 | FASTTREE | toolshed.g2.bx.psu.edu/repos/iuc/fasttree/fasttree/2.1.10+galaxy1 |  |
| 61 | Cut | Cut1 |  |
| 62 | Group | Grouping1 |  |
| 63 | Newick Display | toolshed.g2.bx.psu.edu/repos/iuc/newick_utils/newick_display/1.6+galaxy1 |  |
| 64 | Group | Grouping1 |  |
| 65 | Tabular-to-FASTA | toolshed.g2.bx.psu.edu/repos/devteam/tabular_to_fasta/tab2fasta/1.1.1 |  |
| 66 | Tabular-to-FASTA | toolshed.g2.bx.psu.edu/repos/devteam/tabular_to_fasta/tab2fasta/1.1.1 |  |
| 67 | FASTA Merge Files and Filter Unique Sequences | toolshed.g2.bx.psu.edu/repos/galaxyp/fasta_merge_files_and_filter_unique_sequences/fasta_merge_files_and_filter_unique_sequences/1.2.0 |  |
| 68 | FASTA Merge Files and Filter Unique Sequences | toolshed.g2.bx.psu.edu/repos/galaxyp/fasta_merge_files_and_filter_unique_sequences/fasta_merge_files_and_filter_unique_sequences/1.2.0 |  |
| 69 | ClustalW | toolshed.g2.bx.psu.edu/repos/devteam/clustalw/clustalw/2.1+galaxy1 |  |
| 70 | ClustalW | toolshed.g2.bx.psu.edu/repos/devteam/clustalw/clustalw/2.1+galaxy1 |  |
| 71 | FASTTREE | toolshed.g2.bx.psu.edu/repos/iuc/fasttree/fasttree/2.1.10+galaxy1 |  |
| 72 | FASTTREE | toolshed.g2.bx.psu.edu/repos/iuc/fasttree/fasttree/2.1.10+galaxy1 |  |
| 73 | Newick Display | toolshed.g2.bx.psu.edu/repos/iuc/newick_utils/newick_display/1.6+galaxy1 |  |
| 74 | Newick Display | toolshed.g2.bx.psu.edu/repos/iuc/newick_utils/newick_display/1.6+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 12 | number_of_reads_before_host_removal_and_number_of_host_reads_found_per_sample_fig | out_file1 |
| 13 | removed_host_percentage_fig | out_file1 |
| 14 | mapping_mean_depth_per_sample_fig | out_file1 |
| 16 | mapping_coverage_percentage_per_sample_fig | out_file1 |
| 17 | number_of_Variants_and_SNPs_indentified_fig | out_file1 |
| 23 | all_samples_contigs_in_one_fasta_file | output |
| 24 | all_vfs_in_one_tabular | output |
| 30 | split_by_group_collection | split_output |
| 36 | adjusted_abricate_vfs_tabular_part1 | out_file1 |
| 42 | adjusted_abricate_vfs_tabular_part2 | out_file1 |
| 44 | amrs_count | out_file1 |
| 45 | vfs_count | out_file1 |
| 46 | heatmap_table | out_file1 |
| 48 | filtered_sequences_with_vfs_fasta | output |
| 51 | heatmap_png | output1 |
| 51 | heatmap_pdf | output2 |
| 53 | clustalw_on_input_clustal | output |
| 53 | clustalw_on_input_dnd | dnd |
| 55 | vfs_amrs_count_table | outfile |
| 57 | filtered_empty_datasets | output |
| 60 | fasttree_nhx | output |
| 63 | newick_genes_tree_graphs_collection | output |
| 73 | all_samples_phylogenetic_tree_based_amrs | output |
| 74 | all_samples_phylogenetic_tree_based_vfs | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run pathogen-detection-pathogfair-samples-aggrtion-and-visualisation.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run pathogen-detection-pathogfair-samples-aggrtion-and-visualisation.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run pathogen-detection-pathogfair-samples-aggrtion-and-visualisation.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init pathogen-detection-pathogfair-samples-aggrtion-and-visualisation.ga -o job.yml`
- Lint: `planemo workflow_lint pathogen-detection-pathogfair-samples-aggrtion-and-visualisation.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `pathogen-detection-pathogfair-samples-aggrtion-and-visualisation.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
