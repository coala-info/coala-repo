cwlVersion: v1.2
class: CommandLineTool
baseCommand: shorah
label: shorah
doc: "Short Read Assembly and Haplotype reconstruction\n\nTool homepage: https://github.com/cbg-ethz/shorah"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shorah:1.99.2--py38h73782ee_8
stdout: shorah.out
