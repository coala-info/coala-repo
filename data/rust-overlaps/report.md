# rust-overlaps CWL Generation Report

## rust-overlaps

### Tool Description
Finds approximate suffix prefix overlaps from a given fasta file

### Metadata
- **Docker Image**: quay.io/biocontainers/rust-overlaps:0.1.1--h577a1d6_10
- **Homepage**: https://github.com/jbaaijens/rust-overlaps
- **Package**: https://anaconda.org/channels/bioconda/packages/rust-overlaps/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rust-overlaps/overview
- **Total Downloads**: 8.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jbaaijens/rust-overlaps
- **Stars**: N/A
### Original Help Text
```text
ASPOPsolver 1.0
Christopher Esterhuyse <christopher.esterhuyse@gmail.com>
Finds approximate suffix prefix overlaps from a given fasta file

USAGE:
    rust-overlaps [FLAGS] [OPTIONS] <IN_PATH> <OUT_PATH> <ERR_RATE> <THRESH>

FLAGS:
    -e, --edit_distance     Uses Levenshtein / edit distance instead of Hamming distance
    -f, --format_line       The first line of the output file will contain a TSV header line.
    -g, --greedy_output     Threads print solutions to output greedily instead of storing them. Limited duplication may
                            arise
    -h, --help              Prints help information
    -i, --inclusions        Enables finding of inclusion overlaps (one string within another)
    -n, --no_n              Omits N symbol from alphabet saving time. Will remove N symbols from input file (with a
                            warning)
    -p, --print             For each solution printed to file, also prints a rough visualization to stdout (mostly for
                            debugging purposes)
    -r, --reversals         Enables reversals of input strings
    -t, --track_progress    Prints progress bar for completed tasks and ETA to stdout
    -V, --version           Prints version information
    -v, --verbose           Prints completed steps of the run process

OPTIONS:
    -m, --mode <mode>                        Uses the filtering scheme mode given options {valimaki, kucherov}. Modes
                                             can also be supplied string arguments i.e. 'kucherov_2'. (Default :
                                             kucherov_2
    -w, --worker_threads <worker_threads>    Number of worker threads used. Defaults to number of logical cpu cores

ARGS:
    <IN_PATH>     Path to the input fasta file
    <OUT_PATH>    Path of desired output file
    <ERR_RATE>    The max rate of errors in an overlap
    <THRESH>      Shortest allowed length of an overlap
```

