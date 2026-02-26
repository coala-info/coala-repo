cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastools gen
label: fastools_gen
doc: "Generate a DNA sequence in FASTA format.\n\nTool homepage: https://git.lumc.nl/j.f.j.laros/fastools"
inputs:
  - id: accno
    type: string
    doc: accession number
    inputBinding:
      position: 1
  - id: descr
    type: string
    doc: description of the DNA sequence
    inputBinding:
      position: 2
  - id: length
    type: int
    doc: length of the DNA sequence
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
