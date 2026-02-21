cwlVersion: v1.2
class: CommandLineTool
baseCommand: geneocr-ui
label: geneocr-ui
doc: "The provided text is an error log from a container runtime and does not contain
  help documentation or usage instructions for the tool.\n\nTool homepage: https://github.com/bedapub/geneocr-ui"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/geneocr-ui:1.0_cv1
stdout: geneocr-ui.out
