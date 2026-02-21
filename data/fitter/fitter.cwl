cwlVersion: v1.2
class: CommandLineTool
baseCommand: fitter
label: fitter
doc: "A tool to fit data to distributions and identify the best-fitting one.\n\nTool
  homepage: https://github.com/cokelaer/fitter"
inputs:
  - id: command
    type: string
    doc: The command to execute
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the specified command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fitter:1.4.1--pyh5e36f6f_0
stdout: fitter.out
