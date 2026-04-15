---
name: obitools-edna-metabarcoding
description: This workflow processes paired-end environmental DNA sequencing data using the OBITools suite and NCBI BLAST+ to perform sequence assembly, quality filtering, and taxonomic assignment. Use this skill when you need to characterize biodiversity from environmental samples by converting raw metabarcoding reads into filtered taxonomic abundance tables while removing sequencing errors and PCR artifacts.
homepage: https://www.pndb.fr/
metadata:
  docker_image: "N/A"
---

# obitools-edna-metabarcoding

## Overview

This workflow implements the [OBITools](https://metabarcoding.org/obitools) suite within Galaxy to process environmental DNA (eDNA) metabarcoding data. It begins by ingesting raw sequencing data, merging paired-end Illumina reads using `illuminapairedend`, and performing initial quality control and formatting via FastQC and FASTQ Groomer.

The core processing pipeline involves demultiplexing samples with `NGSfilter` to identify primers and tags, followed by dereplication using `obiuniq` to collapse identical sequences. The data is then refined through a series of `obigrep` and `obiclean` steps, which filter sequences by length or quality and denoise the dataset by identifying potential PCR chimeras or sequencing errors.

For biological interpretation, the workflow utilizes `NCBI BLAST+ blastn` to assign taxonomic identities to the filtered sequences. The final stages convert OBITools-specific outputs into standard tabular formats using `obitab`, followed by data joining and attribute filtering to produce a clean, annotated sequence table ready for ecological analysis.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | wolf_tutorial.zip?download=1 | data_input |  |


Ensure the input ZIP archive contains your raw paired-end FASTQ files along with the mandatory NGSfilter sample description file formatted as a tab-separated text file. While this specific workflow processes a single compressed dataset, ensure all sequence data is groomed to the Sanger FASTQ format to maintain compatibility with the OBITools suite. Detailed instructions on metadata formatting and specific tool parameters are provided in the README.md file. For streamlined execution and testing, you can use `planemo workflow_job_init` to generate a `job.yml` file for your environment.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Illuminapairedend | toolshed.g2.bx.psu.edu/repos/iuc/obi_illumina_pairend/obi_illumina_pairend/1.2.13 |  |
| 2 | Unzip | toolshed.g2.bx.psu.edu/repos/imgteam/unzip/unzip/0.2 |  |
| 3 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.73+galaxy0 |  |
| 4 | FASTQ Groomer | toolshed.g2.bx.psu.edu/repos/devteam/fastq_groomer/fastq_groomer/1.1.5 |  |
| 5 | obigrep | toolshed.g2.bx.psu.edu/repos/iuc/obi_grep/obi_grep/1.2.13 |  |
| 6 | Line/Word/Character count | wc_gnu |  |
| 7 | Line/Word/Character count | wc_gnu |  |
| 8 | NGSfilter | toolshed.g2.bx.psu.edu/repos/iuc/obi_ngsfilter/obi_ngsfilter/1.2.13 |  |
| 9 | obiuniq | toolshed.g2.bx.psu.edu/repos/iuc/obi_uniq/obi_uniq/1.2.13 |  |
| 10 | obiannotate | toolshed.g2.bx.psu.edu/repos/iuc/obi_annotate/obi_annotate/1.2.13 |  |
| 11 | obistat | toolshed.g2.bx.psu.edu/repos/iuc/obi_stat/obi_stat/1.2.13 |  |
| 12 | obigrep | toolshed.g2.bx.psu.edu/repos/iuc/obi_grep/obi_grep/1.2.13 |  |
| 13 | obigrep | toolshed.g2.bx.psu.edu/repos/iuc/obi_grep/obi_grep/1.2.13 |  |
| 14 | obiclean | toolshed.g2.bx.psu.edu/repos/iuc/obi_clean/obi_clean/1.2.13 |  |
| 15 | NCBI BLAST+ blastn | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_blastn_wrapper/2.10.1+galaxy0 |  |
| 16 | Filter sequences by ID | toolshed.g2.bx.psu.edu/repos/peterjc/seq_filter_by_id/seq_filter_by_id/0.2.7 |  |
| 17 | Filter sequences by ID | toolshed.g2.bx.psu.edu/repos/peterjc/seq_filter_by_id/seq_filter_by_id/0.2.7 |  |
| 18 | obitab | toolshed.g2.bx.psu.edu/repos/iuc/obi_tab/obi_tab/1.2.13 |  |
| 19 | obitab | toolshed.g2.bx.psu.edu/repos/iuc/obi_tab/obi_tab/1.2.13 |  |
| 20 | Join two Datasets | join1 |  |
| 21 | Join two Datasets | join1 |  |
| 22 | Cut | Cut1 |  |
| 23 | Filter | Filter1 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Obitools_eDNA_metabarcoding.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Obitools_eDNA_metabarcoding.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Obitools_eDNA_metabarcoding.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Obitools_eDNA_metabarcoding.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Obitools_eDNA_metabarcoding.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Obitools_eDNA_metabarcoding.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)