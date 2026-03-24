---
name: functional-annotation-of-protein-sequences
description: "This Galaxy workflow performs comprehensive functional annotation of protein sequences in FASTA format using eggNOG-mapper and InterProScan to identify ortholog groups, protein domains, and motifs. Use this skill when you need to characterize the biological roles of novel or unannotated proteins by assigning Gene Ontology terms, KEGG pathways, and functional signatures across any organism."
homepage: https://workflowhub.eu/workflows/1262
---

# Functional annotation of protein sequences

## Overview

This workflow provides a comprehensive functional annotation of protein sequences by integrating two industry-standard tools: [eggNOG-mapper](https://toolshed.g2.bx.psu.edu/repos/galaxyp/eggnog_mapper/eggnog_mapper/2.1.8+galaxy4) and [InterProScan](https://toolshed.g2.bx.psu.edu/repos/bgruening/interproscan/interproscan/5.59-91.0+galaxy3). It is designed to process protein FASTA files from any organism, assigning biological context through orthology assignment and protein signature recognition.

The process begins by comparing sequences against the [eggNOG database](http://eggnog5.embl.de/) to transfer functional metadata—such as Gene Ontology (GO) terms, KEGG pathways, and EC numbers—from known orthologous groups. Simultaneously, InterProScan scans the sequences for known domains and motifs across multiple member databases, identifying structural signatures and functional sites.

The workflow generates detailed tabular and XML outputs. These results include predicted protein names, metabolic pathway identifiers, and precise coordinates for identified protein domains. This dual-method approach ensures a robust characterization of unknown proteins, facilitating downstream comparative genomics and systems biology research.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | input | data_input | This workflow uses eggNOG mapper and Interproscan for functional annotation of protein sequences. |


Provide a protein sequence file in FASTA format as the primary input, ensuring headers are unique and compatible with downstream parsing. For large-scale analyses, consider using a dataset collection to process multiple proteomes simultaneously through the eggNOG Mapper and InterProScan steps. Refer to the README.md for comprehensive details on interpreting the specific columns of the resulting tabular and XML functional annotations. You can use `planemo workflow_job_init` to generate a `job.yml` for automated execution. Ensure all reference databases for InterProScan and eggNOG are correctly indexed on your Galaxy instance before launching the workflow.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | InterProScan | toolshed.g2.bx.psu.edu/repos/bgruening/interproscan/interproscan/5.59-91.0+galaxy3 | InterProScan is a tool that analyses each protein sequence from our annotation to determine if they contain one or several of the signatures from InterPro. |
| 2 | eggNOG Mapper | toolshed.g2.bx.psu.edu/repos/galaxyp/eggnog_mapper/eggnog_mapper/2.1.8+galaxy4 | EggNOG Mapper compares each protein sequence of the annotation to a huge set of ortholog groups from the EggNOG database. |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | interproscan xml | outfile_xml |
| 1 | interproscan tabular | outfile_tsv |
| 2 | eggNOG Mapper annotations | annotations |
| 2 | eggNOG Mapper seed_orthologs | seed_orthologs |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Functional_annotation_of_protein_sequences.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Functional_annotation_of_protein_sequences.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Functional_annotation_of_protein_sequences.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Functional_annotation_of_protein_sequences.ga -o job.yml`
- Lint: `planemo workflow_lint Functional_annotation_of_protein_sequences.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Functional_annotation_of_protein_sequences.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
