---
name: lncrnas-annotation-workflow
description: "This workflow processes RNA-seq alignments, genome assemblies, and annotations using StringTie, gffread, and FEELnc to identify and classify long non-coding RNAs. Use this skill when you need to discover novel lncRNAs in a specific tissue or condition and want to integrate them into an existing genome annotation for comprehensive transcriptomic analysis."
homepage: https://workflowhub.eu/workflows/1324
---

# lncRNAs annotation workflow

## Overview

This workflow identifies and annotates long non-coding RNAs (lncRNAs) from RNA-seq data using the [FEELnc](https://github.com/tderrien/FEELnc) tool suite. It begins by assembling RNA-seq alignments into potential transcripts using [StringTie](https://ccb.jhu.edu/software/stringtie/) and standardizing genome annotations with [gffread](https://github.com/gpertea/gffread) to ensure compatibility across the pipeline.

The core analysis is performed by FEELnc, which filters transcripts to remove unwanted overlaps, evaluates coding potential to distinguish lncRNAs from protein-coding RNAs, and classifies the candidates based on their genomic location and transcriptional direction. This multi-step approach provides a rigorous identification of non-coding elements relative to the reference genome.

The workflow concludes by merging the newly identified lncRNA annotations with the original reference annotation. This results in a comprehensive, unified GTF file containing both mRNAs and lncRNAs, which is essential for downstream functional analysis or differential expression studies.

Derived from the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/), this tool is available under the [MIT License](https://opensource.org/licenses/MIT). It requires genome sequences (FASTA), RNA-seq alignments (BAM), and existing annotations (GFF3/GTF) as primary inputs.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | strandedness | parameter_input | strandednes |
| 1 | Genome assembly | data_input | Genome assembly |
| 2 | Genome annotation | data_input | Genome annotation |
| 3 | Alignments from RNA-seq | data_input | Alignments from RNA-seq |


Ensure your input RNA-seq alignments are in BAM format, while the genome assembly must be a FASTA file and the reference annotation provided in GFF3 or GTF. If you are processing multiple samples, consider using a dataset collection for the alignments to streamline the StringTie assembly step. You can use `planemo workflow_job_init` to generate a `job.yml` for automated testing and execution. Refer to the README.md for comprehensive details on file specifications and the multi-stage FEELnc classification process. One final check on the "strandedness" parameter is recommended to ensure accurate transcript assembly and lncRNA categorization.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | Map parameter value | toolshed.g2.bx.psu.edu/repos/iuc/map_param_value/map_param_value/0.2.0 | Map parameter value |
| 5 | gffread | toolshed.g2.bx.psu.edu/repos/devteam/gffread/gffread/2.2.1.4+galaxy0 | Protein sequences extracted from genomic annotation |
| 6 | StringTie | toolshed.g2.bx.psu.edu/repos/iuc/stringtie/stringtie/2.2.3+galaxy0 | StringTie is a fast, highly efficient assembler of RNA-Seq alignments into potential transcripts. |
| 7 | FEELnc | toolshed.g2.bx.psu.edu/repos/iuc/feelnc/feelnc/0.2.1+galaxy0 | The FEELnc pipeline identifies and classifies long non-coding RNAs (lncRNAs) through three main steps: filter, codpot and classifier. |
| 8 | Concatenate datasets | cat1 | The lncRNA annotation is merged with the reference annotation to create a unified genome annotation containing both mRNAs and lncRNAs. |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | annotation | output_gtf |
| 6 | stringtie gtf | output_gtf |
| 7 | candidate mRNA | candidate_mRNA |
| 7 | classification | classifier |
| 7 | candidate lncRNA | candidate_lncRNA |
| 8 | annotation final | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-lncRNAs_annotation_workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-lncRNAs_annotation_workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-lncRNAs_annotation_workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-lncRNAs_annotation_workflow.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-lncRNAs_annotation_workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-lncRNAs_annotation_workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
