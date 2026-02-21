cwlVersion: v1.2
class: CommandLineTool
baseCommand: ensembl-py
label: ensembl-py
doc: "The provided text does not contain help information for the tool. It contains
  container runtime error messages regarding a failure to build a SIF image due to
  insufficient disk space.\n\nTool homepage: https://www.ensembl.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ensembl-py:3.0.1--pyhdfd78af_0
stdout: ensembl-py.out
