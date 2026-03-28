# sfs CWL Generation Report

## sfs_create

### Tool Description
Tools for working with site frequency spectra

### Metadata
- **Docker Image**: quay.io/biocontainers/sfs:0.1.0--h9ee0642_0
- **Homepage**: https://github.com/malthesr/sfs
- **Package**: https://anaconda.org/channels/bioconda/packages/sfs/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sfs/overview
- **Total Downloads**: 1.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/malthesr/sfs
- **Stars**: N/A
### Original Help Text
```text
Tools for working with site frequency spectra

Usage: sfs create [OPTIONS] [FILE]

Arguments:
  [FILE]
          Input VCF/BCF.
          
          If no file is provided, stdin will be used. Input may be BGZF-compressed or uncompressed.

Options:
      --precision <INT>
          Output precision.
          
          This option is only used when projecting, and otherwise set to zero since the output must be integer counts.
          
          [default: 6]

  -p, --project-individuals <INT,...>
          Projected individuals.
          
          By default, any site with missing and/or multiallelic genotypes in the applied sample subset will be skipped. Where this leads to too much missingness, the SFS can be projected to a lower number of individuals using hypergeometric sampling. By doing so, all sites with data for at least as this required shape will be used, and those with more data will be projected down. Use a comma-separated list of values giving the new shape of the SFS. For example, `--project-individuals 3,2` would project a two-dimensional SFS down to three individuals in the first dimension and two in the second.

      --project-shape <INT,...>
          Projected shape.
          
          Alternative to `--project-individuals`, see documentation for background. Using this argument, the projection can be specified by shape, rather than number of individuals. For example, `--project-shape 7,5` would project a two-dimensional SFS down to three diploid individuals in the first dimension and two in the second.

  -s, --samples <SAMPLE[=POPULATION],...>
          Sample subset.
          
          By default, a one-dimensional SFS of all samples is created. Using this argument, the subset of samples can be restricted. Multiple, comma-separated values may be provided. To construct a multi-dimensional SFS, the samples may be provided as `sample=population` pairs. The ordering of populations in the resulting SFS corresponds to the order of appearance of input population names.

  -q, --quiet...
          Suppress log output.
          
          By default, information may be logged to stderr while running. Set this flag once to silence normal logging output, and set twice to silence warnings.

  -S, --samples-file <FILE>
          Sample subset file.
          
          Alternative to `--samples`, see documentation for background. Using this argument, the sample subset can be provided as a file. Each line should contain the name of a sample. Optionally, the file may contain a second, tab-delimited column with population identifiers.

      --strict
          Fail on missingness.
          
          By default, any site with missing and/or multiallelic genotypes in the applied sample subset are skipped and logged. Using this flag will cause an error if such genotypes are encountered.

  -v, --verbose...
          Log output verbosity.
          
          Set this flag times to show debug information, and set twice to show trace information.

  -t, --threads <INT>
          Number of threads.
          
          Multi-threading currently only affects reading and parsing BGZF compressed input.
          
          [default: 4]

  -h, --help
          Print help (see a summary with '-h')
```


## sfs_fold

### Tool Description
Tools for working with site frequency spectra

### Metadata
- **Docker Image**: quay.io/biocontainers/sfs:0.1.0--h9ee0642_0
- **Homepage**: https://github.com/malthesr/sfs
- **Package**: https://anaconda.org/channels/bioconda/packages/sfs/overview
- **Validation**: PASS

### Original Help Text
```text
Tools for working with site frequency spectra

Usage: sfs fold [OPTIONS] [PATH]

Arguments:
  [PATH]
          Input SFS.
          
          The input SFS can be provided here or read from stdin in any of the supported formats.

Options:
  -s, --fill <FILL>
          Fill value to use when folding.
          
          By default, the "lower" part of the SFS will be filled with nan values. Set this option to use another fill values.
          
          [default: nan]

          Possible values:
          - nan:       Set folded value to nan
          - zero:      Set folded value to 0
          - minus-one: Set folded value to -1
          - inf:       Set folded value to Inf

  -o, --output <PATH>
          Output SFS path.
          
          If no path is given, SFS will be output to stdout.

  -p, --precision <INT>
          Precision to use when printing SFS
          
          [default: 6]

  -q, --quiet...
          Suppress log output.
          
          By default, information may be logged to stderr while running. Set this flag once to silence normal logging output, and set twice to silence warnings.

  -v, --verbose...
          Log output verbosity.
          
          Set this flag times to show debug information, and set twice to show trace information.

  -h, --help
          Print help (see a summary with '-h')
```


