---
name: ffindex
description: ffindex creates and manages flat-file indexes by concatenating many small files into a single searchable database. Use when user asks to build a flat-file database, retrieve entries by name or index, modify an existing index, or apply commands to database entries in serial or parallel.
homepage: https://github.com/soedinglab/ffindex_soedinglab
---


# ffindex

## Overview
ffindex is a specialized tool for creating and managing "flat-file indexes." It solves the problem of "too many small files" by concatenating them into a single large data file (`.ffdata`) and maintaining a separate, searchable text index (`.ffindex`) that stores the name, offset, and length of each entry. This skill provides the necessary command-line patterns to build, retrieve, modify, and apply arbitrary commands to these databases.

## Core CLI Patterns

### Building a Database
To create a new ffindex from directories of files, use `ffindex_build`.
- **Standard build**: `ffindex_build data.ffdata data.ffindex path/to/files`
- **Build and sort**: `ffindex_build -s data.ffdata data.ffindex path/to/files`
  - *Tip*: Always use `-s` if you intend to query the database later, as lookups require a sorted index for binary search.

### Retrieving Data
Use `ffindex_get` to extract specific entries by name or index.
- **By name**: `ffindex_get data.ffdata data.ffindex entry_name1 entry_name2`
- **By numerical index**: `ffindex_get data.ffdata data.ffindex -n 1 5 10` (This is faster than name-based lookup).

### Modifying the Index
The `ffindex_modify` tool allows for administrative tasks without rebuilding the entire data file.
- **Unlink an entry**: `ffindex_modify -u data.ffindex entry_name` (Removes the reference from the index; the data remains in the `.ffdata` file but is inaccessible).
- **Sort an existing index**: `ffindex_modify -s data.ffindex`

### Working with FASTA Files
ffindex is frequently used in bioinformatics to handle large sequence databases.
- **Convert FASTA to ffindex**: `ffindex_from_fasta -s out.ffdata out.ffindex input.fasta`
  - This creates entries where the names are incremental IDs (1, 2, 3...).

## Processing Entries (ffindex_apply)
One of the most powerful features is the ability to run a command against every entry in the database.

- **Run a shell command**: `ffindex_apply data.ffdata data.ffindex wc -c`
- **Complex processing (Perl/Python)**: `ffindex_apply data.ffdata data.ffindex perl -ne 'print if /^>/'`
- **Parallel processing (MPI)**:
  `mpirun -np 4 ffindex_apply_mpi data.ffdata data.ffindex -- your_command`
- **Parallel processing with output**:
  `mpirun -np 4 ffindex_apply_mpi data.ffdata data.ffindex -i out.ffindex -o out.ffdata -- your_command`

## Expert Tips and Best Practices
- **Sorting Requirement**: If you forget to sort during the build process, `ffindex_get` will fail to find entries. Use `ffindex_modify -s` to fix this.
- **Environment Setup**: Ensure the binaries are in your `PATH`. If you compiled from source, you may need to set `LD_LIBRARY_PATH` (Linux) or `DYLD_LIBRARY_PATH` (macOS) to point to the ffindex library directory.
- **Memory Mapping**: ffindex uses `mmap` for performance. This means it is very fast for random access but relies on the operating system's virtual memory management.
- **Concatenation**: Files in the `.ffdata` file are separated by `\0`. Keep this in mind if you are manually inspecting the data file.

## Reference documentation
- [GitHub Repository README](./references/github_com_soedinglab_ffindex_soedinglab.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_ffindex_overview.md)