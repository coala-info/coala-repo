cwlVersion: v1.2
class: CommandLineTool
baseCommand: feelnc_FEELnc_classifier.pl
label: feelnc_FEELnc_classifier.pl
doc: "FEELnc_classifier is a module of the FEELnc pipeline used to classify long non-coding
  RNAs (lncRNAs) based on their genomic proximity to protein-coding genes. (Note:
  The provided input text contains system error messages and does not list specific
  command-line arguments).\n\nTool homepage: https://github.com/tderrien/FEELnc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/feelnc:0.2--pl526_0
stdout: feelnc_FEELnc_classifier.pl.out
