cwlVersion: v1.2
class: CommandLineTool
baseCommand: REPmask
label: damasker_REPmask
doc: "The provided text is an error log from a container build process and does not
  contain help information or usage instructions for the tool. As a result, no arguments
  could be extracted.\n\nTool homepage: https://github.com/thegenemyers/DAMASKER"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/damasker:1.0p1--h7b50bb2_8
stdout: damasker_REPmask.out
