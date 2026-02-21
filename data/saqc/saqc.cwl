cwlVersion: v1.2
class: CommandLineTool
baseCommand: saqc
label: saqc
doc: "System for automated Quality Control (Note: The provided text appears to be
  a container engine log rather than CLI help text; no arguments could be extracted
  from the input).\n\nTool homepage: https://github.com/Helmholtz-UFZ/saqc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/saqc:2.6.0
stdout: saqc.out
