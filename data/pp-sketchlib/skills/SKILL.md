---
name: pp-sketchlib
description: pp-sketchlib is a high-performance library for rapidly comparing large genomic datasets using MinHash-based sketching. Use when user asks to create sketch databases from genomic sequences, calculate core and accessory distances between samples, or generate sparse distance matrices for population genomics.
homepage: https://github.com/johnlees/pp-sketchlib
metadata:
  docker_image: "quay.io/biocontainers/pp-sketchlib:1.1.0--py310hc2005d1_5"
---

# pp-sketchlib

## Overview
`pp-sketchlib` is a high-performance library designed for the rapid comparison of large genomic datasets. It uses MinHash-based sketching to reduce sequences into compact representations, allowing for the calculation of core and accessory distances without full alignment. It is particularly useful for population genomics, strain typing, and building distance matrices for tools like PopPUNK.

## Core Workflows

### 1. Creating Sketch Databases
To generate a database from genomic sequences, use the `sketch` command.

**Input Format (`rfiles.txt`):**
A tab-separated file with one sample per line:
`SampleName  file1.fa  [file2.fq.gz]`

**Command:**
```bash
sketchlib sketch -l rfiles.txt -o my_database --cpus 8
```
*   **Reads vs. Assemblies:** For read data, use `--min-count [n]` to filter out low-frequency k-mers (sequencing errors).
*   **Strand Specificity:** Use `--single-strand` if your input sequences are all in the same orientation and you want to ignore reverse complements.
*   **Accuracy:** Use `--exact-counter` for non-bacterial or highly complex datasets to improve k-mer counting precision.

### 2. Calculating Distances
Once a database is created, calculate distances between samples using `query dist`.

**All-vs-all distances:**
```bash
sketchlib query dist my_database --cpus 8 > distances.tab
```

**Query vs. Reference:**
To compare new samples against an existing database:
```bash
sketchlib query dist ref_db --query query_db --cpus 8
```

**Sparse Matrices:**
For very large datasets where only close relationships matter:
```bash
sketchlib query sparse my_database --kNN 10 --cpus 8
```

### 3. GPU Acceleration
If a CUDA-compatible GPU is available, `pp-sketchlib` can significantly speed up both sketching (especially for reads) and distance calculations.

```bash
sketchlib sketch -l rfiles.txt -o my_db --cpus 4 --gpu 0
sketchlib query dist my_db --gpu 0
```

## Python API Usage
For integration into Python scripts, use the `pp_sketchlib` module.

```python
import pp_sketchlib

# Calculate distances between two databases
# Returns a numpy array of core and accessory distances
distMat = pp_sketchlib.queryDatabase(
    ref_db="ref.h5", 
    query_db="query.h5", 
    rList=ref_names, 
    qList=query_names, 
    kmers=[15, 18, 21, 24, 27, 30], 
    jaccard=False, 
    cpus=4, 
    use_gpu=False, 
    deviceid=0
)
```

## Expert Tips
*   **Performance:** Distance calculation speed scales linearly with the number of k-mer lengths and the number of bins. Default is usually 10,000 bins; reducing this increases speed but decreases resolution.
*   **Memory:** When working with tens of thousands of genomes, use the `--subset` option in `query` to process specific samples without loading the entire distance matrix into memory.
*   **Database Inspection:** Use `h5ls` on the `.h5` output files to inspect the internal structure (sketches, random matches, and sample names).

## Reference documentation
- [pp-sketchlib Library Documentation](./references/github_com_bacpop_pp-sketchlib.md)