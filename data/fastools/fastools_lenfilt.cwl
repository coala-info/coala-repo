cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastools_lenfilt
label: fastools_lenfilt
doc: "Split a FASTA/FASTQ file on length.\n\nTool homepage: https://git.lumc.nl/j.f.j.laros/fastools"
inputs:
  - id: input
    type: File
    doc: input file
    inputBinding:
      position: 1
  - id: output
    type:
      type: array
      items: File
    doc: output files
    inputBinding:
      position: 2
  - id: length
    type:
      - 'null'
      - int
    doc: length threshold
    inputBinding:
      position: 103
      prefix: -l
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
stdout: fastools_lenfilt.out
