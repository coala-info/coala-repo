# lrge CWL Generation Report

## lrge

### Tool Description
Genome size estimation from long read overlaps

### Metadata
- **Docker Image**: quay.io/biocontainers/lrge:0.2.1--h9f13da3_0
- **Homepage**: https://github.com/mbhall88/lrge
- **Package**: https://anaconda.org/channels/bioconda/packages/lrge/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/lrge/overview
- **Total Downloads**: 4.7K
- **Last updated**: 2025-09-22
- **GitHub**: https://github.com/mbhall88/lrge
- **Stars**: N/A
### Original Help Text
```text
Genome size estimation from long read overlaps

Usage: lrge [OPTIONS] <INPUT>

Arguments:
  <INPUT>
          Input FASTQ file

Options:
  -o, --output <OUTPUT>
          Output file for the estimate
          
          [default: -]

  -T, --target <INT>
          Target number of reads to use (for two-set strategy; default)
          
          [default: 10000]

  -Q, --query <INT>
          Query number of reads to use (for two-set strategy; default)
          
          [default: 5000]

  -n, --num <INT>
          Number of reads to use (for all-vs-all strategy)

  -P, --platform <PLATFORM>
          Sequencing platform of the reads
          
          [default: ont]
          [possible values: ont, pb]

  -F, --filter-contained
          Exclude overlaps for internal matches

  -t, --threads <INT>
          Number of threads to use
          
          [default: 1]

  -C, --keep-temp
          Don't clean up temporary files

  -D, --temp <DIR>
          Temporary directory for storing intermediate files

  -s, --seed <INT>
          Random seed to use - making the estimate repeatable

  -8, --inf
          Take the estimate as the median of all estimates, *including infinite estimates*

  -f, --float-my-boat
          I neeeeeed that precision! Output the estimate as a floating point number

      --q1 <FLOAT>
          The lower quantile to use for the estimate
          
          [default: 0.15]

      --q3 <FLOAT>
          The upper quantile to use for the estimate
          
          [default: 0.65]

      --max-overhang-ratio <FLOAT>
          Maximum overhang size to alignment length ratio for internal overlap filtering
          
          [default: 0.2]

      --use-min-ref
          Use the smaller Q/T dataset as minimap2 reference (for two-set strategy)

  -q, --quiet...
          `-q` only show errors and warnings. `-qq` only show errors. `-qqq` shows nothing

  -v, --verbose...
          `-v` show debug output. `-vv` show trace output

  -h, --help
          Print help (see a summary with '-h')

  -V, --version
          Print version
```

