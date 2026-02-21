cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfapy-convert
label: gfapy_gfapy-convert
doc: "A tool for converting GFA (Graphical Fragment Assembly) files using the gfapy
  library.\n\nTool homepage: https://github.com/ggonnella/gfapy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfapy:1.2.3--pyhdfd78af_0
stdout: gfapy_gfapy-convert.out
