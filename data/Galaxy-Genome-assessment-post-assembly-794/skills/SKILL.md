---
name: galaxy-workflow-genome_assessment_post_assembly
description: "This workflow performs comprehensive quality control on genome assemblies using raw reads and FASTA contigs through tools including Quast, BUSCO, Meryl, and Merqury. Use this skill when you need to evaluate the completeness, accuracy, and continuity of a de novo genome assembly by generating k-mer based statistics and ortholog recovery reports."
homepage: https://workflowhub.eu/workflows/794
---

# Galaxy-Workflow-Genome_assessment_post_assembly

## Overview

This Galaxy workflow provides a comprehensive quality control (QC) suite for evaluating genome assemblies, specifically optimized for high-fidelity (HiFi) long-read data. It automates the assessment of assembly completeness, continuity, and accuracy by integrating industry-standard tools including [Quast](https://github.com/ablab/quast), [BUSCO](https://busco.ezlab.org/), [Meryl](https://github.com/marbl/meryl), and [Merqury](https://github.com/marbl/merqury).

The pipeline requires two primary inputs: raw sequencing reads in `fastqsanger.gz` format and the assembled contigs in FASTA format. By default, the workflow is configured for eukaryotic genomes, utilizing the `eukaryota` lineage for BUSCO and the `large` genome setting for Quast. It performs k-mer distribution analysis to estimate consensus quality (QV) and completeness, while also generating detailed fasta statistics and biological marker assessments.

The workflow produces a consolidated `metrics.tsv` table that aggregates key assembly statistics, read coverage, and BUSCO results into a single report. Users can access detailed visual outputs, including HTML/PDF reports from Quast and diagnostic plots from Merqury. For detailed usage instructions and parameter recommendations, refer to the [Genome assessment post assembly guide](https://australianbiocommons.github.io/how-to-guides/genome_assembly/assembly_qc).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Raw reads | data_input |  |
| 1 | FASTA contigs - Primary Assembly | data_input |  |


Ensure your raw reads are uploaded as `fastqsanger.gz` (not `fastq.gz`) and your primary assembly is in `fasta` format to avoid tool compatibility issues. This workflow processes individual datasets for the reads and contigs, so ensure they are correctly assigned to the corresponding input slots. For comprehensive details on parameter settings and data preparation, refer to the `README.md` file. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution and testing. Note that if the workflow report text appears as default, you may need to manually restore it from a previous version.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | FASTQ to FASTA | toolshed.g2.bx.psu.edu/repos/devteam/fastqtofasta/fastq_to_fasta_python/1.1.5 |  |
| 3 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl/meryl/1.3+galaxy6 |  |
| 4 | Fasta Statistics | toolshed.g2.bx.psu.edu/repos/iuc/fasta_stats/fasta-stats/2.0 |  |
| 5 | Quast | toolshed.g2.bx.psu.edu/repos/iuc/quast/quast/5.0.2+galaxy1 |  |
| 6 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.4.6+galaxy0 |  |
| 7 | Fasta Statistics | toolshed.g2.bx.psu.edu/repos/iuc/fasta_stats/fasta-stats/2.0 |  |
| 8 | Merqury | toolshed.g2.bx.psu.edu/repos/iuc/merqury/merqury/1.3 |  |
| 9 | Search in textfiles | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/1.1.1 |  |
| 10 | Text transformation | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sed_tool/1.1.1 |  |
| 11 | Search in textfiles | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/1.1.1 |  |
| 12 | Search in textfiles | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/1.1.1 |  |
| 13 | Search in textfiles | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/1.1.1 |  |
| 14 | Search in textfiles | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/1.1.1 |  |
| 15 | Cut | Cut1 |  |
| 16 | Filter Tabular | toolshed.g2.bx.psu.edu/repos/iuc/filter_tabular/filter_tabular/3.3.0 |  |
| 17 | Text transformation | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sed_tool/1.1.1 |  |
| 18 | Text transformation | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sed_tool/1.1.1 |  |
| 19 | Cut | Cut1 |  |
| 20 | Filter Tabular | toolshed.g2.bx.psu.edu/repos/iuc/filter_tabular/filter_tabular/3.3.0 |  |
| 21 | Filter Tabular | toolshed.g2.bx.psu.edu/repos/iuc/filter_tabular/filter_tabular/3.3.0 |  |
| 22 | Filter Tabular | toolshed.g2.bx.psu.edu/repos/iuc/filter_tabular/filter_tabular/3.3.0 |  |
| 23 | Filter Tabular | toolshed.g2.bx.psu.edu/repos/iuc/filter_tabular/filter_tabular/3.3.0 |  |
| 24 | Filter Tabular | toolshed.g2.bx.psu.edu/repos/iuc/filter_tabular/filter_tabular/3.3.0 |  |
| 25 | Convert | Convert characters1 |  |
| 26 | Concatenate datasets | cat1 |  |
| 27 | Paste | Paste1 |  |
| 28 | Add line to file | toolshed.g2.bx.psu.edu/repos/bgruening/add_line_to_file/add_line_to_file/0.1.0 |  |
| 29 | Transpose | toolshed.g2.bx.psu.edu/repos/iuc/datamash_transpose/datamash_transpose/1.8+galaxy0 |  |
| 30 | Convert | Convert characters1 |  |
| 31 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/2.0 |  |
| 32 | Convert | Convert characters1 |  |
| 33 | Cut | Cut1 |  |
| 34 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/2.0 |  |
| 35 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_column/1.1.3 |  |
| 36 | Concatenate datasets | cat1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | output_file | output_file |
| 3 | Meryl on input dataset(s): read-db.meryldb | read_db |
| 4 | Fasta Statistics on input dataset(s): summary stats | stats_output |
| 5 | Quast on input dataset(s): tabular report | quast_tabular |
| 5 | Quast on input dataset(s): Log | log |
| 5 | Quast on input dataset(s):  HTML report | report_html |
| 5 | Quast on input dataset(s):  PDF report | report_pdf |
| 6 | Busco on input dataset(s): full table | busco_table |
| 6 | busco_sum | busco_sum |
| 7 | stats_output | stats_output |
| 8 | Merqury on input dataset(s): bed | bed_files |
| 8 | Merqury on input dataset(s): qv | qv_files |
| 8 | Merqury on input dataset(s): png | png_files |
| 8 | Merqury on input dataset(s): size files | sizes_files |
| 8 | Merqury on input dataset(s): stats | stats_files |
| 8 | Merqury on input dataset(s): wig | wig_files |
| 9 | output | output |
| 10 | output | output |
| 11 | output | output |
| 12 | output | output |
| 13 | output | output |
| 14 | output | output |
| 15 | out_file1 | out_file1 |
| 16 | output | output |
| 17 | output | output |
| 18 | output | output |
| 19 | out_file1 | out_file1 |
| 20 | output | output |
| 21 | output | output |
| 22 | output | output |
| 23 | output | output |
| 24 | output | output |
| 25 | out_file1 | out_file1 |
| 26 | out_file1 | out_file1 |
| 27 | out_file1 | out_file1 |
| 28 | outfile | outfile |
| 29 | out_file | out_file |
| 30 | Busco and dependencies version | out_file1 |
| 31 | out_file1 | out_file1 |
| 32 | out_file1 | out_file1 |
| 33 | Genome coverage | out_file1 |
| 34 | out_file1 | out_file1 |
| 35 | outfile | outfile |
| 36 | Genome assembly metrics | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Genome_assessment_post_assembly.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Genome_assessment_post_assembly.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Genome_assessment_post_assembly.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Genome_assessment_post_assembly.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Genome_assessment_post_assembly.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Genome_assessment_post_assembly.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
