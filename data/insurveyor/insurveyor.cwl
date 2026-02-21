cwlVersion: v1.2
class: CommandLineTool
baseCommand: insurveyor
label: insurveyor
doc: "A tool for detecting insertions in NGS data (Note: The provided help text contains
  only system error messages and does not list specific tool arguments).\n\nTool homepage:
  https://github.com/kensung-lab/INSurVeyor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/insurveyor:1.1.3--h077b44d_2
stdout: insurveyor.out
