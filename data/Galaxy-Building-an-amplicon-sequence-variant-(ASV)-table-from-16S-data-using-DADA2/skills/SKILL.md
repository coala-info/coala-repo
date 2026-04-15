---
name: building-an-amplicon-sequence-variant-asv-table-from-16s-dat
description: This microbiome workflow processes raw 16S rRNA sequencing reads into an amplicon sequence variant (ASV) table and taxonomic assignments using the DADA2 pipeline. Use this skill when you need to resolve fine-scale microbial diversity from environmental or clinical samples by filtering sequencing noise and identifying exact biological sequences.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# building-an-amplicon-sequence-variant-asv-table-from-16s-dat

## Overview

This workflow implements the DADA2 pipeline within Galaxy to process 16S rRNA gene amplicon sequences into an Amplicon Sequence Variant (ASV) table. It begins by taking raw sequencing reads and performing quality control through filtering and trimming. Quality profiles are generated to visualize the data, ensuring that only high-quality reads proceed to the denoising stage.

The core of the process involves learning error rates for the sequencing run and applying the DADA2 denoising algorithm. This approach allows for the resolution of biological variants differing by as little as a single nucleotide, providing finer resolution than traditional OTU clustering. For paired-end data, the workflow merges the denoised forward and reverse reads to reconstruct the full amplicon sequences.

Following merging, the workflow constructs a sequence table and performs chimera removal to eliminate artifacts. It then assigns taxonomy to the resulting ASVs and generates sequence counts for each sample. The final outputs include a taxonomic table and a [phyloseq](https://joey711.github.io/phyloseq/) object, which integrates the ASV data, taxonomy, and metadata for downstream ecological analysis. This workflow is particularly useful for microbiome researchers following [GTN](https://training.galaxyproject.org/) best practices.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Raw reads | data_collection_input | raw_reads |
| 1 | header | data_input | header |


Ensure your raw 16S reads are organized into a paired-end list collection of fastq.gz files to maintain sample associations throughout the DADA2 pipeline. The workflow also requires a tabular header file to properly format the final sequence counts and metadata tables. For automated execution, you can use `planemo workflow_job_init` to generate a `job.yml` file that maps these inputs to the workflow. Refer to the README.md for comprehensive details on parameter settings and reference database requirements for taxonomic assignment. Always verify that your collection identifiers match your experimental metadata to ensure accurate downstream analysis in phyloseq.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Sort collection | __SORTLIST__ |  |
| 3 | dada2: filterAndTrim | toolshed.g2.bx.psu.edu/repos/iuc/dada2_filterandtrim/dada2_filterAndTrim/1.34.0+galaxy0 |  |
| 4 | dada2: plotQualityProfile | toolshed.g2.bx.psu.edu/repos/iuc/dada2_plotqualityprofile/dada2_plotQualityProfile/1.34.0+galaxy0 |  |
| 5 | Unzip collection | __UNZIP_COLLECTION__ |  |
| 6 | dada2: plotQualityProfile | toolshed.g2.bx.psu.edu/repos/iuc/dada2_plotqualityprofile/dada2_plotQualityProfile/1.34.0+galaxy0 |  |
| 7 | dada2: learnErrors | toolshed.g2.bx.psu.edu/repos/iuc/dada2_learnerrors/dada2_learnErrors/1.34.0+galaxy0 |  |
| 8 | dada2: learnErrors | toolshed.g2.bx.psu.edu/repos/iuc/dada2_learnerrors/dada2_learnErrors/1.34.0+galaxy0 |  |
| 9 | dada2: dada | toolshed.g2.bx.psu.edu/repos/iuc/dada2_dada/dada2_dada/1.34.0+galaxy0 |  |
| 10 | dada2: dada | toolshed.g2.bx.psu.edu/repos/iuc/dada2_dada/dada2_dada/1.34.0+galaxy0 |  |
| 11 | dada2: mergePairs | toolshed.g2.bx.psu.edu/repos/iuc/dada2_mergepairs/dada2_mergePairs/1.34.0+galaxy0 |  |
| 12 | Extract element identifiers | toolshed.g2.bx.psu.edu/repos/iuc/collection_element_identifiers/collection_element_identifiers/0.0.2 |  |
| 13 | dada2: makeSequenceTable | toolshed.g2.bx.psu.edu/repos/iuc/dada2_makesequencetable/dada2_makeSequenceTable/1.34.0+galaxy0 |  |
| 14 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_line/9.5+galaxy2 |  |
| 15 | dada2: removeBimeraDenovo | toolshed.g2.bx.psu.edu/repos/iuc/dada2_removebimeradenovo/dada2_removeBimeraDenovo/1.34.0+galaxy0 |  |
| 16 | Select first | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_head_tool/9.5+galaxy2 |  |
| 17 | dada2: sequence counts | toolshed.g2.bx.psu.edu/repos/iuc/dada2_seqcounts/dada2_seqCounts/1.34.0+galaxy0 |  |
| 18 | dada2: assignTaxonomy and addSpecies | toolshed.g2.bx.psu.edu/repos/iuc/dada2_assigntaxonomyaddspecies/dada2_assignTaxonomyAddspecies/1.34.0+galaxy0 |  |
| 19 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/2.1 |  |
| 20 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_column/9.3+galaxy1 |  |
| 21 | Concatenate datasets | cat1 |  |
| 22 | Create phyloseq object | toolshed.g2.bx.psu.edu/repos/iuc/phyloseq_from_dada2/phyloseq_from_dada2/1.50.0+galaxy3 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 13 | sequence_table | stable |
| 17 | sequence_counts | counts |
| 18 | taxons | output |
| 21 | metada_table | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init workflow.ga -o job.yml`
- Lint: `planemo workflow_lint workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)