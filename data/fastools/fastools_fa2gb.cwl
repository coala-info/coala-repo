cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastools fa2gb
label: fastools_fa2gb
doc: "Convert a FASTA file to a GenBank file.\n\nTool homepage: https://git.lumc.nl/j.f.j.laros/fastools"
inputs:
  - id: input
    type: File
    doc: input file
    inputBinding:
      position: 1
  - id: accno
    type: string
    doc: accession number
    inputBinding:
      position: 2
outputs:
  - id: output
    type: File
    doc: output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
