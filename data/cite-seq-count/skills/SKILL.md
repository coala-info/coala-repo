---
name: cite-seq-count
description: cite-seq-count quantifies Antibody-Derived Tags or Hashtag Oligos from raw FASTQ files to create UMI-based count matrices for multimodal single-cell analysis. Use when user asks to quantify ADTs or HTOs, configure barcode positions for different sequencing chemistries, or prepare tag count matrices for Seurat and Scanpy.
homepage: https://hoohm.github.io/CITE-seq-Count/
metadata:
  docker_image: "quay.io/biocontainers/cite-seq-count:1.4.5--pyhdfd78af_0"
---

# cite-seq-count

## Overview
The `cite-seq-count` skill enables the quantification of Antibody-Derived Tags (ADTs) or Hashtag Oligos (HTOs) from raw FASTQ files. This tool is essential for multimodal single-cell experiments where researchers need to align tag sequences to specific cell barcodes and collapse them into UMI-based count matrices. Use this skill to determine the correct command-line arguments for different sequencing chemistries, troubleshoot low mapping rates, and prepare outputs for downstream analysis in Seurat or Scanpy.

## Core Command Structure
The basic execution requires defining the input reads, the tag list, and the barcode structure:

```bash
CITE-seq-Count -R1 <READ1_FASTQ> -R2 <READ2_FASTQ> \
               -t <TAG_LIST_CSV> \
               -cbf <CB_FIRST> -cbl <CB_LAST> \
               -umif <UMI_FIRST> -umil <UMI_LAST> \
               -cells <EXPECTED_CELLS> \
               -o <OUTPUT_FOLDER>
```

## Barcode Configuration by Chemistry
Correctly identifying the positions of the Cell Barcode (CB) and UMI in Read 1 is critical.

### 10x Genomics V2
- **Cell Barcode**: 1 to 16 (`-cbf 1 -cbl 16`)
- **UMI**: 17 to 26 (`-umif 17 -umil 26`)

### 10x Genomics V3
- **Cell Barcode**: 1 to 16 (`-cbf 1 -cbl 16`)
- **UMI**: 17 to 28 (`-umif 17 -umil 28`)
- **Note**: For 10x V3, it is recommended to use the `-cells` argument rather than a whitelist due to the massive size of the V3 whitelist.

### Drop-seq
- **Cell Barcode**: 1 to 12 (`-cbf 1 -cbl 12`)
- **UMI**: 13 to 20 (`-umif 13 -umil 20`)

## Tag List Preparation (`-t`)
The tags CSV file must contain only the **variable region** of the tag.
- **Format**: `Sequence,Name` (e.g., `ATGCGA,CD3`)
- **Trimming**: If your protocol includes a constant sequence before the tag, use `-trim <N>` to skip the first N bases of Read 2.
- **Legacy Barcodes**: If tags have a polyA tail preceded by a single T, C, or G, do not include these in the CSV.

## Advanced Mapping Options
- **Sliding Window**: Use `--sliding-window` if the tag position in Read 2 varies (common in certain custom protocols).
- **Error Tolerance**: The default maximum Levenshtein distance for tags is 3 (`--max-error 3`). Increase this only if mapping rates are unexpectedly low and tags are sufficiently distinct.
- **Parallelization**: Use `-T <N_THREADS>` to speed up processing on multi-core systems.

## Interpreting and Loading Output
The tool produces an `umi_count` folder containing `matrix.mtx.gz`, `features.tsv.gz`, and `barcodes.tsv.gz`.

### Loading into R (Seurat)
```R
library(Seurat)
# Use gene.column=1 because features.tsv contains tag names in the first column
adt_data <- Read10X("OUTFOLDER/umi_count/", gene.column=1)
adt_obj <- CreateSeuratObject(counts = adt_data, assay = "ADT")
```

### Loading into Python (Scanpy)
```python
import scanpy as sc
adata = sc.read_mtx("OUTFOLDER/umi_count/matrix.mtx.gz").T
features = pd.read_csv("OUTFOLDER/umi_count/features.tsv.gz", header=None)
barcodes = pd.read_csv("OUTFOLDER/umi_count/barcodes.tsv.gz", header=None)
adata.var_names = features[0]
adata.obs_names = barcodes[0]
```

## Troubleshooting
- **Low Mapping Percentage**: Check `unmapped.csv` to see the most frequent sequences that failed to map. This often reveals if the `-trim` value is incorrect or if the tag sequences in the CSV are wrong.
- **High Uncorrected Cells**: Ensure the `-cbf` and `-cbl` positions match your library preparation kit.

## Reference documentation
- [Running the script](./references/hoohm_github_io_CITE-seq-Count_Running-the-script.md)
- [Reading the output](./references/hoohm_github_io_CITE-seq-Count_Reading-the-output.md)
- [Guidelines for typical chemistries](./references/hoohm_github_io_CITE-seq-Count_Guidelines.md)