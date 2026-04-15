---
name: identification-of-the-binding-sites-of-the-estrogen-receptor
description: This epigenetics workflow analyzes ChIP-seq BAM files from treatment and control samples to identify Estrogen Receptor binding sites using MACS2 peak calling and deepTools for quality control and visualization. Use this skill when you need to characterize the genomic distribution of transcription factor binding sites and compare epigenetic profiles between patient groups with different clinical outcomes.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# identification-of-the-binding-sites-of-the-estrogen-receptor

## Overview

This Galaxy workflow is designed to identify Estrogen Receptor (ER) binding sites by analyzing ChIP-seq data from patients with different clinical outcomes (good vs. poor). It processes paired ChIP and input control BAM files alongside reference gene annotations to map the epigenetic landscape and determine how ER binding profiles correlate with patient prognosis.

The pipeline begins with comprehensive quality control and signal normalization using [samtools](https://www.htslib.org/) and [deepTools](https://deeptools.readthedocs.io/). It assesses read distribution via `idxstats`, evaluates library enrichment with `plotFingerprint`, and accounts for potential sequencing artifacts by computing GC bias. To isolate the true biological signal, the workflow generates normalized coverage tracks and performs sample-versus-control comparisons using `bamCompare`.

Peak calling is executed via [MACS2](https://github.com/macs3-project/MACS), which identifies specific genomic regions of enrichment. The workflow concludes with advanced visualization and comparative analysis, utilizing `multiBamSummary` and `computeMatrix` to generate correlation plots and heatmaps. These outputs allow researchers to visualize the intensity and distribution of ER binding across different patient cohorts, making it a valuable tool for [Epigenetics](https://training.galaxyproject.org/training-material/topics/epigenetics/) research and GTN-based training.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | patient1_ChIP_ER_good_outcome.bam | data_input |  |
| 1 | patient2_ChIP_ER_good_outcome.bam | data_input |  |
| 2 | patient3_ChIP_ER_poor_outcome.bam | data_input |  |
| 3 | patient4_ChIP_ER_poor_outcome.bam | data_input |  |
| 4 | patient1_input_good_outcome.bam | data_input |  |
| 5 | patient2_input_good_outcome.bam | data_input |  |
| 6 | patient3_input_poor_outcome.bam | data_input |  |
| 7 | patient4_input_poor_outcome.bam | data_input |  |
| 8 | UCSC Main on Human: refGene (chr11:1-134452384) | data_input |  |


Ensure all ChIP and control samples are provided in BAM format with associated indices, while the reference gene model should be uploaded as a GTF or BED file. Organizing these individual datasets into collections based on patient outcome will significantly streamline the comparative analysis across the multiple samples and conditions. Consult the README.md for comprehensive instructions on metadata assignment and specific parameter requirements for each input. You can use `planemo workflow_job_init` to create a `job.yml` template for configuring these inputs programmatically.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 9 | IdxStats | toolshed.g2.bx.psu.edu/repos/devteam/samtools_idxstats/samtools_idxstats/2.0.1 |  |
| 10 | bamCoverage | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_bam_coverage/deeptools_bam_coverage/2.5.1.1.0 |  |
| 11 | bamCoverage | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_bam_coverage/deeptools_bam_coverage/2.5.1.1.0 |  |
| 12 | plotFingerprint | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_plot_fingerprint/deeptools_plot_fingerprint/2.5.1.1.0 |  |
| 13 | computeGCBias | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_compute_gc_bias/deeptools_compute_gc_bias/2.5.1.1.0 |  |
| 14 | IdxStats | toolshed.g2.bx.psu.edu/repos/devteam/samtools_idxstats/samtools_idxstats/2.0.1 |  |
| 15 | bamCoverage | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_bam_coverage/deeptools_bam_coverage/2.5.1.1.0 |  |
| 16 | bamCoverage | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_bam_coverage/deeptools_bam_coverage/2.5.1.1.0 |  |
| 17 | bamCompare | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_bam_compare/deeptools_bam_compare/2.5.1.1.0 |  |
| 18 | bamCompare | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_bam_compare/deeptools_bam_compare/2.5.1.1.0 |  |
| 19 | MACS2 callpeak | toolshed.g2.bx.psu.edu/repos/iuc/macs2/macs2_callpeak/2.1.1.20160309.0 |  |
| 20 | multiBamSummary | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_multi_bam_summary/deeptools_multi_bam_summary/2.5.1.1.0 |  |
| 21 | computeMatrix | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_compute_matrix/deeptools_compute_matrix/2.5.1.1.0 |  |
| 22 | computeMatrix | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_compute_matrix/deeptools_compute_matrix/2.5.1.1.0 |  |
| 23 | plotCorrelation | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_plot_correlation/deeptools_plot_correlation/2.5.1.1.0 |  |
| 24 | plotHeatmap | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_plot_heatmap/deeptools_plot_heatmap/2.5.1.1.0 |  |
| 25 | plotHeatmap | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_plot_heatmap/deeptools_plot_heatmap/2.5.1.1.0 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run chip-seq.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run chip-seq.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run chip-seq.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init chip-seq.ga -o job.yml`
- Lint: `planemo workflow_lint chip-seq.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `chip-seq.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)