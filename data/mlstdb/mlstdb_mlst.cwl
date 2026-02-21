cwlVersion: v1.2
class: CommandLineTool
baseCommand: mlstdb-mlst
label: mlstdb_mlst
doc: "Multi-Locus Sequence Typing (MLST) database tool. (Note: The provided text contains
  system error messages regarding container image creation and does not include usage
  instructions or argument definitions.)\n\nTool homepage: https://github.com/himal2007/mlstdb"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mlstdb:0.2.0--pyh7e72e81_0
stdout: mlstdb_mlst.out
