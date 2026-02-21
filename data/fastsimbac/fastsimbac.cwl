cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastsimbac
label: fastsimbac
doc: "A program for the fast simulation of bacterial populations. (Note: The provided
  help text contains only system error messages and does not list command-line arguments.)\n
  \nTool homepage: https://bitbucket.org/nicofmay/fastsimbac/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastsimbac:1.0.1_bd3ad13d8f79--h72a8191_3
stdout: fastsimbac.out
