---
name: apollo-load-test
description: "This workflow integrates FASTA scaffolds, GFF3 annotations, BigWig coverage, and BAM alignments into a JBrowse instance for collaborative refinement using Apollo. Use this skill when you need to manually curate automated gene predictions or resolve structural annotation errors in a prokaryotic genome using evidence-based visual inspection."
homepage: https://workflowhub.eu/workflows/749
---

# Apollo Load Test

## Overview

This workflow is designed for refining genome annotations using the Apollo platform, specifically tailored for prokaryotic data. It integrates several key genomic data types, including scaffold sequences in FASTA format, existing gene models in GFF3, and evidence tracks such as BAM alignments and BigWig signal files sourced from [Zenodo](https://zenodo.org/record/3270822).

The pipeline begins by managing user accounts and organism lists within the Apollo environment. It then leverages [JBrowse](https://toolshed.g2.bx.psu.edu/repos/iuc/jbrowse/jbrowse/1.16.11+galaxy1) to generate a visual interface for the genomic data. This visualization is integrated into Apollo, allowing for the creation or updating of organism records and providing an interactive iframe for manual curation.

By streamlining the connection between Galaxy and Apollo, the workflow enables researchers to perform high-quality manual curation of automated gene predictions. The final outputs include the registered organism data and the interactive annotation environment, facilitating collaborative genome improvement and precise [genome-annotation](https://galaxyproject.org/use/apollo/) refinement.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | https://zenodo.org/record/3270822/files/Amel_4.5_scaffolds.fa.gz?download=1 | data_input |  |
| 1 | https://zenodo.org/record/3270822/files/amel_OGSv3.2.gff3.gz?download=1 | data_input |  |
| 2 | https://zenodo.org/record/3270822/files/forager.bw | data_input |  |
| 3 | https://zenodo.org/record/3270822/files/forager_Amel4.5_accepted_hits.bam | data_input |  |


Ensure your input files are correctly formatted as FASTA for the reference genome, GFF3 for existing annotations, and BAM or BigWig for evidence tracks to ensure compatibility with JBrowse and Apollo. When handling multiple samples, organize them into collections to streamline the workflow execution across the integrated tool suite. Refer to the `README.md` for comprehensive details on account registration and organism management within the Apollo environment. You can use `planemo workflow_job_init` to generate a `job.yml` for automated testing and parameter configuration. Always verify that your GFF3 attributes conform to Apollo’s requirements to prevent synchronization errors during the organism update step.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | Register Account | toolshed.g2.bx.psu.edu/repos/gga/apollo_create_account/create_account/3.1 |  |
| 5 | List Organisms | toolshed.g2.bx.psu.edu/repos/gga/apollo_list_organism/list_organism/3.1 |  |
| 6 | JBrowse | toolshed.g2.bx.psu.edu/repos/iuc/jbrowse/jbrowse/1.16.11+galaxy1 |  |
| 7 | Create or Update Organism | toolshed.g2.bx.psu.edu/repos/gga/apollo_create_or_update/create_or_update/4.2.5 |  |
| 8 | Annotate | toolshed.g2.bx.psu.edu/repos/gga/apollo_iframe/iframe/4.2.5 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | output | output |
| 5 | output | output |
| 6 | output | output |
| 7 | output | output |
| 8 | output | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Refining Genome Annotations with Apollo (prokaryotes).ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Refining Genome Annotations with Apollo (prokaryotes).ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Refining Genome Annotations with Apollo (prokaryotes).ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Refining Genome Annotations with Apollo (prokaryotes).ga -o job.yml`
- Lint: `planemo workflow_lint Refining Genome Annotations with Apollo (prokaryotes).ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Refining Genome Annotations with Apollo (prokaryotes).ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
