---
name: cellranger-arc
description: Cell Ranger ARC processes joint single-cell ATAC and RNA sequencing data from the 10x Genomics Chromium Multiome platform. Use when user asks to process multiome ATAC and GEX data, quantify joint single-cell libraries, call chromatin peaks and link them to gene expression, aggregate multiple multiome runs, or build multiome reference packages.
homepage: https://github.com/mattgalbraith/cellrangerARC-docker-singularity
metadata:
  docker_image: "cumulusprod/cellranger-arc:2.2.0"
---


# cellranger-arc

## Overview

Cell Ranger ARC processes joint single-cell chromatin accessibility (ATAC) and single-cell RNA sequencing (GEX) data generated with the 10x Genomics Chromium Multiome platform. It aligns reads for both modalities, calls ATAC peaks, counts UMIs and transposition events, detects cells using joint multimodal thresholds, and computes feature linkage between open chromatin regions and gene expression.

Key subcommands include:
- `count`: Primary alignment, feature quantification, peak calling, and multimodal cell calling.
- `aggr`: Batch normalization and aggregation across multiple GEM wells/libraries.
- `reanalyze`: Recalculation of dimensionality reduction, clustering, and peak linkage with custom parameters or barcode subsets.
- `mkref` & `mkgtf`: Custom reference package building (combining genomic FASTA, filtered GTF annotations, and optional transcription factor motifs).
- `telemetry` & `sitecheck`: Infrastructure readiness verification and telemetry configuration.

---

## System Requirements & Pre-Flight Checks

Cell Ranger ARC jobs are memory- and I/O-intensive.

- **Hardware**: Minimum 8 CPU cores (16 recommended), minimum 64 GB RAM (128 GB recommended).
- **OS Limits**: Global open file limit of ≥10k per GB RAM; user process limit ≥64 times CPU count.
- **Pre-flight diagnostics**:
  ```bash
  cellranger-arc sitecheck
  cellranger-arc testrun --id=check_install
  ```
- **Disabling Telemetry**:
  ```bash
  cellranger-arc telemetry disable
  # Alternatively via environment variable:
  export TENX_DISABLE_TELEMETRY=1
  ```

---

## 1. Building Custom References (`mkgtf` & `mkref`)

Cell Ranger ARC references differ from standard Cell Ranger references because they bundle the transcriptome (GEX) and whole-genome/motif annotations (ATAC). Multi-species references are **not supported**.

### Step 1: Filter the GTF with `mkgtf`
Filter standard GTF annotations (e.g., Ensembl) to retain specific biotypes (e.g., protein-coding, lncRNA, antisense):

```bash
cellranger-arc mkgtf \
  Homo_sapiens.GRCh38.105.gtf \
  filtered_GRCh38.105.gtf \
  --attribute=gene_biotype:protein_coding \
  --attribute=gene_biotype:lncRNA \
  --attribute=gene_biotype:antisense
```

### Step 2: Create a Reference Config File (`reference.config`)
Define genome metadata, FASTA, GTF, and non-nuclear contigs (such as mitochondrial DNA where chromatin structure analysis does not apply):

```json
{
    organism: "human",
    genome: ["GRCh38"],
    input_fasta: ["/path/to/GRCh38.primary_assembly.fa"],
    input_gtf: ["/path/to/filtered_GRCh38.105.gtf"],
    non_nuclear_contigs: ["chrM"],
    input_motifs: "/path/to/jaspar/motifs.pfm"
}
```

### Step 3: Run `mkref`
```bash
cellranger-arc mkref \
  --config=reference.config \
  --nthreads=16 \
  --memgb=64
```
*Note*: This command creates a folder named after the `genome` field in the current working directory.

---

## 2. Quantifying Multiome Samples (`cellranger-arc count`)

`cellranger-arc count` requires a libraries CSV specifying the location and library type of paired ATAC and GEX data.

### Step 1: Prepare `libraries.csv`
Library types must be strictly designated as `Chromatin Accessibility` or `Gene Expression`:

```csv
fastqs,sample,library_type
/path/to/fastqs/atac_dir,sample_atac,Chromatin Accessibility
/path/to/fastqs/gex_dir,sample_gex,Gene Expression
```

### Step 2: Run `count`
```bash
cellranger-arc count \
  --id=Sample_01 \
  --reference=/path/to/refdata-cellranger-arc-GRCh38-2024-A \
  --libraries=libraries.csv \
  --create-bam=true \
  --localcores=16 \
  --localmem=128
```

### Common Flags & Customization:
- `--create-bam=<true|false>`: Set to `false` to substantially save disk space and runtime if intermediate BAM files are not needed for visual inspection.
- `--gex-exclude-introns`: Disables intronic counting; counts only exonic reads matching splice junctions.
- `--peaks=<BED>`: Provide a pre-defined, sorted, non-overlapping 3-column BED file to bypass the automated ATAC peak caller.
- `--min-atac-count=<NUM>` & `--min-gex-count=<NUM>`: Manual override of the joint cell-calling algorithm (both flags must be used together).
- `--nosecondary`: Skip secondary analyses (t-SNE, UMAP, k-means clustering, linkage calculation).
- `--dry`: Generates the pipeline invocation `.mro` file without executing the pipeline.

---

## 3. Aggregating Multiple Samples (`cellranger-arc aggr`)

