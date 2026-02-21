cwlVersion: v1.2
class: CommandLineTool
baseCommand: pmmrcalculator
label: pmmrcalculator
doc: "The provided text is a container execution error log and does not contain help
  documentation or usage instructions for the tool.\n\nTool homepage: https://github.com/TCLamnidis/pMMRCalculator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pmmrcalculator:1.1.0--hdfd78af_0
stdout: pmmrcalculator.out
