cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnaml
label: phylip_dnaml
doc: "DNA Maximum Likelihood program from the PHYLIP package. Note: The provided help
  text contains only system logs and error messages regarding a container build failure
  and does not list specific command-line arguments.\n\nTool homepage: http://evolution.genetics.washington.edu/phylip/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylip:3.697--h470a237_0
stdout: phylip_dnaml.out
