---
name: genome-wide-alternative-splicing-analysis
description: "This transcriptomics workflow performs genome-wide alternative splicing analysis by processing RNA-seq data through STAR alignment, StringTie assembly, and IsoformSwitchAnalyzeR integration with CPAT and Pfam functional annotations. Use this skill when you need to identify isoform switches with predicted functional consequences, such as changes in protein domains or coding potential, across different biological conditions."
homepage: https://workflowhub.eu/workflows/472
---

# Genome-wide alternative splicing analysis

## Overview

This training workflow provides a comprehensive pipeline for identifying and analyzing alternative splicing events and isoform switches using RNA-seq data. It begins with raw data preprocessing using [fastp](https://toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.23.2+galaxy0) and [FastQC](https://toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.73+galaxy0), followed by read mapping with [RNA STAR](https://toolshed.g2.bx.psu.edu/repos/iuc/rgrnastar/rna_star/2.7.10b+galaxy3). Extensive quality control is performed via [RSeQC](https://toolshed.g2.bx.psu.edu/repos/nilesh/rseqc/) tools to evaluate junction saturation, read distribution, and gene body coverage.

Transcript assembly and quantification are handled by [StringTie](https://toolshed.g2.bx.psu.edu/repos/iuc/stringtie/stringtie/2.2.1+galaxy1), which reconstructs transcripts from the aligned reads. The workflow then utilizes [IsoformSwitchAnalyzeR](https://toolshed.g2.bx.psu.edu/repos/iuc/isoformswitchanalyzer/isoformswitchanalyzer/1.20.0+galaxy3) to identify statistically significant isoform switches. To characterize the functional consequences of these switches, the pipeline integrates external tools like [CPAT](https://toolshed.g2.bx.psu.edu/repos/bgruening/cpat/cpat/3.0.4+galaxy0) for coding potential assessment and [PfamScan](https://toolshed.g2.bx.psu.edu/repos/bgruening/pfamscan/pfamscan/1.6+galaxy0) for protein domain identification.

The final stages of the workflow consolidate these functional annotations to highlight switches that result in protein domain loss/gain or changes in coding potential. This end-to-end solution is tagged for [transcriptomics](https://galaxyproject.org/use/transcriptomics/) and [alternative splicing](https://training.galaxyproject.org/training-material/topics/transcriptomics/tutorials/isoform-switch/tutorial.html) analysis, providing researchers with a robust framework for exploring post-transcriptional regulation.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Genome annotation | data_input |  |
| 1 | Reference genome | data_input |  |
| 2 | RNA-seq data collection | data_collection_input |  |
| 3 | Protein coding transcripts | data_input |  |
| 4 | lncRNA transcripts | data_input |  |
| 5 | Pfam-A HMM library | data_input |  |
| 6 | Active sites dataset | data_input |  |
| 7 | Pfam-A HMM Stockholm file | data_input |  |
| 8 | CPAT header | data_input |  |


Ensure all transcriptomic inputs are correctly formatted, specifically using GTF for genome annotations and FASTA for the reference genome and transcript sequences. Organize your raw RNA-seq reads into a paired-end or single-end data collection to enable efficient batch processing through STAR and StringTie. You must also provide specialized functional annotation files, including Pfam-A HMM libraries and CPAT headers, to support the downstream isoform switch analysis. For a comprehensive guide on parameter settings and data organization, refer to the README.md file. You can use `planemo workflow_job_init` to generate a `job.yml` for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 9 | Convert GTF to BED12 | toolshed.g2.bx.psu.edu/repos/iuc/gtftobed12/gtftobed12/357 |  |
| 10 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.23.2+galaxy0 |  |
| 11 | Flatten collection | __FLATTEN__ |  |
| 12 | RNA STAR | toolshed.g2.bx.psu.edu/repos/iuc/rgrnastar/rna_star/2.7.10b+galaxy3 |  |
| 13 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.73+galaxy0 |  |
| 14 | Concatenate datasets | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cat/0.1.1 |  |
| 15 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.11+galaxy1 |  |
| 16 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/1.1.2 | ($5 &gt; 0 &amp;&amp; $7 &gt; 2 &amp;&amp; $6==0) |
| 17 | Cut | Cut1 |  |
| 18 | Sort | sort1 |  |
| 19 | Unique | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sorted_uniq/1.1.0 |  |
| 20 | RNA STAR | toolshed.g2.bx.psu.edu/repos/iuc/rgrnastar/rna_star/2.7.10b+galaxy3 |  |
| 21 | Infer Experiment | toolshed.g2.bx.psu.edu/repos/nilesh/rseqc/rseqc_infer_experiment/5.0.1+galaxy2 |  |
| 22 | Junction Saturation | toolshed.g2.bx.psu.edu/repos/nilesh/rseqc/rseqc_junction_saturation/5.0.1+galaxy2 |  |
| 23 | Gene Body Coverage (BAM) | toolshed.g2.bx.psu.edu/repos/nilesh/rseqc/rseqc_geneBody_coverage/5.0.1+galaxy2 |  |
| 24 | Read Distribution | toolshed.g2.bx.psu.edu/repos/nilesh/rseqc/rseqc_read_distribution/5.0.1+galaxy2 |  |
| 25 | Junction Annotation | toolshed.g2.bx.psu.edu/repos/nilesh/rseqc/rseqc_junction_annotation/5.0.1+galaxy2 |  |
| 26 | StringTie | toolshed.g2.bx.psu.edu/repos/iuc/stringtie/stringtie/2.2.1+galaxy1 |  |
| 27 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.11+galaxy1 |  |
| 28 | StringTie merge | toolshed.g2.bx.psu.edu/repos/iuc/stringtie/stringtie_merge/2.2.1+galaxy1 |  |
| 29 | StringTie | toolshed.g2.bx.psu.edu/repos/iuc/stringtie/stringtie/2.2.1+galaxy1 |  |
| 30 | gffread | toolshed.g2.bx.psu.edu/repos/devteam/gffread/gffread/2.2.1.3+galaxy0 |  |
| 31 | Extract element identifiers | toolshed.g2.bx.psu.edu/repos/iuc/collection_element_identifiers/collection_element_identifiers/0.0.2 |  |
| 32 | Search in textfiles | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/1.1.1 |  |
| 33 | Filter collection | __FILTER_FROM_FILE__ |  |
| 34 | IsoformSwitchAnalyzeR | toolshed.g2.bx.psu.edu/repos/iuc/isoformswitchanalyzer/isoformswitchanalyzer/1.20.0+galaxy3 |  |
| 35 | IsoformSwitchAnalyzeR | toolshed.g2.bx.psu.edu/repos/iuc/isoformswitchanalyzer/isoformswitchanalyzer/1.20.0+galaxy3 |  |
| 36 | CPAT | toolshed.g2.bx.psu.edu/repos/bgruening/cpat/cpat/3.0.4+galaxy0 |  |
| 37 | PfamScan | toolshed.g2.bx.psu.edu/repos/bgruening/pfamscan/pfamscan/1.6+galaxy0 |  |
| 38 | Remove beginning | Remove beginning1 |  |
| 39 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/1.1.2 |  |
| 40 | Concatenate datasets | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cat/0.1.1 |  |
| 41 | IsoformSwitchAnalyzeR | toolshed.g2.bx.psu.edu/repos/iuc/isoformswitchanalyzer/isoformswitchanalyzer/1.20.0+galaxy3 |  |
| 42 | IsoformSwitchAnalyzeR | toolshed.g2.bx.psu.edu/repos/iuc/isoformswitchanalyzer/isoformswitchanalyzer/1.20.0+galaxy3 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run main_workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run main_workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run main_workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init main_workflow.ga -o job.yml`
- Lint: `planemo workflow_lint main_workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `main_workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
