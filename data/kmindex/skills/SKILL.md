---
name: kmindex
description: kmindex indexes and queries k-mers from large genomic datasets to enable efficient sequence presence checks across multiple samples. Use when user asks to build a k-mer index from genomic files, query sequences against an index, or manage genomic databanks for comparative genomics.
homepage: https://github.com/tlemane/kmindex
---


# kmindex

## Overview

The kmindex skill enables the efficient management of genomic databanks by indexing k-mers from sequencing samples. It is particularly useful for comparative genomics and metagenomics where you need to check the presence of specific sequences across hundreds or thousands of datasets. By utilizing the findere algorithm, it minimizes false positives during the query phase by using $(s+z)$-mers. This skill provides the procedural knowledge to build indices from "File of Files" (fof) inputs and execute high-performance queries against those indices.

## Core Workflows

### Index Construction

To build an index, you must provide a list of input files and define the k-mer parameters.

- **Prepare Input**: Create a `fof.txt` (File of Files) where each line is a path to a genomic dataset (FASTA/FASTQ).
- **Run Build**: Use the `build` command to generate the index.

```bash
kmindex build --fof inputs.txt --run-dir ./work_dir --index ./my_index --register-as DB_NAME --kmer-size 25 --hard-min 2 --nb-cell 1000000
```

**Key Parameters:**
- `--fof`: Path to the text file listing input datasets.
- `--index`: The output directory for the generated index.
- `--register-as`: A logical name for the dataset within the index.
- `--kmer-size`: Length of the k-mers to index (must be a multiple of 32 if customized in some builds, default often 25).
- `--hard-min`: Minimum abundance threshold for a k-mer to be indexed (filters out sequencing errors).
- `--nb-cell`: Bloom filter size; adjust based on the expected number of unique k-mers.

### Querying the Index

Once an index is built, you can query it using FASTA or FASTQ files to find shared k-mer percentages.

```bash
kmindex query --index ./my_index --fastx query.fasta --zvalue 3
```

**Key Parameters:**
- `--index`: Path to the directory containing the built index.
- `--fastx`: Path to the query file (FASTA/FASTQ).
- `--zvalue`: Used by the findere algorithm to reduce false positives. It queries $(k+z)$-mers. Increasing this value improves precision but may impact sensitivity.

## Best Practices

- **Resource Management**: For large datasets, ensure the `--run-dir` is located on a disk with sufficient space for intermediate kmtricks files.
- **K-mer Selection**: Use a `--kmer-size` appropriate for your organism's complexity. 21-31 is standard for most bacterial and small eukaryotic applications.
- **False Positive Control**: Always experiment with the `--zvalue` during queries. A small $z$ (e.g., 1-3) significantly reduces false positives compared to standard k-mer lookups.
- **Scaling**: kmindex supports multiple sub-indices. You can build separate indices and search across them collectively by pointing to the parent index directory.



## Subcommands

| Command | Description |
|---------|-------------|
| build | Build index. |
| index-infos | Print index informations. |
| kmindex compress | Compress index. |
| kmindex merge | Merge sub-indexes. |
| kmindex register | Register index. |
| kmindex sum-query | Query a summarized index. (experimental) |
| kmindex_query2 | To be used instead of kmindex query when many sub-indexes are registered, i.e. hundreds or thousands. |
| kmindex_reports | Reports on kmindex files. |
| kmindex_sum-index | Make a lightweight summarized index, at query time, reports only the number samples containing each k-mer. (experimental) |
| query | Query index. |

## Reference documentation

- [kmindex README](./references/github_com_tlemane_kmindex_blob_main_README.md)
- [CMake Configuration and Build Options](./references/github_com_tlemane_kmindex_blob_main_CMakeLists.txt.md)