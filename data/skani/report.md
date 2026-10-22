# skani CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| skani_dist | PASS |  |
| skani_search | PASS |  |
| skani_sketch | PASS |  |
| skani_triangle | PASS |  |

## skani_dist

### Tool Description
Compute ANI for queries against references fasta files or pre-computed sketch files.

### Metadata
- **Docker Image**: quay.io/biocontainers/skani:0.3.1--ha6fb395_0
- **Homepage**: https://github.com/bluenote-1577/skani
- **Package**: https://anaconda.org/channels/bioconda/packages/skani/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/skani/overview
- **Total Downloads**: 41.5K
- **Last updated**: 2025-10-12
- **GitHub**: https://github.com/bluenote-1577/skani
- **Stars**: N/A
### Original Help Text
```text
skani-dist 
Compute ANI for queries against references fasta files or pre-computed sketch files. Usage: skani
dist query.fa ref1.fa ref2.fa ... or use -q/--ql and -r/--rl options

USAGE:
    skani dist [OPTIONS] <QUERY|-q <QUERIES>...|--ql <QUERY_LIST>> [--] [REFERENCE]...

OPTIONS:
    -h, --help          Print help information
    -t <THREADS>        Number of threads [default: 3]

INPUTS:
    -q <QUERIES>...              Query fasta(s) or sketch(es)
        --qi                     Use individual sequences for the QUERY in a multi-line fasta
        --ql <QUERY_LIST>        File with each line containing one fasta/sketch file
    -r <REFERENCES>...           Reference fasta(s) or sketch(es)
        --ri                     Use individual sequences for the REFERENCE in a multi-line fasta
        --rl <REFERENCE_LIST>    File with each line containing one fasta/sketch file
    <QUERY>                  Query fasta or sketch
    <REFERENCE>...           Reference fasta(s) or sketch(es)

OUTPUT:
    -o <OUTPUT>                        Output file name; rewrites file by default [default: output
                                       to stdout]
        --min-af <MIN_AF>              Only output ANI values where one genome has aligned fraction
                                       > than this value. [default: 15]
        --both-min-af <BOTH_MIN_AF>    Only output ANI values where both genomes have aligned
                                       fraction > than this value. [default: disabled]
        --ci                           Output [5%,95%] ANI confidence intervals using percentile
                                       bootstrap on the putative ANI distribution
        --detailed                     Print additional info including contig N50s and more
    -n <N>                             Max number of results to show for each query. [default:
                                       unlimited]
        --short-header                 Only display the first part of contig names (before first
                                       whitespace)

PRESETS:
        --fast             Faster skani mode; 2x faster and less memory. Less accurate AF and less
                           accurate ANI for distant genomes, but works ok for high N50 and > 95%
                           ANI. Alias for -c 200
        --medium           Medium skani mode; 2x slower and more memory. More accurate AF and more
                           accurate ANI for moderately fragmented assemblies (< 10kb N50). Alias for
                           -c 70
        --slow             Slower skani mode; 4x slower and more memory. Gives much more accurate AF
                           for distant genomes. More accurate ANI for VERY fragmented assemblies (<
                           3kb N50), but less accurate ANI otherwise. Alias for -c 30
        --small-genomes    Mode for small genomes such as viruses or plasmids (< 20 kb). Can be much
                           faster for large data, but is slower/less accurate on bacterial-sized
                           genomes. Alias for: -c 30 -m 200 --faster-small

ALGORITHM PARAMETERS:
    -c <C>                   Compression factor (k-mer subsampling rate). [default: 125]
        --faster-small       Filter genomes with < 20 marker k-mers more aggressively. Much faster
                             for many small genomes but may miss some comparisons
    -m <MARKER_C>            Marker k-mer compression factor. Markers are used for filtering.
                             Consider decreasing to ~200-300 if working with small genomes (e.g.
                             plasmids or viruses). [default: 1000]
        --median             Estimate median identity instead of average (mean) identity
        --no-learned-ani     Disable regression model for ANI prediction. [default: learned ANI used
                             for c >= 70 and >= 150,000 bases aligned and not on individual contigs]
        --no-marker-index    Do not use hash-table inverted index for faster ANI filtering.
                             [default: load index if > 100 query files or using the --qi option]
        --robust             Estimate mean after trimming off 10%/90% quantiles
    -s <S>                   Screen out pairs with *approximately* < % identity using k-mer
                             sketching. [default: 80]

MISC:
        --trace    Trace level verbosity
    -v, --debug    Debug level verbosity
```

