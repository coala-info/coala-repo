cwlVersion: v1.2
class: CommandLineTool
baseCommand: plassembler_citation
label: plassembler_citation
doc: "Please cite plassembler in your paper using:\n\nTool homepage: https://github.com/gbouras13/plassembler"
inputs:
  - id: citation
    type: string
    doc: 'Bouras, G., Sheppard A.E., Mallawaarachchi, V., Vreugde S. (2023) Plassembler:
      an automated bacterial plasmid assembly tool, Bioinformatics, Volume 39, Issue
      7, July 2023, btad409, https://doi.org/10.1093/bioinformatics/btad409'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plassembler:1.8.2--pyhdfd78af_0
stdout: plassembler_citation.out
