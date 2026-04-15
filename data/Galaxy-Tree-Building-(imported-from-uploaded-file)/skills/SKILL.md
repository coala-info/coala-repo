---
name: tree-building-imported-from-uploaded-file
description: This Galaxy workflow performs phylogenetic tree construction from FASTA sequence files using MAFFT for multiple sequence alignment and both FastTree and IQ-TREE for tree inference. Use this skill when you need to reconstruct evolutionary relationships between biological sequences and compare results from different maximum-likelihood tree estimation algorithms.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# tree-building-imported-from-uploaded-file

## Overview

This workflow provides a streamlined pipeline for fundamental phylogenetic analysis, specifically designed to support the "Phylogenetics - Back to basics" tutorial from the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/). It enables researchers to transition from raw sequence data to reconstructed evolutionary trees using industry-standard bioinformatics tools.

The process begins with an input FASTA sequence file, which is processed by [MAFFT](https://toolshed.g2.bx.psu.edu/repos/rnateam/mafft/rbc_mafft/7.508+galaxy1) to create a multiple sequence alignment. This alignment serves as the essential foundation for the subsequent tree-building steps, ensuring that homologous positions are correctly compared.

For tree inference, the workflow employs two complementary methods: [FastTree](https://toolshed.g2.bx.psu.edu/repos/iuc/fasttree/fasttree/2.1.10+galaxy1) for rapid approximately-maximum-likelihood reconstructions and [IQ-TREE](https://toolshed.g2.bx.psu.edu/repos/iuc/iqtree/iqtree/2.1.2+galaxy2) for highly accurate maximum likelihood analysis. The final outputs include the sequence alignment and the resulting tree files from both algorithms, allowing for comparative evolutionary studies under an MIT license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input FASTA Sequence File | data_input | This should be a fasta formatted file with multiple sequences. |


Ensure your input is a high-quality FASTA file containing the nucleotide or protein sequences you wish to align and analyze. While the workflow is configured for a single dataset, you may utilize dataset collections to scale the analysis across multiple sequence sets simultaneously. You can streamline the execution process by using `planemo workflow_job_init` to generate a `job.yml` file for your specific inputs. For comprehensive details on parameter settings and data preparation requirements, please consult the README.md file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | MAFFT | toolshed.g2.bx.psu.edu/repos/rnateam/mafft/rbc_mafft/7.508+galaxy1 |  |
| 2 | FASTTREE | toolshed.g2.bx.psu.edu/repos/iuc/fasttree/fasttree/2.1.10+galaxy1 |  |
| 3 | IQ-TREE | toolshed.g2.bx.psu.edu/repos/iuc/iqtree/iqtree/2.1.2+galaxy2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | outputAlignment | outputAlignment |
| 2 | output | output |
| 3 | treefile | treefile |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run tree-building.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run tree-building.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run tree-building.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init tree-building.ga -o job.yml`
- Lint: `planemo workflow_lint tree-building.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `tree-building.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)