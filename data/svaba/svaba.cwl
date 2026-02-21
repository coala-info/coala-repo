cwlVersion: v1.2
class: CommandLineTool
baseCommand: svaba
label: svaba
doc: "Structural variation analysis by assembly\n\nTool homepage: https://github.com/walaj/svaba"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svaba:1.2.0--h69ac913_1
stdout: svaba.out
