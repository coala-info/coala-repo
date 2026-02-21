cwlVersion: v1.2
class: CommandLineTool
baseCommand: dynalign
label: rnastructure_dynalign
doc: "The provided text contains container runtime error messages and does not include
  the help documentation for the tool. Dynalign is typically used for predicting common
  secondary structures for two sequences.\n\nTool homepage: http://rna.urmc.rochester.edu/RNAstructure.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnastructure:6.5--hde5307d_0
stdout: rnastructure_dynalign.out
