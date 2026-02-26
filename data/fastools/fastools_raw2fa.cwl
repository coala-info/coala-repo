cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastools_raw2fa
label: fastools_raw2fa
doc: "Make a FASTA file from a raw sequence.\n\nTool homepage: https://git.lumc.nl/j.f.j.laros/fastools"
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
  - id: descr
    type: string
    doc: description of the DNA sequence
    inputBinding:
      position: 3
outputs:
  - id: output
    type: File
    doc: output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
