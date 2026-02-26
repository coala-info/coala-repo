cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastools edit
label: fastools_edit
doc: "Replace regions in a reference sequence. The header of the edits file must have
  the following strucure: >name chrom:start_end\n\nTool homepage: https://git.lumc.nl/j.f.j.laros/fastools"
inputs:
  - id: input
    type: File
    doc: input file
    inputBinding:
      position: 1
  - id: edits
    type: File
    doc: FASTA file containing edits
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