## skani_search

### Tool Description
Search queries against a large pre-sketched database of reference genomes in a memory efficient manner.

### Metadata
- **Docker Image**: quay.io/biocontainers/skani:0.3.1--ha6fb395_0
- **Homepage**: https://github.com/bluenote-1577/skani
- **Package**: https://anaconda.org/channels/bioconda/packages/skani/overview
- **Validation**: PASS

### Original Help Text
```text
skani-search 
Search queries against a large pre-sketched database of reference genomes in a memory efficient
manner. Usage: skani search -d sketch_folder query1.fa query2.fa ...

USAGE:
    skani search [OPTIONS] -d <DATABASE> <QUERY|-q <QUERIES>...|--ql <QUERY_LIST>> [--]

OPTIONS:
    -h, --help          Print help information
    -t <THREADS>        Number of threads [default: 3]

INPUTS:
    -d <DATABASE>            Output folder from `skani sketch`
    -q <QUERIES>...          Query fasta(s) or sketch(es)
        --qi                 Use individual sequences for the QUERY in a multi-line fasta
        --ql <QUERY_LIST>    File with each line containing one fasta/sketch file
    <QUERY>...           Query fasta(s) or sketch(es)

OUTPUT:
    -o <OUTPUT>                        Output file name; rewrites file by default [default: output
                                       to stdout]
        --both-min-af <BOTH_MIN_AF>    Only output ANI values where both genomes have aligned
                                       fraction > than this value. [default: disabled]
        --ci                           Output [5%,95%] ANI confidence intervals using percentile
                                       bootstrap on the putative ANI distribution
        --detailed                     Print additional info including contig N50s and more
        --min-af <MIN_AF>              Only output ANI values where one genome has aligned fraction
                                       > than this value. [default: 15]
    -n <N>                             Max number of results to show for each query. [default:
                                       unlimited]
        --short-header                 Only display the first part of contig names (before first
                                       whitespace)

ALGORITHM PARAMETERS:
        --keep-refs          Keep reference sketches in memory if the sketch passes the marker
                             filter. Takes more memory but is much faster when querying many similar
                             sequences
        --median             Estimate median identity instead of average (mean) identity
        --no-learned-ani     Disable regression model for ANI prediction. [default: learned ANI used
                             for c >= 70 and >= 150,000 bases aligned and not on individual contigs]
        --no-marker-index    Do not use hash-table inverted index for faster ANI filtering.
                             [default: load index if > 100 query files or using the --qi option]
        --robust             Estimate mean after trimming off 10%/90% quantiles
    -s <S>                   Screen out pairs with *approximately* < % identity using k-mer
                             sketching. [default: 80]

MISC:
        --trace    Trace level verbosity
    -v, --debug    Debug level verbosity
```

## skani_sketch

### Tool Description
Sketch (index) genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/skani:0.3.1--ha6fb395_0
- **Homepage**: https://github.com/bluenote-1577/skani
- **Package**: https://anaconda.org/channels/bioconda/packages/skani/overview
- **Validation**: PASS

### Original Help Text
```text
skani-sketch 
Sketch (index) genomes. Usage: skani sketch genome1.fa genome2.fa ... -o new_sketch_folder

USAGE:
    skani sketch [OPTIONS] -o <OUTPUT> <FASTA_FILES|-l <FASTA_LIST>>

OPTIONS:
    -h, --help          Print help information
    -t <THREADS>        Number of threads [default: 3]

INPUT/OUTPUT:
    -o <OUTPUT>                Output folder where sketch files are placed
    -i                         Use individual sequences instead the entire file for multi-fastas
    -l <FASTA_LIST>            File with each line containing one fasta/sketch file
        --separate-sketches    Create separate .sketch files instead of consolidated database
                               format. DOES NOT WORK WITH -i
    <FASTA_FILES>...       fastas to sketch

PRESETS:
        --fast      Faster skani mode; 2x faster and less memory. Less accurate AF and less accurate
                    ANI for distant genomes, but works ok for high N50 and > 95% ANI. Alias for -c
                    200
        --medium    Medium skani mode; 2x slower and more memory. More accurate AF and more accurate
                    ANI for moderately fragmented assemblies (< 10kb N50). Alias for -c 70
        --slow      Slower skani mode; 4x slower and more memory. Gives much more accurate AF for
                    distant genomes. More accurate ANI for VERY fragmented assemblies (< 3kb N50),
                    but less accurate ANI otherwise. Alias for -c 30

SKETCH PARAMETERS:
    -c <C>               Compression factor (k-mer subsampling rate). [default: 125]
    -m <MARKER_C>        Marker k-mer compression factor. Markers are used for filtering. Consider
                         decreasing to ~200-300 if working with small genomes (e.g. plasmids or
                         viruses). [default: 1000]

MISC:
        --trace    Trace level verbosity
    -v, --debug    Debug level verbosity
```

