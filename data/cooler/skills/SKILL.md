---
name: cooler
description: Cooler stores and manipulates genomic interaction matrices using a high-performance sparse data model. Use when user asks to create contact matrices from interaction pairs, normalize Hi-C data through matrix balancing, generate multi-resolution files, or export genomic pixels.
homepage: https://github.com/open2c/cooler
---


# cooler

## Overview
Cooler is a specialized suite of tools designed for the efficient storage and manipulation of genomic interaction matrices, such as those produced by Hi-C experiments. It implements a sparse, compressed, binary data model using HDF5. This skill enables the creation of contact matrices from interaction pairs, the application of normalization algorithms (balancing), and the high-performance querying of specific genomic regions. It is the standard format for many visualization tools and downstream Hi-C analysis pipelines.

## Common CLI Patterns

### Creating Cooler Files
To transform interaction pairs into a binned matrix:
* **From sorted pairs**: `cooler cload pairs <chrom.sizes>:<bin_size> <input_pairs.gz> <output.cool>`
* **From unordered pixels**: `cooler load <bins.bed> <pixels.tsv> <output.cool>`
* **Single-cell data**: Use the `.scool` extension to store multiple matrices (one per cell) in a single container.

### Matrix Balancing (Normalization)
Normalization is critical for removing experimental biases:
* **Standard balancing**: `cooler balance <file.cool>`
* **Specify arguments**: `cooler balance --mad-max 5 --min-nnz 10 <file.cool>`
* **Check status**: Use `cooler info <file.cool>` to verify if a "weight" column exists in the bin table.

### Multi-resolution Management
For visualization (e.g., HiGlass) or multi-scale analysis:
* **Generate resolutions**: `cooler zoomify <file.cool>` creates an `.mcool` file containing a hierarchy of resolutions.
* **Custom resolutions**: `cooler zoomify --resolutions 1000,5000,10000 <file.cool>`

### Data Extraction and Inspection
* **List contents**: `cooler ls <file.mcool>` (useful for seeing available resolutions in a multi-res file).
* **Export pixels**: `cooler dump --join <file.cool>` exports pixels with genomic coordinates instead of bin IDs.
* **Symmetric output**: When dumping symmetric-upper coolers, use `cooler dump --matrix` to generate the full square matrix output.
* **Coordinate formatting**: Use `-one-based-ids` or `--one-based-starts` for compatibility with tools expecting 1-based indexing.

## Expert Tips
* **Temporary Storage**: When creating coolers from large unordered inputs, use the `-t` or `--temp-dir` flag to point to a high-performance scratch disk to avoid filling the system `/tmp`.
* **Resolution Reduction**: Use `cooler coarsen` to create a lower-resolution version of an existing cooler without re-processing the original pairs.
* **Metadata**: Always check `cooler info` to see the bin size, genome assembly, and whether the matrix has been balanced.
* **Column Selection**: `cooler dump` allows selecting specific columns (e.g., `count`, `balanced`) to reduce output size during text export.



## Subcommands

| Command | Description |
|---------|-------------|
| balance | Out-of-core matrix balancing. |
| cooler attrs | Display a file's attribute hierarchy. |
| cooler cload | Create a cooler from genomic pairs and bins. |
| cooler coarsen | Coarsen a cooler to a lower resolution. |
| cooler cp | Copy a cooler from one file to another or within the same file. |
| cooler csort | Sort and index a contact list. |
| cooler digest | Generate fragment-delimited genomic bins. |
| cooler dump | Dump a cooler's data to a text stream. |
| cooler ln | Create a hard link to a cooler (rather than a true copy) in the same file.   Also supports soft links (in the same file) or external links (different   files). |
| cooler load | Create a cooler from a pre-binned matrix. |
| cooler merge | Merge multiple coolers with identical axes. |
| cooler mv | Rename a cooler within the same file. |
| cooler tree | Display a file's data hierarchy. |
| cooler zoomify | Generate a multi-resolution cooler file by coarsening. |
| cooler_ls | List all coolers inside a file. |
| cooler_makebins | Generate fixed-width genomic bins. |
| info | Display a cooler's info and metadata. |
| show | Display and browse a cooler in matplotlib. |

## Reference documentation
- [Cooler GitHub README](./references/github_com_open2c_cooler_blob_master_README.md)
- [Cooler Release Notes and Changes](./references/github_com_open2c_cooler_blob_master_CHANGES.md)
- [Cooler Citation and Metadata](./references/github_com_open2c_cooler_blob_master_CITATION.cff.md)