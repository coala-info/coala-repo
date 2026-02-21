cwlVersion: v1.2
class: CommandLineTool
baseCommand: Fold
label: rnastructure_Fold
doc: "Predict the secondary structure of an RNA or DNA sequence using the RNAstructure
  Fold algorithm. Note: The provided input text appears to be a container execution
  error log rather than help text, so no arguments could be extracted.\n\nTool homepage:
  http://rna.urmc.rochester.edu/RNAstructure.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnastructure:6.5--hde5307d_0
stdout: rnastructure_Fold.out
