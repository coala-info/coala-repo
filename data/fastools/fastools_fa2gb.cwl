cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastools
  - fa2gb
label: fastools_fa2gb
doc: "Convert a FASTA file to a GenBank file.\n\nTool homepage: https://git.lumc.nl/j.f.j.laros/fastools"
inputs:
  - id: input
    type: File
    doc: input file
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: output file
    inputBinding:
      position: 2
  - id: accno
    type: string
    doc: accession number
    inputBinding:
      position: 3
outputs:
  - id: out_output
    type: File
    doc: output file
    outputBinding:
      glob: '$(inputs.output)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
