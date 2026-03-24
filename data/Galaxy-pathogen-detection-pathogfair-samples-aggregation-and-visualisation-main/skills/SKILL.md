---
name: pathogen-detection-pathogfair-samples-aggregation-and-visual
description: "This workflow aggregates pathogen identification results, antimicrobial resistance data, and virulence factors from multiple samples using tools like bedtools, ClustalW, FastTree, and ggplot2 to generate comparative visualizations. Use this skill when you need to track pathogen transmission across foodborne or environmental samples by analyzing gene presence-absence heatmaps and phylogenetic relationships between detected virulence factors and resistance markers."
homepage: https://workflowhub.eu/workflows/1060
---

# Pathogen Detection PathoGFAIR Samples Aggregation and Visualisation

## Overview

This workflow aggregates and visualizes results from multiple upstream analysis pipelines, including Nanopore preprocessing and both gene-based and allele-based pathogen identification. It is designed to track pathogens across multiple samples by synthesizing data on antimicrobial resistance (AMR), virulence factors (VF), and quality control metrics into comprehensive reports.

The pipeline performs extensive data cleaning and transformation, utilizing tools like `Abricate`, `bedtools`, and `ClustalW` to process contigs and identified genes. Key analytical steps include generating presence-absence heatmaps with `ggplot2` to visualize the distribution of virulence genes across the sample set and performing multi-sample joins to compare AMR and VF counts.

To support phylogenetic tracking, the workflow constructs gene-specific trees and sample-wide phylogenetic trees based on AMR and VF profiles using `FastTree` and `Newick Display`. These visualizations allow researchers to identify common pathogenic signatures and trace potential contamination events across different sampling times and locations.

