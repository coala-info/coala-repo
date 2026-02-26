cwlVersion: v1.2
class: CommandLineTool
baseCommand: ensemblcov countconvert
label: ensemblcov_countconvert
doc: "Convert counts from one format to another.\n\nTool homepage: https://github.com/IBCHgenomic/ensemlcov"
inputs:
  - id: counts
    type: File
    doc: Input counts file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ensemblcov:0.1.0--h4349ce8_0
stdout: ensemblcov_countconvert.out
