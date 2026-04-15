---
name: preparing-genomic-data-for-phylogeny-recostruction-gtn
description: This workflow processes a collection of genome assemblies through annotation with Funannotate and BUSCO, ortholog identification via ProteinOrtho, and alignment using ClustalW and ClipKIT to generate a concatenated matrix with PhyKit. Use this skill when you need to prepare high-quality phylogenomic datasets from raw assemblies by identifying conserved orthologous groups and constructing trimmed sequence alignments for downstream tree reconstruction.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# preparing-genomic-data-for-phylogeny-recostruction-gtn

## Overview

This workflow automates the preparation of genomic data for phylogenetic analysis, starting from a collection of genome assemblies from different samples, strains, or species. It begins with initial data cleaning and repeat masking via [RepeatMasker](https://toolshed.g2.bx.psu.edu/repos/bgruening/repeat_masker/repeatmasker_wrapper/4.1.2-p1+galaxy0), followed by structural annotation using [Funannotate](https://toolshed.g2.bx.psu.edu/repos/iuc/funannotate_predict/funannotate_predict/1.8.9+galaxy2) to predict proteins and [BUSCO](https://toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/4.1.4) to assess annotation completeness.

To identify evolutionary relationships, the workflow employs [ProteinOrtho](https://toolshed.g2.bx.psu.edu/repos/iuc/proteinortho/proteinortho/6.0.14+galaxy2.9.1) to detect orthologous groups across the input proteomes. It specifically filters for "core" orthogroups where every sample is represented, ensuring that the resulting dataset is suitable for multi-gene phylogenetic reconstruction.

In the final stages, orthologs are aligned using [ClustalW](https://toolshed.g2.bx.psu.edu/repos/devteam/clustalw/clustalw/2.1) and refined with [ClipKIT](https://toolshed.g2.bx.psu.edu/repos/padge/clipkit/clipkit/0.1.0) to trim uninformative sites. [PhyKit](https://toolshed.g2.bx.psu.edu/repos/padge/phykit/phykit_alignment_based/0.1.0) is then used to build a concatenation matrix and generate partition files. These outputs are ready for downstream tree inference using tools like RAxML or IQ-TREE. This pipeline is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) and follows [GTN](https://training.galaxyproject.org/) best practices for ecology and genomics.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input genomes as collection | data_collection_input |  |


Ensure your input genome assemblies are uploaded as a single list collection in FASTA format to facilitate batch processing through the annotation and orthology steps. Using a collection is essential for ProteinOrtho to correctly identify orthogroups across all samples simultaneously while maintaining sample metadata. Verify that your FASTA headers are concise and unique to avoid formatting errors during the final concatenation and alignment phases. For a comprehensive guide on data formatting and specific tool parameters, refer to the accompanying README.md file. You can also use `planemo workflow_job_init` to generate a `job.yml` file for streamlined execution and reproducible job configuration.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_line/1.1.2 |  |
| 2 | RepeatMasker | toolshed.g2.bx.psu.edu/repos/bgruening/repeat_masker/repeatmasker_wrapper/4.1.2-p1+galaxy0 |  |
| 3 | Funannotate predict annotation | toolshed.g2.bx.psu.edu/repos/iuc/funannotate_predict/funannotate_predict/1.8.9+galaxy2 |  |
| 4 | Extract ORF | toolshed.g2.bx.psu.edu/repos/bgruening/glimmer_gbk_to_orf/glimmer_gbk_to_orf/3.02 |  |
| 5 | Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regex1/1.0.1 |  |
| 6 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/4.2 |  |
| 7 | Proteinortho | toolshed.g2.bx.psu.edu/repos/iuc/proteinortho/proteinortho/6.0.14+galaxy2.9.1 |  |
| 8 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/4.1.4 |  |
| 9 | Filter | Filter1 |  |
| 10 | Proteinortho grab proteins | toolshed.g2.bx.psu.edu/repos/iuc/proteinortho_grab_proteins/proteinortho_grab_proteins/6.0.14+galaxy2.9.1 |  |
| 11 | Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regex1/1.0.1 |  |
| 12 | ClustalW | toolshed.g2.bx.psu.edu/repos/devteam/clustalw/clustalw/2.1 |  |
| 13 | ClipKIT. Alignment trimming software for phylogenetics. | toolshed.g2.bx.psu.edu/repos/padge/clipkit/clipkit/0.1.0 |  |
| 14 | PhyKit - Alignment-based functions | toolshed.g2.bx.psu.edu/repos/padge/phykit/phykit_alignment_based/0.1.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | headers_shortened | outfile |
| 2 | repeat_masked | output_masked_genome |
| 3 | funannotate_predicted_proteins | annot_gbk |
| 4 | extracted_ORFs | aa_output |
| 4 | nc_output | nc_output |
| 5 | sample_names_to_headers | out_file1 |
| 6 | proteomes_to_one_file | output |
| 7 | proteinorthograph | proteinorthograph |
| 7 | Proteinortho on input dataset(s): orthology-groups | proteinortho |
| 7 | blastgraph | blastgraph |
| 8 | busco_sum | busco_sum |
| 8 | busco_missing | busco_missing |
| 8 | busco_table | busco_table |
| 9 | out_file1 | out_file1 |
| 10 | Proteinortho_extract_by_orthogroup | listproteinorthograbproteins |
| 11 | fasta_header_cleaned | out_file1 |
| 12 | ClustalW on input dataset(s): clustal | output |
| 13 | Trimmed alignment. | trimmed_output |
| 14 | Concatenated fasta alignment file | fasta |
| 14 | A partition file ready for input into RAxML or IQ-tree | partition |
| 14 | An occupancy file that summarizes the taxon occupancy per sequence | occupancy |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run main-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run main-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run main-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init main-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint main-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `main-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)