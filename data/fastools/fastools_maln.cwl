cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastools
  - maln
label: fastools_maln
doc: "Calculate the Hamming distance between all sequences in a FASTA file.\n\nTool
  homepage: https://git.lumc.nl/j.f.j.laros/fastools"
inputs:
  - id: input
    type: File
    doc: input file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
stdout: fastools_maln.out
