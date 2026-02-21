cwlVersion: v1.2
class: CommandLineTool
baseCommand: protdist
label: phylip_protdist
doc: "Protein Distance Matrix program from the PHYLIP package. Note: The provided
  help text contains only system error logs and no command-line argument definitions.\n
  \nTool homepage: http://evolution.genetics.washington.edu/phylip/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylip:3.697--h470a237_0
stdout: phylip_protdist.out
