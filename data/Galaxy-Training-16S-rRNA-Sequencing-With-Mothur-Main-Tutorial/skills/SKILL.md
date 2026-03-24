---
name: training-16s-rrna-sequencing-with-mothur-main-tutorial
description: "This microbiome workflow processes raw 16S rRNA FASTQ pairs using the mothur suite and SILVA reference databases to perform sequence quality control, alignment, and taxonomic classification. Use this skill when you need to characterize microbial community composition, calculate alpha and beta diversity metrics, and generate visualizations like Krona charts or heatmaps from environmental or clinical samples."
homepage: https://workflowhub.eu/workflows/1465
---

# Training: 16S rRNA Sequencing With Mothur: Main Tutorial

## Overview

This workflow implements the [mothur MiSeq SOP](https://mothur.org/wiki/miseq_sop/) for high-throughput 16S rRNA microbial analysis. It begins by assembling raw FASTQ pairs into contigs and performing initial quality control, including screening for length and dereplicating sequences to streamline downstream processing.

Sequences are aligned against the [SILVA](https://www.arb-silva.de/) reference database and filtered to ensure all reads overlap the same genetic region. The pipeline then employs pre-clustering to mitigate sequencing errors and utilizes VSEARCH to identify and remove chimeric sequences. Taxonomic classification is performed using a PDS training set, allowing for the removal of unwanted lineages such as mitochondria, chloroplasts, or eukaryotes.

Following denoising, the workflow clusters sequences into Operational Taxonomic Units (OTUs) and generates a shared file to represent the distribution of OTUs across samples. It calculates alpha diversity (e.g., rarefaction curves and richness estimators) and beta diversity (e.g., community membership and structure comparisons) to characterize the microbial landscape.

The final stages produce various visualizations and data formats, including interactive [Krona](https://github.com/marbl/Krona/wiki) pie charts, heatmaps, Venn diagrams, and Newick-formatted phylogenetic trees. It also generates a BIOM file, ensuring compatibility with other ecological analysis tools. This workflow is tagged for [Microbiome](https://training.galaxyproject.org/training-material/topics/microbiome/) research and is part of the Galaxy Training Network (GTN) curriculum.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input FASTQ pairs | data_collection_input |  |
| 1 | silva.v4.fasta | data_input |  |
| 2 | trainset9_032012.pds.fasta | data_input |  |
| 3 | trainset9_032012.pds.tax | data_input |  |
| 4 | HMP_MOCK.v35.fasta | data_input |  |
| 5 | mouse.dpw.metadata | data_input |  |


To run this workflow, organize your raw sequence data into a paired-end list collection of FASTQ files to ensure compatibility with the initial contig generation step. You must also provide specific reference datasets, including SILVA-aligned FASTA files and PDS-formatted training sets for taxonomic classification. Ensure that metadata files are provided in a tabular format to facilitate group-based downstream analysis and subsampling. For automated environment setup and job configuration, you can use `planemo workflow_job_init` to generate a `job.yml` file. Please refer to the `README.md` for comprehensive details on parameter settings and reference database versions.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 6 | Make.contigs | toolshed.g2.bx.psu.edu/repos/iuc/mothur_make_contigs/mothur_make_contigs/1.39.5.0 |  |
| 7 | Summary.seqs | toolshed.g2.bx.psu.edu/repos/iuc/mothur_summary_seqs/mothur_summary_seqs/1.39.5.0 |  |
| 8 | Screen.seqs | toolshed.g2.bx.psu.edu/repos/iuc/mothur_screen_seqs/mothur_screen_seqs/1.39.5.0 |  |
| 9 | Unique.seqs | toolshed.g2.bx.psu.edu/repos/iuc/mothur_unique_seqs/mothur_unique_seqs/1.39.5.0 |  |
| 10 | Count.seqs | toolshed.g2.bx.psu.edu/repos/iuc/mothur_count_seqs/mothur_count_seqs/1.39.5.0 |  |
| 11 | Align.seqs | toolshed.g2.bx.psu.edu/repos/iuc/mothur_align_seqs/mothur_align_seqs/1.39.5.0 |  |
| 12 | Summary.seqs | toolshed.g2.bx.psu.edu/repos/iuc/mothur_summary_seqs/mothur_summary_seqs/1.39.5.0 |  |
| 13 | Screen.seqs | toolshed.g2.bx.psu.edu/repos/iuc/mothur_screen_seqs/mothur_screen_seqs/1.39.5.0 |  |
| 14 | Filter.seqs | toolshed.g2.bx.psu.edu/repos/iuc/mothur_filter_seqs/mothur_filter_seqs/1.39.5.0 |  |
| 15 | Unique.seqs | toolshed.g2.bx.psu.edu/repos/iuc/mothur_unique_seqs/mothur_unique_seqs/1.39.5.0 |  |
| 16 | Pre.cluster | toolshed.g2.bx.psu.edu/repos/iuc/mothur_pre_cluster/mothur_pre_cluster/1.39.5.0 |  |
| 17 | Chimera.vsearch | toolshed.g2.bx.psu.edu/repos/iuc/mothur_chimera_vsearch/mothur_chimera_vsearch/1.39.5.1 |  |
| 18 | Remove.seqs | toolshed.g2.bx.psu.edu/repos/iuc/mothur_remove_seqs/mothur_remove_seqs/1.36.1.0 |  |
| 19 | Classify.seqs | toolshed.g2.bx.psu.edu/repos/iuc/mothur_classify_seqs/mothur_classify_seqs/1.39.5.0 |  |
| 20 | Remove.lineage | toolshed.g2.bx.psu.edu/repos/iuc/mothur_remove_lineage/mothur_remove_lineage/1.39.5.0 |  |
| 21 | Get.groups | toolshed.g2.bx.psu.edu/repos/iuc/mothur_get_groups/mothur_get_groups/1.39.5.0 |  |
| 22 | Remove.groups | toolshed.g2.bx.psu.edu/repos/iuc/mothur_remove_groups/mothur_remove_groups/1.39.5.0 |  |
| 23 | Seq.error | toolshed.g2.bx.psu.edu/repos/iuc/mothur_seq_error/mothur_seq_error/1.39.5.0 |  |
| 24 | Dist.seqs | toolshed.g2.bx.psu.edu/repos/iuc/mothur_dist_seqs/mothur_dist_seqs/1.39.5.0 |  |
| 25 | Cluster.split | toolshed.g2.bx.psu.edu/repos/iuc/mothur_cluster_split/mothur_cluster_split/1.39.5.0 |  |
| 26 | Cluster | toolshed.g2.bx.psu.edu/repos/iuc/mothur_cluster/mothur_cluster/1.39.5.0 |  |
| 27 | Make.shared | toolshed.g2.bx.psu.edu/repos/iuc/mothur_make_shared/mothur_make_shared/1.39.5.0 |  |
| 28 | Classify.otu | toolshed.g2.bx.psu.edu/repos/iuc/mothur_classify_otu/mothur_classify_otu/1.39.5.0 |  |
| 29 | Make.shared | toolshed.g2.bx.psu.edu/repos/iuc/mothur_make_shared/mothur_make_shared/1.39.5.0 |  |
| 30 | Summary.single | toolshed.g2.bx.psu.edu/repos/iuc/mothur_summary_single/mothur_summary_single/1.39.5.0 |  |
| 31 | Count.groups | toolshed.g2.bx.psu.edu/repos/iuc/mothur_count_groups/mothur_count_groups/1.39.5.0 |  |
| 32 | Dist.shared | toolshed.g2.bx.psu.edu/repos/iuc/mothur_dist_shared/mothur_dist_shared/1.39.5.0 |  |
| 33 | Rarefaction.single | toolshed.g2.bx.psu.edu/repos/iuc/mothur_rarefaction_single/mothur_rarefaction_single/1.39.5.0 |  |
| 34 | Sub.sample | toolshed.g2.bx.psu.edu/repos/iuc/mothur_sub_sample/mothur_sub_sample/1.39.5.0 |  |
| 35 | Taxonomy-to-Krona | toolshed.g2.bx.psu.edu/repos/iuc/mothur_taxonomy_to_krona/mothur_taxonomy_to_krona/1.0 |  |
| 36 | Rarefaction.single | toolshed.g2.bx.psu.edu/repos/iuc/mothur_rarefaction_single/mothur_rarefaction_single/1.39.5.0 |  |
| 37 | Tree.shared | toolshed.g2.bx.psu.edu/repos/iuc/mothur_tree_shared/mothur_tree_shared/1.39.5.0 |  |
| 38 | Heatmap.sim | toolshed.g2.bx.psu.edu/repos/iuc/mothur_heatmap_sim/mothur_heatmap_sim/1.39.5.0 |  |
| 39 | Plotting tool | toolshed.g2.bx.psu.edu/repos/devteam/xy_plot/XY_Plot_1/1.0.2 |  |
| 40 | Venn | toolshed.g2.bx.psu.edu/repos/iuc/mothur_venn/mothur_venn/1.39.5.0 |  |
| 41 | Make.biom | toolshed.g2.bx.psu.edu/repos/iuc/mothur_make_biom/mothur_make_biom/1.39.5.0 |  |
| 42 | Krona pie chart | toolshed.g2.bx.psu.edu/repos/crs4/taxonomy_krona_chart/taxonomy_krona_chart/2.6.1.1 |  |
| 43 | Newick Display | toolshed.g2.bx.psu.edu/repos/iuc/newick_utils/newick_display/1.6 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run mothur-miseq-sop.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run mothur-miseq-sop.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run mothur-miseq-sop.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init mothur-miseq-sop.ga -o job.yml`
- Lint: `planemo workflow_lint mothur-miseq-sop.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `mothur-miseq-sop.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
