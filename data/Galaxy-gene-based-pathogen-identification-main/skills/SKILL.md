---
name: gene-based-pathogen-identification
description: "This workflow processes preprocessed Nanopore sequencing collections to perform genome assembly and polishing using Flye and Medaka, followed by gene-based screening with ABRicate and Bandage. Use this skill when you need to identify pathogenic organisms in genomic samples by detecting virulence factors and antimicrobial resistance genes while generating high-quality consensus contigs."
homepage: https://workflowhub.eu/workflows/1062
---

# Gene-based Pathogen Identification

## Overview

This workflow provides a comprehensive pipeline for the phylogenetic identification and characterization of pathogens from Nanopore sequencing data. It is designed to process collections of preprocessed reads to determine pathogenicity by identifying specific genetic markers, specifically focusing on Virulence Factors (VFs) and Antimicrobial Resistance (AMR) genes.

The analysis begins with genome assembly using [Flye](https://github.com/fenderglass/Flye) to generate contigs, followed by assembly polishing via the [medaka consensus pipeline](https://github.com/nanoporetech/medaka). To assess the quality and structure of the assembly, the workflow generates assembly graph visualizations using [Bandage](https://rrwick.github.io/Bandage/).

Once the assemblies are refined, the workflow utilizes [ABRicate](https://github.com/tseemann/abricate) to screen the contigs against specialized databases, including VFDB for virulence factors and NCBI for AMR gene detection. The final outputs include FASTA and tabular reports that facilitate the tracking and visualization of pathogenic traits across all processed samples.

This workflow is part of the [microGalaxy](https://microgalaxy.eu/) initiative and is featured in a detailed [GTN tutorial](https://training.galaxyproject.org/training-material/topics/microbiome/tutorials/pathogen-detection-from-nanopore-foodborne-data/tutorial.html) for foodborne pathogen detection. It is released under the MIT license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | collection_of_preprocessed_samples | data_collection_input | Output collection from the Nanopore Preprocessing workflow |


To prepare your data, ensure your Nanopore reads are organized into a Galaxy data collection containing files in `fastqsanger` or `fastqsanger.gz` format, ideally sourced from the Nanopore Preprocessing workflow. Using a collection is essential as the workflow leverages element identifiers to track sample names through assembly with Flye and polishing with Medaka. For comprehensive details on parameter settings and data preparation, refer to the README.md or the associated GTN tutorial. You can also use `planemo workflow_job_init` to generate a `job.yml` file for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Extract element identifiers | toolshed.g2.bx.psu.edu/repos/iuc/collection_element_identifiers/collection_element_identifiers/0.0.2 |  |
| 2 | Build list | __BUILD_LIST__ |  |
| 3 | Split file | toolshed.g2.bx.psu.edu/repos/bgruening/split_file_to_collection/split_file_to_collection/0.5.0 |  |
| 4 | Flye | toolshed.g2.bx.psu.edu/repos/bgruening/flye/flye/2.9.1+galaxy0 |  |
| 5 | Parse parameter value | param_value_from_file |  |
| 6 | medaka consensus pipeline | toolshed.g2.bx.psu.edu/repos/iuc/medaka_consensus_pipeline/medaka_consensus_pipeline/1.7.2+galaxy0 |  |
| 7 | Bandage Image | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/2022.09+galaxy4 |  |
| 8 | Compose text parameter value | toolshed.g2.bx.psu.edu/repos/iuc/compose_text_param/compose_text_param/0.1.1 |  |
| 9 | FASTA-to-Tabular | toolshed.g2.bx.psu.edu/repos/devteam/fasta_to_tabular/fasta2tab/1.1.1 |  |
| 10 | ABRicate | toolshed.g2.bx.psu.edu/repos/iuc/abricate/abricate/1.0.1 |  |
| 11 | ABRicate | toolshed.g2.bx.psu.edu/repos/iuc/abricate/abricate/1.0.1 |  |
| 12 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/1.1.4 |  |
| 13 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/1.1.4 |  |
| 14 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/1.1.4 |  |
| 15 | Tabular-to-FASTA | toolshed.g2.bx.psu.edu/repos/devteam/tabular_to_fasta/tab2fasta/1.1.1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | extracted_samples_IDs | output |
| 2 | list_of_lists_of_preprocessed_samples | output |
| 3 | splitted_extracted_samples_IDs | list_output_txt |
| 4 | flye_consensus_fasta | consensus |
| 4 | flye_assembly_graph | assembly_graph |
| 4 | flye_assembly_gfa | assembly_gfa |
| 4 | flye_assembly_info_tabular | assembly_info |
| 5 | parsed_extracted_samples_IDs_to_text | text_param |
| 6 | medaka_gaps_in_draft_bed_file | out_gaps |
| 6 | medaka_log_file | out_log |
| 6 | medaka_propability_h5_file | out_probs |
| 6 | medaka_calls_of_draft_bam_file | out_calls |
| 6 | sample_all_contigs | out_consensus |
| 7 | bandage_assembly_graph_image | outfile |
| 9 | sample_specific_contigs_tabular_file_preparation | output |
| 10 | abricate_with_vfdb_to_identify_genes_with_VFs | report |
| 11 | abricate_report_using_ncbi_database_to_indentify_amr | report |
| 12 | sample_specific_contigs_tabular_file | outfile |
| 13 | vfs | outfile |
| 14 | amrs | outfile |
| 15 | contigs | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Gene-based-Pathogen-Identification.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Gene-based-Pathogen-Identification.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Gene-based-Pathogen-Identification.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Gene-based-Pathogen-Identification.ga -o job.yml`
- Lint: `planemo workflow_lint Gene-based-Pathogen-Identification.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Gene-based-Pathogen-Identification.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
