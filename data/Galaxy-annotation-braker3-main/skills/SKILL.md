---
name: genome-annotation-with-braker3
description: This workflow automates eukaryotic genome annotation by integrating soft-masked sequences, RNA-seq alignments, and protein evidence using Braker3, followed by quality assessment with BUSCO and OMArk. Use this skill when you need to predict high-precision gene structures in a novel genome assembly and validate the completeness of the resulting protein-coding gene models.
homepage: https://iwc.galaxyproject.org/
metadata:
  docker_image: "N/A"
---

# genome-annotation-with-braker3

## Overview

This workflow provides an automated pipeline for eukaryotic genome annotation using [BRAKER3](https://toolshed.g2.bx.psu.edu/repos/genouest/braker3/braker3/3.0.8+galaxy2). By integrating GeneMark-ETP and AUGUSTUS, the system leverages both RNA-seq alignments and protein sequence evidence to generate high-precision gene models. It is designed to produce a final consensus annotation supported by extrinsic experimental data, making it suitable for non-model organisms.

To ensure the reliability of the results, the workflow incorporates comprehensive quality assessment tools. It utilizes [BUSCO](https://toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.8.0+galaxy1) to evaluate the completeness of both the initial genome and the predicted proteome. Additionally, [OMArk](https://toolshed.g2.bx.psu.edu/repos/iuc/omark/omark/0.3.1+galaxy1) provides detailed proteomic statistics, helping researchers validate the biological accuracy of the predicted gene structures.

Beyond the raw annotation, the pipeline uses [gffread](https://toolshed.g2.bx.psu.edu/repos/devteam/gffread/gffread/2.2.1.4+galaxy0) to extract protein sequences for downstream functional analysis. The final results are packaged into a [JBrowse](https://toolshed.g2.bx.psu.edu/repos/iuc/jbrowse/jbrowse/1.16.11+galaxy1) interactive browser, allowing for seamless visualization of gene models against the genomic background. For detailed setup instructions and input requirements, refer to the [README.md](README.md) in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | BUSCO database | parameter_input | BUSCO database |
| 1 | Include BUSCO | parameter_input | By selecting yes, BUSCO analyses will be performed on the genome and predicted protein sequences. |
| 2 | BUSCO lineage | parameter_input | BUSCO lineage |
| 3 | Soft masked Genome sequence | data_input | Genome sequence |
| 4 | Alignments from RNA-seq | data_input | Alignments from RNA-seq |
| 5 | Protein sequences | data_input | Protein sequences |
| 6 | Fungus genome | parameter_input | If your genome is a fungus, would you like to use the --fungus parameter for Braker3 analyses? |


Ensure your input genome is in soft-masked FASTA format, while protein evidence should be provided as a FASTA file and RNA-seq alignments as a BAM file. When configuring the workflow, verify that the BUSCO lineage matches your target organism and specify if the genome is fungal to optimize the GeneMark-ETP parameters. For large-scale analyses, consider using dataset collections for protein or RNA-seq inputs to streamline processing. Refer to the README.md for comprehensive details on file preparation and parameter settings. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 7 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.8.0+galaxy1 | Completeness assessment of the genome using the Busco tool |
| 8 | BRAKER3 | toolshed.g2.bx.psu.edu/repos/genouest/braker3/braker3/3.0.8+galaxy2 | Annotation step with Braker3 |
| 9 | JBrowse | toolshed.g2.bx.psu.edu/repos/iuc/jbrowse/jbrowse/1.16.11+galaxy1 | JBrowse |
| 10 | gffread | toolshed.g2.bx.psu.edu/repos/devteam/gffread/gffread/2.2.1.4+galaxy0 | Converts GFF files to other formats, such as FASTA |
| 11 | OMArk | toolshed.g2.bx.psu.edu/repos/iuc/omark/omark/0.3.1+galaxy1 | OMArk |
| 12 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.8.0+galaxy1 | Completeness assessment of the genome using the Busco tool |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 7 | BUSCO Summary Image (Genome) | summary_image |
| 7 | BUSCO GFF (Genome) | busco_gff |
| 7 | BUSCO Missing Genes (Genome) | busco_missing |
| 7 | BUSCO Table (Genome) | busco_table |
| 7 | BUSCO Summary (Genome) | busco_sum |
| 8 | Braker3 Annotation GFF | output_gff |
| 9 | JBrowse Genome Browser | output |
| 10 | Predicted Proteins | output_pep |
| 11 | OMArk Summary | omark_sum |
| 11 | OMArk Detailed Summary | omark_detail_sum |
| 12 | BUSCO Missing Genes (Predicted Proteins) | busco_missing |
| 12 | BUSCO Summary Image (Predicted Proteins) | summary_image |
| 12 | BUSCO GFF (Predicted Proteins) | busco_gff |
| 12 | BUSCO Summary (Predicted Proteins) | busco_sum |
| 12 | BUSCO Table (Predicted Proteins) | busco_table |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Genome_annotation_with_braker3.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Genome_annotation_with_braker3.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Genome_annotation_with_braker3.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Genome_annotation_with_braker3.ga -o job.yml`
- Lint: `planemo workflow_lint Genome_annotation_with_braker3.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Genome_annotation_with_braker3.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)