## sfs_stat

### Tool Description
Tools for working with site frequency spectra

### Metadata
- **Docker Image**: quay.io/biocontainers/sfs:0.1.0--h9ee0642_0
- **Homepage**: https://github.com/malthesr/sfs
- **Package**: https://anaconda.org/channels/bioconda/packages/sfs/overview
- **Validation**: PASS

### Original Help Text
```text
Tools for working with site frequency spectra

Usage: sfs stat [OPTIONS] --statistics <STAT,...> [PATH]

Arguments:
  [PATH]
          Input SFS.
          
          The input SFS can be provided here or read from stdin. The SFS will be normalised as required for particular statistics, so the input SFS does not need to be normalised.

Options:
  -d, --delimiter <CHAR>
          Delimiter between statistics
          
          [default: ,]

  -H, --header
          Include a header with the names of statistics

  -p, --precision <INT,...>
          Precision to use when printing statistics.
          
          If a single value is provided, this will be used for all statistics. If more than one statistic is calculated, the same number of precision specifiers may be provided, and they will be applied in the same order. Use comma to separate precision specifiers.
          
          [default: 6]

  -s, --statistics <STAT,...>
          Statistics to calculate.
          
          More than one statistic can be output. Use comma to separate statistics. An error will be thrown if the shape or dimensionality of the SFS is incompatible with the required statistics.

          Possible values:
          - d-fu-li:  Fu and Li's D statistic. 1D SFS only. See Durrett (2008)
          - d-tajima: Tajima's D statistic. 1D SFS only. See Durrett (2008)
          - f2:       The f₂-statistic. 2D SFS only. See Peter (2016)
          - f3:       The f₃(A; B, C)-statistic, where A, B, C is in the order of the populations in the SFS. 3D SFS only. See Peter (2016)
          - f4:       The f₄(A, B; C, D)-statistic, where A, B, C, D is in the order of the populations in the SFS. 4D SFS only. See Peter (2016)
          - fst:      Hudson's estimator of Fst, as ratio of averages. 2D SFS only. See Bhatia et al. (2013)
          - pi:       Average pairwise differences. 1D SFS only
          - pi-xy:    Average pairwise differences between two populations, also known as Dxy. 2D SFS only. See Nei and Li (1979), Cruickshank and Hahn (2014)
          - king:     The King kinship statistic. Shape 3x3 2D SFS only. See Waples et al. (2019)
          - r0:       The R0 kinship statistic. Shape 3x3 2D SFS only. See Waples et al. (2019)
          - r1:       The R1 kinship statistic. Shape 3x3 2D SFS only. See Waples et al. (2019)
          - s:        Number of segregating sites (in at least one population)
          - sum:      Sum of SFS. This will be total number of sites if not normalized, and ≈1 otherwise
          - theta:    Watterson's estimator of θ. 1D SFS only. Use π for Tajima's estimator. See Durrett (2008)

  -q, --quiet...
          Suppress log output.
          
          By default, information may be logged to stderr while running. Set this flag once to silence normal logging output, and set twice to silence warnings.

  -v, --verbose...
          Log output verbosity.
          
          Set this flag times to show debug information, and set twice to show trace information.

  -h, --help
          Print help (see a summary with '-h')
```


## sfs_view

### Tool Description
Format, marginalize, project, and convert SFS.

### Metadata
- **Docker Image**: quay.io/biocontainers/sfs:0.1.0--h9ee0642_0
- **Homepage**: https://github.com/malthesr/sfs
- **Package**: https://anaconda.org/channels/bioconda/packages/sfs/overview
- **Validation**: PASS

