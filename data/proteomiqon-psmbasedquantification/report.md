# proteomiqon-psmbasedquantification CWL Generation Report

## proteomiqon-psmbasedquantification

### Tool Description
Performs PSM-based quantification using mass spectrometry output, scored PSMs, and a peptide database.

### Metadata
- **Docker Image**: quay.io/biocontainers/proteomiqon-psmbasedquantification:0.0.9--hdfd78af_0
- **Homepage**: https://csbiology.github.io/ProteomIQon/
- **Package**: https://anaconda.org/channels/bioconda/packages/proteomiqon-psmbasedquantification/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/proteomiqon-psmbasedquantification/overview
- **Total Downloads**: 12.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/CSBiology/ProteomIQon
- **Stars**: N/A
### Original Help Text
```text
ERROR: missing parameter '--instrumentoutput'.
USAGE: ProteomIQon.PSMBasedQuantification [--help]
                                          --instrumentoutput [<path>...]
                                          --scoredpsms [<path>...]
                                          --peptidedatabase <path>
                                          --outputdirectory <path>
                                          --paramfile <path> [--matchfiles]
                                          [--diagnosticcharts] [--zipcharts]
                                          [--parallelism-level <level>]
                                          [--log-level <level>]
                                          [--verbosity-level <level>]

OPTIONS:

    --instrumentoutput, -i [<path>...]
                          Specify the mass spectrometry output, either specify
                          a file directory containing the files to be analyzed
                          or specify the file path of a single mzlite file.
    --scoredpsms, -ii [<path>...]
                          Specify the scored peptide spectrum matches, either
                          specify a file directory containing the files to be
                          analyzed or specify the file path of a single qpsm
                          file. If InstrumentOutPut(i) and ScoredPSMs (ii) both
                          reference a directory the files are automatically
                          aligned by their file name.
    --peptidedatabase, -d <path>
                          Specify the file path of the peptide data base.
    --outputdirectory, -o <path>
                          Specify the output directory.
    --paramfile, -p <path>
                          Specify parameter file for peptide spectrum matching.
    --matchfiles, -mf     If this flag is set the files specified by
                          InstrumentOutput and ScoredPSMs are matched according
                          to their file name, otherwise they are matched by
                          their position in the input lists.
    --diagnosticcharts, -dc
                          Set to save diagnostic charts to the output directory.
    --zipcharts, -z       Set to zip the diagnostic charts.
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

