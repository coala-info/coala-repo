cwlVersion: v1.2
class: CommandLineTool
baseCommand: protpars
label: phylip_protpars
doc: "Protein Parsimony Algorithm from the PHYLIP package. Note: The provided help
  text contains only container environment errors and does not list specific command-line
  arguments.\n\nTool homepage: http://evolution.genetics.washington.edu/phylip/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylip:3.697--h470a237_0
stdout: phylip_protpars.out
