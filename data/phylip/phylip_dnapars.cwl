cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnapars
label: phylip_dnapars
doc: "DNA Parsimony program from the PHYLIP package. Note: The provided help text
  contains only container runtime errors and no tool-specific usage information.\n
  \nTool homepage: http://evolution.genetics.washington.edu/phylip/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylip:3.697--h470a237_0
stdout: phylip_dnapars.out
