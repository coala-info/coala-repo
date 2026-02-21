cwlVersion: v1.2
class: CommandLineTool
baseCommand: smeg
label: smeg
doc: "The provided text is a log of a failed container build/fetch operation and does
  not contain the help documentation for the 'smeg' tool. As a result, no arguments
  or tool descriptions could be extracted.\n\nTool homepage: https://github.com/ohlab/SMEG"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smeg:1.1.5--0
stdout: smeg.out