This workflow is part of the [microGalaxy](https://microgalaxy.usegalaxy.eu/) initiative and is featured in the [GTN tutorial](https://training.galaxyproject.org/training-material/topics/microbiome/tutorials/pathogen-detection-from-nanopore-foodborne-data/tutorial.html) for foodborne pathogen detection. It is released under the [MIT license](https://opensource.org/licenses/MIT).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | amr_identified_by_ncbi | data_collection_input | output_of_abricate_with_amrfinderncbi |
| 1 | vfs_of_genes_identified_by_vfdb | data_collection_input | output_of_abricate_with_vfdb |
| 2 | amrs | data_collection_input | amrs |
| 3 | contigs | data_collection_input | Contigs |
| 4 | vfs | data_collection_input | VFs |
| 5 | removed_hosts_percentage_tabular | data_input | removed_hosts_percentage_tabular |
| 6 | mapping_mean_depth_per_sample | data_input | mapping_mean_depth_per_sample |
| 7 | mapping_coverage_percentage_per_sample | data_input | mapping_coverage_percentage_per_sample |
| 8 | number_of_variants_per_sample | data_input | number_of_variants_per_sample |
| 9 | metadata | data_input | samples_metadata |


This workflow requires a mix of individual tabular datasets for QC metrics and data collections for gene identification results and contigs. Ensure that AMR and virulence factor (VF) results are provided as collections, while host removal and mapping statistics should be uploaded as single tabular files. For comprehensive guidance on preparing these inputs from previous workflow stages, refer to the README.md. You can streamline the configuration of these multiple inputs by using `planemo workflow_job_init` to generate a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 10 | Filter failed datasets | __FILTER_FAILED_DATASETS__ |  |
| 11 | Filter failed datasets | __FILTER_FAILED_DATASETS__ |  |
| 12 | Filter failed datasets | __FILTER_FAILED_DATASETS__ |  |
| 13 | Filter failed datasets | __FILTER_FAILED_DATASETS__ |  |
| 14 | Filter failed datasets | __FILTER_FAILED_DATASETS__ |  |
| 15 | Remove beginning | Remove beginning1 |  |
| 16 | Remove beginning | Remove beginning1 |  |
| 17 | Remove beginning | Remove beginning1 |  |
| 18 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 19 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 20 | Remove beginning | Remove beginning1 |  |
| 21 | Count | Count1 |  |
| 22 | Count | Count1 |  |
| 23 | Group | Grouping1 |  |
| 24 | Unique | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sorted_uniq/9.3+galaxy1 |  |
| 25 | Split by group | toolshed.g2.bx.psu.edu/repos/bgruening/split_file_on_column/tp_split_on_column/0.6 |  |
| 26 | Unique | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sorted_uniq/9.3+galaxy1 |  |
| 27 | Cut | Cut1 |  |
| 28 | Cut | Cut1 |  |
| 29 | Filter empty datasets | __FILTER_EMPTY_DATASETS__ |  |
| 30 | Cut | Cut1 |  |
| 31 | Cut | Cut1 |  |
| 32 | Cut | Cut1 |  |
| 33 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 34 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 35 | Column join | toolshed.g2.bx.psu.edu/repos/iuc/collection_column_join/collection_column_join/0.0.3 |  |
| 36 | bedtools getfasta | toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_getfastabed/2.30.0+galaxy1 |  |
| 37 | Remove beginning | Remove beginning1 |  |
| 38 | bedtools getfasta | toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_getfastabed/2.30.0+galaxy1 |  |
| 39 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3 |  |
| 40 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3 |  |
| 41 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3 |  |
| 42 | Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regex1/1.0.3 |  |
| 43 | bedtools getfasta | toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_getfastabed/2.30.0+galaxy1 |  |
| 44 | Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regex1/1.0.3 |  |
| 45 | Multi-Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_multijoin_tool/9.3+galaxy1 |  |
| 46 | Heatmap w ggplot | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_heatmap/ggplot2_heatmap/3.4.0+galaxy0 |  |
| 47 | Filter empty datasets | __FILTER_EMPTY_DATASETS__ |  |
| 48 | ClustalW | toolshed.g2.bx.psu.edu/repos/devteam/clustalw/clustalw/2.1+galaxy1 |  |
| 49 | Filter empty datasets | __FILTER_EMPTY_DATASETS__ |  |
| 50 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_column/9.3+galaxy1 |  |
| 51 | FASTA-to-Tabular | toolshed.g2.bx.psu.edu/repos/devteam/fasta_to_tabular/fasta2tab/1.1.1 |  |
| 52 | Filter empty datasets | __FILTER_EMPTY_DATASETS__ |  |
| 53 | FASTA-to-Tabular | toolshed.g2.bx.psu.edu/repos/devteam/fasta_to_tabular/fasta2tab/1.1.1 |  |
| 54 | Cut | Cut1 |  |
| 55 | FASTTREE | toolshed.g2.bx.psu.edu/repos/iuc/fasttree/fasttree/2.1.10+galaxy1 |  |
| 56 | Cut | Cut1 |  |
| 57 | Group | Grouping1 |  |
| 58 | Newick Display | toolshed.g2.bx.psu.edu/repos/iuc/newick_utils/newick_display/1.6+galaxy1 |  |
| 59 | Group | Grouping1 |  |
| 60 | Tabular-to-FASTA | toolshed.g2.bx.psu.edu/repos/devteam/tabular_to_fasta/tab2fasta/1.1.1 |  |
| 61 | Tabular-to-FASTA | toolshed.g2.bx.psu.edu/repos/devteam/tabular_to_fasta/tab2fasta/1.1.1 |  |
| 62 | FASTA Merge Files and Filter Unique Sequences | toolshed.g2.bx.psu.edu/repos/galaxyp/fasta_merge_files_and_filter_unique_sequences/fasta_merge_files_and_filter_unique_sequences/1.2.0 |  |
| 63 | FASTA Merge Files and Filter Unique Sequences | toolshed.g2.bx.psu.edu/repos/galaxyp/fasta_merge_files_and_filter_unique_sequences/fasta_merge_files_and_filter_unique_sequences/1.2.0 |  |
| 64 | ClustalW | toolshed.g2.bx.psu.edu/repos/devteam/clustalw/clustalw/2.1+galaxy1 |  |
| 65 | ClustalW | toolshed.g2.bx.psu.edu/repos/devteam/clustalw/clustalw/2.1+galaxy1 |  |
| 66 | FASTTREE | toolshed.g2.bx.psu.edu/repos/iuc/fasttree/fasttree/2.1.10+galaxy1 |  |
| 67 | FASTTREE | toolshed.g2.bx.psu.edu/repos/iuc/fasttree/fasttree/2.1.10+galaxy1 |  |
| 68 | Newick Display | toolshed.g2.bx.psu.edu/repos/iuc/newick_utils/newick_display/1.6+galaxy1 |  |
| 69 | Newick Display | toolshed.g2.bx.psu.edu/repos/iuc/newick_utils/newick_display/1.6+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 18 | all_samples_contigs_in_one_fasta_file | output |
| 19 | all_vfs_in_one_tabular | output |
| 25 | split_by_group_collection | split_output |
| 31 | adjusted_abricate_vfs_tabular_part1 | out_file1 |
| 37 | adjusted_abricate_vfs_tabular_part2 | out_file1 |
| 39 | amrs_count | out_file1 |
| 40 | vfs_count | out_file1 |
| 41 | heatmap_table | out_file1 |
| 43 | filtered_sequences_with_vfs_fasta | output |
| 46 | heatmap_png | output1 |
| 46 | heatmap_pdf | output2 |
| 48 | clustalw_on_input_dnd | dnd |
| 48 | clustalw_on_input_clustal | output |
| 50 | vfs_amrs_count_table | outfile |
| 52 | filtered_empty_datasets | output |
| 55 | fasttree_nhx | output |
| 58 | newick_genes_tree_graphs_collection | output |
| 68 | all_samples_phylogenetic_tree_based_amrs | output |
| 69 | all_samples_phylogenetic_tree_based_vfs | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Pathogen-Detection-PathoGFAIR-Samples-Aggregation-and-Visualisation.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Pathogen-Detection-PathoGFAIR-Samples-Aggregation-and-Visualisation.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Pathogen-Detection-PathoGFAIR-Samples-Aggregation-and-Visualisation.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Pathogen-Detection-PathoGFAIR-Samples-Aggregation-and-Visualisation.ga -o job.yml`
- Lint: `planemo workflow_lint Pathogen-Detection-PathoGFAIR-Samples-Aggregation-and-Visualisation.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Pathogen-Detection-PathoGFAIR-Samples-Aggregation-and-Visualisation.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
