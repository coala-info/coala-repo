cwlVersion: v1.2
class: CommandLineTool
baseCommand: scallop-lr
label: scallop-lr
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a failed container image retrieval.\n\n
  Tool homepage: https://github.com/Kingsford-Group/lrassemblyanalysis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scallop-lr:0.9.2--h503566f_10
stdout: scallop-lr.out
