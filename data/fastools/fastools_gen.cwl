cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastools
  - gen
label: fastools_gen
doc: "Generate a DNA sequence in FASTA format.\n\nTool homepage: https://git.lumc.nl/j.f.j.laros/fastools"
inputs:
  - id: output
    type: string
    doc: output file
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
  - id: length
    type: int
    doc: length of the DNA sequence
    inputBinding:
      position: 4
outputs:
  - id: out_output
    type: File
    doc: output file
    outputBinding:
      glob: '$(inputs.output)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
