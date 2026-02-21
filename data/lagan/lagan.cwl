cwlVersion: v1.2
class: CommandLineTool
baseCommand: lagan
label: lagan
doc: "LAGAN (Limited Area Global Alignment of Nucleotides) is a system for the global
  alignment of two or more long genomic sequences.\n\nTool homepage: https://github.com/lutsen/lagan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/lagan:v2.0-3-deb_cv1
stdout: lagan.out
