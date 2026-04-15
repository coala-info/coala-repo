---
name: funannotate
description: This Galaxy workflow performs comprehensive structural and functional genome annotation using a genome assembly, RNA-seq data, and protein evidence through tools like STAR, Funannotate, eggNOG-mapper, and InterProScan. Use this skill when you need to identify gene models in a newly assembled fungal or eukaryotic genome and assign biological functions to the predicted proteins for downstream comparative genomics.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# funannotate

## Overview

This workflow provides a comprehensive pipeline for the structural and functional annotation of genomes using the Funannotate suite. It begins by processing raw genomic and transcriptomic data, utilizing [RNA STAR](https://toolshed.g2.bx.psu.edu/repos/iuc/rgrnastar/rna_star/2.7.10b+galaxy3) to align RNASeq reads against the assembly. These alignments, combined with protein evidence sequences, serve as the foundation for [Funannotate predict](https://toolshed.g2.bx.psu.edu/repos/iuc/funannotate_predict/funannotate_predict/1.8.15+galaxy0) to generate initial gene models and structural predictions.

To refine these models with biological context, the workflow incorporates functional characterization through [eggNOG Mapper](https://toolshed.g2.bx.psu.edu/repos/galaxyp/eggnog_mapper/eggnog_mapper/2.1.8+galaxy3) and [InterProScan](https://toolshed.g2.bx.psu.edu/repos/bgruening/interproscan/interproscan/5.59-91.0+galaxy3). The results are integrated by [Funannotate functional](https://toolshed.g2.bx.psu.edu/repos/iuc/funannotate_annotate/funannotate_annotate/1.8.15+galaxy0) to produce standardized outputs, including GFF3, GenBank files, and protein/nucleotide sequences formatted for NCBI submission.

The final stage focuses on quality control and visualization. The workflow assesses annotation completeness using [Busco](https://toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.4.6+galaxy0) and performs comparative analysis via [Funannotate compare](https://toolshed.g2.bx.psu.edu/repos/iuc/funannotate_compare/funannotate_compare/1.8.15+galaxy0) and [AEGeAn ParsEval](https://toolshed.g2.bx.psu.edu/repos/iuc/aegean_parseval/aegean_parseval/0.16.0). For interactive exploration, it generates a [JBrowse](https://toolshed.g2.bx.psu.edu/repos/iuc/jbrowse/jbrowse/1.16.11+galaxy1) instance, allowing researchers to visually inspect the annotated genomic features.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Genome assembly | data_input | The genome sequence that you wish to annotate, in fasta format. It needs to be soft masked beforehand. |
| 1 | RNASeq reads forward | data_input | Some RNASeq data, forward reads, in fastq format |
| 2 | RNASeq reads reverse | data_input | Some RNASeq data, reverse reads, in fastq format |
| 3 | Protein evidence sequences | data_input | Some protein sequences to align on the genome to help annotation |
| 4 | NCBI submission template | data_input | A submission template retrieved from NCBI (generate it on https://submit.ncbi.nlm.nih.gov/genbank/template/submission/) |
| 5 | Alternate annotation gbk | data_input | The genbank output of an alternate annotation (for comparison) |
| 6 | Alternate annotation gff3 | data_input | The gff3 output of an alternate annotation (for comparison) |


Ensure your genome assembly is in FASTA format and provide RNA-seq reads as fastqsanger paired-end collections to streamline the STAR mapping step. Protein evidence and alternate annotations should be supplied as FASTA and GFF3/GBK files respectively, while the NCBI submission template must be a valid .sbt file. For automated execution, you can initialize a job configuration using `planemo workflow_job_init` to generate a `job.yml` file. Refer to the README.md for comprehensive details on parameter tuning and specific database requirements for functional annotation. One should verify that all input datasets are correctly tagged to ensure seamless tool integration throughout the Funannotate pipeline.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 7 | RNA STAR | toolshed.g2.bx.psu.edu/repos/iuc/rgrnastar/rna_star/2.7.10b+galaxy3 |  |
| 8 | Funannotate predict annotation | toolshed.g2.bx.psu.edu/repos/iuc/funannotate_predict/funannotate_predict/1.8.15+galaxy0 |  |
| 9 | eggNOG Mapper | toolshed.g2.bx.psu.edu/repos/galaxyp/eggnog_mapper/eggnog_mapper/2.1.8+galaxy3 |  |
| 10 | InterProScan | toolshed.g2.bx.psu.edu/repos/bgruening/interproscan/interproscan/5.59-91.0+galaxy3 |  |
| 11 | Funannotate functional | toolshed.g2.bx.psu.edu/repos/iuc/funannotate_annotate/funannotate_annotate/1.8.15+galaxy0 |  |
| 12 | JBrowse | toolshed.g2.bx.psu.edu/repos/iuc/jbrowse/jbrowse/1.16.11+galaxy1 |  |
| 13 | Funannotate compare | toolshed.g2.bx.psu.edu/repos/iuc/funannotate_compare/funannotate_compare/1.8.15+galaxy0 |  |
| 14 | AEGeAn ParsEval | toolshed.g2.bx.psu.edu/repos/iuc/aegean_parseval/aegean_parseval/0.16.0 |  |
| 15 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.4.6+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 7 | Mapped RNASeq | mapped_reads |
| 8 | fasta_proteins | fasta_proteins |
| 9 | annotations | annotations |
| 10 | outfile_tsv | outfile_tsv |
| 11 | Final annotation (genbank) | gbk |
| 11 | Final annotation (CDS sequences) | fa_transcripts_cds |
| 11 | Final annotation (mRNA sequences) | fa_transcripts_mrna |
| 11 | Final annotation (protein sequences) | fa_proteins |
| 11 | tbl2asn_report | tbl2asn_report |
| 11 | stats | stats |
| 11 | Final annotation (GFF3) | gff3 |
| 12 | JBrowse | output |
| 13 | Funannotate compare report | output |
| 14 | AEGeAN report | output_html |
| 15 | Busco summary | busco_sum |
| 15 | Busco image | summary_image |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run funannotate.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run funannotate.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run funannotate.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init funannotate.ga -o job.yml`
- Lint: `planemo workflow_lint funannotate.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `funannotate.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)