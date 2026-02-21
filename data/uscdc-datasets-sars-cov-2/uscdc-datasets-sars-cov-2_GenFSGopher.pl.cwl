cwlVersion: v1.2
class: CommandLineTool
baseCommand: uscdc-datasets-sars-cov-2_GenFSGopher.pl
label: uscdc-datasets-sars-cov-2_GenFSGopher.pl
doc: "A tool for processing SARS-CoV-2 datasets (Note: The provided text contains
  container execution logs and error messages rather than help documentation, so specific
  arguments could not be extracted).\n\nTool homepage: https://github.com/CDCgov/datasets-sars-cov-2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/uscdc-datasets-sars-cov-2:0.7.2--hdfd78af_0
stdout: uscdc-datasets-sars-cov-2_GenFSGopher.pl.out
