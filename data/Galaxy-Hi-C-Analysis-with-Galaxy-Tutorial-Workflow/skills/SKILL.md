---
name: hi-c-analysis-with-galaxy-tutorial-workflow
description: This epigenetics workflow processes raw Hi-C sequencing reads and reference genomes using Bowtie2 and HiCExplorer to build contact matrices, identify Topologically Associating Domains, and detect chromatin loops. Use this skill when you need to characterize the three-dimensional architecture of the genome or investigate how chromatin folding and spatial interactions relate to gene regulation and epigenetic features.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# hi-c-analysis-with-galaxy-tutorial-workflow

## Overview

This workflow implements the [Hi-C analysis of Drosophila melanogaster cells](https://training.galaxyproject.org/training-material/topics/epigenetics/tutorials/hicexplorer/tutorial.html) tutorial from the Galaxy Training Network (GTN). It provides a comprehensive pipeline for processing raw Hi-C sequencing data to explore the 3D organization of the genome, specifically focusing on chromatin interactions and epigenetic features in *Drosophila*.

The pipeline begins by aligning paired-end FASTQ reads to the dm3 reference genome using [Bowtie2](https://bowtie-bio.sourceforge.net/bowtie2/index.shtml). It then utilizes the [HiCExplorer](https://hicexplorer.readthedocs.io/) suite to identify restriction sites, build initial contact matrices, and perform matrix correction and bin merging. These steps ensure the data is normalized and formatted correctly for high-resolution structural analysis.

Advanced analysis steps include the identification of Topologically Associating Domains (TADs), Principal Component Analysis (PCA) for A/B compartment detection, and long-range loop calling. The workflow concludes with sophisticated visualization using `hicPlotMatrix` and [pyGenomeTracks](https://github.com/deeptools/pyGenomeTracks), allowing users to overlay contact maps with gene annotations and histone marks such as H3K36me3 and H3K27me3.

This resource is licensed under CC-BY-4.0 and is tagged for use in Epigenetics and GTN-related training contexts.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | HiC_S2_1p_10min_lowU_R1.fastq.gz | data_input |  |
| 1 | HiC_S2_1p_10min_lowU_R2.fastq.gz | data_input |  |
| 2 | dm3_genome.fasta | data_input |  |
| 3 | GM12878_25kb_cooler_coarsen.cool | data_input |  |
| 4 | corrected_contact_matrix_dm3_large.h5 | data_input |  |
| 5 | H3K36me3.bw | data_input |  |
| 6 | H3K27me3.bw | data_input |  |
| 7 | H4K16ac.bw | data_input |  |
| 8 | dm3_genes.bed | data_input |  |


Ensure your input files are correctly formatted as fastq.gz for sequencing reads, fasta for the reference genome, and bed/bigWig for genomic features. While this workflow uses individual datasets, you may consider organizing paired-end reads into a dataset collection for larger scale analyses. Contact matrices should be provided in .h5 or .cool formats to ensure compatibility with HiCExplorer tools. For automated execution, you can initialize your environment using `planemo workflow_job_init` to generate a `job.yml` file. Refer to the README.md for comprehensive details on parameter settings and data preparation.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 9 | Bowtie2 | toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.5.3+galaxy1 |  |
| 10 | Bowtie2 | toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.5.3+galaxy1 |  |
| 11 | hicFindRestSite | toolshed.g2.bx.psu.edu/repos/bgruening/hicexplorer_hicfindrestrictionsites/hicexplorer_hicfindrestrictionsites/3.7.6+galaxy1 |  |
| 12 | hicInfo | toolshed.g2.bx.psu.edu/repos/bgruening/hicexplorer_hicinfo/hicexplorer_hicinfo/3.7.6+galaxy1 |  |
| 13 | hicDetectLoops | toolshed.g2.bx.psu.edu/repos/bgruening/hicexplorer_hicdetectloops/hicexplorer_hicdetectloops/3.7.6+galaxy1 |  |
| 14 | hicInfo | toolshed.g2.bx.psu.edu/repos/bgruening/hicexplorer_hicinfo/hicexplorer_hicinfo/3.7.6+galaxy1 |  |
| 15 | hicPCA | toolshed.g2.bx.psu.edu/repos/bgruening/hicexplorer_hicpca/hicexplorer_hicpca/3.6+galaxy1 |  |
| 16 | hicFindTADs | toolshed.g2.bx.psu.edu/repos/bgruening/hicexplorer_hicfindtads/hicexplorer_hicfindtads/3.7.6+galaxy1 |  |
| 17 | hicBuildMatrix | toolshed.g2.bx.psu.edu/repos/bgruening/hicexplorer_hicbuildmatrix/hicexplorer_hicbuildmatrix/3.7.6+galaxy1 |  |
| 18 | hicPlotMatrix | toolshed.g2.bx.psu.edu/repos/bgruening/hicexplorer_hicplotmatrix/hicexplorer_hicplotmatrix/3.7.6+galaxy1 |  |
| 19 | hicPlotMatrix | toolshed.g2.bx.psu.edu/repos/bgruening/hicexplorer_hicplotmatrix/hicexplorer_hicplotmatrix/3.7.6+galaxy1 |  |
| 20 | hicPlotMatrix | toolshed.g2.bx.psu.edu/repos/bgruening/hicexplorer_hicplotmatrix/hicexplorer_hicplotmatrix/3.7.6+galaxy1 |  |
| 21 | pyGenomeTracks | toolshed.g2.bx.psu.edu/repos/iuc/pygenometracks/pygenomeTracks/3.8+galaxy2 |  |
| 22 | hicCorrectMatrix | toolshed.g2.bx.psu.edu/repos/bgruening/hicexplorer_hiccorrectmatrix/hicexplorer_hiccorrectmatrix/3.7.6+galaxy1 |  |
| 23 | hicMergeMatrixBins | toolshed.g2.bx.psu.edu/repos/bgruening/hicexplorer_hicmergematrixbins/hicexplorer_hicmergematrixbins/3.7.6+galaxy1 |  |
| 24 | hicCorrectMatrix | toolshed.g2.bx.psu.edu/repos/bgruening/hicexplorer_hiccorrectmatrix/hicexplorer_hiccorrectmatrix/3.7.6+galaxy1 |  |
| 25 | hicPlotMatrix | toolshed.g2.bx.psu.edu/repos/bgruening/hicexplorer_hicplotmatrix/hicexplorer_hicplotmatrix/3.7.6+galaxy1 |  |
| 26 | hicPlotMatrix | toolshed.g2.bx.psu.edu/repos/bgruening/hicexplorer_hicplotmatrix/hicexplorer_hicplotmatrix/3.7.6+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run hi-c-analysis-with-galaxy-tutorial-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run hi-c-analysis-with-galaxy-tutorial-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run hi-c-analysis-with-galaxy-tutorial-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init hi-c-analysis-with-galaxy-tutorial-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint hi-c-analysis-with-galaxy-tutorial-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `hi-c-analysis-with-galaxy-tutorial-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)