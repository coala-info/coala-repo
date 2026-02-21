cwlVersion: v1.2
class: CommandLineTool
baseCommand: cesar
label: cesar
doc: "Coding Exon Structure Awareness Mapper (CESAR)\n\nTool homepage: https://github.com/hillerlab/CESAR2.0"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cesar:1.01--h503566f_3
stdout: cesar.out
