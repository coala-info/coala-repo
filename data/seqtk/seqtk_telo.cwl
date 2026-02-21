cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqtk_telo
label: seqtk_telo
doc: "The provided text does not contain help information or a description for the
  tool.\n\nTool homepage: https://github.com/lh3/seqtk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
stdout: seqtk_telo.out
