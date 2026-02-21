cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaphlan2
label: metaphlan2
doc: "Metagenomic Phylogenetic Analysis (Note: The provided input text contains system
  error messages and does not include help documentation or argument definitions).\n
  \nTool homepage: https://bitbucket.org/biobakery/metaphlan2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaphlan2:2.96.1--py_0
stdout: metaphlan2.out
