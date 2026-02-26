cwlVersion: v1.2
class: CommandLineTool
baseCommand: svdss_SVDSS
label: svdss_SVDSS
doc: "SVDSS [index|smooth|search|call]\n\nTool homepage: https://github.com/Parsoa/SVDSS"
inputs:
  - id: command
    type: string
    doc: index|smooth|search|call
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svdss:2.1.0--h9013031_0
stdout: svdss_SVDSS.out
