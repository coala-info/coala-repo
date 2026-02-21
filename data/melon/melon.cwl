cwlVersion: v1.2
class: CommandLineTool
baseCommand: melon
label: melon
doc: "Metagenomic long-read analysis tool (Note: The provided text contains container
  runtime error logs rather than tool help documentation).\n\nTool homepage: https://github.com/xinehc/melon"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/melon:0.3.0--pyhdfd78af_0
stdout: melon.out
