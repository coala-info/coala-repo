---
name: dada2-amplicon-analysis-pipeline-for-paired-end-data
description: "This Galaxy workflow processes paired-end FASTQ amplicon sequences using the DADA2 suite to perform quality filtering, error modeling, sequence merging, and taxonomic assignment. Use this skill when you need to resolve high-resolution amplicon sequence variants from microbial community samples and characterize their taxonomic diversity using a reference database."
homepage: https://workflowhub.eu/workflows/790
---

# dada2 amplicon analysis pipeline - for paired end data

## Overview

This Galaxy workflow implements the [dada2 tutorial](https://benjjneb.github.io/dada2/tutorial.html) pipeline for processing paired-end amplicon sequencing data. It automates the transition from raw FASTQ collections to high-resolution Amplicon Sequence Variants (ASVs), providing a comprehensive solution for microbial community analysis.

The pipeline begins with quality control using `plotQualityProfile` and `filterAndTrim`. After unzipping the collection to process forward and reverse reads separately, it performs error rate learning and denoising via the `dada` algorithm. The reads are then merged, and a sequence table is constructed. Final processing steps include the removal of chimeric sequences and taxonomic assignment against a selected reference database.

The workflow generates three primary outputs: a cleaned sequence table (ASV table), taxonomic classifications for each sequence, and a summary of sequence counts to track read retention through each processing stage. Users must provide a paired-end data collection, specify truncation lengths for both read directions, and select a cached reference database for taxonomy.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Paired input data | data_collection_input | Paired input data |
| 1 | Read length forward read | parameter_input | Forward reads will be truncated to this length. Empty means no truncation. |
| 2 | Read length reverse read | parameter_input | Reverse reads will be truncated to this length. Empty means no truncation. |
| 3 | Pool samples | parameter_input | Pooling may increase sensitivity |
| 4 | Cached reference database | parameter_input | for taxonomic assignment. If a cached reference is used no reference from history is used. |


Ensure your paired-end FASTQ files are organized into a paired dataset collection to maintain sample integrity throughout the sorting and merging steps. You must provide specific truncation lengths for both forward and reverse reads based on your initial quality profiles to optimize the filtering process. While the workflow uses a cached reference database for taxonomic assignment, refer to the README.md for comprehensive details on parameter tuning and data preparation. For automated execution, you can initialize your environment using `planemo workflow_job_init` to generate a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 5 | Apply rules | __APPLY_RULES__ |  |
| 6 | dada2: plotQualityProfile | toolshed.g2.bx.psu.edu/repos/iuc/dada2_plotqualityprofile/dada2_plotQualityProfile/1.34.0+galaxy0 |  |
| 7 | dada2: filterAndTrim | toolshed.g2.bx.psu.edu/repos/iuc/dada2_filterandtrim/dada2_filterAndTrim/1.34.0+galaxy0 |  |
| 8 | dada2: plotQualityProfile | toolshed.g2.bx.psu.edu/repos/iuc/dada2_plotqualityprofile/dada2_plotQualityProfile/1.34.0+galaxy0 |  |
| 9 | Unzip collection | __UNZIP_COLLECTION__ |  |
| 10 | dada2: learnErrors | toolshed.g2.bx.psu.edu/repos/iuc/dada2_learnerrors/dada2_learnErrors/1.34.0+galaxy0 |  |
| 11 | dada2: learnErrors | toolshed.g2.bx.psu.edu/repos/iuc/dada2_learnerrors/dada2_learnErrors/1.34.0+galaxy0 |  |
| 12 | dada2: dada | toolshed.g2.bx.psu.edu/repos/iuc/dada2_dada/dada2_dada/1.34.0+galaxy0 |  |
| 13 | dada2: dada | toolshed.g2.bx.psu.edu/repos/iuc/dada2_dada/dada2_dada/1.34.0+galaxy0 |  |
| 14 | dada2: mergePairs | toolshed.g2.bx.psu.edu/repos/iuc/dada2_mergepairs/dada2_mergePairs/1.34.0+galaxy0 |  |
| 15 | dada2: makeSequenceTable | toolshed.g2.bx.psu.edu/repos/iuc/dada2_makesequencetable/dada2_makeSequenceTable/1.34.0+galaxy0 |  |
| 16 | dada2: removeBimeraDenovo | toolshed.g2.bx.psu.edu/repos/iuc/dada2_removebimeradenovo/dada2_removeBimeraDenovo/1.34.0+galaxy0 |  |
| 17 | dada2: sequence counts | toolshed.g2.bx.psu.edu/repos/iuc/dada2_seqcounts/dada2_seqCounts/1.34.0+galaxy0 |  |
| 18 | dada2: assignTaxonomy and addSpecies | toolshed.g2.bx.psu.edu/repos/iuc/dada2_assigntaxonomyaddspecies/dada2_assignTaxonomyAddspecies/1.34.0+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 16 | Sequence Table | stable_sequencetable |
| 17 | Counts | counts |
| 18 | Taxonomy | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run dada2_paired.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run dada2_paired.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run dada2_paired.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init dada2_paired.ga -o job.yml`
- Lint: `planemo workflow_lint dada2_paired.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `dada2_paired.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
