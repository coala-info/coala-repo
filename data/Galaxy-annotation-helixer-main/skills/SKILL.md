---
name: genome-annotation-with-helixer
description: This workflow performs ab initio genome annotation on a masked FASTA sequence using the Helixer deep learning model and evaluates the resulting gene models through BUSCO, OMArk, and JBrowse visualization. Use this skill when you need to generate high-quality gene predictions for a newly sequenced genome without RNA-seq evidence and want to assess the completeness and consistency of the predicted proteome.
homepage: https://iwc.galaxyproject.org/
metadata:
  docker_image: "N/A"
---

# genome-annotation-with-helixer

## Overview

This workflow provides an automated pipeline for *ab initio* genome annotation using [Helixer](https://github.com/weberlab-hhu/Helixer), a deep-learning tool that predicts gene structures without the need for transcriptomic or protein evidence. By leveraging GPU-accelerated cross-species models, the workflow identifies UTRs, CDS, and introns to generate a comprehensive GFF3 annotation from a masked genome sequence.

To ensure high-quality results, the pipeline integrates several evaluation tools. [BUSCO](https://busco.ezlab.org/) is utilized to assess the completeness of both the genomic annotation and the predicted proteome. Additionally, [Genome Annotation Statistics](https://github.com/tanghaibao/jcvi) provides structural summaries and graphical analyses, while [OMArk](https://omark.omabrowser.org/) evaluates the consistency and potential contamination of the predicted protein sequences.

The workflow also handles downstream processing and visualization. [GFFRead](http://ccb.jhu.edu/software/stringtie/gffread.shtml) is used to extract protein sequences from the Helixer predictions, and an interactive [JBrowse](https://jbrowse.org/) instance is generated to allow for manual inspection of the gene models. This pipeline is particularly useful for rapid annotation of non-model organisms where evidence data may be limited.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Helixer lineage | parameter_input | Helixer lineage |
| 1 | Genome sequence masked | data_input | Genome sequence |
| 2 | BUSCO lineage | parameter_input | BUSCO lineage |


Ensure your genome sequence is in FASTA format and properly masked to optimize Helixer’s deep learning predictions. You must specify the correct Helixer and BUSCO lineages as parameters to ensure accurate gene model identification and quality assessment. While this workflow processes individual datasets, ensure all file types are correctly assigned in Galaxy before execution. For automated testing or command-line execution, you can initialize a job file using `planemo workflow_job_init`. Refer to the README.md for comprehensive details on parameter selection and data preparation.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Helixer | toolshed.g2.bx.psu.edu/repos/genouest/helixer/helixer/0.3.3+galaxy1 | Helixer tool for genomic annotation |
| 4 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.8.0+galaxy1 | Completeness assessment of the genome using the Busco tool |
| 5 | Genome annotation statistics | toolshed.g2.bx.psu.edu/repos/iuc/jcvi_gff_stats/jcvi_gff_stats/0.8.4 | Genome annotation statistics |
| 6 | JBrowse | toolshed.g2.bx.psu.edu/repos/iuc/jbrowse/jbrowse/1.16.11+galaxy1 | JBrowse |
| 7 | gffread | toolshed.g2.bx.psu.edu/repos/devteam/gffread/gffread/2.2.1.4+galaxy0 | Converts GFF files to other formats, such as FASTA |
| 8 | OMArk | toolshed.g2.bx.psu.edu/repos/iuc/omark/omark/0.3.1+galaxy1 | OMArk |
| 9 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.8.0+galaxy1 | Completeness assessment of the genome using the Busco tool |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | helixer output | output |
| 4 | busco table genome | busco_table |
| 4 | busco sum genome | busco_sum |
| 4 | busco missing genome | busco_missing |
| 4 | busco gff genome | busco_gff |
| 4 | summary image genome | summary_image |
| 5 | graphs | graphs |
| 5 | summary | summary |
| 6 | jbrowse | output |
| 7 | gffread peptides | output_pep |
| 8 | omark detail sum | omark_detail_sum |
| 8 | omark sum | omark_sum |
| 9 | busco image predicted proteins | summary_image |
| 9 | busco sum predicted proteins | busco_sum |
| 9 | busco gff predicted proteins | busco_gff |
| 9 | busco missing predicted proteins | busco_missing |
| 9 | busco table predicted proteins | busco_table |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-annotation_helixer.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-annotation_helixer.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-annotation_helixer.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-annotation_helixer.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-annotation_helixer.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-annotation_helixer.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)