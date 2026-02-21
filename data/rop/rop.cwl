cwlVersion: v1.2
class: CommandLineTool
baseCommand: rop
label: rop
doc: "The Repeat Oriented Pipeline (ROP) is a tool designed to identify the origin
  of unmapped reads in genomic sequences.\n\nTool homepage: https://github.com/smangul1/rop"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rop:1.1.2--py27h516909a_0
stdout: rop.out
