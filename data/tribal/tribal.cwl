cwlVersion: v1.2
class: CommandLineTool
baseCommand: tribal
label: tribal
doc: "A tool for Tree-Inferred Binary Alignment (TRIBAL)\n\nTool homepage: https://github.com/elkebir-group/TRIBAL"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tribal:0.1.1--py310hdbdd923_1
stdout: tribal.out
