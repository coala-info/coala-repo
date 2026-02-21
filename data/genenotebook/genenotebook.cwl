cwlVersion: v1.2
class: CommandLineTool
baseCommand: genenotebook
label: genenotebook
doc: "GeneNotebook is a tool for genome browsing and annotation. (Note: The provided
  text is an error log and does not contain usage information.)\n\nTool homepage:
  https://genenotebook.github.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genenotebook:0.3.2--h4ac6f70_2
stdout: genenotebook.out
