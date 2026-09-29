---
name: cellranger
description: Cell Ranger processes raw 10x Genomics Chromium sequencing data into gene expression count matrices, feature barcodes, and immune repertoire clonotype calls. Use when user asks to process single-cell RNA-seq FASTQ files, quantify gene expression and feature barcodes, assemble V(D)J immune receptor sequences, aggregate multiple GEM wells, or build custom 10x references.
homepage: https://github.com/10XGenomics/cellranger
metadata:
  docker_image: "cumulusprod/cellranger:10.1.0"
---


# cellranger

## Overview

Cell Ranger processes raw sequencing data from 10x Genomics Chromium single-cell platforms into gene expression matrices, cell annotations, and clonotype calls. It wraps sequence alignment (via STAR), cellular barcode detection, UMI quantification, and secondary statistical workflows into standard pipelines.

Key analysis pipelines:
- `cellranger count`: Single-sample 3' or 5' gene expression and feature barcode processing.
- `cellranger multi`: Multi-library integration (GEX, V(D)J, Antibody, CRISPR, CellPlex/FRP multiplexing).
- `cellranger vdj`: Immune receptor profiling (TCR/BCR assembly and clonotyping).
- `cellranger aggr`: Aggregating and normalizing counts across multiple GEM wells/libraries.
- `cellranger reanalyze`: Recomputing clustering, PCA, and t-SNE/UMAP with custom parameters.
- `cellranger mkref` / `mkgtf` / `mkvdjref`: Building custom references from FASTA and GTF files.

---

## Environment & Resource Management

Cell Ranger pipelines run on Martian pipestance architecture, managing local or cluster jobs.

### Standard Resource Flags
Always specify memory and CPU limits on shared workstations or HPC environments:
- `--localcores <NUM>`: Max CPU cores to utilize.
- `--localmem <NUM>`: Max memory in gigabytes (recommend at least 64GB for mammalian GEX).
- `--jobmode <local|sge|lsf|slurm>`: Execution engine mode.
- `--create-bam <true|false>`: Required in modern Cell Ranger versions. Set `--create-bam=false` if alignments are not needed downstream, significantly speeding up run time and saving storage.

---

## Core Workflows and CLI Patterns

### 1. Single-Sample Gene Expression (`cellranger count`)

Used for single GEM-well standard 3' or 5' gene expression libraries.

```bash
cellranger count \
  --id=sample_001 \
  --transcriptome=/path/to/refdata-gex-GRCh38-2020-A \
  --fastqs=/path/to/fastqs/ \
  --sample=sample_prefix \
  --create-bam=true \
  --localcores=16 \
  --localmem=64
```

Key optional flags:
- `--include-introns <true|false>`: Set to `true` (default in v7+) to capture nuclear and pre-mRNA reads, essential for single-nucleus RNA-seq (snRNA-seq).
- `--expect-cells <INT>`: Prior guidance for cell-calling algorithms (default: 3000).
- `--force-cells <INT>`: Bypasses automated cell filtering and forces a specific cell barcode count.
- `--chemistry <CHEM>`: Explicitly define chemistry if auto-detection fails (e.g., `threeprime`, `fiveprime`, `SC3Pv3`, `ARC-v1`).

---

### 2. Multi-Assay & Multiplexed Workflows (`cellranger multi`)

Recommended for multi-modal assays: combined Gene Expression + Feature Barcode (Antibody, CRISPR) or 5' V(D)J + GEX, or sample multiplexing (CellPlex CMOs, Flex probe barcodes).

#### Generate Config Template
```bash
# Output full parameter descriptions
cellranger multi-template --parameters

# Generate standard boilerplate config file
cellranger multi-template --output=multi_config.csv
```

#### Run `cellranger multi`
```bash
cellranger multi \
  --id=experiment_run_01 \
  --csv=multi_config.csv \
  --localcores=32 \
  --localmem=128
```

#### Multi Config CSV Structure Example (GEX + Cell Multiplexing):
```csv
[gene-expression]
reference,/refdata/refdata-gex-GRCh38-2020-A
create-bam,false

[libraries]
fastq_id,fastqs,feature_types
Sample_GEX,/data/fastqs/gex,Gene Expression
Sample_CMO,/data/fastqs/cmo,Multiplexing Capture

[samples]
sample_id,cmo_ids,description
Jurkat,CMO301,Jurkat cell line
Raji,CMO302,Raji cell line
```

*For V(D)J or Feature Barcoding, add `[vdj]` or `[feature]` sections pointing to references, and include library types `VDJ-T`, `VDJ-B`, or `Antibody Capture`.*

---

### 3. V(D)J Profiling (`cellranger vdj`)

Assembles TCR and BCR sequences from 5' immune profiling libraries independently of GEX.

```bash
cellranger vdj \
  --id=tcr_donorA \
  --reference=/path/to/refdata-cellranger-vdj-GRCh38-alts-ensembl-7.1.0 \
  --fastqs=/path/to/fastqs/vdj \
  --sample=vdj_donorA \
  --chain=TR \
  --localcores=16 \
  --localmem=32
```
*Note: `--chain` accepts `TR` (TCR), `IG` (BCR), or `auto`.*

---

### 4. Sample Aggregation (`cellranger aggr`)

Aggregates multiple `cellranger count` or `cellranger multi` outputs into a unified matrix, removing sequencing depth batch effects.