### Original Help Text
```text
Format, marginalize, project, and convert SFS.

Note that the order of operations matter, and the order is: marginalization > projection > mask monomorphic > normalization. To control the order of operations differently, chain together multiple commands by piping in the desired order.

Usage: sfs view [OPTIONS] [PATH]

Arguments:
  [PATH]
          Input SFS.
          
          The input SFS can be provided here or read from stdin in any of the supported formats.

Options:
  -o, --output <PATH>
          Output path.
          
          If no path is given, SFS will be output to stdout.

  -O, --output-format <FORMAT>
          Output format
          
          [default: text]
          [possible values: npy, text]

  -m, --marginalize-remove <INT,...>
          Marginalize populations.
          
          Marginalize out provided populations. Marginalization corresponds to an array sum over the SFS seen as an array. Use a comma-separated list of 0-based dimensions to  keep, using the same ordering of the dimensions of the SFS as specified e.g. in the header.

  -M, --marginalize-keep <INT,...>
          Marginalize remaining populations.
          
          Alternative to `--marginalize-remove`, see documentation for background. Using this argument, the marginalization can be specified in terms of dimensions to keep, rather than dimensions to remove.

      --mask-monomorphic
          Set monomorphic sites zero

  -q, --quiet...
          Suppress log output.
          
          By default, information may be logged to stderr while running. Set this flag once to silence normal logging output, and set twice to silence warnings.

  -n, --normalize
          Normalize SFS

  -v, --verbose...
          Log output verbosity.
          
          Set this flag times to show debug information, and set twice to show trace information.

  -p, --project-individuals <INT,...>
          Projected individuals.
          
          Using this argument, it is possible to project the SFS down to a lower number of individuals.  Use a comma-separated list of values giving the new shape of the SFS. For example, `--project-individuals 3,2` would project a two-dimensional SFS down to three individuals in the first dimension and two in the second.
          
          Note that it is also possible to project during creation of the SFS using the `create` subcommand, and projection after creation is not in equivalent. Where applicable, prefer projecting during creation to use more data in the presence of missingness.

      --project-shape <INT,...>
          Projected shape.
          
          Alternative to `--project-individuals`, see documentation for background. Using this argument, the projection can be specified by shape, rather than number of individuals. For example, `--project-shape 7,5` would project a two-dimensional SFS down to three diploid individuals in the first dimension and two in the second.

      --precision <INT>
          Print precision.
          
          This is only used for printing SFS to plain text format, and will be ignored otherwise.
          
          [default: 6]

  -h, --help
          Print help (see a summary with '-h')
```


## sfs_Suppress

### Tool Description
For more information, try '--help'.

### Metadata
- **Docker Image**: quay.io/biocontainers/sfs:0.1.0--h9ee0642_0
- **Homepage**: https://github.com/malthesr/sfs
- **Package**: https://anaconda.org/channels/bioconda/packages/sfs/overview
- **Validation**: PASS

### Original Help Text
```text
error: unrecognized subcommand 'Suppress'

Usage: sfs [OPTIONS] <COMMAND>

For more information, try '--help'.
```


## sfs_By

### Tool Description
Command-line tool for sfs operations.

### Metadata
- **Docker Image**: quay.io/biocontainers/sfs:0.1.0--h9ee0642_0
- **Homepage**: https://github.com/malthesr/sfs
- **Package**: https://anaconda.org/channels/bioconda/packages/sfs/overview
- **Validation**: PASS

### Original Help Text
```text
error: unrecognized subcommand 'By'

Usage: sfs [OPTIONS] <COMMAND>

For more information, try '--help'.
```


## sfs_Log

### Tool Description
For more information, try '--help'.

### Metadata
- **Docker Image**: quay.io/biocontainers/sfs:0.1.0--h9ee0642_0
- **Homepage**: https://github.com/malthesr/sfs
- **Package**: https://anaconda.org/channels/bioconda/packages/sfs/overview
- **Validation**: PASS

### Original Help Text
```text
error: unrecognized subcommand 'Log'

Usage: sfs [OPTIONS] <COMMAND>

For more information, try '--help'.
```


## sfs_Set

### Tool Description
For more information, try '--help'.

### Metadata
- **Docker Image**: quay.io/biocontainers/sfs:0.1.0--h9ee0642_0
- **Homepage**: https://github.com/malthesr/sfs
- **Package**: https://anaconda.org/channels/bioconda/packages/sfs/overview
- **Validation**: PASS

### Original Help Text
```text
error: unrecognized subcommand 'Set'

Usage: sfs [OPTIONS] <COMMAND>

For more information, try '--help'.
```


## sfs_Print

### Tool Description
Command-line tool for sequence similarity analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/sfs:0.1.0--h9ee0642_0
- **Homepage**: https://github.com/malthesr/sfs
- **Package**: https://anaconda.org/channels/bioconda/packages/sfs/overview
- **Validation**: PASS

### Original Help Text
```text
error: unrecognized subcommand 'Print'

Usage: sfs [OPTIONS] <COMMAND>

For more information, try '--help'.
```


## Metadata
- **Skill**: generated
