cwlVersion: v1.2
class: CommandLineTool
baseCommand: graphprot_GraphProt.pl
label: graphprot_GraphProt.pl
doc: "GraphProt is a tool for modeling binding preferences of RNA-binding proteins.
  (Note: The provided text contains system error messages regarding container execution
  and does not list specific command-line arguments.)\n\nTool homepage: https://github.com/dmaticzka/graphprot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphprot:1.1.7--py36_0
stdout: graphprot_GraphProt.pl.out
