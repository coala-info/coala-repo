---
name: whole-transcriptome-analysis-of-arabidopsis-thaliana
description: "This plant transcriptomics workflow integrates miRNA-seq and mRNA-seq data from Arabidopsis thaliana using Salmon, MiRDeep2, and DESeq2 to perform differential expression analysis and target prediction with TargetFinder. Use this skill when you need to identify regulatory interactions by correlating upregulated miRNAs with their downregulated target mRNAs to understand gene expression control under specific experimental conditions."
homepage: https://workflowhub.eu/workflows/1717
---

# Whole transcriptome analysis of Arabidopsis thaliana

## Overview

This Galaxy workflow performs a comprehensive whole transcriptome analysis of *Arabidopsis thaliana*, integrating both miRNA-seq and mRNA-seq data to identify regulatory interactions. Based on the [GTN tutorial](https://gxy.io/GTN:T00292), the pipeline executes two parallel differential expression analyses to determine how specific miRNAs may regulate gene expression under different biological conditions, such as Brassinosteroid (BR) treatment.

The process begins with rigorous quality control and preprocessing using **Falco**, **Trim Galore!**, and **MultiQC**. For the mRNA-seq arm, transcript levels are quantified using **Salmon**, followed by differential expression analysis with **DESeq2**. Simultaneously, the miRNA-seq arm utilizes **miRDeep2 Mapper** and **Quantifier** to process small RNA reads against known miRNA stem-loop and mature sequences, with **DESeq2** identifying significantly altered miRNAs.

In the final stage, the workflow integrates these independent results to find functional correlations. It specifically identifies upregulated miRNAs and checks them against downregulated mRNA targets using **TargetFinder**. This cross-referencing helps pinpoint putative miRNA-target pairs that are likely involved in the plant's transcriptional response.

This workflow is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) and is tagged for use in plant transcriptomics research.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Control miRNA | data_collection_input | Collection of control miRNA FASTQs |
| 1 | BR treated miRNA | data_collection_input | Collection of BR treated miRNA FASTQs |
| 2 | miRNA_stem-loop_seq.fasta | data_input | miRNA step loop sequences |
| 3 | miRNA_DESeq2_results_complete_dataset | data_input | DESeq2 results complete miRNA dataset |
| 4 | mature_miRNA_AT.fasta | data_input | mature miRNA sequences |
| 5 | star_miRNA_seq.fasta | data_input | miRNA star sequences |
| 6 | mRNA_DESeq2_results_complete_dataset.tabular | data_input | DESeq2 results of complete mRNA dataset |
| 7 | transcriptome.fasta | data_input | transcriptome sequences in FASTA format |
| 8 | BR treated mRNA | data_collection_input | Collection of BR treated mRNA FASTQs |
| 9 | Control mRNA | data_collection_input | Collection of control mRNA FASTQs |
| 10 | annotation_AtRTD2.gtf | data_input | Annotation in GTF format |


