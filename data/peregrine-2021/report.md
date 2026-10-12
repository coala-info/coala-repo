# peregrine-2021 CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| peregrine-2021_pg_asm | PASS |  |
| peregrine-2021_pg_build_idx | PASS |  |
| peregrine-2021_pg_build_sdb | PASS |  |
| peregrine-2021_pg_dedup | PASS |  |
| peregrine-2021_pg_dp_graph | PASS |  |
| peregrine-2021_pg_getreads | PASS |  |
| peregrine-2021_pg_graph | PASS |  |
| peregrine-2021_pg_layout | PASS |  |
| peregrine-2021_pg_ovlp | PASS |  |
| peregrine-2021_pg_ovlp_ec | PASS |  |
| peregrine-2021_pg_resolve | PASS |  |

## Metadata
- **Skill**: generated

## peregrine-2021_pg_asm

### Tool Description
Peregrine-2021 genome assembler: the main workflow entry for end-to-end assembly from the reads

### Metadata
- **Docker Image**: quay.io/biocontainers/peregrine-2021:0.4.13--ha6fb395_6
- **Homepage**: https://github.com/cschin/peregrine-2021
- **Package**: https://anaconda.org/channels/bioconda/packages/peregrine-2021/overview
- **Validation**: PASS
### Original Help Text
```text
pg_asm peregrine-r 0.4.13 (bioconda release build, linux [x86_64] [rustc 1.89.0 (29483883e 2025-08-04)])
Jason Chin <jason@omnibio.ai>

Peregrine-2021 genome assembler
pg_asm: the main workflow entry for end-to-end assembly from the reads
LICENSE: http://creativecommons.org/licenses/by-nc-sa/4.0/

USAGE:
    pg_asm [FLAGS] [OPTIONS] <input_reads> <work_dir> [ARGS]

FLAGS:
        --fast          run the assembler in the fast mode
    -h, --help          Prints help information
        --keep          keep intermediate files
        --no_resolve    disable resolving repeats / dups at the end
    -V, --version       Prints version information

OPTIONS:
    -b, --bestn <bestn>              number of best overlaps for initial graph [default: 6]
    -k <k>                           Kmer size [default: 56]
    -l <layout_method>               layout version [default: 2]
        --log <log>                  log level: DBBUG or INFO (default)
    -c, --min_ec_cov <min_ec_cov>    Minimum error coverage [default: 1]
    -r <r>                           Reduction factor [default: 6]
    -t, --tol <tol>                  Alignment tolerance [default: 0.01]
    -w <w>                           Window size [default: 80]

ARGS:
    <input_reads>    Path to a file that contains the list of reads in .fa .fa.gz .fastq or fastq.gz formats
    <work_dir>       The path to a work directory for intermediate files and the results
    <NTHREADS>       Number of threads
    <NCHUNKS>        Number of partition
```

## peregrine-2021_pg_build_sdb

### Tool Description
Build the sequence database from the reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/peregrine-2021:0.4.13--ha6fb395_6
- **Homepage**: https://github.com/cschin/peregrine-2021
- **Package**: https://anaconda.org/channels/bioconda/packages/peregrine-2021/overview
- **Validation**: PASS

### Original Help Text
```text
pg_build_sdb peregrine-r 0.4.13 (bioconda release build, linux [x86_64] [rustc 1.89.0 (29483883e 2025-08-04)])
Jason Chin <jason@omnibio.ai>

Peregrine-2021 genome assembler 
pb_build_sdb: build the sequence database
LICENSE: http://creativecommons.org/licenses/by-nc-sa/4.0/

USAGE:
    pg_build_sdb [OPTIONS] --input <input> --out_prefix <out_prefix>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
        --input <input>              Path to a file that contains the list of reads in .fa .fa.gz .fastq or fastq.gz
                                     formats
        --log <log>                  log level: DBBUG or INFO (default)
        --out_prefix <out_prefix>    The prefix for the sequence database and index files
```

## peregrine-2021_pg_build_idx

