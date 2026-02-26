cwlVersion: v1.2
class: CommandLineTool
baseCommand: bmge
label: bmge
doc: "BMGE (Block Mapping with Gapped Exoneration) is a tool for finding conserved
  blocks in multiple sequence alignments.\n\nTool homepage: https://bioweb.pasteur.fr/packages/pack@BMGE@1.12"
inputs:
  - id: infile
    type: File
    doc: Input file
    inputBinding:
      position: 101
      prefix: -i
  - id: type
    type: string
    doc: Type of analysis
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bmge:1.12--0
stdout: bmge.out
