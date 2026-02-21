cwlVersion: v1.2
class: CommandLineTool
baseCommand: miniasm_minidot
label: miniasm_minidot
doc: "\nTool homepage: https://github.com/lh3/miniasm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/miniasm:0.3_r179--ha92aebf_0
stdout: miniasm_minidot.out
