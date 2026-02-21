cwlVersion: v1.2
class: CommandLineTool
baseCommand: strike
label: strike
doc: "The provided text does not contain help information or a description of the
  tool. It contains error logs related to a container build failure for the 'strike'
  tool.\n\nTool homepage: http://www.tcoffee.org/Projects/strike/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strike:1.2--h9948957_6
stdout: strike.out
