# proteomiqon-joinquantpepionswithproteins CWL Generation Report

## proteomiqon-joinquantpepionswithproteins

### Tool Description
Joins quantified peptide information with inferred protein information.

### Metadata
- **Docker Image**: quay.io/biocontainers/proteomiqon-joinquantpepionswithproteins:0.0.2--hdfd78af_1
- **Homepage**: https://csbiology.github.io/ProteomIQon/
- **Package**: https://anaconda.org/channels/bioconda/packages/proteomiqon-joinquantpepionswithproteins/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/proteomiqon-joinquantpepionswithproteins/overview
- **Total Downloads**: 4.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/CSBiology/ProteomIQon
- **Stars**: N/A
### Original Help Text
```text
ERROR: missing parameter '--quantifiedpeptides'.
USAGE: ProteomIQon.JoinQuantPepIonsWithProteins [--help]
                                                --quantifiedpeptides [<path>...]
                                                --inferredproteins [<path>...]
                                                --outputdirectory <path>
                                                [--matchfiles]
                                                [--parallelism-level <level>]

OPTIONS:

    --quantifiedpeptides, -i [<path>...]
                          Specify quantified peptides, specify either a
                          directory containing or a space separated list of
                          .quant files.
    --inferredproteins, -ii [<path>...]
                          Specify inferred proteins, specify either a directory
                          containing or a space separated list of .prot files.
    --outputdirectory, -o <path>
                          Specify the output directory.
    --matchfiles, -mf     If this flag is set the files specified using the
                          QuantifiedPeptides and InferredProteins are matched
                          according to their file name, otherwise they are
                          matched by their position in the input lists.
    --parallelism-level, -c <level>
                          Set the number of cores the programm can use.
                          Parallelization occurs on file level. This flag is
                          only of effect if a input directory (-i) is specified.
    --help                display this list of options.
```

