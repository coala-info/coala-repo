---
name: mapping-and-molecular-identification-of-phenotype-causing-mu
description: "This Arabidopsis thaliana variant analysis workflow processes reference genomes and aligned reads from outcrossed F2 pools and mapping strains using the MiModD suite and SnpEff to identify phenotype-causing mutations. Use this skill when you need to perform mapping-by-sequencing to pinpoint the genomic location and molecular identity of mutations responsible for observed phenotypes in plant breeding or genetic research."
homepage: https://workflowhub.eu/workflows/1682
---

# Mapping And Molecular Identification Of Phenotype Causing Mutations

## Overview

This workflow facilitates mapping-by-sequencing to identify phenotype-causing mutations in *Arabidopsis thaliana*. It reproduces the analysis described in the [Galaxy Training Network (GTN) tutorial](https://training.galaxyproject.org/training-material/topics/variant-analysis/tutorials/mapping-by-sequencing/tutorial.html), utilizing aligned reads from an outcrossed F2 pool and a mapping strain against the TAIR10 reference genome.

The pipeline relies heavily on the [MiModD](https://mimodd.readthedocs.io/en/latest/) suite for variant calling, site extraction, and linkage analysis. By employing the `NacreousMap` tool, the workflow identifies genomic regions associated with the mutation of interest through allele frequency analysis.

Following the mapping phase, the workflow filters the resulting VCF files and uses [SnpEff](https://pcingola.github.io/SnpEff/) to annotate the functional impact of identified variants. The process concludes with a detailed variant report, allowing researchers to prioritize candidate mutations based on their predicted molecular effects.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | A. thaliana TAIR10 ref genome | data_input | can be obtained from https://www.arabidopsis.org/download_files/Genes/TAIR10_genome_release/TAIR10_chromosome_files/TAIR10_chr_all.fas |
| 1 | aligned reads from outcrossed F2 pool | data_input | as obtained from https://zenodo.org/record/1098034/files/outcrossed_F2.bam |
| 2 | aligned reads from Ler mapping strain | data_input | as obtained from https://zenodo.org/record/1098034/files/Ler_mapping_strain.bam |


Ensure you provide the *A. thaliana* TAIR10 reference genome in FASTA format and aligned sequencing reads for both the outcrossed F2 pool and the Ler mapping strain as BAM files. While these inputs are typically handled as individual datasets, ensure all BAM files are properly indexed and coordinate-sorted to avoid errors during MiModD variant calling. For automated execution, you can generate a template for your input parameters using `planemo workflow_job_init` to create a `job.yml` file. Please consult the README.md for exhaustive instructions on data preparation and specific tool configurations.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | SnpEff Download | toolshed.g2.bx.psu.edu/repos/iuc/snpeff/snpEff_download/4.1.0 | download the SnpEff genome annotation file corresponding to TAIR10 |
| 4 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/1.1.1 | truncate ref genome chromosome names |
| 5 | MiModD Variant Calling | toolshed.g2.bx.psu.edu/repos/wolma/mimodd_main/mimodd_varcall/0.1.8_1 | compute variant call statistics for both samples across the entire genome |
| 6 | MiModD Extract Variant Sites | toolshed.g2.bx.psu.edu/repos/wolma/mimodd_main/mimodd_varextract/0.1.8_1 | extract variants at sites for which at least one sample is not homozygous wildtype |
| 7 | MiModD NacreousMap | toolshed.g2.bx.psu.edu/repos/wolma/mimodd_main/mimodd_map/0.1.8_1 | Variant allele frequency-based linkage analysis |
| 8 | MiModD VCF Filter | toolshed.g2.bx.psu.edu/repos/wolma/mimodd_main/mimodd_vcf_filter/0.1.8_1 | get candidates in linked region |
| 9 | SnpEff | toolshed.g2.bx.psu.edu/repos/iuc/snpeff/snpEff/4.1.0 | annotate the candidate mutations |
| 10 | MiModD Report Variants | toolshed.g2.bx.psu.edu/repos/wolma/mimodd_main/mimodd_varreport/0.1.8_1 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run workflow-arabidopsis.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run workflow-arabidopsis.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run workflow-arabidopsis.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init workflow-arabidopsis.ga -o job.yml`
- Lint: `planemo workflow_lint workflow-arabidopsis.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `workflow-arabidopsis.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
