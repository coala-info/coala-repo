cwlVersion: v1.2
class: CommandLineTool
baseCommand: debreak
label: debreak
doc: "A tool for structural variant detection (Note: The provided help text contains
  only container runtime error messages and no usage information).\n\nTool homepage:
  https://github.com/ChongLab/DeBreak"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/debreak:1.3--h9ee0642_0
stdout: debreak.out
