cwlVersion: v1.2
class: CommandLineTool
baseCommand: mitorsaw
label: mitorsaw
doc: "The provided text contains system error logs and does not include the tool's
  help documentation or usage instructions.\n\nTool homepage: https://github.com/PacificBiosciences/mitorsaw"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mitorsaw:0.2.7--h9ee0642_0
stdout: mitorsaw.out
