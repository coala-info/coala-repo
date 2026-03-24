---
name: identification-and-evolutionary-analysis-of-transcription-as
description: "This Galaxy workflow identifies and analyzes the evolution of transcription-associated proteins from protein sequence collections using TAPScan, MAFFT, and Quicktree. Use this skill when you need to classify transcription factors and regulators within a proteome and reconstruct their phylogenetic history to study evolutionary conservation or divergence."
homepage: https://workflowhub.eu/workflows/1650
---

# Identification and Evolutionary Analysis of Transcription-Associated Proteins

## Overview

This workflow automates the identification and phylogenetic analysis of Transcription-Associated Proteins (TAPs) from protein sequence datasets. It begins by utilizing [TAPScan Classify](https://toolshed.g2.bx.psu.edu/repos/bgruening/tapscan/tapscan_classify/4.76+galaxy0) to categorize input sequences into specific TAP families based on established domain profiles.

Following classification, the workflow performs a series of filtering and text-processing steps to isolate high-quality sequences of interest. These sequences are then aligned using [MAFFT](https://toolshed.g2.bx.psu.edu/repos/rnateam/mafft/rbc_mafft/7.526+galaxy1) and refined with [trimAl](https://toolshed.g2.bx.psu.edu/repos/iuc/trimal/trimal/1.5.0+galaxy1) to remove poorly aligned regions, ensuring a robust dataset for evolutionary inference.

In the final stage, the workflow constructs a phylogenetic tree using [Quicktree](https://toolshed.g2.bx.psu.edu/repos/iuc/quicktree/quicktree/2.5+galaxy0). The resulting evolutionary relationships are rendered through the [ETE tree viewer](https://toolshed.g2.bx.psu.edu/repos/iuc/ete_treeviewer/ete_treeviewer/3.1.3+galaxy0), providing a comprehensive visual representation of the protein family's divergence. This pipeline is particularly useful for comparative genomics and is tagged for [Sequence-analysis](https://training.galaxyproject.org/) under the MIT license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input Dataset Collection | data_collection_input |  |


Ensure your input dataset collection contains protein sequences in FASTA format, as the workflow is optimized to process multiple proteomes in a single batch. Using a collection rather than individual datasets is necessary to maintain the association between sequences and their respective source organisms throughout the TAPScan and phylogenetic analysis. For comprehensive instructions on data formatting and specific tool parameters, consult the `README.md` file. You may also use `planemo workflow_job_init` to create a `job.yml` for streamlined execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | TAPScan Classify | toolshed.g2.bx.psu.edu/repos/bgruening/tapscan/tapscan_classify/4.76+galaxy0 |  |
| 2 | Filter | Filter1 |  |
| 3 | Cut | Cut1 |  |
| 4 | Remove beginning | Remove beginning1 |  |
| 5 | Filter FASTA | toolshed.g2.bx.psu.edu/repos/galaxyp/filter_by_fasta_ids/filter_by_fasta_ids/2.3 |  |
| 6 | MAFFT | toolshed.g2.bx.psu.edu/repos/rnateam/mafft/rbc_mafft/7.526+galaxy1 |  |
| 7 | trimAl | toolshed.g2.bx.psu.edu/repos/iuc/trimal/trimal/1.5.0+galaxy1 |  |
| 8 | Quicktree | toolshed.g2.bx.psu.edu/repos/iuc/quicktree/quicktree/2.5+galaxy0 |  |
| 9 | ETE tree viewer | toolshed.g2.bx.psu.edu/repos/iuc/ete_treeviewer/ete_treeviewer/3.1.3+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

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
