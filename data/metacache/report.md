# metacache CWL Generation Report

## metacache_help

### Tool Description
MetaCache  Copyright (C) 2016-2026  André Müller & Robin Kobus
This program comes with ABSOLUTELY NO WARRANTY.
This is free software, and you are welcome to redistribute it
under certain conditions. See the file 'LICENSE' for details.

### Metadata
- **Docker Image**: quay.io/biocontainers/metacache:2.6.0--h077b44d_0
- **Homepage**: https://github.com/muellan/metacache
- **Package**: https://anaconda.org/channels/bioconda/packages/metacache/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/metacache/overview
- **Total Downloads**: 32.3K
- **Last updated**: 2026-01-22
- **GitHub**: https://github.com/muellan/metacache
- **Stars**: N/A
### Original Help Text
```text
MetaCache  Copyright (C) 2016-2026  André Müller & Robin Kobus
This program comes with ABSOLUTELY NO WARRANTY.
This is free software, and you are welcome to redistribute it
under certain conditions. See the file 'LICENSE' for details.

USAGE:

    metacache <MODE> [OPTION...]

    Available modes:

    help          shows documentation
    build         build new database from reference sequences (usually genomes)
    modify        add reference sequences and/or taxonomy to existing database
    query         classify read sequences using pre-built database
    build+query   build new database and query directly afterwards
    merge         merge classification results of independent queries
    info          show database and reference sequence properties


EXAMPLES:

    Query single FASTA file 'myreads.fna' against pre-built database 'refseq':
        metacache query refseq myreads.fna -out results.txt
    same with output to the console:
        metacache query refseq myreads.fna

    Query all sequence files in folder 'test' againgst database 'refseq':
        metacache query refseq test -out results.txt

    Query paired-end reads in separate files:
        metacache query refseq reads1.fa reads2.fa -pairfiles -out results.txt

    Query paired-end reads in one file (a1,a2,b1,b2,...):
        metacache query refseq paired_reads.fa -pairseq -out results.txt

    View documentation for query mode:
        metacache help query

    View documentation on how to build databases:
        metacache help build
```


## metacache_build

### Tool Description
Build a metacache database from sequence files or directories.

### Metadata
- **Docker Image**: quay.io/biocontainers/metacache:2.6.0--h077b44d_0
- **Homepage**: https://github.com/muellan/metacache
- **Package**: https://anaconda.org/channels/bioconda/packages/metacache/overview
- **Validation**: PASS

### Original Help Text
```text
ERROR: Invalid command line arguments!

unknown argument: --help
Database name is missing!
No reference sequence files provided or found!

USAGE:
    metacache build <database> <sequence file/directory>... [OPTION]...

    metacache build <database> [OPTION]... <sequence file/directory>...


You can view the full interface documentation of mode 'build' with:
    metacache help build | less
```


## metacache_modify

### Tool Description
Modify a metacache database with new sequence files.

### Metadata
- **Docker Image**: quay.io/biocontainers/metacache:2.6.0--h077b44d_0
- **Homepage**: https://github.com/muellan/metacache
- **Package**: https://anaconda.org/channels/bioconda/packages/metacache/overview
- **Validation**: PASS

### Original Help Text
```text
ERROR: Invalid command line arguments!

unknown argument: --help
Database name is missing!
No reference sequence files provided or found!

USAGE:
    metacache modify <database> <sequence file/directory>... [OPTION]...

    metacache modify <database> [OPTION]... <sequence file/directory>...


You can view the full interface documentation of mode 'modify' with:
    metacache help modify | less
```


## metacache_query

### Tool Description
Query a metacache database with sequence files or directories.

### Metadata
- **Docker Image**: quay.io/biocontainers/metacache:2.6.0--h077b44d_0
- **Homepage**: https://github.com/muellan/metacache
- **Package**: https://anaconda.org/channels/bioconda/packages/metacache/overview
- **Validation**: PASS

### Original Help Text
```text
ERROR: Invalid command line arguments!

unknown argument: --help
Database filename is missing!

USAGE:
    metacache query <database>

    metacache query <database> <sequence file/directory>... [OPTION]...

    metacache query <database> [OPTION]... <sequence file/directory>...


You can view the full interface documentation of mode 'query' with:
    metacache help query | less
```


## metacache_build+query

### Tool Description
Builds and queries a sequence cache.

### Metadata
- **Docker Image**: quay.io/biocontainers/metacache:2.6.0--h077b44d_0
- **Homepage**: https://github.com/muellan/metacache
- **Package**: https://anaconda.org/channels/bioconda/packages/metacache/overview
- **Validation**: PASS

### Original Help Text
```text
ERROR: Invalid command line arguments!

unknown argument: --help
No reference sequence files provided or found!

USAGE:
    metacache build+query -targets <sequence file/directory>... [OPTION]...

    metacache build+query [OPTION]... -targets <sequence file/directory>...

    metacache build+query -targets <sequence file/directory>... -query <sequence file/directory>... [OPTION]...

    metacache build+query -targets <sequence file/directory>... [OPTION]... -query <sequence file/directory>...

    metacache build+query [OPTION]... -targets <sequence file/directory>... -query <sequence file/directory>...


You can view the full interface documentation of mode 'build+query' with:
    metacache help build+query | less
```


## metacache_merge

### Tool Description
Merge query files or directories with taxonomy information.

### Metadata
- **Docker Image**: quay.io/biocontainers/metacache:2.6.0--h077b44d_0
- **Homepage**: https://github.com/muellan/metacache
- **Package**: https://anaconda.org/channels/bioconda/packages/metacache/overview
- **Validation**: PASS

### Original Help Text
```text
ERROR: Invalid command line arguments!

unknown argument: --help
No query output filenames provided!
Taxonomy path missing. Use '-taxonomy <path>'!
Taxonomy path missing after '-taxonomy'!

USAGE:
    metacache merge <query file/directory>... -taxonomy <path> [-out <result>] [OPTION]...

    metacache merge -taxonomy <path> [-out <result>] [OPTION]... <query file/directory>...


You can view the full interface documentation of mode 'merge' with:
    metacache help merge | less
```


## metacache_info

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/metacache:2.6.0--h077b44d_0
- **Homepage**: https://github.com/muellan/metacache
- **Package**: https://anaconda.org/channels/bioconda/packages/metacache/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
------------------------------------------------
MetaCache version  2.6.0 (20260121)
database version   20200820
------------------------------------------------
sequence type      mc::char_sequence
target id type     unsigned int 32 bits
target limit       4294967295
------------------------------------------------
window id type     unsigned int 32 bits
window limit       4294967295
window length      0
window stride      0
------------------------------------------------
sketcher type      mc::single_function_unique_min_hasher<unsigned int, mc::same_size_hash<unsigned int> >
feature type       unsigned int 32 bits
feature hash       mc::same_size_hash<unsigned int>
kmer size          0
kmer limit         16
sketch size        0
------------------------------------------------
bucket size type   unsigned char 8 bits
max. locations     254
location limit     254
------------------------------------------------
hit classifier       mc::best_distinct_matches_in_contiguous_window_ranges
------------------------------------------------
```


## Metadata
- **Skill**: generated
