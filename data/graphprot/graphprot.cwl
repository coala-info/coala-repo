cwlVersion: v1.2
class: CommandLineTool
baseCommand: graphprot
label: graphprot
doc: "GraphProt is a tool for modeling binding preferences of RNA-binding proteins.
  (Note: The provided input text appears to be a container runtime error log rather
  than help text, so no arguments could be extracted).\n\nTool homepage: https://github.com/dmaticzka/graphprot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphprot:1.1.7--py36_0
stdout: graphprot.out
