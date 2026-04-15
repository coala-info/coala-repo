---
name: changeo
description: Change-O is a suite of command-line utilities for processing B cell and T cell receptor repertoires and standardizing V(D)J alignment data. Use when user asks to convert alignment tool outputs to AIRR format, filter or manipulate repertoire databases, assign sequences to clonal lineages, or reconstruct ancestral germline sequences.
homepage: http://changeo.readthedocs.io
metadata:
  docker_image: "quay.io/biocontainers/changeo:1.3.4--pyhdfd78af_0"
---

# changeo

## Overview

Change-O is a specialized suite of command-line utilities designed for the advanced processing of B cell and T cell receptor repertoires. It serves as the bridge between initial V(D)J alignment tools and downstream statistical analysis. The toolkit excels at transforming raw alignment files into a standardized tabular format (AIRR Community Rearrangement standard), clustering sequences into clonal lineages based on shared ancestry, and reconstructing ancestral germline sequences to facilitate the study of somatic hypermutation.

## Core Workflow and CLI Patterns

### 1. Database Generation (MakeDb.py)
The first step is converting alignment tool output into a Change-O/AIRR compliant TSV file.

**From IgBLAST output:**
```bash
MakeDb.py igblast -i input.fmt7 -s input.fasta -r IMGT_V.fasta IMGT_D.fasta IMGT_J.fasta --extended
```
*   **Tip**: The `-r` reference sequences must be IMGT-gapped to ensure correct junction (CDR3) parsing.
*   **Tip**: Use `--extended` to include IMGT-gapped CDR/FWR regions and alignment metrics.

**From IMGT/HighV-QUEST output:**
```bash
MakeDb.py imgt -i output.txz -s input.fasta --extended
```

### 2. Data Filtering and Manipulation (ParseDb.py)
Use `ParseDb.py` to clean your database before clonal assignment.

**Filter for productive sequences:**
```bash
ParseDb.py select -d database.tsv -f productive -u T
```

**Split by locus (e.g., Heavy vs Light chains):**
```bash
ParseDb.py select -d database.tsv -f locus -u "IGH" --logic all --regex --outname heavy
```

### 3. Clonal Assignment (DefineClones.py)
Groups sequences into clones based on V-gene, J-gene, and junction length similarity.

**Standard Hamming distance clustering:**
```bash
DefineClones.py -d database_pass.tsv --act set --model ham --norm len --dist 0.16
```
*   **Expert Tip**: The `--dist` threshold is critical. For BCR data, a threshold around 0.1 to 0.2 is common, but should be determined using the `distToNearest` function in the SHazaM R package.
*   **T-Cell Tip**: For TCR data, use `--dist 0` or a very low value, as T cells do not undergo somatic hypermutation.

### 4. Germline Reconstruction (CreateGermlines.py)
Reconstructs the unmutated ancestral sequence for each record or clone.

**Generate germlines with D-segment masking:**
```bash
CreateGermlines.py -d database_clones.tsv -g dmask -r IMGT_V.fasta IMGT_D.fasta IMGT_J.fasta
```
*   **Note**: Use `-g dmask` (default) to place Ns in the D-segment, which is safer when D-assignment confidence is low. Use `--cloned` if you have already run `DefineClones.py` to ensure a consensus germline for the entire clone.

### 5. Format Conversion (ConvertDb.py)
Export data for external tools or submission.

**Export to FASTA with annotations in the header:**
```bash
ConvertDb.py fasta -d database.tsv --if sequence_id --sf sequence_alignment --mf v_call duplicate_count
```

## Expert Tips and Best Practices

*   **AIRR Standard**: As of v1.0.0, Change-O defaults to the AIRR Community Rearrangement standard. If working with older pipelines, use `--format changeo` to maintain compatibility with legacy Change-O columns (e.g., `V_CALL` vs `v_call`).
*   **10X Genomics**: To process 10X V(D)J data, use `MakeDb.py` with the `--10x` flag to incorporate the `filtered_contig_annotations.csv` file provided by Cell Ranger.
*   **Memory Management**: For very large datasets, use `ParseDb.py split` to divide the database into smaller chunks (e.g., by sample or locus) before running computationally intensive tasks like `DefineClones.py`.
*   **Reference Consistency**: Always ensure the reference fasta files passed to `MakeDb.py` and `CreateGermlines.py` are identical to those used by the initial aligner (IgBLAST/IMGT).



## Subcommands

| Command | Description |
|---------|-------------|
| DefineClones.py | Assigns Ig sequences to clonal groups based on junction sequence similarity. |
| ParseDb.py | A utility to parse, filter, and manipulate Change-O tab-delimited database files. |

## Reference documentation
- [Commandline Usage](./references/changeo_readthedocs_io_en_stable_usage.html.md)
- [Using IgBLAST](./references/changeo_readthedocs_io_en_stable_examples_igblast.html.md)
- [Clustering sequences into clonal groups](./references/changeo_readthedocs_io_en_stable_examples_cloning.html.md)
- [Parsing 10X Genomics V(D)J data](./references/changeo_readthedocs_io_en_stable_examples_10x.html.md)
- [Reconstructing germline sequences](./references/changeo_readthedocs_io_en_stable_examples_germlines.html.md)