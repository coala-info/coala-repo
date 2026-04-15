---
name: hybrid-genome-assembly-tutorial-workflow
description: This genomics workflow performs hybrid de novo genome assembly using Illumina and Nanopore reads through tools like Flye, Unicycler, and Pilon, while evaluating quality with BUSCO and QUAST. Use this skill when you need to generate a highly accurate and contiguous genome assembly by leveraging the complementary strengths of long-read and short-read sequencing data.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# hybrid-genome-assembly-tutorial-workflow

## Overview

This workflow implements a comprehensive hybrid genome assembly pipeline designed for the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) tutorial on combining Nanopore and Illumina sequencing data. It utilizes long reads for initial contig construction and short reads for high-accuracy polishing, ensuring a contiguous and accurate final assembly.

The process begins by generating a long-read assembly using [Flye](https://github.com/fenderglass/Flye) and a hybrid assembly via [Unicycler](https://github.com/rrwick/Unicycler). To further improve sequence quality, the pipeline maps Illumina reads to the assembly using [BWA-MEM](https://github.com/lh3/bwa) and performs automated polishing with [Pilon](https://github.com/astraw/pilon).

Quality control is integrated at every stage of the assembly process. The workflow runs [BUSCO](https://busco.ezlab.org/) to assess gene content completeness and [QUAST](https://github.com/ablab/quast) to evaluate assembly metrics against a reference genome. All diagnostic results are aggregated into a final [MultiQC](https://multiqc.info/) report for streamlined comparative analysis.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | reference_genome.fasta | data_input |  |
| 1 | illumina_reads_1.fastq | data_input |  |
| 2 | illumina_reads_2.fastq | data_input |  |
| 3 | nanopore_reads.fastq | data_input |  |


Ensure your input files are correctly formatted as FASTQ for both Illumina paired-end and Nanopore long reads, while the reference genome must be in FASTA format. For large-scale analyses, organizing your paired-end reads into a dataset collection can streamline the Unicycler and BWA-MEM steps. Refer to the README.md for comprehensive details on parameter settings and data preprocessing requirements. You can quickly initialize your execution environment using `planemo workflow_job_init` to generate a template `job.yml` file. Always verify that your quality control metrics are consistent across datasets before launching the full assembly pipeline.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.8.0+galaxy1 |  |
| 5 | Flye | toolshed.g2.bx.psu.edu/repos/bgruening/flye/flye/2.9.6+galaxy0 |  |
| 6 | Create assemblies with Unicycler | toolshed.g2.bx.psu.edu/repos/iuc/unicycler/unicycler/0.5.1+galaxy0 |  |
| 7 | Quast | toolshed.g2.bx.psu.edu/repos/iuc/quast/quast/5.3.0+galaxy0 |  |
| 8 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.8.0+galaxy1 |  |
| 9 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.19 |  |
| 10 | Quast | toolshed.g2.bx.psu.edu/repos/iuc/quast/quast/5.3.0+galaxy0 |  |
| 11 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.8.0+galaxy1 |  |
| 12 | pilon | toolshed.g2.bx.psu.edu/repos/iuc/pilon/pilon/1.20.1 |  |
| 13 | Quast | toolshed.g2.bx.psu.edu/repos/iuc/quast/quast/5.3.0+galaxy0 |  |
| 14 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.8.0+galaxy1 |  |
| 15 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.27+galaxy4 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | busco_sum_ref | busco_sum |
| 7 | report_html_raw_assembly | report_html |
| 8 | busco_sum_raw_assembly | busco_sum |
| 10 | report_html_unicy_assembly | report_html |
| 11 | busco_sum_unicy_assembly | busco_sum |
| 13 | report_html_polish_assembly | report_html |
| 14 | busco_sum_polish_assembly | busco_sum |
| 15 | multiqc_html_report | html_report |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run hybrid-genome-assembly-tutorial-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run hybrid-genome-assembly-tutorial-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run hybrid-genome-assembly-tutorial-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init hybrid-genome-assembly-tutorial-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint hybrid-genome-assembly-tutorial-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `hybrid-genome-assembly-tutorial-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)