Combine outputs from multiple `cellranger-arc count` runs into a unified dataset with depth normalization.

### Step 1: Create `aggr.csv`
```csv
library_id,atac_fragments,per_barcode_metrics,gex_molecule_info
L1,/data/L1/outs/atac_fragments.tsv.gz,/data/L1/outs/per_barcode_metrics.csv,/data/L1/outs/gex_molecule_info.h5
L2,/data/L2/outs/atac_fragments.tsv.gz,/data/L2/outs/per_barcode_metrics.csv,/data/L2/outs/gex_molecule_info.h5
```
*Tip*: Extra custom metadata columns (e.g., `batch`, `condition`) can be included; they will be transferred into the `.cloupe` file for Loupe Browser visualization.

### Step 2: Run `aggr`
```bash
cellranger-arc aggr \
  --id=Aggregated_Experiment \
  --reference=/path/to/refdata-cellranger-arc-GRCh38-2024-A \
  --csv=aggr.csv \
  --normalize=depth \
  --localcores=16 \
  --localmem=128
```
- `--normalize`: Set to `depth` (subsamples mapped reads to match the lowest library depth) or `none`.

---

## 4. Custom Secondary Analysis (`cellranger-arc reanalyze`)

Rerun dimensional reduction, clustering, and feature linkage using custom principal components, barcode lists, or peak sets without realigning reads.

```bash
cellranger-arc reanalyze \
  --id=Reanalysis_01 \
  --reference=/path/to/refdata-cellranger-arc-GRCh38-2024-A \
  --matrix=/data/Sample_01/outs/filtered_feature_bc_matrix.h5 \
  --atac-fragments=/data/Sample_01/outs/atac_fragments.tsv.gz \
  --params=params.csv \
  --barcodes=subset_barcodes.csv
```

### Parameter Specification (`params.csv`)
Define key-value pairs to override secondary analysis defaults:
```csv
num_gex_pcs,20
num_atac_pcs,20
k_means_max_clusters,15
feature_linkage_max_dist_mb,1.0
random_seed,42
```
*Note*: `atac_fragments.tsv.gz.tbi` must exist in the same directory as the `atac-fragments` file.

---

## 5. HPC & Cluster Resource Management

Cell Ranger ARC uses the Martian runtime engine, supporting distributed execution:

- **Local Execution**:
  ```bash
  --jobmode=local --localcores=32 --localmem=128
  ```
- **HPC Cluster Execution (SLURM/SGE/LSF)**:
  ```bash
  --jobmode=slurm \
  --maxjobs=64 \
  --jobinterval=100 \
  --mempercore=8
  ```
- **Custom Stage Resource Allocations**:
  Use `--overrides=stages.json` to fine-tune memory or thread allocations for specific pipeline stages that experience out-of-memory (OOM) conditions.

---

## Troubleshooting & Best Practices

1. **Deprecated `mkfastq`**:
   `cellranger-arc mkfastq` is deprecated. Use Illumina `bcl-convert` directly to produce demultiplexed FASTQs for both GEX and ATAC libraries before running `cellranger-arc count`.
2. **Library CSV Type Matching**:
   Ensure `library_type` strings in the libraries CSV match standard conventions exactly (`Gene Expression` and `Chromatin Accessibility`). Mismatched strings will cause validation failure during preflight checks.
3. **Mitochondrial Contig Specification**:
   When using `mkref`, always specify mitochondrial contigs in `non_nuclear_contigs`. Excluding this causes false ATAC peaks to be called across circular mtDNA.
4. **BAM Generation Overhead**:
   If downstream visualization via Loupe Browser and matrix analysis in Seurat/Signac/Scanpy are all that is required, use `--create-bam=false` to cut storage and pipeline runtime substantially.

---



## Subcommands

| Command | Description |
|---------|-------------|
| cellranger-arc aggr | Aggregate data from multiple `cellranger-arc count` runs |
| cellranger-arc cloud | The official command-line client for 10x Genomics Cloud Analysis. |
| cellranger-arc count | Count ATAC and gene expression reads from a single library |
| cellranger-arc mkfastq | Run Illumina demultiplexer on sample sheets that contain 10x-specific sample index sets, and generate 10x-specific quality metrics after the demultiplex. |
| cellranger-arc mkgtf | Filter user-supplied GTF files for use as Cell Ranger Multiome ATAC + Gene Expression-compatible genes files for mkref tool. |
| cellranger-arc mkref | Build a reference package from a user-supplied genome FASTA and gene GTF file for 10x Genomics Cell Ranger Multiome ATAC + Gene Expression. |
| cellranger-arc reanalyze | Re-run secondary analysis (dimensionality reduction, clustering, feature linkage etc.) on a completed `cellranger-arc count` or `cellranger-arc aggr` run |
| cellranger-arc telemetry | Manage and inspect telemetry data collection for Cell Ranger ARC |
| cellranger-arc testrun | Run a tiny cellranger-arc count pipeline to verify software integrity |
| cellranger-arc upload | Upload files to 10x Genomics support |

## Reference documentation
- [Creating a Custom Reference](./references/creating-a-custom-reference.md)
- [Cell Ranger ARC Pipeline Telemetry](./references/cr-arc-pipeline-telemetry.md)
- [Cell Ranger ARC Singularity/Docker Guidelines](./references/github_com_mattgalbraith_cellrangerARC-docker-singularity_blob_main_README.md)