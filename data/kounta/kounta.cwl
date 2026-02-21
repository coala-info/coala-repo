cwlVersion: v1.2
class: CommandLineTool
baseCommand: kounta
label: kounta
doc: "A tool for counting (description not available in provided text)\n\nTool homepage:
  https://github.com/tseemann/kounta"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kounta:0.2.3--0
stdout: kounta.out
