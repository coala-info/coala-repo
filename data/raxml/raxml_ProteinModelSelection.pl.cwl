cwlVersion: v1.2
class: CommandLineTool
baseCommand: raxml_ProteinModelSelection.pl
label: raxml_ProteinModelSelection.pl
doc: "A script used to select the best-fitting protein substitution model for RAxML.
  Note: The provided text contains container runtime errors and does not include the
  tool's help documentation, so no arguments could be extracted.\n\nTool homepage:
  http://sco.h-its.org/exelixis/web/software/raxml/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/raxml:8.2.13--h7b50bb2_3
stdout: raxml_ProteinModelSelection.pl.out
