# metacache CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| metacache_build | PASS | tiny database from nf-core sarscov2 and insect mitochondrial genomes; the accession-to-taxid map is planted |
| metacache_build+query | PASS |  |
| metacache_info | PASS |  |
| metacache_merge | PASS |  |
| metacache_modify | PASS |  |
| metacache_query | PASS |  |

## metacache_build

### Tool Description
Build a metacache database from sequence files or directories.

#

## metacache_info

### Tool Description
Show database and reference sequence properties stored in a MetaCache database.

### Metadata
- **Docker Image**: quay.io/biocontainers/metacache:2.6.0--h077b44d_0
- **Homepage**: https://github.com/muellan/metacache
- **Package**: https://anaconda.org/channels/bioconda/packages/metacache/overview
- **Validation**: PASS

### Original Help Text
```text
SYNOPSIS

    metacache info [<database> ]
    metacache info [<database> reference [<sequence_id>]... ]
    metacache info [<database> rank <rank_name> ]
    metacache info [<database> lineages ]
    metacache info [<database> statistics ]
    metacache info [<database> locations ]
    metacache info [<database> featurecounts ]


DESCRIPTION

    Display (meta-)information stored in a database.


SUB-MODES

    metacache info
        show basic properties of MetaCache executable (data type widths, etc.)

    matacache info <database>
        show basic properties of <database>

    matacache info <database> ref[erence]
       list meta information for all reference sequences in <database>

    matacache info <database> ref[erence] <sequence_id>...
       list meta information for specific reference sequences

    matacache info <database> rank <rank_name>
       list reference sequence distribution on rank <rank_name>

    matacache info <database> lin[eages]
       print table with ranked lineages for all reference sequences

    matacache info <database> stat[istics]
       print database statistics / hash table properties

    matacache info <database> loc[ations]
       print map (feature -> list of reference locations)
       Not available in the GPU version.

    matacache info <database> featurecounts
       print map (feature -> number of reference locations)
       Not available in the GPU version.


PARAMETERS

    <database>        Name of database.
                      A MetaCache database contains taxonomic information and
                      min-hash signatures of reference sequences (complete
                      genomes, scaffolds, contigs, ...).

    <rank_name>       Valid values: sequence, form, variety, subspecies,
                      species, subgenus, genus, subtribe, tribe, subfamily,
                      family, suborder, order, subclass, class, subphylum,
                      phylum, subkingdom, kingdom, domain


EXAMPLES

    List metadata for all reference sequences in database 'refseq':
        metacache info refseq ref

    List metadata for the sequence with id NC_12345.6 in database 'refseq':
        metacache info refseq ref NC_12345.6

    List distribution of the number of sequences on rank 'phylum':
        metacache info refseq rank phylum
```

## Metadata
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

## Metadata
- **Skill**: generated
