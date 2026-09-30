cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastools
  - gb2fa
label: fastools_gb2fa
doc: "Convert a GenBank file to a FASTA file.\n\nTool homepage: https://git.lumc.nl/j.f.j.laros/fastools"
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
outputs:
  - id: out_output
    type: File
    doc: output file
    outputBinding:
      glob: '$(inputs.output)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
