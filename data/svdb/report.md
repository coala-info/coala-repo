# svdb CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| svdb_build | PASS |  |
| svdb_export | PASS |  |
| svdb_merge | PASS |  |
| svdb_query | PASS |  |

## svdb_build

### Tool Description
SVDB build module

### Metadata
- **Docker Image**: quay.io/biocontainers/svdb:2.8.4--py311h7c5c6c8_0
- **Homepage**: https://github.com/J35P312/SVDB
- **Package**: https://anaconda.org/channels/bioconda/packages/svdb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: SVDB-2.8.4: build module [-h] [--build] [--passonly]
                                [--files [FILES ...]] [--folder FOLDER]
                                [--prefix PREFIX]

options:
  -h, --help           show this help message and exit
  --build              create a db
  --passonly           Remove filtered variants (i.e anything not labeled
                       "PASS" or ".")
  --files [FILES ...]  create a db using the specified vcf files(cannot be
                       used with --folder)
  --folder FOLDER      create a db using all the vcf files in the folders
  --prefix PREFIX      the prefix of the output file, default = SVDB
```

## svdb_merge

### Tool Description
SVDB merge module

### Metadata
- **Docker Image**: quay.io/biocontainers/svdb:2.8.4--py311h7c5c6c8_0
- **Homepage**: https://github.com/J35P312/SVDB
- **Package**: https://anaconda.org/channels/bioconda/packages/svdb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: SVDB-2.8.4: vcf_merge module [-h] [--merge] [--notag] --vcf [VCF ...]
                                    [--priority PRIORITY]
                                    [--bnd_distance BND_DISTANCE]
                                    [--ins_distance INS_DISTANCE]
                                    [--overlap OVERLAP] [--no_intra]
                                    [--no_var] [--pass_only] [--same_order]

options:
  -h, --help            show this help message and exit
  --merge               merge structural variants
  --notag               Do not add the the VARID and set entries to the info
                        field
  --vcf [VCF ...]       input vcf files, all input vcf files will be merged
                        into one. Use the --prioriy flag to prioritize the
                        callers/vcf files
  --priority PRIORITY   prioritise the input files, using the following format
                        --vcf caller1.vcf:2 caller2.vcf:1 --priority: 1,2
  --bnd_distance BND_DISTANCE
                        the maximum distance between two similar precise
                        breakpoints(default = 2000)
  --ins_distance INS_DISTANCE
                        the maximum distance to merge two insertions(default =
                        50)
  --overlap OVERLAP     the overlap required to merge two events(0 means
                        anything that touches will be merged, 1 means that two
                        events must be identical to be merged), default = 0.95
  --no_intra            no merging of variants within the same vcf
  --no_var              variants of different type will be merged
  --pass_only           merge only variants labeled PASS
  --same_order          Across all input vcf files, the order of the sample
                        columns are the same
```

## svdb_query

### Tool Description
SVDB query module

### Metadata
- **Docker Image**: quay.io/biocontainers/svdb:2.8.4--py311h7c5c6c8_0
- **Homepage**: https://github.com/J35P312/SVDB
- **Package**: https://anaconda.org/channels/bioconda/packages/svdb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: SVDB.2.8.4: query module [-h] [--query] --query_vcf QUERY_VCF [--db DB]
                                [--sqdb SQDB] [--bedpedb BEDPEDB]
                                [--in_occ IN_OCC] [--in_frq IN_FRQ]
                                [--out_occ OUT_OCC] [--out_frq OUT_FRQ]
                                [--max_frq MAX_FRQ] [--prefix PREFIX]
                                [--bnd_distance BND_DISTANCE]
                                [--ins_distance INS_DISTANCE]
                                [--overlap OVERLAP] [--memory] [--no_var]

options:
  -h, --help            show this help message and exit
  --query               query a db
  --query_vcf QUERY_VCF
                        a vcf used to query the db
  --db DB               path to a SVDB db vcf or a comma separated list of
                        vcfs
  --sqdb SQDB           path to a SVDB sqlite db or a comma separated list of
                        dbs
  --bedpedb BEDPEDB     path to a SV database of the following format chrA-
                        posA-chrB-posB-type-count-frequency, or a or a comma
                        separated list of dbs
  --in_occ IN_OCC       The allele count tag, if used, this tag must be
                        present in the INFO column of the input DB(usually set
                        to AC or OCC), required if multiple databases are
                        queried. Use default (as shown in the example in
                        README) if you'd like to use default tag for a
                        specific database
  --in_frq IN_FRQ       The frequency count tag, if used, this tag must be
                        present in the INFO column of the input DB(usually set
                        to AF or FRQ), required if multiple databases are
                        queried. Use default (as shown in the example in
                        README) if you'd like to use default tag for a
                        specific database
  --out_occ OUT_OCC     the allele count tag, as annotated by
                        SVDBvariant(default=OCC), required if multiple
                        databases are queried.
  --out_frq OUT_FRQ     the tag used to describe the frequency of the
                        variant(default=FRQ), required if multiple databases
                        are queried.
  --max_frq MAX_FRQ     Only include variants with a higher frequency than
                        given here between 0 and 1. All new variants are
                        always included. (default: 1)
  --prefix PREFIX       the prefix of the output file, default = print to
                        stdout. Required, if multiple databases are queried
  --bnd_distance BND_DISTANCE
                        the maximum distance between two similar
                        breakpoints(default = 10000)
  --ins_distance INS_DISTANCE
                        the maximum distance to merge two insertions(default =
                        50)
  --overlap OVERLAP     the overlap required to merge two events(0 means
                        anything that touches will be merged, 1 means that two
                        events must be identical to be merged), default = 0.6
  --memory              load the database into memory: increases the memory
                        requirements, but lowers the time consumption(may only
                        be used with sqdb)
  --no_var              count overlaping variants of different type as hits in
                        the db
```

## svdb_export

### Tool Description
SVDB export module

### Metadata
- **Docker Image**: quay.io/biocontainers/svdb:2.8.4--py311h7c5c6c8_0
- **Homepage**: https://github.com/J35P312/SVDB
- **Package**: https://anaconda.org/channels/bioconda/packages/svdb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: SVDB-2.8.4: export module; export the variants of the SVDB sqlite database into a vcf file
       [-h] [--export] --db DB [--no_merge] [--bnd_distance BND_DISTANCE]
       [--ins_distance INS_DISTANCE] [--overlap OVERLAP] [--DBSCAN]
       [--epsilon EPSILON] [--min_pts MIN_PTS] [--prefix PREFIX] [--memory]

options:
  -h, --help            show this help message and exit
  --export              create a db
  --db DB               The SQLite database
  --no_merge            skip the merging of variants, print all variants in
                        the db to a vcf file
  --bnd_distance BND_DISTANCE
                        the maximum distance between two similar precise
                        breakpoints(default = 2500)
  --ins_distance INS_DISTANCE
                        the maximum distance to merge two insertions(default =
                        50)
  --overlap OVERLAP     the overlap required to merge two events(0 means
                        anything that touches will be merged, 1 means that two
                        events must be identical to be merged), default = 0.8
  --DBSCAN              use dbscan to cluster the variants
  --epsilon EPSILON     used together with --DBSCAN; sets the epsilon
                        paramter(default = 500)
  --min_pts MIN_PTS     used together with 1--DBSCAN; sets the min_pts
                        parameter(default = 2)
  --prefix PREFIX       the prefix of the output file, default = same as input
  --memory              load the database into memory: increases the memory
                        requirements, but lowers the time consumption
```

