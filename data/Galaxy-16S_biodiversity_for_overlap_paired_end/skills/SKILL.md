---
name: 16s_biodiversity_for_overlap_paired_end
description: This Galaxy workflow processes paired-end 16S metagenomic dataset collections through quality control, read merging with Pear, and OTU clustering with VSearch to perform differential abundance and biodiversity analysis using Phyloseq and DESeq2. Use this skill when you need to identify taxonomic shifts between microbial communities, calculate alpha and beta diversity metrics, or detect differentially abundant taxa in overlapping paired-end sequencing data.
homepage: https://www.qcif.edu.au/
metadata:
  docker_image: "N/A"
---

# 16s_biodiversity_for_overlap_paired_end

## Overview

This workflow, part of the [MetaDEGalaxy](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6807170/) suite, is designed for the differential abundance analysis of 16S rRNA metagenomic data using paired-end reads. It provides an end-to-end pipeline that transitions from raw sequencing data to comprehensive biodiversity visualizations and statistical assessments.

The initial stages focus on quality control and sequence refinement using tools like FastQC, Trimmomatic, and Pear to merge overlapping paired-end reads. Following preprocessing, the workflow utilizes the VSearch suite for dereplication, chimera detection, and OTU clustering. This ensures that the downstream analysis is based on high-quality, representative sequences filtered for artifacts.

The final phase converts processed data into BIOM format for advanced ecological analysis. It integrates Phyloseq and DESeq2 to perform differential abundance testing, richness estimation, and taxonomic profiling. The workflow generates several visual outputs, including abundance plots, symmetric plots, and network visualizations, to facilitate the interpretation of microbial community structures.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | "Input Dataset Collection" | data_collection_input |  |


For this workflow, ensure your paired-end 16S rRNA sequence data is organized into a paired dataset collection of fastqsanger files to maintain sample associations through the Trimmomatic and PEAR processing steps. You should also prepare a metadata mapping file in tabular format for the BIOM and Phyloseq downstream analysis steps to correctly group samples for differential abundance. Refer to the README.md for specific formatting requirements regarding the taxonomy database and metadata columns. For automated execution and testing, you can initialize a job configuration using `planemo workflow_job_init` to generate a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 2 | Trimmomatic | toolshed.g2.bx.psu.edu/repos/pjbriggs/trimmomatic/trimmomatic/0.36.6 |  |
| 3 | Pear | toolshed.g2.bx.psu.edu/repos/iuc/pear/iuc_pear/0.9.6.1 |  |
| 4 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 5 | Concatenate datasets | cat1 |  |
| 6 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.17.1 |  |
| 7 | MergeSamFiles | toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_MergeSamFiles/2.18.2.1 |  |
| 8 | FilterSamReads | toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_FilterSamReads/2.18.2.1 |  |
| 9 | Samtools fastx | toolshed.g2.bx.psu.edu/repos/iuc/samtools_fastx/samtools_fastx/1.9+galaxy1 |  |
| 10 | VSearch search | toolshed.g2.bx.psu.edu/repos/iuc/vsearch/vsearch_search/2.8.3.1 |  |
| 11 | VSearch dereplication | toolshed.g2.bx.psu.edu/repos/iuc/vsearch/vsearch_dereplication/2.8.3.0 |  |
| 12 | VSearch chimera detection | toolshed.g2.bx.psu.edu/repos/iuc/vsearch/vsearch_chimera_detection/2.8.3.0 |  |
| 13 | VSearch clustering | toolshed.g2.bx.psu.edu/repos/iuc/vsearch/vsearch_clustering/2.8.3.0 |  |
| 14 | VSearch search | toolshed.g2.bx.psu.edu/repos/iuc/vsearch/vsearch_search/2.8.3.1 |  |
| 15 | Add column | addValue |  |
| 16 | Cut | Cut1 |  |
| 17 | Cut | Cut1 |  |
| 18 | Concatenate datasets | cat1 |  |
| 19 | OTUTable | toolshed.g2.bx.psu.edu/repos/qfabrepo/metadegalaxy_uc2otutable/uclust2otutable/1.0.0 |  |
| 20 | Convert | toolshed.g2.bx.psu.edu/repos/iuc/biom_convert/biom_convert/2.1.5.3 |  |
| 21 | BIOM metadata | toolshed.g2.bx.psu.edu/repos/iuc/biom_add_metadata/biom_add_metadata/2.1.5.0 |  |
| 22 | Phyloseq DESeq2 | toolshed.g2.bx.psu.edu/repos/qfabrepo/metadegalaxy_phyloseq_deseq2/phyloseq_DESeq2/1.22.3 |  |
| 23 | Phyloseq Richness | toolshed.g2.bx.psu.edu/repos/qfabrepo/metadegalaxy_phyloseq_richness/phyloseq_richness/1.22.3.2 |  |
| 24 | Phyloseq Abundance plot | toolshed.g2.bx.psu.edu/repos/qfabrepo/metadegalaxy_phyloseq_abundance_factor/phyloseq_abundance/1.22.3.3 |  |
| 25 | Phyloseq Abundance Taxonomy | toolshed.g2.bx.psu.edu/repos/qfabrepo/metadegalaxy_phyloseq_abundance_taxonomy/phyloseq_taxonomy/1.22.3.3 |  |
| 26 | Symmetric Plot | toolshed.g2.bx.psu.edu/repos/qfabrepo/metadegalaxy_symmetric_plot/symmetricPlot/1.0.1 |  |
| 27 | Phyloseq Network Plot | toolshed.g2.bx.psu.edu/repos/qfabrepo/metadegalaxy_phyloseq_net/phyloseq_net/1.24.2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | assembled_reads | assembled_reads |
| 5 | out_file1 | out_file1 |
| 6 | bam_output | bam_output |
| 7 | outFile | outFile |
| 8 | outFile | outFile |
| 9 | output | output |
| 10 | uc | uc |
| 10 | notmatched | notmatched |
| 11 | outfile | outfile |
| 12 | nonchimeras | nonchimeras |
| 13 | consout | consout |
| 14 | uc | uc |
| 15 | out_file1 | out_file1 |
| 16 | out_file1 | out_file1 |
| 17 | out_file1 | out_file1 |
| 18 | out_file1 | out_file1 |
| 19 | output | output |
| 20 | output_fp | output_fp |
| 21 | output_table | output_table |
| 22 | normalised_table | normalised_table |
| 23 | htmlfile | htmlfile |
| 24 | htmlfile | htmlfile |
| 25 | htmlfile | htmlfile |
| 26 | htmlfile | htmlfile |
| 27 | htmlfile | htmlfile |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run 16S_biodiversity_for_overlap_paired_end.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run 16S_biodiversity_for_overlap_paired_end.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run 16S_biodiversity_for_overlap_paired_end.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init 16S_biodiversity_for_overlap_paired_end.ga -o job.yml`
- Lint: `planemo workflow_lint 16S_biodiversity_for_overlap_paired_end.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `16S_biodiversity_for_overlap_paired_end.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)