### Tool Description
Build the SHIMMER index from the reads for overlapping.

### Metadata
- **Docker Image**: quay.io/biocontainers/peregrine-2021:0.4.13--ha6fb395_6
- **Homepage**: https://github.com/cschin/peregrine-2021
- **Package**: https://anaconda.org/channels/bioconda/packages/peregrine-2021/overview
- **Validation**: PASS

### Original Help Text
```text
pg_build_idx peregrine-r 0.4.13 (bioconda release build, linux [x86_64] [rustc 1.89.0 (29483883e 2025-08-04)])
Jason Chin <jason@omnibio.ai>

Peregrine-2021 genome assembler
build the SHIMMER index from the reads for overlapping
LICENSE: http://creativecommons.org/licenses/by-nc-sa/4.0/

USAGE:
    pg_build_idx [OPTIONS] <SEQDB> <SEQIDX> <SHMRINDEXPREFIX> <NTHREADS> <NCHUNKS>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
    -k <k>             Kmer size [default: 56]
        --log <log>    log level: DBBUG or INFO (default)
    -r <r>             Reduction factor [default: 6]
    -w <w>             Window size [default: 80]

ARGS:
    <SEQDB>              Path to the seqdb file 
    <SEQIDX>             Path to the seqdb index file
    <SHMRINDEXPREFIX>    The prefix to the output shimmer index database
    <NTHREADS>           Number of threads
    <NCHUNKS>            Number of partition
```

## peregrine-2021_pg_ovlp

### Tool Description
Generate haplotype specific overlaps between the reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/peregrine-2021:0.4.13--ha6fb395_6
- **Homepage**: https://github.com/cschin/peregrine-2021
- **Package**: https://anaconda.org/channels/bioconda/packages/peregrine-2021/overview
- **Validation**: PASS

### Original Help Text
```text
pg_ovlp peregrine-r 0.4.13 (bioconda release build, linux [x86_64] [rustc 1.89.0 (29483883e 2025-08-04)])
Jason Chin <jason@omnibio.ai>

Peregrine-2021 genome assembler, 
pg_ovlp: generate haplotype specific overlaps between the reads
LICENSE: http://creativecommons.org/licenses/by-nc-sa/4.0/

USAGE:
    pg_ovlp [OPTIONS] <SEQDB> <SEQIDX> <SHMRINDEXPREFIX> <OUTPREFIX> <NTHREADS> <NCHUNKS>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
        --log <log>    log level: DBBUG or INFO (default)
    -t, --tol <tol>    Alignment tolerance [default: 0.01]

ARGS:
    <SEQDB>              Path to the seqdb file 
    <SEQIDX>             Path to the seqdb index file
    <SHMRINDEXPREFIX>    The prefix to the output shimmer index database
    <OUTPREFIX>          The prefix of the output ovelap files
    <NTHREADS>           Number of threads 
    <NCHUNKS>            Number of partition
```

## peregrine-2021_pg_ovlp_ec

### Tool Description
Perform error correction from the haplotype specific overlaps.

### Metadata
- **Docker Image**: quay.io/biocontainers/peregrine-2021:0.4.13--ha6fb395_6
- **Homepage**: https://github.com/cschin/peregrine-2021
- **Package**: https://anaconda.org/channels/bioconda/packages/peregrine-2021/overview
- **Validation**: PASS

### Original Help Text
```text
pg_ovlp_ec peregrine-r 0.4.13 (bioconda release build, linux [x86_64] [rustc 1.89.0 (29483883e 2025-08-04)])
Jason Chin <jason@omnibio.ai>

Peregrine-2021 genome assembler, 
pg_ovlp_ec: perform error correction from the haplotype specific overlaps
LICENSE: http://creativecommons.org/licenses/by-nc-sa/4.0/

USAGE:
    pg_ovlp_ec [OPTIONS] <SEQDB> <SEQIDX> <prefix> <out_prefix> <NTHREADS> <NCHUNKS>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
        --log <log>                  log level: DBBUG or INFO (default)
    -c, --min_ec_cov <min_ec_cov>    Minimum error coverage [default: 1]
    -t, --tol <tol>                  Alignment tolerance [default: 0.01]

ARGS:
    <SEQDB>         Path to the seqdb file 
    <SEQIDX>        Path to the seqdb index file
    <prefix>        The prefix to the output shimmer index database
    <out_prefix>    The prefix of the output ovelap files
    <NTHREADS>      Number of threads 
    <NCHUNKS>       Number of partition
```

