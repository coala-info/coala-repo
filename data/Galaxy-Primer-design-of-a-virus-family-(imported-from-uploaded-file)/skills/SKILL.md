---
name: primer-design-of-a-virus-family-imported-from-uploaded-file
description: "This workflow performs multiple sequence alignment on viral gene sequences using MAFFT and designs optimized primers with varVAMP. Use this skill when you need to develop diagnostic primers or amplification assays that target conserved regions across a diverse family of related virus sequences."
homepage: https://workflowhub.eu/workflows/1627
---

# Primer design of a virus family (imported from uploaded file)

## Overview

This workflow automates the design of primers for a specific virus family or group of related gene sequences. It is designed to identify conserved regions across multiple viral genomes to ensure broad-spectrum detection or amplification. The process begins with a set of input virus gene sequences provided by the user.

The pipeline first utilizes [MAFFT](https://toolshed.g2.bx.psu.edu/repos/rnateam/mafft/rbc_mafft/7.526+galaxy1) to perform a multiple sequence alignment, which identifies homologous regions and sequence variations across the input set. Following alignment, the [varVAMP](https://toolshed.g2.bx.psu.edu/repos/iuc/varvamp/varvamp/1.2.2+galaxy0) tool is employed to design primers that are optimized for the target virus family, accounting for the diversity captured in the alignment.

The workflow produces several key outputs, including the multiple sequence alignment, a detailed varVAMP log, and the final primer sequences. Additionally, the primers are provided in BED format for easy integration into genome browsers or downstream bioinformatics pipelines.

This resource is tagged for [sequenceanalysis](https://training.galaxyproject.org/training-material/topics/sequence-analysis/) and is associated with the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/). It is released under the AGPL-3.0-or-later license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input virus gene sequences | data_input | Dataset consists of different virus gene sequences. |


Ensure your input virus gene sequences are in FASTA format and represent a single family or closely related group to facilitate accurate multiple sequence alignment via MAFFT. If you are analyzing multiple distinct viral groups, organizing your inputs into a dataset collection will allow the workflow to process each group independently. Consult the `README.md` for specific guidance on configuring varVAMP parameters for different genomic regions. You can quickly prepare your execution environment by using `planemo workflow_job_init` to create a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | MAFFT | toolshed.g2.bx.psu.edu/repos/rnateam/mafft/rbc_mafft/7.526+galaxy1 | Multiple alignment of various virus genomes of dataset input |
| 2 | varVAMP | toolshed.g2.bx.psu.edu/repos/iuc/varvamp/varvamp/1.2.2+galaxy0 | Design of primer with multiple alignment from MAFFT. |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | outputAlignment | outputAlignment |
| 2 | varvamp_log | varvamp_log |
| 2 | primers_bed | primers_bed |
| 2 | primer_seqs | primer_seqs |


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
