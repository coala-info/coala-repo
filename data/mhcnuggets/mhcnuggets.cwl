cwlVersion: v1.2
class: CommandLineTool
baseCommand: mhcnuggets
label: mhcnuggets
doc: "MHCnuggets: A deep learning tool for peptide-MHC binding prediction.\n\nTool
  homepage: http://karchinlab.org/apps/mhcnuggets.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mhcnuggets:2.4.1--pyh7cba7a3_0
stdout: mhcnuggets.out
