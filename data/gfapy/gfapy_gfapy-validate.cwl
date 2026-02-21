cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfapy-validate
label: gfapy_gfapy-validate
doc: "Validate GFA (Graphical Fragment Assembly) files.\n\nTool homepage: https://github.com/ggonnella/gfapy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfapy:1.2.3--pyhdfd78af_0
stdout: gfapy_gfapy-validate.out
