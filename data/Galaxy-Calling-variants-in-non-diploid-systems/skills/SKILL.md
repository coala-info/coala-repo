---
name: calling-variants-in-non-diploid-systems
description: "This workflow performs variant calling on paired-end FASTQ reads from non-diploid samples using BWA-MEM for mapping and FreeBayes for identifying genetic polymorphisms. Use this skill when analyzing genomic data from organisms with complex ploidy levels, viral quasispecies, or pooled samples where traditional diploid genotype models are inappropriate."
homepage: https://workflowhub.eu/workflows/1659
---

# Calling variants in non-diploid systems

## Overview

This workflow is designed to identify genetic variations in non-diploid systems, such as mitochondrial DNA, viral populations, or polyploid organisms, where standard diploid assumptions do not apply. The process begins with quality control of raw sequencing reads using [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/), followed by alignment to a reference genome using [BWA-MEM](https://github.com/lh3/bwa).

To ensure high-quality variant calls, the workflow performs several alignment refinement steps. It utilizes [Picard](https://broadinstitute.github.io/picard/) tools to merge SAM files and mark PCR duplicates, and employs [BamLeftAlign](https://github.com/freebayes/freebayes) to standardize the positioning of insertions and deletions. These steps minimize false positives caused by mapping artifacts or library preparation biases.

The core analysis is performed by [FreeBayes](https://github.com/freebayes/freebayes), a Bayesian genetic variant detector specifically configured to handle complex ploidy levels. The resulting variants are filtered for quality and converted from VCF format into tab-delimited files for easier downstream interpretation. This workflow follows [GTN](https://training.galaxyproject.org/) best practices for [Variant-analysis](https://training.galaxyproject.org/training-material/topics/variant-analysis/).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | raw_child-ds-1.fq | data_input |  |
| 1 | raw_child-ds-2.fq | data_input |  |
| 2 | raw_mother-ds-1.fq | data_input |  |
| 3 | raw_mother-ds-2.fq | data_input |  |


Ensure your input FASTQ files are correctly assigned as paired-end datasets or organized into a dataset collection to streamline the BWA-MEM mapping process. Verify that your reference genome is available in the history or as a built-in index to ensure proper alignment and subsequent variant calling with FreeBayes. For large-scale analyses, using `planemo workflow_job_init` can help automate the creation of a `job.yml` file for batch processing. Consult the README.md for comprehensive details on parameter tuning for non-diploid ploidy settings and filtering criteria. Always check that your BAM files are properly sorted and indexed before proceeding to the alignment cleaning steps.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy1 |  |
| 5 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy1 |  |
| 6 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.19 |  |
| 7 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy1 |  |
| 8 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy1 |  |
| 9 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.19 |  |
| 10 | MergeSamFiles | toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_MergeSamFiles/3.1.1.0 |  |
| 11 | MarkDuplicates | toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_MarkDuplicates/3.1.1.0 |  |
| 12 | BamLeftAlign | toolshed.g2.bx.psu.edu/repos/devteam/freebayes/bamleftalign/1.3.9 |  |
| 13 | Filter BAM | toolshed.g2.bx.psu.edu/repos/devteam/bamtools_filter/bamFilter/2.5.2+galaxy2 |  |
| 14 | FreeBayes | toolshed.g2.bx.psu.edu/repos/devteam/freebayes/freebayes/1.3.9+galaxy0 |  |
| 15 | VCFfilter: | toolshed.g2.bx.psu.edu/repos/devteam/vcffilter/vcffilter2/1.0.0_rc3+galaxy3 |  |
| 16 | VCFtoTab-delimited: | toolshed.g2.bx.psu.edu/repos/devteam/vcf2tsv/vcf2tsv/1.0.0_rc3+galaxy0 |  |
| 17 | Cut | Cut1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 16 | out_file1 | out_file1 |
| 17 | out_file1 | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run calling-variants-in-non-diploid-systems.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run calling-variants-in-non-diploid-systems.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run calling-variants-in-non-diploid-systems.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init calling-variants-in-non-diploid-systems.ga -o job.yml`
- Lint: `planemo workflow_lint calling-variants-in-non-diploid-systems.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `calling-variants-in-non-diploid-systems.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
