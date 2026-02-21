cwlVersion: v1.2
class: CommandLineTool
baseCommand: protml
label: phylip_protml
doc: "Maximum Likelihood Method for Protein Sequences (PHYLIP). Note: The provided
  help text contains container runtime errors and does not list command-line arguments.\n
  \nTool homepage: http://evolution.genetics.washington.edu/phylip/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylip:3.697--h470a237_0
stdout: phylip_protml.out
