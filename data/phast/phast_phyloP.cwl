cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyloP
label: phast_phyloP
doc: "Phylogenetic conservation analysis (Note: The provided text contains container
  runtime error messages and does not include the tool's help documentation or argument
  definitions).\n\nTool homepage: http://compgen.cshl.edu/phast/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phast:1.9.6--h93e12ee_0
stdout: phast_phyloP.out
