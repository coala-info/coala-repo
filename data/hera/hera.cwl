cwlVersion: v1.2
class: CommandLineTool
baseCommand: hera
label: hera
doc: "Hera is a tool for fast and accurate RNA-seq quantification (Note: The provided
  help text contains only system error messages and no usage information).\n\nTool
  homepage: https://github.com/bioturing/hera"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hera:1.1--h8121788_3
stdout: hera.out
