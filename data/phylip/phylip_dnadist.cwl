cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnadist
label: phylip_dnadist
doc: "DNA Distance Matrix program from the PHYLIP package. (Note: The provided text
  contains system logs and error messages rather than tool help text; therefore, no
  arguments could be extracted.)\n\nTool homepage: http://evolution.genetics.washington.edu/phylip/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylip:3.697--h470a237_0
stdout: phylip_dnadist.out
