# proteomiqon-alignmentbasedquantification CWL Generation Report

## proteomiqon-alignmentbasedquantification

### Tool Description
Performs alignment-based quantification of proteomic data.

### Metadata
- **Docker Image**: quay.io/biocontainers/proteomiqon-alignmentbasedquantification:0.0.2--hdfd78af_0
- **Homepage**: https://csbiology.github.io/ProteomIQon/
- **Package**: https://anaconda.org/channels/bioconda/packages/proteomiqon-alignmentbasedquantification/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/proteomiqon-alignmentbasedquantification/overview
- **Total Downloads**: 1.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/CSBiology/ProteomIQon
- **Stars**: N/A
### Original Help Text
```text
ERROR: missing parameter '--instrumentoutput'.
USAGE: ProteomIQon.AlignmentBasedQuantification [--help]
                                                --instrumentoutput <path>
                                                --alignedpeptides <path>
                                                --metrics <path>
                                                --quantifiedpeptides <path>
                                                --peptidedatabase <path>
                                                --outputdirectory <path>
                                                --paramfile <path>
                                                [--matchfiles]
                                                [--diagnosticcharts]
                                                [--parallelism-level <level>]
                                                [--log-level <level>]
                                                [--verbosity-level <level>]

OPTIONS:

    --instrumentoutput, -i <path>
                          Specify the mass spectrometry output, either specify
                          a file directory containing the files to be analyzed
                          or specify the file path of a single mzlite file.
    --alignedpeptides, -ii <path>
                          Specify the aligned peptide spectrum matches, either
                          specify a file directory containing the files to be
                          analyzed or specify the file path of a single qpsm
                          file. If InstrumentOutPut(i) and ScoredPSMs (ii) both
                          reference a directory the files are automatically
                          aligned by their file name.
    --metrics, -iii <path>
                          Specify the .alignmetrics file used to assess false
                          positive alignments, either specify a file directory
                          containing the files to be analyzed or specify the
                          file path of a single qpsm file. If
                          InstrumentOutPut(i) and ScoredPSMs (ii) both
                          reference a directory the files are automatically
                          aligned by their file name.
    --quantifiedpeptides, -iv <path>
                          Specify quantified peptides, specify a directory
                          containing .quant files.
    --peptidedatabase, -d <path>
                          Specify the file path of the peptide data base.
    --outputdirectory, -o <path>
                          Specify the output directory.
    --paramfile, -p <path>
                          Specify parameter file for peptide spectrum matching.
    --matchfiles, -mf     If this flag is set the files specified by
                          InstrumentOutput, AlignedPeptides, Metrics  and
                          QuantifiedPeptides are matched according to their
                          file name, otherwise they are matched by their
                          position in the input lists.
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

