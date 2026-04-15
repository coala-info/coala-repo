---
name: ml-phylogenetic-reconstruction
description: This Galaxy workflow performs maximum likelihood phylogenetic reconstruction from input alignment collections using ClipKIT for trimming, PhyKit for concatenation, and IQ-TREE and ASTRAL-III for tree estimation. Use this skill when you need to infer evolutionary relationships from genome-wide or single-gene data while accounting for sequence quality and species tree estimation from multiple gene trees.
homepage: https://usegalaxy.be/workflows/list_published
metadata:
  docker_image: "N/A"
---

# ml-phylogenetic-reconstruction

## Overview

This workflow performs Maximum Likelihood (ML) phylogenetic reconstruction using genome-wide and single-gene alignment data. It is designed to process an input alignment collection through a series of trimming, processing, and estimation steps to produce high-quality evolutionary trees.

The pipeline begins by utilizing [ClipKIT](https://toolshed.g2.bx.psu.edu/repos/padge/clipkit/clipkit/0.1.0) for alignment trimming and [PhyKit](https://toolshed.g2.bx.psu.edu/repos/padge/phykit/phykit_alignment_based/0.1.0) to handle alignment-based functions. PhyKit generates essential intermediate files, including concatenated FASTA alignments, taxon occupancy summaries, and partition files formatted for downstream analysis in RAxML or IQ-TREE.

Core phylogenetic reconstruction is conducted using [IQ-TREE](https://toolshed.g2.bx.psu.edu/repos/iuc/iqtree/iqtree/1.5.5.3), which generates consensus trees, maximum likelihood trees, and distance matrices. To account for gene tree discordance, the workflow also incorporates [ASTRAL-III](https://toolshed.g2.bx.psu.edu/repos/padge/astral/astral/0.1.0) to estimate unrooted species trees from sets of gene trees.

The final outputs include a comprehensive suite of phylogenetic data, such as BIONJ trees, bootstrap occurrence frequencies, and detailed reports. This workflow is shared under a [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input alignment collection | data_collection_input |  |


Ensure your input alignment collection contains FASTA or PHYLIP files, as these formats are required for processing by IQ-TREE and ClipKIT. Utilizing a data collection is necessary to efficiently handle multiple gene alignments for the subsequent concatenation and species tree estimation steps. Refer to the `README.md` for comprehensive details on data formatting and specific parameter configurations. You may also use `planemo workflow_job_init` to create a `job.yml` file for streamlined job submission.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | IQ-TREE | toolshed.g2.bx.psu.edu/repos/iuc/iqtree/iqtree/1.5.5.3 |  |
| 2 | ClipKIT. Alignment trimming software for phylogenetics. | toolshed.g2.bx.psu.edu/repos/padge/clipkit/clipkit/0.1.0 |  |
| 3 | ASTRAL-III. Tool for estimating an unrooted species tree given a set of unrooted gene trees. | toolshed.g2.bx.psu.edu/repos/padge/astral/astral/0.1.0 |  |
| 4 | PhyKit - Alignment-based functions | toolshed.g2.bx.psu.edu/repos/padge/phykit/phykit_alignment_based/0.1.0 |  |
| 5 | IQ-TREE | toolshed.g2.bx.psu.edu/repos/iuc/iqtree/iqtree/1.5.5.3 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | bionj | bionj |
| 1 | iqtree | iqtree |
| 1 | splits.nex | splits.nex |
| 1 | mldist | mldist |
| 1 | contree | contree |
| 1 | treefile | treefile |
| 2 | Trimmed alignment. | trimmed_output |
| 3 | Output tree file | output |
| 3 | Astral log. | log_output |
| 4 | An occupancy file that summarizes the taxon occupancy per sequence | occupancy |
| 4 | Concatenated fasta alignment file | fasta |
| 4 | A partition file ready for input into RAxML or IQ-tree | partition |
| 5 | IQ-TREE on input dataset(s): BIONJ Tree | bionj |
| 5 | IQ-TREE on input dataset(s): MaxLikelihood Tree | treefile |
| 5 | IQ-TREE on input dataset(s): Consensus Tree | contree |
| 5 | IQ-TREE on input dataset(s): MaxLikelihood Distance Matrix | mldist |
| 5 | IQ-TREE on input dataset(s): Report and Final Tree | iqtree |
| 5 | IQ-TREE on input dataset(s): Occurence Frequencies in Bootstrap Trees | splits.nex |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-ML_phylogenetic_reconstruction.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-ML_phylogenetic_reconstruction.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-ML_phylogenetic_reconstruction.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-ML_phylogenetic_reconstruction.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-ML_phylogenetic_reconstruction.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-ML_phylogenetic_reconstruction.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)