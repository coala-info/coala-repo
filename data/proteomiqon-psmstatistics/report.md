# proteomiqon-psmstatistics CWL Generation Report

## proteomiqon-psmstatistics

### Tool Description
Compute PSM statistics and score peptide spectrum matches.

### Metadata
- **Docker Image**: quay.io/biocontainers/proteomiqon-psmstatistics:0.0.8--hdfd78af_0
- **Homepage**: https://csbiology.github.io/ProteomIQon/
- **Package**: https://anaconda.org/channels/bioconda/packages/proteomiqon-psmstatistics/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/proteomiqon-psmstatistics/overview
- **Total Downloads**: 16.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/CSBiology/ProteomIQon
- **Stars**: N/A
### Original Help Text
```text
ERROR: unrecognized argument: '-help'.
USAGE: ProteomIQon.PSMStatistics [--help] --psms [<path>...]
                                 --peptidedatabase <path>
                                 --outputdirectory <path> --paramfile <path>
                                 [--diagnosticcharts]
                                 [--parallelism-level <level>]
                                 [--log-level <level>]
                                 [--verbosity-level <level>]

OPTIONS:

    --psms, -i [<path>...]
                          Specify the peptide spectum matches (PSMs) to be
                          scored, either specify a file directory containing
                          the files to be analyzed or specify the file path of
                          a single .psm file.
    --peptidedatabase, -d <path>
                          Specify the file path of the peptide data base.
    --outputdirectory, -o <path>
                          Specify the output directory.
    --paramfile, -p <path>
                          Specify parameter file for computation of psm
                          statistics.
    --diagnosticcharts, -dc
                          Set to save diagnostic charts to the output directory.
    --parallelism-level, -c <level>
                          Set the number of cores the programm can use.
                          Parallelization occurs on file level. This flag is
                          only of effect if a input directory (-i) is specified.
    --log-level, -l <level>
                          Set the log level.
    --verbosity-level, -v <level>
                          Set the verbosity level.
    --help                display this list of options.
```