## peregrine-2021_pg_dp_graph

### Tool Description
Generate the layout file from overlap data with a polyploid aware layout algorithm.

### Metadata
- **Docker Image**: quay.io/biocontainers/peregrine-2021:0.4.13--ha6fb395_6
- **Homepage**: https://github.com/cschin/peregrine-2021
- **Package**: https://anaconda.org/channels/bioconda/packages/peregrine-2021/overview
- **Validation**: PASS

### Original Help Text
```text
pg_graph peregrine-r 0.4.13 (bioconda release build, linux [x86_64] [rustc 1.89.0 (29483883e 2025-08-04)])
Jason Chin <jason@omnibio.ai>

Peregrine-2021 genome assembler, 
pg_dp_graph: take overlap data file as input to generate the layout file using a polyploid aware layout algorithm
LICENSE: http://creativecommons.org/licenses/by-nc-sa/4.0/

USAGE:
    pg_dp_graph [OPTIONS] --out_prefix <out_prefix> --prefix <prefix>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
    -b, --bestn <bestn>              number of best overlaps for initial graph [default: 6]
        --log <log>                  log level: DBBUG or INFO (default)
        --out_prefix <out_prefix>    ath prefix for output files 
        --prefix <prefix>            Path prefix for input files
```

## peregrine-2021_pg_graph

### Tool Description
(Obsoleted) convert the overlap information between the reads into an assembly graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/peregrine-2021:0.4.13--ha6fb395_6
- **Homepage**: https://github.com/cschin/peregrine-2021
- **Package**: https://anaconda.org/channels/bioconda/packages/peregrine-2021/overview
- **Validation**: PASS

### Original Help Text
```text
pg_graph peregrine-r 0.4.13 (bioconda release build, linux [x86_64] [rustc 1.89.0 (29483883e 2025-08-04)])
Jason Chin <jason@omnibio.ai>

Peregrine-2021 genome assembler, 
pg_graph: (obsoleted) convert the overlap information between the reads into an assembly group
LICENSE: http://creativecommons.org/licenses/by-nc-sa/4.0/

USAGE:
    pg_graph [OPTIONS] --out_prefix <out_prefix> --prefix <prefix>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
        --log <log>                  log level: DBBUG or INFO (default)
        --out_prefix <out_prefix>    Path prefix for output files 
        --prefix <prefix>            Path prefix for input files
```

## peregrine-2021_pg_layout

### Tool Description
Convert the assembly graph to paths and generate the contig fasta file.

### Metadata
- **Docker Image**: quay.io/biocontainers/peregrine-2021:0.4.13--ha6fb395_6
- **Homepage**: https://github.com/cschin/peregrine-2021
- **Package**: https://anaconda.org/channels/bioconda/packages/peregrine-2021/overview
- **Validation**: PASS

### Original Help Text
```text
pg_layout peregrine-r 0.4.13 (bioconda release build, linux [x86_64] [rustc 1.89.0 (29483883e 2025-08-04)])
Jason Chin <jason@omnibio.ai>

Peregrine-2021 genome assembler, 
pg_layout: convert the assembly graph to paths and generate the contig fasta file
LICENSE: http://creativecommons.org/licenses/by-nc-sa/4.0/

USAGE:
    pg_layout [OPTIONS] <SEQDB> <SEQIDX> --layout_file <layout_file> --output <output_file>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
        --layout_file <layout_file>    Path to the layout file
        --log <log>                    log level: DBBUG or INFO (default)
        --output <output_file>         Path to the output file

ARGS:
    <SEQDB>     Path to the seqdb file 
    <SEQIDX>    Path to the seqdb index file
```

