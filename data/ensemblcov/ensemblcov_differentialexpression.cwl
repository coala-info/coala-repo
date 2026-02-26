cwlVersion: v1.2
class: CommandLineTool
baseCommand: ensemblcov differentialexpression
label: ensemblcov_differentialexpression
doc: "id convert from differential expression\n\nTool homepage: https://github.com/IBCHgenomic/ensemlcov"
inputs:
  - id: differentialexpression
    type: File
    doc: path to the differential expression
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ensemblcov:0.1.0--h4349ce8_0
stdout: ensemblcov_differentialexpression.out
