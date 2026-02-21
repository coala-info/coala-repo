cwlVersion: v1.2
class: CommandLineTool
baseCommand: uscdc-datasets-sars-cov-2
label: uscdc-datasets-sars-cov-2
doc: "A tool for handling US CDC SARS-CoV-2 datasets. Note: The provided text contains
  container build logs and error messages rather than CLI help documentation, so no
  arguments could be extracted.\n\nTool homepage: https://github.com/CDCgov/datasets-sars-cov-2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/uscdc-datasets-sars-cov-2:0.7.2--hdfd78af_0
stdout: uscdc-datasets-sars-cov-2.out