## peregrine-2021_pg_getreads

### Tool Description
Generate a fasta file for a subset of reads from the sequence database.

### Metadata
- **Docker Image**: quay.io/biocontainers/peregrine-2021:0.4.13--ha6fb395_6
- **Homepage**: https://github.com/cschin/peregrine-2021
- **Package**: https://anaconda.org/channels/bioconda/packages/peregrine-2021/overview
- **Validation**: PASS

### Original Help Text
```text
pg_getreads peregrine-r 0.4.13 (bioconda release build, linux [x86_64] [rustc 1.89.0 (29483883e 2025-08-04)])
Jason Chin <jason@omnibio.ai>

Peregrine-2021 genome assembler, 
pg_getreads: generate fasta file for a subset of reads from the sequence database
LICENSE: http://creativecommons.org/licenses/by-nc-sa/4.0/

USAGE:
    pg_getreads [OPTIONS] <SEQDB> <SEQIDX> <READID>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
        --log <log>    log level: DBBUG or INFO (default)

ARGS:
    <SEQDB>     Path to the seqdb file 
    <SEQIDX>    Path to the seqdb index file
    <READID>    Path to the read id file
```

## peregrine-2021_pg_resolve

### Tool Description
Align all contigs to themselves to identify haplotype-related contigs.

### Metadata
- **Docker Image**: quay.io/biocontainers/peregrine-2021:0.4.13--ha6fb395_6
- **Homepage**: https://github.com/cschin/peregrine-2021
- **Package**: https://anaconda.org/channels/bioconda/packages/peregrine-2021/overview
- **Validation**: PASS

### Original Help Text
```text
pg_resolve peregrine-r 0.4.13 (bioconda release build, linux [x86_64] [rustc 1.89.0 (29483883e 2025-08-04)])
Jason Chin <jason@omnibio.ai>

Peregrine-2021 genome assembler, 
pg_resolve: this tool aligns all contigs to themselve to identify haplotype-related contigs
LICENSE: http://creativecommons.org/licenses/by-nc-sa/4.0/

USAGE:
    pg_resolve [OPTIONS] --fasta_file <fasta_file> --out_prefix <output_prefix>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
    -f, --fasta_file <fasta_file>       Path to the layout file
    -k <k>                              Kmer size [default: 56]
        --log <log>                     log level: DBBUG or INFO (default)
    -o, --out_prefix <output_prefix>    Path to the output prefix
    -r <r>                              Reduction factor [default: 6]
    -w <w>                              Window size [default: 80]
```

## peregrine-2021_pg_dedup

### Tool Description
Perform all contigs to all contigs alignment to remove duplicates.

### Metadata
- **Docker Image**: quay.io/biocontainers/peregrine-2021:0.4.13--ha6fb395_6
- **Homepage**: https://github.com/cschin/peregrine-2021
- **Package**: https://anaconda.org/channels/bioconda/packages/peregrine-2021/overview
- **Validation**: PASS

### Original Help Text
```text
pg_resolve peregrine-r 0.4.13 (bioconda release build, linux [x86_64] [rustc 1.89.0 (29483883e 2025-08-04)])
Jason Chin <jason@omnibio.ai>

Peregrine-2021 genome assembler, 
pg_dedup: perform all contigs to all contigs alignment to remove duplicates 
LICENSE: http://creativecommons.org/licenses/by-nc-sa/4.0/

USAGE:
    pg_dedup [OPTIONS] --output <output> --ref_fasta <ref_fasta> --target_fasta <target_fasta>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
    -k <k>                               Kmer size [default: 56]
        --log <log>                      log level: DBBUG or INFO (default)
    -o, --output <output>                Path to the output filename
    -r <r>                               Reduction factor [default: 4]
    -f, --ref_fasta <ref_fasta>          Path to the reference file
    -t, --target_fasta <target_fasta>    Path to the target file
    -w <w>                               Window size [default: 48]
```
