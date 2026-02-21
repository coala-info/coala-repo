cwlVersion: v1.2
class: CommandLineTool
baseCommand: irf
label: irf
doc: "Inverted Repeats Finder (Note: The provided text is a container execution error
  and does not contain help information)\n\nTool homepage: https://github.com/Benson-Genomics-Lab/IRF"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/irf:3.09--h7b50bb2_0
stdout: irf.out
