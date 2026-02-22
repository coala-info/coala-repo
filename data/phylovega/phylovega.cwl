cwlVersion: v1.2
class: CommandLineTool
baseCommand: phylovega
label: phylovega
doc: "No description available (The provided text contains system error messages rather
  than tool help text).\n\nTool homepage: https://github.com/Zsailer/phylovega"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylovega:0.3--py_0
stdout: phylovega.out