## skani_triangle

### Tool Description
Compute a lower triangular ANI/AF matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/skani:0.3.1--ha6fb395_0
- **Homepage**: https://github.com/bluenote-1577/skani
- **Package**: https://anaconda.org/channels/bioconda/packages/skani/overview
- **Validation**: PASS

### Original Help Text
```text
skani-triangle 
Compute a lower triangular ANI/AF matrix. Usage: skani triangle genome1.fa genome2.fa genome3.fa ...

USAGE:
    skani triangle [OPTIONS] <-l <FASTA_LIST>|FASTA_FILES>

OPTIONS:
    -h, --help          Print help information
    -t <THREADS>        Number of threads [default: 3]

INPUTS:
    -i                      Use individual sequences instead the entire file for multi-fastas
    -l <FASTA_LIST>         File with each line containing one fasta/sketch file
    <FASTA_FILES>...    Fasta(s) or sketch(es)

OUTPUT:
    -o <OUTPUT>                        Output file name; rewrites file by default [default: output
                                       to stdout]
        --both-min-af <BOTH_MIN_AF>    Only output ANI values where both genomes have aligned
                                       fraction > than this value. [default: disabled]
        --ci                           Output [5%,95%] ANI confidence intervals using percentile
                                       bootstrap on the putative ANI distribution. Only works with
                                       --sparse or -E
        --detailed                     Print additional info including contig N50s and more
        --diagonal                     Output the diagonal of the ANI matrix (i.e. self-self
                                       comparisons) for both dense and sparse matrices
        --distance                     Output 100 - ANI instead of ANI, creating a distance instead
                                       of a similarity matrix. No effect if using --sparse or -E
    -E, --sparse                       Output comparisons in a row-by-row form (i.e. sparse matrix)
                                       in the same form as `skani dist`. Only pairs with aligned
                                       fraction > --min-af are output
        --full-matrix                  Output full matrix instead of lower-triangular matrix
        --min-af <MIN_AF>              Only output ANI values where one genome has aligned fraction
                                       > than this value. [default: 15]
        --short-header                 Only display the first part of contig names (before first
                                       whitespace)

PRESETS:
        --fast             Faster skani mode; 2x faster and less memory. Less accurate AF and less
                           accurate ANI for distant genomes, but works ok for high N50 and > 95%
                           ANI. Alias for -c 200
        --medium           Medium skani mode; 2x slower and more memory. More accurate AF and more
                           accurate ANI for moderately fragmented assemblies (< 10kb N50). Alias for
                           -c 70
        --slow             Slower skani mode; 4x slower and more memory. Gives much more accurate AF
                           for distant genomes. More accurate ANI for VERY fragmented assemblies (<
                           3kb N50), but less accurate ANI otherwise. Alias for -c 30
        --small-genomes    Mode for small genomes such as viruses or plasmids (< 20 kb). Can be much
                           faster for large data, but is slower/less accurate on bacterial-sized
                           genomes. Alias for: -c 30 -m 200 --faster-small

ALGORITHM PARAMETERS:
    -c <C>                  Compression factor (k-mer subsampling rate). [default: 125]
        --faster-small      Filter genomes with < 20 marker k-mers more aggressively. Much faster
                            for many small genomes but may miss some comparisons
    -m <MARKER_C>           Marker k-mer compression factor. Markers are used for filtering.
                            Consider decreasing to ~200-300 if working with small genomes (e.g.
                            plasmids or viruses). [default: 1000]
        --median            Estimate median identity instead of average (mean) identity
        --no-learned-ani    Disable regression model for ANI prediction. [default: learned ANI used
                            for c >= 70 and >= 150,000 bases aligned and not on individual contigs]
        --robust            Estimate mean after trimming off 10%/90% quantiles
    -s <S>                  Screen out pairs with *approximately* < % identity using k-mer
                            sketching. [default: 80]

MISC:
        --trace    Trace level verbosity
    -v, --debug    Debug level verbosity
```

## Metadata
- **Skill**: generated
