cwlVersion: v1.2
class: CommandLineTool
baseCommand: insilicosv
label: insilicosv
doc: "A tool for simulating structural variations (Note: The provided text contains
  system error messages regarding container image conversion and disk space, rather
  than the tool's help documentation).\n\nTool homepage: https://github.com/PopicLab/insilicoSV"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/insilicosv:0.0.6--pyhdfd78af_0
stdout: insilicosv.out
