cwlVersion: v1.2
class: CommandLineTool
baseCommand: pylca
label: pylca
doc: "A tool for Lowest Common Ancestor (LCA) analysis, typically used in taxonomic
  classification.\n\nTool homepage: https://github.com/pirovc/pylca"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pylca:1.0.0--py_0
stdout: pylca.out
