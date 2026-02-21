cwlVersion: v1.2
class: CommandLineTool
baseCommand: amused
label: amused
doc: "The provided text does not contain help information or usage instructions for
  'amused'. It appears to be a system log showing a failed execution attempt where
  the executable was not found.\n\nTool homepage: https://github.com/Carldeboer/AMUSED"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amused:1.0--1
stdout: amused.out
