---
name: pox-virus-illumina-amplicon-workflow-from-half-genomes
description: This virology workflow processes Illumina paired-end amplicon reads from pox virus samples using BWA-MEM for mapping to masked references and iVar for primer trimming and consensus generation. Use this skill when you need to resolve complex inverted terminal repeat sequences in pox virus genomes by analyzing data from samples sequenced as two separate half-genome pools.
homepage: https://iwc.galaxyproject.org/
metadata:
  docker_image: "N/A"
---

# pox-virus-illumina-amplicon-workflow-from-half-genomes

## Overview

This Galaxy workflow is designed for the analysis of pox virus genomes sequenced using a tiled-amplicon approach (ARTIC). It specifically addresses the challenge of resolving Inverted Terminal Repeat (ITR) sequences by processing samples sequenced as "half-genomes" across two separate sequencing runs. By utilizing this split-sequencing strategy, the workflow ensures more accurate assembly and consensus generation for complex poxvirus genomic structures.

The pipeline begins by preprocessing paired-end reads from two separate pools using [fastp](https://github.com/OpenGene/fastp) for quality control and adapter trimming. It then generates two distinct versions of the reference genome, each masked to correspond to a specific half-genome. Reads from each pool are mapped to their respective masked references using [BWA-MEM](https://github.com/lh3/bwa), followed by filtering and statistical assessment via [Samtools](https://www.htslib.org/) and [MultiQC](https://multiqc.info/).

In the final stages, the workflow merges the mapping results from both pools into a single alignment. It employs [iVar](https://andersen-lab.github.io/ivar/html/manualpage.html) to perform primer trimming and call consensus sequences based on user-defined quality scores and allele frequency thresholds. The final outputs include per-sample consensus sequences, a combined multi-FASTA file, and comprehensive quality reports from [QualiMap](http://qualimap.conesalab.org/) and MultiQC.

This workflow is licensed under the **MIT License** and is tagged for use in **pox** and **virology** research. It builds upon the logic of standard SARS-CoV-2 ARTIC pipelines but introduces specialized handling for split-genome mapping and merging.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Reference FASTA | data_input | The viral reference sequence to map sequenced reads against |
| 1 | Primer Scheme | data_input | The workflow expects a primer scheme split into two separate sequencing pools. These pools must be denoted as pool1/pool2 in the BED score column. The pool ids may, optionally, be followed by indicators of the subpool for tiled PCR amplification (e.g., pool1a/pool1b/pool2a/pool2b) |
| 2 | PE Reads Pool1 | data_collection_input | A collection of the sequencing data obtained from the **pool1** run of all samples |
| 3 | PE Reads Pool2 | data_collection_input | A collection of the sequencing data obtained from the **pool2** run of all samples |
| 4 | Minimum quality score to call base | parameter_input | Only sequenced bases with at least this  base calling quality will be considered for consensus calling. |
| 5 | Allele frequency to call SNV | parameter_input | A consensus **SNV** call requires that the alternate base is seen in at least this fraction of reads covering it. |
| 6 | Allele frequency to call indel | parameter_input | A consensus **indel** call requires that the indel is seen in at least this fraction of reads covering it. |


To prepare your data, upload the reference genome in FASTA format and the primer scheme as a tabular file, ensuring the primer pool identifiers match the workflow's expectations for split-genome processing. Paired-end reads must be organized into two separate list:paired dataset collections, one for each sequencing pool, to allow the workflow to resolve inverted terminal repeats (ITRs) correctly. For automated execution and parameter reproducibility, you can initialize a job configuration using `planemo workflow_job_init` to generate a `job.yml` file. Please refer to the `README.md` for comprehensive details on file formatting and specific parameter requirements for iVar and BWA-MEM. Ensure all input collections are properly named and paired before launching the analysis to avoid mapping errors.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 7 | Compute sequence length | toolshed.g2.bx.psu.edu/repos/devteam/fasta_compute_length/fasta_compute_length/1.0.4 |  |
| 8 | Select | Grep1 |  |
| 9 | Select | Grep1 |  |
| 10 | Extract element identifiers | toolshed.g2.bx.psu.edu/repos/iuc/collection_element_identifiers/collection_element_identifiers/0.0.2 |  |
| 11 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/1.0.1+galaxy2 |  |
| 12 | Cut | Cut1 |  |
| 13 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.9+galaxy0 |  |
| 14 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.9+galaxy0 |  |
| 15 | Split file | toolshed.g2.bx.psu.edu/repos/bgruening/split_file_to_collection/split_file_to_collection/0.5.2 |  |
| 16 | Sort collection | __SORTLIST__ |  |
| 17 | Parse parameter value | param_value_from_file |  |
| 18 | Parse parameter value | param_value_from_file |  |
| 19 | Parse parameter value | param_value_from_file |  |
| 20 | Parse parameter value | param_value_from_file |  |
| 21 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/1.0.1+galaxy2 |  |
| 22 | Compose text parameter value | toolshed.g2.bx.psu.edu/repos/iuc/compose_text_param/compose_text_param/0.1.1 |  |
| 23 | Compose text parameter value | toolshed.g2.bx.psu.edu/repos/iuc/compose_text_param/compose_text_param/0.1.1 |  |
| 24 | Compose text parameter value | toolshed.g2.bx.psu.edu/repos/iuc/compose_text_param/compose_text_param/0.1.1 |  |
| 25 | Compose text parameter value | toolshed.g2.bx.psu.edu/repos/iuc/compose_text_param/compose_text_param/0.1.1 |  |
| 26 | maskseq | toolshed.g2.bx.psu.edu/repos/devteam/emboss_5/EMBOSS: maskseq51/5.0.0 |  |
| 27 | maskseq | toolshed.g2.bx.psu.edu/repos/devteam/emboss_5/EMBOSS: maskseq51/5.0.0 |  |
| 28 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.19 |  |
| 29 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.19 |  |
| 30 | Samtools view | toolshed.g2.bx.psu.edu/repos/iuc/samtools_view/samtools_view/1.21+galaxy0 |  |
| 31 | Samtools stats | toolshed.g2.bx.psu.edu/repos/devteam/samtools_stats/samtools_stats/2.0.7 |  |
| 32 | Samtools view | toolshed.g2.bx.psu.edu/repos/iuc/samtools_view/samtools_view/1.21+galaxy0 |  |
| 33 | Samtools stats | toolshed.g2.bx.psu.edu/repos/devteam/samtools_stats/samtools_stats/2.0.7 |  |
| 34 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.27+galaxy3 |  |
| 35 | Zip collections | __ZIP_COLLECTION__ |  |
| 36 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.27+galaxy3 |  |
| 37 | Apply rules | __APPLY_RULES__ |  |
| 38 | Samtools merge | toolshed.g2.bx.psu.edu/repos/iuc/samtools_merge/samtools_merge/1.21+galaxy0 |  |
| 39 | QualiMap BamQC | toolshed.g2.bx.psu.edu/repos/iuc/qualimap_bamqc/qualimap_bamqc/2.3+galaxy0 |  |
| 40 | ivar trim | toolshed.g2.bx.psu.edu/repos/iuc/ivar_trim/ivar_trim/1.4.4+galaxy1 |  |
| 41 | Filter failed datasets | __FILTER_FAILED_DATASETS__ |  |
| 42 | ivar consensus | toolshed.g2.bx.psu.edu/repos/iuc/ivar_consensus/ivar_consensus/1.4.4+galaxy0 |  |
| 43 | Flatten collection | __FLATTEN__ |  |
| 44 | Text transformation | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sed_tool/9.5+galaxy2 |  |
| 45 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.27+galaxy3 |  |
| 46 | Concatenate datasets | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cat/9.5+galaxy2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 8 | pool1_primers | out_file1 |
| 9 | pool2_primers | out_file1 |
| 11 | fastp_pool1_html | report_html |
| 11 | fastp_pool1_reads | output_paired_coll |
| 11 | fastp_pool1_json | report_json |
| 16 | input dataset(s) (sorted) | output |
| 21 | fastp_pool2_json | report_json |
| 21 | fastp_pool2_reads | output_paired_coll |
| 21 | fastp_pool2_html | report_html |
| 26 | masked_ref_pool1 | out_file1 |
| 27 | masked_ref_pool2 | out_file1 |
| 28 | Mapping of Pool1 | bam_output |
| 29 | mapping_pool2 | bam_output |
| 30 | filtered_mapping_pool1 | outputsam |
| 31 | mapping_stats_pool1 | output |
| 32 | filtered_mapping_pool2 | outputsam |
| 33 | mapping_stats_pool2 | output |
| 34 | multiqc_pool1_stats | stats |
| 34 | pool1_quality_report | html_report |
| 36 | pool2_quality_report | html_report |
| 36 | multiqc_pool2_stats | stats |
| 38 | mapping_merged | output |
| 39 | qualimap_pool1_raw | raw_data |
| 39 | qualimap_merged_html | output_html |
| 40 | trimmed_merged_mapping | output_bam |
| 42 | ivar_consensus_out | consensus |
| 44 | per_sample_consensus | output |
| 45 | quality_by_sample_report | html_report |
| 45 | multiqc_sample_stats | stats |
| 46 | combined_consensus_multifasta | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run pox-virus-half-genome.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run pox-virus-half-genome.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run pox-virus-half-genome.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init pox-virus-half-genome.ga -o job.yml`
- Lint: `planemo workflow_lint pox-virus-half-genome.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `pox-virus-half-genome.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)