Ensure all sequencing reads for both miRNA and mRNA are organized into paired data collections for control and treated groups to maintain sample metadata throughout the DESeq2 and MiRDeep2 steps. You must provide reference files in FASTA format for the transcriptome, stem-loop, and mature miRNA sequences, alongside a GTF annotation file for accurate quantification. For large-scale testing, the workflow accepts pre-computed DESeq2 tabular results to streamline the target prediction analysis. Refer to the README.md for comprehensive details on parameter settings and specific Arabidopsis thaliana reference versions. You can use `planemo workflow_job_init` to generate a `job.yml` for automated input mapping.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 11 | Falco | toolshed.g2.bx.psu.edu/repos/iuc/falco/falco/1.2.4+galaxy0 |  |
| 12 | Trim Galore! | toolshed.g2.bx.psu.edu/repos/bgruening/trim_galore/trim_galore/0.6.10+galaxy0 |  |
| 13 | Falco | toolshed.g2.bx.psu.edu/repos/iuc/falco/falco/1.2.4+galaxy0 |  |
| 14 | Trim Galore! | toolshed.g2.bx.psu.edu/repos/bgruening/trim_galore/trim_galore/0.6.10+galaxy0 |  |
| 15 | Filter | Filter1 |  |
| 16 | Filter | Filter1 |  |
| 17 | Falco | toolshed.g2.bx.psu.edu/repos/iuc/falco/falco/1.2.4+galaxy0 |  |
| 18 | Falco | toolshed.g2.bx.psu.edu/repos/iuc/falco/falco/1.2.4+galaxy0 |  |
| 19 | Salmon quant | toolshed.g2.bx.psu.edu/repos/bgruening/salmon/salmon/1.10.1+galaxy2 |  |
| 20 | Salmon quant | toolshed.g2.bx.psu.edu/repos/bgruening/salmon/salmon/1.10.1+galaxy2 |  |
| 21 | Falco | toolshed.g2.bx.psu.edu/repos/iuc/falco/falco/1.2.4+galaxy0 |  |
| 22 | MiRDeep2 Mapper | toolshed.g2.bx.psu.edu/repos/rnateam/mirdeep2_mapper/rbc_mirdeep2_mapper/2.0.0.8.1 |  |
| 23 | Merge collections | __MERGE_COLLECTION__ |  |
| 24 | Falco | toolshed.g2.bx.psu.edu/repos/iuc/falco/falco/1.2.4+galaxy0 |  |
| 25 | MiRDeep2 Mapper | toolshed.g2.bx.psu.edu/repos/rnateam/mirdeep2_mapper/rbc_mirdeep2_mapper/2.0.0.8.1 |  |
| 26 | Filter | Filter1 |  |
| 27 | Filter | Filter1 |  |
| 28 | Filter | Filter1 |  |
| 29 | Merge collections | __MERGE_COLLECTION__ |  |
| 30 | DESeq2 | toolshed.g2.bx.psu.edu/repos/iuc/deseq2/deseq2/2.11.40.8+galaxy0 |  |
| 31 | MiRDeep2 Quantifier | toolshed.g2.bx.psu.edu/repos/rnateam/mirdeep2_quantifier/rbc_mirdeep2_quantifier/2.0.0 |  |
| 32 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.27+galaxy3 |  |
| 33 | Merge collections | __MERGE_COLLECTION__ |  |
| 34 | MiRDeep2 Quantifier | toolshed.g2.bx.psu.edu/repos/rnateam/mirdeep2_quantifier/rbc_mirdeep2_quantifier/2.0.0 |  |
| 35 | Sort | sort1 |  |
| 36 | Cut | Cut1 |  |
| 37 | Cut | Cut1 |  |
| 38 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.27+galaxy3 |  |
| 39 | Cut | Cut1 |  |
| 40 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.8+galaxy1 |  |
| 41 | Cut | Cut1 |  |
| 42 | Filter FASTA | toolshed.g2.bx.psu.edu/repos/galaxyp/filter_by_fasta_ids/filter_by_fasta_ids/2.3 |  |
| 43 | Filter FASTA | toolshed.g2.bx.psu.edu/repos/galaxyp/filter_by_fasta_ids/filter_by_fasta_ids/2.3 |  |
| 44 | Filter FASTA | toolshed.g2.bx.psu.edu/repos/galaxyp/filter_by_fasta_ids/filter_by_fasta_ids/2.3 |  |
| 45 | DESeq2 | toolshed.g2.bx.psu.edu/repos/iuc/deseq2/deseq2/2.11.40.8+galaxy0 |  |
| 46 | Concatenate datasets | cat1 |  |
| 47 | Filter | Filter1 |  |
| 48 | TargetFinder | toolshed.g2.bx.psu.edu/repos/rnateam/targetfinder/targetfinder/1.7.0+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 30 | DESeq2 results subsample mRNA | deseq_out |
| 45 | DESeq2 results subsample miRNA | deseq_out |
| 48 | TargetFinder output | output_file |


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
