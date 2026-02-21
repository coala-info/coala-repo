cwlVersion: v1.2
class: CommandLineTool
baseCommand: snikt
label: snikt
doc: "A tool for processing biological data (description not available in provided
  text)\n\nTool homepage: https://github.com/piyuranjan/SNIKT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snikt:0.5.0--r44hdfd78af_3
stdout: snikt.out
