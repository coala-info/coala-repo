cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastools collapse
label: fastools_collapse
doc: "Remove all mononucleotide stretches from a FASTA file.\n\nTool homepage: https://git.lumc.nl/j.f.j.laros/fastools"
inputs:
  - id: input
    type: File
    doc: input file
    inputBinding:
      position: 1
  - id: max_stretch
    type:
      - 'null'
      - int
    doc: Length of the stretch
    inputBinding:
      position: 102
      prefix: --stretch
outputs:
  - id: output
    type: File
    doc: output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