#### Prepare `aggr.csv`:
```csv
sample_id,molecule_h5
sample_control,/path/to/sample_control/outs/molecule_info.h5
sample_treated,/path/to/sample_treated/outs/molecule_info.h5
```
*(For Cell Ranger v6.0+, use `sample_id,molecule_h5`; earlier versions used `library_id`)*.

#### Run Aggregation:
```bash
cellranger aggr \
  --id=aggregated_experiment \
  --csv=aggr.csv \
  --normalize=mapped \
  --localcores=16 \
  --localmem=64
```
- `--normalize`: Set to `mapped` to downsample reads across libraries to match mapped depth, or `none` to combine counts directly without downsampling.

---

### 5. Reanalysis and Secondary Analysis (`cellranger reanalyze`)

Reruns dimensionality reduction, PCA, t-SNE, UMAP, and graph-based clustering with customized subsets of cells or genes.

```bash
cellranger reanalyze \
  --id=reanalysis_filtered \
  --matrix=/path/to/outs/filtered_feature_bc_matrix.h5 \
  --barcodes=/path/to/whitelisted_barcodes.csv \
  --genes=/path/to/custom_genes.csv \
  --params=/path/to/reanalysis_params.csv
```

---

### 6. Custom Reference Generation

#### Step 1: Filter GTF (`cellranger mkgtf`)
Filter annotations to keep only biotypes of interest (typically protein-coding and lincRNA):
```bash
cellranger mkgtf \
  Homo_sapiens.GRCh38.109.gtf \
  Homo_sapiens.GRCh38.109.filtered.gtf \
  --attribute=gene_biotype:protein_coding \
  --attribute=gene_biotype:lncRNA
```

#### Step 2: Build Reference (`cellranger mkref`)
```bash
cellranger mkref \
  --genome=GRCh38_custom \
  --fasta=Homo_sapiens.GRCh38.dna.primary_assembly.fa \
  --genes=Homo_sapiens.GRCh38.109.filtered.gtf \
  --nthreads=16 \
  --memgb=64
```

#### Build Custom V(D)J Reference (`cellranger mkvdjref`)
```bash
cellranger mkvdjref \
  --genome=vdj_custom \
  --fasta=vdj_segments.fa \
  --genes=vdj_annotations.gtf
```

---

### 7. Feature Barcode Utility (`cellranger mat2csv`)

Convert compressed H5 or sparse MEX matrix folders to a flat CSV file for external pipelines (R/Python/Excel):
```bash
cellranger mat2csv \
  sample_out/outs/filtered_feature_bc_matrix.h5 \
  filtered_matrix.csv
```

---

## Troubleshooting & Best Practices

1. **FASTQ File Naming Convention**:
   Cell Ranger matches input FASTQs using Illumina naming conventions:
   `[SampleName]_S[SampleNumber]_L00[LaneNumber]_[ReadType]_001.fastq.gz`
   Ensure `R1` (barcode/UMI), `R2` (cDNA insert), and `I1`/`I2` (sample indices) follow this standard format before running pipelines.
2. **Storage and Disk Space**:
   A typical run generates temporary files under the `--id` folder. Do not modify or move internal files while the run is active. The final deliverables reside cleanly in `<id>/outs/`.
3. **Resuming Interrupted Runs**:
   If a pipeline fails due to memory exhaustion or a cluster timeout, rerun the exact same command line from the same working directory. Martian will automatically inspect the checkpoint database and resume execution from the last successful stage.
4. **Validation Before Submission**:
   Use `--dry` on cluster submissions to generate Martian invocation files (`.mro`) and validate parameter syntax without launching jobs. Use `cellranger sitecheck` to inspect node capabilities and environment configurations.

---



## Subcommands

| Command | Description |
|---------|-------------|
| cellranger aggr | Aggregate data from multiple Cell Ranger runs |
| cellranger annotate | Annotate cell-types from outputs of a Cell Ranger run |
| cellranger cloud | The official command-line client for 10x Genomics Cloud Analysis. |
| cellranger count | Count gene expression and/or feature barcode reads from a single sample and GEM well |
| cellranger mat2csv | Tool for converting feature-barcode matrices from sparse format to dense CSV format, for use by external programs. |
| cellranger mkgtf | Filter user-supplied GTF files for use as Cell Ranger-compatible genes files for mkref tool. |
| cellranger mkref | Prepare a reference for use with 10x analysis software. Requires a GTF and FASTA |
| cellranger mkvdjref | Prepare a reference for use with Cell Ranger VDJ. Build a Cell Ranger V(D)J-compatible reference folder from user-supplied genome FASTA and gene GTF files, or a FASTA file containing V(D)J segments. |
| cellranger multi | Analyze multiplexed data or combined gene expression/immune profiling/feature barcode data |
| cellranger multi-template | Output cellranger multi config CSV template for analyzing Single Cell Gene Expression with Feature Barcode Technology, Flex Gene Expression, on-chip multiplexing, hashing with Antibody Capture, or Single Cell Immune Profiling data. |
| cellranger reanalyze | Re-run secondary analysis (dimensionality reduction, clustering, etc) |
| cellranger telemetry | Configure and inspect telemetry settings and data |
| cellranger testrun | Execute the 'count' pipeline on a small test dataset |
| cellranger upload | Upload a file with cellranger |
| cellranger vdj | Assembles single-cell VDJ receptor sequences from 10x Immune Profiling libraries |

## Reference documentation

- [Running Cell Ranger aggr](./references/cr-tutorial-ag.md)
- [Running Cell Ranger multi](./references/cr-tutorial-multi.md)