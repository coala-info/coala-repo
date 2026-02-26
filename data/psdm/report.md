# psdm CWL Generation Report

## psdm

### Tool Description
Compute a pairwise SNP distance matrix from one or two alignment(s)

### Metadata
- **Docker Image**: quay.io/biocontainers/psdm:0.3.0--hc1c3326_2
- **Homepage**: https://github.com/mbhall88/psdm
- **Package**: https://anaconda.org/channels/bioconda/packages/psdm/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/psdm/overview
- **Total Downloads**: 9.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mbhall88/psdm
- **Stars**: N/A
### Original Help Text
```text
psdm 0.3.0
Michael Hall <michael@mbh.sh>
Compute a pairwise SNP distance matrix from one or two alignment(s)

USAGE:
    psdm [OPTIONS] [ALIGNMENTS]...

ARGS:
    <ALIGNMENTS>...
            FASTA alignment file(s) to compute the pairwise distance for.
            
            Providing two files will compute the distances for all sequences in one file against all
            sequences from the other file - i.e., not between sequences in the same file. The first
            file will be the column names, while the second is the row names. The alignment file(s)
            can be compressed.

OPTIONS:
    -c, --case-sensitive
            Case matters - i.e., dist(a, A) = 1

    -d, --delim <DELIMITER>
            Delimiting character for the output table
            
            [default: ,]

    -e, --ignored-chars <IGNORED_CHARS>
            String of characters to ignore - e.g., `-e N-` -> dist(A, N) = 0 and dist(A, -) = 0
            
            Note, if using `--case-sensitive` the upper- and lower-case form of a character is
            needed. To not ignore any characters, use `-e ''` or `-e ""`
            
            [default: N-]

    -h, --help
            Print help information

    -l, --long
            Output as long-form ("melted") table
            
            By default the output is a N x N or N x M table where N is the number of sequences in
            the first alignment and M is the number of sequences in the (optional) second alignment.

    -o, --output <OUTPUT>
            Output file name [default: stdout]

    -P, --progress
            Show a progress bar

    -q, --quiet
            No logging (except progress info if `-P` is given)

    -s, --sort
            Sort the alignment(s) by ID

    -t, --threads <THREADS>
            Number of threads to use. Setting to 0 will use all available
            
            [default: 1]

    -V, --version
            Print version information
```

