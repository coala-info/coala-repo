# terminus CWL Generation Report

## terminus_collapse

### Tool Description
analyze a collection of per-sample groups, and produce a consensus grouping.

### Metadata
- **Docker Image**: quay.io/biocontainers/terminus:v0.1.0--h2db0a6b_0
- **Homepage**: https://github.com/COMBINE-lab/terminus
- **Package**: https://anaconda.org/channels/bioconda/packages/terminus/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/terminus/overview
- **Total Downloads**: 9.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/COMBINE-lab/terminus
- **Stars**: N/A
### Original Help Text
```text
terminus-collapse 
analyze a collection of per-sample groups, and produce a consensus grouping.

USAGE:
    terminus collapse [OPTIONS] --dirs <dirs>... --out <out>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
    -c, --consensus-thresh <consensus-thresh>    threshold for edge consensus [default: 0.5]
    -d, --dirs <dirs>...                         direcotories to read the group files from
    -o, --out <out>                              prefix where output would be written
    -t, --threads <threads>
            number of threads to use when writing down the collapsed quantifications [default: 8]
```


## terminus_group

### Tool Description
perform per-sample grouping of transcripts; required prior to consensus collapse.

### Metadata
- **Docker Image**: quay.io/biocontainers/terminus:v0.1.0--h2db0a6b_0
- **Homepage**: https://github.com/COMBINE-lab/terminus
- **Package**: https://anaconda.org/channels/bioconda/packages/terminus/overview
- **Validation**: PASS

### Original Help Text
```text
terminus-group 
perform per-sample grouping of transcripts; required prior to consensus collapse.

USAGE:
    terminus group [OPTIONS] --dir <dir> --out <out>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
    -d, --dir <dir>                  directory to read input from
    -m, --min-spread <min-spread>    the minimum spread a transcript must exhibit to enable an attached edge to be a
                                     collapse candidate [default: 0.1]
    -o, --out <out>                  prefix where output would be written
        --seed <seed>                The allowable difference between the weights of transcripts in same equivalence
                                     classes to treat them as identical [default: 10]
        --tolerance <tolerance>      The allowable difference between the weights of transcripts in same equivalence
                                     classes to treat them as identical [default: 0.001]
```

