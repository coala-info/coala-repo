# proteomiqon-alignmentbasedquantstatistics CWL Generation Report

## proteomiqon-alignmentbasedquantstatistics

### Tool Description
Performs alignment-based quantification statistics.

### Metadata
- **Docker Image**: quay.io/biocontainers/proteomiqon-alignmentbasedquantstatistics:0.0.3--hdfd78af_0
- **Homepage**: https://csbiology.github.io/ProteomIQon/
- **Package**: https://anaconda.org/channels/bioconda/packages/proteomiqon-alignmentbasedquantstatistics/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/proteomiqon-alignmentbasedquantstatistics/overview
- **Total Downloads**: 3.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/CSBiology/ProteomIQon
- **Stars**: N/A
### Original Help Text
```text
ERROR: unrecognized argument: '-help'.
USAGE: ProteomIQon.AlignmentBasedQuantStatistics [--help] --quant [<path>...]
                                                 --align [<path>...]
                                                 --alignedquant [<path>...]
                                                 --quantlearn [<path>...]
                                                 --alignlearn [<path>...]
                                                 --alignedquantlearn [<path>...]
                                                 --outputdirectory <path>
                                                 --paramfile <path>
                                                 [--parallelism-level <level>]
                                                 [--diagnosticcharts]
                                                 [--matchfiles]

OPTIONS:

    --quant, -i [<path>...]
                          Specify the quant files or directory
    --align, -ii [<path>...]
                          Specify the align files or directory
    --alignedquant, -iii [<path>...]
                          Specify the aligned quant files or directory
    --quantlearn, -l [<path>...]
                          Specify the quant files or directory for learning
    --alignlearn, -ll [<path>...]
                          Specify the align files or directory for learning
    --alignedquantlearn, -lll [<path>...]
                          Specify the aligned quant files or directory for
                          learning
    --outputdirectory, -o <path>
                          Specify the output directory.
    --paramfile, -p <path>
                          Specify parameter file for peptide spectrum matching.
    --parallelism-level, -c <level>
                          Set the number of cores the programm can use.
                          Parallelization occurs on file level. This flag is
                          only of effect if a input directory (-i) is specified.
    --diagnosticcharts, -dc
                          Set to save diagnostic charts to the output directory.
    --matchfiles, -mf     If this flag is set the files specified by Quant,
                          Align AlignedQuant are matched according to their
                          file name, otherwise they are matched by their
                          position in the input lists.
    --help                display this list of options.
```


## Metadata
- **Skill**: generated
