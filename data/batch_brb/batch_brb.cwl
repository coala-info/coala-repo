cwlVersion: v1.2
class: CommandLineTool
baseCommand: batch_brb
label: batch_brb
doc: "A tool for processing biological data (description not available in provided
  logs)\n\nTool homepage: https://github.com/erin-r-butterfield/batch_brb"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/batch_brb:1.1.1--hdfd78af_0
stdout: batch_brb.out
