cwlVersion: v1.2
class: CommandLineTool
baseCommand: norns
label: norns
doc: "A tool for normalizing and filtering RNA-seq data. (Note: The provided input
  text contains container runtime error messages rather than the tool's help documentation,
  so no arguments could be extracted.)\n\nTool homepage: https://github.com/simonvh/norns"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/norns:0.1.6--pyh5e36f6f_0
stdout: norns.out
