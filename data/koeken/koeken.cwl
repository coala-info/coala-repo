cwlVersion: v1.2
class: CommandLineTool
baseCommand: koeken
label: koeken
doc: "A tool for MetaPhlAn and LEfSe analysis (Note: The provided text contains container
  runtime error logs rather than tool help documentation).\n\nTool homepage: https://github.com/twbattaglia/koeken"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/koeken:0.2.6--py27_0
stdout: koeken.out
