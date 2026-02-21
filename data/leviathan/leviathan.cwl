cwlVersion: v1.2
class: CommandLineTool
baseCommand: leviathan
label: leviathan
doc: "A tool for searching for k-mers in large datasets (Note: The provided text contains
  error logs rather than help documentation, so specific arguments could not be extracted).\n
  \nTool homepage: https://github.com/morispi/LEVIATHAN"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/leviathan:1.0.2--h9f5acd7_0
stdout: leviathan.out
