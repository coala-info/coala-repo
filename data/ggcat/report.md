# ggcat CWL Generation Report

## ggcat_build

### Tool Description
Builds a k-mer graph from input files.

### Metadata
- **Docker Image**: quay.io/biocontainers/ggcat:2.0.0--ha96b9cd_0
- **Homepage**: https://github.com/algbio/ggcat
- **Package**: https://anaconda.org/channels/bioconda/packages/ggcat/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ggcat/overview
- **Total Downloads**: 1.5K
- **Last updated**: 2025-07-16
- **GitHub**: https://github.com/algbio/ggcat
- **Stars**: N/A
### Original Help Text
```text
ggcat-build 2.0.0

USAGE:
    ggcat build [FLAGS] [OPTIONS] --kmer-length <kmer-length> [--] [input]...

FLAGS:
    -c, --colors                            Enable colors
        --eulertigs                         Generate eulertigs instead of maximal unitigs
        --fast-eulertigs                    Generate eulertigs instead of maximal unitigs, faster version
        --fast-simplitigs                   Generate simplitigs instead of maximal unitigs, faster version
    -f, --forward-only                      Treats reverse complementary kmers as different
    -e, --generate-maximal-unitigs-links    Generate maximal unitigs connections references, in BCALM2 format
                                            L:<+/->:<other id>:<+/->
        --gfa-v1                            Output the graph in GFA format v1
        --gfa-v2                            Output the graph in GFA format v2
    -g, --greedy-matchtigs                  Generate greedy matchtigs instead of maximal unitigs
    -h, --help                              Prints help information
        --keep-temp-files                   Keep intermediate temporary files for debugging purposes
        --pathtigs                          Generate pathtigs instead of maximal unitigs
    -p, --prefer-memory                     Use all the given memory before writing to disk
    -V, --version                           Prints version information

OPTIONS:
    -b, --buckets-count-log <buckets-count-log>                              The log2 of the number of buckets
    -d, --colored-input-lists <colored-input-lists>...
            The lists of input files with colors in format <COLOR_NAME><TAB><FILE_PATH>

        --disk-optimization-level <disk-optimization-level>
            Sets the level of disk optimization (0 disabled) [default: 5]

    -w, --hash-type <hash-type>
            Hash type used to identify kmers [default: Auto]

    -l, --input-lists <input-lists>...                                       The lists of input files
        --intermediate-compression-level <intermediate-compression-level>
            The level of lz4 compression to be used for the intermediate files

    -k, --kmer-length <kmer-length>                                          Specifies the k-mers length
        --last-step <last-step>                                               [default: BuildUnitigs]
    -m, --memory <memory>
            Maximum suggested memory usage (GB) The tool will try use only up to this GB of memory to store temporary
            files without writing to disk. This usage does not include the needed memory for the processing steps. GGCAT
            can allocate extra memory for files if the current memory is not enough to complete the current operation
            [default: 2]
    -s, --min-multiplicity <min-multiplicity>
            Minimum multiplicity required to keep a kmer [default: 2]

        --minimizer-length <minimizer-length>
            Overrides the default m-mers (minimizers) length

    -o, --output-file <output-file>                                           [default: output.fasta.lz4]
        --step <step>                                                         [default: MinimizerBucketing]
    -t, --temp-dir <temp-dir>
            Directory for temporary files (default .temp_files) [default: .temp_files]

    -j, --threads-count <threads-count>                                       [default: 16]

ARGS:
    <input>...    The input files
```


## ggcat_dump-colors

### Tool Description
Dumps the colors from a colormap file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ggcat:2.0.0--ha96b9cd_0
- **Homepage**: https://github.com/algbio/ggcat
- **Package**: https://anaconda.org/channels/bioconda/packages/ggcat/overview
- **Validation**: PASS

### Original Help Text
```text
ggcat-dump-colors 2.0.0

USAGE:
    ggcat dump-colors <input-colormap> <output-file>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

ARGS:
    <input-colormap>    
    <output-file>
```


## ggcat_matches

### Tool Description
ggcat-matches 2.0.0

### Metadata
- **Docker Image**: quay.io/biocontainers/ggcat:2.0.0--ha96b9cd_0
- **Homepage**: https://github.com/algbio/ggcat
- **Package**: https://anaconda.org/channels/bioconda/packages/ggcat/overview
- **Validation**: PASS

### Original Help Text
```text
ggcat-matches 2.0.0

USAGE:
    ggcat matches <input-file> <match-color>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

ARGS:
    <input-file>     Input fasta file with associated colors file (in the same folder)
    <match-color>    Debug print matches of a color index (in hexadecimal)
```


## ggcat_query

### Tool Description
Query a graph with k-mers

### Metadata
- **Docker Image**: quay.io/biocontainers/ggcat:2.0.0--ha96b9cd_0
- **Homepage**: https://github.com/algbio/ggcat
- **Package**: https://anaconda.org/channels/bioconda/packages/ggcat/overview
- **Validation**: PASS

### Original Help Text
```text
ggcat-query 2.0.0

USAGE:
    ggcat query [FLAGS] [OPTIONS] <input-graph> <input-query> --kmer-length <kmer-length>

FLAGS:
    -c, --colors             Enable colors
    -f, --forward-only       Treats reverse complementary kmers as different
    -h, --help               Prints help information
        --keep-temp-files    Keep intermediate temporary files for debugging purposes
    -p, --prefer-memory      Use all the given memory before writing to disk
    -V, --version            Prints version information

OPTIONS:
    -b, --buckets-count-log <buckets-count-log>                              The log2 of the number of buckets
        --colored-query-output-format <colored-query-output-format>          
    -w, --hash-type <hash-type>
            Hash type used to identify kmers [default: Auto]

        --intermediate-compression-level <intermediate-compression-level>
            The level of lz4 compression to be used for the intermediate files

    -k, --kmer-length <kmer-length>                                          Specifies the k-mers length
    -m, --memory <memory>
            Maximum suggested memory usage (GB) The tool will try use only up to this GB of memory to store temporary
            files without writing to disk. This usage does not include the needed memory for the processing steps. GGCAT
            can allocate extra memory for files if the current memory is not enough to complete the current operation
            [default: 2]
        --minimizer-length <minimizer-length>
            Overrides the default m-mers (minimizers) length

    -o, --output-file-prefix <output-file-prefix>                             [default: output]
    -x, --step <step>                                                         [default: MinimizerBucketing]
    -t, --temp-dir <temp-dir>
            Directory for temporary files (default .temp_files) [default: .temp_files]

    -j, --threads-count <threads-count>                                       [default: 16]

ARGS:
    <input-graph>    The input graph
    <input-query>    The input query as a .fasta file
```


## Metadata
- **Skill**: generated
