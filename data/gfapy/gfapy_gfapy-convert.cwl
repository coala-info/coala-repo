cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfapy-convert
label: gfapy_gfapy-convert
doc: "Convert a GFA file to the other specification version\n\nTool homepage: https://github.com/ggonnella/gfapy"
inputs:
  - id: filename
    type: File
    doc: Input GFA file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfapy:1.2.3--pyhdfd78af_0
stdout: gfapy_gfapy-convert.out
