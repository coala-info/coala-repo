cwlVersion: v1.2
class: CommandLineTool
baseCommand: pstrain
label: pstrain
doc: "\nTool homepage: https://github.com/wshuai294/PStrain"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pstrain:1.0.3--h9ee0642_0
stdout: pstrain.out
